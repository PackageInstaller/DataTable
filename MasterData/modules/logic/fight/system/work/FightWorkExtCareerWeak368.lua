-- chunkname: @modules/logic/fight/system/work/FightWorkExtCareerWeak368.lua

module("modules.logic.fight.system.work.FightWorkExtCareerWeak368", package.seeall)

local FightWorkExtCareerWeak368 = class("FightWorkExtCareerWeak368", FightEffectBase)

function FightWorkExtCareerWeak368:onStart()
	FightMsgMgr.sendMsg(FightMsgId.ChangeEntityWeakness, self.actEffectData.targetId)

	return self:onDone(true)
end

return FightWorkExtCareerWeak368
