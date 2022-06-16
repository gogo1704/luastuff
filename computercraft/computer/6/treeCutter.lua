local pretty = require "cc.pretty"

if turtle == nil then error("run on turtle") end

function kurwaSpin()
	turtle.turnRight()
	turtle.dig()
	turtle.turnRight()
	turtle.dig()
	turtle.turnRight()
	for i = 1, 4 do
		turtle.dig()
		turtle.forward()
		turtle.dig()
		turtle.turnLeft()
		turtle.dig()
		turtle.turnRight()
		turtle.turnRight()
		turtle.dig()
		turtle.forward()
		turtle.dig()
		turtle.turnLeft()
		turtle.dig()
		turtle.turnRight()
	end
	turtle.turnRight()
end

function megaSuck()
	turtle.suck()
	turtle.turnRight()
	turtle.suck()
	turtle.turnRight()
	turtle.suck()
	turtle.turnRight()
	turtle.suck()
	turtle.turnRight()
end


while true do
	local isBlock, blockData = turtle.inspect()
	if not isBlock then
		turtle.select(2)
		turtle.place()
	else
		local file = io.open("sex.txt","w")
		io.input(file)
		file:write(textutils.serialize(blockData))
		file:close()
		if blockData.tags["minecraft:saplings"] == true then

		elseif blockData.tags["minecraft:logs"] == true then
			local saplings = turtle.getItemCount(1)
			local logs = turtle.getItemCount(2)
			turtle.dig()
			turtle.select(1)
			turtle.place()
			repeat
				turtle.digUp()
				turtle.up()
				kurwaSpin()
			until turtle.detectUp() == false
			turtle.dig()
			turtle.forward()
			turtle.digUp()
			
			repeat
				turtle.digDown()
				turtle.down()
				local isBlock, blockData = turtle.inspectDown()
			until blockData.tags["minecraft:saplings"] == true
			turtle.back()
			turtle.down()
			megaSuck()
			if saplings > turtle.getItemCount(1) then
				print(("%d Saplings ;-;"):format(turtle.getItemCount(1)-saplings))
			else
				print(("+%d Saplings uwu"):format(turtle.getItemCount(1)-saplings))
			end
			if logs > turtle.getItemCount(2) then
				print(("%d Logs ;-;"):format(turtle.getItemCount(2)-logs))
			else
				print(("+%d Logs uwu"):format(turtle.getItemCount(2)-logs))
			end
		end
	end
end	
