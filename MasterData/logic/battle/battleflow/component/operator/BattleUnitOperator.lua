-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/operator/BattleUnitOperator.lua

module("logic.battle.battleflow.component.operator.BattleUnitOperator", package.seeall)

local BattleUnitOperator = class("BattleUnitOperator", IBattleFlowComp, IBattleMainViewResult)
local State = {
	kTransport = 5,
	kFocused = 2,
	kDisable = 0,
	kAttacked = 4,
	kWait = 1,
	kRelateUnitTransport_P2 = 7,
	kRelateUnitTransport_P1 = 6,
	kSelectPos = 8
}
local kLocalSettingKey = "BattleUnitOperator"

function BattleUnitOperator:onInit()
	self._state = State.kDisable
	self._lockOperateCount = 0
	self._focusUnit = false
	self._originUnionIndex = false
	self._originLookAt = Vector3.New()
	self._targetUnionIndex = false
	self._transportUnionIndex = false
	self._selectedSkillId = false
	self._hasAnyAttackableTarget = false
	self._isStrenthening = false
	self._forecastUnit = false
end

function BattleUnitOperator:onStart()
	self._model = self.flow.model or false
	self._settingModel = self.flow.settingModel or false
	self._boardMgr = self.flow.boardMgr or false
	self._unitMgr = self.flow.unitMgr or false
	self._boardModel = self.flow.boardModel or false
	self._pathFinder = self.flow.pathFinder or false
	self._sharedPathFinder = self.flow.sharedPathFinder or false
	self._cmdExecuter = self.flow.cmdExecuter or false
	self._campOperator = self.flow.campOperator or false
	self._pathArrow = self.flow.pathArrow or false
	self._forecastDrawing = self.flow.forecastDrawing or false
	self._haloLinks = self.flow.haloLinks or false
	self._forecastMgr = self.flow.forecastMgr or false
	self._aiForecastMgr = self.flow.aiForecastMgr or false
	self._netAgent = self.flow.netAgent or false
	self._releaseSkillAgent = self.flow.releaseSkillAgent or false
	self._scenePickerHandler = self.flow.scenePickerHandler or false
	self._mainViewFacade = BattleMainViewFacade.instance
	self._lockOperateCount = 0

	self:_switchState(State.kDisable)

	self._forecastUnit = false

	self:_setEvent(true)
end

function BattleUnitOperator:onClear()
	self._mainViewFacade = false
	self._focusUnit = false
	self._originUnionIndex = false

	self._originLookAt:Set(0, 0, 0)

	self._targetUnionIndex = false
	self._transportUnionIndex = false
	self._selectedSkillId = false
	self._isStrenthening = false
	self._model = false
	self._settingModel = false
	self._boardModel = false
	self._boardMgr = false
	self._unitMgr = false
	self._pathFinder = false
	self._sharedPathFinder = false
	self._cmdExecuter = false
	self._campOperator = false
	self._forecastDrawing = false
	self._haloLinks = false
	self._pathArrow = false
	self._forecastMgr = false
	self._aiForecastMgr = false
	self._netAgent = false
	self._releaseSkillAgent = false
	self._forecastUnit = false

	self:_setEvent(false)
end

function BattleUnitOperator:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnForecastResultUpdate, self._onForecastResultUpdate, self)
	end
end

function BattleUnitOperator:beginOperateUnit()
	self:_switchState(State.kWait)
	self:_clearOperateUnitInfo()
	self._mainViewFacade:setupOperatableFunction(true, kLocalSettingKey)
end

function BattleUnitOperator:endOperateUnit()
	self:_clearAllSign()
	self:_switchState(State.kDisable)
	self:_clearOperateUnitInfo()
	self:_clearTargetUnionIndex()
	self._forecastMgr:clearCaches()
	self._aiForecastMgr:clearCaches()
	self._mainViewFacade:clearOperateUnit()
	self._mainViewFacade:setupOperatableFunction(false, kLocalSettingKey)
end

function BattleUnitOperator:_checkForecastLegal()
	local isLegal = true

	if self._focusUnit and self._selectedSkillId and not self._focusUnit.skill:isSkillEnable(self._selectedSkillId) and self:_isSelectedTransportSkill() then
		isLegal = false

		self:_clearTargetUnionIndex()
		self:_clearTransportUnionIndex()
		self._pathArrow:hideTransportSign()
		self._forecastDrawing:clearTransportUnit()
		self._mainViewFacade:hideTransportView()
		self:_switchState(State.kFocused)
		self:_selectDefaultSkillFromUnit()
	end

	if isLegal then
		self:_onForecastPush()
	end
end

function BattleUnitOperator:_onForecastResultUpdate()
	local triggerCmd = BattleTriggerCommand:create(self._checkForecastLegal, self, 0)

	self._cmdExecuter:addCommand(triggerCmd)
	self._cmdExecuter:submit()
end

function BattleUnitOperator:forecastAgainWithoutTarget()
	self:_clearTargetUnionIndex()
	self:_selectDefaultSkillFromUnit()

	local forecastResult = self:_requestForecast()

	self._forecastMgr:activeForecast(forecastResult)
end

function BattleUnitOperator:isOperatingUnit()
	return self._state ~= State.kDisable
end

function BattleUnitOperator:_clearOperateUnitInfo()
	self:_setOriginalUnionIndex(false)

	self._focusUnit = false
	self._selectedSkillId = false
	self._hasAnyAttackableTarget = false

	self._originLookAt:Set(0, 0, 0)
end

function BattleUnitOperator:focusOnUnit(unit)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local position = BattleUnitUtil.getBattleFocusPos(unit)
	local tweener = BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, 0.5)

	if GuideModel.instance:getBattleTriggerGuideInRound(BattleEnterUtil.getCurrentDungeonCode(), self._model:getCurrentRound()) then
		if self._model:isRoundStart() then
			ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Battle)

			local function func()
				self._model:setRoundStartStatus(false)
				BattleDispatcher:dispatchEvent(BattleEventType.OnRoundStartAnimDone, self._model:getCurrentRound())
				ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Battle)
			end

			tweener:OnKill(func)
		end
	else
		self._model:setRoundStartStatus(false)
	end

	self:_doStateWait(unionIndex, true)
end

function BattleUnitOperator:onTouchCell(unionIndex, isDoubleClick)
	if self._lockOperateCount > 0 then
		if BattleLog.enableWarn then
			BattleLog.warn("BattleUnitOperator:current operate is locked!")
		end

		return
	end

	local state = self._state

	if state == State.kDisable then
		if BattleLog.enableWarn then
			BattleLog.warn("BattleUnitOperator::call beginOperateUnit first!")
		end
	elseif state == State.kWait then
		self:_doStateWait(unionIndex)
	elseif state == State.kFocused then
		self:_doStateFocused(unionIndex, isDoubleClick)
	elseif state == State.kTransport then
		self:_doStateTransport(unionIndex, isDoubleClick)
	elseif state == State.kRelateUnitTransport_P1 then
		self:_doStateSecondSelect(unionIndex, isDoubleClick)
	elseif state == State.kRelateUnitTransport_P2 then
		self:_doStateSecondSelect_P2(unionIndex, isDoubleClick)
	elseif state == State.kSelectPos then
		self:_doStateSelectPos(unionIndex, isDoubleClick)
	elseif state == State.kAttacked then
		return
	elseif BattleLog.enableWarn then
		BattleLog.warn(string.format("BattleUnitOperator::unhandle state", state))
	end
