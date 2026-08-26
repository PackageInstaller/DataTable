-- chunkname: @modules/logic/character/model/CharacterMainHeroMO.lua

module("modules.logic.character.model.CharacterMainHeroMO", package.seeall)

local CharacterMainHeroMO = pureTable("CharacterMainHeroMO")

function CharacterMainHeroMO:init(heroMO, skinId, isRandom)
	self.heroMO = heroMO
	self.skinId = skinId
	self.id = skinId
	self.isRandom = isRandom
end

return CharacterMainHeroMO
