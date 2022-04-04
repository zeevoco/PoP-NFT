from brownie import POPNFT, accounts

def main():
    account = accounts.load('deployment_account')
    POPNFT.deploy({'from': account})