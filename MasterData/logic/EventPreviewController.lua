-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/controller/EventPreviewController.lua

module("logic.extensions.eventpreview.controller.EventPreviewController", package.seeall)

local EventPreviewController = class("EventPreviewController", BaseController)

function EventPreviewController:ctor()
	return
end

function EventPreviewController:onInit()
	self:onReset()
end

function EventPreviewController:onReset()
	return
end

function EventPreviewController:sendPM_UpcomingActivityGetInfoReq(actId)
	UpcomingActivityAgent.instance:sendPM_UpcomingActivityGetInfoReq(actId)
end

function EventPreviewController:sendPM_UpcomingActivityLikeReq(actId, id)
	UpcomingActivityAgent.instance:sendPM_UpcomingActivityLikeReq(actId, id)
end

function EventPreviewController:sendPM_UpcomingActivityGainPrizeReq(actId, id)
	UpcomingActivityAgent.instance:sendPM_UpcomingActivityGainPrizeReq(actId, id)
end

function EventPreviewController:getUnlockInfo(actId)
	UpcomingActivityAgent.instance:sendPM_UpcomingUnlockInfoReq(actId)
end

function EventPreviewController:handleGetUnlockInfo(msg)
	EventPreviewModel.instance:onGetUnlockInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivityGetUnlockInfo)
end

function EventPreviewController:sendUnlock(actId, id)
	UpcomingActivityAgent.instance:sendPM_UpcomingUnlockReq(actId, id)
end

function EventPreviewController:handleSendUnlock(msg)
	EventPreviewModel.instance:onSendUnlock(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivitySendUnlock)
end

function EventPreviewController:gainPersonPrize(actId)
	UpcomingActivityAgent.instance:sendPM_UpcomingGainUnlockPersonPrizeReq(actId)
end

function EventPreviewController:handleGainPersonPrize(msg)
	EventPreviewModel.instance:onGainPersonPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivityGainPersonPrize)
end

function EventPreviewController:gainWorldPrize(actId)
	UpcomingActivityAgent.instance:sendPM_UpcomingGainUnlockWorldPrizeReq(actId)
end

function EventPreviewController:handleWorldPersonPrize(msg)
	EventPreviewModel.instance:onGainWorldPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivityGainWorldPrize)
end

EventPreviewController.instance = EventPreviewController.New()

return EventPreviewController
