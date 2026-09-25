def read_file(filename):
    with open(filename, "r", encoding="utf-8") as file:
        for line in file:
            yield line


def write_file(source, destination):
    with open(destination, "w", encoding="utf-8") as outfile:
        for line in read_file(source):
            outfile.write(f"({line}")
    

def write_file_full(source, destination):
    with open(destination, "w", encoding="utf-8") as outfile:
        for line in read_file(source):
            splits=line.split(',')
            outfile.write(f'({splits[0]},{splits[1]},"{splits[2]}","{splits[3]}","{splits[4]}")')
##            print(f'({splits[0]},{splits[1]},"{splits[2]}","{splits[3]}","{splits[4]}")')

##passengers
##write_file("D:\\Repository\\Qtexa\\Flight Data Assignment\\passengers.csv","D:\\Repository\\Qtexa\\Flight Data Assignment\\enpassengers.csv")

##flightData
write_file_full("D:\\Repository\\Qtexa\\Flight Data Assignment\\flightData.csv",
           "D:\\Repository\\Qtexa\\Flight Data Assignment\\enflightData.csv")

print("File operation completed")
