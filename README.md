![PuppyPro Logo](https://user-images.githubusercontent.com/63659148/193999839-c977f663-ebc7-4b91-adaa-a7906968c11d.jpg)

Puppy Pro is a CRUD capable and MVC structured app using Sinatra framework. Essentially, it's a simple Content Management System (CMS). It was created with the intent to give the user a way to track their puppy's training progress. The initial goals of the app were to allow the user to:

✏️ Sign up for an account
🐶 Add/remove multiple puppies
🔧Create/delete puppy skills (sit, down, speak, etc)
❓ Manage what skills their puppy knows
⬆️ Manage the proficiency level of said skills
🌟 View a list of mastered skills
📈 View a visual timeline of mastered skills

<b>Curious about this project?</b>  

:books: Read about the process on my [blog](https://codebaby.hashnode.dev/my-first-sinatra-project-puppy-pro)  

## Install :sparkles:

### Prerequesites
Before you begin, ensure you have met the following requirements:

* You have installed `ruby 2.6.1` or higher.
* You have a Linux or WSL environment.
* You have Sinatra installed.

### Clone the repository

```shell
git clone git@github.com:Lunarang/PuppyPro.git
cd puppypro
```

### Install api dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

### Initialize the database

```shell
rake db:create db:migrate db:seed
```

## Serve :sparkles:


## Architecture and Models :sparkles:

PuppyPro follows basic MVC architecture and RESTful controller conventions.
Models and associations are as follows:

* <b>User</b> `has_many` dogs and skills
* <b>Dog</b> `belongs_to` user, `has_many` skills through join table
* <b>Skill</b> `has_many` dogs through join table

## Contributions :sparkles:

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/lunarang/PuppyPro/CODE_OF_CONDUCT.md).
To contribute to PuppyPro, follow these steps:

1. Fork this repository.
2. Create a branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin <project_name>/<location>`
5. Create the pull request.

Alternatively see the GitHub documentation on [creating a pull request](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## License :sparkles:

The repository is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct :sparkles:

Everyone interacting in this project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lunarang/PuppyPro/CODE_OF_CONDUCT.md).
