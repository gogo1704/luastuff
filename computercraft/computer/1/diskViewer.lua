local drives = {"drive_0","drive_1","drive_2"}
local monitors = {"monitor_0","monitor_1","monitor_2"}

for k, v in pairs(drives) do
	if not peripheral.isPresent(v) then error("drive not found") end
end

for k, v in pairs(monitors) do
	if not peripheral.isPresent(v) then error("monitor not found") end
end

if not (#drives == #monitors) then error("input error") end

while true do

	for k, v in pairs(drives) do
		print(("%s : %s"):format(v, monitors[k]))
		local drive = peripheral.wrap(v)
		local monitor = peripheral.wrap(monitors[k])
		monitor.clear()
		if drive.isDiskPresent() then
			if drive.hasAudio() then
				local author, title = string.match(drive.getAudioTitle(), "(.*)%-(.*)")

				monitor.setCursorPos(1, 1)
				monitor.setTextColor(colors.yellow)
				monitor.write("MUSIC DISC")
				monitor.setCursorPos(1, 2)
				monitor.setTextColor(colors.lightGray)
				monitor.write("Title:")
				monitor.setCursorPos(1, 3)
				monitor.setTextColor(colors.white)
				monitor.write(title:sub(2))
				monitor.setCursorPos(1, 4)
				monitor.setTextColor(colors.lightGray)
				monitor.write("Author:")
				monitor.setCursorPos(1, 5)
				monitor.setTextColor(colors.white)
				monitor.write(author)
			elseif not (drive.getDiskID() == nil) then
				monitor.setCursorPos(1, 1)
				monitor.setTextColor(colors.yellow)
				monitor.write("FLOPPY DISK")
				monitor.setCursorPos(1, 2)
				monitor.setTextColor(colors.lightGray)
				monitor.write("Label: ")
				if drive.getDiskLabel() then
					monitor.setTextColor(colors.white)
					monitor.write(drive.getDiskLabel())
				else
					monitor.setTextColor(colors.gray)
					monitor.write("no label")
				end
				monitor.setCursorPos(1, 3)
				monitor.setTextColor(colors.lightGray)
				monitor.write("ID: ")
				monitor.setTextColor(colors.white)
				monitor.write(tostring(drive.getDiskID()))
				monitor.setCursorPos(1, 4)
				monitor.setTextColor(colors.lightGray)
				monitor.write("Path: ")
				monitor.setTextColor(colors.white)
				monitor.write("/"..drive.getMountPath())
			else
				monitor.setCursorPos(1, 1)
				monitor.setTextColor(colors.yellow)
				monitor.write("DEVICE")
				monitor.setCursorPos(1, 2)
				monitor.setTextColor(colors.lightGray)
				monitor.write("Label: ")
				if drive.getDiskLabel() then
					monitor.setTextColor(colors.white)
					monitor.write(drive.getDiskLabel())
				else
					monitor.setTextColor(colors.gray)
					monitor.write("no label")
				end
				monitor.setCursorPos(1, 3)
				monitor.setTextColor(colors.lightGray)
				monitor.write("Path: ")
				monitor.setTextColor(colors.white)
				monitor.write("/"..drive.getMountPath())
			end			
		else
			monitor.setCursorPos(1, 3)
			monitor.setTextColor(colors.gray)
			monitor.write("  --- EMPTY ---")
		end
	end
	while true do
		local timer = os.startTimer(5)
		local event, id = os.pullEvent()
		if event == "disk" or event == "disk_eject" or (event == "timer" and id == timer) then
			break
		end
	end
end