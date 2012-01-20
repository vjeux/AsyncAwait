
async = ->(generator) {
	->(*args) {
		callback = ->(*args) {
			if generator.alive?
				fn, args = generator.resume(*args)
				fn[*(args + [callback])]
			end
		}
		callback[*args];
	};
}

# await(fn)(1, 2, 3)
# -> [fn, [1, 2, 3]]
await = ->(fn) {
	->(*args) {
		[ fn, args ]
	}
}
