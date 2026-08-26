-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131Model.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131Model", package.seeall)

local Activity131Model = class("Activity131Model", BaseModel)

function Activity131Model:onInit()
	self:reInit()
end

function Activity131Model:reInit()
	self._curEpisodeId = 0
	self._interactInfos = {}
	self.curMaplogDic = {}
end

function Activity131Model:updateInfo(info)
	self:initInfo(info)
end

function Activity131Model:setInfos(infos)
	for _, info in ipairs(infos) do
		local infoMo = Activity131LevelInfoMo.New()

		infoMo:init(info)

		self._interactInfos[info.episodeId] = infoMo
	end
end

function Activity131Model:resetInfos(episodeId, infos)
	for _, info in ipairs(infos) do
		local infoMo = Activity131LevelInfoMo.New()

		infoMo:init(info)

		self._interactInfos[info.episodeId] = infoMo
	end
end

function Activity131Model:updateInfos(info)
	if self._interactInfos[info.episodeId] then
		self._interactInfos[info.episodeId]:updateInfo(info)
	else
		local infoMo = Activity131LevelInfoMo.New()

		infoMo:init(info)

		self._interactInfos[info.episodeId] = infoMo
	end
end

function Activity131Model:updateProgress(episodeId, progress)
	if self._interactInfos and self._interactInfos[episodeId] then
		self._interactInfos[episodeId].progress = progress < Activity131Enum.ProgressType.Finished and progress or Activity131Enum.ProgressType.Finished

		return
	end

	logError("请求了不存在的关卡进度!")
end

function Activity131Model:refreshLogDics()
	local mapInfo = self:getCurMapInfo()
	local logType = 0

	if mapInfo then
		self.curMaplogDic = {}

		for _, elementInfo in ipairs(mapInfo.act131Elements) do
			local progress = elementInfo.index

			if progress ~= 0 then
				for i = 1, progress do
					local elementType = elementInfo.typeList[i]
					local param = elementInfo.paramList[i]

					if elementType == Activity131Enum.ElementType.LogStart then
						logType = param

						if not self.curMaplogDic[param] then
							self.curMaplogDic[logType] = {}
						end
					elseif elementType == Activity131Enum.ElementType.Dialog then
						if logType ~= 0 and self.curMaplogDic[logType] then
							local dialogGroupCfg = Activity131Config.instance:getActivity131DialogGroup(tonumber(param))

							for _, v in pairs(dialogGroupCfg) do
								table.insert(self.curMaplogDic[logType], v)
							end
						end
					elseif elementType == Activity131Enum.ElementType.LogEnd then
						if self.curMaplogDic[logType] then
							table.sort(self.curMaplogDic[logType], function(a, b)
								if a.id ~= b.id then
									return a.id < b.id
								else
									return a.stepId < b.stepId
								end
							end)
						end

						logType = 0
					end
				end
			end
		end
	end
end

function Activity131Model:getLogCategortList()
	local logCategortListInfo = {}

	for _logType, _ in pairs(self.curMaplogDic) do
		table.insert(logCategortListInfo, {
			logType = _logType
		})
	end

	return logCategortListInfo
end

function Activity131Model:getInfos()
	return self._interactInfos
end

function Activity131Model:getInfo(episodeId)
	if not self._interactInfos then
		return {}
	end

	return self._interactInfos[episodeId]
end

function Activity131Model:isEpisodeFinished(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return false
	end

	return self._interactInfos[episodeId].progress == Activity131Enum.ProgressType.Finished
end

function Activity131Model:getEpisodeProgress(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return Activity131Enum.ProgressType.BeforeStory
	end

	return self._interactInfos[episodeId].progress
end

function Activity131Model:getEpisodeElements(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return {}
	end

	return self._interactInfos[episodeId].act131Elements
end

function Activity131Model:getEpisodeCurSceneIndex(episodeId)
	local index = 1
	local mapInfo = self:getInfo(episodeId)

	for _, v in ipairs(mapInfo.act131Elements) do
		if v.isFinish and v.typeList[v.index] == Activity131Enum.ElementType.ChangeScene then
			index = tonumber(string.split(v.config.param, "#")[v.index])
		end
	end

	return index
end

function Activity131Model:getCurMapId()
	local co = self:getCurMapConfig()

	return co.mapId
end

function Activity131Model:getCurMapConfig()
	local actId = VersionActivity1_4Enum.ActivityId.Role6

	return (Activity131Config.instance:getActivity131EpisodeCo(actId, self._curEpisodeId))
end

function Activity131Model:isEpisodeUnlock(episodeId)
	local mapInfo = self:getInfo(episodeId)

	return mapInfo and next(mapInfo)
end

function Activity131Model:getEpisodeState(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return 0
	end

	return self._interactInfos[episodeId].state
end

function Activity131Model:getCurMapInfo()
	return self:getInfo(self._curEpisodeId)
end

function Activity131Model:getCurMapElementInfo(elementId)
	local curMapInfo = self:getCurMapInfo()

	for _, v in pairs(curMapInfo.act131Elements) do
		if v.elementId == elementId then
			return v
		end
	end
end

function Activity131Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity131Model:getCurEpisodeId()
	return self._curEpisodeId
end

function Activity131Model:getEpisodeTaskTip(episodeId)
	local mapInfo = self:getInfo(episodeId)
	local tipId = 0
	local stepId = 0
	local elementId = 0

	for _, v in ipairs(mapInfo.act131Elements) do
		for index, type in ipairs(v.typeList) do
			if type == Activity131Enum.ElementType.TaskTip and index <= v.index then
				local params = string.split(v.config.param, "#")[index]
				local ids = string.splitToNumber(params, "_")

				if elementId < v.elementId then
					elementId = v.elementId
					tipId = ids[1]
					stepId = ids[2]
				end
			end
		end
	end

	return tipId, stepId
end

function Activity131Model:getMaxEpisode()
	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local episodeCos = Activity131Config.instance:getActivity131EpisodeCos(actId)
	local episodeId = 0

	for _, v in pairs(episodeCos) do
		episodeId = episodeId > v.episodeId and episodeId or v.episodeId
	end

	return episodeId
end

function Activity131Model:getMaxUnlockEpisode()
	local episodeId = self:getCurEpisodeId()

	for _, v in pairs(self._interactInfos) do
		episodeId = episodeId > v.episodeId and episodeId or v.episodeId
	end

	return episodeId
end

function Activity131Model:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function Activity131Model:getNewFinishEpisode()
	return self._newFinishEpisode or -1
end

function Activity131Model:getNewUnlockEpisode()
	return self._newUnlockEpisode or -1
end

function Activity131Model:setNewUnlockEpisode(episodeId)
	self._newUnlockEpisode = episodeId
end

function Activity131Model:setSelectLogType(logType)
	self.curSelectLogType = logType

	Activity131Controller.instance:dispatchEvent(Activity131Event.SelectCategory)
end

function Activity131Model:getSelectLogType()
	return self.curSelectLogType
end

function Activity131Model:getLog()
	if self.curSelectLogType and self.curSelectLogType ~= 0 then
		return (self.curMaplogDic or nil) and (self.curMaplogDic[self.curSelectLogType] or {})
	end

	return {}
end

function Activity131Model:getTotalEpisodeCount()
	local actId = VersionActivity1_4Enum.ActivityId.Role6
	local episodeCos = Activity131Config.instance:getActivity131EpisodeCos(actId)

	return #episodeCos
end

Activity131Model.instance = Activity131Model.New()

return Activity131Model