end

function BattleUnitOperator:simulateSwitchOpToBoss(unit)
	self:onTouchEmpty()
	self:_focusNotOperatableUnit(unit, BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates()))
end

function BattleUnitOperator:onTouchEmpty(isDoubleClick)
	if self._lockOperateCount > 0 then
		if BattleLog.enableWarn then
			BattleLog.warn("BattleUnitOperator:current operate is locked!")
		end

		return
	end

	local state = self._state

	if state == State.kTransport then
		self._mainViewFacade:hideTransportView()
		self._forecastDrawing:clearTransportUnit()
	end

	if state ~= State.kWait or state ~= State.kDisable then
		self:_switchToWaitState()
	end
end

function BattleUnitOperator:_addMoveCommands()
	self._mainViewFacade:clearOperateUnit()
	self._forecastDrawing:clearForecastResult()
	self._forecastDrawing:clearTransportUnit()
	self:_clearAllSign()
	self._pathArrow:clearSkillArea()

	local toUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	self:_addMoveCommand(toUnionIndex)
	self:_addMoveFinishCommand()
end

function BattleUnitOperator:onClickStandby()
	if self._hasAnyAttackableTarget and BattleViewUtil.tryShowEarlyStageTips(BattleMapEnum.WarningAction.StandBy, self._onClickStandby, self) then
		return
	end

	self:_onClickStandby()
end

function BattleUnitOperator:_onClickStandby()
	if not self._focusUnit then
		return
	end

	self._cmdExecuter:addCommand(BattleAsynCallCommand:create(self._doStandBy, self))
	self._cmdExecuter:submit()
	self:_addMoveCommands()
end

function BattleUnitOperator:onClickAttack()
	if BattleUnitUtil.isLowSanity(self._focusUnit) and self._isStrenthening and BattleViewUtil.tryShowEarlyStageTips(BattleMapEnum.WarningAction.SanityDead, self._onClickAttack, self) then
		return
	end

	if self._releaseSkillAgent:isRemoteMelee(self._focusUnit, self._targetUnionIndex, self._selectedSkillId, self._isStrenthening) and BattleViewUtil.tryShowEarlyStageTips(BattleMapEnum.WarningAction.RemoteMelee, self._onClickAttack, self) then
		return
	end

	self:_onClickAttack()
end

function BattleUnitOperator:_onClickAttack()
	self._cmdExecuter:addCommand(BattleAsynCallCommand:create(self._doAttack, self))
	self._cmdExecuter:submit()
	self:_addMoveCommands()
end

function BattleUnitOperator:onSelectSkill(skillId, isStrenthening)
	if skillId == self._selectedSkillId then
		return
	end

	self._isStrenthening = isStrenthening

	self._focusUnit.skill:setSkillStatus(isStrenthening and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal)
	self._cmdExecuter:addCommand(BattleAsynCallCommand:createParam1(self._switchSelectedSkill, self, skillId))
	self._cmdExecuter:submit()
end

function BattleUnitOperator:internal_onForecastResultUpdate()
	self:_checkAttackSelectedSkill()
end

function BattleUnitOperator:onClickStrenthening(isStrenthening)
	if self._isStrenthening == isStrenthening then
		return
	end

	self._isStrenthening = isStrenthening

	self._focusUnit.skill:setSkillStatus(isStrenthening and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal)
	self._mainViewFacade:updateViewInfoOnStrengthenChange()
	self._cmdExecuter:addCommand(BattleAsynCallCommand:createParam1(self._switchSelectedSkill, self, self._selectedSkillId))
	self._cmdExecuter:submit()

	if not self._targetUnionIndex then
		self._focusUnit.uiProxy:updateOnSanityChange()
	end

	if self._isStrenthening then
		self._focusUnit.property:activeState(BattleEnum.State.SANITY_STRENGTHEN)
		self._focusUnit.effectPlayer:playEffect(BattleConst.SANITY_BURN_EFFECT)
		self._focusUnit.effectPlayer:playLoopEffect(BattleConst.SANITY_BURN_LOOP_EFFECT)
	else
		self._focusUnit.property:inactiveState(BattleEnum.State.SANITY_STRENGTHEN)
		self._focusUnit.effectPlayer:stopLoopEffectWithAnim(BattleConst.SANITY_BURN_LOOP_EFFECT, "End", 0.5)
	end
end

function BattleUnitOperator:setStrenthening(isStrenthening)
	self._isStrenthening = isStrenthening
end

function BattleUnitOperator:isInStrengthenStatus()
	return self._isStrenthening
end

function BattleUnitOperator:interruptOperateUnit()
	self._cmdExecuter:addCommand(BattleAsynCallCommand:create(self._doInterruptOperateUnit, self))
	self._cmdExecuter:submit()
end

function BattleUnitOperator:isSelectableSkillTarget(unionIndex)
	if self._focusUnit and self._selectedSkillId and self._pathFinder:isInAttackableArea(unionIndex) and self._releaseSkillAgent:isValidSkillTarget(self._focusUnit, unionIndex, self._selectedSkillId) then
		return true
	end

	return false
end

function BattleUnitOperator:_doStandBy()
	if not self._focusUnit then
		if BattleLog.enableWarn then
			BattleLog.warn("BattleUnitOperator::focus unit is nil!")
		end

		return
	end

	self:_clearFocusUnitForecast()

	local entityId = self._focusUnit.property:getEntityId()
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())
	local pathUnionIndexs = self._sharedPathFinder:findPathForServer(self._focusUnit, self._selectedSkillId, self._originUnionIndex, unionIndex)
	local lookAtDirection = Coordinates:createInstance(self:_getLookAtDir())

	self:_setOperateUnitFinish()
	self._netAgent:sendStepRequest(entityId, pathUnionIndexs, 0, 0, 0, false, lookAtDirection)
	lookAtDirection:returnSelf()
end

function BattleUnitOperator:_clearFocusUnitForecast()
	if not self._focusUnit then
		return
	end

	if not self._focusUnit.property:isStateActive(BattleEnum.State.SNIPING) then
		self._focusUnit.property:inactiveState(BattleEnum.State.SANITY_STRENGTHEN)
		self._focusUnit.effectPlayer:stopLoopEffectWithAnim(BattleConst.SANITY_BURN_LOOP_EFFECT, "End", 0.5)
	end

	self:setStrenthening(false)
	self._focusUnit.uiProxy:updateOnSanityChange()
end

function BattleUnitOperator:_doAttack()
	local releaseSkillContext = BattleReleaseSkillContext:createInstance()

	releaseSkillContext.entityId = self._focusUnit.property:getEntityId()
	releaseSkillContext.originUnionIndex = self._originUnionIndex
	releaseSkillContext.stopUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())
	releaseSkillContext.selectedSkillId = self._selectedSkillId
	releaseSkillContext.targetUnionIndex = self._targetUnionIndex
	releaseSkillContext.transportUnionIndex = self._transportUnionIndex
	releaseSkillContext.isStrenthening = self._isStrenthening

	releaseSkillContext:setLookAtDirection(self:_getLookAtDir())
	self._releaseSkillAgent:requestAttack(releaseSkillContext)
	self:_setOperateUnitFinish()
	self:_clearAllSign()
	releaseSkillContext:returnSelf()
end

function BattleUnitOperator:_getLookAtDir()
	if self._forecastUnit then
		return self._forecastUnit.meshModel:getLookAtDir()
	end

	return self._focusUnit.meshModel:getLookAtDir()
end

