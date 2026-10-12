from tool import greet


def test_greet_met_naam():
    assert greet(" Emiel ") == "Hallo Emiel!"


def test_greet_zonder_naam():
    assert greet("") == "Hallo!"
