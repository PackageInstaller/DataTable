-- chunkname: @modules/logic/fight/system/work/FightWorkToughnessRecover369.lua

module("modules.logic.fight.system.work.FightWorkToughnessRecover369", package.seeall)

local FightWorkToughnessRecover369 = class("FightWorkToughnessRecover369", FightEffectBase)

function FightWorkToughnessRecover369:onStart()
	FightMsgMgr.sendMsg(FightMsgId.ChangeEntityToughness, self.actEffectData.targetId)

	return self:onDone(true)
end

return FightWorkToughnessRecover369
