-- chunkname: @modules/logic/fight/system/work/FightWorkCardInvalid.lua

module("modules.logic.fight.system.work.FightWorkCardInvalid", package.seeall)

local FightWorkCardInvalid = class("FightWorkCardInvalid", FightEffectBase)

function FightWorkCardInvalid:onStart()
	local version = FightModel.instance:getVersion()

	if version >= 1 and self.actEffectData.teamType ~= FightEnum.TeamType.MySide then
		local roundData = FightDataHelper.roundMgr:getPreRoundData()

		if roundData then
			local list = roundData:getAIUseCardMOList()
			local cardInfoMO = list[self.actEffectData.effectNum]

			if cardInfoMO then
				cardInfoMO.custom_done = true
			end
		end

		FightController.instance:dispatchEvent(FightEvent.InvalidEnemyUsedCard, self.actEffectData.effectNum)
		self:onDone(true)

		return
	end

	FightPlayCardModel.instance:playCard(self.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.InvalidUsedCard, self.actEffectData.effectNum, self.actEffectData.configEffect)
	self:com_registTimer(self._delayDone, 1 / FightModel.instance:getUISpeed())
end

function FightWorkCardInvalid:_delayDone()
	self:onDone(true)
end

function FightWorkCardInvalid:clearWork()
	return
end

return FightWorkCardInvalid
