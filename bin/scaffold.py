#!/usr/bin/env python3
import argparse

def py():
    f = """#!/usr/bin/env python3

import argparse
def commands_parser():
    parser = argparse.ArgumentParser(description='Call contract function', epilog=f'Example: {__file__} -i input -x xxx -o output"')
    parser.add_argument('-i','--input', help='argument_1', metavar="[Custom_message_Required_Argument ]", required=True)
    parser.add_argument('-x','--xx', help='argument_2', metavar="[Optional_argument]", type=str, default=None, required=False)
    parser.add_argument('-o','--output', help='argument_3', metavar="[Required_argument]", required=True)
    args = parser.parse_args()
    return args

def main():    
    args = commands_parser()
    arg_input = args.input
    arg_xx = args.xx
    arg_output = args.output


if __name__ == "__main__":
    main()"""
    print(f)

def commands_parser():
    parser = argparse.ArgumentParser(description='Generate boilerplate', epilog=f'Example: {__file__} -l python"')
    parser.add_argument('-l','--language', help='program language', metavar="", required=True, type=str)
    args = parser.parse_args()
    return args


def main():
    args = commands_parser()
    if args.language == "python":
        py()

if __name__ == "__main__":
    main()    
