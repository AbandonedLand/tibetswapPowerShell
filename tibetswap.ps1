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
    
    
}

Function Get-TibetPairs {

}

Function Get-TibetToken {

}

Function Get-TibetPair {

}

Function Get-TibetRouter {

}

Function Get-TibetQuote {

}

Function Send-TibetOffer {

}

