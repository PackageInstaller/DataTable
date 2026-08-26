-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneMapUnitComp.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneMapUnitComp", package.seeall)

local SurvivalShelterSceneMapUnitComp = class("SurvivalShelterSceneMapUnitComp", BaseSceneComp)

function SurvivalShelterSceneMapUnitComp:onScenePrepared()
	self._sceneGo = self:getCurScene().level:getSceneGo()
	self._unitRoot = gohelper.create3d(self._sceneGo, "UnitRoot")
	self._allUnits = {}

	for _, value in pairs(SurvivalEnum.ShelterUnitType) do
		self._allUnits[value] = {}
	end

	self._unitParent = {}
	self._unitType2Cls = {
		[SurvivalEnum.ShelterUnitType.Npc] = SurvivalShelterNpcEntity,
		[SurvivalEnum.ShelterUnitType.Monster] = SurvivalShelterMonsterEntity,
		[SurvivalEnum.ShelterUnitType.Player] = SurvivalShelterPlayerEntity,
		[SurvivalEnum.ShelterUnitType.Build] = SurvivalShelterBuildingEntity
	}

	self:addEvents()
	self:refreshAllEntity()
end

function SurvivalShelterSceneMapUnitComp:refreshAllEntity()
	self:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
	self:refreshMonster()
	self:refreshNpcList()
	self:refreshBuild()
end

function SurvivalShelterSceneMapUnitComp:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnRecruitDataUpdate, self.onBuildingInfoUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnWeekInfoUpdate, self.onWeekInfoUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.AbandonFight, self.refreshMonster, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.BossFightSuccessShowFinish, self.refreshMonster, self)
end

function SurvivalShelterSceneMapUnitComp:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnRecruitDataUpdate, self.onBuildingInfoUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNpcPostionChange, self.onNpcPostionChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnWeekInfoUpdate, self.onWeekInfoUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.AbandonFight, self.refreshMonster, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.BossFightSuccessShowFinish, self.refreshMonster, self)
end

function SurvivalShelterSceneMapUnitComp:onWeekInfoUpdate()
	self:refreshAllEntity()
end

function SurvivalShelterSceneMapUnitComp:onBuildingInfoUpdate(buildingId)
	if buildingId then
		local entity = self:getEntity(SurvivalEnum.ShelterUnitType.Build, buildingId, true)

		if entity then
			entity:showBuildEffect()
		end

		return
	end

	self:refreshBuild()
	self:refreshNpcList()
end

function SurvivalShelterSceneMapUnitComp:onNpcPostionChange()
	self:refreshNpcList()
end

function SurvivalShelterSceneMapUnitComp:getPlayer()
	return self:getEntity(SurvivalEnum.ShelterUnitType.Player, 0)
end

function SurvivalShelterSceneMapUnitComp:refreshBuild()
	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	for i, v in ipairs(mapCo.allBuildings) do
		local buildingInfo = weekInfo:getBuildingInfo(v.id)

		self:refreshEntity(SurvivalEnum.ShelterUnitType.Build, v.id, buildingInfo ~= nil)
	end
end

function SurvivalShelterSceneMapUnitComp:getBuildEntity(id, createIfNotExist)
	return self:getEntity(SurvivalEnum.ShelterUnitType.Build, id, createIfNotExist)
end

