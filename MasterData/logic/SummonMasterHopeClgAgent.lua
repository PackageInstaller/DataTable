-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/agent/SummonMasterHopeClgAgent.lua

module("logic.extensions.summonmasterhopeclg.agent.SummonMasterHopeClgAgent", package.seeall)

local SummonMasterHopeClgAgent = class("SummonMasterHopeClgAgent", BaseAgent)

function SummonMasterHopeClgAgent:sendPM_SummonMasterHopeClgGetInfoReq(activityId)
	local req = SummonMasterHopeClgExtension_pb.PM_SummonMasterHopeClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterHopeClgAgent:handlePM_SummonMasterHopeClgGetInfoRes(status, msg)
	if status == 0 then
		SummonMasterHopeClgController.instance:handlePM_SummonMasterHopeClgGetInfoRes(msg)
	end
end

function SummonMasterHopeClgAgent:sendPM_SummonMasterHopeClgFightReq(activityId, stageId, form)
	local req = SummonMasterHopeClgExtension_pb.PM_SummonMasterHopeClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function SummonMasterHopeClgAgent:handlePM_SummonMasterHopeClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SummonMasterHopeClgAgent:handlePM_SummonMasterHopeClgNotifyFightResultRes(status, msg)
	if status == 0 then
		SummonMasterHopeClgController.instance:handlePM_SummonMasterHopeClgNotifyFightResultRes(msg)
	end
end

function SummonMasterHopeClgAgent:sendPM_SummonMasterHopeClgGetGodRankReq(activityId)
	local req = SummonMasterHopeClgExtension_pb.PM_SummonMasterHopeClgGetGodRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterHopeClgAgent:handlePM_SummonMasterHopeClgGetGodRankRes(status, msg)
	if status == 0 then
		SummonMasterHopeClgController.instance:handlePM_SummonMasterHopeClgGetGodRankRes(msg)
	end
end

function SummonMasterHopeClgAgent:sendPM_SummonMasterHopeClgGetDailyRankReq(activityId)
	local req = SummonMasterHopeClgExtension_pb.PM_SummonMasterHopeClgGetDailyRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SummonMasterHopeClgAgent:handlePM_SummonMasterHopeClgGetDailyRankRes(status, msg)
	if status == 0 then
		SummonMasterHopeClgController.instance:handlePM_SummonMasterHopeClgGetDailyRankRes(msg)
	end
end

SummonMasterHopeClgAgent.instance = SummonMasterHopeClgAgent.New()

return SummonMasterHopeClgAgent
