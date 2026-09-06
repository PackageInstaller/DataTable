-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/agent/OriginInfiniteFutureClgAgent.lua

module("logic.extensions.origininfinitefutureclg.agent.OriginInfiniteFutureClgAgent", package.seeall)

local OriginInfiniteFutureClgAgent = class("OriginInfiniteFutureClgAgent", BaseAgent)

function OriginInfiniteFutureClgAgent:sendPM_OriginInfiniteFutureClgGetInfoReq(activityId)
	local req = OriginInfiniteFutureClgExtension_pb.PM_OriginInfiniteFutureClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginInfiniteFutureClgAgent:handlePM_OriginInfiniteFutureClgGetInfoRes(status, msg)
	if status == 0 then
		OriginInfiniteFutureClgController.instance:handlePM_OriginInfiniteFutureClgGetInfoRes(msg)
	end
end

function OriginInfiniteFutureClgAgent:sendPM_OriginInfiniteFutureClgFightReq(activityId, stageId, form)
	local req = OriginInfiniteFutureClgExtension_pb.PM_OriginInfiniteFutureClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginInfiniteFutureClgAgent:handlePM_OriginInfiniteFutureClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginInfiniteFutureClgAgent:sendPM_OriginInfiniteFutureClgResetReq(activityId, stageId)
	local req = OriginInfiniteFutureClgExtension_pb.PM_OriginInfiniteFutureClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginInfiniteFutureClgAgent:handlePM_OriginInfiniteFutureClgResetRes(status, msg)
	if status == 0 then
		OriginInfiniteFutureClgController.instance:handlePM_OriginInfiniteFutureClgResetRes(msg)
	end
end

function OriginInfiniteFutureClgAgent:handlePM_OriginInfiniteFutureClgNotifyFightRes(status, msg)
	if status == 0 then
		OriginInfiniteFutureClgController.instance:handlePM_OriginInfiniteFutureClgNotifyFightRes(msg)
	end
end

OriginInfiniteFutureClgAgent.instance = OriginInfiniteFutureClgAgent.New()

return OriginInfiniteFutureClgAgent
