
# Requires Python 3

def async(fn):
	def f(*args):
		gen = fn(*args)
		def callback(*args):
			try:
				if len(args) == 1 and args[0] == callback:
					(fn, args) = next(gen)
				else:
					(fn, args) = gen.send(args)
				fn(*(args + (callback,)))
			except StopIteration:
				pass

		callback(callback)
	return f

def await(fn):
	def f(*args):
		return (fn, args)
	return f

