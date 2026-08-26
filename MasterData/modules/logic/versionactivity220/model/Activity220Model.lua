-- chunkname: @modules/logic/versionactivity220/model/Activity220Model.lua

module("modules.logic.versionactivity220.model.Activity220Model", package.seeall)

local Activity220Model = class("Activity220Model", BaseModel)

function Activity220Model:onInit()
	return
end

function Activity220Model:reInit()
	self:onInit()
end

function Activity220Model:updateInfo(info)
	local mo = self:getById(info.activityId)

	if not mo then
		mo = Activity220MO.New()

		mo:init(info.activityId)
		self:addAtLast(mo)
	end

	mo:updateInfo(info)
end

function Activity220Model:updateEpisodeInfo(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:updateEpisodeProgress(info)
	end
end

function Activity220Model:finishEpisode(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:finishEpisode(info)
	end
end

function Activity220Model:unlockEpisodeBranch(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:unlockEpisodeBranch(info)
	end
end

function Activity220Model:pushEpisodes(info)
	local mo = self:getById(info.activityId)

	if mo then
		mo:pushEpisodes(info)
	end
end

function Activity220Model:getMaxUnlockEpisodeId(activityId)
	local maxEpisodeId = 0
	local mo = self:getById(activityId)

	if mo then
		local episodeCos = Activity220Config.instance:getEpisodeConfigList(activityId)

		for _, episodeCo in pairs(episodeCos) do
			local isUnlock = mo:isEpisodeUnlock(episodeCo.episodeId)

			maxEpisodeId = isUnlock and math.max(maxEpisodeId, episodeCo.episodeId) or maxEpisodeId
		end
	end

	return maxEpisodeId
end

function Activity220Model:setCurEpisode(activityId, index, episodeId)
	local mo = self:getById(activityId)

	if mo then
		mo:setCurEpisode(index, episodeId)
	end
end

function Activity220Model:getEpisodeInfo(activityId, episodeId)
	local mo = self:getById(activityId)

	if mo then
		return mo:getEpisodeInfo(episodeId)
	end
end

Activity220Model.instance = Activity220Model.New()

return Activity220Model
