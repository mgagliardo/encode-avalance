// Dependencies 
const IPFS = require('ipfs');
const all = require('it-all');

(async () => {
    const node = await IPFS.create();

    // FOO BAR
    const cid = 'QmT9FQ6spMuq2CKTnHs6271nB8Tms1MF6vggAA15W4Vwg2';
    const data = Buffer.concat(await all(node.cat(cid)));
    console.log(`\nData stored is: ${data.toString()}`);
})();
