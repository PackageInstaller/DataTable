-- chunkname: @modules/logic/fight/system/work/FightWorkChangeToTempCard.lua

module("modules.logic.fight.system.work.FightWorkChangeToTempCard", package.seeall)

local FightWorkChangeToTempCard = class("FightWorkChangeToTempCard", FightEffectBase)

function FightWorkChangeToTempCard:onStart()
	if not FightCardDataHelper.cardChangeIsMySide(self.actEffectData) then
		self:onDone(true)

		return
	end

	local indexes = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if #indexes > 0 then
		local handCard = FightDataHelper.handCardMgr.handCard

		for i, v in ipairs(indexes) do
			if handCard[v] then
				FightController.instance:dispatchEvent(FightEvent.ChangeToTempCard, v)
			end
		end
	end

	self:onDone(true)
end

function FightWorkChangeToTempCard:clearWork()
	return
end

return FightWorkChangeToTempCard
