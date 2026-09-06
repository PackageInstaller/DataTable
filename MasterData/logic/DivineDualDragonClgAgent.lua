-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedualdragonclg/agent/DivineDualDragonClgAgent.lua

module("logic.extensions.divinedualdragonclg.agent.DivineDualDragonClgAgent", package.seeall)

local DivineDualDragonClgAgent = class("DivineDualDragonClgAgent", BaseAgent)

function DivineDualDragonClgAgent:sendPM_DivineDualDragonClgGetInfoReq(activityId)
	local req = DivineDualDragonClgExtension_pb.PM_DivineDualDragonClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDualDragonClgAgent:handlePM_DivineDualDragonClgGetInfoRes(status, msg)
	if status == 0 then
		DivineDualDragonClgController.instance:handlePM_DivineDualDragonClgGetInfoRes(msg)
	end
end

function DivineDualDragonClgAgent:sendPM_DivineDualDragonClgChallengeReq(activityId, phaseId, stageId, form)
	local req = DivineDualDragonClgExtension_pb.PM_DivineDualDragonClgChallengeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineDualDragonClgAgent:handlePM_DivineDualDragonClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineDualDragonClgAgent:handlePM_Notify_DivineDualDragonClgChallengeRes(status, msg)
	if status == 0 then
		DivineDualDragonClgController.instance:handlePM_Notify_DivineDualDragonClgChallengeRes(msg)
	end
end

DivineDualDragonClgAgent.instance = DivineDualDragonClgAgent.New()

return DivineDualDragonClgAgent
