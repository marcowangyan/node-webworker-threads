name: 'webworker-threads'
version: '0.2.4'
main: 'build/Release/WebWorkerThreads.node'
description: 'Lightweight Web Worker API implementation with POSIX threads'
keywords: [ 'threads' 'web worker' 'a gogo' ]
author:
  name: 'Audrey Tang'
  email: 'audreyt@audreyt.org'
  twitter: 'audreyt'
homepage: 'https://github.com/audreyt/node-webworker-threads'
bugs:
  url: 'http://github.com/audreyt/node-webworker-threads/issues'
  email: 'audreyt@audreyt.org'
licenses: [
    { type: "Apache License, Version 2.0", url: "http://www.apache.org/licenses/LICENSE-2.0" }
    { type: 'MIT', url: "file:LICENSE" }
]
repository:
  type: 'git'
  url: 'http://github.com/audreyt/node-webworker-threads.git'
scripts:
  prepublish: 'env PATH=./node_modules/.bin:"$PATH" lsc -cj package.ls'
  js: """
    env PATH=./node_modules/.bin:"$PATH" lsc -cj package.ls;
    gcc deps/minifier/src/minify.c -o deps/minifier/bin/minify;
    env PATH=./node_modules/.bin:"$PATH" lsc -cbp src/load.ls                      > src/load.js;
    ./deps/minifier/bin/minify kLoad_js              < src/load.js            > src/load.js.c;
    env PATH=./node_modules/.bin:"$PATH" lsc -cbp src/worker.ls                    > src/worker.js;
    ./deps/minifier/bin/minify kWorker_js            < src/worker.js          > src/worker.js.c;
    env PATH=./node_modules/.bin:"$PATH" lsc -cbp src/events.ls                    > src/events.js;
    ./deps/minifier/bin/minify kEvents_js            < src/events.js          > src/events.js.c;
    env PATH=./node_modules/.bin:"$PATH" lsc -cbp src/thread_nextTick.ls           > src/thread_nextTick.js;
    ./deps/minifier/bin/minify kThread_nextTick_js 1 < src/thread_nextTick.js > src/thread_nextTick.js.c;
    env PATH=./node_modules/.bin:"$PATH" lsc -cbp src/createPool.ls                > src/createPool.js;
    ./deps/minifier/bin/minify kCreatePool_js        < src/createPool.js      > src/createPool.js.c;
  """
dev-dependencies:
  LiveScript: \1.1.x
gypfile: true
os: <[ macos linux darwin sunos ]>
engines: { node: '>=0.8.0' }