FLAGS=--gstabs

build: main.o
	ld -o main $^

clean:
	rm -rf *.o && rm -rf main && rm -rf core

run:
	make build
	./main

.PHONY: build clean

%.o: %.s
	as $(FLAGS) -o $@ $^