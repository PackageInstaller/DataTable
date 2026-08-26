-- chunkname: @modules/logic/versionactivity1_3/act125/model/Activity125Model.lua

module("modules.logic.versionactivity1_3.act125.model.Activity125Model", package.seeall)

local Activity125Model = class("Activity125Model", BaseModel)

function Activity125Model:onInit()
	return
end

function Activity125Model:reInit()
	return
end

function Activity125Model:setActivityInfo(info)
	local mo = self:getById(info.activityId)

	if not mo then
		mo = Activity125MO.New()

		mo:setInfo(info)
		self:addAtLast(mo)
	else
		mo:setInfo(info)
	end
end

function Activity125Model:refreshActivityInfo(info)
	local mo = self:getById(info.activityId)

	if not mo then
		return
	end

	mo:updateInfo(info.updateAct125Episodes)
end

function Activity125Model:isEpisodeFinished(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isEpisodeFinished(episodeId)
end

function Activity125Model:isEpisodeUnLock(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isEpisodeUnLock(episodeId)
end

function Activity125Model:isEpisodeDayOpen(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isEpisodeDayOpen(episodeId)
end

function Activity125Model:isEpisodeReallyOpen(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isEpisodeReallyOpen(episodeId)
end

function Activity125Model:getLastEpisode(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:getLastEpisode()
end

function Activity125Model:setLocalIsPlay(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	mo:setLocalIsPlay(episodeId)
end

function Activity125Model:checkLocalIsPlay(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:checkLocalIsPlay(episodeId)
end

function Activity125Model:getEpisodeCount(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:getEpisodeCount()
end

function Activity125Model:getEpisodeList(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:getEpisodeList()
end

function Activity125Model:getEpisodeConfig(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:getEpisodeConfig(episodeId)
end

function Activity125Model:setSelectEpisodeId(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:setSelectEpisodeId(episodeId)
end

function Activity125Model:getSelectEpisodeId(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:getSelectEpisodeId()
end

function Activity125Model:setOldEpisode(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	mo:setOldEpisode(episodeId)
end

function Activity125Model:checkIsOldEpisode(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:checkIsOldEpisode(episodeId)
end

function Activity125Model:isAllEpisodeFinish(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isAllEpisodeFinish()
end

function Activity125Model:isHasEpisodeCanReceiveReward(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isHasEpisodeCanReceiveReward(episodeId)
end

function Activity125Model:isFirstCheckEpisode(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:isFirstCheckEpisode(episodeId)
end

function Activity125Model:setHasCheckEpisode(activityId, episodeId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:setHasCheckEpisode(episodeId)
end

function Activity125Model:hasEpisodeCanCheck(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:hasEpisodeCanCheck()
end

function Activity125Model:hasEpisodeCanGetReward(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:hasEpisodeCanGetReward()
end

function Activity125Model:hasRedDot(activityId)
	local mo = self:getById(activityId)

	if not mo then
		return
	end

	return mo:hasRedDot()
end

function Activity125Model:isActivityOpen(actId)
	if ActivityModel.instance:isActOnLine(actId) == false then
		return false
	end

	local activityInfoMo = ActivityModel.instance:getActMO(actId)

	return activityInfoMo:isOpen() and not activityInfoMo:isExpired()
end

Activity125Model.instance = Activity125Model.New()

return Activity125Model
