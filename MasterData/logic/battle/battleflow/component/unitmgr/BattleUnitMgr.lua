-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/unitmgr/BattleUnitMgr.lua

module("logic.battle.battleflow.component.unitmgr.BattleUnitMgr", package.seeall)

local BattleUnitMgr = class("BattleUnitMgr", IBattleFlowComp)
local kEmptyTable = {}

function BattleUnitMgr:onInit()
	self._campId2CampMO = false
	self._entityId2Unit = false
	self._forecastUnitList = false
	self._entityId2DeadUnit = false
end

function BattleUnitMgr:onStart()
	self._campId2CampMO = {}
	self._forecastUnitList = {}
	self._entityId2Unit = {}
	self._entityId2DeadUnit = {}
	self._resMgr = self.flow.resMgr or false
	self._boardModel = self.flow.boardModel or false
	self._model = self.flow.model or false
	self._additionalTerrainMgr = self.flow.additionalTerrainMgr or false
end

function BattleUnitMgr:onClear()
	if self._entityId2Unit then
		for _, unit in pairs(self._entityId2Unit) do
			self:removeUnit(unit)
			BattleUnitGenerator.destroyUnit(unit)
		end
	end

	if self._entityId2DeadUnit then
		for _, unit in pairs(self._entityId2DeadUnit) do
			BattleUnitGenerator.destroyUnit(unit)
		end
	end

	if self._campId2CampMO then
		for _, campMO in pairs(self._campId2CampMO) do
			campMO:returnSelf()
		end
	end

	self:removeAllForecastUnit()

	self._forecastUnit = false
	self._entityId2Unit = false
	self._entityId2DeadUnit = false
	self._campId2CampMO = false
	self._resMgr = false
	self._boardModel = false
	self._model = false
	self._additionalTerrainMgr = false
end

function BattleUnitMgr:onUndoReset()
	if self._entityId2Unit then
		for _, unit in pairs(self._entityId2Unit) do
			self:removeUnit(unit)
			BattleUnitGenerator.destroyUnit(unit, true)
		end
	end

	if self._entityId2DeadUnit then
		for _, unit in pairs(self._entityId2DeadUnit) do
			BattleUnitGenerator.destroyUnit(unit, true)
		end
	end
end

function BattleUnitMgr:onPreClear()
	self:onUndoReset()
end

function BattleUnitMgr:internal_BuildUnits()
	BattleBossPropertyFacade.instance:setUnit(false)

	local battleFieldInfo = self._model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos

	for _, entityInfo in pairs(entityInfos) do
		self:createUnit(entityInfo)
	end

	local cellInfos = battleFieldInfo.cellInfos

	self._additionalTerrainMgr:createTerrainUnits(cellInfos)
end

function BattleUnitMgr:onUpdateTimeScale()
	for _, unit in pairs(self._entityId2Unit) do
		unit:setTimeScale(BattleTime.timeScale)
	end
end

function BattleUnitMgr:createUnit(entityInfo)
	local unit = BattleUnitGenerator.createUnit(entityInfo)

	self:addUnit(unit)
	self:_processAfterAddUnit(unit, entityInfo)

	return unit
end

function BattleUnitMgr:_processAfterAddUnit(unit, entityInfo)
	if entityInfo.bornUnionIndex >= 0 then
		BattleUnitGenerator.setUnitToUnionIndex(unit, entityInfo.bornUnionIndex)
	end

	if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
		BattleBuffUtil.initUnitBuffEffect(unit)
		BattleUnitEffectUtil.initUnitStates(unit)
		BattleUnitEffectUtil.initUnitPropertyEffects(unit)
		MeshModelDirection.lookAtDirectionOrEnum(unit, entityInfo.lookAtDirection, entityInfo.direction)
	end

	if unit.property:getMonsterType() == BattleEnum.MonsterType.BOSS and not self.flow.model:getBossViewUnit() then
		unit:setIsInBossView(true)
		BattleBossPropertyFacade.instance:setUnit(unit)
	end

	if unit.property:isModelFuzzy() then
		RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH_MASK, true, unit.property:getEntityId())
	end
end

function BattleUnitMgr:_processAfterRemoveUnit(unit)
	if unit.property:isModelFuzzy() then
		RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH_MASK, false, unit.property:getEntityId())
	end
end

function BattleUnitMgr:getAllUnits()
	return self._entityId2Unit
end

