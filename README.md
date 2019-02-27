# Project 01 README.md

Created By: Dragos Baciu-David

Github: github.com/baciudad/CS1XA3

### 

###### *To use the project run the project_analyze.sh file in bash and work through the menus to use the various functions.*



### Feature 1: Script Input Menu

- This program was designed with expansion in mind. The menu system was created to allow the user to filter through the options as many times as they wish until they choose to exit.
- This program was also designed to not error when the user enters an option that is not currently populated.
- The menu system was chosen so it would be easy to incorporate and programs that would request inline arguments to produce their output

### Feature 2: TODO Log Program

- Looks to see if todo.log file exists, if it does the program will delete it before creating a new file
- The program then uses grep to find all the lines from ever file in the repo that contain #TODO and place them along with the file name and line number into the TODO.log file
- Lastly it directs the user to the  todo.log file for the results

### Feature 3: Clean Directory Program

- This program will take in a directory path relative to the project directory
- The program then finds all .tmp files and deletes them prompting
- The program will continue to loop until a valid directory is provided to the program at which point it will complete the operation

### Feature 4: Unit Convertion

- This program will convert between simple units on measurements to approximate accuracy
- Built into the program is a menu system that allows you to select various options
- Each option will prompt for input and provide appropriate output
- The program runs in a loop that checks for correct input and prompts if the input is incorrect
- The program will continue until the user request an exit from the program
