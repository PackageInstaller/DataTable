-- chunkname: @modules/logic/fight/system/work/FightWorkDelCardAndDamage.lua

module("modules.logic.fight.system.work.FightWorkDelCardAndDamage", package.seeall)

local FightWorkDelCardAndDamage = class("FightWorkDelCardAndDamage", FightEffectBase)

function FightWorkDelCardAndDamage:onStart()
	local entity = self.actEffectData.teamType == FightEnum.TeamType.EnemySide and FightHelper.getEntity(FightEntityScene.EnemySideId) or FightHelper.getEntity(FightEntityScene.MySideId)

	if entity then
		local effectWrap = entity.effect:addGlobalEffect("v2a2_znps/znps_unique_03_hit", nil, 1)

		effectWrap:setRenderOrder(20000)

		local posX = self.actEffectData.teamType == FightEnum.TeamType.EnemySide and -6.14 or 6.14

		effectWrap:setLocalPos(posX, 1.65, -1.74)
		AudioMgr.instance:trigger(410000104)
	end

	self:onDone(true)
end

function FightWorkDelCardAndDamage:clearWork()
	return
end

return FightWorkDelCardAndDamage
