-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/agent/DivineFuYaoClgAgent.lua

module("logic.extensions.divinefuyaoclg.agent.DivineFuYaoClgAgent", package.seeall)

local DivineFuYaoClgAgent = class("DivineFuYaoClgAgent", BaseAgent)

function DivineFuYaoClgAgent:sendPM_DivineFuYaoClgInfoReq(activityId)
	local req = DivineFuYaoClgExtension_pb.PM_DivineFuYaoClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineFuYaoClgAgent:handlePM_DivineFuYaoClgInfoRes(status, msg)
	if status == 0 then
		DivineFuYaoClgController.instance:handlePM_DivineFuYaoClgInfoRes(msg)
	end
end

function DivineFuYaoClgAgent:sendPM_DivineFuYaoClgNormalChallengeReq(activityId, stageId, form)
	local req = DivineFuYaoClgExtension_pb.PM_DivineFuYaoClgNormalChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineFuYaoClgAgent:handlePM_DivineFuYaoClgNormalChallengeRes(status, msg)
	if status == 0 then
		DivineFuYaoClgController.instance:handlePM_DivineFuYaoClgNormalChallengeRes(msg)
	end
end

function DivineFuYaoClgAgent:handlePM_NotifyFuYaoClgNormalChallengeFinishRes(status, msg)
	if status == 0 then
		DivineFuYaoClgController.instance:handlePM_NotifyFuYaoClgNormalChallengeFinishRes(msg)
	end
end

function DivineFuYaoClgAgent:sendPM_DivineFuYaoClgExtremeChallengeReq(activityId, stageId, form)
	local req = DivineFuYaoClgExtension_pb.PM_DivineFuYaoClgExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineFuYaoClgAgent:handlePM_DivineFuYaoClgExtremeChallengeRes(status, msg)
	if status == 0 then
		DivineFuYaoClgController.instance:handlePM_DivineFuYaoClgExtremeChallengeRes(msg)
	end
end

function DivineFuYaoClgAgent:sendPM_DivineFuYaoClgExtremeConfirmReq(activityId, stageId, save)
	local req = DivineFuYaoClgExtension_pb.PM_DivineFuYaoClgExtremeConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function DivineFuYaoClgAgent:handlePM_DivineFuYaoClgExtremeConfirmRes(status, msg)
	DivineFuYaoClgController.instance:handlePM_DivineFuYaoClgExtremeConfirmRes(status, msg)
end

function DivineFuYaoClgAgent:sendPM_DivineFuYaoClgExtremeResetReq(activityId)
	local req = DivineFuYaoClgExtension_pb.PM_DivineFuYaoClgExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineFuYaoClgAgent:handlePM_DivineFuYaoClgExtremeResetRes(status, msg)
	if status == 0 then
		DivineFuYaoClgController.instance:handlePM_DivineFuYaoClgExtremeResetRes(msg)
	end
end

function DivineFuYaoClgAgent:handlePM_NotifyFuYaoClgExtremeChallengeFinishRes(status, msg)
	if status == 0 then
		DivineFuYaoClgController.instance:handlePM_NotifyFuYaoClgExtremeChallengeFinishRes(msg)
	end
end

DivineFuYaoClgAgent.instance = DivineFuYaoClgAgent.New()

return DivineFuYaoClgAgent
