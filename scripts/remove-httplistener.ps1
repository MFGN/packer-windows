$listeners =@(
    "127.0.0.1",
    "localhost"
)

$netsh_config = & {netsh http show iplisten}

$listeners | % {
    if ($netsh_config -match $_) {
        & {netsh http delete iplisten ipaddress=$_}
    }
}