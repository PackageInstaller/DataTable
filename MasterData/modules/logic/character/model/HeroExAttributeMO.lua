-- chunkname: @modules/logic/character/model/HeroExAttributeMO.lua

module("modules.logic.character.model.HeroExAttributeMO", package.seeall)

local HeroExAttributeMO = pureTable("HeroExAttributeMO")

function HeroExAttributeMO:init(info)
	self.cri = info.cri
	self.recri = info.recri
	self.criDmg = info.criDmg
	self.criDef = info.criDef
	self.addDmg = info.addDmg
	self.dropDmg = info.dropDmg
end

return HeroExAttributeMO
