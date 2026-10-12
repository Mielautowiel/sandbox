"""Voorbeeldtool. Logica in functies, zodat het testbaar is."""
import sys


def greet(name: str) -> str:
    name = name.strip()
    return f"Hallo {name}!" if name else "Hallo!"


def main(argv: list[str]) -> int:
    print(greet(" ".join(argv)))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
