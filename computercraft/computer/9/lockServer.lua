local password = "ass"

local modem = "top"
if not (peripheral.getType(modem) == "modem") then error("modem not found") end

term.clear()
term.setCursorPos(1, 1)
print("DoorLock Server")
rednet.open(modem)
print(modem.." modem open")
rednet.host("lock","server")
print("hosting 'lock' as 'server'")
print("listening...")
while true do
	local event, id, message, protocol = os.pullEventRaw()
	if event == "terminate" then
		rednet.unhost("lock")
		rednet.close(modem)
		error("Terminanted")
	elseif event == "rednet_message" and protocol == "lock" then
		local hashA = ""
		local hashB = ""
		for i = 1, #password do
			hashA = tostring(tonumber(hashA..tostring(password:byte(i))) % 1733904931274916817)
			hashB = tostring(((tostring(password:byte(i)+1))..hashB) % 1733904931274916817)
		end
		hashA = hashA % 65537
		hashB = hashB % 65537 
		if message == hashA then
			print(("id: %d hash: %s positive response: %s"):format(id, message, hashB))
			rednet.send(id, hashB, "lock")
		else
			
			local badResponse
			repeat
				badResponse = math.random(65536)
			until not (badResponse == hashB)
			print(("id: %d hash: %s negative response: %s"):format(id, message,badResponse))
			rednet.send(id, badResponse, "lock")
		end
	end
end
