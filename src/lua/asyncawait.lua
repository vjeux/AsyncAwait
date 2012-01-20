
yield = coroutine.yield

async = function (fn)
	co = coroutine.create(fn)
	return function (...)
		callback = function (...)
			_, fn, args = coroutine.resume(co, unpack(arg))
			if coroutine.status(co) ~= 'dead' then
				table.insert(args, callback)
				fn(unpack(args))
			end
		end
		callback(arg)
	end
end

await = function (fn)
	return function (...)
		return fn, arg
	end
end
