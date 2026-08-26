-- chunkname: @modules/logic/sdk/controller/SDKController.lua

module("modules.logic.sdk.controller.SDKController", package.seeall)

local SDKController = class("SDKController", BaseController)

function SDKController:onInit()
	return
end

function SDKController:reInit()
	return
end

function SDKController:addConstEvents()
	return
end

function SDKController:openSDKExitView(loginCallback, exitCallback)
	local param = {}

	param.loginCallback = loginCallback
	param.exitCallback = exitCallback

	ViewMgr.instance:openView(ViewName.SDKExitGameView, param)
end

SDKController.instance = SDKController.New()

return SDKController
