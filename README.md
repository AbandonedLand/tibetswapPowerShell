# tibetswapPowerShell
 PowerShell wrapper for TibetSwap API for Chia Blockchain

# Installation
 Clone download the ps1 file into a direcory of your choosing.  Then load the function using the dot notation.

 ```powershell
 . .\tibetswap.ps1
 ```



# Get-TibetTokens

## SYNOPSIS
Retrieve a list of all traded tokens on TibetSwap.

## DESCRIPTION
This script retrieves a list of tokens with `asset_id`, `pair_id/launcher_id`, `name`, `short_name`, and other details from the TibetSwap API.

## OUTPUTS
The script outputs a list of objects with the following properties:

- **asset_id**: The CAT2 tail ID for the asset.
- **pair_id**: The TibetSwap ID for the traded pair. Also known as the launcher_id.
- **name**: Name of the coin.
- **short_name**: Dexie CODE for the coin.
- **image_url**: Image URL for coin representation.
- **verified**: Indicates if the token is verified (True/False).

## EXAMPLE
```powershell
Get-TibetTokens

asset_id   : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
pair_id    : 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af
name       : Spacebucks
short_name : SBX
image_url  : https://nftstorage.link/ipfs/bafybeicyyqrk4llkvosnstdehby5pajumgzh7imvkt3dlywape65putcne/a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913.png
verified   : True

asset_id   : db1a9020d48d9d4ad22631b66ab4b9ebd3637ef7758ad38881348c5d24c38f20
pair_id    : c0952d9c3761302a5545f4c04615a855396b1570be5c61bfd073392466d2a973
name       : dexie bucks
short_name : DBX
image_url  : https://nftstorage.link/ipfs/bafybeidiupubzjznsxonxxjvrw3jeemwsb6lgtir23mgfqoeybwcnqljsi/db1a9020d48d9d4ad22631b66ab4b9ebd3637ef7758ad38881348c5d24c38f20.png
verified   : True

asset_id   : 509deafe3cd8bbfbb9ccce1d930e3d7b57b40c964fa33379b18d628175eb7a8f
pair_id    : 3bc8a62cb5d05190e4aa8d3ea738f639259402f356a99c6521011063d100580b
name       : Chia Holiday 2021
short_name : CH21
-- More  --
```

# Get-TibetPairs

## SYNOPSIS
Get a list of all traded pairs on TibetSwap.

## DESCRIPTION
This function allows you to page through the entire list of traded pairs on TibetSwap. Each pair is a CAT2_XCH traded pair.

## OUTPUTS
The script outputs a list of objects with the following properties:

- **launcher_id**: The TibetSwap id for traded pair.  Also known as the pair_id.
- **asset_id**: CAT2 tail id for asset.
- **liquidity_asset_id**: CAT2 tail for the liquidity token.
- **xch_reserve**: Amount of XCH held as Mojos in the smart coin.
- **token_reserve**: Amount of CAT2 held in Mojos in the smart coin.
- **liquidity**: Amout of liquidity tokens in circulation.
- **last_coin_id_on_chain**: The last coin id on chain.


## PARAMETERS

- **skip**: Skips forward in the query.
- **limit**: Limits the number of results to display.

## EXAMPLES

### Example 1
```powershell
Get-TibetPairs
```
```yaml

launcher_id           : 30a37ab26511c142e48c22a6de3141140e66b45135b85ff0b5b3c3ec7a62c271
asset_id              : ccda69ff6c44d687994efdbee30689be51d2347f739287ab4bb7b52344f8bf1d
liquidity_asset_id    : ba9750db89ef16feb3eabadbfb199509e3e1290851188e5625d0956ca1354b85
xch_reserve           : 1218567060353797
token_reserve         : 473838226946
liquidity             : 488453915457
last_coin_id_on_chain : fde48c263183fa101a1d8c5e2fc47dd3145568411994555f4a5fdd984de644fd

launcher_id           : ad79860e5020dcdac84336a5805537cbc05f954c44caf105336226351d2902c0
asset_id              : e816ee18ce2337c4128449bc539fbbe2ecfdd2098c4e7cab4667e223c3bdc23d
liquidity_asset_id    : 7ccf260808c1c3b8d87e02ea2f8df9cf71d793b62c6cb42bd654aa289410f9b5
xch_reserve           : 343281258474997
token_reserve         : 1817886086
liquidity             : 2918214769
last_coin_id_on_chain : e05b49f2cceb9884a8b4ce73872538607d7d98938518b1070c628090d655452c

launcher_id           : b62577aed2b09182f3db8b21049d687b597f1526fb88268c1b4f4dec4add28ec
asset_id              : ec9d874e152e888231024c72e391fc484e8b6a1cf744430a322a0544e207bf46
-- More  --
```

