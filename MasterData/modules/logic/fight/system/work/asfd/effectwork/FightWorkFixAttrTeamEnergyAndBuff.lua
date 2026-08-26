-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkFixAttrTeamEnergyAndBuff.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkFixAttrTeamEnergyAndBuff", package.seeall)

local FightWorkFixAttrTeamEnergyAndBuff = class("FightWorkFixAttrTeamEnergyAndBuff", FightEffectBase)

function FightWorkFixAttrTeamEnergyAndBuff:onStart()
	self:onDone(true)
end

return FightWorkFixAttrTeamEnergyAndBuff
