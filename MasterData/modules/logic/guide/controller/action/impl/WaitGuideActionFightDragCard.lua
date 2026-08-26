-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightDragCard.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightDragCard", package.seeall)

local WaitGuideActionFightDragCard = class("WaitGuideActionFightDragCard", BaseGuideAction)

function WaitGuideActionFightDragCard:onStart(context)
	WaitGuideActionFightDragCard.super.onStart(self, context)

	local temp = string.splitToNumber(self.actionParam, "#")
	local from = temp[1]
	local tos = {}

	for i = 2, #temp do
		local to = temp[i]

		table.insert(tos, to)
	end

	GuideViewMgr.instance:enableDrag(true)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.FightMoveCard, {
		from = from,
		tos = tos
	}, self.guideId)
	FightController.instance:registerCallback(FightEvent.OnGuideDragCard, self._onGuideDragCard, self)
end

function WaitGuideActionFightDragCard:_onGuideDragCard()
	FightController.instance:unregisterCallback(FightEvent.OnGuideDragCard, self._onGuideDragCard, self)
	self:onDone(true)
end

function WaitGuideActionFightDragCard:clearWork()
	GuideViewMgr.instance:enableDrag(false)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.FightMoveCard, nil, self.guideId)
	FightController.instance:unregisterCallback(FightEvent.OnGuideDragCard, self._onGuideDragCard, self)
end

return WaitGuideActionFightDragCard
