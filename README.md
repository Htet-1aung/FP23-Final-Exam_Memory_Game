# FP23-Final-Exam_Game_Memory

The Game Memory is a Haskell implementation of the classic memory game.This Implementation is provided by HTET AUNG and HSU MYAT WAI MAUNG

## What is Game Memory?

Game Memory, also known as "Concentration", is a popular card matching game. The objective is to find all pairs of matching cards by flipping them over two at a time. The game tests your memory and concentration skills.

## How does it work and what are its rules?

1. At the beginning of the game, all cards are face-down.
2. On each turn, the player selects two cards to flip over.
3. If the two flipped cards match, they remain face-up, and the player earns a point.
4. If the two flipped cards do not match, they are flipped back face-down.
5. The player continues flipping pairs of cards until all matches are found.
6. The game ends when all pairs are found, and the player's score is displayed.

# Issues during implementation Memory Game in Haskell

During the implementation of the Memory Game in Haskell, the following issues were encountered:

1. **Card representation**: Designing a suitable data structure to represent the cards and their states (face-up or face-down).
2. **Game logic**: Implementing the game rules, such as flipping cards, checking for matches, and keeping track of the score.
3. **User interface**: Creating an interactive user interface to display the game board and handle user input.
4. **Random card generation**: Generating a random arrangement of cards on each game start to ensure a different gameplay experience.

# Contributions

Contributions to the project are welcome! If you would like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Implement your changes and test them thoroughly.
4. Commit your changes and push them to your forked repository.
5. Submit a pull request, describing your changes in detail.

# Installation and Prerequisite

To run the Game Memory Haskell implementation, you need to have the following prerequisites installed:

- Haskell compiler (GHC)
- Cabal build tool / Stack (if you are using Stack Build)

Follow these steps to install and run the game:

If you want to manually clone the git and run:

1. Clone the repository:

```
git clone https://github.com/Htet-1aung/FP23-Final-Exam_Memory_Game.git
```

2. Change into the project directory:

```
cd FP23-Final-Exam_Memory_Game
```

3. Build the project:

```
cabal build
```

4. Run the game:

```
cabal run
```

## Alternative Ways to install

Otherwise you can download Main.exe file from the github repository and run it from terminal.


1. Open Terminal and Navigate to the directory where the executable file is located using the cd command. For example, if the executable file is in the /home/user/myapp directory, you can use the following command:

```
cd /home/user/Main.exe
```


2. Make sure the executable file has the necessary permissions to be executed. You can use the ls command to list the files in the directory and check the file permissions.


3.Once the executable file has the execute permission, you can run it by typing its name in the terminal. For example, if the executable file is named myapp.exe, you can run it with the following command:

```
./Main.exe
```


## You can run the haskell source code from scratch to play the game.




Enjoy playing the Game Memory!
