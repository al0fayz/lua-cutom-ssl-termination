-- example program for website builder (https://bikin.domain.id)
local ssl = require "ngx.ssl"
            
-- local directory
local CERT_DIRECTORY = '/home/alfa/Project/Website-builder-V2/storage/ssl/'

-- load cert
local function load_cert(name)
    -- load certificate
    local f, err = io.open(CERT_DIRECTORY .. name .. "/certificate.crt")
    if not f then
        return nil, err
    end

    -- "*a": reads the whole file
    local cert = f:read("*a")

    f:close()

    -- load ca bundle
    local f, err = io.open(CERT_DIRECTORY .. name .. "/ca_bundle.crt")
    if not f then
        return nil, err
    end

    -- "*a": reads the whole file
    local ca_bundle = f:read("*a")

    f:close()

    -- load private key
    local f, err = io.open(CERT_DIRECTORY .. name .. "/private_key.pem")
    if not f then
        return nil, err
    end

    local key = f:read("*a")

    f:close()

    return {
        cert = cert.. "\n"..ca_bundle,
        key = key,
    }
end
local function load_cert_matching(name)
    -- call function and assign data
    local cert_data = load_cert(name)
    if cert_data then
        return cert_data
    end

end


-- clear existing cert 

local ok, err = ssl.clear_certs()
if not ok then
    ngx.log(ngx.ERR, "failed to clear existing (fallback) certificates")
    return ngx.exit(ngx.ERROR)
end

-- Get TLS SNI (Server Name Indication) name set by the client
local domain, err = ssl.server_name()
if not domain then
    ngx.log(ngx.ERR, "failed to get SNI, err: ", err)
    return ngx.exit(ngx.ERROR)
end

print("SNI: ", domain)
-- split function 
--local example = {}
-- local a = 0
-- for i in string.gmatch(domain, "%a+") do
--     example[a] = i
--     a = a + 1
-- end
-- local name = example[0]
local name = domain

-- load cert
local cert_data = load_cert_matching(name)
if not cert_data then
    ngx.log(ngx.ERR, "Unable to load suitable cert for: ", name)
    return ngx.exit(ngx.ERROR)
end

-- cert process
local der_cert_chain, err = ssl.cert_pem_to_der(cert_data.cert)
if not der_cert_chain then
    ngx.log(ngx.ERR, "Unable to load certificate for: ", name,
            ", err: ", err)
    return ngx.exit(ngx.ERROR)
end

local ok, err = ssl.set_der_cert(der_cert_chain)
if not ok then
    ngx.log(ngx.ERR, "Unable te set cert for: ", name,
            ", err: ", err)
    return ngx.exit(ngx.ERROR)
end

-- private key process
local der_priv_key, err = ssl.priv_key_pem_to_der(cert_data.key)
if not der_priv_key then
    ngx.log(ngx.ERR, "Unable to load Private Key for: ", name,
            ", err: ", err)
    return ngx.exit(ngx.ERROR)
end

local ok, err = ssl.set_der_priv_key(der_priv_key)
if not ok then
    ngx.log(ngx.ERR, "Unable te set Private key for: ", name,
            ", err: ", err)
    return ngx.exit(ngx.ERROR)
end