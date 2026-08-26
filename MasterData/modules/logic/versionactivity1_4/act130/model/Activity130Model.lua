-- chunkname: @modules/logic/versionactivity1_4/act130/model/Activity130Model.lua

module("modules.logic.versionactivity1_4.act130.model.Activity130Model", package.seeall)

local Activity130Model = class("Activity130Model", BaseModel)

function Activity130Model:onInit()
	self:reInit()
end

function Activity130Model:reInit()
	self._curEpisodeId = 0
	self._interactInfos = {}
	self._collectRewardSates = {}
end

function Activity130Model:updateInfo(info)
	self:initInfo(info)
end

function Activity130Model:setInfos(infos)
	for _, info in ipairs(infos) do
		local infoMo = Activity130LevelInfoMo.New()

		infoMo:init(info)

		self._interactInfos[info.episodeId] = infoMo
	end
end

function Activity130Model:resetInfos(episodeId, infos)
	for _, info in ipairs(infos) do
		local infoMo = Activity130LevelInfoMo.New()

		infoMo:init(info)

		self._interactInfos[info.episodeId] = infoMo
	end
end

function Activity130Model:updateInfos(info)
	if self._interactInfos[info.episodeId] then
		self._interactInfos[info.episodeId]:updateInfo(info)
	else
		local infoMo = Activity130LevelInfoMo.New()

		infoMo:init(info)

		self._interactInfos[info.episodeId] = infoMo
	end
end

function Activity130Model:updateProgress(episodeId, progress)
	if self._interactInfos and self._interactInfos[episodeId] then
		self._interactInfos[episodeId].progress = progress < Activity130Enum.ProgressType.Finished and progress or Activity130Enum.ProgressType.Finished

		return
	end

	logError("请求了不存在的关卡进度!")
end

function Activity130Model:getInfos()
	return self._interactInfos
end

function Activity130Model:getInfo(episodeId)
	if not self._interactInfos then
		return {}
	end

	return self._interactInfos[episodeId]
end

