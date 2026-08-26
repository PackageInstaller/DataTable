-- chunkname: @modules/logic/versionactivity2_5/challenge/controller/Act183JumpController.lua

module("modules.logic.versionactivity2_5.challenge.controller.Act183JumpController", package.seeall)

local Act183JumpController = class("Act183JumpController", BaseController)
local actId = VersionActivity2_8Enum.ActivityId.Challenge
local enterActId = VersionActivity2_8Enum.ActivityId.EnterView

function Act183JumpController.fightExitHandleFunc(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = episodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act183MainView)

		local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
		local activityId = episodeCo and episodeCo.activityId

		VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, activityId)
		Act183Controller.instance:openAct183MainView(nil, function()
			local viewParam = Act183Helper.generateDungeonViewParams2(episodeId)

			Act183Controller.instance:openAct183DungeonView(viewParam)
		end)
	end)
end

function Act183JumpController:canJumpToAct183(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(enterActId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	local splitJumpParamArray = string.splitToNumber(jumpParamArray, "#")
	local groupId = splitJumpParamArray and splitJumpParamArray[2]
	local isGroupExist = Act183Config.instance:isGroupExist(actId, groupId)

	if not isGroupExist then
		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local actInfo = Act183Model.instance:getActInfo()
	local groupMo = actInfo:getGroupEpisodeMo(groupId)
	local status = groupMo and groupMo:getStatus()

	if status == Act183Enum.GroupStatus.Locked then
		return false, ToastEnum.Act183GroupNotOpen, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function Act183JumpController:jumpToAct183(paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_8EnterView)
	table.insert(self.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(self.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(self.closeViewNames, ViewName.Act183TaskView)
	VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		local splitParamsList = string.splitToNumber(paramsList, "#")
		local groupId = splitParamsList and splitParamsList[2]
		local viewParam = Act183Helper.generateDungeonViewParams3(actId, groupId)

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function()
				Act183Controller.instance:openAct183DungeonView(viewParam)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(viewParam)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function Act183JumpController:canJumpToEnterView(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(enterActId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function Act183JumpController:jumpToEnterView(paramsList)
	local actId = paramsList[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

local function addFightExitHandleFunc()
	local chapterCoList = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Act183)
	local isCurActConfig = actId == nil

	for _, chapterCo in ipairs(chapterCoList) do
		local chapterActId = chapterCo.actId

		if chapterActId ~= 0 then
			EnterActivityViewOnExitFightSceneHelper["enterActivity" .. chapterActId] = Act183JumpController.fightExitHandleFunc
			isCurActConfig = isCurActConfig or chapterActId == actId
		end
	end

	if not isCurActConfig then
		logError(string.format("挑战玩法添加战斗返回跳转方法失败!!!失败原因:副本表缺少对应活动项 actId = %s", actId))
	end
end

local function addActJumpHandleFunc()
	if not actId then
		return
	end

	local version = ActivityHelper.getActivityVersion(actId)

	if not version then
		return
	end

	local canJumpClsName = string.format("VersionActivity%sCanJumpFunc", version)
	local canJumpCls = _G[canJumpClsName]

	if canJumpCls then
		canJumpCls["canJumpTo" .. actId] = Act183JumpController.canJumpToEnterView
	else
		logError(string.format("缺少活动跳转检查脚本 cls = %s, actId = %s", canJumpClsName, actId))
	end

	local jumpHandleClsName = string.format("VersionActivity%sJumpHandleFunc", version)
	local jumpHandleCls = _G[jumpHandleClsName]

	if jumpHandleCls then
		jumpHandleCls["jumpTo" .. actId] = Act183JumpController.jumpToEnterView
	else
		logError(string.format("缺少活动跳转脚本 cls = %s, actId = %s", jumpHandleClsName, actId))
	end
end

function Act183JumpController:addConstEvents()
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._onGetInfoFinish, self)
end

function Act183JumpController:_onGetInfoFinish()
	addFightExitHandleFunc()
	addActJumpHandleFunc()
end

Act183JumpController.instance = Act183JumpController.New()

return Act183JumpController
