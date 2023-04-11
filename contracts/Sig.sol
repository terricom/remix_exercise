//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/* Signature Verification

How to Sign and Verify
# Signing
1. Create message to sign
2. Hash the message
3. Sign the hash (off chain, keep private key secret)

# Verify
1. Recreate hash from the original message
2. Recover signer from signature and hash
3. Compare recovered signer to claimed signer
*/

contract VerifySig {
    /* 1. Unlock MetaMask account
    ethereum.enable()
    */

    /* 2. Get message hash to sign
    getMessageHash("this is a secret")

    hash = "0x3d94ad58e3c30e4b253d7984033b3f8375730f9f6869ee7b8b7002743dbbde38"
    */
    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    /* 3. Sign message hash
    # using browser
    account = "複製 connect Metamask 的 address"
    ethereum.request({ method: "personal_sign", params: [account, hash]}).then(console.log)

    # using web3
    web3.personal.sign(hash, web3.eth.defaultAccount, console.log)

    Signature will be different for different accounts
    0xcb442cd7aadc14fc1cb35ccf2df64dc502224348b07e33d061828a8bb7cceb960fb35bc4d2118313c7318cd35f165740e21efcddc8bb25d9b21f4fabb4d3a99f1c
    */
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    /* 4. Verify signature
    signer = 0x1895dE8651A898E325856e7F7C011A4710Fc81ec
    message = "this is a secret"
    signature = 0xcb442cd7aadc14fc1cb35ccf2df64dc502224348b07e33d061828a8bb7cceb960fb35bc4d2118313c7318cd35f165740e21efcddc8bb25d9b21f4fabb4d3a99f1c
    */
    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
            // implicitly return (r, s, v)
        }
    }
}