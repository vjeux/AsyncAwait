import sys
sys.path.append('../../src/python/')
from asyncawait import async, await

def multiply(x, y, callback):
	return callback(x * y)

multiplyAwait = await(multiply)

def f():
	res, = yield await(multiply)(111, 6)
	print(res)

	res, = yield multiplyAwait(6, 7)
	print(res)

async(f)()
