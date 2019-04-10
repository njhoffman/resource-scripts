#!/usr/bin/env node

// start node first

$>rethinkdb
$>node

r = require('rethinkdb')

let connection = null;
r.connect({ host: 'localhost', port: 28015}, (err, conn) => {
  if (err) throw err;
  connection = conn;
});

r.db('test').tableCreate('authors').run(connection, function(err, result) {
    if (err) throw err;
    console.log(JSON.stringify(result, null, 2));
});

/* inserting */
r.table('authors').insert([
    { name: "William Adama", tv_show: "Battlestar Galactica",
      posts: [
        {title: "Decommissioning speech", content: "The Cylon War is long over..."},
        {title: "We are at war", content: "Moments ago, this ship received word..."},
        {title: "The new Earth", content: "The discoveries of the past few days..."}
      ]
    },
    { name: "Laura Roslin", tv_show: "Battlestar Galactica",
      posts: [
        {title: "The oath of office", content: "I, Laura Roslin, ..."},
        {title: "They look like us", content: "The Cylons have the ability..."}
      ]
    },
    { name: "Jean-Luc Picard", tv_show: "Star Trek TNG",
      posts: [
        {title: "Civil rights", content: "There are some words I've known since..."}
      ]
    }
]).run(connection, function(err, result) {
    if (err) throw err;
    console.log(JSON.stringify(result, null, 2));
})

/* retrieving */
r.table('songs').run(connection, function(err, cursor) {
    if (err) throw err;
    cursor.toArray(function(err, result) {
        if (err) throw err;
        console.log(JSON.stringify(result, null, 2));
    });
});

r.table('authors').filter(r.row('name').eq("William Adama")).
    run(connection, function(err, cursor) {
        if (err) throw err;
        cursor.toArray(function(err, result) {
            if (err) throw err;
            console.log(JSON.stringify(result, null, 2));
        });
    });


/* realtime feeds */
r.table('authors').changes().run(connection, function(err, cursor) {
    if (err) throw err;
    cursor.each(function(err, row) {
        if (err) throw err;
        console.log(JSON.stringify(row, null, 2));
    });
});

r.db('instrumental_test').table('songs').changes().run(connection, function(err, cursor) {
  // cursor.each(console.log);
  cursor.each(util.inspect);
});

r.db('instrumental_test').table('songs').changes().run(connection, (err, cursor) => {
  cursor.each((err, row) => {
    if (err) throw err;
    util.inspect(row, { compact: true });
  });
});


  // util.inspect:
  // showHidden <boolean>
  //    If true, the object's non-enumerable symbols and properties will be included in the formatted result as well as WeakMap and WeakSet entries. Default: false.
  // depth <number>
  //    Specifies the number of times to recurse while formatting the object. This is useful for inspecting large complicated objects. To make it recurse up to the maximum call stack size pass Infinity or null. Default: 20.
  // colors <boolean>
  //    If true, the output will be styled with ANSI color codes. Colors are customizable, see Customizing util.inspect colors. Default: false.
  // customInspect <boolean>
  //    If false, then [util.inspect.custom](depth, opts) functions will not be called. Default: true.
  // showProxy <boolean>
  //    If true, then objects and functions that are Proxy objects will be introspected to show their target and handler objects. Default: false.
  // maxArrayLength <integer>
  //    Specifies the maximum number of Array, TypedArray, WeakMap and WeakSet elements to include when formatting. Set to null or Infinity to show all elements. Set to 0 or negative to show no elements. Default: 100.
  // breakLength <integer>
  //    The length at which an object's keys are split across multiple lines. Set to Infinity to format an object as a single line. Default: 60 for legacy compatibility.
  // compact <boolean>
  //     Setting this to false changes the default indentation to use a line break for each object key instead of lining up multiple properties in one line. It will also break text that is above the breakLength size into smaller and better readable chunks and indents objects the same as arrays. Note that no text will be reduced below 16 characters, no matter the breakLength size. For more information, see the example below. Default: true.
  // sorted <boolean> | <Function>
  //     If set to true or a function, all properties of an object and Set and Map entries will be sorted in the returned string. If set to true the default sort is going to be used. If set to a function, it is used as a compare function.
  //
/* update */
r.table('authors').update({type: "fictional"}).
    run(connection, function(err, result) {
        if (err) throw err;
        console.log(JSON.stringify(result, null, 2));
    });

/* delete */
r.table('authors').
    filter(r.row('posts').count().lt(3)).
    delete().
    run(connection, function(err, result) {
        if (err) throw err;
        console.log(JSON.stringify(result, null, 2));
    });
