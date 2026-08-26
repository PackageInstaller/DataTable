-- chunkname: @modules/logic/fight/system/work/FightWorkEffectShieldChange.lua

module("modules.logic.fight.system.work.FightWorkEffectShieldChange", package.seeall)

local FightWorkEffectShieldChange = class("FightWorkEffectShieldChange", FightEffectBase)

function FightWorkEffectShieldChange:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)
	local effectNum = self.actEffectData.effectNum

	if entity and entity.nameUI and effectNum > 0 then
		entity.nameUI:addHp(effectNum)
		entity.nameUI:setShield(0)
		FightFloatMgr.instance:float(entity.id, FightEnum.FloatType.heal, effectNum, nil, self.actEffectData.buffActId == 1)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, effectNum)
		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, entity, 0)
	end

	self:onDone(true)
end

return FightWorkEffectShieldChange
