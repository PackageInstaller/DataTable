-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/controller/WheelFortuneController.lua

module("logic.extensions.wheelfortune.controller.WheelFortuneController", package.seeall)

local WheelFortuneController = class("WheelFortuneController", BaseController)

function WheelFortuneController:ctor()
	return
end

function WheelFortuneController:onInit()
	GlobalDispatcher:addListener(WheelFortuneAgent.handlePM_WheelFortuneInfoRes, self.handlePM_WheelFortuneInfoRes, self)
	GlobalDispatcher:addListener(WheelFortuneAgent.handlePM_WheelFortuneDrawRes, self.handlePM_WheelFortuneDrawRes, self)
	GlobalDispatcher:addListener(WheelFortuneAgent.handlePM_WheelFortuneRecordsRes, self.handlePM_WheelFortuneRecordsRes, self)
	self:onReset()
end

function WheelFortuneController:onReset()
	self._tempIds = {}
	self._tempIndex = 11
	self._temporderID = 1
end

function WheelFortuneController:handlePM_WheelFortuneInfoRes(msg)
	WheelFortuneModel.instance:setDrawInfos(msg.orderId, msg.hasDrawIds)
	GlobalDispatcher:dispatch(GlobalNotify.WheelFortuneInfoRes)
end

function WheelFortuneController:handlePM_WheelFortuneDrawRes(msg)
	WheelFortuneModel.instance:setChangeSetId(msg.changeSetId)
	WheelFortuneModel.instance:drawSuccessed(msg.rewardId, msg.nextOrderId)
	GlobalDispatcher:dispatch(GlobalNotify.WheelFortuneDrawRes)
end

function WheelFortuneController:handlePM_WheelFortuneRecordsRes(msg)
	WheelFortuneModel.instance:setFortunePlayerInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.WheelFortuneRecordsRes)
end

WheelFortuneController.instance = WheelFortuneController.New()

return WheelFortuneController
