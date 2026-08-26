-- chunkname: @modules/logic/versionactivity2_5/liangyue/config/LiangYueConfig.lua

module("modules.logic.versionactivity2_5.liangyue.config.LiangYueConfig", package.seeall)

local LiangYueConfig = class("LiangYueConfig", BaseConfig)

LiangYueConfig.EPISODE_CONFIG_NAME = "activity184_episode"
LiangYueConfig.PUZZLE_CONFIG_NAME = "activity184_puzzle_episode"
LiangYueConfig.ILLUSTRATION_CONFIG_NAME = "activity184_illustration"
LiangYueConfig.TASK_CONFIG_NAME = "activity184_task"

function LiangYueConfig:reqConfigNames()
	return {
		self.EPISODE_CONFIG_NAME,
		self.ILLUSTRATION_CONFIG_NAME,
		self.PUZZLE_CONFIG_NAME,
		self.TASK_CONFIG_NAME
	}
end

function LiangYueConfig:onInit()
	self._noGameEpisodeDic = {}
	self._afterGameEpisodeDic = {}
	self._taskDict = {}
end

function LiangYueConfig:onConfigLoaded(configName, configTable)
	if configName == self.EPISODE_CONFIG_NAME then
		self._episodeConfig = configTable
	elseif configName == self.TASK_CONFIG_NAME then
		self._taskConfig = configTable
	elseif configName == self.ILLUSTRATION_CONFIG_NAME then
		self._illustrationConfig = configTable

		self:initIllustrationConfig()
	elseif configName == self.PUZZLE_CONFIG_NAME then
		self._episodePuzzleConfig = configTable

		self:initPuzzleEpisodeConfig()
	end
end

function LiangYueConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(self._taskConfig.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function LiangYueConfig:initPuzzleEpisodeConfig()
	self._episodeStaticIllustrationDic = {}

	for _, config in ipairs(self._episodePuzzleConfig.configList) do
		local actId = config.activityId

		if self._episodeStaticIllustrationDic[actId] == nil then
			self._episodeStaticIllustrationDic[actId] = {}
		end

		if not string.nilorempty(config.staticShape) then
			local paramList = string.split(config.staticShape, "|")
			local staticCubeDic = {}

			for _, param in ipairs(paramList) do
				local data = string.split(param, "#")
				local pos = string.splitToNumber(data[1], ",")
				local posX = pos[1]
				local posY = pos[2]

				if staticCubeDic[posX] and staticCubeDic[posX][posY] then
					logError("固定格子位置重复 位置: x:" .. posX .. "y:" .. posY)
				else
					staticCubeDic[posX] = staticCubeDic[posX] or {}
					staticCubeDic[posX][posY] = tonumber(data[2])
				end
			end

			self._episodeStaticIllustrationDic[actId][config.id] = staticCubeDic
		end
	end
end

function LiangYueConfig:getFirstEpisodeId()
	return self._episodeConfig.configList[1]
end

function LiangYueConfig:initIllustrationConfig()
	self._illustrationShapeDic = {}
	self._illustrationShapeBoxCountDic = {}

	for _, config in ipairs(self._illustrationConfig.configList) do
		local activityId = config.activityId
		local shapeId = config.id

		if not self._illustrationShapeDic[activityId] then
			self._illustrationShapeDic[activityId] = {}
			self._illustrationShapeBoxCountDic[activityId] = {}
		end

		if not self._illustrationShapeDic[activityId][shapeId] then
			local shapeDic = {}
			local boxCount = 0
			local params = string.split(config.shape, "#")

			for y = 1, #params do
				local rowData = {}
				local param = params[y]
				local data = string.splitToNumber(param, ",")

				for x = 1, #data do
					rowData[x] = data[x]

					if data[x] == 1 then
						boxCount = boxCount + 1
					end
				end

				shapeDic[y] = rowData
			end

			self._illustrationShapeDic[activityId][shapeId] = shapeDic
			self._illustrationShapeBoxCountDic[activityId][shapeId] = boxCount
		else
			logError(string.format("梁月角色活动 插图表id重复 actId:%s id:%s", activityId, shapeId))
		end
	end
end

function LiangYueConfig:getEpisodeStaticIllustrationDic(activityId, episodeGameId)
	if self._episodeStaticIllustrationDic[activityId] then
		return self._episodeStaticIllustrationDic[activityId][episodeGameId]
	end

	return nil
end

function LiangYueConfig:getIllustrationShape(activityId, shapeId)
	if not self._illustrationShapeDic[activityId] then
		return nil
	end

	return self._illustrationShapeDic[activityId][shapeId]
end

function LiangYueConfig:getIllustrationShapeCount(activityId, shapeId)
	if not self._illustrationShapeBoxCountDic[activityId] then
		return nil
	end

	return self._illustrationShapeBoxCountDic[activityId][shapeId]
end

function LiangYueConfig:getIllustrationAttribute(activityId, shapeId)
	local config = self:getIllustrationConfigById(activityId, shapeId)

	if config == nil then
		return
	end

	self._illustrationAttributeConfig = self._illustrationAttributeConfig or {}
	self._illustrationAttributeConfig[activityId] = self._illustrationAttributeConfig[activityId] or {}

	if not self._illustrationAttributeConfig[activityId][shapeId] then
		local data = {}
		local singleParams = string.split(config.attribute, "|")

		for _, singleParam in ipairs(singleParams) do
			local attributeParam = string.splitToNumber(singleParam, "#")
			local attributeType = attributeParam[1]
			local calculateType = attributeParam[2]
			local attribute = attributeParam[3]

			data[attributeType] = {
				attributeType,
				calculateType,
				attribute
			}
		end

		self._illustrationAttributeConfig[activityId][shapeId] = data

		return data
	end

	return self._illustrationAttributeConfig[activityId][shapeId]
end

function LiangYueConfig:getEpisodeConfigByActAndId(actId, id)
	if not self._episodeConfig.configDict[actId] then
		return nil
	end

	return self._episodeConfig.configDict[actId][id]
end

function LiangYueConfig:getEpisodePuzzleConfigByActAndId(actId, id)
	if not self._episodePuzzleConfig.configDict[actId] then
		return nil
	end

	return self._episodePuzzleConfig.configDict[actId][id]
end

function LiangYueConfig:getIllustrationConfigById(activityId, id)
	if not self._illustrationConfig.configDict[activityId] then
		return nil
	end

	return self._illustrationConfig.configDict[activityId][id]
end

function LiangYueConfig:getNoGameEpisodeList(activityId)
	if not self._episodeConfig.configDict[activityId] then
		return nil
	end

	if not self._noGameEpisodeDic[activityId] then
		local episodeList = {}
		local allConfig = self._episodeConfig.configDict[activityId]

		for _, config in pairs(allConfig) do
			if config.puzzleId == 0 then
				table.insert(episodeList, config)
			end
		end

		table.sort(episodeList, self._sortEpisode)

		self._noGameEpisodeDic[activityId] = episodeList
	end

	return self._noGameEpisodeDic[activityId]
end

function LiangYueConfig._sortEpisode(a, b)
	return a.episodeId <= b.episodeId
end

function LiangYueConfig:getAfterGameEpisodeId(activityId, episodeId)
	if not self._episodeConfig.configDict[activityId] then
		return nil
	end

	if not self._afterGameEpisodeDic[activityId] then
		local dic = {}
		local allConfig = self._episodeConfig.configDict[activityId]

		for _, config in pairs(allConfig) do
			if config.puzzleId ~= 0 then
				dic[config.preEpisodeId] = config.episodeId
			end
		end

		self._afterGameEpisodeDic[activityId] = dic
	end

	return self._afterGameEpisodeDic[activityId][episodeId]
end

LiangYueConfig.instance = LiangYueConfig.New()

return LiangYueConfig
