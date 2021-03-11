<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Multiplayer Trivia](#multiplayer-trivia)
  - [The Game](#the-game)
  - [Important details](#important-details)
  - [Services and responsibilities](#services-and-responsibilities)
    - [Current](#current)
    - [Future](#future)
  - [The Architecture](#the-architecture)
    - [High level](#high-level)
    - [Current Infrastructure (in AWS)](#current-infrastructure-in-aws)
    - [Future Infrastructure ideas (in AWS)](#future-infrastructure-ideas-in-aws)
  - [Setup instructions](#setup-instructions)
  - [Steps/TODO](#stepstodo)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Multiplayer Trivia

## The Game

The game consists of multiple rounds. In each round players are presented a question, a choice of answers, and have to select one answer within the allotted time (10 seconds or so). Players that chose a correct answer advance to the next round. Those who chose the wrong answers are eliminated. The game continues until there’s only one winner left.

## Important details

1. The game runs without any admin intervention
1. Multiple trivia games can run simultaneously.
1. A reasonably large number of players can participate in each game.
1. Each round displays if the choice was correct and how many players advance.

## Services and responsibilities

### Current
2 services - Q&A service and Game service

Game service is responsible for running games, which means
1. creating a game
1. showing a list of games that users can join while not showing already started games
1. allowing users to connect to a not started game
1. starting a game
1. creating new rounds if multiple winners exist or first round
1. displaying a question (by getting it from Q&A service)
1. deciding winners of round and creating new round if more than 1 winner
1. completing game and displaying winner
1. ending the game

Q&A service is responsible for providing questions and answers, with one correct answer
1. scrape/obtain q&a from the web
1. potentially get new q&a on request/scheduled basis
1. provide q&a on request
1. pontentially invalidate/delete poor quality q&a

### Future

- User service is responsible for signing up and authenticating users
- Game History Service stores statistics of completed games such as number of players, duration of game, number of rounds, who won so that we can analyse how well the game is doing
- Leaderboard Service for storing top performing users by period of time, region, category etc.

## The Architecture

### High level
Game Service is a Rails app with DynamoDB for storing game state and RabbitMQ for messaging winners and ending game per user -> requests -> Q&A service - another Rails app with Aurora Postgres for storing questions and answers

### Current Infrastructure (in AWS)

Game service - ECS Fargate manually scaled service with ALB in a public subnet, DynamoDB stores game state, and RabbitMQ on AmazonMQ is used for messaging

Q&A service - ECS Fargate manually scaled service in a private subnet, Aurora Postgres stores questions and answers, ECS scheduled task to run Ruby rake task at regular interval to ingest questions and answers into DynamoDB

Game service requests Q&A service via HTTP endpoint and relies on configuration or service discovery

The infrastructure is setup, deployed and maintained via AWS Copilot

### Future Infrastructure ideas (in AWS)

- Autoscale ECS Fargate service using Cloudwatch metrics
- SNS + SQS for communication between Game and Q&A Service for scaling to very high throughputs

## Setup instructions on Mac OSX
- Install AWS Copilot
```zsh
> brew install aws/tap/copilot-cli 
```

- Create node_modules and rails gems local cache to make docker-compose for local dev faster
```zsh
> cd /Users/USER/Documents/docker
> mkdir -p common/nodejs-14.16.0-r0/node_modules
> mkdir -p common/ruby-3.0.0/bundle
> docker volume create --driver local --opt type=none --opt o=bind --opt device=/Users/USER/Documents/docker/common/nodejs-14.16.0-r0/node_modules nodejs-14.16.0-r0-node_modules
> docker volume create --driver local --opt type=none --opt o=bind --opt device=/Users/USER/Documents/docker/common/ruby-3.0.0/bundle ruby-3.0.0-bundle
```

- Startup the qa-service
```zsh
> cd qa-service
> docker-compose up -d
> docker-compose exec app bundle exec rails db:reset
> docker-compose exec app bundle exec rails db:setup
> docker-compose exec app bundle exec rails db:migrate
```
http://localhost:3000 will be working now!


>> *Note: The qa-service was created using*
```zsh
> docker-compose run --no-deps app bundle exec rails new . --api --force --database=postgresql
``` 
>> ref: https://www.blocknot.es/2021-02-06-docker-rails-6-dev-environment/, https://docs.docker.com/compose/rails/, https://medium.com/@guillaumeocculy/setting-up-rails-6-with-postgresql-webpack-on-docker-a51c1044f0e4

## Steps/TODO

- [ ] Get a list of multiple choice questions and answers, with the correct answer (q&a)
- [ ] Store a list of q&a in a database
- [ ] Create a service with http endpoint that outputs q&a
- [ ] 