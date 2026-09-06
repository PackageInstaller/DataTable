-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/agent/DivineDakinosClgAgent.lua

module("logic.extensions.divinedakinosclg.agent.DivineDakinosClgAgent", package.seeall)

local DivineDakinosClgAgent = class("DivineDakinosClgAgent", BaseAgent)

function DivineDakinosClgAgent:sendPM_DivineDakinosClgGetInfoReq(activityId)
	local req = DivineDakinosClgExtension_pb.PM_DivineDakinosClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDakinosClgAgent:handlePM_DivineDakinosClgGetInfoRes(status, msg)
	if status == 0 then
		DivineDakinosClgController.instance:handlePM_DivineDakinosClgGetInfoRes(msg)
	end
end

function DivineDakinosClgAgent:sendPM_DivineDakinosClgFightReq(activityId, phaseId, stageId, form)
	local req = DivineDakinosClgExtension_pb.PM_DivineDakinosClgFightReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineDakinosClgAgent:handlePM_DivineDakinosClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineDakinosClgAgent:handlePM_DivineDakinosClgNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineDakinosClgController.instance:handlePM_DivineDakinosClgNotifyFightResultRes(msg)
	end
end

DivineDakinosClgAgent.instance = DivineDakinosClgAgent.New()

return DivineDakinosClgAgent
