-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/controller/FameHallController.lua

module("logic.extensions.famehall.controller.FameHallController", package.seeall)

local FameHallController = class("FameHallController", BaseController)

function FameHallController:ctor()
	return
end

function FameHallController:onInit()
	return
end

function FameHallController:onReset()
	return
end

function FameHallController:handlePM_FameHallGetInfoRes(msg)
	FameHallModel.instance:saveInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_FameHallGetInfoRes)
end

FameHallController.instance = FameHallController.New()

return FameHallController
