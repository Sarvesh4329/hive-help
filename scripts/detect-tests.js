const path = require('path');

const packagePath = process.argv[2] || 'backend/package.json';
const pkg = require(path.resolve(packagePath));
const testScript = pkg.scripts && pkg.scripts.test;
const shouldRun = Boolean(testScript && !testScript.includes('no test specified'));

process.stdout.write(`shouldRun=${shouldRun}\n`);
