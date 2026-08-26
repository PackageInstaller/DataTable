-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapDialogueBaseFlow.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapDialogueBaseFlow", package.seeall)

local Rouge2_MapDialogueBaseFlow = class("Rouge2_MapDialogueBaseFlow", BaseWork)

function Rouge2_MapDialogueBaseFlow:ctor(dialogueList, playType)
	self._dialogueList = dialogueList
	self._playType = playType

	if dialogueList then
		self._stepNum = #dialogueList or 0
	end

	self._doneStepNum = 0
end

function Rouge2_MapDialogueBaseFlow:onStart(listComp)
	self._listComp = listComp

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.OnJumpToChoiceState, self._onJumpToChoiceState, self)

	self._flow = FlowSequence.New()

	self:addBeforePlayWork(self._flow)
	self:addOnPlayWork(self._flow)
	self:addAfterPlayWork(self._flow)
	self._flow:addWork(FunctionWork.New(self._onDialogueFlowDone, self))
	self._flow:start(listComp)
end

function Rouge2_MapDialogueBaseFlow:addOnPlayWork(flow)
	local playFlow = FlowSequence.New()

	for i, info in ipairs(self._dialogueList) do
		playFlow:addWork(self:_buildOneStepFlow(i, self._stepNum, info, self._playType))
	end

	playFlow:addWork(FunctionWork.New(self._onPlayDialogueDone, self))
	flow:addWork(playFlow)
end

function Rouge2_MapDialogueBaseFlow:addBeforePlayWork(flow)
	return
end

function Rouge2_MapDialogueBaseFlow:addAfterPlayWork(flow)
	return
end

function Rouge2_MapDialogueBaseFlow:_onPlayDialogueDone()
	Rouge2_MapModel.instance:setPlayingDialogue(false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onPlayDialogueDone)
end

function Rouge2_MapDialogueBaseFlow:_onDialogueFlowDone()
	self._listComp:_rebuildLayout()
	self:onDone(true)
end

function Rouge2_MapDialogueBaseFlow:_buildOneStepFlow(index, stepNum, info, playType)
	local flow = FlowSequence.New()

	flow:addWork(FunctionWork.New(self._listComp.showArrow, self._listComp, false))

	local itemWork = Rouge2_MapDialogueItemWork.New(index)

	itemWork:initInfo(info, playType)
	flow:addWork(itemWork)
	flow:addWork(WorkWaitSeconds.New(0.01))
	flow:addWork(FunctionWork.New(self._listComp.showArrow, self._listComp, index < stepNum))

	if index < stepNum and playType ~= Rouge2_MapEnum.DialoguePlayType.Directly then
		flow:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;onSwitchNextChoiceDialogue"))
		flow:addWork(FunctionWork.New(self._onSwitchToNextStepDialogue, self))
	end

	return flow
end

function Rouge2_MapDialogueBaseFlow:_onSwitchToNextStepDialogue()
	self._doneStepNum = self._doneStepNum + 1
end

function Rouge2_MapDialogueBaseFlow:_onJumpToChoiceState()
	self._jumpFlow = FlowSequence.New()

	for i = self._doneStepNum + 1, self._stepNum do
		self._jumpFlow:addWork(FunctionWork.New(self._quitSetDialogueDone, self))
		self._jumpFlow:addWork(WorkWaitSeconds.New(0.02))
		self._jumpFlow:addWork(FunctionWork.New(self._switch2NextDialogue, self))
	end

	self._jumpFlow:start()
end

function Rouge2_MapDialogueBaseFlow:_quitSetDialogueDone()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.quickSetDialogueDone)
end

function Rouge2_MapDialogueBaseFlow:_switch2NextDialogue()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSwitchNextChoiceDialogue)
end

function Rouge2_MapDialogueBaseFlow:clearWork()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end

	if self._jumpFlow then
		self._jumpFlow:destroy()

		self._jumpFlow = nil
	end

	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.OnJumpToChoiceState, self._onJumpToChoiceState, self)
end

function Rouge2_MapDialogueBaseFlow:getStepNum()
	return self._stepNum
end

return Rouge2_MapDialogueBaseFlow
