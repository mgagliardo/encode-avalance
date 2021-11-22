// Dependencies 
const IPFS = require('ipfs');
const all = require('it-all');

(async () => {
    // Initialise IPFS node 
    const node = await IPFS.create();

    // Store CID in a variable 
    const cid = 'Qmemu9xia8YGv6gV3LCQcs7FxPM5EDqRYfJd3sF7kBUJ9o';

    // Retrieve data from CID 
    const data = Buffer.concat(await all(node.cat(cid)));

    // Print data to console 
    console.log(data.toString());
})();
