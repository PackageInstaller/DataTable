-- chunkname: @modules/logic/herogroup/model/HeroGroupRecommendGroupMO.lua

module("modules.logic.herogroup.model.HeroGroupRecommendGroupMO", package.seeall)

local HeroGroupRecommendGroupMO = pureTable("HeroGroupRecommendGroupMO")

function HeroGroupRecommendGroupMO:init(info)
	if not info or not info.rate then
		self.isEmpty = true

		return
	end

	self.heroIdList = {}
	self.levels = {}
	self.heroDataList = {}

	for i, heroId in ipairs(info.heroIds) do
		if heroId > 0 then
			local heroData = {}

			heroData.heroId = heroId
			heroData.level = info.levels[i]

			table.insert(self.heroDataList, heroData)
		end
	end

	self.aidDict = {}

	for i, heroId in ipairs(info.subHeroIds) do
		if heroId > 0 then
			local heroData = {}

			heroData.heroId = heroId
			heroData.level = info.levels[#info.heroIds + i]

			table.insert(self.heroDataList, heroData)

			self.aidDict[heroId] = true
		end
	end

	self.cloth = info.cloth
	self.rate = info.rate
	self.assistBossId = info.assistBossId
	self.extString = info.extString or ""
end

return HeroGroupRecommendGroupMO
