local drive = peripheral.find("drive") or error("drive not found")

term.clear()
term.setCursorPos(1,1)
print(peripheral.getName(drive))

local passID = 0
local pass = "ass"
local doorSide = "front"
local openTime = 3

while true do
	event, side = os.pullEvent("disk")
	if peripheral.getName(drive) == side then
		local diskID = drive.getDiskID()
		local diskLabel = drive.getDiskLabel()
		local path = fs.combine(drive.getMountPath(),"pass")
		local input
		if fs.exists(path) and not fs.isDir(path) then
			local file = fs.open(path, "r")
			input = file.readAll()
			file.close()
		end
		drive.ejectDisk()
		if diskID == passID and input == pass then
			redstone.setOutput(doorSide, true)
			sleep(openTime)
			redstone.setOutput(doorSide, false)
		end	
	end
end