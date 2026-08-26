-- chunkname: @modules/logic/fight/system/work/FightWorkKill110.lua

module("modules.logic.fight.system.work.FightWorkKill110", package.seeall)

local FightWorkKill110 = class("FightWorkKill110", FightEffectBase)

function FightWorkKill110:onStart()
	local hurtInfo = self.actEffectData.hurtInfo
	local entityId = self.actEffectData.targetId
	local entityData = FightDataHelper.entityMgr:getById(entityId)

	if entityData then
		local currentHp = entityData.currentHp
		local reduceHp = hurtInfo.reduceHp
		local oldValue = currentHp + reduceHp

		FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, entityId, oldValue, currentHp)
	end

	FightMsgMgr.sendMsg(FightMsgId.EntityHurt, entityId, hurtInfo)

	return self:onDone(true)
end

return FightWorkKill110
