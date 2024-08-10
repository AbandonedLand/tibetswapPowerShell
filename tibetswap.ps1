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
    $uri = 'https://api.v2.tibetswap.io/tokens'
    Return Invoke-RestMethod -Method Get -Uri $uri
    
}

Function Get-TibetPairs {
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
    param(
        [string] $asset_id
    )
    $uri = -join('https://api.v2.tibetswap.io/token/',$asset_id)
    Return Invoke-RestMethod -Method Get -Uri $uri
}

Function Get-TibetPair {
    param(
        [string]$launcher_id
    )
    $uri = -join('https://api.v2.tibetswap.io/pair/',$launcher_id)
    Return Invoke-RestMethod -Method Get -Uri $uri
}

Function Get-TibetRouter {
    Return Invoke-RestMethod -Method Get -Uri 'https://api.v2.tibetswap.io/router'
}

Function Get-TibetQuote {
    param(
        [string]$pair_id,
        [Int64]$amount_in,
        [Int64]$amount_out,
        [switch]$xch_is_input,
        [switch]$estimate_fee,
        [switch]$input_is_xch_notation
    )

    if($input_is_xch_notation.IsPresent){
        if($xch_is_input.IsPresent){
            
        }
    }



}

Function Send-TibetOffer {

}

