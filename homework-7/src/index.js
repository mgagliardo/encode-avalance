'use strict';

const IPFS = require('ipfs');

document.addEventListener('DOMContentLoaded', async () => {
    const ipfs = window.IpfsApi('ipfs.infura.io', '5001', { protocol: 'https' }); // Connect to IPFS
    async function read() {
        (async () => {
            const data = ipfs.types.Buffer.concat(await all(ipfs.cat(cid)));

            // Print data to console 
            console.log(data.toString());
        })();

        const reader = new FileReader();
        reader.onloadend = function () {
            const ipfs = window.IpfsApi('ipfs.infura.io', '5001', { protocol: 'https' }); // Connect to IPFS
            const buf = ipfs.types.Buffer(reader.result) // Convert data into buffer
            ipfs.files.add(buf, (err, result) => { // Upload buffer to IPFS
                if (err) {
                    console.error(err)
                    return
                }
                let url = `https://ipfs.io/ipfs/${result[0].hash}`
                console.log(`Url --> ${url}`)
                document.getElementById("url").innerHTML = url
                document.getElementById("url").href = url
                document.getElementById("output").src = url
            })
        }
        const file = document.getElementById("file");
        reader.readAsArrayBuffer(file.files[0]); // Read Provided File
    }

    async function display(cid) {
        for await(const data of ipfs.cat(cid)) {
            document.getElementById('cid').innerText = cid;
            document.getElementById('content').innerText = data;
            document.getElementById('output').setAttribute('style', 'display: block');
        }
    }
    document.getElementById('store').onclick = store
});
