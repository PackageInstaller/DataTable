-- chunkname: @modules/logic/fight/system/work/LY/FightWorkToCardAreaRedOrBlue.lua

module("modules.logic.fight.system.work.LY.FightWorkToCardAreaRedOrBlue", package.seeall)

local FightWorkToCardAreaRedOrBlue = class("FightWorkToCardAreaRedOrBlue", FightEffectBase)

function FightWorkToCardAreaRedOrBlue:onStart()
	FightPlayCardModel.instance:setUsedCard(self.actEffectData.cardInfoList)
	FightController.instance:dispatchEvent(FightEvent.SetUseCards)
	FightViewPartVisible.set(false, false, false, false, true)
	self:onDone(true)
end

return FightWorkToCardAreaRedOrBlue
