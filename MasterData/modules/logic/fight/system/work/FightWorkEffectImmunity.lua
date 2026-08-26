-- chunkname: @modules/logic/fight/system/work/FightWorkEffectImmunity.lua

module("modules.logic.fight.system.work.FightWorkEffectImmunity", package.seeall)

local FightWorkEffectImmunity = class("FightWorkEffectImmunity", BaseWork)

function FightWorkEffectImmunity:onStart()
	FightFloatMgr.instance:float(self.actEffectData.targetId, FightEnum.FloatType.buff, luaLang("fight_buff_reject"), FightEnum.BuffFloatEffectType.Good, false)
	self:onDone(true)
end

return FightWorkEffectImmunity
