-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameCharacterMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameCharacterMo", package.seeall)

local MatchGameCharacterMo = pureTable("MatchGameCharacterMo")

function MatchGameCharacterMo:init(info)
	self.heroId = info.heroId
	self.id = tonumber(self.heroId)
	self.heroCo = lua_activity244_character.configDict[self.heroId]
	self.level = info.level
end

function MatchGameCharacterMo:initByLocal(heroId, level)
	self.id = tonumber(-heroId)
	self.heroId = heroId
	self.level = level
	self.heroCo = lua_activity244_character.configDict[self.heroId]
end

function MatchGameCharacterMo:isTrial()
	return self.heroCo and self.heroCo.isTrial == 1
end

function MatchGameCharacterMo:getAttrValue(attrType)
	local _, baseValue = MatchGameModel.instance:getCharacterAttrValue(self.heroId, self.level, attrType)

	return baseValue or 0
end

function MatchGameCharacterMo:getTotalAttrValue(attrType)
	local totalValue = MatchGameModel.instance:getCharacterAttrValue(self.heroId, self.level, attrType)

	return totalValue or 0
end

return MatchGameCharacterMo
