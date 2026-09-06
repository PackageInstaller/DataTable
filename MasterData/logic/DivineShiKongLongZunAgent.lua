-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineshikonglongzunmainview/agent/DivineShiKongLongZunAgent.lua

module("logic.extensions.divineshikonglongzunmainview.agent.DivineShiKongLongZunAgent", package.seeall)

local DivineShiKongLongZunAgent = class("DivineShiKongLongZunAgent", BaseAgent)

function DivineShiKongLongZunAgent:sendPM_DivineTSDragonLordClgGetInfoReq(activityId)
	local req = DivineTSDragonLordClgExtension_pb.PM_DivineTSDragonLordClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineShiKongLongZunAgent:handlePM_DivineTSDragonLordClgGetInfoRes(status, msg)
	if status == 0 then
		DivineShiKongLongZunController.instance:handlePM_DivineTSDragonLordClgGetInfoRes(msg)
	end
end

function DivineShiKongLongZunAgent:sendPM_DivineTSDragonLordClgChallengeReq(activityId, stageId, teamIndex, form)
	local req = DivineTSDragonLordClgExtension_pb.PM_DivineTSDragonLordClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamIndex = teamIndex

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineShiKongLongZunAgent:handlePM_DivineTSDragonLordClgChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineShiKongLongZunAgent:sendPM_DivineTSDragonLordClgConfirmScoreReq(activityId, stageId, teamIndex, replace)
	local req = DivineTSDragonLordClgExtension_pb.PM_DivineTSDragonLordClgConfirmScoreReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamIndex = teamIndex
	req.replace = replace

	self:sendMsg(req)
end

function DivineShiKongLongZunAgent:handlePM_DivineTSDragonLordClgConfirmScoreRes(status, msg)
	DivineShiKongLongZunController.instance:handlePM_DivineTSDragonLordClgConfirmScoreRes(status, msg)
end

function DivineShiKongLongZunAgent:handlePM_Notify_DivineTSDragonLordClgChallengeEndRes(status, msg)
	if status == 0 then
		DivineShiKongLongZunController.instance:handlePM_Notify_DivineTSDragonLordClgChallengeEndRes(msg)
	end
end

DivineShiKongLongZunAgent.instance = DivineShiKongLongZunAgent.New()

return DivineShiKongLongZunAgent
