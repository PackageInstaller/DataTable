-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/GuideActionBuilder.lua

module("logic.extensions.guide.controller.GuideActionBuilder", package.seeall)

local GuideActionBuilder = class("GuideActionBuilder")

function GuideActionBuilder:ctor()
	self:_registerGuideAction()
end

function GuideActionBuilder:_registerGuideAction()
	self._guideActionMap = {}
	self._guideActionMap[GuideEnum.CompleteType.ClickAnywhere] = GuideActionClickMaskAnywhere
	self._guideActionMap[GuideEnum.CompleteType.ClickTargetControl] = GuideActionClickMask
	self._guideActionMap[GuideEnum.CompleteType.DragBeforeBattle] = GuideActionDragBeforeBattle
	self._guideActionMap[GuideEnum.CompleteType.CloseFullImageGuide] = GuideActionOpenImageHelp
	self._guideActionMap[GuideEnum.CompleteType.WaitForLoadScene] = GuideActionWaitForLoadScene
	self._guideActionMap[GuideEnum.CompleteType.WaitForAactionFinish] = GuideActionWaitForBattleActionFinish
	self._guideActionMap[GuideEnum.CompleteType.WaitForPlotFinish] = GuideActionWaitForPlotFinish
	self._guideActionMap[GuideEnum.CompleteType.SwipeTo] = GuideActionSwipeTo
	self._guideActionMap[GuideEnum.CompleteType.ClickAnywhereWithPassEvent] = GuideActionClickAnyWithPassEvent
	self._guideActionMap[GuideEnum.CompleteType.WaitForTime] = GuideActionWaitForTime
	self._guideActionMap[GuideEnum.CompleteType.CloseUI] = GuideActionCloseUI
	self._guideActionMap[GuideEnum.CompleteType.ShowOpenFunctionAnim] = GuideActionShowFunctionAnim
	self._guideActionMap[GuideEnum.CompleteType.ShowEnemyHint] = GuideActionShowEnemyHint
	self._guideActionMap[GuideEnum.CompleteType.EnterScene] = GuideActionEnterSpecifyScene
	self._guideActionMap[GuideEnum.CompleteType.OpenView] = GuideActionOpenSpecifyView
	self._guideActionMap[GuideEnum.CompleteType.WaitUIViewClose] = GuideActionWaitUIViewClose
	self._guideActionMap[GuideEnum.CompleteType.WaitCreateRole] = GuideActionWaitCreateRole
	self._guideActionMap[GuideEnum.CompleteType.WaitUICloseBySpecial] = GuideActionWaitUICloseBySpecial
	self._guideActionMap[GuideEnum.CompleteType.AgreeAirWorkProtocol] = GuideActionAgreeAirWorkProtocol
end

function GuideActionBuilder:buildActionFlow(guideId, stepId)
	local flow = FlowSequence.New()
	local stepCO = GuideConfig.instance:getGuideStepCO(guideId, stepId)

	if not stepCO then
		printError(string.format("guide_%d_%d stepCO is nil", guideId, stepId))

		return nil
	end

	local completeType = stepCO.completeType
	local guideControlType = stepCO.guideControlType

	if completeType == GuideEnum.CompleteType.AutoFinishWhenShowControl then
		if guideControlType == GuideEnum.GuideControlType.ActiveUI then
			local action = GuideActionActiveUI.New(guideId, stepId, stepCO)

			flow:addChild(action)
		elseif guideControlType == GuideEnum.GuideControlType.MoveCamera then
			local action = GuideActionMoveCamera.New(guideId, stepId, stepCO)

			flow:addChild(action)
		end
	else
		local guideActionCls = self._guideActionMap[completeType]

		if guideActionCls then
			local action = guideActionCls.New(guideId, stepId, stepCO)

			flow:addChild(action)
		elseif enableErrorLog then
			printError(string.format("unhandle guide complete type in [%s]—[%s] with [%s]", guideId, stepId, completeType))
		end
	end

	if #flow:getChildren() == 0 then
		printInfo(string.format("<color=#FFA500>guide_%d_%d has no action!</color>", guideId, stepId))
	end

	return flow
end

return GuideActionBuilder
