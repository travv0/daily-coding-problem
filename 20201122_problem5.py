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


print("car(cons(3, 4)) ==", car(cons(3, 4)))
print("cdr(cons(3, 4)) ==", cdr(cons(3, 4)))
