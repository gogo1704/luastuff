if turtle == nil then error("run on turtle") end

function empty()
	for i=1, 16 do
		turtle.drop()
	end
end

function findItem(name)
	for i=1, 16 do
		if turtle.getItemCount(i) > 0 and turtle.getItemDetail(i).name == name then
			return i
		end
	end
	return false
end

function printLine(printer,text)
	printer.write(tostring(text))
	local cursorPos = {printer.getCursorPos()}
	printer.setCursorPos(1, cursorPos[2] + 1)
end

turtle.up()
turtle.up()
turtle.select(findItem("computercraft:printer"))
turtle.placeDown()
turtle.select(findItem("minecraft:paper"))
turtle.dropDown()
turtle.back()
turtle.down()
turtle.select(findItem("minecraft:black_dye"))
turtle.drop()
turtle.down()
turtle.forward()


turtle.select(findItem("minecraft:barrel"))
turtle.place()
turtle.drop()
turtle.select(findItem("minecraft:leather"))
turtle.drop()
turtle.select(findItem("minecraft:string"))
turtle.transferTo(1)

local printer = peripheral.wrap("top")

local number = 1
printer.newPage()
while number < 100 do
	local cursorPos = {printer.getCursorPos()}
	local pageSize = {printer.getPageSize()}
	if cursorPos[2] > pageSize[2] then
		printer.endPage()
		turtle.suckUp()
		turtle.craft()
		printer.newPage()
	end
	printLine(printer,number)
	number = number + 1
end
printer.endPage()
turtle.suckUp()
turtle.craft()
turtle.suck()
turtle.craft()
turtle.dig()
turtle.digUp()