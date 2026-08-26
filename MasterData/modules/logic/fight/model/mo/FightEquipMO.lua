-- chunkname: @modules/logic/fight/model/mo/FightEquipMO.lua

module("modules.logic.fight.model.mo.FightEquipMO", package.seeall)

local FightEquipMO = pureTable("FightEquipMO")

function FightEquipMO:ctor()
	self.heroUid = nil
	self.equipUid = nil
	self.equipId = nil
end

return FightEquipMO
