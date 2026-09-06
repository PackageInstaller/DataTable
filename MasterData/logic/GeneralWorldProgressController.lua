-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/controller/GeneralWorldProgressController.lua

module("logic.extensions.generalworldprogress.controller.GeneralWorldProgressController", package.seeall)

local GeneralWorldProgressController = class("GeneralWorldProgressController", BaseController)

function GeneralWorldProgressController:ctor()
	return
end

function GeneralWorldProgressController:getInfo(actId)
	GeneralWorldProgressAgent.instance:sendPM_GeneralWorldProgressGetInfoReq(actId)
end

function GeneralWorldProgressController:handleGetInfo(msg)
	GeneralWorldProgressModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GeneralWorldProgressGetInfo)
end

function GeneralWorldProgressController:gainPrize(actId, prizeId, oneKeyGain)
	GeneralWorldProgressAgent.instance:sendPM_GeneralWorldProgressGainReq(actId, prizeId, oneKeyGain)
end

function GeneralWorldProgressController:handleGainPrize(msg)
	GeneralWorldProgressModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GeneralWorldProgressGainPrize)
end

GeneralWorldProgressController.instance = GeneralWorldProgressController.New()

return GeneralWorldProgressController
