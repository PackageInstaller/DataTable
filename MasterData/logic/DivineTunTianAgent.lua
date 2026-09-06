-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/agent/DivineTunTianAgent.lua

module("logic.extensions.divinetuntian.agent.DivineTunTianAgent", package.seeall)

local DivineTunTianAgent = class("DivineTunTianAgent", BaseAgent)

function DivineTunTianAgent:sendPM_DivineTunTianClgGetInfoReq(activityId)
	local req = DivineTunTianClgExtension_pb.PM_DivineTunTianClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineTunTianAgent:handlePM_DivineTunTianClgGetInfoRes(status, msg)
	if status == 0 then
		DivineTunTianController.instance:handlePM_DivineTunTianClgGetInfoRes(msg)
		print("handlePM_DivineTunTianClgGetInfoRes  1")
	end
end

function DivineTunTianAgent:sendPM_DivineTunTianClgExtremeChallengeReq(activityId, stageId, form)
	local req = DivineTunTianClgExtension_pb.PM_DivineTunTianClgExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineTunTianAgent:handlePM_DivineTunTianClgExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineTunTianAgent:sendPM_DivineTunTianClgExtremeConfirmReq(activityId, stageId, confirm)
	local req = DivineTunTianClgExtension_pb.PM_DivineTunTianClgExtremeConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function DivineTunTianAgent:handlePM_DivineTunTianClgExtremeConfirmRes(status, msg)
	if status == 0 then
		DivineTunTianController.instance:handlePM_DivineTunTianClgExtremeConfirmRes(msg)
	end
end

function DivineTunTianAgent:sendPM_DivineTunTianClgExtremeResetReq(activityId)
	local req = DivineTunTianClgExtension_pb.PM_DivineTunTianClgExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineTunTianAgent:handlePM_DivineTunTianClgExtremeResetRes(status, msg)
	if status == 0 then
		DivineTunTianController.instance:handlePM_DivineTunTianClgExtremeResetRes(msg)
	end
end

function DivineTunTianAgent:sendPM_DivineTunTianClgNormalChallengeReq(activityId, index, form)
	local req = DivineTunTianClgExtension_pb.PM_DivineTunTianClgNormalChallengeReq()

	req.activityId = activityId
	req.index = index

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineTunTianAgent:handlePM_DivineTunTianClgNormalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineTunTianAgent:sendPM_DivineTunTianClgGainNormalProgressPrizeReq(activityId, prizeId)
	local req = DivineTunTianClgExtension_pb.PM_DivineTunTianClgGainNormalProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineTunTianAgent:handlePM_DivineTunTianClgGainNormalProgressPrizeRes(status, msg)
	if status == 0 then
		DivineTunTianController.instance:handlePM_DivineTunTianClgGainNormalProgressPrizeRes(msg)
	end
end

function DivineTunTianAgent:handlePM_Notify_DivineTunTianClgExtremeChallengeResultRes(status, msg)
	if status == 0 then
		DivineTunTianController.instance:handlePM_Notify_DivineTunTianClgExtremeChallengeResultRes(msg)
	end
end

function DivineTunTianAgent:handlePM_Notify_DivineTunTianClgNormalChallengeResultRes(status, msg)
	if status == 0 then
		DivineTunTianController.instance:handlePM_Notify_DivineTunTianClgNormalChallengeResultRes(msg)
	end
end

DivineTunTianAgent.instance = DivineTunTianAgent.New()

return DivineTunTianAgent
