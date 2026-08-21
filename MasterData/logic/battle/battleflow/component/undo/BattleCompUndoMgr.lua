-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/undo/BattleCompUndoMgr.lua

module("logic.battle.battleflow.component.undo.BattleCompUndoMgr", package.seeall)

local BattleCompUndoMgr = class("BattleCompUndoMgr", IBattleFlowComp)
local kLocalSettingKey = "BattleCompUndoMgr"

function BattleCompUndoMgr:onInit()
	self._undoList = BattleUndoMOList.New()
	self._battleInfoNOCache = BattleUndoInfoNOCache.New()
end

function BattleCompUndoMgr:onStart()
	self:_setEvent(true)

	self._model = self.flow.model or false
	self._unitMgr = self.flow.unitMgr or false
	self._cmdExecuter = self.flow.cmdExecuter or false
	self._scenePickerHandler = self.flow.scenePickerHandler or false
	self._assistantSystemMgr = self.flow.assistantSystemMgr or false

	self._undoList:initializeUndoMOList()
	self._battleInfoNOCache:initialize()
end

function BattleCompUndoMgr:onClear(isRestart)
	self:_setEvent(false)

	self._model = false
	self._unitMgr = false
	self._cmdExecuter = false
	self._scenePickerHandler = false
	self._assistantSystemMgr = false

	self._undoList:clear()
	self._battleInfoNOCache:clear()
end

function BattleCompUndoMgr:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnUndoBattlefieldUpdate, self._onUndoBattlefieldUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_BACK_TO, self._onReceiveBackTo, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnUndoBattlefieldUpdate, self._onUndoBattlefieldUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_BACK_TO, self._onReceiveBackTo, self)
	end
end

function BattleCompUndoMgr:getUndoMOList()
	return self._undoList:getUndoMOList()
end

function BattleCompUndoMgr:recordEntitySteppedEvent(entitySteppedEventNO)
	local round = entitySteppedEventNO.round

	if round > 1 then
		return
	end

	self._undoList:recordEntitySteppedEvent(entitySteppedEventNO)
end

function BattleCompUndoMgr:recordRoundStartedEvent(round)
	self._undoList:recordRoundStartedEvent(round)
end

function BattleCompUndoMgr:previewUndo(round, step, enableCache)
	local battleInfoNO = self._battleInfoNOCache:getBattleInfoNO(round, step, enableCache)

	if battleInfoNO then
		self:_applyBattleInfoNO(battleInfoNO)
	end
end

function BattleCompUndoMgr:cancelUndo()
	local undoMO = self._undoList:getLastUndoMO()

	self:previewUndo(undoMO:getRound(), undoMO:getStep() + 1, true)
	self._cmdExecuter:addCommand(BattlePostEventAnimationCommand:createInstance())
	self._cmdExecuter:submit()
end

function BattleCompUndoMgr:confirmUndo(round, step)
	BattleDispatcher:dispatchEvent(BattleEventType.OnConfirmUndo)
	BattleAgent.instance:sendBackToRequest(round, step)
end

function BattleCompUndoMgr:setupUndoEnvironment()
	BattleMainViewFacade.instance:setLeftTopViewVisible(false, kLocalSettingKey)
	BattleMainViewFacade.instance:setCenterTopViewVisible(false, kLocalSettingKey)
	BattleMainViewFacade.instance:setForMoving(kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Auto, false, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Speed, false, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Setting, false, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.RoundFinish, false, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.DangerZone, false, kLocalSettingKey)
	BattleRoundReportViewFacade.instance:resetReportView()
	BattleBossPropertyFacade.instance:setVisible(false, kLocalSettingKey)
	self._scenePickerHandler:setUndoEnable(true)

	local unitOperator = BattleMgr.instance:getUnitOperator()

	unitOperator:onTouchEmpty()
	self:_setUnitsUndoPreviewState(true)
	ViewMgr.instance:open(ViewName.BattleUndo)
end

function BattleCompUndoMgr:resetUndoEnvironment()
	BattleMainViewFacade.instance:setLeftTopViewVisible(true, kLocalSettingKey)
	BattleMainViewFacade.instance:setCenterTopViewVisible(true, kLocalSettingKey)
	BattleMainViewFacade.instance:resetFromMoving(kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Auto, true, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Speed, true, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Setting, true, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.RoundFinish, true, kLocalSettingKey)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.DangerZone, true, kLocalSettingKey)
	BattleBossPropertyFacade.instance:setVisible(true, kLocalSettingKey)
	self._scenePickerHandler:setUndoEnable(false)
	self:_setUnitsUndoPreviewState(false)
	ViewMgr.instance:close(ViewName.BattleUndo)
