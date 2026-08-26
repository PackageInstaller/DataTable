-- chunkname: @modules/logic/versionactivity1_7/doubledrop/model/DoubleDropModel.lua

module("modules.logic.versionactivity1_7.doubledrop.model.DoubleDropModel", package.seeall)

local DoubleDropModel = class("DoubleDropModel", BaseModel)

function DoubleDropModel:onInit()
	self:reInit()
end

function DoubleDropModel:reInit()
	self.act153Dict = {}
end

function DoubleDropModel:getActId()
	local list = ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.DoubleDrop)

	return list and list[1]
end

function DoubleDropModel:setActivity153Infos(info)
	self:updateActivity153Info(info)
	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshDoubleDropInfo)
end

function DoubleDropModel:updateActivity153Info(info)
	local mo = self:getById(info.activityId)

	if not mo then
		mo = DoubleDropMo.New()

		mo:init(info)
		self:addAtLast(mo)
	else
		mo:init(info)
	end
end

function DoubleDropModel:isShowDoubleByChapter(chapter, ignoreFreeLimit)
	local actId = self:getActId()

	if not actId or not ActivityModel.instance:isActOnLine(actId) then
		return false
	end

	local episodes = DoubleDropConfig.instance:getAct153ActEpisodes(actId)

	if not episodes then
		return false
	end

	local isDoubleChapter = false

	for k, v in pairs(episodes) do
		local episodeCo = DungeonConfig.instance:getEpisodeCO(v.episodeId)

		if episodeCo and episodeCo.chapterId == chapter then
			isDoubleChapter = true

			break
		end
	end

	if isDoubleChapter then
		if not ignoreFreeLimit then
			local chapterCo = DungeonConfig.instance:getChapterCO(chapter)
			local enterAfterFreeLimit = chapterCo.enterAfterFreeLimit > 0

			if enterAfterFreeLimit and DungeonModel.instance:getChapterRemainingNum(chapterCo.type) > 0 then
				return false
			end
		end

		local isDoubleTimesout, dailyTimes, dailyLimit = self:isDoubleTimesout()

		return not isDoubleTimesout, dailyTimes, dailyLimit
	end

	return false
end

function DoubleDropModel:isShowDoubleByEpisode(episode, ignoreFreeLimit)
	local actId = self:getActId()

	if not actId or not ActivityModel.instance:isActOnLine(actId) then
		return false
	end

	local episodes = DoubleDropConfig.instance:getAct153ActEpisodes(actId)

	if not episodes then
		return false
	end

	local isDoubleEpisode = false

	for k, v in pairs(episodes) do
		if v.episodeId == episode then
			isDoubleEpisode = true

			break
		end
	end

	if isDoubleEpisode then
		if not ignoreFreeLimit then
			local episodeCo = DungeonConfig.instance:getEpisodeCO(episode)
			local chapterCo = DungeonConfig.instance:getChapterCO(episodeCo.chapterId)
			local enterAfterFreeLimit = chapterCo.enterAfterFreeLimit > 0

			if enterAfterFreeLimit and DungeonModel.instance:getChapterRemainingNum(chapterCo.type) > 0 then
				return false
			end
		end

		local isDoubleTimesout, dailyTimes, dailyLimit = self:isDoubleTimesout()

		return not isDoubleTimesout, dailyTimes, dailyLimit
	end

	return false
end

function DoubleDropModel:isDoubleTimesout()
	local actId = self:getActId()

	if not actId or not ActivityModel.instance:isActOnLine(actId) then
		return true
	end

	local mo = self:getById(actId)

	if not mo then
		return true
	end

	return mo:isDoubleTimesout()
end

function DoubleDropModel:getDailyRemainTimes()
	local actId = self:getActId()

	if not actId then
		return
	end

	local mo = self:getById(actId)

	if not mo then
		local co = DoubleDropConfig.instance:getAct153Co(actId)

		if co then
			if not co.dailyLimit then
				local dailyLimit = 0

				return dailyLimit, dailyLimit
			end
		end
	end

	return mo:getDailyRemainTimes()
end

DoubleDropModel.instance = DoubleDropModel.New()

return DoubleDropModel
