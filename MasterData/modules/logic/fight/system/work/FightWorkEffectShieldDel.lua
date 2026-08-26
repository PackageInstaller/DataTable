-- chunkname: @modules/logic/fight/system/work/FightWorkEffectShieldDel.lua

module("modules.logic.fight.system.work.FightWorkEffectShieldDel", package.seeall)

local FightWorkEffectShieldDel = class("FightWorkEffectShieldDel", FightEffectBase)

function FightWorkEffectShieldDel:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if entity and entity.nameUI then
		entity.nameUI:setShield(0)
	end

	if entity then
		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, entity, 0)
	end

	self:onDone(true)
end

return FightWorkEffectShieldDel
