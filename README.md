# Elemental Meta Sequence - Proof of Participation NFT 

Sequence creators can optionally enable an NFT to be distributed to users upon completion of a given sequence. The repository contains the Solidity contracts used to mint the Proof of Participation NFT (PoPNFTS).

## Setup & Config 


1) Install Brownie [https://eth-brownie.readthedocs.io/en/stable/install.html](https://eth-brownie.readthedocs.io/en/stable/install.html)

2) create .env file with `WEB3_INFURA_PROJECT_ID=` and `POLYGONSCAN_TOKEN` if you want to verify source

3) run `brownie compile` to test things are working 


## Deploy contracts to Mumbai 


- Create deployment_account to deploy contract 
```
# Optional: create deployment account
brownie accounts generate deployment_account

# Ensure created account is listed
brownie accounts list
```

- Use Mumbai faucet to load Matic into deployment_account

- Create an `.env` file and fill the values
`cp local.env .env`

- Connect to the polygon-test rpc 
```
brownie console --network polygon-test

# check if connection was successful
network.is_connected()  #   true
network.show_active()   #   polygon-test

# load deployment account
account = accounts.load('deployment_account')

# check balance
web3.fromWei(account.balance(), 'ether')
```

- Deploy the contract using `deploy.py`
`brownie run deploy.py --network polygon-test`

If successful it should look something like
https://user-images.githubusercontent.com/5358146/161502650-88e95e04-69c4-4640-b0ca-a94858b705f3.png

# Alternate Route
`brownie console --network polygon-test`
or for mainnet:
`brownie console --network polygon-main`

1. Load your accounts 
`accounts.from_mnemonic('asd asd asd asd',count=10)`

2. Deploy the contract 
`POPNFT.deploy({'from': accounts[0]}, publish_source=True)`

3. Mint 
`POPNFT[3].safeMint(accounts[1], 'bafyreifqzbb54o5znnasebu3ub7w47ww2m7jylgbmouhxnyv5e5qkdw3wi/metadata.json', {'from': accounts[0]})`

 

