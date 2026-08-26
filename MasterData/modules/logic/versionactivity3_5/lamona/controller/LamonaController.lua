-- chunkname: @modules/logic/versionactivity3_5/lamona/controller/LamonaController.lua

module("modules.logic.versionactivity3_5.lamona.controller.LamonaController", package.seeall)

local LamonaController = class("LamonaController", BaseController)

function LamonaController:onInit()
	self._jumpEpisodeId = nil
end

function LamonaController:onInitFinish()
	return
end

function LamonaController:addConstEvents()
	return
end

function LamonaController:reInit()
	self._jumpEpisodeId = nil
end

function LamonaController:getAct220LamonaInfo(cb, cbObj)
	local actId = LamonaModel.instance:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, cb, cbObj)
end

function LamonaController:enterEpisodeLevelView(jumpEpisodeId)
	self._jumpEpisodeId = jumpEpisodeId

	self.getAct220LamonaInfo(self, self._openEpisodeLevelViewAfterGetInfo, self)
end

function LamonaController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local curActId = LamonaModel.instance:getActId()
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

	self._jumpEpisodeId = nil
end

function LamonaController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.LamonaLevelView, {
		jumpEpisodeId = self._jumpEpisodeId
	})
end

function LamonaController:openTaskView()
	local actId = LamonaModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.LamonaTaskView, {
		actId = actId
	})
end

function LamonaController:openGameResultView(isWin, episodeId)
	ViewMgr.instance:openView(ViewName.LamonaResultView)
end

function LamonaController:clickEpisodeLevel(episodeId, index)
	local actId = LamonaModel.instance:getActId()
	local act220MO = Activity220Model.instance:getById(actId)
	local episodeMO = act220MO and act220MO:getEpisodeInfo(episodeId)

	if not episodeMO then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	local episodeCfg = episodeMO.config
	local storeBefore = episodeCfg.storyBefore
	local param = {
		episodeCfg = episodeCfg
	}

	if storeBefore > 0 then
		local storyParam = {}

		storyParam.mark = true

		StoryController.instance:playStory(storeBefore, storyParam, self._afterPlayLevelBeforeStory, self, param)
	else
		self:_afterPlayLevelBeforeStory(param)
	end

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, index)
end

function LamonaController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId = cfg.episodeId
	local gameId = cfg.gameId

	if gameId ~= 0 then
		LamonaGameController.instance:enterGame(episodeId, gameId)
	else
		self:finishEpisodeLevel(episodeId)
	end
end

function LamonaController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = LamonaModel.instance:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

LamonaController.instance = LamonaController.New()

return LamonaController
