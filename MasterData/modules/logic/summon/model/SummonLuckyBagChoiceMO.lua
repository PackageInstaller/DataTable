-- chunkname: @modules/logic/summon/model/SummonLuckyBagChoiceMO.lua

module("modules.logic.summon.model.SummonLuckyBagChoiceMO", package.seeall)

local SummonLuckyBagChoiceMO = pureTable("SummonLuckyBagChoiceMO")

function SummonLuckyBagChoiceMO:init(heroId)
	self.id = heroId
	self.ownNum = 0
	self.exSkillLevel = 0
	self.rank = 0

	self:initSkillLevel()
end

function SummonLuckyBagChoiceMO:initSkillLevel()
	local heroCo = HeroConfig.instance:getHeroCO(self.id)
	local duplicateItemCount = 0
	local duplicateItem = heroCo.duplicateItem

	if not string.nilorempty(duplicateItem) then
		local items = string.split(duplicateItem, "|")
		local item = items[1]

		if item then
			local itemParams = string.splitToNumber(item, "#")

			duplicateItemCount = ItemModel.instance:getItemQuantity(itemParams[1], itemParams[2])
		end
	end

	local heroMo = HeroModel.instance:getByHeroId(self.id)

	self.ownNum = 0
	self.exSkillLevel = 0

	if heroMo then
		self.exSkillLevel = heroMo.exSkillLevel
		self.ownNum = self.exSkillLevel + 1 + duplicateItemCount
		self.rank = heroMo.rank
	end
end

function SummonLuckyBagChoiceMO:hasHero()
	return self.ownNum > 0
end

function SummonLuckyBagChoiceMO:getSkillLevel()
	return self.exSkillLevel
end

return SummonLuckyBagChoiceMO
