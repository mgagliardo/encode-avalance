const IPFS = require('ipfs'); 

(async () => { 
    const node = await IPFS.create(); 

    const data = 'FOO BAR'; 
    const cid = await node.add(data); 
    console.log(`\nData is stored in https://ipfs.io/ipfs/${cid.path}`);
})();
