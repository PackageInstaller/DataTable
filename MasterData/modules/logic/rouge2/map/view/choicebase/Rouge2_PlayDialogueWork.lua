-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_PlayDialogueWork.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_PlayDialogueWork", package.seeall)

local Rouge2_PlayDialogueWork = class("Rouge2_PlayDialogueWork", BaseWork)

function Rouge2_PlayDialogueWork:onStart()
	self._flow = FlowSequence.New()

	local isPoping = Rouge2_PopController.instance:isPopping()

	if isPoping then
		self._flow:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;onPopViewDone"))
	end

	self._flow:addWork(FunctionWork.New(self._triggerPlay, self))
	self._flow:addWork(Rouge2_WaitDialogueDoneWork.New())
	self._flow:registerDoneListener(self._onDialogueDone, self)
	self._flow:start()
end

function Rouge2_PlayDialogueWork:_triggerPlay()
	Rouge2_MapModel.instance:setPlayingDialogue(false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onReceiveChoiceEvent)
end

function Rouge2_PlayDialogueWork:_onDialogueDone()
	self:onDone(true)
end

function Rouge2_PlayDialogueWork:clearWork()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

return Rouge2_PlayDialogueWork
