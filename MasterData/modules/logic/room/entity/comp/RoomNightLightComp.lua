-- chunkname: @modules/logic/room/entity/comp/RoomNightLightComp.lua

module("modules.logic.room.entity.comp.RoomNightLightComp", package.seeall)

local RoomNightLightComp = class("RoomNightLightComp", LuaCompBase)

function RoomNightLightComp:ctor(entity)
	self.entity = entity
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
	self._isNight = RoomWeatherModel.instance:getIsNight()
end

function RoomNightLightComp:init(go)
	self.go = go
end

function RoomNightLightComp:setEffectKey(key)
	self._effectKey = key
end

function RoomNightLightComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.MapEntityNightLight, self._onNightLight, self)
end

function RoomNightLightComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.MapEntityNightLight, self._onNightLight, self)
end

function RoomNightLightComp:_onNightLight(isNight)
	if isNight ~= nil and self._isNight ~= isNight then
		self._isNight = isNight

		self:_updateNight()
	end
end

function RoomNightLightComp:_updateNight()
	local golist = self.entity.effect:getGameObjectsByName(self._effectKey, RoomEnum.EntityChildKey.NightLightGOKey)

	if golist then
		for i, tempGO in ipairs(golist) do
			gohelper.setActive(tempGO, self._isNight)
		end
	end
end

function RoomNightLightComp:beforeDestroy()
	return
end

function RoomNightLightComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)

		self:_updateNight()
	end
end

return RoomNightLightComp
