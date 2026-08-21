-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/config/GuideConfig.lua

module("logic.extensions.guide.config.GuideConfig", package.seeall)

local GuideConfig = class("GuideConfig", BaseConfig)

function GuideConfig:ctor()
	self._guideConfig = nil
	self._guideStepConfig = nil
	self._guideFullScreenConfig = nil
	self._guideFullScreenStepConfig = nil
	self._guideCOList = {}
	self._guideStepDict = {}
	self._guideFullScreenDict = {}
	self._guideFullScreenStepDict = {}
	self._guideStepIdMap = {}
	self._introCareerDict = {}
	self._introLabelDict = {}
end

function GuideConfig:getNames()
	return {
		ConfigName.Guide,
		ConfigName.GuideStep,
		ConfigName.GuideFullScreen,
		ConfigName.GuideFullScreenStep,
		ConfigName.IntroCareer,
		ConfigName.IntroLabel
	}
end

function GuideConfig:handleConfig(name, content)
	if name == ConfigName.Guide then
		self._guideConfig = content

		for i = 1, #self._guideConfig.dataList do
			local guideCO = self._guideConfig.dataList[i]

			if guideCO.isOnLine == 0 then
				table.insert(self._guideCOList, guideCO)
			end
		end
	elseif name == ConfigName.GuideStep then
		self._guideStepConfig = content

		for guideId, guideStepTb in pairs(self._guideStepConfig) do
			for stepId, stepCO in pairs(guideStepTb) do
				if not self._guideStepDict[guideId] then
					self._guideStepDict[guideId] = {}
				end

				if not self._guideStepIdMap[guideId] then
					self._guideStepIdMap[guideId] = {}
				end

				if stepCO.isOnLine == 0 then
					table.insert(self._guideStepDict[guideId], stepCO)
					table.insert(self._guideStepIdMap[guideId], stepId)
				end
			end
		end
	elseif name == ConfigName.GuideFullScreen then
		self._guideFullScreenConfig = content

		for i = 1, #self._guideFullScreenConfig.dataList do
			local guideCo = self._guideFullScreenConfig.dataList[i]

			table.insert(self._guideFullScreenDict, guideCo)
		end
	elseif name == ConfigName.GuideFullScreenStep then
		self._guideFullScreenStepConfig = content

		for i = 1, #self._guideFullScreenStepConfig.dataList do
			local guideCo = self._guideFullScreenStepConfig.dataList[i]

			table.insert(self._guideFullScreenStepDict, guideCo)
		end
	elseif name == ConfigName.IntroCareer then
		for i = 1, #content.dataList do
			local guideCO = content.dataList[i]

			table.insert(self._introCareerDict, guideCO)
		end
	elseif name == ConfigName.IntroLabel then
		for i = 1, #content.dataList do
			local guideCO = content.dataList[i]

			table.insert(self._introLabelDict, guideCO)
		end
	end
end

function GuideConfig:getGuideCOList()
	return self._guideCOList
end

function GuideConfig:getGuideCO(guideId)
	return self._guideConfig[guideId]
end

function GuideConfig:getGuideFullScreenList()
	return self._guideFullScreenDict
end

function GuideConfig:getGuideFullScreenCfg(id)
	if not self._guideFullScreenDict then
		return
	end

	for index, cfg in ipairs(self._guideFullScreenDict) do
		if cfg.id == id then
			return cfg
		end
	end
end

function GuideConfig:getGuideFullScreenStepList()
	return self._guideFullScreenStepDict
end

function GuideConfig:getGuideStepCO(guideId, stepId)
	local guideStepCO = false
	local guideData = self._guideStepDict and self._guideStepDict[guideId] or false

	if guideData then
		for i = 1, #guideData do
			if guideData[i].id == stepId then
				guideStepCO = guideData[i]

				break
			end
		end
	end

	return guideStepCO
end

function GuideConfig:getGuideStepCOList(guideId)
	return self._guideStepDict[guideId]
end

function GuideConfig:getGuideStepIdList(guideId)
	if self._guideStepIdMap and self._guideStepIdMap[guideId] then
		table.sort(self._guideStepIdMap[guideId], function(data1, data2)
			if not data1 or not data2 then
				return false
			end

			return data1 < data2
		end)

		return self._guideStepIdMap[guideId]
	end

	return false
end

function GuideConfig:getMaxGuideStepCount(guideId)
	local list = self:getGuideStepCOList(guideId)
	local count = list and #list or 0

	return count
end

function GuideConfig:getNextGuideStepId(guideId, stepId)
	local stepCOList = self:getGuideStepCOList(guideId)

	if stepCOList then
		for i = 1, #stepCOList - 1 do
			if stepCOList[i] == stepId then
				return stepCOList[i + 1]
			end
		end
	end

	return -1
end

function GuideConfig:getHighestPriorityGuideId(guideIdList)
	table.sort(guideIdList, function(id1, id2)
		if not id1 or not id2 then
			return false
		end

		return id1 < id2
	end)

	if guideIdList and #guideIdList > 0 then
		return guideIdList[1]
	else
		return false
	end
end

function GuideConfig:getIntroCareerConfig()
	return self._introCareerDict
end

function GuideConfig:getIntroLabelDict()
	return self._introLabelDict
end

GuideConfig.instance = GuideConfig.New()

return GuideConfig
