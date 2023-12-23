import random
import time
import tkinter as tk

def create_board(width, height, symbols):
    num_pairs = (width * height) // 2
    symbol_list = symbols * num_pairs
    random.shuffle(symbol_list)
    board = []
    for _ in range(height):
        row = []
        for _ in range(width):
            symbol = symbol_list.pop()
            row.append((symbol, False))
        board.append(row)
    return board

def print_board(board):
    root = tk.Tk()
    root.title("Memory Game")

    for i, row in enumerate(board):
        for j, (symbol, flipped) in enumerate(row):
            if flipped:
                label = tk.Label(root, text=symbol, width=5, height=2)
            else:
                label = tk.Label(root, text="*", width=5, height=2)
            label.grid(row=i, column=j)

    root.mainloop()

def get_input(board):
    while True:
        try:
            x = int(input("Enter the x-coordinate (0 to width-1): "))
            y = int(input("Enter the y-coordinate (0 to height-1): "))
            if not (0 <= x < len(board[0])) or not (0 <= y < len(board)):
                raise ValueError
            return x, y
        except ValueError:
            print("Invalid input. Please try again.")

def update_board(board, x1, y1, x2, y2):
    if board[y1][x1][0] == board[y2][x2][0]:
        board[y1][x1] = (board[y1][x1][0], True)
        board[y2][x2] = (board[y2][x2][0], True)
        return True
    return False

def check_game_over(board):
    for row in board:
        for _, flipped in row:
            if not flipped:
                return False
    return True

def play_memory_game():
    print("Welcome to the Memory Game!")

    # Get game configuration from the user
    width = int(input("Enter the width of the board: "))
    height = int(input("Enter the height of the board: "))
    symbols = input("Enter the symbols to use (separated by a space): ").split()

    # Create the board
    board = create_board(width, height, symbols)

    # Print the initial board
    print_board(board)

    # Play the game
    while True:
        print("\nChoose the first card:")
        x1, y1 = get_input(board)
        board[y1][x1] = (board[y1][x1][0], True)

        print("\nChoose the second card:")
        x2, y2 = get_input(board)
        board[y2][x2] = (board[y2][x2][0], True)

        print_board(board)

        if update_board(board, x1, y1, x2, y2):
            print("Match!")
        else:
            print("No match.")

        if check_game_over(board):
            print("\nCongratulations! You've matched all the cards!")
            break

        time.sleep(2)  # Wait for 2 seconds before flipping the cards back

        board[y1][x1] = (board[y1][x1][0], False)
        board[y2][x2] = (board[y2][x2][0], False)

        print_board(board)

    print("\nThanks for playing!")

# Start the game
play_memory_game()