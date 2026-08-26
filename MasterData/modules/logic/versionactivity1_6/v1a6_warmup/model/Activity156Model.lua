-- chunkname: @modules/logic/versionactivity1_6/v1a6_warmup/model/Activity156Model.lua

module("modules.logic.versionactivity1_6.v1a6_warmup.model.Activity156Model", package.seeall)

local Activity156Model = class("Activity156Model", BaseModel)

Activity156Model.EpisodeUnFinishState = 0
Activity156Model.EpisodeFinishedState = 1

function Activity156Model:onInit()
	self._actInfo = nil
end

function Activity156Model:reInit()
	self._actInfo = nil
end

function Activity156Model:setActivityInfo(info)
	self._actInfo = {}

	for _, v in pairs(info) do
		if v.id and v.state then
			self._actInfo[v.id] = v.state
		end
	end
end

function Activity156Model:setLocalIsPlay(id)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. PlayerPrefsKey.VersionActivity1_6WarmUpView .. id, id)
end

function Activity156Model:checkLocalIsPlay(id)
	local value = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. PlayerPrefsKey.VersionActivity1_6WarmUpView .. id, "")

	if string.nilorempty(value) then
		return false
	end

	return true
end

function Activity156Model:isEpisodeFinishedButUnReceive(episodeId)
	return self._actInfo and self._actInfo[episodeId] == Activity156Model.EpisodeFinishedState
end

function Activity156Model:isEpisodeFinished(episodeId)
	return self:isEpisodeFinishedButUnReceive(episodeId) or self:isEpisodeHasReceivedReward(episodeId)
end

function Activity156Model:isEpisodeHasReceivedReward(episodeId)
	return self._actInfo and self._actInfo[episodeId] == Activity156Model.EpisodeFinishedState
end

function Activity156Model:setCurSelectedEpisode(episodeId)
	self._curSelectedEpisodeId = episodeId
end

function Activity156Model:getCurSelectedEpisode()
	return self._curSelectedEpisodeId
end

function Activity156Model:cleanCurSelectedEpisode()
	self._curSelectedEpisodeId = nil
end

function Activity156Model:setIsPlayingMusicId(id)
	self._isPlayingMusicId = id
end

function Activity156Model:checkIsPlayingMusicId(id)
	if self._isPlayingMusicId == id then
		return true
	end

	return false
end

function Activity156Model:cleanIsPlayingMusicId()
	self._isPlayingMusicId = nil
end

function Activity156Model:isEpisodeUnLock(episodeId)
	local preEpisodeCfg = Activity156Config.instance:getPreEpisodeConfig(episodeId)
	local var_15_0

	if (preEpisodeCfg or nil) and self:isEpisodeFinished(preEpisodeCfg.id) then
		::label_15_0::

		var_15_0 = self._actInfo and self._actInfo[episodeId] ~= nil
	end

	return var_15_0
end

function Activity156Model:isOpen(actId, episodeId)
	local result = false
	local actMO = ActivityModel.instance:getActMO(actId)
	local openDay = Activity156Config.instance:getEpisodeOpenDay(episodeId)

	if actMO and openDay then
		local openTime = actMO:getRealStartTimeStamp() + (openDay - 1) * TimeUtil.OneDaySecond
		local time = ServerTime.now()

		if openTime < ServerTime.now() then
			result = true
		end
	end

	return result
end

function Activity156Model:reallyOpen(actId, episodeId)
	local isEpisodeUnLock = self:isEpisodeUnLock(episodeId)
	local isOpenDay = self:isOpen(actId, episodeId)

	return isEpisodeUnLock and isOpenDay
end

function Activity156Model:getLastEpisode()
	if self._actInfo then
		for index, value in ipairs(self._actInfo) do
			if self:reallyOpen(ActivityEnum.Activity.Activity1_6WarmUp, index) then
				if value == Activity156Model.EpisodeUnFinishState then
					return index
				end
			else
				return index - 1
			end
		end

		return #self._actInfo
	end
end

function Activity156Model:getActivityInfo()
	return self._actInfo
end

function Activity156Model:isAllEpisodeFinish()
	if self._actInfo then
		for _, v in pairs(self._actInfo) do
			if tonumber(v) == 0 then
				return false
			end
		end

		return true
	end

	return false
end

Activity156Model.instance = Activity156Model.New()

return Activity156Model
