-- chunkname: @modules/logic/fight/controller/FightEventExtend.lua

module("modules.logic.fight.controller.FightEventExtend", package.seeall)

local FightEventExtend = class("FightEventExtend")

function FightEventExtend:addConstEvents()
	FightController.instance:registerCallback(FightEvent.StageChanged, self.onStageChange, self)
end

function FightEventExtend:onStageChange(stageType)
	if stageType ~= FightStageMgr.StageType.Operate then
		return
	end

	local cards = FightDataHelper.handCardMgr.handCard

	for _, card in ipairs(cards) do
		local entityMO = FightDataHelper.entityMgr:getById(card.uid)

		if entityMO and FightCardDataHelper.isBigSkill(card.skillId) then
			FightController.instance:dispatchEvent(FightEvent.OnGuideGetUniqueCard)

			return
		end
	end
end

return FightEventExtend
