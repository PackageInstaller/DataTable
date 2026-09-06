-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holidaygift/agent/HolidayGiftAgent.lua

module("logic.extensions.holidaygift.agent.HolidayGiftAgent", package.seeall)

local HolidayGiftAgent = class("HolidayGiftAgent", BaseAgent)

function HolidayGiftAgent:sendPM_HolidayGiftGetInfoReq(activityId)
	local req = HolidayGiftExtension_pb.PM_HolidayGiftGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HolidayGiftAgent:handlePM_HolidayGiftGetInfoRes(status, msg)
	HolidayGiftController.instance:handleGetInfoRes(status, msg)
end

function HolidayGiftAgent:sendPM_HolidayGiftGainPrizeReq(activityId, giftId)
	local req = HolidayGiftExtension_pb.PM_HolidayGiftGainPrizeReq()

	req.activityId = activityId
	req.giftId = giftId

	self:sendMsg(req)
end

function HolidayGiftAgent:handlePM_HolidayGiftGainPrizeRes(status, msg)
	HolidayGiftController.instance:handleGainPrizeRes(status, msg)
end

HolidayGiftAgent.instance = HolidayGiftAgent.New()

return HolidayGiftAgent
