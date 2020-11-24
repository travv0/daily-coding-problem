# Given the root to a binary tree, implement serialize(root), which serializes
# the tree into a string, and deserialize(s), which deserializes the string
# back into the tree.
#
# For example, given the following Node class
#
# class Node:
#     def __init__(self, val, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
#
# The following test should pass:
#
# node = Node('root', Node('left', Node('left.left')), Node('right'))
# assert deserialize(serialize(node)).left.left.val == 'left.left'

class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

    def __str__(self):
        return 'Node(' + self.val + ', ' + str(self.left) + ', ' + str(self.right) + ')'


def deserialize(s):
    def d():
        nonlocal s
        parts = s.split(' , ', 1)
        if parts[0] == 'None':
            return None
        else:
            s = parts[1]
            return Node(parts[0].replace(',,', ',').replace('NoneNone', 'None'), d(), d())
    return d()


def serialize(node):
    if node:
        val = str(node.val).replace(',', ',,').replace('None', 'NoneNone')
        return val + ' , ' + serialize(node.left) + ' , ' + serialize(node.right)
    else:
        return 'None'


node = Node('root', Node('left', Node('left.left')), Node('right'))
assert deserialize(serialize(node)).left.left.val == 'left.left'
