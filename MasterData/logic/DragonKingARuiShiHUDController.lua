-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/controller/DragonKingARuiShiHUDController.lua

module("logic.extensions.dragonkingaruishihud.controller.DragonKingARuiShiHUDController", package.seeall)

local DragonKingARuiShiHUDController = class("DragonKingARuiShiHUDController", BaseController)

function DragonKingARuiShiHUDController:onReset()
	return
end

function DragonKingARuiShiHUDController:getInfo(activityId)
	DragonKingARuiShiHUDAgent.instance:sendDragonKingARuiShiHUDInfoReq(activityId)
end

function DragonKingARuiShiHUDController:handleGetInfo(msg)
	DragonKingARuiShiHUDModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingARuiShiHUDUpdateInfo)
end

function DragonKingARuiShiHUDController:gainPrize(activityId)
	DragonKingARuiShiHUDAgent.instance:sendDragonKingARuiShiHUDGainPrizeReq(activityId)
end

function DragonKingARuiShiHUDController:handleGainPrize(msg)
	DragonKingARuiShiHUDModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingARuiShiHUDUpdateInfo)
end

DragonKingARuiShiHUDController.instance = DragonKingARuiShiHUDController.New()

return DragonKingARuiShiHUDController
