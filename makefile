FLAGS=--gstabs

build: main.o
	ld -o main $^

clean:
	rm -f *.o && rm -f main && rm -f core

run:
	make build
	./main

.PHONY: build clean run

%.o: %.s
	as $(FLAGS) -o $@ $^