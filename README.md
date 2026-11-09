# c-template

A minimal starting point for C projects on Linux: directory layout, Makefile,
clang-format configuration, a pre-commit hook and a `.gitignore`.

## Layout

```
.
├── .githooks/pre-commit   # formats staged C files before each commit
├── .clang-format          # code style (Linux kernel flavored)
├── .gitignore
├── include/               # public headers
├── src/                   # sources and private headers
├── test/                  # test programs
├── Makefile
├── LICENSE
└── README.md
```

## Getting started

1. Click **Use this template** on GitHub (or clone the repository).
2. Enable the git hook (it is not active after a clone):

   ```sh
   make setup
   ```

3. Set the project name, either in the `Makefile` (`NAME ?= project`) or
   on the command line: `make NAME=myproject`.
4. Add `/<name>` (your binary) to `.gitignore`.
5. Replace the copyright holder in `LICENSE` and rewrite this README.

## Makefile targets

| Target       | Description                                          |
| :----------- | :--------------------------------------------------- |
| `make`       | Build the program from `src/*.c`                     |
| `make debug` | Clean rebuild with AddressSanitizer (`-g`)           |
| `make clean` | Remove the `build/` directory                        |
| `make fclean`| `clean` + remove the binary                          |
| `make re`    | `fclean` followed by a normal build                  |
| `make setup` | Enable the pre-commit hook (`core.hooksPath`)        |

Header dependencies are tracked automatically (`-MMD -MP`), so editing a
header rebuilds the files that include it.

## Code style

The style is defined in `.clang-format`. The pre-commit hook runs
`clang-format -i` on the staged `.c` and `.h` files and re-stages them, so
there is no need to format by hand. To format everything manually:

```sh
clang-format -i src/*.c include/*.h
```

`clang-format` 16 or newer is required (for `InsertNewlineAtEOF`).

## Editor support (clangd)

`clangd` needs a `compile_commands.json`. Generate it with
[bear](https://github.com/rizsotto/Bear):

```sh
make fclean && bear -- make
```

The file is machine-specific and is ignored by git.

## Requirements

`gcc` or `clang`, `make`, `clang-format`. Optional: `bear`.
Compiled with `-std=gnu99 -Wall -Wextra -Werror -pedantic`.

## License

Released under the [MIT License](LICENSE).
