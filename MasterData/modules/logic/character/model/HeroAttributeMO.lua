-- chunkname: @modules/logic/character/model/HeroAttributeMO.lua

module("modules.logic.character.model.HeroAttributeMO", package.seeall)

local HeroAttributeMO = pureTable("HeroAttributeMO")

function HeroAttributeMO:init(info)
	self.original_max_hp = info.hp
	self.hp = info.hp
	self.attack = info.attack
	self.defense = info.defense
	self.mdefense = info.mdefense
	self.technic = info.technic
	self.multiHpIdx = info.multiHpIdx
	self.multiHpNum = info.multiHpNum
end

function HeroAttributeMO:getCurMultiHpIndex()
	return self.multiHpIdx
end

return HeroAttributeMO
