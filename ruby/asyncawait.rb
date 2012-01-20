
async = lambda { |fn|
	return lambda { |*args|
		gen = fn[*args]
		callback = lambda { |response|
			if not gen.nil?
				descriptor = gen.resume(response)
				if not descriptor.nil?
					descriptor[0][*descriptor[1], callback]
				end
			end
		}
		callback[nil]
	}
}

to = lambda { |func, *args|
	return [
		lambda { |*args, callback|
			async[func][*args, callback]
		},
		args
	]
}
