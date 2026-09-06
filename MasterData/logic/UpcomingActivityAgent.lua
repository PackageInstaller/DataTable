-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventpreview/agent/UpcomingActivityAgent.lua

module("logic.extensions.upcomingactivity.agent.UpcomingActivityAgent", package.seeall)

local UpcomingActivityAgent = class("UpcomingActivityAgent", BaseAgent)

function UpcomingActivityAgent:sendPM_UpcomingActivityGetInfoReq(actId)
	local req = UpcomingActivityExtension_pb.PM_UpcomingActivityGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingActivityGetInfoRes(status, msg)
	if status == 0 then
		EventPreviewModel.instance:setAllInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivity)
	end
end

function UpcomingActivityAgent:sendPM_UpcomingActivityLikeReq(actId, id)
	local req = UpcomingActivityExtension_pb.PM_UpcomingActivityLikeReq()

	req.actId = actId
	req.id = id

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingActivityLikeRes(status, msg)
	if status == 0 then
		local infos = msg.infos

		EventPreviewModel.instance:setUpcomingInfo(infos)
		GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivity)
		GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivityLike)
	end
end

function UpcomingActivityAgent:sendPM_UpcomingActivityGainPrizeReq(actId, id)
	local req = UpcomingActivityExtension_pb.PM_UpcomingActivityGainPrizeReq()

	req.actId = actId
	req.id = id

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingActivityGainPrizeRes(status, msg)
	if status == 0 then
		EventPreviewModel.instance:setGainProgressPrize(msg)
		GlobalDispatcher:dispatch(GlobalNotify.UpcomingActivity)
	end
end

function UpcomingActivityAgent:sendPM_UpcomingUnlockInfoReq(actId)
	local req = UpcomingActivityExtension_pb.PM_UpcomingUnlockInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingUnlockInfoRes(status, msg)
	if status == 0 then
		EventPreviewController.instance:handleGetUnlockInfo(msg)
	end
end

function UpcomingActivityAgent:sendPM_UpcomingUnlockReq(actId, id)
	local req = UpcomingActivityExtension_pb.PM_UpcomingUnlockReq()

	req.actId = actId
	req.id = id

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingUnlockRes(status, msg)
	if status == 0 then
		EventPreviewController.instance:handleSendUnlock(msg)
	end
end

function UpcomingActivityAgent:sendPM_UpcomingGainUnlockPersonPrizeReq(actId)
	local req = UpcomingActivityExtension_pb.PM_UpcomingGainUnlockPersonPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingGainUnlockPersonPrizeRes(status, msg)
	if status == 0 then
		EventPreviewController.instance:handleGainPersonPrize(msg)
	end
end

function UpcomingActivityAgent:sendPM_UpcomingGainUnlockWorldPrizeReq(actId)
	local req = UpcomingActivityExtension_pb.PM_UpcomingGainUnlockWorldPrizeReq()

	req.actId = actId

	self:sendMsg(req)
end

function UpcomingActivityAgent:handlePM_UpcomingGainUnlockWorldPrizeRes(status, msg)
	if status == 0 then
		EventPreviewController.instance:handleWorldPersonPrize(msg)
	end
end

UpcomingActivityAgent.instance = UpcomingActivityAgent.New()

return UpcomingActivityAgent
