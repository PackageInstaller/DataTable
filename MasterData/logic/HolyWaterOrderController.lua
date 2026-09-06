-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holywaterorder/controller/HolyWaterOrderController.lua

module("logic.extensions.holywaterorder.controller.HolyWaterOrderController", package.seeall)

local HolyWaterOrderController = class("HolyWaterOrderController", BaseController)

function HolyWaterOrderController:ctor()
	return
end

function HolyWaterOrderController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderNotifyChallengeResultRes, self._onNotifyChallengeResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HolyWaterOrderCloseBuff, self._onCloseBuffView, self)
end

function HolyWaterOrderController:_onNotifyChallengeResultRes()
	UIJumper.instance:pushOneStack(ViewName.HolyWaterOrderMainView, true)
	UIJumper.instance:pushOneStack(ViewName.HolyWaterOrderChallengeView, true, HolyWaterOrderModel.instance:getActivityId())
end

function HolyWaterOrderController:_onCloseBuffView()
	UIStateManager.instance:popByName(ViewName.HolyWaterOrderBuffView)
end

function HolyWaterOrderController:openMissionView(activityId, stageId)
	local customFmtMo = HolyWaterOrderModel.instance:getCustomFmtMo()

	customFmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
	UIStateManager.instance:push(ViewName.HolyWaterOrderBuffView, activityId, stageId)
end

function HolyWaterOrderController:openBattleResultView()
	UIStateManager.instance:push(ViewName.HolyWaterOrderResultView, HolyWaterOrderModel.instance:getActivityId())
end

HolyWaterOrderController.instance = HolyWaterOrderController.New()

return HolyWaterOrderController
