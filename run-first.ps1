#!/usr/bin/env pwsh

$CommitMessageSuffix = ""

switch ($(Get-Culture).IetfLanguageTag)
{
    "en-US" { $CommitMessageSuffix = ".en" }
    "ja-JP" { $CommitMessageSuffix = ".ja" }
}

if ($Null -ne $CommitMessageSuffix)
{
    # TLS 1.0, TLS 1.2, SSL 3 を有効化する
    [Net.ServicePointManager]::SecurityProtocol = `
        [Net.SecurityProtocolType]::Tls12

    $Url = "https://raw.githubusercontent.com/to884/git-scripts/main/hooks/prepare-commit-msg${CommitMessageSuffix}" 
    $(Invoke-WebRequest -Method GET $Url).Content `
        > ${PSScriptRoot}\.git\hooks\prepare-commit-msg
}

