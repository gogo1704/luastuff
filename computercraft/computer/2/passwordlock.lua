local modem = "back"

if not (peripheral.getType(modem) == "modem") then error("modem not found") end

local doorSide = "right"
local openTime = 3
local errorTime = 1

redstone.setOutput(doorSide, false)
while true do
	term.clear()
	term.setCursorPos(1, 1)
	write("Password: ")
	local input = ""
	repeat
		input = read("#")
	until not (input == "") 
	rednet.open(modem)
	local serverId = rednet.lookup("lock","server")
	local responseId, response
	local hashA = ""
	local hashB = ""
	if not(serverId == nil) then
		for i = 1, #input do
			hashA = tostring(tonumber(hashA..tostring(input:byte(i))) % 1733904931274916817)
			hashB = tostring(((tostring(input:byte(i)+1))..hashB) % 1733904931274916817)
		end
		hashA = hashA % 65537
		hashB = hashB % 65537
		rednet.send(serverId, hashA, "lock")
		responseId, response = rednet.receive("lock", 5)
	end
	rednet.close()
	if response == hashB then
		print("OPEN")
		redstone.setOutput(doorSide, true)
		os.sleep(openTime)
		redstone.setOutput(doorSide, false)
	elseif response == nil then
		print("CONNECTION ERROR")
		os.sleep(errorTime)
	else
		print("ERROR")
		os.sleep(errorTime)
	end
end