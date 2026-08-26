-- chunkname: @modules/logic/room/entity/comp/base/RoomBaseEffectKeyComp.lua

module("modules.logic.room.entity.comp.base.RoomBaseEffectKeyComp", package.seeall)

local RoomBaseEffectKeyComp = class("RoomBaseEffectKeyComp", LuaCompBase)

function RoomBaseEffectKeyComp:ctor(entity)
	self.entity = entity
	self._effectKey = entity:getMainEffectKey()
end

function RoomBaseEffectKeyComp:setEffectKey(key)
	self._effectKey = key
end

function RoomBaseEffectKeyComp:onRebuildEffectGO()
	return
end

function RoomBaseEffectKeyComp:onReturnEffectGO()
	return
end

function RoomBaseEffectKeyComp:onEffectReturn(key, res)
	if self._effectKey == key then
		self:onReturnEffectGO()
	end
end

function RoomBaseEffectKeyComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)

		self:onRebuildEffectGO()
	end
end

return RoomBaseEffectKeyComp
