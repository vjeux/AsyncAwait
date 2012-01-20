
function async (fn) {
	return function () {
		// Get a generator by calling the function one time
		var generator = fn.apply(this, arguments);

		function callback (isFirstTime) {
			try {
				// The script has just yielded a function to await
				var [fn, args] = (isFirstTime === generator)
					? generator.next()
					: generator.send(Array.slice(arguments));

				// Run the function with the initial args + our callback
				fn.apply(this, args.concat(callback));

			} catch (error if error === StopIteration) {
				// The generator completed its execution
			}
		};

		// Use generator as a dummy value to know when
		// callback is called for the first time
		callback(generator);
	};
}

// await(fn)(1, 2, 3)
// -> [fn, [1, 2, 3]]
function await (fn) {
	return function() {
		return [ fn, Array.slice(arguments) ];
	}
}
