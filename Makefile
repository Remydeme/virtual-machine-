CXX= g++
LEXER= ./src/scan.ll
PARSER= ./src/parse.yy
SRC= scan.cc parse.cc
EXEC= thl 
BISON= -Wall,error --report=all
all: thl

scan: scan.cc

scan.cc : $(LEXER)
	flex -o $@ $^

parse: parse.cc

parse.cc: $(PARSER)
	bison -v -d  $(BISON) -o $@ $^

$(EXEC): $(SRC)
	$(CXX) -o $@ $^

check: all 
	@mv thl tests; cd tests; ./test.sh

clean: 
	@rm -rf $(EXEC) $(OBJECT_FILES) *.hh *.cc
	@rm -rf parse.output; cd tests ; rm thl	

.PHONY: clean all
