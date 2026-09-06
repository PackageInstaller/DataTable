-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfareequiprecycle/controller/WelfareRecycleController.lua

module("logic.extensions.welfareequiprecycle.controller.WelfareRecycleController", package.seeall)

local WelfareRecycleController = class("WelfareRecycleController", BaseController)

function WelfareRecycleController:ctor()
	return
end

function WelfareRecycleController:onInit()
	self:onReset()
end

function WelfareRecycleController:onReset()
	return
end

function WelfareRecycleController:sendWelfareRecycle(activityId, itemMap)
	ThroneEquipmentReplaceAgent.instance:sendPM_ThroneEquipmentReplaceReq(activityId, itemMap)
end

WelfareRecycleController.instance = WelfareRecycleController.New()

return WelfareRecycleController
