-- chunkname: @modules/logic/versionactivity1_4/act130/controller/Activity130Controller.lua

module("modules.logic.versionactivity1_4.act130.controller.Activity130Controller", package.seeall)

local Activity130Controller = class("Activity130Controller", BaseController)

function Activity130Controller:openActivity130GameView(param)
	if param and param.episodeId then
		if not Activity130Model.instance:isEpisodeUnlock(param.episodeId) then
			GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

			return
		else
			Activity130Model.instance:setCurEpisodeId(param.episodeId)
		end
	end

	Activity130Controller.instance:dispatchEvent(Activity130Event.ShowLevelScene, false)
	ViewMgr.instance:openView(ViewName.Activity130GameView, param, true)
end

function Activity130Controller:openPuzzleView(param)
	Role37PuzzleModel.instance:setErrorCnt(0)
	ViewMgr.instance:openView(ViewName.Role37PuzzleView, param)
end

function Activity130Controller:enterActivity130()
	local key = PlayerPrefsKey.Version1_4_Act130Tips .. "#" .. tostring(VersionActivity1_4Enum.ActivityId.Role37) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act130OpenTips) or hasTiped then
		self:_getActInfoBeforeEnter()

		return
	end

	local episodeId = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act130OpenTips).episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local dungeonName = DungeonController.getEpisodeName(episodeCo)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(key, 1)
		self:_getActInfoBeforeEnter()
	end, nil, nil, nil, nil, nil, dungeonName)
end

function Activity130Controller:_getActInfoBeforeEnter()
	Activity130Rpc.instance:sendGet130InfosRequest(VersionActivity1_4Enum.ActivityId.Role37, self.openActivity130LevelView, self)
end

function Activity130Controller:openActivity130LevelView()
	local pvStory = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role37).storyId

	if pvStory > 0 and not StoryModel.instance:isStoryFinished(pvStory) then
		StoryController.instance:playStory(pvStory, nil, function()
			Activity130Model.instance:setNewFinishEpisode(0)
			Activity130Model.instance:setNewUnlockEpisode(1)

			local data = {}

			data.episodeId = 0

			self:_realOpenLevelView(data)
		end, nil)

		return
	end

	self:_realOpenLevelView()
end

function Activity130Controller:_realOpenLevelView(param)
	ViewMgr.instance:openView(ViewName.Activity130LevelView, param)
end

function Activity130Controller:openActivity130DialogView(param)
	ViewMgr.instance:openView(ViewName.Activity130DialogView, param)
end

function Activity130Controller:openActivity130CollectView()
	ViewMgr.instance:openView(ViewName.Activity130CollectView)
end

function Activity130Controller:openActivity130TaskView()
	ViewMgr.instance:openView(ViewName.Activity130TaskView)
end

function Activity130Controller:delayReward(delayTime, taskMO)
	if self._act130TaskMO == nil and taskMO then
		self._act130TaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function Activity130Controller:_onPreFinish()
	local act130TaskMO = self._act130TaskMO

	self._act130TaskMO = nil

	if act130TaskMO and (act130TaskMO.id == Activity130Enum.TaskMOAllFinishId or act130TaskMO:alreadyGotReward()) then
		Activity130TaskListModel.instance:preFinish(act130TaskMO)

		self._act130TaskId = act130TaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, Activity130Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function Activity130Controller:_onRewardTask()
	local act130TaskId = self._act130TaskId

	self._act130TaskId = nil

	if act130TaskId then
		if act130TaskId == Activity130Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity130)
		else
			TaskRpc.instance:sendFinishTaskRequest(act130TaskId)
		end
	end
end

function Activity130Controller:oneClaimReward(actId)
	local list = Activity130TaskListModel.instance:getList()

	for _, act130TaskMO in pairs(list) do
		if act130TaskMO:alreadyGotReward() and act130TaskMO.id ~= Activity130Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(act130TaskMO.id)
		end
	end
end

Activity130Controller.instance = Activity130Controller.New()

return Activity130Controller
