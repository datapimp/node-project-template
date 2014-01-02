# a node.js template

Using grunt, with coffeescript, less, jade.

### Setting up Github Pages Deployment

- add a deploy folder to your project
- .gitignore it
- clone another copy of your repository into the deploy folder
- `cd deploy && git checkout --orphan gh-pages && git rm -rf .`

Deploy using `grunt deploy`


