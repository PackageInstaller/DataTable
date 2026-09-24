-- chunkname: @modules/logic/versionactivity4_0/deleike/controller/DeleikeController.lua

module("modules.logic.versionactivity4_0.deleike.controller.DeleikeController", package.seeall)

local DeleikeController = class("DeleikeController", BaseController)

function DeleikeController:onInit()
	self._curEpisodeCo = nil
end

function DeleikeController:reInit()
	self:onInit()
end

function DeleikeController:addConstEvents()
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.onEndDungeonPush, self)
end

function DeleikeController:getActId()
	return VersionActivity4_0Enum.ActivityId.Deleike
end

function DeleikeController:onEndDungeonPush(msg)
	local actId = self:getActId()
	local characterCo = DungeonConfig.instance:getChapterCO(msg.chapterId)

	if characterCo and msg.star > 0 and characterCo.actId == actId then
		self.recordEpisodeId = Activity220Config.instance:get220EpisodeIdByFightEpisodeId(actId, msg.episodeId)
	end
end

function DeleikeController:onGameFinish()
	if self._curEpisodeCo then
		self:finishEpisodeLevel(self._curEpisodeCo.episodeId)

		self._curEpisodeCo = nil
	end
end

function DeleikeController:enterEpisodeLevelView()
	local actId = self:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, self._openEpisodeLevelViewAfterGetInfo, self)
end

function DeleikeController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = self:getActId()
	local activityMo = ActivityModel.instance:getActMO(actId)

	if activityMo and msg.activityId == actId then
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

function DeleikeController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.DeleikeLevelView)
end

function DeleikeController:clickEpisodeLevel(episodeId)
	local actId = self:getActId()
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
end

function DeleikeController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId220 = cfg.episodeId

	if cfg.fightEpisodeId ~= 0 then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(cfg.fightEpisodeId)

		if not episodeConfig then
			logError("副本表_关卡表不存在关卡配置" .. cfg.fightEpisodeId)

			return
		end

		local chapterId = episodeConfig.chapterId
		local battleId = episodeConfig.battleId

		if chapterId and episodeConfig.id and battleId > 0 then
			DungeonFightController.instance:enterFightByBattleId(chapterId, episodeConfig.id, battleId)

			local fightParam = FightModel.instance:getFightParam()

			if fightParam then
				fightParam:setShowSettlement(false)
			end
		end
	elseif cfg.gameId ~= 0 then
		self._curEpisodeCo = cfg

		self:startGame(cfg.gameId)
	else
		self:finishEpisodeLevel(episodeId220)
	end
end

function DeleikeController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = self:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

function DeleikeController:checkLastFight()
	if self.recordEpisodeId then
		self:finishEpisodeLevel(self.recordEpisodeId)

		self.recordEpisodeId = nil
	end
end

function DeleikeController:startGame(gameId)
	if not DeleikeGameMgr.instance:startGame(gameId) then
		return
	end

	self.startTime = ServerTime.now()
	self.totalRevertTimes = 0
	self.totalResetTimes = 0

	ViewMgr.instance:openView(ViewName.DeleikeGameView)
	self:dispatchEvent(DeleikeEvent.ZTriggerStartGame, gameId)
end

function DeleikeController:closeGameView(isManual)
	ViewMgr.instance:closeView(ViewName.DeleikeGameView)
	self:reportGameEnd(isManual)
end

function DeleikeController:onGameRevert()
	self.totalRevertTimes = self.totalRevertTimes + 1
end

function DeleikeController:onGameReset()
	self.totalResetTimes = self.totalResetTimes + 1
end

function DeleikeController:reportGameEnd(isManual)
	local useTime = ServerTime.now() - self.startTime

	StatController.instance:track(StatEnum.EventName.DeleikeGame, {
		[StatEnum.EventProperties.EpisodeId_Num] = DeleikeGameMgr.instance.gameId,
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.OperationType] = isManual and "exit" or "success",
		[StatEnum.EventProperties.RevertTimes] = self.totalRevertTimes,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = self.totalResetTimes
	})
end

DeleikeController.instance = DeleikeController.New()

return DeleikeController
