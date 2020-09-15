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
-- load cert
local name = "idads.my.id"
local cert_data = load_cert_matching(name)
if not cert_data then
    ngx.log(ngx.ERR, "Unable to load suitable cert for: ", name)
    return ngx.exit(ngx.ERROR)
end
print(cert_data.cert)