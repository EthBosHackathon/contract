-include .env

#Clean the repo
clean :; forge clean

# Install the Modules
install-oz :;
	forge install OpenZeppelin/openzeppelin-contracts --no-commit

# Test
run-tests :; forge test -vvvv

# Builds
build :; forge clean && forge build --optimize --optimize-runs 1000000

#Deploy
deploy-local :;
	forge create NFBnb --constructor-args ${CONTRACT_NAME} ${TOKEN_SYMBOL} src/NFBnb.sol --private-key ${LOCAL_PRIVATE_KEY} --rpc-url http://localhost:8545

deploy-test :;
	forge create NFBnb --constructor-args ${CONTRACT_NAME} ${TOKEN_SYMBOL}  src/NFBnb.sol --private-key ${GORLI_PRIVATE_KEY} --rpc-url ${GORLI_RPC}
