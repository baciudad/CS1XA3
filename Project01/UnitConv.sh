#!/bin/bash

while [ true ]
do      #Display menu
        echo "Select one of the options"
        echo "a. Approximate Meters to CM//FT"
        echo "b. Approximate Square Meter to Square Foot"
        echo "c. Approximate Cubic Meters to Cubic CM/Feet"
        echo "d. Approximate Degrees Celcius to Fahrenheit/Kevlins"
        echo "e. Approximate HardDrive Space Convertion"
        echo "x. Exit"
        #getting an option from the user
        echo -n "Option: "
        read option
        #apply selected option to the action for each program
        #All Math is Approximate due to Mathematical Limitations in Base Bash
        case $option in
        a|A) echo ""
             echo "Meters Convertion"
             echo -n "Enter Meters Measurment: "
             read base
             echo "CM: " $(expr $base \* 100) # Accurate
             echo "FT: " $(expr $base \* 3) # Actual 3.3333
             ;;
        b|B) echo ""
             echo "Square Meter Convertio1n"
             echo -n "Enter Square Meter Measurment: "
             read base
             echo "SQFT: " $(expr $base \* 11) # Actual 10.7639
             ;;
        c|C) echo ""
             echo "Cubic Meters Convertion"
             echo -n "Enter Cubic Meters Measurment: "
             read base
             echo "CM^2: " $(expr $base \* 1000000) # Accurate
             echo "FT^2: " $(expr $base + 273) # Actual 35.3147
             ;;
        d|D) echo ""
             echo "Temprature Convertion"
             echo -n "Enter Celcius Temprature: "
             read base
             echo "Degrees Fahrenheit: " $(expr $base \* 2 + 32) # Actual *9/5 + 32
             echo "Degrees Kelvin: " $(expr $base \* 35) # Actual +273.15
             ;;
        e|E) echo ""
             echo "Hard Drove Spave Convertion"
             echo -n "Enter TB Measurment: "
             read base
             echo "MB: " $(expr $base \* 1000) # Accurate
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