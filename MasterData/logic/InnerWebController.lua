-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerweb/controller/InnerWebController.lua

module("logic.extensions.innerweb.controller.InnerWebController", package.seeall)

local InnerWebController = class("InnerWebController", BaseController)

function InnerWebController:ctor()
	InnerWebController.super.ctor(self)
end

function InnerWebController:onInit()
	self:onReset()
end

function InnerWebController:onReset()
	return
end

function InnerWebController:openWebView(url)
	local viewName = ViewName.InnerWebView

	UIStateManager.instance:popByName(viewName)
	UIStateManager.instance:open(viewName, url)
end

function InnerWebController:closeWebView()
	local viewName = ViewName.InnerWebView

	UIStateManager.instance:popByName(viewName)
end

InnerWebController.instance = InnerWebController.New()

return InnerWebController