function BattleUnitOperator:_setOperateUnitFinish()
	self._focusUnit.property:activeState(BattleEnum.State.MANUAL)
	BattleMainViewFacade.instance:setForNotOperatable()
end

function BattleUnitOperator:_doInterruptOperateUnit()
	self:_switchToWaitState()
	self:endOperateUnit()
end

function BattleUnitOperator:_doStateWait(unionIndex, cameraFollowed)
	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if not BattleUnitUtil.checkSelectUnit(unit) then
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_click_point, nil, nil, nil)
		self:_switchToWaitState()
		self._pathArrow:showFocusSign(unionIndex)

		return false
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_click_hero, nil, nil, nil)

	if self._campOperator:isOperatableUnit(unit) then
		self:_focusOperatableUnit(unit, unionIndex, cameraFollowed)
	else
		self:_focusNotOperatableUnit(unit, unionIndex, cameraFollowed)
	end
end

function BattleUnitOperator:_focusOperatableUnit(unit, unionIndex, cameraFollowed)
	if not cameraFollowed then
		self._cmdExecuter:addCommand(BattleAdjustCameraInHotAreaCommand:create(unionIndex, unionIndex, false, BattleEnum.HotAreaType.Middle))
		self._cmdExecuter:submit()
	end

	if self._focusUnit == unit then
		self:_setFocusUnionIndex(unit, unionIndex)

		return
	end

	self:_clearAllSign()
	self:_switchState(State.kFocused)
	self:_switchFocusUnit(unit, unionIndex)
	self:_signStopableAreaForUnit()
	self:_selectDefaultSkillFromUnit()
	self:_activeBaseAiForecast()
	self:_drawAttackForecastForUnit()
	self:_drawHaloLinkForFocusUnit()
end

function BattleUnitOperator:_focusNotOperatableUnit(unit, unionIndex, cameraFollowed)
	if not cameraFollowed then
		self._cmdExecuter:addCommand(BattleAdjustCameraInHotAreaCommand:create(unionIndex, unionIndex, false, BattleEnum.HotAreaType.Middle))
		self._cmdExecuter:submit()
	end

	if self._focusUnit == unit then
		self:_setFocusUnionIndex(unit, unionIndex)

		return
	end

	BattleAudioUtil.playSEByName("ui_battle_targetselect")
	self:_clearAllSign()
	self:_switchState(State.kWait)
	self:_switchFocusUnit(unit, unionIndex)
	self:_signStopableAreaForUnit()
	self:_signDefaultAttackableAreaForUnit()
	self:_activeBaseAiForecast()
	self:_drawAttackForecastForUnit()
	self:_drawHaloLinkForFocusUnit()
end

function BattleUnitOperator:_selectDefaultSkillFromUnit()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightNormalSkill, false) then
		return
	end

	local skillId = self._focusUnit.skill:findEnableDamageSkill():getSkillId()

	if self._focusUnit.skill:isSkillEnable(skillId) then
		self._mainViewFacade:selectSkill(skillId)
	else
		self:_signAttackableAreaForUnit(skillId, true)
	end
end

function BattleUnitOperator:_signDefaultAttackableAreaForUnit()
	local skillId = self._focusUnit.skill:findEnableDamageSkill():getSkillId()

	self:_signAttackableAreaForUnit(skillId, true)
end

function BattleUnitOperator:_doStateFocused(unionIndex, isDoubleClick)
	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if BattleUnitUtil.checkSelectUnit(unit) then
		self:_doStateFocused_TouchUnit(unit, unionIndex, isDoubleClick)
	else
		self:_doStateFocused_TouchEmpty(unionIndex)
	end
end

function BattleUnitOperator:_doStateFocused_TouchUnit(unit, unionIndex, isDoubleClick)
	if self:_isAttackableUnitOfUnionIndex(unit, unionIndex) then
		if self:_isShortcutAttack(unit, unionIndex) then
			self:onClickAttack()
		elseif self._targetUnionIndex ~= unionIndex then
			self:_moveToNearestAttackCellIndex(unionIndex, unit)
		end
	elseif self._campOperator:isOperatableUnit(unit) then
		if self:_isShortcutStandby(unit, unionIndex, isDoubleClick) then
			self:onClickStandby()
		else
			self:_focusOperatableUnit(unit, unionIndex)
		end
	else
		self:_focusNotOperatableUnit(unit, unionIndex)
	end
end

function BattleUnitOperator:_isShortcutAttack(unit, unionIndex)
	if not self._settingModel:isDoubleClickAttack() then
		return false
	end

	if self._targetUnionIndex ~= unionIndex then
		return false
	end

	return not self:_isSelectedTransportSkill()
end

function BattleUnitOperator:_isSelectedTransportSkill()
	if not self._selectedSkillId then
		return false
	end

	return BattleSkillAssist.isTransportSkill(self._selectedSkillId, self._focusUnit.skill:getSkillStatus())
end

function BattleUnitOperator:_isSelectedPosSkill()
	if not self._selectedSkillId then
		return false
	end

	return BattleSkillAssist.isCellSelectedSkill(self._selectedSkillId, self._focusUnit.skill:getSkillStatus())
end

function BattleUnitOperator:_isSelectedRelateUnitTransportSkill()
	if not self._selectedSkillId then
		return false
	end

	return BattleSkillAssist.hasUnitRelatedTransport(self._selectedSkillId, self._focusUnit.skill:getSkillStatus())
end

function BattleUnitOperator:_isShortcutStandby(unit, unionIndex, isDoubleClick)
	if not self._settingModel:isDoubleClickIdle() then
		return false
	end

	if self._focusUnit ~= unit then
		return false
	end

	local currentUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local isMoved = self._originUnionIndex ~= currentUnionIndex

	return isMoved or isDoubleClick
end

function BattleUnitOperator:_doStateFocused_TouchEmpty(unionIndex)
	local pathFinder = self._pathFinder

	if pathFinder:isInStopableArea(unionIndex) then
		self:_forecastMoveToUnionIndex(unionIndex)
	else
		self:_switchToWaitState()
		self._pathArrow:showFocusSign(unionIndex)
	end
end

function BattleUnitOperator:_checkIfNeedMoveForAttack(targetUnionIndex)
	local pathFinder = self._pathFinder
	local currentUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	if not pathFinder:isInCanAttackTargetArea(currentUnionIndex) then
		return true
	end

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._selectedSkillId)
	local skillEffectType = skillCOWrapper:getSkillEffectType(self._focusUnit.skill:getSkillStatus())
	local manhattanDistance = BoardIndexConverter.calculateManhattanDistance(currentUnionIndex, targetUnionIndex)

	if skillEffectType == BattleEnum.SkillPurpose.DAMAGE and manhattanDistance <= 1 and self._originUnionIndex == currentUnionIndex then
		return not pathFinder:isInBestCanAttackTargetArea(currentUnionIndex)
	end

	return false
end

