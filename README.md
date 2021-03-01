<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Multiplayer Trivia](#multiplayer-trivia)
  - [The Game](#the-game)
  - [The Architecture](#the-architecture)
    - [Important details](#important-details)
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