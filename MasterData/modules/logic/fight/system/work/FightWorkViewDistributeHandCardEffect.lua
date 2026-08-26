-- chunkname: @modules/logic/fight/system/work/FightWorkViewDistributeHandCardEffect.lua

module("modules.logic.fight.system.work.FightWorkViewDistributeHandCardEffect", package.seeall)

local FightWorkViewDistributeHandCardEffect = class("FightWorkViewDistributeHandCardEffect", BaseWork)

function FightWorkViewDistributeHandCardEffect:onConstructor()
	return
end

function FightWorkViewDistributeHandCardEffect:onStart()
	local cardList = self.context.cards
	local distributeData = cardList[#cardList]

	self.flow = FightWorkFlowSequence.New()

	if distributeData.clientData.custom_addFromRefrigerator then
		self.flow:registWork(FigthWorkCardDistributeEffectByRefrigerator, self.context.handCardItemList, distributeData)
	else
		self.flow:addWork(FigthCardDistributeEffect.New())
	end

	self.flow:registFinishCallback(self.onFlowDone, self)
	self.flow:start(self.context)
end

function FightWorkViewDistributeHandCardEffect:onFlowDone()
	return self:onDone(true)
end

function FightWorkViewDistributeHandCardEffect:clearWork()
	if self.flow then
		self.flow:disposeSelf()
	end
end

return FightWorkViewDistributeHandCardEffect
