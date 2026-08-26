-- chunkname: @modules/logic/fight/system/work/FightWorkToughnessReset375.lua

module("modules.logic.fight.system.work.FightWorkToughnessReset375", package.seeall)

local FightWorkToughnessReset375 = class("FightWorkToughnessReset375", FightEffectBase)

function FightWorkToughnessReset375:onStart()
	FightMsgMgr.sendMsg(FightMsgId.ChangeEntityToughness, self.actEffectData.targetId)

	return self:onDone(true)
end

return FightWorkToughnessReset375
