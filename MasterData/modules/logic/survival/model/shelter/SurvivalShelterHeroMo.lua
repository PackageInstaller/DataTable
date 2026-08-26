-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterHeroMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterHeroMo", package.seeall)

local SurvivalShelterHeroMo = pureTable("SurvivalShelterHeroMo")

function SurvivalShelterHeroMo:setDefault(heroId)
	self.heroId = heroId
	self.health = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	self.status = SurvivalEnum.HeroStatu.Normal
end

function SurvivalShelterHeroMo:init(data)
	self.heroId = data.heroId
	self.health = data.health
	self.status = data.status
end

function SurvivalShelterHeroMo:getCurState()
	local max = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	local arr1 = string.splitToNumber(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.HeroHealth2), "#") or {}
	local arr2 = string.splitToNumber(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.HeroHealth3), "#") or {}
	local health1 = (arr1[1] or 0) / 1000
	local health2 = (arr2[1] or 0) / 1000
	local amount = 0
	local num2 = health2 * max
	local num1 = health1 * max

	if self.health == 0 then
		return 0, amount
	elseif health2 >= self.health / max then
		amount = self.health / num2

		return 1, self.health / num2
	elseif health1 >= self.health / max then
		amount = (self.health - num2) / (num1 - num2)

		return 2, (self.health - num2) / (num1 - num2)
	else
		amount = (self.health - num1) / (max - num1)

		return 3, (self.health - num1) / (max - num1)
	end
end

return SurvivalShelterHeroMo
