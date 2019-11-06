import itertools


def multiplyCarry2(l1, l2):
    """
    multiply @l1 and @l2 according to the "carry 2" rule.

    Requires len(@l1) == len(@l2)

    @l1, @l2 : list of digits

    add termwise like normal, but carry a 2 instead of a 1.

    i.e. 237 + 481 = 6?? = 61? (carry 2) = 610? (carry 2) = 6102
    """

    ret = []
    carry = 0
    for i in range(len(l1)):
        x = l1[i] + l2[i] + carry
        ret += [x % 10]
        carry = 2* (x // 10)
    return ret


def words(n):
    """
    All strings of digits of length n
    """
    for item in itertools.product("0123456789", repeat=n):
        yield "".join(item)


def isMC2Assoc(n):
    """
    Test if multiplyCarry2 is associative to words of length @n
    """

    total = 10^(3*n)
    i = 1
    for w1 in words(n):
        w1 = [int(w1i) for w1i in w1]
        for w2 in words(n):
            w2 = [int(w2i) for w2i in w2]
            for w3 in words(n):
                w3 = [int(w3i) for w3i in w3]
                print "{0} of {1}".format(i,total)
                i += 1
                if multiplyCarry2(multiplyCarry2(w1,w2),w3) != multiplyCarry2(w1, multiplyCarry2(w2,w3)):
                    print "Oh no!"
                    print w1
                    print w2
                    print w3
                    return False
    return True
