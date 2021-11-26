import os

BANNER = """
Welcome to Big Data Processing Application
"""

OPTIONS = """
Please type number that corresponds to which application you would like to run:
1. Apache Hadoop
2. Apache Spark
3. Jupyter Notebook
4. SonarQube and SonarScanner
5. Exit
"""

PROMPT = """
Type the number the here > """


def handle_input(choice: int) -> None:
    match choice:
        case 1:
            print("Navigate to: http://34.121.62.89")
        case 2:
            print("Navigate to: http://34.135.128.145")
        case 3:
            print("Navigate to: http://34.134.205.190")
        case 4:
            print("Navigate to: http://34.133.164.88")
        case 5:
            print("Thank you for using Big Data Processing Application.")
            os._exit(0)
        case _:
            print("Invalid Input. Please try again.")


def main() -> None:
    print(BANNER)
    while (True):
        print(OPTIONS)
        try:
            handle_input(int(input(PROMPT)))
        except Exception as e:
            if e==EOFError:
                pass
            else:
                print("Invalid Input. Please try again.") 

if __name__ == "__main__":
    main()