-- chunkname: @modules/logic/fight/system/work/asfd/effectwork/FightWorkFixAttrTeamEnergy.lua

module("modules.logic.fight.system.work.asfd.effectwork.FightWorkFixAttrTeamEnergy", package.seeall)

local FightWorkFixAttrTeamEnergy = class("FightWorkFixAttrTeamEnergy", FightEffectBase)

function FightWorkFixAttrTeamEnergy:onStart()
	self:onDone(true)
end

return FightWorkFixAttrTeamEnergy
