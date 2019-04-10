#!/bin/bash

npm ls --depth=0
npm ll # extended dependency information
npm la --json # --long=true; --prod=true; --dev=true
npm outdated --long=true

npm link # in target module root folder
npm link module-name # in parent module node_modules folder
ls -al ./node_modules

npm install -g cost-of-modules
$(npm bin)
cost-of-modules --include-dev --yarn # --less: show top 10 modules
webpack-bundle-analyzer
webpack-bundle-size-analyzer

npm install -g notes
# TODO: show examples of package.json entries (PRs, forks, script tricks)

npm install --save-dev eslint-config-airbnb eslint@^#.#.# eslint-plugin-jsx-a11y@^#.#.# eslint-plugin-import@^#.#.# eslint-plugin-react@^#.#.#

# npx: execute npm package binaries
npx install-peerdeps --dev eslint-config-airbnb

# specific branch
npm install git+https://github.com/user/repo.git#branch

# fork
{ "redux-devtools-inspector", "git+https://github.com/njhoffman/redux-devtools-inspector.git" }

# pull request
npm install reduxjs/d3-state-visualizer#pull/17/head
{ "d3-state-visualizer": "github:reduxjs/d3-state-visualizer#pull/17/head" }
npm install --save https://github.com/{USER}/{REPO}/tarball/{BRANCH}
npm install git+ssh://git@github.com:<githubname>/<githubrepo.git[#<commit-ish>]
npm install git+ssh://git@github.com:<githubname>/<githubrepo.git>[#semver:^x.x]
npm install git+https://git@github.com/<githubname>/<githubrepo.git>
npm install git://github.com/<githubname>/<githubrepo.git>
npm install github:<githubname>/<githubrepo>[#<commit-ish>]

# repl - read-eval-print-loop
# TAB twice shows autocomplete, global objects/methods plus available nodejs modules
# _ holds the results from last expression
.editor # start a multi-line command, ^D to finish, ^C to cancel
.break # interrupts a multi-line expression (same as ^C)
.clear # resets REPL context to empty object and clears any multi-line expressions
.exit
.help
.save ~/file/to/save.js
.load ./file/to/load.js # loads a file as if it was typed

# most powerful to import repl module directly to use within node.js app
#   const repl = require('repl');
#   repl.start('CustomPrompt:: ');
#   r.context.bigBaller = (obj) => (Object.assign(obj, { prop: 'something' })
#   bigBaller({ num: 123 })
#   { num: 124, prop: 'something' }
