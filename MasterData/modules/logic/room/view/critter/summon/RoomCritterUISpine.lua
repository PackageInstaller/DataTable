-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterUISpine.lua

module("modules.logic.room.view.critter.summon.RoomCritterUISpine", package.seeall)

local RoomCritterUISpine = class("RoomCritterUISpine", LuaCompBase)

function RoomCritterUISpine.Create(go)
	local agent

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterUISpine))
end

function RoomCritterUISpine:init(go)
	self._go = go
end

function RoomCritterUISpine:_getSpine()
	self._spine = self._spine or GuiSpine.Create(self._go)

	return self._spine
end

function RoomCritterUISpine:resetTransform()
	if not self._spine then
		return
	end

	local go = self._spine._spineGo

	if gohelper.isNil(go) then
		return
	end

	recthelper.setAnchor(go.transform, 0, 0)
	transformhelper.setLocalScale(go.transform, 1, 1, 1)
end

function RoomCritterUISpine:setResPath(critterMo, loadedCb, loadedCbObj)
	local skinId = critterMo:getSkinId()
	local res = RoomResHelper.getCritterUIPath(skinId)

	self._curModel = self:_getSpine()

	self._curModel:setHeroId(critterMo.id)
	self._curModel:showModel()
	self._curModel:setResPath(res, function()
		self:resetTransform()

		if loadedCb then
			loadedCb(loadedCbObj)
		end
	end, self, true)
end

function RoomCritterUISpine:stopVoice()
	if self._spine then
		self._spine:stopVoice()
	end
end

function RoomCritterUISpine:onDestroyView()
	if self._spine then
		self._spine:stopVoice()

		self._spine = nil
	end
end

return RoomCritterUISpine
