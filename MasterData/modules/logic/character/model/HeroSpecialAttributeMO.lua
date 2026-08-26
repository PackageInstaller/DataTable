-- chunkname: @modules/logic/character/model/HeroSpecialAttributeMO.lua

module("modules.logic.character.model.HeroSpecialAttributeMO", package.seeall)

local HeroSpecialAttributeMO = pureTable("HeroSpecialAttributeMO")

function HeroSpecialAttributeMO:init(info)
	self.revive = info.revive
	self.heal = info.heal
	self.absorb = info.absorb
	self.defenseIgnore = info.defenseIgnore
	self.clutch = info.clutch
	self.finalAddDmg = info.finalAddDmg
	self.finalDropDmg = info.finalDropDmg
end

return HeroSpecialAttributeMO
