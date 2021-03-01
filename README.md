<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Multiplayer Trivia](#multiplayer-trivia)
  - [The Game](#the-game)
  - [Important details](#important-details)
  - [Services and responsibilities](#services-and-responsibilities)
    - [Today](#today)
    - [Future](#future)
  - [Steps/TODO](#stepstodo)
  - [The Architecture](#the-architecture)

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

### Today
2 services - Q&A service and Game service

Game service is responsible for running games, which means
1. creating a game
1. allowing users to connect to the game
1. creating a round
1. displaying a question (by getting it from Q&A service)
1. deciding winners of round and creating new round if more than 2 winners
1. completing game and displaying winner

Q&A service is responsible for providing questions and answers, with one correct answer
1. scrape/obtain q&a from the web
1. potentially get new q&a on request/scheduled basis
1. provide q&a on request
1. pontentially invalidate/delete poor quality q&a

### Future

- User service is responsible for signing up and authenticating users
- Game History Service stores statistics of completed games such as number of players, duration of game, number of rounds, who won so that we can analyse how well the game is doing
- Leaderboard Service for storing top performing users by period of time, region, category etc.

## Steps/TODO

- [ ] Get a list of multiple choice questions and answers, with the correct answer (q&a)
- [ ] Store a list of q&a in a database
- [ ] Create a service with http endpoint that outputs q&a
- [ ] 

## The Architecture