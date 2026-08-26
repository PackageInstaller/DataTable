-- chunkname: @modules/logic/fight/model/mo/FightHeroAttribute.lua

module("modules.logic.fight.model.mo.FightHeroAttribute", package.seeall)

local FightHeroAttribute = pureTable("FightHeroAttribute")

function FightHeroAttribute:init(info)
	self.hp = info.hp
	self.attack = info.attack
	self.defense = info.defense
	self.crit = info.crit
	self.crit_damage = info.crit_damage
end

return FightHeroAttribute
