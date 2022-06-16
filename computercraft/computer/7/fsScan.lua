
while true do
	local timer = os.startTimer(1)
	local event, id
	repeat
	event, id = os.pullEvent("timer")
	until id == timer
	print(#peripheral.getNames())
end