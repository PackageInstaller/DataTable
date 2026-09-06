-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crossword/controller/CrossWrodController.lua

module("logic.extensions.crossword.controller.CrossWrodController", package.seeall)

local CrossWrodController = class("CrossWrodController", BaseController)

function CrossWrodController:onInit()
	self:onReset()
end

function CrossWrodController:onReset()
	return
end

function CrossWrodController:sendGetInfo(activityId)
	GuessPuzzleAgent.instance:sendPM_GuessPuzzleGetInfoReq(activityId)
end

function CrossWrodController:onGetInfo(msg)
	CrossWordModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CROSSWROD_INFO_UPDATE)
end

function CrossWrodController:sendFinishGrid(activityId, gridId)
	GuessPuzzleAgent.instance:sendPM_GuessPuzzleFinishGridReq(activityId, gridId)
end

function CrossWrodController:onFinishGrid(msg)
	CrossWordModel.instance:onFinishGrid(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CROSSWROD_INFO_UPDATE)
end

function CrossWrodController:sendGainPrize(activityId, prizeId)
	GuessPuzzleAgent.instance:sendPM_GuessPuzzleGainPrizeReq(activityId, prizeId)
end

function CrossWrodController:onGainPrize(msg)
	CrossWordModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.CROSSWROD_INFO_UPDATE)
end

CrossWrodController.instance = CrossWrodController.New()

return CrossWrodController
