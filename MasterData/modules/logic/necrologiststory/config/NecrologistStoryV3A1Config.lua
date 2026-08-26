-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV3A1Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV3A1Config", package.seeall)

local NecrologistStoryV3A1Config = class("NecrologistStoryV3A1Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV3A1Config:ctor()
	self._openConfig = nil
	self._opengroupConfig = nil
end

function NecrologistStoryV3A1Config:reqConfigNames()
	return {
		"hero_story_mode_fugaoren_base",
		"hero_story_mode_fugaoren_story"
	}
end

function NecrologistStoryV3A1Config:onLoadhero_story_mode_fugaoren_story(configTable)
	self._fugaorenStoryConfig = configTable
end

function NecrologistStoryV3A1Config:onLoadhero_story_mode_fugaoren_base(configTable)
	self._fugaorenBaseConfig = configTable
end

function NecrologistStoryV3A1Config:getStoryConfig(storyId)
	return self._fugaorenStoryConfig.configDict[storyId]
end

function NecrologistStoryV3A1Config:_initFugaorenGraphMap()
	if self._fugaorenBaseGraph then
		return
	end

	self._fugaorenBaseGraph = {}
	self._costTimeDict = {}

	for _, co in ipairs(self._fugaorenBaseConfig.configList) do
		local map = self._fugaorenBaseGraph[co.id]

		if not map then
			map = {}
			self._fugaorenBaseGraph[co.id] = map
		end

		local conAreas = string.splitToNumber(co.conArea, "#")

		for _, nextId in ipairs(conAreas) do
			map[nextId] = true
		end

		self._costTimeDict[co.id] = {}
		map = self._costTimeDict[co.id]

		local nextIds = GameUtil.splitString2(co.costTime, true)

		if nextIds then
			for _, nextIdAttr in ipairs(nextIds) do
				map[nextIdAttr[1]] = nextIdAttr[2]
			end
		end
	end
end

function NecrologistStoryV3A1Config:hasBaseConnection(sourceId, targetId)
	self:_initFugaorenGraphMap()

	local costTime = self:_checkBaseConnection(sourceId, targetId)

	if costTime then
		return true, costTime
	end

	return false
end

function NecrologistStoryV3A1Config:_checkBaseConnection(sourceId, targetId)
	if sourceId == targetId then
		return false
	end

	local sourceConfig = self:getFugaorenBaseCo(sourceId)
	local targetConfig = self:getFugaorenBaseCo(targetId)
	local sourceMap = self._fugaorenBaseGraph[sourceId]

	if sourceMap and sourceMap[targetId] then
		if self._costTimeDict[sourceId] then
			local time = self._costTimeDict[sourceId][targetId]

			time = self._costTimeDict[sourceId] or self._costTimeDict[targetId] and self._costTimeDict[targetId][sourceId]

			return self._costTimeDict[sourceId] or 0
		end
	end
end

function NecrologistStoryV3A1Config:getFugaorenBaseCo(id)
	local co = self._fugaorenBaseConfig.configDict[id]

	if not co then
		logError(string.format("FugaorenBaseCo is nil id:%s", id))
	end

	return co
end

function NecrologistStoryV3A1Config:getDefaultBaseId()
	return 101
end

function NecrologistStoryV3A1Config:getBaseList()
	return self._fugaorenBaseConfig.configList
end

function NecrologistStoryV3A1Config:getBaseStoryList(baseId)
	if not self._baseStoryList then
		self._baseStoryList = {}

		for i, v in ipairs(self._fugaorenStoryConfig.configList) do
			self._baseStoryList[v.baseId] = self._baseStoryList[v.baseId] or {}

			table.insert(self._baseStoryList[v.baseId], v.id)
		end
	end

	return self._baseStoryList[baseId]
end

function NecrologistStoryV3A1Config:getBaseTargetList()
	if not self._baseTargetList then
		self._baseTargetList = {}

		for i, v in ipairs(self._fugaorenBaseConfig.configList) do
			if v.endTime > 0 then
				table.insert(self._baseTargetList, v)
			end
		end
	end

	return self._baseTargetList
end

function NecrologistStoryV3A1Config:getBigBaseInArea(areaId)
	for i, v in ipairs(self._fugaorenBaseConfig.configList) do
		if v.areaId == areaId and v.type == NecrologistStoryEnum.BaseType.BigBase then
			return v.id
		end
	end
end

function NecrologistStoryV3A1Config:getCurStartTime(baseId)
	local retIndex = 1
	local list = self._fugaorenBaseConfig.configList

	if baseId then
		for i = #list, 1, -1 do
			local co = list[i]

			if baseId >= co.id and co.startTime > 0 then
				retIndex = i

				break
			end
		end
	end

	local retConfig = list[retIndex]

	return retConfig.id, retConfig.startTime
end

NecrologistStoryV3A1Config.instance = NecrologistStoryV3A1Config.New()

return NecrologistStoryV3A1Config
