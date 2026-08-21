-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/BattleCompForecastDrawing.lua

module("logic.battle.battleflow.component.forecast.BattleCompForecastDrawing", package.seeall)

local BattleCompForecastDrawing = class("BattleCompForecastDrawing", IBattleFlowComp)
local kDeltaLineY = 0
local kAiForecastType = {
	IWillAttackWhichOne = 2,
	WhoWillAttackMe = 1,
	All = 3,
	None = 0
}
local kColorDisable = "#FFFFFF00"

function BattleCompForecastDrawing:onInit()
	self._aiAttackLineList = {}
	self._forecastTargetUnits = {}
	self._skillTargetUnits = {}
end

function BattleCompForecastDrawing:onStart()
	self:_setEvent(true)

	self._settingModel = self.flow.settingModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._boardMgr = self.flow.boardMgr or false
	self._pathFinder = self.flow.sharedPathFinder or false
	self._model = self.flow.model or false
	self._aiForecastMgr = self.flow.aiForecastMgr or false
	self._pathArrow = self.flow.pathArrow or false
	self._sharedPathFinder = self.flow.sharedPathFinder or false
	self._unitOperator = self.flow.unitOperator or false
	self._aiForecastType = kAiForecastType.None
	self._unit = false
	self._forecastKey = false
	self._transportUnit = false
end

function BattleCompForecastDrawing:onClear()
	self:_setEvent(false)
	self:_clearAllAiAttackLine()
	BattleTableUtil.clearTable(self._forecastTargetUnits)
	BattleTableUtil.clearTable(self._skillTargetUnits)

	self._settingModel = false
	self._unitMgr = false
	self._boardMgr = false
	self._pathFinder = false
	self._model = false
	self._aiForecastMgr = false
	self._unitOperator = false
	self._aiForecastType = false
	self._unit = false
	self._forecastKey = false
	self._pathArrow = false
	self._sharedPathFinder = false
	self._transportUnit = false
end

function BattleCompForecastDrawing:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_SWITCH_AI_FORECAST, self._onSwitchAIForecast, self)
		BattleDispatcher:addEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnAiForecastResultUpdate, self._onAiForecastResultUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_SWITCH_AI_FORECAST, self._onSwitchAIForecast, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnAiForecastResultUpdate, self._onAiForecastResultUpdate, self)
	end
end

function BattleCompForecastDrawing:onUpdateTimeScale()
	for _, line in pairs(self._aiAttackLineList) do
		line:setPlaySpeed(BattleTime.timeScale)
	end
end

function BattleCompForecastDrawing:forecastWhoWillAttackMe(unit)
	self:_clearAllAiAttackLine()

	self._unit = unit
	self._aiForecastType = kAiForecastType.WhoWillAttackMe

	self:_updateAiForecast()
end

function BattleCompForecastDrawing:forecastIWillAttackWhichOne(unit)
	self:_clearAllAiAttackLine()

	self._unit = unit
	self._aiForecastType = kAiForecastType.IWillAttackWhichOne

	self:_updateAiForecast()
end

function BattleCompForecastDrawing:forecastAllAi()
	self:_clearAllAiAttackLine()

	self._unit = false
	self._aiForecastType = kAiForecastType.All

	self:_updateAiForecast()
end

function BattleCompForecastDrawing:updateAiForecast()
	self:_clearAllAiAttackLine()
	self:_updateAiForecast()
end

function BattleCompForecastDrawing:clearAllAiForecast()
	self._unit = false
	self._aiForecastType = false

	self:_clearAllAiAttackLine()
end