end

function BattleCompUndoMgr:_onReceiveBackTo(evt, successed)
	if successed then
		self._model:internal_increaseUndoCount()
		self:_deleteBeforeActiveNode()

		local resultMO = self._model:getResultMO()

		resultMO:internal_reset()

		local battleFieldInfo = self._model:getBattleFieldInfo()
		local stepCampId = battleFieldInfo.stepCampId
		local localLogic = BattleMgr.instance:getLocalLogic()

		localLogic:handlePlayerStarted(stepCampId)
	else
		local undoMOList = self:getUndoMOList()
		local undoMO = undoMOList[#undoMOList]

		self:previewUndo(undoMO:getRound(), undoMO:getStep() + 1, false)
	end
end

function BattleCompUndoMgr:_onUndoBattlefieldUpdate(evt, battleInfoNO)
	self:_applyBattleInfoNO(battleInfoNO)
end

function BattleCompUndoMgr:_applyBattleInfoNO(battleInfoNO)
	if BattleLog.enableLog then
		BattleLog.log("apply the undo battle field info")
	end

	self.flow:internal_NotifyComponent(BattleFunctionName.onUndoReset)

	local model = self._model
	local srcBattlefieldInfo = self.flow:buildBattleFieldInfo(battleInfoNO)
	local battleFieldInfo = model:getBattleFieldInfo()

	battleFieldInfo:copyFromForUndo(srcBattlefieldInfo)
	model:internal_undoReloadBattleFieldInfo()
	srcBattlefieldInfo:returnSelf()

	local unitMgr = self._unitMgr

	unitMgr:internal_BuildUnits()
	WorkExecuteInitCommands:executeInitCommands()

	local campOperator = BattleMgr.instance:getCampOperator()
	local focusEntityId = self:_getFocusEntityId()
	local focusUnit = focusEntityId and unitMgr:getUnit(focusEntityId) or campOperator:getNextOperatableUnit()

	if focusUnit then
		campOperator:setNextOperateEntityId(focusEntityId)

		local position = BattleUnitUtil.getBattleFocusPos(focusUnit)

		BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, 0.8)
	elseif BattleLog.enableLog then
		BattleLog.log("BattleCompUndoMgr::cannot find a focus unit", focusEntityId)
	end

	local settingModel = BattleMgr.instance:getSettingModel()

	if settingModel:isRequestUndo() then
		self:_setUnitsUndoPreviewState(true)
	end
end

function BattleCompUndoMgr:_setUnitsUndoPreviewState(isFrozen)
	local unitMgr = self._unitMgr
	local units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			if isFrozen then
				unit.property:activeState(BattleEnum.State.UNDO_PREVIEW)
			else
				unit.property:inactiveState(BattleEnum.State.UNDO_PREVIEW)
			end

			unit.stateEffect:refreshStateEffect()
		end
	end
end

function BattleCompUndoMgr:_getFocusEntityId()
	local undoMOList = self:getUndoMOList()
	local activeRound = self._battleInfoNOCache:getActiveRound()
	local activeStep = self._battleInfoNOCache:getActiveStep()

	for index, undoMO in ipairs(undoMOList) do
		if undoMO:equalsRoundAndStep(activeRound, activeStep) then
			if not undoMO:isRoundNode() then
				return undoMO:getEntityId()
			end

			local nextUndoMO = undoMOList[index - 1] or undoMOList[index + 1]

			return nextUndoMO and nextUndoMO:getEntityId()
		end
	end
end

function BattleCompUndoMgr:_deleteBeforeActiveNode()
	local battleInfoNOCache = self._battleInfoNOCache
	local round = battleInfoNOCache:getActiveRound()
	local step = battleInfoNOCache:getActiveStep()
	local undoMOList = self:getUndoMOList()

	repeat
		local undoMO = undoMOList[#undoMOList]

		if not undoMO then
			return
		end

		local isFindCurrentMO = undoMO:equalsRoundAndStep(round, step)

		if isFindCurrentMO and undoMO:isRoundNode() then
			return
		end

		table.remove(undoMOList)
		battleInfoNOCache:deleteCacheItem(undoMO:getRound(), undoMO:getStep())
		undoMO:returnSelf()

		if isFindCurrentMO then
			return
		end
	until false
end

return BattleCompUndoMgr
