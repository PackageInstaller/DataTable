-- chunkname: @modules/logic/herogroup/model/HeroGroupRecommendCharacterMO.lua

module("modules.logic.herogroup.model.HeroGroupRecommendCharacterMO", package.seeall)

local HeroGroupRecommendCharacterMO = pureTable("HeroGroupRecommendCharacterMO")

function HeroGroupRecommendCharacterMO:init(info)
	if not info or not info.rate then
		self.isEmpty = true
		self.heroRecommendInfos = {}

		return
	end

	self.heroId = info.heroId
	self.heroRecommendInfos = info.infos
	self.rate = info.rate
end

return HeroGroupRecommendCharacterMO
