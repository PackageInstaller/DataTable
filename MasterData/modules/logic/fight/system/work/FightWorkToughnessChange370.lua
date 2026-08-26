-- chunkname: @modules/logic/fight/system/work/FightWorkToughnessChange370.lua

module("modules.logic.fight.system.work.FightWorkToughnessChange370", package.seeall)

local FightWorkToughnessChange370 = class("FightWorkToughnessChange370", FightEffectBase)

function FightWorkToughnessChange370:onStart()
	FightMsgMgr.sendMsg(FightMsgId.ChangeEntityToughness, self.actEffectData.targetId)

	return self:onDone(true)
end

return FightWorkToughnessChange370
