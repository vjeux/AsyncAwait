Async Await
===========

Using the AsyncAwait pattern, you can write any asynchronous function with a callback as last argument in a synchronous way.

Example
-------

```javascript
var multiply = function (x, y, callback) {
  callback(x * y);
}
```

Now, we want to do ```1 * 2 * 3 * 4``` using an asynchronous multiply function:

```javascript
function main() {
  multiply(1, 2, function (res) {
    multiply(res, 3, function (res) {
      multiply(res, 4, function (res) {
        console.log(res);
      })
    })
  })
}
main() // 24
```

We just wrote spaghetti code. Now let's look the same code with ```async```, ```await``` and ```yield```:

```javascript
var main = async(function () {
  var [res] = yield await(multiply)(1, 2);
  [res] = yield await(multiply)(res, 3);
  [res] = yield await(multiply)(res, 4);
  console.log(res);
});
main() // 24
```

Using ```async``` and ```await```, we can easily combine asynchronous functions to write a new one:

```javascript
var factorial = async(function (n, callback) {
  var res = 1;
  for (; n > 0; --n) {
    [res] = yield await(multiply)(res, n);
  }
  callback(res);
});
```

We can either use it the old way:

```javascript
var main = function () {
  factorial(4, function (res) {
    console.log(res);
  })
}
main() // 24
```

or the new way:

```javascript
var main = async(function () {
  var [res] = yield await(factorial)(4);
  console.log(res);
});
main() // 24
```


Similar Projects
================

- [Mozilla TaskJS](http://taskjs.org/): Generator, Promise

```javascript
spawn(function*() {
    var data = yield $.ajax(url);
    $('#result').html(data);
    var status = $('#status').html('Download complete.');
    yield status.fadeIn().promise();
    yield sleep(2000);
    status.fadeOut();
});
```

- [OkCupid TameJS](http://tamejs.org/): Code Rewrite

```javascript
var res1, res2;
await {
    doOneThing(defer(res1));
    andAnother(defer(res2));
}
thenDoSomethingWith(res1, res2);
```

- [C#5 Async/Await](http://msmvps.com/blogs/jon_skeet/archive/2011/05/30/eduasync-part-9-generated-code-for-multiple-awaits.aspx):

```C#
private static async Task<int> Sum2ValuesAsyncWithAssistance() { 
    Task<int> task1 = Task.Factory.StartNew(() => 1); 
    Task<int> task2 = Task.Factory.StartNew(() => 2); 

    int value1 = await task1; 
    int value2 = await task2; 

    return value1 + value2; 
}
```

- [Kaffeine](http://weepy.github.com/kaffeine/docs/unwrapping_async_calls.html): Code Rewrite, Doesn't work with loops.

```javascript
get = {
  err, data = jQuery.get! "/"
  if !err, process data
}
```