function BattleUnitOperator:_moveToNearestAttackCellIndex(unionIndex, unit)
	if unit and BattleUnitUtil.isComposite(unit) and BattleSkillAssist.isTransportSkill(self._selectedSkillId, self._focusUnit.skill:getSkillStatus()) then
		FloatWordMgr.instance:show(lang("tip_battle_composite_unit_check_1"))

		return
	end

	local pathFinder = self._pathFinder

	pathFinder:signCanAttackTarget(self._focusUnit, self._originUnionIndex, unionIndex, self._selectedSkillId)

	if not self:_checkIfNeedMoveForAttack(unionIndex) then
		local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

		self:_tryHideCompareView(unit)
		self:_switchTargetUnionIndex(unionIndex, unit)
		self:_adjustCameraAndShowCompareView(unitUnionIndex, unionIndex, unit)
		self:_requestAndSetForecast(unitUnionIndex)

		return
	end

	local nearestCellIndex = pathFinder:findNearestAttackUnionIndexOnSignResult(self._focusUnit, unionIndex)

	if not nearestCellIndex then
		if BattleLog.enableError then
			BattleLog.error(string.format("BattleUnitOperator::cannot find nearest attack cell index for [%s]", unionIndex))
		end

		return
	end

	self:_tryHideCompareView(unit)
	self:_moveToUnionIndexAndAdjustmentCamera(nearestCellIndex, unionIndex, unit)
	self:_switchTargetUnionIndex(unionIndex, unit)
	self:_requestForecast(nearestCellIndex)
end

function BattleUnitOperator:_forecastMoveToUnionIndex(unionIndex)
	BattleMainViewFacade.instance:closeUnitInfoExpandPanel()
	self:_addForecastMoveCommand(unionIndex)
	self._cmdExecuter:addCommand(BattleAsynCallCommand:create(self._onForecastMoveCommandFinish, self))
	self._cmdExecuter:addCommand(BattleAdjustCameraInHotAreaCommand:create(unionIndex, unionIndex, false, BattleEnum.HotAreaType.Middle))
	self._cmdExecuter:submit()
end

function BattleUnitOperator:_tryHideCompareView(unit)
	if self._targetUnionIndex and not self:_isSelectedTransportSkill() then
		return
	end

	BattleMainViewFacade.instance:hideCompareView()
end

function BattleUnitOperator:_adjustCameraAndShowCompareView(unionIndex, targetUnionIndex, targetUnit)
	self:_addAdjustCameraCommand(unionIndex, targetUnionIndex, targetUnit)
	self:_addResumeAdjustCameraCommand(0)
	self._cmdExecuter:submit()
end

function BattleUnitOperator:_moveToUnionIndexAndAdjustmentCamera(unionIndex, targetUnionIndex, targetUnit)
	self:_addForecastMoveCommand(unionIndex)
	self:_addAdjustCameraCommand(unionIndex, targetUnionIndex, targetUnit)
	self:_addForecastMoveFinishCommand(0)
	self:_addResumeAdjustCameraCommand(0)
	self._cmdExecuter:submit()
end

function BattleUnitOperator:_resetUnitFromForecast()
	if self._focusUnit then
		self:_clearForecastUnit()
		self._boardMgr:setUnitToUnionIndex(self._focusUnit, self._originUnionIndex)
	end
end

function BattleUnitOperator:_addMoveCommand(unionIndex)
	self:_lockOperate()
	self._cmdExecuter:addCommand(BattleAsynCallCommand:create(self._onBeforeMove, self))
	self._cmdExecuter:submit()
	self._forecastDrawing:clearAllAiForecast()

	local pathFinder = self._pathFinder
	local arrowPathList = pathFinder:findPrettyPath(self._focusUnit, self._originUnionIndex)

	pathFinder:signPrettyPath(self._focusUnit, self._originUnionIndex, arrowPathList)

	local pathUnionIndexList = pathFinder:findShortestPath(self._focusUnit, unionIndex)

	self._cmdExecuter:addCommand(BattleAdjustCameraInMoveAndAttackCommand:create(self._targetUnionIndex, self._originUnionIndex, unionIndex, self._focusUnit.property:getEntityId()))

	local moveCmd = BattleMoveCommand:create(self._focusUnit.property:getEntityId(), self._originUnionIndex, pathUnionIndexList)

	self._cmdExecuter:addCommand(moveCmd)
end

function BattleUnitOperator:_onBeforeMove()
	self:_resetUnitFromForecast()
end

function BattleUnitOperator:_addForecastMoveCommand(unionIndex)
	self._forecastDrawing:clearAllAiForecast()

	local pathFinder = self._pathFinder
	local arrowPathList = pathFinder:findPrettyPath(self._focusUnit, self._originUnionIndex)

	pathFinder:signPrettyPath(self._focusUnit, self._originUnionIndex, arrowPathList)

	local pathUnionIndexList = pathFinder:findShortestPath2(self._focusUnit, self._originUnionIndex, unionIndex)

	self:_createForecastUnitAndSetPos(unionIndex)
	self._boardMgr:setUnitToUnionIndex(self._focusUnit, unionIndex, true)

	if pathUnionIndexList and #pathUnionIndexList > 1 then
		self._pathArrow:showPath(pathUnionIndexList)

		local count = #pathUnionIndexList
		local x1, _, z1 = self._boardMgr:getCellPositionXYZ(pathUnionIndexList[count - 1])
		local x2, _, z2 = self._boardMgr:getCellPositionXYZ(pathUnionIndexList[count])

		self._forecastUnit.meshModel:lookAtDir(x2 - x1, 0, z2 - z1)
	elseif self._forecastUnit then
		self._forecastUnit.meshModel:lookAtDir(self._focusUnit.meshModel:getLookAtDir())
	end

	self._pathArrow:showOperatableFocusSign(unionIndex)
end

function BattleUnitOperator:_addMoveFinishCommand(duration)
	local triggerCmd = BattleTriggerCommand:create(self._onMoveCommandFinish, self, duration)

	self._cmdExecuter:addCommand(triggerCmd)
	self._cmdExecuter:submit()
end

function BattleUnitOperator:_addForecastMoveFinishCommand(duration)
	local triggerCmd = BattleTriggerCommand:create(self._onForecastMoveCommandFinish, self, duration)

	self._cmdExecuter:addCommand(triggerCmd)
end

function BattleUnitOperator:_onForecastMoveCommandFinish()
	if self._focusUnit then
		BattleDispatcher:dispatchEvent(BattleEventType.OnEntityForecastMove, self._focusUnit.property:getEntityId())
	end

	self:_checkAttackSelectedSkill()
	self:_checkAttackTargetAfterMove()
	self:_signAllSelectableUnit()
	self:_requestAndSetForecast()
	self:_signAOESkillArea()
	self._forecastDrawing:forecastAllAi()
	self:_lookAtTarget(true)
end

function BattleUnitOperator:_onMoveCommandFinish()
	self:_unlockOperate()
	self:_lookAtTarget()
end

function BattleUnitOperator:_lookAtTarget(isForecast)
	if self._targetUnionIndex then
		local position = self._boardMgr:getCellPosition(self._targetUnionIndex)
		local focusUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

		if self._targetUnionIndex ~= focusUnionIndex then
			if isForecast and self._forecastUnit then
				self._forecastUnit.meshModel:lookAt(position.x, 0, position.z)
			else
				self._focusUnit.meshModel:lookAt(position.x, 0, position.z)
			end
		end
	end
end

function BattleUnitOperator:_addAdjustCameraCommand(unionIndex, targetUnionIndex, targetUnit)
	self:_lockOperate()
	self._cmdExecuter:addCommand(BattleAdjustCameraInHotAreaCommand:create(unionIndex, targetUnionIndex, targetUnit))
end

function BattleUnitOperator:_addResumeAdjustCameraCommand(duration)
	local triggerCmd = BattleTriggerCommand:create(self._onAdjustFollowCenterFinish, self, duration)

	self._cmdExecuter:addCommand(triggerCmd)
end

