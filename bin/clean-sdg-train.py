#!/usr/bin/env python3

import argparse
import json
import re

# Function to clean content starting with non-alphabetical characters
def clean_content(content):
    content = re.sub(r'^[^a-zA-Z]+', '', content)
    return content

def process_json_line(json_line):
    data = json.loads(json_line)
    
    data['content'] = clean_content(data.get('assistant', ''))

    if data['content']:
        return json.dumps(data)
    else:
        return None
    
def main():
    parser = argparse.ArgumentParser(description='Process and clean JSON content in each line of the file.')
    parser.add_argument('input_file', help='Path to the input file with JSON objects')
    parser.add_argument('--output_file', help='Path to the output file (optional)', default=None)
    
    args = parser.parse_args()
    
    with open(args.input_file, 'r') as infile:
        lines = infile.readlines()
    
    processed_lines = [process_json_line(line.strip()) for line in lines]
    # Filter out None values 
    processed_lines = [line for line in processed_lines if line is not None]
    
    if args.output_file:
        with open(args.output_file, 'w') as outfile:
            outfile.write('\n'.join(processed_lines) + '\n')
    else:
        for line in processed_lines:
            print(line)

if __name__ == '__main__':
    main()
