-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/controller/WaterTianYanController.lua

module("logic.extensions.watertianyan.controller.WaterTianYanController", package.seeall)

local WaterTianYanController = class("WaterTianYanController", BaseController)

WaterTianYanController.KeyWordChosedBuff = "WaterTianYanChosedBuff"
WaterTianYanController.KeyWordChosedBuffFlag = "WaterTianYanChosedBuff_flag"

function WaterTianYanController:ctor()
	return
end

function WaterTianYanController:saveSelectBuff(activityId, curStageId, buffType, buffId)
	local buffFlag = self:getBuffFlag()

	GameUtil.saveUserData(WaterTianYanController.KeyWordChosedBuff .. "_" .. buffFlag .. "_" .. activityId .. "_" .. curStageId .. "_" .. buffType, buffId)
end

function WaterTianYanController:getSelectBuff(activityId, curStageId, buffType)
	local buffFlag = self:getBuffFlag()

	return GameUtil.getUserData(WaterTianYanController.KeyWordChosedBuff .. "_" .. buffFlag .. "_" .. activityId .. "_" .. curStageId .. "_" .. buffType)
end

function WaterTianYanController:getBuffFlag()
	return checknumber(GameUtil.getUserData(WaterTianYanController.KeyWordChosedBuffFlag))
end

function WaterTianYanController:setBuffFlag()
	local num = self:getBuffFlag()

	GameUtil.saveUserData(WaterTianYanController.KeyWordChosedBuffFlag, num + 1)
end

function WaterTianYanController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.Notify_WaterTianYanBuildingStageChallengeRes, self._onBuildingStageChallengeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.Notify_WaterTianYanMainStageChallengeRes, self._onMainStageChallengeRes, self)
end

function WaterTianYanController:_onBuildingStageChallengeRes(activityId)
	local mainView = WaterTianYanEnum.ViewNames[activityId][WaterTianYanEnum.ViewTypes_MainView]
	local clgBuildView = WaterTianYanEnum.ViewNames[activityId][WaterTianYanEnum.ViewTypes_ClgBuildView]

	UIJumper.instance:pushOneStack(mainView, true)
	UIJumper.instance:pushOneStack(clgBuildView, true, activityId)
end

function WaterTianYanController:_onMainStageChallengeRes(activityId)
	local mainView = WaterTianYanEnum.ViewNames[activityId][WaterTianYanEnum.ViewTypes_MainView]
	local clgMainView = WaterTianYanEnum.ViewNames[activityId][WaterTianYanEnum.ViewTypes_ClgMainView]

	UIJumper.instance:pushOneStack(mainView, true)
	UIJumper.instance:pushOneStack(clgMainView, true, activityId)
end

function WaterTianYanController:openBuildMissionView(activityId, stageId, index)
	local customFmtMo = WaterTianYanModel.instance:getBuildCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId, index)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function WaterTianYanController:openMainMissionView(activityId, stageId, buffItemIds)
	local customFmtMo = WaterTianYanModel.instance:getMainCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, stageId, buffItemIds)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function WaterTianYanController:getViewName(activityId, viewType)
	return
end

WaterTianYanController.instance = WaterTianYanController.New()

return WaterTianYanController
