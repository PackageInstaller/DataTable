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
		local episodeConfig = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
		local isFightLevel = episodeConfig and episodeConfig.fightEpisodeId ~= 0

		if not isFightLevel then
			local storyClear = episodeInfo:getStoryClear()

			if storyClear and storyClear ~= 0 then
				StoryController.instance:playStory(storyClear, nil, self._afterFinishStory, self, {
					episodeId = episodeId,
					activityId = actId
				})

				return
			end
		end

		self:_afterFinishStory({
			episodeId = episodeId,
			activityId = actId
		})
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
	local episodeConfig = Activity220Config.instance:getEpisodeConfig(actId, episodeId)
	local showStory = episodeConfig.gameId ~= 0 and episodeConfig.fightEpisodeId == 0

	if showStory and storyClear and storyClear ~= 0 then
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

function Activity220Controller:finishAllTask(activityId, callback, callbackObj)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity220, nil, nil, callback, callbackObj, activityId)
end

function Activity220Controller:enterFight(actId, episodeId)
	local act220EpisodeConfig = Activity220Config.instance:getEpisodeConfig(actId, episodeId)

	if not act220EpisodeConfig then
		logError("活动220_关卡配置不存在 actId:" .. tostring(actId) .. " episodeId:" .. tostring(episodeId))

		return
	end

	local fightEpisodeId = act220EpisodeConfig.fightEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(fightEpisodeId)

	if not episodeConfig then
		logError("副本表_关卡表不存在关卡配置 fightEpisodeId:" .. tostring(fightEpisodeId))

		return
	end

	local chapterId = episodeConfig.chapterId
	local battleId = episodeConfig.battleId

	if chapterId and episodeConfig.id and battleId > 0 then
		DungeonFightController.instance:enterFightByBattleId(chapterId, episodeConfig.id, battleId)

		local showResultView = episodeConfig.afterStory == nil or act220EpisodeConfig.afterStory == 0

		self:setResultViewState(showResultView)
	end
end

function Activity220Controller:setResultViewState(isShow)
	local fightParam = FightModel.instance:getFightParam()

	if fightParam then
		fightParam:setShowSettlement(isShow)
	end
end

Activity220Controller.instance = Activity220Controller.New()

return Activity220Controller
