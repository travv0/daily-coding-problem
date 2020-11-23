def cons(a, b):
    def pair(f):
        return f(a, b)
    return pair


def car(pair):
    def first(a, b):
        return a
    return pair(first)


def cdr(pair):
    def second(a, b):
        return b
    return pair(second)


assert car(cons(3, 4)) == 3
assert cdr(cons(3, 4)) == 4
