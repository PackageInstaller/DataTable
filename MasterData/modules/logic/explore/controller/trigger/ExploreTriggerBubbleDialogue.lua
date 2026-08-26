-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerBubbleDialogue.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerBubbleDialogue", package.seeall)

local ExploreTriggerBubbleDialogue = class("ExploreTriggerBubbleDialogue", ExploreTriggerBase)

function ExploreTriggerBubbleDialogue:handle(id, unit)
	local view = unit.uiComp:addUI(ExploreUnitDialogueView)

	view:setDialogueId(id)
	self:onStepDone(true)
end

return ExploreTriggerBubbleDialogue