function BattleUnitMgr:getUnit(entityId)
	if self._entityId2Unit then
		return self._entityId2Unit[entityId] or self._entityId2DeadUnit[entityId]
	end

	if BattleLog.enableLog then
		BattleLog.log("The component is cleared.")
	end
end

function BattleUnitMgr:getUnitByEntityCode(entityCode)
	for k, v in pairs(self._entityId2Unit) do
		if v.property:getEntityCode() == entityCode then
			return v
		end
	end
end

function BattleUnitMgr:getUnitByEntityCodeAndRelation(entityCode, relationType)
	for k, unit in pairs(self._entityId2Unit) do
		if unit.property:getEntityCode() == entityCode and relationType == BattleCampRelationUtil.getCampRelationWithOperateCamp(unit.property:getCampId()) then
			return unit
		end
	end
end

function BattleUnitMgr:getUnitByModelCode(modelCode)
	for k, v in pairs(self._entityId2Unit) do
		if v.property:getModelCode() == modelCode then
			return v
		end
	end
end

function BattleUnitMgr:getUnitByTag(entityTag)
	for k, v in pairs(self._entityId2Unit) do
		if v.property:containsTag(entityTag) then
			return v
		end
	end
end

function BattleUnitMgr:getUnitsByCampId(campId)
	local campMO = self._campId2CampMO[campId]

	return campMO and campMO:getUnits() or kEmptyTable
end

function BattleUnitMgr:getCamp(campId)
	return self._campId2CampMO[campId]
end

function BattleUnitMgr:getMyUnits(filter)
	local campId = self._model:getOperateCampId()
	local allUnits = self:getUnitsByCampId(campId)
	local entityIds = {}

	for _, unit in pairs(allUnits) do
		if filter then
			if unit.property:getEntityType() == BattleEnum.EntityType.Hero then
				table.insert(entityIds, unit.property:getEntityCode())
			end
		else
			table.insert(entityIds, unit.property:getEntityCode())
		end
	end

	return entityIds
end

function BattleUnitMgr:getAnyEmptyCamp()
	for campId, campMO in pairs(self._campId2CampMO) do
		if campMO:isEmpty() then
			return campId
		end
	end

	return false
end

function BattleUnitMgr:containsAnyRelationTypeCamp(relationType)
	for campId, campMO in pairs(self._campId2CampMO) do
		if not campMO:isEmpty() and BattleCampRelationUtil.getCampRelationWithOperateCamp(campId) == relationType then
			return true
		end
	end

	return false
end

function BattleUnitMgr:getUnitOnUnionIndex(unionIndex)
	if not unionIndex then
		return false
	end

	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	if not cellMO then
		if BattleLog.enableError then
			BattleLog.error(string.format("BattleUnitMgr::cannot find CellMO[%s]", unionIndex))
		end

		return false
	end

	return self:getUnit(cellMO:getOwnerEntityId())
end

function BattleUnitMgr:addUnit(unit)
	local entityId = unit.property:getEntityId()

	if enableDebug and self._entityId2Unit[entityId] and BattleLog.enableError then
		BattleLog.error("BattleUnitMgr::already has entity entityId[%s]", entityId)
	end

	local campId = unit.property:getCampId()
	local campMO = self._campId2CampMO[campId]

	if not campMO then
		campMO = BattleCampMO:createInstance(campId)
		self._campId2CampMO[campId] = campMO
	end

	campMO:addUnit(unit)

	self._entityId2Unit[entityId] = unit

	unit:dispatchCompInitFinish()

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleUnitMgr::add unit: %s", entityId))
	end
end

function BattleUnitMgr:removeUnit(unit)
	local entityId = unit.property:getEntityId()
	local campId = unit.property:getCampId()
	local campMO = self._campId2CampMO[campId]

	if not campMO then
		if BattleLog.enableError then
			BattleLog.error(string.format("BattleUnitMgr::cannot find CampMO for campId[%s]", campId))
		end
	else
		campMO:removeUnit(unit)
	end

	self._entityId2Unit[entityId] = nil

	self:_processAfterRemoveUnit(unit)

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleUnitMgr::remove unit: %s", entityId))
	end
end

function BattleUnitMgr:addDeadUnit(unit)
	local entityId = unit.property:getEntityId()

	self._entityId2DeadUnit[entityId] = unit
end

function BattleUnitMgr:removeDeadUnit(unit, isSilent)
	local entityId = unit.property:getEntityId()

	self._entityId2DeadUnit[entityId] = nil

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleUnitMgr::remove dead unit: %s", entityId))
	end
