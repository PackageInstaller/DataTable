-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessdark/agent/EndlessDarkClgAgent.lua

module("logic.extensions.endlessdark.agent.EndlessDarkClgAgent", package.seeall)

local EndlessDarkClgAgent = class("EndlessDarkClgAgent", BaseAgent)

function EndlessDarkClgAgent:sendPM_EndlessDarkClgGetInfoReq(activityId)
	local req = EndlessDarkClgExtension_pb.PM_EndlessDarkClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EndlessDarkClgAgent:handlePM_EndlessDarkClgGetInfoRes(status, msg)
	if status == 0 then
		EndlessDarkClgController.instance:handlePM_EndlessDarkClgGetInfoRes(status, msg)
	end
end

function EndlessDarkClgAgent:sendPM_EndlessDarkClgStartFightReq(activityId, form)
	local req = EndlessDarkClgExtension_pb.PM_EndlessDarkClgStartFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function EndlessDarkClgAgent:handlePM_EndlessDarkClgStartFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function EndlessDarkClgAgent:sendPM_EndlessDarkClgContinueFightReq(activityId)
	local req = EndlessDarkClgExtension_pb.PM_EndlessDarkClgContinueFightReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EndlessDarkClgAgent:handlePM_EndlessDarkClgContinueFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function EndlessDarkClgAgent:handlePM_EndlessDarkClgNotifyFightRes(status, msg)
	if status == 0 then
		EndlessDarkClgController.instance:handlePM_EndlessDarkClgNotifyFightRes(status, msg)
	end
end

function EndlessDarkClgAgent:sendPM_EndlessDarkClgViewRankReq(activityId)
	local req = EndlessDarkClgExtension_pb.PM_EndlessDarkClgViewRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function EndlessDarkClgAgent:handlePM_EndlessDarkClgViewRankRes(status, msg)
	if status == 0 then
		EndlessDarkClgController.instance:handlePM_EndlessDarkClgViewRankRes(status, msg)
	end
end

function EndlessDarkClgAgent:sendPM_EndlessDarkClgUpgradeBuffReq(activityId, buffType)
	local req = EndlessDarkClgExtension_pb.PM_EndlessDarkClgUpgradeBuffReq()

	req.activityId = activityId
	req.buffType = buffType

	self:sendMsg(req)
end

function EndlessDarkClgAgent:handlePM_EndlessDarkClgUpgradeBuffRes(status, msg)
	if status == 0 then
		EndlessDarkClgController.instance:handlePM_EndlessDarkClgUpgradeBuffRes(status, msg)
	end
end

EndlessDarkClgAgent.instance = EndlessDarkClgAgent.New()

return EndlessDarkClgAgent