function BattleCompForecastDrawing:drawForecastResult(forecastResult)
	if not forecastResult.isValid then
		return
	end

	if self._forecastKey == forecastResult.forecastKey then
		return
	end

	self:_clearForecastResult()

	self._forecastKey = forecastResult.forecastKey

	local unitMgr = self._unitMgr
	local entityInfo = forecastResult.victimEntityInfo
	local unit = unitMgr:getUnit(entityInfo.entityId)

	if unit then
		unit.uiProxy:forecast(entityInfo)
		unit.sceneProxy:forecast(entityInfo)
		table.insert(self._forecastTargetUnits, unit)
	end

	local secondaryTargetEntityInfoList = forecastResult.secondaryTargetEntityInfoList

	if #secondaryTargetEntityInfoList > 0 then
		for _, entityInfo in ipairs(secondaryTargetEntityInfoList) do
			local unit = unitMgr:getUnit(entityInfo.entityId)

			unit.uiProxy:forecast(entityInfo)
			unit.sceneProxy:forecast(entityInfo)
			table.insert(self._forecastTargetUnits, unit)
		end
	end

	local hasReleaseSkill = forecastResult:hasReleaseSkill()
	local entityInfo = forecastResult.attackerEntityInfo
	local unit = unitMgr:getUnit(entityInfo.entityId)

	if hasReleaseSkill and unit then
		unit.uiProxy:forecast(entityInfo)
		unit.sceneProxy:forecast(entityInfo)
		table.insert(self._forecastTargetUnits, unit)
	end

	self:_signTargetUnits(forecastResult)
	self._unitOperator:internal_onForecastResultUpdate()
end

function BattleCompForecastDrawing:_signTargetUnits(forecastResult)
	local skillId = forecastResult.skillId

	if not skillId then
		return
	end

	local unitMgr = self._unitMgr
	local attackerEntityInfo = forecastResult.attackerEntityInfo
	local attackerUnit = unitMgr:getUnit(attackerEntityInfo.entityId)

	if BattleSkillAssist.isAoeSkill(skillId, attackerUnit.skill:getSkillStatus()) then
		self:_clearTargetUnits()

		local skillMO = attackerUnit.skill:getActiveSkillById(skillId)

		if not skillMO then
			return
		end

		local targetIdList = BattleTableUtil.getTempList()

		table.insert(targetIdList, forecastResult.victimEntityInfo.entityId)

		for i, entityInfo in ipairs(forecastResult.secondaryTargetEntityInfoList) do
			table.insert(targetIdList, entityInfo.entityId)
		end

		for i, entityId in ipairs(targetIdList) do
			local unit = unitMgr:getUnit(entityId)

			if unit then
				table.insert(self._skillTargetUnits, unit)
			end
		end

		BattleTableUtil.releaseTempList(targetIdList)
	else
		local unit = unitMgr:getUnit(forecastResult.victimEntityInfo.entityId)

		table.insert(self._skillTargetUnits, unit)
	end

	local isBlueSign = BattleSkillAssist.judgeAttackableCellSign(skillId, attackerUnit.skill:getSkillStatus())

	self:_drawTargetUnits(isBlueSign)
end

function BattleCompForecastDrawing:_drawTargetUnits(isBlueSign)
	for i, unit in ipairs(self._skillTargetUnits) do
		local forecastUnit = BattleUnitUtil.getUnitInForecast(unit)

		forecastUnit.material:killAll(true)

		local tween = forecastUnit.material:doLuminance(1, 2, 1)

		if tween then
			tween:SetLoops(-1)
		end

		if isBlueSign then
			forecastUnit.material:setCustomColor2("#33D966CC")
			forecastUnit.material:doCustomAlphaLoop(0.1, 1.6)
		else
			forecastUnit.material:setCustomColor2("#FF4C4CCC")
			forecastUnit.material:doCustomAlphaLoop(0.1, 1.6)
		end
	end
end

function BattleCompForecastDrawing:drawTransportUnit(unit)
	self._transportUnit = unit

	unit.material:killAll(true)

	local tween = unit.material:doLuminance(1, 2, 1)

	if tween then
		tween:SetLoops(-1)
	end

	unit.material:setCustomColor2("#33D966BB")
	unit.material:doCustomAlphaLoop(0, 2)
end

function BattleCompForecastDrawing:clearTransportUnit()
	if self._transportUnit then
		local unit = self._transportUnit

		unit.material:killAll(true)
		unit.material:doLuminance(1, 1, 0)
		unit.material:setCustomColor2(kColorDisable)

		if unit.property:getForecastUnit() then
			local forecastUnit = unit.property:getForecastUnit()

			forecastUnit.material:killAll(true)
			forecastUnit.material:doLuminance(1, 1, 0)
			forecastUnit.material:setCustomColor2(kColorDisable)
		end

		self._transportUnit = false
	end
end

