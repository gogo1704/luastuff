local pretty = require "cc.pretty"

local modemSide = "top"

local modem = peripheral.wrap(modemSide) or error("modem not found", 0)
local ar = peripheral.find("arController") or error("arController not found", 0)

local min = 1
local max = 10
local buffer = {}
local bufferSize = 3

for i = min, max do
	modem.open(i)
end
modem.open(rednet.CHANNEL_BROADCAST)
modem.open(rednet.CHANNEL_REPEAT)
modem.open(gps.CHANNEL_GPS)

term.clear()
term.setCursorPos(1, 1)
print("Network Listener")
print(("ports opened: %d-%d, %d, %d, %d t: %d"):format(min, max, rednet.CHANNEL_REPEAT, gps.CHANNEL_GPS, rednet.CHANNEL_BROADCAST,math.floor(os.epoch()/100000)))

ar.clear()
ar.drawStringWithId("netTitle",("Network Listener - ports opened: %d-%d, %d, %d, %d t: %d"):format(min, max, rednet.CHANNEL_REPEAT, gps.CHANNEL_GPS, rednet.CHANNEL_BROADCAST,os.epoch()/100000),10,10,0xffffff)
while true do
	local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
	table.insert(buffer, ("t: %d p: %d r: %d d: %d "):format(os.epoch()/100000, channel, replyChannel, distance)..pretty.render(pretty.pretty(message),1000,1))
	while #buffer > bufferSize do
		for k,v in ipairs(buffer) do
			buffer[k] = buffer[k+1]	
		end
		--table.remove(buffer)
	end
	for k,v in ipairs(buffer) do
		ar.drawStringWithId(tostring(k),v,10,20+k*10,0xffffff)
	end

	write(("t: %d channel: %d reply: %d distance: %d "):format(os.epoch()/100000, channel, replyChannel, distance))
	pretty.print(pretty.pretty(message),1)
	local _, currentY = term.getCursorPos()
	term.setCursorPos(1,currentY-1)
end