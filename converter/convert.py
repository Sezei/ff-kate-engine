from threading import Thread
from os import name, system
from time import sleep

# This is our dictionary that helps us decide how we should parse.
taskResults = {}

# Main function/thread
def startConvert():
    FunkyChart = createNewTask(createYesOrNot('Do you want to create a new Funky Friday chart with an FNF format or an Osu Format? Yes for FNF, no for Osu'))
    # Create a new key that defines wether or not we want an osu chart.
    taskResults["isFNF"] = FunkyChart
    clear()

# This yields the main thread until the task at hand is finished
def createNewTask(task):
    while task == None:
        sleep()
    return task

# Different operating systems have different commands that need to be used to clear out the output
def clear():
    if name == 'nt':
        _ = system('clr')
    else:
        _ = system('clear')

# Here we just create a simple yes or no question which returns either true or false.
def createYesOrNot(line : str):
    kateText = open("KateText.txt", "r")
    print(kateText.read())
    newInput = input(f"{line} [y/n]")
    print(newInput)
    match newInput:
        case 'y':
            return True
        case 'n':
            return False
        case _:
            return None



if __name__ == '__main__':
    startConvert()
