-- chunkname: @modules/logic/fight/system/work/FightWorkChangeShield.lua

module("modules.logic.fight.system.work.FightWorkChangeShield", package.seeall)

local FightWorkChangeShield = class("FightWorkChangeShield", FightEffectBase)

function FightWorkChangeShield:onStart()
	local entityId = self.actEffectData.targetId

	self:com_sendFightEvent(FightEvent.ChangeShield, entityId)

	if self.actEffectData.reserveId == "1" then
		FightFloatMgr.instance:float(entityId, FightEnum.FloatType.addShield, "+" .. self.actEffectData.effectNum, nil, self.actEffectData.effectNum1 == 1)
	end

	self:onDone(true)
end

function FightWorkChangeShield:_onPlayCardOver()
	return
end

return FightWorkChangeShield
