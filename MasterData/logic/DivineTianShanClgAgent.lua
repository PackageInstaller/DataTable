-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetianshanclg/agent/DivineTianShanClgAgent.lua

module("logic.extensions.divinetianshanclg.agent.DivineTianShanClgAgent", package.seeall)

local DivineTianShanClgAgent = class("DivineTianShanClgAgent", BaseAgent)

function DivineTianShanClgAgent:sendPM_DivineTianShanClgGetInfoReq(activityId)
	local req = DivineTianShanClgExtension_pb.PM_DivineTianShanClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgGetInfoRes(status, msg)
	if status == 0 then
		DivineTianShanClgController.instance:handleGetInfo(msg)
	end
end

function DivineTianShanClgAgent:sendPM_DivineTianShanClgExtremeFightReq(activityId, stageId, form_pb)
	local req = DivineTianShanClgExtension_pb.PM_DivineTianShanClgExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineTianShanClgAgent:sendPM_DivineTianShanClgResetExtremeStageReq(activityId, stageId)
	local req = DivineTianShanClgExtension_pb.PM_DivineTianShanClgResetExtremeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgResetExtremeStageRes(status, msg)
	if status == 0 then
		DivineTianShanClgController.instance:handleResetExtremeFight(msg)
	end
end

function DivineTianShanClgAgent:sendPM_DivineTianShanClgNormalFightReq(activityId, stageId, isPractice, form_pb)
	local req = DivineTianShanClgExtension_pb.PM_DivineTianShanClgNormalFightReq()

	req.activityId = activityId
	req.stageId = stageId
	req.isPractice = isPractice

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineTianShanClgAgent:sendPM_DivineTianShanClgGainPrizeReq(activityId, prizeId)
	local req = DivineTianShanClgExtension_pb.PM_DivineTianShanClgGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgGainPrizeRes(status, msg)
	if status == 0 then
		DivineTianShanClgController.instance:handleGainNormalPrize(msg)
	end
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgExtremeFightNotifyRes(status, msg)
	if status == 0 then
		DivineTianShanClgController.instance:handleNotifyExtremeFight(msg)
	end
end

function DivineTianShanClgAgent:handlePM_DivineTianShanClgNormalFightNotifyRes(status, msg)
	if status == 0 then
		DivineTianShanClgController.instance:handleNotifyNormalFight(msg)
	end
end

DivineTianShanClgAgent.instance = DivineTianShanClgAgent.New()

return DivineTianShanClgAgent
