##### Prerequisites

The setups steps expect following tools installed on the system.

- Git
- Ruby [2.6.3]
- Rails [6.0.2]

##### 1. Check out the repository

```bash
git clone https://github.com/mamoon123/cardboard-api.git
```

##### 2. Edit database.yml file

Edit the database configuration as required to add database configuration

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```
##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```
And now you can visit the site with the URL http://localhost:3000