function BattleUnitOperator:_onAdjustFollowCenterFinish()
	self:_unlockOperate()

	if self:_isSelectedRelateUnitTransportSkill() then
		self:_switchToRelateUnitTransport()
	elseif self:_isSelectedTransportSkill() then
		self:_switchToTransportState()
	else
		self:_updateCompareViewInfo()
	end
end

function BattleUnitOperator:_checkAttackSelectedSkill()
	if self._selectedSkillId and not self._focusUnit.skill:isSkillEnable(self._selectedSkillId) then
		self:_selectDefaultSkillFromUnit()
	end
end

function BattleUnitOperator:_checkAttackTargetAfterMove()
	if self._targetUnionIndex then
		local pathFinder = self._pathFinder
		local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

		if not self:_tryAutoSelectSelf() and not pathFinder:isInCanAttackTargetArea(unionIndex) then
			self:_clearTargetUnionIndex()
		end
	end
end

function BattleUnitOperator:_isAttackableUnitOfUnionIndex(unit, unionIndex)
	local pathFinder = self._pathFinder
	local model = self._model

	if not pathFinder:isInAttackableArea(unionIndex) then
		return false
	end

	return self._selectedSkillId and self._releaseSkillAgent:isValidSkillTarget(self._focusUnit, unionIndex, self._selectedSkillId)
end

function BattleUnitOperator:_switchToTransportState()
	self:_switchState(State.kTransport)
	self:_signTransportableArea()
	self:_signTransportSelectableSign()
	self._boardMgr:resetAllSign()
	self._mainViewFacade:showTransportView()

	local transportUnit = self._unitMgr:getUnitOnUnionIndex(self._targetUnionIndex)

	self._forecastDrawing:drawTransportUnit(transportUnit)
end

function BattleUnitOperator:_switchToRelateUnitTransport()
	self:_switchState(State.kRelateUnitTransport_P1)

	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())
	local skillMO = self._focusUnit.skill:getActiveSkillById(self._selectedSkillId)
	local transportDistance = skillMO:getTransportDistance()
	local shape = BattleShapeUtil.createShapeByTypeAndRange(BattleEnum.Shape.Rhombus, transportDistance)

	self._pathFinder:signSelectableArea(shape, unionIndex)
	self._boardMgr:singleSpreadCheckerBoardForSelectable(self._focusUnit, BattleEnum.CellLayer.ATTACKABLE, BattleEnum.CellColor.CURABLE, BattleEnum.CellColor.CURABLE, true)
	self:_signAllSelectableUnitForSecondSelect(true, skillMO:getSecondSelectSelectableTarget())
	shape:returnSelf()
end

function BattleUnitOperator:_doStateTransport(unionIndex, isDoubleClick)
	if self._pathFinder:isInTransportableArea(unionIndex) then
		if self._transportUnionIndex == unionIndex then
			self:onClickAttack()
		else
			self._mainViewFacade:hideTransportView()
			self:_setTransportUnionIndex(unionIndex)

			local forecastResult = self:_requestForecast()

			self._forecastMgr:activeForecast(forecastResult)
			self:_signTransportSelectableSign()
		end
	else
		self._mainViewFacade:hideTransportView()
		self:_switchToWaitState()
		self:_doStateWait(unionIndex)
		self._forecastDrawing:clearTransportUnit()
	end
end

function BattleUnitOperator:_doStateSecondSelect(unionIndex, isDoubleClick)
	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if BattleUnitUtil.checkSelectUnit(unit) then
		self:_doStateSecondSelect_TouchUnit(unit, unionIndex, isDoubleClick)
	else
		self:_doStateSecondSelect_TouchEmpty(unionIndex)
	end
end

function BattleUnitOperator:_doStateSecondSelect_TouchEmpty(unionIndex)
	if self._originUnionIndex == unionIndex then
		self:_switchToWaitState()
		self:_doStateWait(unionIndex)
	else
		self:_switchToWaitState()
		self._pathArrow:showFocusSign(unionIndex)
	end
end

function BattleUnitOperator:_doStateSecondSelect_TouchUnit(unit, unionIndex, isDoubleClick)
	local skillMO = self._focusUnit.skill:getActiveSkillById(self._selectedSkillId)
	local selectableTarget = skillMO:getSecondSelectSelectableTarget()
	local model = BattleMgr.instance:getModel()

	if self._pathFinder:isInSelectableArea(unionIndex) and BattleSkillAssist.validateSkillTargetWithTarget(selectableTarget, self._focusUnit, unionIndex) then
		self._transportUnionIndex = unionIndex

		self._pathArrow:hideAllSelectableSign()
		self._boardMgr:resetAllSign()
		self._pathArrow:showTargetSign(unionIndex)
		self:_switchState(State.kRelateUnitTransport_P2)

		local forecastResult = self:_requestForecast()

		self._forecastMgr:activeForecast(forecastResult)

		local attackerUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

		self._cmdExecuter:addCommand(BattleAdjustCameraInHotAreaCommand:create(attackerUnionIndex, unionIndex, false))
		self._cmdExecuter:submit()
	elseif self._campOperator:isOperatableUnit(unit) then
		self:_focusOperatableUnit(unit, unionIndex)
	else
		self:_focusNotOperatableUnit(unit, unionIndex)
	end
end

function BattleUnitOperator:_doStateSecondSelect_P2(unionIndex, isDoubleClick)
	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if BattleUnitUtil.checkSelectUnit(unit) then
		self:_doStateSecondSelect_P2_TouchUnit(unit, unionIndex, isDoubleClick)
	else
		self:_doStateSecondSelect_P2_TouchEmpty(unionIndex)
	end
end

function BattleUnitOperator:_doStateSecondSelect_P2_TouchEmpty(unionIndex)
	if self._originUnionIndex == unionIndex then
		self:_switchToWaitState()
		self:_doStateWait(unionIndex)
	else
		self:_switchToWaitState()
		self._pathArrow:showFocusSign(unionIndex)
	end
end

function BattleUnitOperator:_doStateSecondSelect_P2_TouchUnit(unit, unionIndex, isDoubleClick)
	if self._transportUnionIndex == unionIndex then
		return
	elseif self._campOperator:isOperatableUnit(unit) then
		self:_focusOperatableUnit(unit, unionIndex)
	else
		self:_focusNotOperatableUnit(unit, unionIndex)
	end
end

function BattleUnitOperator:_doStateSelectPos(unionIndex, isDoubleClick)
	local moveUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	if self._pathFinder:isInSelectableArea(unionIndex) and moveUnionIndex ~= unionIndex then
		if self._targetUnionIndex == unionIndex then
			self:onClickAttack()
		else
			self:_switchTargetUnionIndex(unionIndex)

			local forecastResult = self:_requestForecast()

			self._forecastMgr:activeForecast(forecastResult)
			self:_signSelectableSign()
		end
	else
		self:_switchToWaitState()
		self:_doStateWait(unionIndex)
	end
end

function BattleUnitOperator:_onForecastPush(forecastResult)
	if self._state == State.kRelateUnitTransport_P2 then
		local forecastResult = self._forecastMgr:getActiveForecastResult()

		if forecastResult then
			local finalAttackerUnionIndex = forecastResult.attackerEntityInfo:getCellUnionIndex()

			if finalAttackerUnionIndex then
				self._pathArrow:showTransportSign(finalAttackerUnionIndex)
			end
		end
	end
end

