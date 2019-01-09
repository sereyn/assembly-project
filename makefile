CC=gcc
FLAGS=-gstabs

build: main.o
	$(CC) $(FLAGS) -o main $^

clean:
	rm -rf *.o && rm -rf main

.PHONY: build clean

%.o: %.s
	$(CC) -c -o $@ $^