end

function BattleUnitMgr:isDeadPerformanceEmpty()
	for _, unit in pairs(self._entityId2DeadUnit) do
		if not unit.dieHandler:isPerformanced() then
			return false
		end
	end

	return true
end

function BattleUnitMgr:isDeadUnit(entityId)
	return self._entityId2DeadUnit[entityId] and true or false
end

function BattleUnitMgr:internal_ClearAllDeadUnit()
	local waitDestroyUnitList = BattleTableUtil.getTempList()

	for _, unit in pairs(self._entityId2DeadUnit) do
		if unit.dieHandler:isPerformanced() then
			table.insert(waitDestroyUnitList, unit)
		end
	end

	for _, unit in ipairs(waitDestroyUnitList) do
		BattleUnitGenerator.destroyUnit(unit)
	end

	BattleTableUtil.releaseTempList(waitDestroyUnitList)
end

function BattleUnitMgr:createForecastUnit(sourceUnit, unionIndex, key)
	local key = key or BattleEnum.ForecastUnitType.Move
	local sProperty = sourceUnit.property
	local unit = BattleUnit:createInstance(sProperty:getEntityId())

	unit:delayShowModel(0.175)
	unit.property:setEntityId(sProperty:getEntityId())
	unit.property:setEntityType(sProperty:getEntityType())
	unit.property:setEntityCode(sProperty:getEntityCode())

	local modelId = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	unit.mover:setSpeed(5)
	unit.uiProxy:setVisible(false)
	unit.sceneProxy:setVisible(false)
	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))
	BattleUnitGenerator.addUnitToScene(unit)
	unit:setTimeScale(BattleTime.timeScale)
	unit.meshModelMover:playIdle()
	unit.meshModel:jumpToTime(math.random())

	local goAvatar = unit.mountRoot:getAvatarRoot()
	local transAvatar = goAvatar.transform
	local positionOffsets = ModelCOUtil.getPositionOffsets(modelCO)

	if positionOffsets then
		Astral.TransformUtil.SetLocalPos(transAvatar, positionOffsets[1], BattleConst.YOffsetAvatar, positionOffsets[2])
	else
		Astral.TransformUtil.SetLocalPos(transAvatar, 0, BattleConst.YOffsetAvatar, 0)
	end

	unit.material:switchMaterial(BattleResourceName.ForecastUnitMaterial, true)
	unit.material:turnOnLayerMask(RenderingLayerMask.Layer9)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH_MASK, true, BattleConst.DefaultStateKey)

	if key == BattleEnum.ForecastUnitType.Move then
		sourceUnit.property:setForecastUnit(unit)
	elseif key == BattleEnum.ForecastUnitType.Transport then
		sourceUnit.property:setTransportForecastUnit(unit)
	end

	unit.property:setSourceUnit(sourceUnit)
	unit.effectPlayer:playEffect(BattleConst.EFFECT_CREATE_FORECAST_UNIT)
	unit.uiProxy:rebuildUI()
	unit.uiProxy:setCenterVisible(true)

	self._forecastUnitList[key] = unit

	return unit
end

function BattleUnitMgr:removeForecastUnit(key)
	local key = key or BattleEnum.ForecastUnitType.Move
	local unit = self._forecastUnitList[key]

	if not unit then
		return
	end

	unit.material:turnOffLayerMask(RenderingLayerMask.Layer9)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.GLITCH_MASK, false, BattleConst.DefaultStateKey)

	local sourceUnit = unit.property:getSourceUnit()

	if sourceUnit then
		if key == BattleEnum.ForecastUnitType.Move then
			sourceUnit.property:setForecastUnit(false)
		elseif key == BattleEnum.ForecastUnitType.Transport then
			sourceUnit.property:setTransportForecastUnit(false)
		end
	end

	unit:returnSelf()

	self._forecastUnitList[key] = nil
end

function BattleUnitMgr:removeAllForecastUnit()
	for key, unit in pairs(self._forecastUnitList) do
		self:removeForecastUnit(key)
	end

	BattleTableUtil.clearTable(self._forecastUnitList)
end

function BattleUnitMgr:getForecastUnit(key)
	local key = key or BattleEnum.ForecastUnitType.Move

	return self._forecastUnitList and self._forecastUnitList[key]
end

return BattleUnitMgr
