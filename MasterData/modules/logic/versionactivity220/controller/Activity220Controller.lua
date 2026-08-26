-- chunkname: @modules/logic/versionactivity220/controller/Activity220Controller.lua

module("modules.logic.versionactivity220.controller.Activity220Controller", package.seeall)

local Activity220Controller = class("Activity220Controller", BaseController)

function Activity220Controller:onInit()
	return
end

function Activity220Controller:reInit()
	return
end

function Activity220Controller:onGameFinished(actId, episodeId)
	local mo = Activity220Model.instance:getById(actId)

	if not mo then
		return
	end

	local episodeInfo = mo:getEpisodeInfo(episodeId)

	if not episodeInfo then
		return
	end

	if not episodeInfo:isEpisodePass() then
		local param = {
			episodeId = episodeId,
			activityId = actId
		}
		local storyClear = episodeInfo:getStoryClear()

		if storyClear and storyClear ~= 0 then
			StoryController.instance:playStory(storyClear, nil, self._afterFinishStory, self, param)
		else
			self:_afterFinishStory(param)
		end
	else
		self:_playStoryClear(actId, episodeId)
	end
end

function Activity220Controller:_afterFinishStory(param)
	local actId = param and param.activityId
	local episodeId = param and param.episodeId

	if not actId or not episodeId then
		return
	end

	Activity220Rpc.instance:sendAct220FinishEpisodeRequest(actId, episodeId, nil, self.onSendAct220FinishEpisodeCallback, self)
end

function Activity220Controller:onSendAct220FinishEpisodeCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = msg.activityId
	local episodeId = msg.episodeId
	local mo = Activity220Model.instance:getById(actId)

	if mo then
		mo:setNewFinishEpisode(episodeId)
	end

	self:finishEpisode({
		episodeId = episodeId,
		activityId = actId
	})
end

function Activity220Controller:_playStoryClear(actId, episodeId)
	local mo = Activity220Model.instance:getById(actId)

	if not mo then
		return
	end

	local episodeInfo = mo:getEpisodeInfo(episodeId)

	if not episodeInfo then
		return
	end

	if not episodeInfo:isEpisodePass() then
		return
	end

	local param = {
		episodeId = episodeId,
		activityId = actId
	}
	local storyClear = episodeInfo:getStoryClear()

	if storyClear and storyClear ~= 0 then
		StoryController.instance:playStory(storyClear, nil, self.finishEpisode, self, param)
	else
		self:finishEpisode(param)
	end
end

function Activity220Controller:finishEpisode(param)
	local episodeId = param and param.episodeId
	local actId = param and param.activityId

	if not actId or not episodeId then
		return
	end

	self:dispatchEvent(Activity220Event.EpisodeFinished)
end

Activity220Controller.instance = Activity220Controller.New()

return Activity220Controller
