import React, { useState } from 'react';
import Web3 from 'web3';
import { encodeTokenAbi } from './abi/abis';
import './App.css';

const web3 = new Web3(Web3.givenProvider);

const contractAddr = '0x1594efD6cC552812683e666628Fcb5473A76E8c2';
const EncodeContract = new web3.eth.Contract(encodeTokenAbi, contractAddr);

function App() {
    const [number, setNumber] = useState(0);
    const [getNumber, setGetNumber] = useState('0x00');
    return (
        <div className="App">
            <header className="App-header">
                <form onSubmit={handleSet}>
                    <label>
                        Set Number:
                        <input
                            type="text"
                            name="name"
                            value={number}
                            onChange={e => setNumber(e.target.value)} />
                    </label>
                    <input type="submit" value="Set Number" />
                </form>
                <br />
                <button
                    onClick={handleGet}
                    type="button" >
                    Get Number
                </button>
                { getNumber }
            </header>
        </div>
    );
}
