-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/horselantern/controller/HorseLanternController.lua

module("logic.extensions.horselantern.controller.HorseLanternController", package.seeall)

local HorseLanternController = class("HorseLanternController", BaseController)

function HorseLanternController:onInit()
	return
end

HorseLanternController.instance = HorseLanternController.New()

return HorseLanternController
