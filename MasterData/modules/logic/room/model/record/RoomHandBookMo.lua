-- chunkname: @modules/logic/room/model/record/RoomHandBookMo.lua

module("modules.logic.room.model.record.RoomHandBookMo", package.seeall)

local RoomHandBookMo = class("RoomHandBookMo")

function RoomHandBookMo:ctor()
	self._config = nil
	self.id = nil
end

function RoomHandBookMo:init(co)
	self._config = co
	self.id = co.id
	self._isreverse = false
	self._mo = RoomHandBookModel.instance:getMoById(self.id)
end

function RoomHandBookMo:getConfig()
	return self._config
end

function RoomHandBookMo:checkGotCritter()
	return not not self._mo
end

function RoomHandBookMo:getBackGroundId()
	if self._mo and self._mo.Background ~= 0 then
		return self._mo.Background
	end
end

function RoomHandBookMo:setBackGroundId(id)
	self._mo.Background = id
end

function RoomHandBookMo:checkUnlockSpeicalSkinById()
	if not self._mo then
		return
	end

	return self._mo.unlockSpecialSkin
end

function RoomHandBookMo:setSpeicalSkin(state)
	self._mo.UseSpecialSkin = state
end

function RoomHandBookMo:checkNew()
	if not self._mo then
		return
	end

	return self._mo.isNew
end

function RoomHandBookMo:clearNewState()
	self._mo.isNew = false
end

function RoomHandBookMo:setReverse(state)
	self._isreverse = state
end

function RoomHandBookMo:checkIsReverse()
	return self._isreverse
end

function RoomHandBookMo:checkShowMutate()
	if not self._mo then
		return false
	end

	return self._mo.unlockSpecialSkin and self._mo.unlockNormalSkin
end

function RoomHandBookMo:checkShowSpeicalSkin()
	if not self._mo then
		return false
	end

	return self._mo.UseSpecialSkin
end

return RoomHandBookMo