# Get-TibetToken

## SYNOPSIS
Retrieve an individual traded token by `asset_id`.

## DESCRIPTION
This function retrieves a token's details including `asset_id`, `pair_id/launcher_id`, `name`, `short_name`, and other attributes from the TibetSwap API.

## PARAMETERS

- **asset_id**: The CAT2 tail ID for the token.

## EXAMPLES

### Example 1
```powershell
Get-TibetToken -asset_id a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
```
```yaml
asset_id   : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
pair_id    : 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af
name       : Spacebucks
short_name : SBX
image_url  : https://nftstorage.link/ipfs/bafybeicyyqrk4llkvosnstdehby5pajumgzh7imvkt3dlywape65putcne/a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913.png
verified   : True
```


# Get-TibetQuote

## SYNOPSIS
Retrieve a trade quote from TibetSwap for a given `pair_id` (launcher_id).

## DESCRIPTION
This function retrieves an offer quote from TibetSwap, showing what the Automated Market Maker (AMM) will accept as a trade.

## PARAMETERS

- **pair_id**: The launcher ID of the trading pair.
- **amount_in**: The amount of input tokens.
- **amount_out**: The desired amount of output tokens.
- **xch_is_input**: Switch parameter indicating whether XCH is the input.
- **estimate_fee**: Switch parameter to estimate the fee.
- **display_as_xch_notation**: Switch parameter to display values in XCH notation.

## EXAMPLES

### Example 1
Retrieve a quote for 0.001 SpaceBucks:
```powershell
Get-TibetQuote -pair_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -amount_in 1
```
```yaml
amount_in      : 1
amount_out     : 29375
price_warning  : False
price_impact   : 4.2305381420249E-10
fee            : 
asset_id       : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
input_reserve  : 4694378021
output_reserve : 138871205361620
```
### Example 2
Retrieve a quote for 0.000000000001 XCH worth of SpaceBucks:
```powershell
Get-TibetQuote -pair_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -amount_in 1 -xch_is_input
```
```yaml
amount_in      : 1
amount_out     : 29375
price_warning  : False
price_impact   : 4.2305381420249E-10
fee            : 
asset_id       : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
input_reserve  : 4694378021
output_reserve : 138871205361620
```

### Example 2
Retrieve a quote for 1 XCH worth of SpaceBucks:
```powershell
Get-TibetQuote -pair_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -amount_in 1 -xch_is_input -display_as_xch_notation
```
```yaml
amount_in      : 1
amount_out     : 33328.88
price_warning  : False
price_impact   : 0.0141490807094357
fee            : 
asset_id       : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
input_reserve  : 138871205361620
output_reserve : 4694378021
xch_notation   : True
```


# Send-TibetOffer

## SYNOPSIS
Send an offer to TibetSwap.

## DESCRIPTION    
This function allows you to send an offer to TibetSwap for it to be accepted. The offers can be for swapping tokens, adding liquidity, or removing liquidity.

## PARAMETERS

- **pair_id**: The ID of the trading pair (launcher_id).
- **offer**: The offer details to be sent to TibetSwap.
- **action**: The action type, such as SWAP, ADD_LIQUIDITY, or REMOVE_LIQUIDITY.

## EXAMPLES

### Example 1
Send an offer to swap XCH for SpaceBucks:
```powershell
Send-TibetOffer -pair_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -offer offer1d24..... -action SWAP
```
```powershell
success message                                offer_id
------- -------                                --------
True    {"status": "SUCCESS", "success": true} 3RR9miy92Vfxr1kgb72Z28sDMhU44BivD1nwkxRLPMHb

```

