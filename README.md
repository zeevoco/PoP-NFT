# Elemental Meta Sequence - Proof of Participation NFT 

Sequence creators can optionally enable an NFT to be distributed to users upon completion of a given sequence. The repository contains the Solidity contracts used to mint the Proof of Participation NFT (PoPNFTS).

## Setup & Config 


1) Install Brownie [https://eth-brownie.readthedocs.io/en/stable/install.html](https://eth-brownie.readthedocs.io/en/stable/install.html)

2) create .env file with `WEB3_INFURA_PROJECT_ID=`

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

- Add `WEB3_INFURA_PROJECT_ID` to `.env`

- Connect to the polygon-test rpc 
```
brownie console --network polygon-test

# check if connection was successful
network.is_active()     #   true
network.show_active()   #   polygon-test

# load deployment account
account = accounts.load('deployment_account')

# check balance
web3.fromWei(account.balance(), 'ether')
```

- Deploy the contract using `deploy.py`
`brownie run deploy.py --network polygon-test`

