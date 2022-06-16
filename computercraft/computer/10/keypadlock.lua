local monitor = peripheral.find("monitor") or error("monitor not found")
local old = term.redirect(monitor)
monitor.size = {monitor.getSize()}
for i = 1, monitor.size[2], 2 do
	for j = 1, monitor.size[1], 2 do
		paintutils.drawPixel(j, i, colors.orange)
	end
end
term.redirect(old)