function BattleCompForecastDrawing:_clearTargetUnits()
	if #self._skillTargetUnits <= 0 then
		return
	end

	for _, unit in pairs(self._skillTargetUnits) do
		unit.material:killAll(true)
		unit.material:doLuminance(1, 1, 0)
		unit.material:setCustomColor2(kColorDisable)

		if unit.property:getForecastUnit() then
			local forecastUnit = unit.property:getForecastUnit()

			forecastUnit.material:killAll(true)
			forecastUnit.material:doLuminance(1, 1, 0)
			forecastUnit.material:setCustomColor2(kColorDisable)
		end
	end

	BattleTableUtil.clearTable(self._skillTargetUnits)
end

function BattleCompForecastDrawing:clearForecastResult()
	self._forecastKey = false

	self:_clearForecastResult()
end

function BattleCompForecastDrawing:_clearForecastResult()
	for _, unit in ipairs(self._forecastTargetUnits) do
		unit.uiProxy:clearForecast()
		unit.sceneProxy:clearForecast()
	end

	BattleTableUtil.clearTable(self._forecastTargetUnits)
	self:_clearTargetUnits()
end

function BattleCompForecastDrawing:_onForecastResultUpdate(evt, forecastResult)
	self:drawForecastResult(forecastResult)
end

function BattleCompForecastDrawing:_onAiForecastResultUpdate(evt, forecastResult)
	self:_clearAllAiAttackLine()
	self:_updateAiForecast()
end

function BattleCompForecastDrawing:_onSwitchAIForecast(evt, isEnable)
	self:_clearAllAiAttackLine()
	self:_updateAiForecast()
end

function BattleCompForecastDrawing:_updateAiForecast()
	if not self._settingModel:isEnableAIForecast() then
		return
	end

	local forecastResult = self._aiForecastMgr:getActiveForecastResult()

	if not forecastResult or not forecastResult.isValid then
		return
	end

	if self._aiForecastType == kAiForecastType.WhoWillAttackMe then
		local entityId = self._unit.property:getEntityId()
		local aiForecastMOList = forecastResult.aiForecastMOList

		for _, aiForecastMO in ipairs(aiForecastMOList) do
			if aiForecastMO:isVictim(entityId) then
				self:_drawAiForecastLink(aiForecastMO)
			end
		end
	elseif self._aiForecastType == kAiForecastType.IWillAttackWhichOne then
		local entityId = self._unit.property:getEntityId()
		local aiForecastMOList = forecastResult.aiForecastMOList

		for _, aiForecastMO in ipairs(aiForecastMOList) do
			if aiForecastMO:isAttacker(entityId) then
				self:_drawAiForecastLink(aiForecastMO)
			end
		end
	elseif self._aiForecastType == kAiForecastType.All then
		local aiForecastMOList = forecastResult.aiForecastMOList

		for _, aiForecastMO in ipairs(aiForecastMOList) do
			self:_drawAiForecastLink(aiForecastMO)
		end
	end
end

function BattleCompForecastDrawing:_drawAiForecastLink(aiForecastMO)
	local fromUnit = self._unitMgr:getUnit(aiForecastMO.fromEntityId)
	local toUnit = self._unitMgr:getUnit(aiForecastMO.toEntityId)

	if not fromUnit or not toUnit then
		return
	end

	local fx, fy, fz = BattleUnitUtil.getUnitCellCenterPos(fromUnit)
	local tx, ty, tz = BattleUnitUtil.getUnitCellCenterPos(toUnit)
	local line = ForecastCurveLine:createInstance()

	line:setStartPositionXYZ(fx, fy + kDeltaLineY, fz)
	line:setEndPositionXYZ(tx, ty + kDeltaLineY, tz)
	line:setPlaySpeed(BattleTime.timeScale)
	line:seLineWidth(0.1)
	line:rebuild()
	table.insert(self._aiAttackLineList, line)
end

function BattleCompForecastDrawing:_clearAllAiAttackLine()
	BattleTableUtil.clearReusableTable(self._aiAttackLineList)
end

function BattleCompForecastDrawing:onLeaveScene()
	for _, line in ipairs(self._aiAttackLineList or {}) do
		line:reset()
	end
end

function BattleCompForecastDrawing:onReturnScene()
	for _, line in ipairs(self._aiAttackLineList or {}) do
		line:reuse()
	end
end

return BattleCompForecastDrawing
