local monitorSide = "monitor_6"

local monitor = peripheral.wrap(monitorSide) or error("monitor not found", 0)
monitor.size = {monitor.getSize()}
monitor.setBackgroundColor(colors.black)
monitor.clear()
monitor.setBackgroundColor(colors.red)
--[[
while true do
	local event, side, x, y = os.pullEvent("monitor_touch")
	if side == monitorSide then
		monitor.setCursorPos(x,y)
		monitor.write(" ")
	end
end
]]--
while true do
	for i = 1, monitor.size[2], 2 do
		for j = 1, monitor.size[1], 2 do
			monitor.setCursorPos(j, i)
		monitor.write(" ")
		end
	end
	for i = 2, monitor.size[2], 2 do
		for j = 2, monitor.size[1], 2 do
			monitor.setCursorPos(j, i)
			monitor.write(" ")
		end
	end
	sleep(0.5)
	monitor.setBackgroundColor(colors.black)
	monitor.clear()
	monitor.setBackgroundColor(colors.red)
	for i = 1, monitor.size[2], 2 do
		for j = 2, monitor.size[1], 2 do
			monitor.setCursorPos(j, i)
		monitor.write(" ")
		end
	end
	for i = 2, monitor.size[2], 2 do
		for j = 1, monitor.size[1], 2 do
			monitor.setCursorPos(j, i)
			monitor.write(" ")
		end
	end
	sleep(0.5)
	monitor.setBackgroundColor(colors.black)
	monitor.clear()
	monitor.setBackgroundColor(colors.red)
end