function BattleUnitOperator:_signTransportableArea()
	local targetUnit = self._unitMgr:getUnitOnUnionIndex(self._targetUnionIndex)
	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())
	local skillMO = self._focusUnit.skill:getActiveSkillById(self._selectedSkillId)
	local transportDistance = skillMO:getTransportDistance()
	local shape = BattleShapeUtil.createShapeByTypeAndRange(BattleEnum.Shape.Rhombus, transportDistance)

	self._pathFinder:signTransportableArea(targetUnit, shape, unitUnionIndex)
	shape:returnSelf()
end

function BattleUnitOperator:_signTransportSelectableSign()
	local pathArrow = self._pathArrow

	pathArrow:hideAllSelectableSign()

	local resultNodeArray = self._pathFinder:getNodeArray()
	local unionIndexList = BattleTableUtil.getTempList()

	for _, resultNode in resultNodeArray:ipairs() do
		if resultNode.isTransportable then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())

			if self._targetUnionIndex ~= unionIndex and self._transportUnionIndex ~= unionIndex then
				table.insert(unionIndexList, unionIndex)
			end
		end
	end

	self._pathArrow:showTransportArea(unionIndexList)
	BattleTableUtil.releaseTempList(unionIndexList)
end

function BattleUnitOperator:_requestForecast(stopUnionIndex)
	if not self._focusUnit then
		return
	end

	local entityId = self._focusUnit.property:getEntityId()

	stopUnionIndex = stopUnionIndex or BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	local releaseSkillContext = BattleReleaseSkillContext:createInstance()

	releaseSkillContext.entityId = entityId
	releaseSkillContext.originUnionIndex = self._originUnionIndex
	releaseSkillContext.stopUnionIndex = stopUnionIndex
	releaseSkillContext.selectedSkillId = self._selectedSkillId
	releaseSkillContext.targetUnionIndex = self._targetUnionIndex
	releaseSkillContext.transportUnionIndex = self._transportUnionIndex
	releaseSkillContext.isStrenthening = self._isStrenthening

	releaseSkillContext:setLookAtDirection(self:_getLookAtDir())

	local forecastResult = self._releaseSkillAgent:requestForecast(releaseSkillContext)

	releaseSkillContext:returnSelf()

	return forecastResult
end

function BattleUnitOperator:_requestAndSetForecast(stopUnionIndex)
	if not self._focusUnit then
		return
	end

	local forecastResult = self:_requestForecast(stopUnionIndex)

	self._forecastMgr:activeForecast(forecastResult)

	return forecastResult
end

function BattleUnitOperator:_setFocusUnionIndex(unit, unionIndex)
	local isOperatable = self._campOperator:isOperatableUnit(unit)

	if isOperatable then
		self._pathArrow:showOperatableFocusSign(unionIndex)
	else
		self._pathArrow:showFocusSign(unionIndex)
	end
end

function BattleUnitOperator:_switchFocusUnit(unit, unionIndex)
	self:_switchFocusUnit_resumeCurrentFocusUnit()

	if not unit then
		self._mainViewFacade:clearOperateUnit()
	end

	self:_clearTargetUnionIndex()
	self:_clearTransportUnionIndex()
	self:_clearSelectedSkill()
	self._pathArrow:hideAllSelectableSign()

	if unit then
		local isOperatable = self._campOperator:isOperatableUnit(unit)

		self:_switchFocusUnit_setFocusUnit(unit)
		self:_setFocusUnionIndex(unit, unionIndex)
		self._mainViewFacade:switchOperateUnit(unit, isOperatable, self)
		self._forecastMgr:activeForecast(false)
	else
		self:_setOriginalUnionIndex(false)

		self._focusUnit = false

		self._originLookAt:Set(0, 0, 0)
		self._pathArrow:hideFocusSign()
		self._forecastMgr:activeForecast(false)
	end
end

function BattleUnitOperator:_switchFocusUnit_resumeCurrentFocusUnit()
	local currentUnit = self._focusUnit

	if currentUnit then
		self:_clearFocusUnitForecast()
		self._boardMgr:setUnitToUnionIndex(currentUnit, self._originUnionIndex)
		currentUnit.meshModel:lookAtDirVec3(self._originLookAt)
		currentUnit.uiProxy:setSelected(false)

		if self._campOperator:isOperatableUnit(currentUnit) then
			currentUnit.sign:setOperatableSignVisible(true)
		end
	end

	self:_clearForecastUnit()
end

function BattleUnitOperator:_switchFocusUnit_setFocusUnit(unit)
	self._focusUnit = unit

	self:_setOriginalUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates()))
	unit.meshModel:getLookAtDirInVec3(self._originLookAt)
	unit.uiProxy:setSelected(true)

	if self._campOperator:isOperatableUnit(unit) then
		unit.sign:setOperatableSignVisible(false)
		unit.meshModelMover:playMappedAnimationIfExists(UnitAnimState.React)
		BattleUnitUtil.play3dAudio(unit, unit.property:getReactAudio())
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_yourturn)

		if BattleUnitUtil.isLowSanity(unit) then
			BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_dilizhi)
		else
			BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_xuanzhong)
		end
	end
end

function BattleUnitOperator:_signStopableAreaForUnit()
	self._pathFinder:signStopableArea(self._focusUnit)
	self._pathArrow:clearPath()
end

function BattleUnitOperator:_signAttackableAreaForUnit(skillId, isNeedSpreadBoard)
	if not self._focusUnit then
		return
	end

	local pathFinder = self._pathFinder
	local boardMgr = self._boardMgr

	pathFinder:signAttackableArea(self._focusUnit, skillId)

	if isNeedSpreadBoard then
		boardMgr:spreadCheckerBoard(self._focusUnit, skillId, true)
	end
end

function BattleUnitOperator:_signAllSelectableUnit()
	local focusUnit = self._focusUnit

	if not focusUnit then
		return
	end

	local pathArrow = self._pathArrow
	local resultNodeArray = self._pathFinder:getNodeArray()
	local isBlueSign = BattleSkillAssist.judgeAttackableCellSign(self._selectedSkillId, focusUnit.skill:getSkillStatus())
	local restrainWaitForClearUnits = BattleTableUtil.getTempList()
	local units = self._unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			table.insert(restrainWaitForClearUnits, unit)
		end
	end

	local selectableWaitForClearSigns = BattleTableUtil.getTempList()

	for pathIndex, goSign in pairs(pathArrow:getSelectableSignList()) do
		selectableWaitForClearSigns[pathIndex] = goSign
	end

	for _, resultNode in resultNodeArray:ipairs() do
		if resultNode.isAttackable then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())

			if self._releaseSkillAgent:isValidSkillTarget(focusUnit, unionIndex, self._selectedSkillId) then
				local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

				if unit and unit:isPerson() and not BattleCampRelationUtil.areTheySameOrFriendRelation(focusUnit, unit) then
					local restrainRelationLeft = BattleRestrainRelationUtil.getRestrainRelation(focusUnit, unit, self._selectedSkillId)

					unit.uiProxy:setRestrainRelation(restrainRelationLeft)
					table.removebyvalue(restrainWaitForClearUnits, unit)
				end

				if self._targetUnionIndex ~= unionIndex then
					if selectableWaitForClearSigns[unionIndex] then
						selectableWaitForClearSigns[unionIndex] = nil
					else
						pathArrow:showSelectableSign(unionIndex, isBlueSign)
					end
				end

				self._hasAnyAttackableTarget = true
			end
		end
	end

	for _, unit in ipairs(restrainWaitForClearUnits) do
		unit.uiProxy:clearRestrainRelation()
	end

	for pathIndex, _ in pairs(selectableWaitForClearSigns) do
		pathArrow:hideSelectableSign(pathIndex)
	end

	BattleTableUtil.releaseTempList(restrainWaitForClearUnits)
	BattleTableUtil.releaseTempList(selectableWaitForClearSigns)
