const IPFS = require('ipfs-core');
const FileReader = require('filereader');

(async () => {
    // Initialise IPFS node 
    const ipfs = await IPFS.create();

    const reader = new FileReader();
    reader.onloadend = () => {
        const buf = buffer.Buffer.from(reader.result);
        ipfs.add(buf, (err, result) => {
            if (err) {
                console.error(err);
                return;
            }
            let url = `https://ipfs.io/ipfs/${result[0].hash}`;
            console.log(`URL --> ${url}`);
        });
    }
    const file = new File('test.txt');
    reader.readAsArrayBuffer(this.files[0]);
})();
