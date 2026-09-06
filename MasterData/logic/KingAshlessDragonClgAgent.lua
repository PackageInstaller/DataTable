-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/agent/KingAshlessDragonClgAgent.lua

module("logic.extensions.kingashlessdragonclg.agent.KingAshlessDragonClgAgent", package.seeall)

local KingAshlessDragonClgAgent = class("KingAshlessDragonClgAgent", BaseAgent)

function KingAshlessDragonClgAgent:sendPM_KingAshlessDragonClgGetInfoReq(activityId)
	local req = KingAshlessDragonClgExtension_pb.PM_KingAshlessDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingAshlessDragonClgAgent:handlePM_KingAshlessDragonClgGetInfoRes(status, msg)
	if status == 0 then
		KingWujinlongController.instance:onGetInfo(msg)
	end
end

function KingAshlessDragonClgAgent:sendPM_KingAshlessDragonClgChallengeReq(activityId, form_pb)
	local req = KingAshlessDragonClgExtension_pb.PM_KingAshlessDragonClgChallengeReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function KingAshlessDragonClgAgent:handlePM_KingAshlessDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function KingAshlessDragonClgAgent:sendPM_KingAshlessDragonClgConfirmReq(activityId, confirmNum, save)
	local req = KingAshlessDragonClgExtension_pb.PM_KingAshlessDragonClgConfirmReq()

	req.activityId = activityId
	req.confirmNum = confirmNum
	req.save = save

	self:sendMsg(req)
end

function KingAshlessDragonClgAgent:handlePM_KingAshlessDragonClgConfirmRes(status, msg)
	if status == 0 then
		KingWujinlongController.instance:onGetConfirm(msg)
	end
end

function KingAshlessDragonClgAgent:sendPM_KingAshlessDragonClgResetReq(activityId)
	local req = KingAshlessDragonClgExtension_pb.PM_KingAshlessDragonClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingAshlessDragonClgAgent:handlePM_KingAshlessDragonClgResetRes(status, msg)
	if status == 0 then
		KingWujinlongController.instance:onGetReset(msg)
	end
end

function KingAshlessDragonClgAgent:handlePM_NotifyKingAshlessDragonClgEndRes(status, msg)
	if status == 0 then
		KingWujinlongController.instance:handleFightRes(msg)
	end
end

KingAshlessDragonClgAgent.instance = KingAshlessDragonClgAgent.New()

return KingAshlessDragonClgAgent
