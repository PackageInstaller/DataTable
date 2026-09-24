-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/controller/SpLilyaController.lua

module("modules.logic.versionactivity4_0.sp_lilya.controller.SpLilyaController", package.seeall)

local SpLilyaController = class("SpLilyaController", BaseController)

function SpLilyaController:onInit()
	return
end

function SpLilyaController:onInitFinish()
	return
end

function SpLilyaController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.onEndDungeonPush, self)
end

function SpLilyaController:getActId()
	return SpLilyaModel.instance:getActId()
end

function SpLilyaController:onEndDungeonPush(msg)
	local actId = self:getActId()
	local characterCo = DungeonConfig.instance:getChapterCO(msg.chapterId)

	if characterCo and msg.star > 0 and characterCo.actId == actId then
		self.recordEpisodeId = Activity220Config.instance:get220EpisodeIdByFightEpisodeId(actId, msg.episodeId)
	end
end

function SpLilyaController:getAct220SpLilyaInfo(cb, cbObj)
	local actId = SpLilyaModel.instance:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, cb, cbObj)
end

function SpLilyaController:enterEpisodeLevelView()
	self.getAct220SpLilyaInfo(self, self._openEpisodeLevelViewAfterGetInfo, self)
end

function SpLilyaController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local curActId = SpLilyaModel.instance:getActId()
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

function SpLilyaController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.SpLilyaLevelView)
end

function SpLilyaController:openTaskView()
	local actId = SpLilyaModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.SpLilyaTaskView, {
		actId = actId
	})
end

function SpLilyaController:openGameResultView()
	ViewMgr.instance:openView(ViewName.SpLilyaGameResultView)
end

function SpLilyaController:GMEnterGame(actId, episodeId)
	SpLilyaGameController.instance:enterGame(actId, episodeId)
end

function SpLilyaController:clickEpisodeLevel(episodeId, index)
	local actId = SpLilyaModel.instance:getActId()
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

function SpLilyaController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId220 = cfg.episodeId

	if cfg.fightEpisodeId ~= 0 then
		Activity220Controller.instance:enterFight(cfg.activityId, cfg.episodeId)
	elseif cfg.gameId ~= 0 then
		local actId = SpLilyaModel.instance:getActId()

		SpLilyaGameController.instance:enterGame(actId, cfg.episodeId)
	else
		self:finishEpisodeLevel(episodeId220)
	end
end

function SpLilyaController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = SpLilyaModel.instance:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

function SpLilyaController:checkLastFight()
	if self.recordEpisodeId then
		self:finishEpisodeLevel(self.recordEpisodeId)

		self.recordEpisodeId = nil
	end
end

SpLilyaController.instance = SpLilyaController.New()

return SpLilyaController
