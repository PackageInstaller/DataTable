-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/controller/HuarongRoadController.lua

module("logic.extensions.huarongroad.controller.HuarongRoadController", package.seeall)

local HuarongRoadController = class("HuarongRoadController", BaseController)

HuarongRoadController.PM_HuarongRoadGetInfoRes = "HuarongRoadController.PM_HuarongRoadGetInfoRes"
HuarongRoadController.PM_HuarongRoadPassRes = "HuarongRoadController.PM_HuarongRoadPassRes"
HuarongRoadController.PM_HuarongRoadIncreaseSecondRes = "HuarongRoadController.PM_HuarongRoadIncreaseSecondRes"
HuarongRoadController.PM_HuarongRoadBuyQuickPassRes = "HuarongRoadController.PM_HuarongRoadBuyQuickPassRes"

function HuarongRoadController:onInit()
	HuarongRoadController.super.onInit(self)
	GlobalDispatcher:addListener(HuarongRoadAgent.PM_HuarongRoadGetInfoRes, self._PM_HuarongRoadGetInfoRes, self)
	GlobalDispatcher:addListener(HuarongRoadAgent.PM_HuarongRoadPassRes, self._PM_HuarongRoadPassRes, self)
	GlobalDispatcher:addListener(HuarongRoadAgent.PM_HuarongRoadIncreaseSecondRes, self._PM_HuarongRoadIncreaseSecondRes, self)
	GlobalDispatcher:addListener(HuarongRoadAgent.PM_HuarongRoadBuyQuickPassRes, self._PM_HuarongRoadBuyQuickPassRes, self)
	self:onReset()
end

function HuarongRoadController:onReset()
	HuarongRoadController.super.onReset(self)
end

function HuarongRoadController:_PM_HuarongRoadGetInfoRes(status, msg)
	if status == 0 then
		local info = {}

		info.activityId = msg.activityId
		info.playCount = msg.playCount
		info.IncrTimeBuyCount = msg.IncrTimeBuyCount
		info.passStageIds = msg.passStageIds
		info.allPass = msg.allPass

		HuarongRoadModel.instance:setData(info)
		GlobalDispatcher:dispatch(HuarongRoadController.PM_HuarongRoadGetInfoRes)
	end
end

function HuarongRoadController:_PM_HuarongRoadPassRes(status, msg)
	if status == 0 then
		local info = {}

		info.activityId = msg.activityId
		info.playCount = msg.playCount
		info.IncrTimeBuyCount = msg.IncrTimeBuyCount
		info.passStageIds = msg.passStageIds
		info.allPass = msg.allPass

		HuarongRoadModel.instance:setData(info)
		GlobalDispatcher:dispatch(HuarongRoadController.PM_HuarongRoadPassRes)
	end
end

function HuarongRoadController:_PM_HuarongRoadIncreaseSecondRes(status, msg)
	if status == 0 then
		local info = {}

		info.activityId = msg.activityId
		info.IncrTimeBuyCount = msg.IncrTimeBuyCount

		HuarongRoadModel.instance:setData(info)
		GlobalDispatcher:dispatch(HuarongRoadController.PM_HuarongRoadIncreaseSecondRes, status)
	end
end

function HuarongRoadController:_PM_HuarongRoadBuyQuickPassRes(status, msg)
	if status == 0 then
		local info = {}

		info.activityId = msg.activityId
		info.playCount = msg.playCount
		info.IncrTimeBuyCount = msg.IncrTimeBuyCount
		info.passStageIds = msg.passStageIds
		info.allPass = msg.allPass

		HuarongRoadModel.instance:setData(info)
		GlobalDispatcher:dispatch(HuarongRoadController.PM_HuarongRoadBuyQuickPassRes)
	end
end

HuarongRoadController.instance = HuarongRoadController.New()

return HuarongRoadController
