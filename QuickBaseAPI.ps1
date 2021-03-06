# Variables
$username = "email address"
$password = "password"
$appToken = "application token"
$baseUrlQB = "https://www.quickbase.com/db"

# Makes a call against the api and returns the resulting xml
Function makeQBApiCall([string]$db, [string]$action, [string]$requestBody) {
    $encodedRequestBody = [System.Text.Encoding]::UTF8.GetBytes($requestBody)
    $request = [System.Net.HttpWebRequest]::Create("$baseUrlQB/$db")
    $request.Method = "POST"
    $request.ContentType = "application/xml"
    $request.ContentLength = $encodedRequestBody.length
    $request.Headers.Add("QUICKBASE-ACTION", $action)
    $requestStream = $request.GetRequestStream()
    $requestStream.Write($encodedRequestBody, 0, $encodedRequestBody.length)
    $requestStream.Close()
    
    $response = $request.GetResponse()
    $responseStream = $response.GetResponseStream()
    $xml = New-Object System.Xml.XmlDocument
    $xml.Load($responseStream)
    
    $responseStream.Close()
    $response.Close()
    
    return $xml
}