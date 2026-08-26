-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneController.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneController", package.seeall)

local HedoneController = class("HedoneController", BaseController)

function HedoneController:onInit()
	return
end

function HedoneController:onInitFinish()
	return
end

function HedoneController:addConstEvents()
	return
end

function HedoneController:reInit()
	return
end

function HedoneController:getAct220HedoneInfo(cb, cbObj)
	local actId = HedoneModel.instance:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, cb, cbObj)
end

function HedoneController:enterEpisodeLevelView()
	self.getAct220HedoneInfo(self, self._openEpisodeLevelViewAfterGetInfo, self)
end

function HedoneController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local curActId = HedoneModel.instance:getActId()
	local activityMo = ActivityModel.instance:getActMO(curActId)

	if activityMo and msg.activityId == curActId then
		if activityMo.config then
			if activityMo.config and activityMo.config > 0 and not StoryModel.instance:isStoryFinished(activityMo.config) then
				local storyParam = {}

				storyParam.mark = true

				StoryController.instance:playStory(activityMo.config, storyParam, self.openEpisodeLevelView, self)
			else
				self:openEpisodeLevelView()
			end
		end
	end
end

function HedoneController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.HedoneLevelView)
end

function HedoneController:openTaskView()
	local actId = HedoneModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.HedoneTaskView, {
		actId = actId
	})
end

function HedoneController:openGameResultView(isWin)
	local gameId = HedoneGameModel.instance:getGameId()
	local episodeId = HedoneGameModel.instance:getGameEpisodeId()

	if not gameId or not episodeId then
		return
	end

	local viewParam = {}

	viewParam.episodeId = episodeId
	viewParam.gameId = gameId
	viewParam.gameTime = HedoneGameModel.instance:getGameTime()

	local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(viewParam.gameId)

	viewParam.isWin = targetTime < 0 and true or isWin

	ViewMgr.instance:openView(ViewName.HedoneResultView, viewParam)
end

function HedoneController:clickEpisodeLevel(episodeId, index)
	local actId = HedoneModel.instance:getActId()
	local act220MO = Activity220Model.instance:getById(actId)
	local episodeMO = act220MO and act220MO:getEpisodeInfo(episodeId)

	if not episodeMO then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	local episodeCfg = episodeMO.config
	local storyBefore = episodeCfg.storyBefore
	local param = {
		episodeCfg = episodeCfg
	}

	if storyBefore and storyBefore > 0 then
		local storyParam = {}

		storyParam.mark = true

		StoryController.instance:playStory(storyBefore, storyParam, self._afterPlayLevelBeforeStory, self, param)
	else
		self:_afterPlayLevelBeforeStory(param)
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, index)
end

function HedoneController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId = cfg.episodeId
	local gameId = cfg.gameId

	if gameId ~= 0 then
		HedoneGameController.instance:enterGame(episodeId, gameId)

		local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(gameId)

		if targetTime < 0 then
			local actId = HedoneModel.instance:getActId()

			Activity220Rpc.instance:sendAct220FinishEpisodeRequest(actId, episodeId, nil, Activity220Controller.onSendAct220FinishEpisodeCallback, Activity220Controller.instance)
		end
	else
		self:finishEpisodeLevel(episodeId)
	end
end

function HedoneController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = HedoneModel.instance:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

HedoneController.instance = HedoneController.New()

return HedoneController
