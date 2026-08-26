-- chunkname: @modules/logic/versionactivity1_5/act146/model/Activity146Model.lua

module("modules.logic.versionactivity1_5.act146.model.Activity146Model", package.seeall)

local Activity146Model = class("Activity146Model", BaseModel)

Activity146Model.EpisodeUnFinishState = 0
Activity146Model.EpisodeFinishedState = 1
Activity146Model.EpisodeHasReceiveState = 2

function Activity146Model:onInit()
	self._actInfo = nil
end

function Activity146Model:reInit()
	self._actInfo = nil
end

function Activity146Model:setActivityInfo(info)
	self._actInfo = {}

	if info then
		for _, v in pairs(info) do
			if v.id and v.state then
				self._actInfo[v.id] = v.state
			end
		end
	end
end

function Activity146Model:isEpisodeUnLockAndUnFinish(episodeId)
	return self._actInfo and self._actInfo[episodeId] == Activity146Model.EpisodeUnFinishState
end

function Activity146Model:isEpisodeFinishedButUnReceive(episodeId)
	return self._actInfo and self._actInfo[episodeId] == Activity146Model.EpisodeFinishedState
end

function Activity146Model:isEpisodeFinished(episodeId)
	return self:isEpisodeFinishedButUnReceive(episodeId) or self:isEpisodeHasReceivedReward(episodeId)
end

function Activity146Model:isEpisodeHasReceivedReward(episodeId)
	return self._actInfo and self._actInfo[episodeId] == Activity146Model.EpisodeHasReceiveState
end

function Activity146Model:isEpisodeUnLock(episodeId)
	local preEpisodeCfg = Activity146Config.instance:getPreEpisodeConfig(ActivityEnum.Activity.Activity1_5WarmUp, episodeId)
	local var_8_0

	if (preEpisodeCfg or nil) and self:isEpisodeFinished(preEpisodeCfg.id) then
		::label_8_0::

		var_8_0 = self._actInfo and self._actInfo[episodeId] ~= nil
	end

	return var_8_0
end

function Activity146Model:isHasEpisodeCanReceiveReward()
	local episodeCfgList = Activity146Config.instance:getAllEpisodeConfigs(ActivityEnum.Activity.Activity1_5WarmUp)

	for _, v in pairs(episodeCfgList) do
		if self:isEpisodeFinishedButUnReceive(v.id) then
			return true
		end
	end

	return false
end

function Activity146Model:getActivityInfo()
	return self._actInfo
end

function Activity146Model:isAllEpisodeFinish()
	if self._actInfo then
		for _, v in pairs(self._actInfo) do
			if tonumber(v) == Activity146Model.EpisodeUnFinishState then
				return false
			end
		end

		return true
	end

	return false
end

function Activity146Model:setCurSelectedEpisode(episodeId)
	self._curSelectedEpisodeId = episodeId
end

function Activity146Model:getCurSelectedEpisode()
	return self._curSelectedEpisodeId
end

function Activity146Model:markHasEnterEpisode(episodeId)
	if not self._hasEnterEpisodeDict then
		self:decodeHasEnterEpisodeData()
	end

	local isDirty = false

	if not self._hasEnterEpisodeDict[episodeId] then
		self._hasEnterEpisodeDict[episodeId] = true

		table.insert(self._hasEnterEpisodeList, episodeId)

		isDirty = true
	end

	if isDirty then
		self:flushHasEnterEpisodes()
	end
end

function Activity146Model:flushHasEnterEpisodes()
	if self._hasEnterEpisodeList then
		PlayerPrefsHelper.setString(self:getLocalKey(), cjson.encode(self._hasEnterEpisodeList))
	end
end

function Activity146Model:isEpisodeFirstEnter(episodeId)
	if not self._hasEnterEpisodeDict then
		self:decodeHasEnterEpisodeData()
	end

	return not self._hasEnterEpisodeDict[episodeId]
end

function Activity146Model:decodeHasEnterEpisodeData()
	local localKey = self:getLocalKey()
	local rs

	if not string.nilorempty(localKey) then
		rs = PlayerPrefsHelper.getString(localKey, "")
	end

	self._hasEnterEpisodeDict = {}

	if not string.nilorempty(rs) then
		self._hasEnterEpisodeList = cjson.decode(rs)

		for _, episodeId in pairs(self._hasEnterEpisodeList) do
			self._hasEnterEpisodeDict[episodeId] = true
		end
	else
		self._hasEnterEpisodeList = {}
	end
end

function Activity146Model:getLocalKey()
	return PlayerPrefsKey.Version1_5_Act146HasEnterEpisodeKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

Activity146Model.instance = Activity146Model.New()

return Activity146Model
