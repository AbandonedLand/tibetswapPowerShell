Function Build-UrlWithParameters {
    <#
        .SYNOPSIS
            Build a url from a hashtable of parameters.
        .DESCRIPTION
            URL builder to help with REST api endpoints that use URL Query parameters.
        .PARAMETER BaseUrl
            The base url of the REST endpoint.  This will be the first part of the website and should begin with https:// or http://.
        .PARAMETER Parameters
            This is a hashtable of key value pairs that represent the url querey parameters for the REST endpoint.
        .EXAMPLE
            Build-UrlWithParameters -BaseUrl "https://api.dexie.space/v1/offers" -Parameters @{"status"=4}
            https://api.dexie.space/v1/offers?status=4
        .EXAMPLE
            Build-UrlWithParameters -BaseUrl "https://api.dexie.space/v1/offers" -Parameters @{"status"=4;"offered"="XCH"}
            https://api.dexie.space/v1/offers?status=4&offered=XCH
        .LINK
            https://api.v2.tibetswap.io/
        .OUTPUTS
            [string]
        .FUNCTIONALITY
            This is a helper function for building uri
            
    #>
    param (
        [string]$BaseUrl,
        [hashtable]$Parameters
    )

    # Validate inputs
    if (-not $BaseUrl) {
        throw "BaseUrl is required."
    }

    if (-not $Parameters) {
        return $BaseUrl
    }

    # Convert hashtable to query string
    $queryString = ($Parameters.GetEnumerator() | ForEach-Object { 
        "$($_.Key)=$([System.Web.HttpUtility]::UrlEncode($_.Value))"
    }) -join "&"

    # Construct the full URL
    if ($BaseUrl -match '\?') {
        # If the base URL already ends with a '?', append parameters directly
        $FullUrl = -join($BaseUrl,"&",$queryString)
    } else {
        # Otherwise, add '?' before the parameters
        $FullUrl = -join($BaseUrl,"?",$queryString)
    }

    return $FullUrl
}

Function Get-TibetTokens {
    <#
        .SYNOPSIS
            Retrieve a list of all traded tokens on TibetSwap

        .DESCRIPTION
            Retrieve a list of tokens with asset_id, (pair_id/launcher_id), name, short_name from TibetSwap API.

        .OUTPUTS
            [PSCustomObject]@{
                asset_id:       --CAT2 tail id for asset.
                pair_id:        --The TibetSwap id for traded pair.  Also known as the launcher_id.
                name:           --Name of coin.
                short_name:     --Dexie CODE for coin
                image_url:      --Image for coin representation
                verified:       --Is Verified True/False
            }
        .EXAMPLE
            Get-TibetTokens

            Output:
            [
                {
                    "asset_id": "a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913",
                    "pair_id": "1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af",
                    "name": "Spacebucks",
                    "short_name": "SBX",
                    "image_url": "https://nftstorage.link/ipfs/bafybeicyyqrk4llkvosnstdehby5pajumgzh7imvkt3dlywape65putcne/a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913.png",
                    "verified": true
                },
                {
                    "asset_id": "db1a9020d48d9d4ad22631b66ab4b9ebd3637ef7758ad38881348c5d24c38f20",
                    "pair_id": "c0952d9c3761302a5545f4c04615a855396b1570be5c61bfd073392466d2a973",
                    "name": "dexie bucks",
                    "short_name": "DBX",
                    "image_url": "https://nftstorage.link/ipfs/bafybeidiupubzjznsxonxxjvrw3jeemwsb6lgtir23mgfqoeybwcnqljsi/db1a9020d48d9d4ad22631b66ab4b9ebd3637ef7758ad38881348c5d24c38f20.png",
                    "verified": true
                }, ...
            ]
        .LINK
            https://api.v2.tibetswap.io/docs#/default/get_tokens_tokens_get
        

    #>
    $uri = 'https://api.v2.tibetswap.io/tokens'
    Return Invoke-RestMethod -Method Get -Uri $uri
    
}

