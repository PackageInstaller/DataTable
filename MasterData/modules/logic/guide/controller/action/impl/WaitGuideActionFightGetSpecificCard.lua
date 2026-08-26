-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionFightGetSpecificCard.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionFightGetSpecificCard", package.seeall)

local WaitGuideActionFightGetSpecificCard = class("WaitGuideActionFightGetSpecificCard", BaseGuideAction)

function WaitGuideActionFightGetSpecificCard:ctor(guideId, stepId, actionParam)
	WaitGuideActionFightGetSpecificCard.super.ctor(self, guideId, stepId, actionParam)

	local temp = string.split(actionParam, "#")

	self._cardSkillId = tonumber(temp[1])
end

function WaitGuideActionFightGetSpecificCard:onStart(context)
	WaitGuideActionFightGetSpecificCard.super.onStart(self, context)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, self._onDistributeCardDone, self)
end

function WaitGuideActionFightGetSpecificCard:_onRoundStart()
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local cards = FightDataHelper.handCardMgr.handCard

		for i, card in ipairs(cards) do
			if self._cardSkillId == card.skillId then
				if FightDataHelper.stateMgr:getIsAuto() then
					FightController.instance:dispatchEvent(FightEvent.OnGuideStopAutoFight)
				end

				GuideModel.instance:setFlag(GuideModel.GuideFlag.FightSetSpecificCardIndex, i)
				self:clearWork()
				self:onDone(true)
			end
		end
	end
end

function WaitGuideActionFightGetSpecificCard:_onDistributeCardDone()
	local cards = FightDataHelper.handCardMgr.handCard

	for i, card in ipairs(cards) do
		if self._cardSkillId == card.skillId then
			if FightDataHelper.stateMgr:getIsAuto() then
				FightController.instance:dispatchEvent(FightEvent.OnGuideStopAutoFight)
			end

			GuideModel.instance:setFlag(GuideModel.GuideFlag.FightSetSpecificCardIndex, i)
			self:clearWork()
			self:onDone(true)
		end
	end
end

function WaitGuideActionFightGetSpecificCard:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, self._onRoundStart, self)
end

return WaitGuideActionFightGetSpecificCard
