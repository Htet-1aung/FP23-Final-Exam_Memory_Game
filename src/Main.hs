import System.Random
import Control.Monad
import Control.Monad.State
import Data.List
import Text.Printf
import Data.Array.IO (IOArray, readArray, writeArray, newListArray)
import System.IO


type Card = (Char, Bool)
type Board = [[Card]]

handleChoice :: Int -> IO ()
handleChoice choice = do
  case choice of
    1 -> do
      putStrLn "Starting a new game..."
      finalScore <- playMemoryGame
      putStrLn $ "Final score: " ++ show finalScore
    2 -> do
      putStrLn $ "The highest score so far is: " ++ show highScore
      gameMenu highScore
    3 -> putStrLn "Certainly! Here's a guide to playing the memory game:\n\n1. The memory game is played on a grid of cards.\n2. Each card has a symbol on it, and the goal is to match pairs of cards with the same symbol.\n3. At the beginning of the game, all cards are face down (flipped).\n4. On each turn:\n   - You will be prompted to enter the coordinates of two cards you want to flip.\n   - Enter the x-coordinate and y-coordinate of the first card you want to flip.\n   - Enter the x-coordinate and y-coordinate of the second card you want to flip.\n5. After you flip the cards, their symbols will be revealed.\n6. If the symbols of the two flipped cards match, they remain face up.\n7. If the symbols do not match, the cards are flipped face down again.\n8. Keep flipping cards and trying to match pairs until all cards are face up.\n9. The game ends when all cards are face up.\n10. Your score is determined by the number of turns it took to complete the game. The lower the score, the better.\n11. You can choose to start a new game, view the scores, read the guide (not implemented yet), or quit the game from the game menu.\n\nEnjoy playing the memory game!" >> gameMenu highScore
    4 -> putStrLn "Thank you for playing!"
    _ -> putStrLn "Invalid choice. Please try again." >> gameMenu highScore
  where highScore = 0

gameMenu :: Int -> IO ()
gameMenu highScore = do
  putStrLn "<Memory Game - Presented By HtetAung&HsuMyatWaiMaung>"
  putStrLn "1. Start new game"
  putStrLn "2. Scores"
  putStrLn "3. Guide"
  putStrLn "4. Quit"
  putStrLn "Please pick your choice: "
  choice <- readLn
  handleChoice choice

createBoard :: Int -> Int -> [Char] -> IO Board
createBoard width height symbols = do
    let numPairs = (width * height) `div` 2
    let symbolList = concat $ replicate numPairs symbols
    shuffledSymbols <- shuffle symbolList
    let board = [ [ (symbol, False) | symbol <- take width rest ]
                | rest <- splitEvery width shuffledSymbols ]
    return board

shuffle :: [a] -> IO [a]
shuffle xs = do
    ar <- newArray n xs
    forM [1..n] $ \i -> do
        j <- randomRIO (i,n)
        vi <- readArray ar i
        vj <- readArray ar j
        writeArray ar j vi
        return vj
    where
        n = length xs
        newArray :: Int -> [a] -> IO (IOArray Int a)
        newArray n xs = newListArray (1,n) xs

splitEvery :: Int -> [a] -> [[a]]
splitEvery _ [] = []
splitEvery n xs = as : splitEvery n bs
    where (as,bs) = splitAt n xs

replace2D :: Int -> Int -> a -> [[a]] -> [[a]]
replace2D x y z = map (\(i,row) -> map (\(j,val) -> if i == y && j == x then z else val) (zip [0..] row)) . zip [0..]

printBoard :: Board -> IO ()
printBoard board = do
    forM_ board $ \row -> do
        forM_ row $ \(symbol, flipped) -> do
            putStr $ if flipped then [symbol] else "*"
            putStr " "
        putStrLn ""

getInput :: Int -> Int -> IO (Int, Int)
getInput width height = do
    putStrLn "Enter the x-coordinate (0 to width-1): "
    x <- readLn
    putStrLn "Enter the y-coordinate (0 to height-1): "
    y <- readLn
    if x < 0 || x >= width || y < 0 || y >= height
        then do
            putStrLn "Invalid input. Please try again."
            getInput width height
        else return (x, y)

updateBoard :: Board -> Int -> Int -> Int -> Int -> Board
updateBoard board x1 y1 x2 y2 =
    if (symbol1 == symbol2)
        then replace2D y1 x1 (symbol1, True) $ replace2D y2 x2 (symbol2, True) board
        else board
    where
        (symbol1, _) = board !! y1 !! x1
        (symbol2, _) = board !! y2 !! x2

checkGameOver :: Board -> Bool
checkGameOver = all (all snd)

playMemoryGame :: IO Int
playMemoryGame = do
   putStrLn "Welcome to the Memory Game!"


   putStrLn "Enter the width of the board: "
   width <- readLn
   putStrLn "Enter the height of the board: "
   height <- readLn
   putStrLn "Enter the symbols to use (separated by a space): "
   symbols <- getLine
 
   board <- createBoard width height (unwords (words symbols))


   finalScore <- gameLoop board 0


   putStrLn "\nThanks for playing!"
   return finalScore


-- Add a new parameter to gameLoop to keep track of the score
gameLoop :: Board -> Int -> IO Int
gameLoop board score = do
   putStrLn $ "\nCurrent score: " ++ show score
   putStrLn "\nCurrent board:"
   printBoard board

   if checkGameOver board
       then return score
       else do
           putStrLn "\nEnter the coordinates of the first card to flip: "
           (x1, y1) <- getInput (length (head board)) (length board)
           let board' = replace2D x1 y1 (fst (board !! y1 !! x1), True) board
           printBoard board'

           putStrLn "\nEnter the coordinates of the second card to flip: "
           (x2, y2) <- getInput (length (head board)) (length board)
           let board'' = replace2D x2 y2 (fst (board !! y2 !! x2), True) board'
           printBoard board''

           let board''' = updateBoard board'' x1 y1 x2 y2
           gameLoop board''' (score + 1)
-- Modify gameMenu to pass an initial score of 0 to gameLoop
-- Replace your main function with this
main :: IO ()
main = do
   hSetBuffering stdout NoBuffering
   gameMenu 0
