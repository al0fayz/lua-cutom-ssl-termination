-- split function 
local domain = "wwwwwww.my.id"
--split function
local example = {}
for i in string.gmatch(domain, "%a+") do
    if i ~= "www" then 
        table.insert(example, i)
    end
end
local name = domain
--concat table with .
local baru = table.concat(example, ".")
print(baru)