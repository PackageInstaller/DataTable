-- chunkname: @modules/logic/versionactivity1_4/act131/controller/Activity131Controller.lua

module("modules.logic.versionactivity1_4.act131.controller.Activity131Controller", package.seeall)

local Activity131Controller = class("Activity131Controller", BaseController)

function Activity131Controller:openActivity131GameView(param)
	if param and param.episodeId then
		if not Activity131Model.instance:isEpisodeUnlock(param.episodeId) then
			GameFacade.showToast(ToastEnum.V1a4_act130EpisodeNotUnlock)

			return
		else
			Activity131Model.instance:setCurEpisodeId(param.episodeId)
		end
	end

	Activity131Controller.instance:dispatchEvent(Activity131Event.ShowLevelScene, false)
	ViewMgr.instance:openView(ViewName.Activity131GameView, param)
end

function Activity131Controller:enterActivity131()
	local key = PlayerPrefsKey.Version1_4_Act131Tips .. "#" .. tostring(VersionActivity1_4Enum.ActivityId.Role6) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
	local hasTiped = PlayerPrefsHelper.getNumber(key, 0) == 1

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act131OpenTips) or hasTiped then
		self:_getActInfoBeforeEnter()

		return
	end

	local episodeId = OpenConfig.instance:getOpenCo(OpenEnum.UnlockFunc.Act131OpenTips).episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local dungeonName = DungeonController.getEpisodeName(episodeCo)

	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130OpenTips, MsgBoxEnum.BoxType.Yes_No, function()
		PlayerPrefsHelper.setNumber(key, 1)
		self:_getActInfoBeforeEnter()
	end, nil, nil, nil, nil, nil, dungeonName)
end

function Activity131Controller:_getActInfoBeforeEnter()
	Activity131Rpc.instance:sendGet131InfosRequest(VersionActivity1_4Enum.ActivityId.Role6, self._onReceiveInfo, self)
end

function Activity131Controller:_onReceiveInfo(cmd, resultCode, msg)
	self:openActivity131LevelView()
end

function Activity131Controller:openActivity131LevelView(param)
	local pvStory = ActivityConfig.instance:getActivityCo(VersionActivity1_4Enum.ActivityId.Role6).storyId

	if pvStory > 0 and not StoryModel.instance:isStoryFinished(pvStory) then
		StoryController.instance:playStory(pvStory, nil, function()
			self:_realOpenLevelView(param)
		end, nil)

		return
	end

	self:_realOpenLevelView(param)
end

function Activity131Controller:_realOpenLevelView(param)
	ViewMgr.instance:openView(ViewName.Activity131LevelView, param)
end

function Activity131Controller:openActivity131DialogView(param)
	ViewMgr.instance:openView(ViewName.Activity131DialogView, param)
end

function Activity131Controller:openActivity131TaskView()
	ViewMgr.instance:openView(ViewName.Activity131TaskView)
end

function Activity131Controller:delayReward(delayTime, taskMO)
	if self._act131TaskMO == nil and taskMO then
		self._act131TaskMO = taskMO

		TaskDispatcher.runDelay(self._onPreFinish, self, delayTime)

		return true
	end

	return false
end

function Activity131Controller:_onPreFinish()
	local act131TaskMO = self._act131TaskMO

	self._act131TaskMO = nil

	if act131TaskMO and (act131TaskMO.id == Activity131Enum.TaskMOAllFinishId or act131TaskMO:alreadyGotReward()) then
		Activity131TaskListModel.instance:preFinish(act131TaskMO)

		self._act131TaskId = act131TaskMO.id

		TaskDispatcher.runDelay(self._onRewardTask, self, Activity131Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function Activity131Controller:_onRewardTask()
	local act131TaskId = self._act131TaskId

	self._act131TaskId = nil

	if act131TaskId then
		if act131TaskId == Activity131Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity131)
		else
			TaskRpc.instance:sendFinishTaskRequest(act131TaskId)
		end
	end
end

function Activity131Controller:oneClaimReward(actId)
	local list = Activity131TaskListModel.instance:getList()

	for _, act131TaskMO in pairs(list) do
		if act131TaskMO:alreadyGotReward() and act131TaskMO.id ~= Activity131Enum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(act131TaskMO.id)
		end
	end
end

function Activity131Controller:enterFight(episodeCfg)
	local chapterId = episodeCfg.chapterId
	local episodeId = episodeCfg.id
	local battleId = episodeCfg.battleId

	if chapterId and episodeId and battleId then
		DungeonFightController.instance:enterFightByBattleId(chapterId, episodeId, battleId)
	else
		logError("副本关卡表配置错误,%s的chapterId或battleId为空", episodeId)
	end
end

function Activity131Controller:openLogView()
	ViewMgr.instance:openView(ViewName.Activity131LogView)
end

Activity131Controller.instance = Activity131Controller.New()

return Activity131Controller
