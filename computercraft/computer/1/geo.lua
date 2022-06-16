local pretty = require "cc.pretty"

local geo = peripheral.find("geoScanner") or error("geoScanner not found", 0)

local result = geo.scan(1)
sleep(geo.getOperationCooldown("scan"))

for k,block in pairs(result) do
	print(block.name)
end


textutils.pagedPrint(pretty.render(pretty.pretty(result),10,1))