all: $(patsubst %.scad,%.stl,$(shell find .. -name '*.scad' | grep -v ../lib_))

%.stl: %.scad
	OPENSCADPATH=.. openscad $< -o $(shell basename $@)

clean:
	rm -f *.stl
