-- chunkname: @modules/logic/room/model/record/RoomHandBookBackMo.lua

module("modules.logic.room.model.record.RoomHandBookBackMo", package.seeall)

local RoomHandBookBackMo = class("RoomHandBookBackMo")

function RoomHandBookBackMo:ctor()
	self._config = nil
	self.id = nil
	self.icon = nil
	self._isEmpty = false
	self._isNew = false
end

function RoomHandBookBackMo:init(mo)
	self._mo = mo
	self.id = mo.id
	self._config = ItemConfig.instance:getItemCo(self.id)
	self.icon = self._config.icon
end

function RoomHandBookBackMo:getConfig()
	return self._config
end

function RoomHandBookBackMo:checkNew()
	return self._isNew
end

function RoomHandBookBackMo:clearNewState()
	self._isNew = false
end

function RoomHandBookBackMo:isEmpty()
	return self._isEmpty
end

function RoomHandBookBackMo:setEmpty()
	self._isEmpty = true
	self.id = 0
end

function RoomHandBookBackMo:checkIsUse()
	local backgroundId = RoomHandBookModel.instance:getSelectMoBackGroundId()

	if backgroundId and backgroundId ~= 0 then
		return backgroundId == self.id
	elseif self._isEmpty then
		return true
	end

	return false
end

return RoomHandBookBackMo
