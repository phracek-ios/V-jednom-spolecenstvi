#!/usr/bin/python3
# -*- coding: utf-8 -*-

import json


class Convert2Json(object):
    recap = False
    chapter = 0
    csv_dict = {}

    #Get Command Line Arguments
    def run(self):
        self.read_csv("database.csv", "database.json")

    def parse_database(self, row):
        fields = row.split(";")
        print(fields)
        return {'jmeno': fields[0],
                'popis': fields[1],
                'den': int(fields[2].split('.')[0]),
                'mesic': int(fields[2].split('.')[1]),
                'text': fields[3],
                }

    #Read CSV File
    def read_csv(self, input_file, output_file):
        csv_content = []
        with open(input_file, 'r') as csvfile:
            for row in csvfile.readlines():
                csv_content.append(self.parse_database(row))
            self.write_json(csv_content, "database", output_file)

    #Convert csv data into json and write it
    def write_json(self, data, name, json_file):
        data_to_write = {name: data}
        self.csv_dict[name] = data
        with open(json_file, "w") as f:
            json.dump(data_to_write, f, indent=4, ensure_ascii=False)


if __name__ == "__main__":
    cj = Convert2Json()
    cj.run()
