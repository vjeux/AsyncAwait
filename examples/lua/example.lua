
require '../../src/lua/asyncawait.lua'

multiply = function (x, y, callback)
	callback(x * y)
end

multiplyAwait = await(multiply)

asyncFunction = async(function ()
	res = yield(await(multiply)(111, 6))
	print(res)

	res = yield(multiplyAwait(6, 7))
	print(res)
end)

asyncFunction()
