-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/controller/ColorfulLanternController.lua

module("logic.extensions.colorfullantern.controller.ColorfulLanternController", package.seeall)

local ColorfulLanternController = class("ColorfulLanternController", BaseController)

ColorfulLanternController.PM_ColorfulLanternGetInfoRes = "ColorfulLanternController.PM_ColorfulLanternGetInfoRes"
ColorfulLanternController.PM_ColorfulLanternActivateRes = "ColorfulLanternController.PM_ColorfulLanternActivateRes"

function ColorfulLanternController:ctor()
	return
end

function ColorfulLanternController:onInit()
	GlobalDispatcher:addListener(ColorfulLanternAgent.PM_ColorfulLanternGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(ColorfulLanternAgent.PM_ColorfulLanternActivateRes, self._onActivateRes, self)
end

function ColorfulLanternController:onReset()
	return
end

function ColorfulLanternController:_onGetInfoRes(status, msg)
	ColorfulLanternModel.instance:setData(msg)
	GlobalDispatcher:dispatch(ColorfulLanternController.PM_ColorfulLanternGetInfoRes)
end

function ColorfulLanternController:_onActivateRes(status, msg)
	GlobalDispatcher:dispatch(ColorfulLanternController.PM_ColorfulLanternActivateRes)
end

ColorfulLanternController.instance = ColorfulLanternController.New()

return ColorfulLanternController
