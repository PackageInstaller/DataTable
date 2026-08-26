-- chunkname: @modules/logic/scene/survivalcollectionroom/comp/SurvivaCollectionRoomUnitComp.lua

module("modules.logic.scene.survivalcollectionroom.comp.SurvivaCollectionRoomUnitComp", package.seeall)

local SurvivaCollectionRoomUnitComp = class("SurvivaCollectionRoomUnitComp", BaseSceneComp)

function SurvivaCollectionRoomUnitComp:onScenePrepared(sceneId, levelId)
	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._unitRoot = gohelper.create3d(self._sceneGo, "UnitRoot")
	self._allUnits = {}

	local types = {
		SurvivalEnum.ShelterUnitType.Player,
		SurvivalEnum.ShelterUnitType.Build
	}

	for _, value in pairs(types) do
		self._allUnits[value] = {}
	end

	self._unitParent = {}
	self._unitType2Cls = {
		[SurvivalEnum.ShelterUnitType.Player] = SurvivalShelterPlayerEntity,
		[SurvivalEnum.ShelterUnitType.Build] = SurvivalShelterBuildingEntity
	}
	self.mapId = SurvivalModel.instance:getCollectionRoomMapId()

	self:refreshAllEntity()
end

function SurvivaCollectionRoomUnitComp:refreshAllEntity()
	self:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
	self:refreshBuild()
end

function SurvivaCollectionRoomUnitComp:refreshBuild()
	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	for i, v in ipairs(mapCo.allBuildings) do
		if v:isCollection() and self:isShowHandbookBuild(v.cfgId) then
			self:refreshEntity(SurvivalEnum.ShelterUnitType.Build, v.id, true)
		else
			local buildingInfo = weekInfo:getBuildingInfo(v.id)

			self:refreshEntity(SurvivalEnum.ShelterUnitType.Build, v.id, buildingInfo ~= nil)
		end
	end
end

function SurvivaCollectionRoomUnitComp:isShowHandbookBuild(id)
	local mo = SurvivalHandbookModel.instance:getHandbookByCollectionBuild(id)

	if mo then
		return mo.isUnlock
	end
end

function SurvivaCollectionRoomUnitComp:getEntity(unitType, unitId, createIfNotExist)
	local entity = self._allUnits[unitType][unitId]

	if not entity and createIfNotExist then
		local cls = self._unitType2Cls[unitType]
		local goParent = self:getUnitParentGO(unitType)

		entity = cls.Create(unitType, unitId, goParent)
	end

	return entity
end

function SurvivaCollectionRoomUnitComp:addEntity(unitType, unitId, entity)
	if not entity then
		return
	end

	self._allUnits[unitType][unitId] = entity
end

function SurvivaCollectionRoomUnitComp:delEntity(unitType, unitId)
	local entity = self:getEntity(unitType, unitId)

	if not entity then
		return
	end

	gohelper.destroy(entity.go)

	self._allUnits[unitType][unitId] = nil
end

function SurvivaCollectionRoomUnitComp:refreshEntity(unitType, unitId, isVisible)
	if isVisible then
		local entity = self:getEntity(unitType, unitId, true)

		entity:updateEntity()
	else
		self:delEntity(unitType, unitId)
	end
end

function SurvivaCollectionRoomUnitComp:getAllEntity()
	return self._allUnits
end

function SurvivaCollectionRoomUnitComp:getBuildEntity(id, createIfNotExist)
	return self:getEntity(SurvivalEnum.ShelterUnitType.Build, id, createIfNotExist)
end

function SurvivaCollectionRoomUnitComp:getUnitParentGO(unitType)
	local goParent = self._unitParent[unitType]

	if not goParent then
		goParent = gohelper.create3d(self._unitRoot, SurvivalEnum.ShelterUnitTypeToName[unitType])
		self._unitParent[unitType] = goParent
	end

	return goParent
end

function SurvivaCollectionRoomUnitComp:checkClickUnit(hexPoint)
	for unitType, dict in pairs(self._allUnits) do
		if unitType ~= SurvivalEnum.ShelterUnitType.Player then
			for unitId, v in pairs(dict) do
				if v:checkClick(hexPoint) then
					SurvivalMapHelper.instance:gotoUnit(unitType, unitId, hexPoint)
					SurvivalStatHelper.instance:statBtnClick(tostring(unitId), "SurvivalCollectionRoomView")

					return true
				end
			end
		end
	end
end

function SurvivaCollectionRoomUnitComp:getPlayer()
	return self:getEntity(SurvivalEnum.ShelterUnitType.Player, 0)
end

function SurvivaCollectionRoomUnitComp:onSceneClose()
	gohelper.destroy(self._unitRoot)

	self._unitRoot = nil
	self._sceneGo = nil
	self._allUnits = {}
end

return SurvivaCollectionRoomUnitComp
