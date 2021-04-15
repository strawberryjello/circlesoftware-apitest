# Circle Software API test

Sample API that returns the monthly ex tax sales and gross profit grouped by year. See the companion sample frontend [here](insert link here). Sample csv data is in the `data` directory.

## System Requirements

This was developed using the ff. on Linux (openSUSE Leap 15.1):
- Ruby 2.7.2
- Rails 6
- PostgreSQL 12

It hasn't been tested using other versions, though as far as I'm aware I haven't used any version-dependent features.

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

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
