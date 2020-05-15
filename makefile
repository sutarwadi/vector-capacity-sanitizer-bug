all: run.clang

main.gcc: main.cpp
	g++ -fsanitize=address,undefined,pointer-compare,pointer-subtract,leak -fsanitize-address-use-after-scope main.cpp -o main.gcc

main.clang: main.cpp
	clang++ -O0 -g -stdlib=libc++ -fsanitize=address,undefined,pointer-compare,pointer-subtract,leak -fsanitize-address-use-after-scope main.cpp -o main.clang

run.gcc: main.gcc
	ASAN_OPTIONS=check_initialization_order=1:detect_stack_use_after_return=1:strict_string_checks=1:strict_init_order=1:detect_invalid_pointer_pairs=2 LSAN_OPTIONS=use_unaligned=1 ./main.gcc

run.clang: main.clang
	ASAN_OPTIONS=check_initialization_order=1:detect_stack_use_after_return=1:strict_string_checks=1:strict_init_order=1:detect_invalid_pointer_pairs=2 \
	LSAN_OPTIONS=use_unaligned=1 \
	./main.clang


clean: main.gcc main.clang
	rm main.gcc
	rm main.clang
