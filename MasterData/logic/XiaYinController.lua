-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/controller/XiaYinController.lua

module("logic.extensions.xiayin.controller.XiaYinController", package.seeall)

local XiaYinController = class("XiaYinController", BaseController)

function XiaYinController:ctor()
	return
end

function XiaYinController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.NotifyXiaYinChallengeRes, self._onNotifyXiaYinChallengeRes, self)
	GlobalDispatcher:addListener("enterxiayinmainview", self._enterEventOpenView, self)
end

function XiaYinController:onReset()
	return
end

function XiaYinController:_onNotifyXiaYinChallengeRes(activityId)
	local viewName = XiaYinModel.instance:getJumpMainViewName()

	UIJumper.instance:pushOneStack(viewName, true, activityId)
	printInfo("test XiaYinController:_onNotifyXiaYinChallengeRes", activityId)

	if not XiaYinModel.instance:isAllStagePass(activityId) then
		viewName = XiaYinModel.instance:getJumpLevelViewName()

		UIJumper.instance:pushOneStack(viewName, true, activityId)
	end
end

function XiaYinController:openMissionView(activityId, tierId, creepsMasterId, levelIndex, tagView)
	printInfo("test XiaYinController:openMissionView", activityId, tierId, creepsMasterId)

	local customFmtMo = XiaYinModel.instance:getCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, tierId, creepsMasterId, levelIndex, tagView)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function XiaYinController:openResultView(activityId, creepsMasterId)
	local isWin = XiaYinModel.instance:isWinBattle(activityId)
	local viewName = XiaYinModel.instance:getJumpResultViewName()

	UIStateManager.instance:push(viewName, creepsMasterId, isWin)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end
end

function XiaYinController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.XiaYinMainView, actId)
end

XiaYinController.instance = XiaYinController.New()

return XiaYinController
