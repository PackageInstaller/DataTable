-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterRecruitMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterRecruitMo", package.seeall)

local SurvivalShelterRecruitMo = pureTable("SurvivalShelterRecruitMo")

function SurvivalShelterRecruitMo:init(info)
	self.id = info.id
	self.config = lua_survival_recruit.configDict[info.id]
	self.tags = {}

	for i, v in ipairs(info.tags) do
		table.insert(self.tags, v)
	end

	if self.config then
		self.selectCount = self.config.chooseNum or 0
	end

	self.selectedTags = {}

	for i, v in ipairs(info.selectedTags) do
		table.insert(self.selectedTags, v)
	end

	self.canRefreshTimes = info.canRefreshTimes
	self.goodList = {}

	for i, v in ipairs(info.good) do
		local good = {}

		good.id = v.id
		good.npcId = v.npcId

		table.insert(self.goodList, good)
	end
end

function SurvivalShelterRecruitMo:isInRecruit()
	return next(self.selectedTags) ~= nil and next(self.goodList) == nil
end

function SurvivalShelterRecruitMo:isCanRecruit()
	return next(self.selectedTags) == nil and next(self.goodList) == nil
end

function SurvivalShelterRecruitMo:isCanSelectNpc()
	return next(self.goodList) ~= nil
end

return SurvivalShelterRecruitMo
