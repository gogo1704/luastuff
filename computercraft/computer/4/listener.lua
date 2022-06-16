local pretty = require "cc.pretty"

local modemSide = "top"

local modem = peripheral.wrap(modemSide) or error("modem not found", 0)

local min = 1
local max = 10

for i = min, max do
	modem.open(i)
end
modem.open(rednet.CHANNEL_BROADCAST)
modem.open(rednet.CHANNEL_REPEAT)
modem.open(gps.CHANNEL_GPS)

term.clear()
term.setCursorPos(1, 1)
print("Network Listener")
print(("ports opened: %d-%d, %d, %d, %d"):format(min, max, rednet.CHANNEL_REPEAT, gps.CHANNEL_GPS, rednet.CHANNEL_BROADCAST))
while true do
	local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
		write(("t: %d channel: %d reply: %d distance: %d "):format(math.floor(os.epoch()/100),channel, replyChannel, distance))
	pretty.print(pretty.pretty(message),1)
	local _, currentY = term.getCursorPos()
	term.setCursorPos(1,currentY-1)
end