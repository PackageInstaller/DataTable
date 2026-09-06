-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/agent/ScriptKillingAgent.lua

module("logic.extensions.scriptkilling.agent.ScriptKillingAgent", package.seeall)

local ScriptKillingAgent = class("ScriptKillingAgent", BaseAgent)

function ScriptKillingAgent:ctor()
	return
end

function ScriptKillingAgent:setExtId(extId)
	ScriptKillingAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ScriptKillingAgent:sendPM_ScriptKillingInfoReq(activityId)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingInfoRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onGetInfo(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingGainClueReq(activityId, clueId)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingGainClueReq()

	req.activityId = activityId
	req.clueId = clueId

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingGainClueRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onGetGlue(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingUseActionPointReq(activityId, num)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingUseActionPointReq()

	req.activityId = activityId
	req.num = num

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingUseActionPointRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onUseActionPoint(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingFormulaReq(activityId, clueIds_i32_Ary)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingFormulaReq()

	req.activityId = activityId

	for i, v1 in ipairs(clueIds_i32_Ary) do
		req.clueIds:append(v1)
	end

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingFormulaRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onGetFormula(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingSuspectReq(activityId, chapterId, selectKiller)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingSuspectReq()

	req.activityId = activityId
	req.chapterId = chapterId
	req.selectKiller = selectKiller

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingSuspectRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onSuspect(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingGainPrizeReq(activityId)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingGainPrizeRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onGetPrize(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingRankReq(activityId)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingRankRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onGetRankInfo(msg)
	end
end

function ScriptKillingAgent:sendPM_ScriptKillingGainStagingClueReq(activityId, success)
	local req = ScriptKillingExtension_pb.PM_ScriptKillingGainStagingClueReq()

	req.activityId = activityId
	req.success = success

	self:sendMsg(req)
end

function ScriptKillingAgent:handlePM_ScriptKillingGainStagingClueRes(status, msg)
	if status == 0 then
		ScriptKillController.instance:onGetTalkGlue(msg)
	end
end

ScriptKillingAgent.instance = ScriptKillingAgent.New()

return ScriptKillingAgent
