-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_WaitDialogueDoneWork.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_WaitDialogueDoneWork", package.seeall)

local Rouge2_WaitDialogueDoneWork = class("Rouge2_WaitDialogueDoneWork", BaseWork)

function Rouge2_WaitDialogueDoneWork:onStart()
	local isPlaying = Rouge2_MapModel.instance:isPlayingDialogue()

	if not isPlaying then
		return self:onDone(true)
	end

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onPlayDialogueDone, self._onDialogueDone, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onDialogueFlowDone, self._onDialogueDone, self)
end

function Rouge2_WaitDialogueDoneWork:_onDialogueDone()
	return self:onDone(true)
end

function Rouge2_WaitDialogueDoneWork:clearWork()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onPlayDialogueDone, self._onDialogueDone, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onDialogueFlowDone, self._onDialogueDone, self)
end

return Rouge2_WaitDialogueDoneWork
