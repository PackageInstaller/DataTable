-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapStoryDialogueFlow.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapStoryDialogueFlow", package.seeall)

local Rouge2_MapStoryDialogueFlow = class("Rouge2_MapStoryDialogueFlow", Rouge2_MapDialogueBaseFlow)

function Rouge2_MapStoryDialogueFlow:addAfterPlayWork(flow)
	if self:getStepNum() <= 0 then
		return
	end

	flow:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;onSwitch2SelectChoice"))
end

return Rouge2_MapStoryDialogueFlow