Function Get-TibetPairs {
    <#
        .SYNOPSIS 
            Get a list of all traded pairs on TibetSwap
        .DESCRIPTION
            This function allows you to page through the entire list of traded pairs on TibetSwap.
            Each pair is a CAT2_XCH traded pair.
        .EXAMPLE
            Get-TibetPairs

            Output:
            [
                {
                    "launcher_id": "30a37ab26511c142e48c22a6de3141140e66b45135b85ff0b5b3c3ec7a62c271",
                    "asset_id": "ccda69ff6c44d687994efdbee30689be51d2347f739287ab4bb7b52344f8bf1d",
                    "liquidity_asset_id": "ba9750db89ef16feb3eabadbfb199509e3e1290851188e5625d0956ca1354b85",
                    "xch_reserve": 1230784588317177,
                    "token_reserve": 469098040564,
                    "liquidity": 488453915457,
                    "last_coin_id_on_chain": "f9a27d87d9ee642653b807445fdc0d7e2217b115aef420192c974b965fd7b1d9"
                },
                {
                    "launcher_id": "ad79860e5020dcdac84336a5805537cbc05f954c44caf105336226351d2902c0",
                    "asset_id": "e816ee18ce2337c4128449bc539fbbe2ecfdd2098c4e7cab4667e223c3bdc23d",
                    "liquidity_asset_id": "7ccf260808c1c3b8d87e02ea2f8df9cf71d793b62c6cb42bd654aa289410f9b5",
                    "xch_reserve": 342661258981470,
                    "token_reserve": 1821152282,
                    "liquidity": 2918214769,
                    "last_coin_id_on_chain": "ceb5b60caed76623d8e1e31809e9adfd0c98995effe51bd2a4fa570c5eaa5ab9"
                }, ...
            ]
        .PARAMETER skip
            Skips foward in query.

        .PARAMETER limit
            Limit number of results to display.
        
        .EXAMPLE 
            Get-TibetPairs -limit 10 -skip 2       

            Output:

            launcher_id           : 30a37ab26511c142e48c22a6de3141140e66b45135b85ff0b5b3c3ec7a62c271
            asset_id              : ccda69ff6c44d687994efdbee30689be51d2347f739287ab4bb7b52344f8bf1d
            liquidity_asset_id    : ba9750db89ef16feb3eabadbfb199509e3e1290851188e5625d0956ca1354b85
            xch_reserve           : 1230784588317177
            token_reserve         : 469098040564
            liquidity             : 488453915457
            last_coin_id_on_chain : f9a27d87d9ee642653b807445fdc0d7e2217b115aef420192c974b965fd7b1d9

            launcher_id           : ad79860e5020dcdac84336a5805537cbc05f954c44caf105336226351d2902c0
            asset_id              : e816ee18ce2337c4128449bc539fbbe2ecfdd2098c4e7cab4667e223c3bdc23d
            liquidity_asset_id    : 7ccf260808c1c3b8d87e02ea2f8df9cf71d793b62c6cb42bd654aa289410f9b5
            xch_reserve           : 342661258981470
            token_reserve         : 1821152282
            liquidity             : 2918214769
            last_coin_id_on_chain : ceb5b60caed76623d8e1e31809e9adfd0c98995effe51bd2a4fa570c5eaa5ab9
        .LINK
            https://api.v2.tibetswap.io/docs#/default/read_pairs_pairs_get

    #>
    param(
        [int]$skip,
        [int]$limit
    )
    $Parameters = @{}
    if($skip){
        $Parameters.Add('skip',$skip)
    }
    if($limit){
        $Parameters.Add('limit',$limit)
    }
    $uri = Build-UrlWithParameters -BaseUrl 'https://api.v2.tibetswap.io/pairs'
    return Invoke-RestMethod -Method Get -Uri $uri
}

Function Get-TibetToken {
    <#
        .SYNOPSIS
            Retrieve an individual traded token by asset_id

        .DESCRIPTION
            Retrieve a tokens with asset_id, (pair_id/launcher_id), name, short_name from TibetSwap API.
        
        .EXAMPLE
            Get-TibetToken -asset_id a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913

            Output:

            asset_id   : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
            pair_id    : 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af
            name       : Spacebucks
            short_name : SBX
            image_url  : https://nftstorage.link/ipfs/bafybeicyyqrk4llkvosnstdehby5pajumgzh7imvkt3dlywape65putcne/a628c1c2c6fcb74d53746157e438e10 
                        8eab5c0bb3e5c80ff9b1910b3e4832913.png
            verified   : True

        .PARAMETER asset_id
            The CAT2 tail id for the token.

        .LINK
            https://api.v2.tibetswap.io/docs#/default/get_token_token__asset_id__get
        
    #>

    param(
        [string] $asset_id
    )
    $uri = -join('https://api.v2.tibetswap.io/token/',$asset_id)
    Return Invoke-RestMethod -Method Get -Uri $uri
}

