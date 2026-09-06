-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunuotongxing/controller/YuNuoTongXingController.lua

module("logic.extensions.yunuotongxing.controller.YuNuoTongXingController", package.seeall)

local YuNuoTongXingController = class("YuNuoTongXingController", BaseController)

function YuNuoTongXingController:onInit()
	self:onReset()
end

function YuNuoTongXingController:onReset()
	return
end

function YuNuoTongXingController:getActivityId()
	return 425002
end

function YuNuoTongXingController:sendGetInfo(activityId)
	WalkWithNoahAgent.instance:sendPM_WalkWithNoahGetInfoReq(activityId)
end

function YuNuoTongXingController:onGetInfo(msg)
	YuNuoTongXingModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YUNUOTONGXING_INFO_UPDATE)
end

function YuNuoTongXingController:sendSetPiece(activityId, pieceId)
	WalkWithNoahAgent.instance:sendPM_WalkWithNoahPlacePieceReq(activityId, pieceId)
end

function YuNuoTongXingController:onSetPiece(msg)
	YuNuoTongXingModel.instance:onSetPiece(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YUNUOTONGXING_INFO_UPDATE)
end

function YuNuoTongXingController:sendGetPrize(activityId, prizeId)
	WalkWithNoahAgent.instance:sendPM_WalkWithNoahGainPrizeReq(activityId, prizeId)
end

function YuNuoTongXingController:onGetPrize(msg)
	YuNuoTongXingModel.instance:onGetPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.YUNUOTONGXING_INFO_UPDATE)
end

YuNuoTongXingController.instance = YuNuoTongXingController.New()

return YuNuoTongXingController
