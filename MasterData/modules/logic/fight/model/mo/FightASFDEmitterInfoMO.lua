-- chunkname: @modules/logic/fight/model/mo/FightASFDEmitterInfoMO.lua

module("modules.logic.fight.model.mo.FightASFDEmitterInfoMO", package.seeall)

local FightASFDEmitterInfoMO = pureTable("FightASFDEmitterInfoMO")

function FightASFDEmitterInfoMO:init(info)
	self.energy = info.energy
end

function FightASFDEmitterInfoMO:changeEnergy(offset)
	self.energy = self.energy or 0
	self.energy = self.energy + offset
end

return FightASFDEmitterInfoMO
