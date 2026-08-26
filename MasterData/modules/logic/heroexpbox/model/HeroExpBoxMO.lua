-- chunkname: @modules/logic/heroexpbox/model/HeroExpBoxMO.lua

module("modules.logic.heroexpbox.model.HeroExpBoxMO", package.seeall)

local HeroExpBoxMO = class("HeroExpBoxMO")

function HeroExpBoxMO:ctor(heroId)
	self.heroId = heroId
	self.heroConfig = HeroConfig.instance:getHeroCO(self.heroId)
end

function HeroExpBoxMO:getHeroMo()
	return HeroModel.instance:getByHeroId(self.heroId)
end

function HeroExpBoxMO:getExpItemCount()
	local exSkillLevel = self:getExSkillLevel()

	if exSkillLevel < CharacterEnum.MaxSkillExLevel then
		local exCo = SkillConfig.instance:getherolevelexskillCO(self.heroId, exSkillLevel + 1)

		if exCo then
			local itemco = string.splitToNumber(exCo.consume, "#")

			return (ItemModel.instance:getItemQuantity(itemco[1], itemco[2]))
		end
	end

	return 0
end

function HeroExpBoxMO:getExSkillLevel()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.exSkillLevel
	end

	return 0
end

function HeroExpBoxMO:getRank()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.rank
	end

	return 0
end

function HeroExpBoxMO:getSkinId()
	local heroMo = self:getHeroMo()

	if heroMo then
		return heroMo.skin
	end

	return self.heroConfig.skinId
end

function HeroExpBoxMO:getStatus()
	local heroMo = self:getHeroMo()

	if heroMo then
		local heroExp = self:getExSkillLevel()

		if heroExp >= CharacterEnum.MaxSkillExLevel then
			return HeroExpBoxEnum.HeroStatus.MAX
		else
			local heroExpItemCount = self:getExpItemCount()

			if heroExp + heroExpItemCount >= CharacterEnum.MaxSkillExLevel then
				return HeroExpBoxEnum.HeroStatus.EnoughHeroItem
			end
		end

		return HeroExpBoxEnum.HeroStatus.Normal
	end

	return HeroExpBoxEnum.HeroStatus.Lock
end

return HeroExpBoxMO