Function Get-TibetPair {
    <#
        .SYNOPSIS
            Retrive trading pair data from a specific trading pair.
        .DESCRIPTION
            Retrives data on total locked value for a trading pair. The liquidiy values are displayed
            in mojos not XCH notation by defult.
        .PARAMETER launcher_id
            The luancher_id is also know as the pair_id in the Get-TibetTokens endpoint.
        .PARAMETER display_as_xch_notation
            Convert the xch_reserve and token_reserve to XCH notation.  
            xch_reserve / 1000000000000
            token_reserve / 1000
        
        .EXAMPLE
            Get-TibetPair -launcher_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af

            launcher_id           : 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af
            asset_id              : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
            liquidity_asset_id    : fbe2694f6fbc63a4d9c8a598dc70f8b6fdf468e8e595ca4c6efee5a2f1ec71a4
            xch_reserve           : 138871205361620
            token_reserve         : 4694378021
            liquidity             : 6216902999
            last_coin_id_on_chain : aa73c5ff4bfb6382b2457498e7eefb06a6d8730822f77d6930ce65614dd26ebc
        
        
        .EXAMPLE
            Get-TibetPair -launcher_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -display_as_xch_notation

            launcher_id           : 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af
            asset_id              : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
            liquidity_asset_id    : fbe2694f6fbc63a4d9c8a598dc70f8b6fdf468e8e595ca4c6efee5a2f1ec71a4
            xch_reserve           : 138.87120536162
            token_reserve         : 4694378.021
            liquidity             : 6216902999
            last_coin_id_on_chain : aa73c5ff4bfb6382b2457498e7eefb06a6d8730822f77d6930ce65614dd26ebc
            
    #>
    param(
        [string]$launcher_id,
        [switch]$display_as_xch_notation
    )
    $uri = -join('https://api.v2.tibetswap.io/pair/',$launcher_id)

    $response = Invoke-RestMethod -Method Get -Uri $uri
    if($display_as_xch_notation.IsPresent){
        $response.xch_reserve = [decimal]$response.xch_reserve / 1000000000000
        $response.token_reserve = [decimal]$response.token_reserve / 1000
    }
    return $response
}

Function Get-TibetRouter {
    Return Invoke-RestMethod -Method Get -Uri 'https://api.v2.tibetswap.io/router'
}

Function Get-TibetQuote {
    <#
        .SYNOPSIS
            Retrive a trade quote from TibetSwap for a given pair_id (launcher_id).
        .DESCRIPTION
            Retrive an offer quote from TibetSwap.  This will show what the AMM will accept as a trade.

        .EXAMPLE
            Retrieve a quote for 0.001 SpaceBucks
            Get-TibetQuote -pair_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -amount_in 1

            Output: 
                amount_in      : 1
                amount_out     : 29375
                price_warning  : False
                price_impact   : 4.2305381420249E-10
                fee            : 
                asset_id       : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
                input_reserve  : 4694378021
                output_reserve : 138871205361620
        .EXAMPLE
            Retrieve a quote for 0.000000000001 XCH worth of SpaceBucks
            Get-TibetQuote -pair_id 1a6d4f404766f984d014a3a7cab15021e258025ff50481c73ea7c48927bd28af -amount_in 1 -xch_is_input
            
                amount_in      : 1
                amount_out     : 0
                price_warning  : False
                price_impact   : 0
                fee            : 
                asset_id       : a628c1c2c6fcb74d53746157e438e108eab5c0bb3e5c80ff9b1910b3e4832913
                input_reserve  : 138871205361620
                output_reserve : 4694378021

    #>
    param(
        [string]$pair_id,
        [Decimal]$amount_in,
        [Decimal]$amount_out,
        [switch]$xch_is_input,
        [switch]$estimate_fee,
        [switch]$display_as_xch_notation
    )

    $uri = -join('https://api.v2.tibetswap.io/quote/',$pair_id)
    $Parameters = @{}
    if($display_as_xch_notation.IsPresent){
        if($xch_is_input.IsPresent){
            $amount_in = $amount_in * 1000000000000
            $amount_out = $amount_out * 1000
        } else {
            $amount_out = $amount_out * 1000000000000
            $amount_in = $amount_in * 1000
        }

    }
    if($amount_in){
        $Parameters.Add('amount_in',$amount_in)
    }
    if($amount_out){
        $Parameters.Add('amount_out',$amount_out)
    }
    
    if($xch_is_input){
        $Parameters.Add('xch_is_input',1)
    } else {
        $Parameters.Add('xch_is_input',0)
    }
    if($estimate_fee.IsPresent){
        $Parameters.Add('estimate_fee',1)
    } else {
        $Parameters.Add('estimate_fee',0)
    }
    $uri = Build-UrlWithParameters -BaseUrl $uri -Parameters $Parameters
    $result = Invoke-RestMethod -Method Get -Uri $uri
    if($display_as_xch_notation.IsPresent){
        if($xch_is_input.IsPresent){
            $result.amount_in = [decimal]($result.amount_in / 1000000000000)
            $result.amount_out = [decimal]($result.amount_out / 1000)
        } else {
            $result.amount_out = [decimal]($result.amount_out / 1000000000000)
            $result.amount_in = [decimal]($result.amount_in / 1000)
        }
        $result | Add-Member -Name xch_notation -Type NoteProperty -Value $true
    }
    return $result
}

Function Send-TibetOffer {
    param(
        [Parameter(mandatory=$true)]
        [string]$pair_id,
        [Parameter(mandatory=$true)]
        [string]$offer,
        [Parameter(mandatory=$true)]
        [Validateset("SWAP","ADD_LIQUIDITY","REMOVE_LIQUIDITY")]
        [string]$action
    )

    $uri = -join('https://api.v2.tibetswap.io/offer/',$pair_id)
    $body = @{
        offer = $offer
        action = $action
    } | ConvertTo-Json
    $contentType = 'application/json' 
    Invoke-RestMethod -Method Post -Uri $uri -Body $body -ContentType $contentType

}

