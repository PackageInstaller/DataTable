-- chunkname: @modules/logic/room/view/RoomBackBlockNumberItem.lua

module("modules.logic.room.view.RoomBackBlockNumberItem", package.seeall)

local RoomBackBlockNumberItem = class("RoomBackBlockNumberItem", LuaCompBase)

function RoomBackBlockNumberItem:init(go)
	self._go = go
	self._goTrs = go.transform
	self._txtnumber = gohelper.findChildText(go, "txt_number")
end

function RoomBackBlockNumberItem:getGO()
	return self._go
end

function RoomBackBlockNumberItem:getGOTrs()
	return self._goTrs
end

function RoomBackBlockNumberItem:setNumber(number)
	self._txtnumber.text = number
end

function RoomBackBlockNumberItem:setBlockMO(blockMO)
	self._blockMO = blockMO

	if self._blockMO then
		gohelper.setActive(self._go, true)
	else
		gohelper.setActive(self._go, false)
	end
end

function RoomBackBlockNumberItem:getBlockMO(blockMO)
	return self._blockMO
end

return RoomBackBlockNumberItem
