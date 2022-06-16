local shellroutine = coroutine.create(function() shell.run("multishell") end)
os.queueEvent("boot")

local termSize = {term.getSize()}

paintutils.drawLine(1,1,termSize[1],1,colors.lightGray)
term.clear()
term.setCursorPos(1,1)
term.setTextColor(colors.gray)
write(os.getComputerLabel())
local idString = "#"..os.getComputerID()
term.setCursorPos(termSize[1]-#idString+1,1)
write(idString)
term.setBackgroundColor(colors.black)


local gui = window.create(term.current(), 1, 2, termSize[1], termSize[2]-1)

local filter
while true do
  -- pull a new event
  local eventData = table.pack(os.pullEventRaw(filter))

  -- alter mouse events
  if eventData[1] == "mouse_click" or eventData[1] == "mouse_up" or eventData[1] == "mouse_drag" then
    if eventData[4] == 1 then
      -- clicked the top row, handle it here
    else
      -- clicked in the window below it.
      eventData[4] = eventData[4] - 1
    end
  end

  if filter == nil or filter == eventData[1] or eventData[1] == "terminate" then
    -- redirect to the window
    local old = term.redirect(gui)

    -- resume the coroutine, collecting the next filter.
  	ok, filter = coroutine.resume(shellroutine, table.unpack(eventData, 1, eventData.n))
  	if not ok then 
  		term.redirect(old) 
  		return
  	end
    -- return terminal
    term.redirect(old)
  end
end