

local inventories = { peripheral.find("inventory") } or error("inventory not found", 0)

print(("Detected inventories: %d"):format(#inventories))
local list = {}
local listQ = {}


for _, inv in pairs(inventories) do
	for i = 1, inv.size() do
		list[i] = inv.getItemDetail(i)
	end
	for slot, item in pairs(list) do
		local isNew = true
		for k,v in pairs(listQ) do
			--print(item.name.." "..v.name)
			if v.displayName == item.displayName then
				
				isNew = false
				v.count = v.count + item.count
				break
			end
		end
		if isNew then
			table.insert(listQ,item)
		end
	end
end

table.sort(listQ, function (k1,k2) return (k1.count > k2.count) or ((k1.count == k2.count) and (k1.displayName < k2.displayName)) end)


local saveToFile = false
local printDocument = false

local file
while true do
	write("Save to file? Y/n: ")
	local input = read()
	if input == "y" or input == "Y" or input == "" then
		saveToFile = true
		file = io.open("log.log","w")
		file:write("")
		break
	elseif input == "n" or input == "N" then
		saveToFile = false
		break
	else

	end
end

local printer = peripheral.find("printer")

if printer then
	while true do
		write("Printer detected. Print document? Y/n: ")
		local input = read()
		if input == "y" or input == "Y" or input == "" then
			printDocument = true
			if not printer.newPage() then
				print("error printing")
				printDocument = false
			else
				printer.setPageTitle("Inventory log")
				printer.setCursorPos(1,1)
				printer.write(("Day %d Hour %d"):format(os.day(),os.time()))
				printer.setCursorPos(1,2)
				printer.write(("Detected inventories: %d"):format(#inventories))
				printer.setCursorPos(1,3)
			end
			break
		elseif input == "n" or input == "N" then
			printDocument = false
			break
		else

		end
	end
end




for k,v in pairs(listQ) do
	--local line = (string.rep(" ", 4-#tostring(v.count))..v.count.." x "..v.displayName)
	local line = (textutils.serialize(v))
	print(line)
	if saveToFile then
		file:write(line.."\n")
	end
	if printDocument then
		printer.write(line)
		local cursorPos = {printer.getCursorPos()}
		printer.setCursorPos(1, cursorPos[2] + 1)
	end
end

if saveToFile then
	file:close()
end

if printDocument then
	if not printer.endPage() then print("error printing") end
end

