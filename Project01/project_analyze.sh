#!/bin/bash

while [ true ]
do      #Display menu
        echo "Select one of the options"
        echo "a. TODO Log"
        echo "b. Error Log"
        echo "c. BLANK"
        echo "x. Exit"
        #getting an option from the user
        echo -n "Option: "
        read option
        #apply selected option to the action for each program
        case $option in
        a|A) echo "TODO Log Working"
             ./TODO.sh
             ;;
        b|B) echo ""
             echo "Error Log Working "
             ./error.sh
             ;;
        c|C) echo ""
             echo "BLANK FOR FUTURE EXPAINSION "
             echo -n "Enter a Directory: "
             read directory
             ./question3.bsh $directory
             ;;
        #exiting the program
        x|X) echo "Goodbye"
             exit 0
             ;;
        #getting correct input from user for the option variable
        *) echo "Invalid option ... Try Again"
           ;;
        esac

done
#END OF PROGRAM