end

function BattleUnitOperator:_signAllSelectableUnitForSecondSelect(isBlue, selectableTarget)
	local focusUnit = self._focusUnit

	if not focusUnit then
		return
	end

	local model = BattleMgr.instance:getModel()
	local pathArrow = self._pathArrow
	local resultNodeArray = self._pathFinder:getNodeArray()

	for _, resultNode in resultNodeArray:ipairs() do
		if resultNode.isSelectable then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())
			local targetUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

			if targetUnit and BattleSkillAssist.validateSkillTargetWithTarget(selectableTarget, self._focusUnit, unionIndex) then
				pathArrow:showSelectableSign(unionIndex, isBlue)
			end
		end
	end
end

function BattleUnitOperator:_signUnitOperatable()
	local notOperatableUnitIds = BattleTableUtil.getTempList()
	local focusUnit = self._focusUnit

	if focusUnit then
		notOperatableUnitIds[focusUnit.property:getEntityId()] = true

		if BattleSkillAssist.isFriendTargetSkill(self._selectedSkillId, focusUnit.skill:getSkillStatus()) then
			local resultNodeArray = self._pathFinder:getNodeArray()

			for _, resultNode in resultNodeArray:ipairs() do
				if resultNode.isAttackable then
					local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())

					if self._releaseSkillAgent:isValidSkillTarget(focusUnit, unionIndex, self._selectedSkillId) then
						local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

						if unit then
							notOperatableUnitIds[unit.property:getEntityId()] = true
						end
					end
				end
			end
		end
	end

	local units = self._unitMgr:getUnitsByCampId(self._model:getOperateCampId())

	for _, unit in pairs(units) do
		if self._campOperator:isOperatableUnit(unit) then
			if notOperatableUnitIds[unit.property:getEntityId()] then
				unit.sign:setOperatableSignVisible(false)
			else
				unit.sign:setOperatableSignVisible(true)
			end
		end
	end

	BattleTableUtil.releaseTempList(notOperatableUnitIds)
end

function BattleUnitOperator:_activeBaseAiForecast()
	self._aiForecastMgr:activeBaseForecastResult()
end

function BattleUnitOperator:_drawAttackForecastForUnit()
	local unit = self._focusUnit

	if BattleCampRelationUtil.isSameOrFriendOfOperateCamp(unit) then
		self._forecastDrawing:forecastWhoWillAttackMe(unit)
	else
		self._forecastDrawing:forecastIWillAttackWhichOne(unit)
	end
end

function BattleUnitOperator:_drawHaloLinkForFocusUnit()
	local unit = self._focusUnit

	self._haloLinks:drawHaloLinksForUnit(unit.property:getEntityId())
end

function BattleUnitOperator:_switchSelectedSkill(skillId)
	local isPreTransportSkill = self:_isSelectedTransportSkill()
	local isPreSelectPosSkill = self:_isSelectedPosSkill()
	local isNeedSpreadBoard = self:_isNeedSpreadBoard(self._selectedSkillId, skillId)

	self._selectedSkillId = skillId
	self._hasAnyAttackableTarget = false

	self:_signAttackableAreaForUnit(skillId, isNeedSpreadBoard)
	self:_signAllSelectableUnit()
	self:_tryUpdateSelectedTarget(isPreTransportSkill, isPreSelectPosSkill)
	self:_signUnitOperatable()
	self:_signSelectPosCell()
end

function BattleUnitOperator:_isNeedSpreadBoard(oldSkillId, newSkillId)
	if not oldSkillId or not newSkillId then
		return true
	end

	local oldSkillMO = self._focusUnit.skill:getActiveSkillById(oldSkillId)
	local newSkillMO = self._focusUnit.skill:getActiveSkillById(newSkillId)

	if BattleSkillAssist.isTransportSkill(oldSkillId, self._focusUnit.skill:getSkillStatus()) then
		return true
	end

	if BattleSkillAssist.isTransportSkill(newSkillId, self._focusUnit.skill:getSkillStatus()) then
		return true
	end

	if oldSkillMO:getSelectableTarget() == newSkillMO:getSelectableTarget() and BattleSkillAssist.isSkillShapeSame(self._focusUnit, oldSkillId, newSkillId) then
		return false
	end

	return true
end

function BattleUnitOperator:_tryUpdateSelectedTarget(isPreTransportSkill, isPreSelectPosSkill)
	if isPreTransportSkill then
		self:_clearTranportArea()
		self:_clearTargetUnionIndex()
		self:_clearTransportUnionIndex()
		self._pathArrow:hideTransportSign()
		self._forecastDrawing:clearTransportUnit()
		self:_switchState(State.kFocused)
	end

	if isPreSelectPosSkill and not self:_isSelectedPosSkill() then
		self:_clearTranportArea()
		self:_switchState(State.kFocused)
		self:_clearTargetUnionIndex()
	end

	if not self:_tryAutoSelectSelf() and not self._targetUnionIndex then
		return
	end

	local targetUnit = self._unitMgr:getUnitOnUnionIndex(self._targetUnionIndex)

	if self:_isAttackableUnitOfUnionIndex(targetUnit, self._targetUnionIndex) then
		self:_moveToNearestAttackCellIndex(self._targetUnionIndex, targetUnit)

		if targetUnit and not BattleCampRelationUtil.isEnemyOfOperateCamp(targetUnit) then
			self._mainViewFacade:showRole(self._focusUnit.property:getModelCode(), targetUnit, "CompareView")
		end
	else
		self:_clearTargetUnionIndex()
		self._mainViewFacade:showRole(self._focusUnit.property:getModelCode(), targetUnit, "CompareView")
	end
end

function BattleUnitOperator:_tryAutoSelectSelf()
	if BattleSkillAssist.isTransportSkill(self._selectedSkillId, self._focusUnit.skill:getSkillStatus()) and BattleUnitUtil.isComposite(self._focusUnit) and BattleLog.enableError then
		printError(self._focusUnit.property:getName(), "大型目标不可以配置自身位移技能 联系策划")
	end

	if not BattleSkillAssist.isSelfTargetSkill(self._selectedSkillId, self._focusUnit.skill:getSkillStatus()) then
		return false
	end

	local targetUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	self:_switchTargetUnionIndex(targetUnionIndex, self._focusUnit)

	return true
end

function BattleUnitOperator:_signSelectPosCell()
	if BattleSkillAssist.isCellSelectedSkill(self._selectedSkillId) then
		self:_switchState(State.kSelectPos)

		local shape = self._focusUnit.skill:generateSkillReleaseShape(self._selectedSkillId)
		local moveUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

		self._boardMgr:resetAllSign()
		self._pathFinder:signSelectableArea(shape, moveUnionIndex)
		self:_signSelectableSign()
		shape:returnSelf()
	end
end

function BattleUnitOperator:_signSelectableSign()
	local resultNodeArray = self._pathFinder:getNodeArray()
	local unionIndexList = BattleTableUtil.getTempList()
	local moveUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	for _, resultNode in resultNodeArray:ipairs() do
		if resultNode.isSelectable then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())

			if moveUnionIndex ~= unionIndex and self._targetUnionIndex ~= unionIndex then
				table.insert(unionIndexList, unionIndex)
			end
		end
	end

	self._pathArrow:showTransportArea(unionIndexList)
	BattleTableUtil.releaseTempList(unionIndexList)
