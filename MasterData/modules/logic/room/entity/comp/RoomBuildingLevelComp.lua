-- chunkname: @modules/logic/room/entity/comp/RoomBuildingLevelComp.lua

module("modules.logic.room.entity.comp.RoomBuildingLevelComp", package.seeall)

local RoomBuildingLevelComp = class("RoomBuildingLevelComp", LuaCompBase)

function RoomBuildingLevelComp:ctor(entity)
	self.entity = entity
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
	self._levelPathDict = {}
end

function RoomBuildingLevelComp:init(go)
	self.go = go
	self._level = self:_getLevel()
end

function RoomBuildingLevelComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUpPush, self)
end

function RoomBuildingLevelComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUpPush, self)
end

function RoomBuildingLevelComp:beforeDestroy()
	self:removeEventListeners()
end

function RoomBuildingLevelComp:_onBuildingLevelUpPush()
	self:refreshLevel()
end

function RoomBuildingLevelComp:refreshLevel()
	local level = self:_getLevel()

	if self._level ~= level then
		self._level = level

		self.entity:refreshBuilding()
		self:_updateLevel()
	end
end

function RoomBuildingLevelComp:_updateLevel()
	local mo = self:getMO()

	if not mo then
		return
	end

	local effect = self.entity.effect

	if not effect:isHasEffectGOByKey(self._effectKey) then
		return
	end

	local levelCfgDict = RoomConfig.instance:getLevelGroupLevelDict(mo.buildingId)

	for level, cfg in pairs(levelCfgDict) do
		self._levelPathDict[level] = self._levelPathDict[level] or string.format(RoomEnum.EffectPath.BuildingLevelPath, level)

		local levelGO = effect:getGameObjectByPath(self._effectKey, self._levelPathDict[level])

		if levelGO then
			gohelper.setActive(levelGO, level <= self._level)
		end
	end
end

function RoomBuildingLevelComp:_getLevel()
	local mo = self:getMO()

	return mo.level or 0
end

function RoomBuildingLevelComp:getMO()
	return self.entity:getMO()
end

function RoomBuildingLevelComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)
		self._level = self:_getLevel()

		self:_updateLevel()
	end
end

return RoomBuildingLevelComp