function Activity130Model:isEpisodeFinished(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return false
	end

	return self._interactInfos[episodeId].progress == Activity130Enum.ProgressType.Finished
end

function Activity130Model:getEpisodeState(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return 0
	end

	return self._interactInfos[episodeId].state
end

function Activity130Model:getEpisodeProgress(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return Activity130Enum.ProgressType.BeforeStory
	end

	return self._interactInfos[episodeId].progress
end

function Activity130Model:getEpisodeElements(episodeId)
	if not self._interactInfos or not self._interactInfos[episodeId] then
		return {}
	end

	return self._interactInfos[episodeId].act130Elements
end

function Activity130Model:getEpisodeCurSceneIndex(episodeId)
	local index = 1
	local mapInfo = self:getInfo(episodeId)

	for _, v in ipairs(mapInfo.act130Elements) do
		if v.isFinish and v.typeList[v.index] == Activity130Enum.ElementType.ChangeScene then
			index = tonumber(string.split(v.config.param, "#")[v.index])
		end
	end

	return index
end

function Activity130Model:getCurMapId()
	local co = self:getCurMapConfig()

	return co.mapId
end

function Activity130Model:getCurMapConfig()
	local actId = VersionActivity1_4Enum.ActivityId.Role37

	return (Activity130Config.instance:getActivity130EpisodeCo(actId, self._curEpisodeId))
end

function Activity130Model:isEpisodeUnlock(episodeId)
	local mapInfo = self:getInfo(episodeId)

	return mapInfo and next(mapInfo)
end

function Activity130Model:getCurMapInfo()
	return self:getInfo(self._curEpisodeId)
end

function Activity130Model:getCurMapElementInfo(elementId)
	local curMapInfo = self:getCurMapInfo()

	for _, v in pairs(curMapInfo.act130Elements) do
		if v.elementId == elementId then
			return v
		end
	end
end

function Activity130Model:setCurEpisodeId(episodeId)
	self._curEpisodeId = episodeId
end

function Activity130Model:getCurEpisodeId()
	return self._curEpisodeId or 0
end

function Activity130Model:getEpisodeOperGroupId(episodeId)
	local mapInfo = self:getInfo(episodeId)
	local operGroupId = 0

	for _, v in ipairs(mapInfo.act130Elements) do
		for index, type in ipairs(v.typeList) do
			if type == Activity130Enum.ElementType.SetValue and index <= v.index then
				local param = string.split(v.config.param, "#")[index]

				operGroupId = tonumber(string.splitToNumber(param, "_")[1])
			end
		end
	end

	return operGroupId
end

function Activity130Model:getEpisodeDecryptId(episodeId)
	local mapInfo = self:getInfo(episodeId)
	local decryptId = 0
	local finish = false

	for _, v in ipairs(mapInfo.act130Elements) do
		for index, type in ipairs(v.typeList) do
			if type == Activity130Enum.ElementType.UnlockDecrypt then
				if index <= v.index then
					decryptId = tonumber(string.split(v.config.param, "#")[index])
					finish = true
				elseif index == v.index + 1 and decryptId == 0 then
					decryptId = tonumber(string.split(v.config.param, "#")[index])
				end
			end
		end
	end

	return decryptId, finish
end

function Activity130Model:getEpisodeTaskTip(episodeId)
	local mapInfo = self:getInfo(episodeId)
	local tipsElementId = mapInfo.tipsElementId
	local tipId = 0
	local stepId = 0

	for _, v in ipairs(mapInfo.act130Elements) do
		if v.elementId == tipsElementId or tipsElementId == 0 then
			for index, type in ipairs(v.typeList) do
				if type == Activity130Enum.ElementType.TaskTip and index <= v.index then
					local params = string.split(v.config.param, "#")[index]
					local ids = string.splitToNumber(params, "_")

					tipId = ids[1]
					stepId = ids[2]
				end
			end
		end
	end

	return tipId, stepId
end

function Activity130Model:getCollects(episodeId)
	local collects = {}
	local episodeId = self:getCurEpisodeId()
	local operGroupId = self:getEpisodeOperGroupId(episodeId)

	if operGroupId == 0 then
		return collects
	end

	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local cos = Activity130Config.instance:getActivity130OperateGroupCos(actId, operGroupId)

	for _, v in pairs(cos) do
		if self:isCollectUnlock(episodeId, v.operType) then
			table.insert(collects, v.operType)
		end
	end

	return collects
end

function Activity130Model:isCollectUnlock(episodeId, operType)
	local mapInfo = self:getInfo(episodeId)

	for _, v in ipairs(mapInfo.act130Elements) do
		for index, type in ipairs(v.typeList) do
			if type == Activity130Enum.ElementType.SetValue and index <= v.index then
				local param = string.split(v.config.param, "#")[index]

				if operType == tonumber(string.splitToNumber(param, "_")[2]) then
					return true
				end
			end
		end
	end

	return false
end

function Activity130Model:getDecryptIdByGroupId(groupId)
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local decryptCos = Activity130Config.instance:getActivity130DecryptCos(actId)

	for _, v in pairs(decryptCos) do
		if v.operGroupId == groupId then
			return v.puzzleId
		end
	end

	return 0
end

function Activity130Model:getElementInfoByDecryptId(decryptId, episodeId)
	local id = episodeId and episodeId or self:getCurEpisodeId()
	local mapInfo = self:getInfo(episodeId)

	for _, v in pairs(mapInfo.act130Elements) do
		for _, type in pairs(v.typeList) do
			if type == Activity130Enum.ElementType.UnlockDecrypt then
				return v
			end
		end
	end
end

function Activity130Model:getMaxEpisode()
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeCos = Activity130Config.instance:getActivity130EpisodeCos(actId)
	local episodeId = 0

	for _, v in pairs(episodeCos) do
		episodeId = episodeId > v.episodeId and episodeId or v.episodeId
	end

	return episodeId
end

function Activity130Model:getMaxUnlockEpisode()
	local episodeId = self:getCurEpisodeId()

	for _, v in pairs(self._interactInfos) do
		episodeId = episodeId > v.episodeId and episodeId or v.episodeId
	end

	return episodeId
end

function Activity130Model:getTotalEpisodeCount()
	local actId = VersionActivity1_4Enum.ActivityId.Role37
	local episodeCos = Activity130Config.instance:getActivity130EpisodeCos(actId)

	return #episodeCos
end

function Activity130Model:setNewFinishEpisode(episodeId)
	self._newFinishEpisode = episodeId
end

function Activity130Model:getNewFinishEpisode()
	return self._newFinishEpisode or -1
end

function Activity130Model:getNewUnlockEpisode()
	return self._newUnlockEpisode or -1
end

function Activity130Model:setNewUnlockEpisode(episodeId)
	self._newUnlockEpisode = episodeId
end

function Activity130Model:setNewCollect(episodeId, state)
	self._collectRewardSates[episodeId] = state
end

function Activity130Model:getNewCollectState(episodeId)
	return self._collectRewardSates[episodeId]
end

function Activity130Model:getGameChallengeNum(episodeId)
	local info = self:getInfo(episodeId)

	return info.challengeNum
end

function Activity130Model:updateChallengeNum(episodeId, challengeNum)
	local info = self:getInfo(episodeId)

	if info and info.updateChallengeNum then
		info:updateChallengeNum(challengeNum)
	end
end

Activity130Model.instance = Activity130Model.New()

return Activity130Model
