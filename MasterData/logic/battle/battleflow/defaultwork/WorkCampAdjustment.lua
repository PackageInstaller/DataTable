-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkCampAdjustment.lua

module("logic.battle.battleflow.defaultwork.WorkCampAdjustment", package.seeall)

local WorkCampAdjustment = class("WorkCampAdjustment", WorkBase)

function WorkCampAdjustment:onEnter(context)
	self:_setEvent(true)
	BattleDispatcher:dispatchEvent(BattleEventType.OnBeginCampAdjustment)
	BattleDispatcher:dispatchEvent(BattleEventType.OnEnableCullingChanged, true)

	local settingModel = context.settingModel

	if not settingModel:isEnableCampAdjustment() then
		self:_requestEndReady()

		return
	end

	if context.model:isProxyMode() then
		self:_requestEndReady()

		return
	end

	local bornUnionIndexList = settingModel:getBornUnionIndexList()
	local lockedCharacterCodeList = settingModel:getLockedCharacterCodeList()

	if #bornUnionIndexList <= #lockedCharacterCodeList then
		self:_requestEndReady()

		return
	end

	local campAdjustment = context.campAdjustment

	campAdjustment:beginCampAdjustment()
	self:_updateUnitSigns()

	self._isEnableCampAdjustment = true

	local unitMgr = context.unitMgr
	local scenePickerHandler = context.scenePickerHandler

	scenePickerHandler:setForCampAdjustment()
	BattleMainViewFacade.instance:setVisible(true)
	BattleMainViewFacade.instance:setForCampAdjustment()
	BattleMainViewFacade.instance:setExplainPanelStatus(false, "BattleCampAdjust")
	BattleCampAdjustmentModel.instance:setEnableAdjustment(true)
	ViewMgr.instance:open(ViewName.BattleCampAdjustment)
end

function WorkCampAdjustment:onExit(isInterrupt)
	self:_setEvent(false)

	if not isInterrupt then
		local model = self.context.model

		model:setPhase(BattleEnum.Phase.NORMAL)

		if self._isEnableCampAdjustment then
			BattleMainViewFacade.instance:setForNormal()
			BattleMainViewFacade.instance:setExplainPanelStatus(true, "BattleCampAdjust")
			BattleMainViewFacade.instance:setVisible(false)
			BattleMainViewFacade.instance:setForMainVisible(false)
			ViewMgr.instance:close(ViewName.BattleCampAdjustment)
		end
	end

	local scenePickerHandler = self.context.scenePickerHandler
	local campAdjustment = self.context.campAdjustment

	scenePickerHandler:setForNormal()

	self._isEnableCampAdjustment = false

	campAdjustment:endCampAdjustment()
	BattleDispatcher:dispatchEvent(BattleEventType.OnEndCampAdjustment)
end

function WorkCampAdjustment:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_END_READY, self._onReceiveEndReady, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_END_READY, self._onReceiveEndReady, self)
	end
end

function WorkCampAdjustment:_requestEndReady()
	if self.context.model:isRecord() then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_END_READY, true)

		return
	end

	BattleAgent.instance:sendEndReadyRequest()
end

function WorkCampAdjustment:_onReceiveEndReady()
	self:onDone(WorkResult.Succeed)
end

function WorkCampAdjustment:_updateUnitSigns()
	local unitMgr = self.context.unitMgr
	local model = self.context.model
	local units = unitMgr:getUnitsByCampId(model:getOperateCampId())

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) and BattleCampAdjustmentUtil.isLockedUnit(unit) then
			unit.uiProxy:setSignEnable(BattleUnitCompUIProxy.SignEnum.LOCKED, true)
		end
	end

	units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if unit.property:isMaskEnable(BattleUnitFlagMask.MaskAttackable) then
			if BattleCampAdjustmentModel.instance:isAssistantCharacter(unit.property:getEntityCode()) then
				unit.uiProxy:setSignEnable(BattleUnitCompUIProxy.SignEnum.ASSISTANT, true)
			end

			if BattleCampAdjustmentModel.instance:isKillCharacter(unit.property:getEntityCode()) and BattleCampRelationUtil.isEnemyOfOperateCamp(unit) then
				unit.uiProxy:setSignEnable(BattleUnitCompUIProxy.SignEnum.KILL, true)
			end

			if BattleCampAdjustmentModel.instance:isProtectCharacter(unit.property:getEntityCode()) then
				unit.uiProxy:setSignEnable(BattleUnitCompUIProxy.SignEnum.PROTECT, true)
			end
		end
	end
end

return WorkCampAdjustment
