-- chunkname: @modules/logic/fight/system/work/FightWorkAct174MonsterAiCard.lua

module("modules.logic.fight.system.work.FightWorkAct174MonsterAiCard", package.seeall)

local FightWorkAct174MonsterAiCard = class("FightWorkAct174MonsterAiCard", FightEffectBase)

function FightWorkAct174MonsterAiCard:onStart()
	self:com_sendMsg(FightMsgId.Act174MonsterAiCard)
	self:onDone(true)
end

function FightWorkAct174MonsterAiCard:_onPlayCardOver()
	return
end

return FightWorkAct174MonsterAiCard
