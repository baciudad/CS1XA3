# Project 01 README.md

Created By: Dragos Baciu-David

Github: github.com/baciudad/CS1XA3



### Feature 1: Script Input Menu

- This program was designed with expansion in mind. The menu system was created to allow the user to filter through the options as many times as they wish until they choose to exit.
- This program was also designed to not error when the user enters an option that is not currently populated.
- The menu system was chosen so it would be easy to incorporate and programs that would request inline arguments to produce their output

### Feature 2: TODO Log Program

- Looks to see if todo.log file exists, if it does the program will delete it before creating a new file
- The program then uses grep to find all the lines from ever file in the repo that contain #TODO and place them along with the file name and line number into the TODO.log file
- Lastly it directs the user to the  todo.log file for the results