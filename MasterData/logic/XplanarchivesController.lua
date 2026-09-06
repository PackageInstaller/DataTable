-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xplanarchives/controller/XplanarchivesController.lua

module("logic.extensions.xplanarchives.controller.XplanarchivesController", package.seeall)

local XplanarchivesController = class("XplanarchivesController", BaseController)

function XplanarchivesController:ctor()
	return
end

function XplanarchivesController:onInit()
	self:onReset()
end

function XplanarchivesController:onReset()
	return
end

function XplanarchivesController:_updateRedpoint()
	local isActivated = false

	RedPointController.instance:setRedPointInfo(-412, isActivated)
end

XplanarchivesController.instance = XplanarchivesController.New()

return XplanarchivesController