end

function BattleUnitOperator:getTargetUnionIndex()
	return self._targetUnionIndex
end

function BattleUnitOperator:_switchToWaitState()
	self:_switchState(State.kWait)
	self:_switchFocusUnit(false)
	self:_clearAllSign()
end

function BattleUnitOperator:_switchState(state)
	self._state = state
end

function BattleUnitOperator:lockOperate()
	self:_lockOperate()
end

function BattleUnitOperator:unlockOperate()
	self:_unlockOperate()
end

function BattleUnitOperator:_lockOperate()
	self._lockOperateCount = self._lockOperateCount + 1
end

function BattleUnitOperator:_unlockOperate()
	self._lockOperateCount = self._lockOperateCount - 1
end

function BattleUnitOperator:_setTransportUnionIndex(unionIndex)
	self._transportUnionIndex = unionIndex

	if unionIndex then
		self._pathArrow:showTransportSign(unionIndex)
	else
		self._pathArrow:hideTransportSign()
	end
end

function BattleUnitOperator:_clearTransportUnionIndex()
	self:_setTransportUnionIndex(false)
end

function BattleUnitOperator:_switchTargetUnionIndex(unionIndex, unit)
	local lastTargetUnionIndex = self._targetUnionIndex

	self._targetUnionIndex = unionIndex

	if unionIndex then
		self._pathArrow:showTargetSign(unionIndex)
		self._mainViewFacade:setSelectTarget(unionIndex)
		self:_lookAtTarget(true)
		self:_signAOESkillArea()
		self:_drawHaloLinkForTargetUnit(unit, lastTargetUnionIndex)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_targetselect)
	else
		self._pathArrow:hideTargetSign()
		self._mainViewFacade:setSelectTarget(false)
		self._pathArrow:clearSkillArea()
		self:_drawHaloLinkForTargetUnit(unit, lastTargetUnionIndex)
	end

	self:_signAllSelectableUnit()
end

function BattleUnitOperator:_drawHaloLinkForTargetUnit(unit, lastTargetUnionIndex)
	local lastTargetUnit = self._unitMgr:getUnitOnUnionIndex(lastTargetUnionIndex)

	if lastTargetUnit == unit then
		return
	end

	if lastTargetUnit then
		self._haloLinks:clearHaloLinksForUnit(lastTargetUnit.property:getEntityId())
	end

	if unit then
		self._haloLinks:drawHaloLinksForUnit(unit.property:getEntityId())
	end
end

function BattleUnitOperator:_signAOESkillArea()
	if not self._targetUnionIndex then
		return
	end

	local targetUnionIndex = self._targetUnionIndex

	self._pathArrow:clearSkillArea()

	local skillMO = self._focusUnit.skill:getActiveSkillById(self._selectedSkillId)

	if not skillMO then
		return
	end

	local aoeType = skillMO:getAoeType()

	if not aoeType or aoeType == BattleEnum.AOEType.NONE then
		return
	end

	local shape = skillMO:generateSkillRangeShape()
	local pathFinder = self._sharedPathFinder
	local unitUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(self._focusUnit.transform:getCoordinates())

	pathFinder:signSkillRangeArea(shape, targetUnionIndex, unitUnionIndex)
	shape:returnSelf()

	local unitMgr = self._unitMgr
	local focusUnit = self._focusUnit
	local resultNodeArray = pathFinder:getNodeArray()
	local isBlueSign = aoeType == BattleEnum.AOEType.BUFF

	for _, resultNode in resultNodeArray:ipairs() do
		if resultNode.isSkillArea then
			local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(resultNode:getCoordinates())

			self._pathArrow:signSkillAreaCell(unionIndex, isBlueSign)
		end
	end
end

function BattleUnitOperator:_clearTargetUnionIndex()
	self:_switchTargetUnionIndex(false)
	self:_updateCompareViewInfo()
end

function BattleUnitOperator:_clearSelectedSkill()
	self._selectedSkillId = false
	self._hasAnyAttackableTarget = false
end

function BattleUnitOperator:_updateCompareViewInfo()
	if self._targetUnionIndex then
		local forecastResult = self._forecastMgr:getActiveForecastResult()

		self._mainViewFacade:showCompareView(forecastResult)
		self._forecastDrawing:drawForecastResult(forecastResult)
	else
		self._mainViewFacade:hideCompareView()
		self._forecastDrawing:clearForecastResult()
	end
end

function BattleUnitOperator:_clearAllSign()
	self:_clearAllSelectableSign()
	self:_clearTranportArea()
	self._boardMgr:resetAllSign()
	self._pathArrow:hideFocusSign()
	self._pathArrow:hideTargetSign()
	self._pathArrow:hideTransportSign()
	self._pathArrow:clearPath()
	self._forecastDrawing:clearAllAiForecast()
	self._haloLinks:clearAllLinkLine()
end

function BattleUnitOperator:_clearAllSelectableSign()
	local units = self._unitMgr:getAllUnits()

	self._pathArrow:hideAllSelectableSign()

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			unit.uiProxy:clearRestrainRelation()
		end
	end
end

function BattleUnitOperator:_clearTranportArea()
	self._pathArrow:clearTranportArea()
end

function BattleUnitOperator:getOriginUnionIndex()
	return self._originUnionIndex
end

function BattleUnitOperator:getFocusUnit()
	return self._focusUnit
end

function BattleUnitOperator:getForecastUnit()
	return self._forecastUnit
end

function BattleUnitOperator:_createForecastUnitAndSetPos(unionIndex)
	if self._originUnionIndex == unionIndex then
		self:_clearForecastUnit()

		return
	end

	if not self._forecastUnit then
		self._forecastUnit = self._unitMgr:createForecastUnit(self._focusUnit, unionIndex)
	end

	self._boardMgr:setForecastUnionIndex(self._forecastUnit, unionIndex)

	return self._forecastUnit
end

function BattleUnitOperator:_clearForecastUnit()
	if self._forecastUnit then
		self._pathArrow:removeForecastUnit()
		self._unitMgr:removeForecastUnit(BattleEnum.ForecastUnitType.Move)

		self._forecastUnit = false

		if self._pathArrow then
			self._pathArrow:clearPath()
		end
	end
end

function BattleUnitOperator:createTransportForecastAndSetPos(unionIndex)
	if not self._transportForecastUnit then
		local targetUnit = self._unitMgr:getUnitOnUnionIndex(self._targetUnionIndex)

		if not targetUnit then
			return
		end

		self._transportForecastUnit = self._unitMgr:createForecastUnit(targetUnit, unionIndex, BattleEnum.ForecastUnitType.Transport)
	end

	self._boardMgr:setForecastUnionIndex(self._transportForecastUnit, unionIndex)

	return self._transportForecastUnit
end

function BattleUnitOperator:clearTransportForecastUnit()
	if self._transportForecastUnit then
		self._unitMgr:removeForecastUnit(BattleEnum.ForecastUnitType.Transport)

		self._transportForecastUnit = false
	end
end

function BattleUnitOperator:_setOriginalUnionIndex(unionIndex)
	self._originUnionIndex = unionIndex

	if self._focusUnit then
		self._focusUnit.transform:setOriginalUnionIndex(unionIndex)
	end
end

return BattleUnitOperator
