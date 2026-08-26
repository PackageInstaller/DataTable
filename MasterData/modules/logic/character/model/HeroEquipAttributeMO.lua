-- chunkname: @modules/logic/character/model/HeroEquipAttributeMO.lua

module("modules.logic.character.model.HeroEquipAttributeMO", package.seeall)

local HeroEquipAttributeMO = pureTable("HeroEquipAttributeMO")

function HeroEquipAttributeMO:init(info)
	self.id = info.id
	self.equipAttr = HeroAttributeMO.New()

	self.equipAttr:init(info.equipAttr)
end

return HeroEquipAttributeMO
