-- chunkname: @modules/logic/rouge/config/RougeTalentConfig.lua

module("modules.logic.rouge.config.RougeTalentConfig", package.seeall)

local RougeTalentConfig = class("RougeTalentConfig", BaseConfig)

function RougeTalentConfig:reqConfigNames()
	return {
		"rouge_genius",
		"rouge_genius_branch",
		"rouge_genius_overview",
		"rouge_genius_branchlight"
	}
end

function RougeTalentConfig:onInit()
	self._talentDict = nil
	self._talentBranchDict = {}
	self._talentBranchList = nil
	self._talentoverList = nil
	self._talentBranchLightList = {}
end

function RougeTalentConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge_genius" then
		self._talentDict = configTable.configDict
	end

	if configName == "rouge_genius_branch" then
		for key, value in ipairs(configTable.configList) do
			if value.talent then
				if self._talentBranchDict[value.talent] == nil then
					self._talentBranchDict[value.talent] = {}
				end

				table.insert(self._talentBranchDict[value.talent], value)
			end
		end

		self._talentBranchList = configTable.configDict
	end

	if configName == "rouge_genius_overview" then
		self._talentoverList = configTable.configDict
	end

	if configName == "rouge_genius_branchlight" then
		for _, value in ipairs(configTable.configList) do
			if value.talent then
				if self._talentBranchLightList[value.talent] == nil then
					self._talentBranchLightList[value.talent] = {}
				end

				table.insert(self._talentBranchLightList[value.talent], value)
			end
		end
	end
end

function RougeTalentConfig:getTalentOverConfigById(id)
	return self._talentoverList[id]
end

function RougeTalentConfig:getRougeTalentDict(season)
	return self._talentDict[season]
end

function RougeTalentConfig:getConfigByTalent(season, id)
	return self._talentDict[season][id]
end

function RougeTalentConfig:getTalentNum(season)
	return #self._talentDict[season]
end

function RougeTalentConfig:getTalentBranchConfig()
	return self._talentBranchDict
end

function RougeTalentConfig:getBranchConfigListByTalent(talent)
	return self._talentBranchDict[talent]
end

function RougeTalentConfig:getBranchConfigByTalent(talent, id)
	return self._talentBranchDict[talent][id]
end

function RougeTalentConfig:getBranchNumByTalent(talent)
	return #self._talentBranchDict[talent]
end

function RougeTalentConfig:getBranchConfigByID(season, id)
	return self._talentBranchList[season][id]
end

function RougeTalentConfig:getBranchLightConfigByTalent(talent)
	return self._talentBranchLightList[talent]
end

RougeTalentConfig.instance = RougeTalentConfig.New()

return RougeTalentConfig
