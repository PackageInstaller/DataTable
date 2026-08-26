-- chunkname: @modules/logic/dungeon/model/DungeonAssistModel.lua

module("modules.logic.dungeon.model.DungeonAssistModel", package.seeall)

local DungeonAssistModel = class("DungeonAssistModel", BaseModel)

function DungeonAssistModel:onInit()
	self:clear()
end

function DungeonAssistModel:reInit()
	return
end

function DungeonAssistModel:getAssistList(assistType, career)
	local result = {}

	if not assistType or not self._assistTypeDict then
		return result
	end

	if not self._assistTypeDict[assistType] then
		local careerDict = {}

		if career then
			result = careerDict[career] or {}
		else
			for _, assistHeroList in pairs(careerDict) do
				tabletool.addValues(result, assistHeroList)
			end
		end

		return result
	end
end

function DungeonAssistModel:setAssistHeroCareersByServerData(serverAssistType, serverAssistHeroCareers)
	if not serverAssistType or not serverAssistHeroCareers then
		return
	end

	self._assistTypeDict = self._assistTypeDict or {}

	local newCareerDict = {}

	self._assistTypeDict[serverAssistType] = newCareerDict

	for _, careerHeroData in ipairs(serverAssistHeroCareers) do
		local career = careerHeroData.career
		local assistHeroList = {}

		newCareerDict[career] = assistHeroList

		local alreadySet = {}

		for _, heroInfo in ipairs(careerHeroData.assistHeroInfos) do
			local heroUid = heroInfo.heroUid

			if not alreadySet[heroUid] then
				local assistHeroMO = DungeonAssistHeroMO.New()
				local result = assistHeroMO:init(serverAssistType, heroInfo)

				if result then
					assistHeroList[#assistHeroList + 1] = assistHeroMO
				end

				alreadySet[heroUid] = true
			end
		end
	end
end

function DungeonAssistModel:clear()
	self._assistTypeDict = {}

	DungeonAssistModel.super.clear(self)
end

DungeonAssistModel.instance = DungeonAssistModel.New()

return DungeonAssistModel
