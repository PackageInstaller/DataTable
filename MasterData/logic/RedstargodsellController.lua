-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redstargodsell/controller/RedstargodsellController.lua

module("logic.extensions.redstargodsell.controller.RedstargodsellController", package.seeall)

local RedstargodsellController = class("RedstargodsellController", BaseController)

function RedstargodsellController:ctor()
	RedstargodsellController.super.ctor(self)
end

function RedstargodsellController:onInit()
	self:onReset()
end

function RedstargodsellController:onReset()
	self._tempActId = nil
end

function RedstargodsellController:getInfo(actId)
	self._tempActId = actId

	MonopolySaleAgent.instance:sendPM_GetMonopolySaleGiftInfoReq(actId)
end

function RedstargodsellController:handleInfo(msg)
	local infos = msg.infos

	for k, v in ipairs(infos) do
		RedstargodsellModel.instance:setGift(self._tempActId, v.giftId, v)
	end

	self._tempActId = nil

	GlobalDispatcher:dispatch(GlobalNotify.RedstargodsellGetInfo)
end

function RedstargodsellController:handleNotifyBuyGift(msg)
	local info = msg.info

	RedstargodsellModel.instance:setGift(msg.activityId, info.giftId, info)
	GlobalDispatcher:dispatch(GlobalNotify.RedstargodsellBuyGift)
end

RedstargodsellController.instance = RedstargodsellController.New()

return RedstargodsellController