function SurvivalShelterSceneMapUnitComp:refreshNpcList()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local dict = weekInfo.npcDict
	local shelterCfg = SurvivalConfig.instance:getShelterCfg()
	local maxNpcNum = 30

	if not string.nilorempty(shelterCfg.maxNpcNum) then
		maxNpcNum = tonumber(shelterCfg.maxNpcNum)
	end

	local list = {}

	for i, v in pairs(dict) do
		table.insert(list, v)
	end

	table.sort(list, self.npcShowSort)

	maxNpcNum = math.min(maxNpcNum, #list)

	for i = 1, maxNpcNum do
		local id = list[i].id
		local canShow = weekInfo:canShowNpcInShelter(id)

		self:refreshEntity(SurvivalEnum.ShelterUnitType.Npc, id, canShow)
	end
end

function SurvivalShelterSceneMapUnitComp.npcShowSort(a, b)
	local aId = a.id
	local bId = b.id
	local aCo = SurvivalConfig.instance:getNpcConfig(aId)
	local bCo = SurvivalConfig.instance:getNpcConfig(bId)

	return aCo.rare > bCo.rare
end

function SurvivalShelterSceneMapUnitComp:getNpcEntity(id, createIfNotExist)
	return self:getEntity(SurvivalEnum.ShelterUnitType.Npc, id, createIfNotExist)
end

function SurvivalShelterSceneMapUnitComp:addUsedPos(dict, isJumpPlayer)
	if not isJumpPlayer then
		local player = self:getPlayer()

		if player then
			local node = player:getPos()

			if node then
				SurvivalHelper.instance:addNodeToDict(dict, node)
			end
		end
	end

	for k, v in pairs(self._allUnits[SurvivalEnum.ShelterUnitType.Monster]) do
		if v.ponitRange then
			for q, vv in pairs(v.ponitRange) do
				for r, node in pairs(vv) do
					SurvivalHelper.instance:addNodeToDict(dict, node)
				end
			end
		end
	end

	for k, v in pairs(self._allUnits[SurvivalEnum.ShelterUnitType.Npc]) do
		local node = v.pos

		if node then
			SurvivalHelper.instance:addNodeToDict(dict, node)
		end
	end
end

function SurvivalShelterSceneMapUnitComp:checkClickUnit(hexPoint)
	for unitType, dict in pairs(self._allUnits) do
		if unitType ~= SurvivalEnum.ShelterUnitType.Player then
			for unitId, v in pairs(dict) do
				if v:checkClick(hexPoint) then
					SurvivalMapHelper.instance:gotoUnit(unitType, unitId, hexPoint)

					return true
				end
			end
		end
	end
end

function SurvivalShelterSceneMapUnitComp:refreshMonster()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local masterFight = weekInfo:getMonsterFight()

	if masterFight then
		local canShow = masterFight:canShowEntity()
		local needShowDestroy, fightId = SurvivalShelterModel.instance:getNeedShowFightSuccess()

		if canShow or fightId == nil then
			fightId = masterFight.fightId
		end

		if SurvivalController.instance.isOldSettle then
			if needShowDestroy then
				local popLayer = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

				gohelper.setActive(popLayer, false)
				PopupController.instance:setPause(ViewName.SurvivalGetRewardView, true)
				SurvivalModel.instance:addDebugSettleStr("refreshMonster 1")
			end

			self:refreshEntity(SurvivalEnum.ShelterUnitType.Monster, fightId, canShow or needShowDestroy)

			if needShowDestroy ~= nil and not needShowDestroy then
				local popLayer = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

				gohelper.setActive(popLayer, true)
				PopupController.instance:setPause(ViewName.SurvivalGetRewardView, false)
				self:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
				SurvivalController.instance:dispatchEvent(SurvivalEvent.BossPerformFinish)
				SurvivalModel.instance:addDebugSettleStr("refreshMonster 2")
				SurvivalShelterModel.instance:setNeedShowFightSuccess(nil, nil)
			end
		else
			self:refreshEntity(SurvivalEnum.ShelterUnitType.Monster, fightId, canShow or needShowDestroy)
		end
	end
end

function SurvivalShelterSceneMapUnitComp:getMonsterEntity(id, createIfNotExist)
	return self:getEntity(SurvivalEnum.ShelterUnitType.Monster, id, createIfNotExist)
end

function SurvivalShelterSceneMapUnitComp:getEntity(unitType, unitId, createIfNotExist)
	local entity = self._allUnits[unitType][unitId]

	if not entity and createIfNotExist then
		local cls = self._unitType2Cls[unitType]
		local goParent = self:getUnitParentGO(unitType)

		entity = cls.Create(unitType, unitId, goParent)
	end

	return entity
end

function SurvivalShelterSceneMapUnitComp:addEntity(unitType, unitId, entity)
	if not entity then
		return
	end

	self._allUnits[unitType][unitId] = entity
end

function SurvivalShelterSceneMapUnitComp:delEntity(unitType, unitId)
	local entity = self:getEntity(unitType, unitId)

	if not entity then
		return
	end

	gohelper.destroy(entity.go)

	self._allUnits[unitType][unitId] = nil
end

function SurvivalShelterSceneMapUnitComp:refreshEntity(unitType, unitId, isVisible)
	if isVisible then
		local entity = self:getEntity(unitType, unitId, true)

		entity:updateEntity()
	else
		self:delEntity(unitType, unitId)
	end
end

function SurvivalShelterSceneMapUnitComp:getAllEntity()
	return self._allUnits
end

function SurvivalShelterSceneMapUnitComp:getEntityDict(unitType)
	for _unityType, entityDict in pairs(self._allUnits) do
		if _unityType == unitType then
			return entityDict
		end
	end
end

function SurvivalShelterSceneMapUnitComp:getShelterMonster()
	local dic = self:getEntityDict(SurvivalEnum.ShelterUnitType.Monster)

	for i, v in pairs(dic) do
		return v
	end
end

function SurvivalShelterSceneMapUnitComp:getUnitParentGO(unitType)
	local goParent = self._unitParent[unitType]

	if not goParent then
		goParent = gohelper.create3d(self._unitRoot, SurvivalEnum.ShelterUnitTypeToName[unitType])
		self._unitParent[unitType] = goParent
	end

	return goParent
end

function SurvivalShelterSceneMapUnitComp:onSceneClose()
	self:removeEvents()
	gohelper.destroy(self._unitRoot)

	self._unitRoot = nil
	self._sceneGo = nil
	self._allUnits = {}
end

return SurvivalShelterSceneMapUnitComp
