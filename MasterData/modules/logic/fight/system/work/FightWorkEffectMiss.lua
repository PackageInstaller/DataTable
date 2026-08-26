-- chunkname: @modules/logic/fight/system/work/FightWorkEffectMiss.lua

module("modules.logic.fight.system.work.FightWorkEffectMiss", package.seeall)

local FightWorkEffectMiss = class("FightWorkEffectMiss", FightEffectBase)

function FightWorkEffectMiss:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity then
		FightFloatMgr.instance:float(self.actEffectData.targetId, FightEnum.FloatType.buff, luaLang("fight_float_miss"), FightEnum.BuffFloatEffectType.Good, false)
	end

	self:onDone(true)
end

return FightWorkEffectMiss
