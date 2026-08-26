-- chunkname: @modules/logic/fight/system/work/FightWorkPlayHandCard.lua

module("modules.logic.fight.system.work.FightWorkPlayHandCard", package.seeall)

local FightWorkPlayHandCard = class("FightWorkPlayHandCard", FightWorkItem)
local counter = 0

FightWorkPlayHandCard.playing = 0

function FightWorkPlayHandCard:onConstructor(index, toId, discardIndex, selectedSkillId, cardParam1)
	counter = counter + 1
	FightWorkPlayHandCard.playing = counter
	self.index = index
	self.toId = toId
	self.discardIndex = discardIndex
	self.selectedSkillId = selectedSkillId
	self.cardParam1 = cardParam1
end

function FightWorkPlayHandCard:onStart()
	local flow = self:com_registFlowSequence()
	local work = FightMsgMgr.sendMsg(FightMsgId.RegistPlayHandCardWork, self.index, self.toId, self.discardIndex, self.selectedSkillId, self.cardParam1)

	flow:addWork(work)
	self:playWorkAndDone(flow)
end

function FightWorkPlayHandCard:onDestructor()
	counter = counter - 1
	FightWorkPlayHandCard.playing = counter
end

return FightWorkPlayHandCard
