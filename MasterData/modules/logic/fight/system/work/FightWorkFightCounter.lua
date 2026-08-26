-- chunkname: @modules/logic/fight/system/work/FightWorkFightCounter.lua

module("modules.logic.fight.system.work.FightWorkFightCounter", package.seeall)

local FightWorkFightCounter = class("FightWorkFightCounter", FightEffectBase)

function FightWorkFightCounter:onStart()
	local id = self.actEffectData.effectNum
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if id == 13 and entity then
		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("fight_counter_float13"), {
			luaLang("multiple"),
			self.actEffectData.configEffect
		})

		FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.buff, str, 1, false)
	end

	self:onDone(true)
end

function FightWorkFightCounter:clearWork()
	return
end

return FightWorkFightCounter
