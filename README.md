# Circle Software API test

Sample API that returns the monthly ex tax sales and gross profit grouped by year. Sample csv data is in the `data` directory.

The API is currently [deployed on Heroku](https://circlesoftware-api.herokuapp.com/monthly_sales_reports); a simple UI for viewing the data can be found [here](https://circlesoftware-api.herokuapp.com/).

## System Requirements

This was developed using the ff. on Linux (openSUSE Leap 15.1):
- Ruby 2.7.2
- Rails 6
- PostgreSQL 12

It hasn't been tested using other versions, though as far as I'm aware I haven't used any version-dependent features.

## Setup

- [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/), either directly or via a version manager such as [rbenv](https://github.com/rbenv/rbenv)

- Clone this repository

- Install and set up PostgreSQL, then create the databases (see the [Database Setup](https://github.com/strawberryjello/circlesoftware-apitest#database-setup) section below)

- Run `bundle install` in the repository's root directory

- Load the csv data into the database by running `rake csv:load` and `rake report:create` in order; this will likely take several minutes, see the section [Loading csv data using Rake](https://github.com/strawberryjello/circlesoftware-apitest#loading-csv-data-using-rake)

- Run the tests using `rspec`

- You can view the data returned by the API by using the included UI or by querying the API directly, see the section [Viewing the Data Locally](https://github.com/strawberryjello/circlesoftware-apitest#viewing-the-data-locally)

## Database Setup

### PostgreSQL installation

Download the version matching your operating system [here](https://www.postgresql.org/download/); alternatively, on Linux you can install PostgreSQL via your operating system's package manager (for example, zypper on openSUSE). Note that for Linux distributions like Ubuntu and openSUSE, the version available via the package manager is generally a few versions behind the latest available.

### Starting the PostgreSQL server

On openSUSE you can start the server by running the ff.:

``` sh
sudo systemctl start postgresql
```

You can also set the server to run when your operating system boots with the ff.:

``` sh
sudo systemctl enable postgresql
```

Run the ff. to check the server's status:

``` sh
sudo systemctl status postgresql
```

Run the ff. to stop the server:

``` sh
sudo systemctl stop postgresql
```

### Creating PostgreSQL roles

Switch to the `postgres` user:

``` sh
sudo su postgres
```

Run the `psql` utility:
``` sh
psql
```

Create a new superuser (replace the placeholders in angle brackets with your preferred settings):

``` sh
create role <superuser> with password '<pw>';
alter role <superuser> with superuser;
```

It is not advised to use the superuser role for routine tasks, since it bypasses most permission checks; instead, create a new user with the `createdb`, `createrole`, and `login` attributes for routine database-related tasks:

``` sh
create role <myuser> with password '<pw>';
alter role <myuser> createdb createrole login;
```

See the [PostgreSQL documentation](https://www.postgresql.org/docs/current/role-attributes.html) for the list of role attributes.

Afterwards you can log out of `psql` by entering `\q`. (You can also type `help` to see a short list of available commands.)

### Create the databases

Use the `createdb` utility to create the development and test databases (see `config/database.yml` for the configured database names, then replace the placeholders in angle brackets):

``` sh
createdb <devdb>;
createdb <testdb>;
```

## Loading csv data using Rake

Two Rake tasks (in `lib/tasks`) are available for loading csv data into their corresponding tables. They, along with the other Rake tasks bundled into Rails, can be viewed at the terminal by running `rake -T`.

- `csv_loader.rake` - Parses all csv files in the `data` directory, computes the gross profit for each item, and saves everything to the tables corresponding to items and transactions. Invoked by running `rake csv:load`. It expects the ff. column headers (note capitalization):
  - APN code
  - R.R.P. (recommended retail price)
  - Last Buy Price
  - Item description
  - Product Category
  - Actual Stock On Hand
  - Trans Date
  - Trans Time
  - Trans Document Number
  - Trans Reference Number
  - Trans Quantity
  - Trans Total extax value
  - Trans Total tax
  - Trans Total discount given

- `report.rake` - Computes the monthly gross profit and total extax sales via a query and saves them to the table for monthly sales reports. Invoked by running `rake report:create`.

Each task uses Ruby's [Benchmark module](https://ruby-doc.org/stdlib-2.7.2/libdoc/benchmark/rdoc/Benchmark.html) to measure the amount of time elapsed in seconds, which can be used as a starting point for future performance improvements.

## Tests

Tests are written in RSpec and can be run using the `rspec` command. Make sure that the test database has been created before running the tests.

## Viewing the Data Locally

A simple UI for viewing the data returned by the API is available:

- Run the server using `rails server` / `rails s`

- Visit `localhost:3000`

The data will be displayed in tables grouped by year, in descending order.

It is also possible to manually inspect what the API returns by running the server and querying the API via the ff.:

- Visiting `localhost:3000/monthly_sales_reports` in a browser

- Using `curl` (if you have it installed) in the terminal:

  ```
  curl localhost:3000/monthly_sales_reports
  ```
  
  - The output can be redirected to a file for easier viewing by using `>` and specifying a filename (for example, `curl localhost:3000/monthly_sales_reports > output.json`). The file will be created if it doesn't exist; if it does, its contents will be overwritten.
