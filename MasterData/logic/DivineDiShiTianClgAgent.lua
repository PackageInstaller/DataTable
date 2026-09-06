-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedishitianclg/agent/DivineDiShiTianClgAgent.lua

module("logic.extensions.divinedishitianclg.agent.DivineDiShiTianClgAgent", package.seeall)

local DivineDiShiTianClgAgent = class("DivineDiShiTianClgAgent", BaseAgent)

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianClgInfoReq(activityId)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianClgInfoRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianClgInfoRes)
	end
end

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianChallengeNormalReq(activityId, index, form)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianChallengeNormalReq()

	req.activityId = activityId
	req.index = index

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianChallengeNormalRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onNormalRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianChallengeNormalRes, msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianClgRefreshLimitReq(activityId, index)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianClgRefreshLimitReq()

	req.activityId = activityId
	req.index = index

	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianClgRefreshLimitRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onRefreshLimitRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianClgRefreshLimitRes)
	end
end

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianClgGainNormalPrizeReq(activityId, prizeId)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianClgGainNormalPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianClgGainNormalPrizeRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onGainNormalPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianClgGainNormalPrizeRes)
	end
end

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianClgChallengeExtremeReq(activityId, stageId, form)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianClgChallengeExtremeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianClgChallengeExtremeRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onExtremeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianClgChallengeExtremeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianClgExtremeResetReq(activityId)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianClgExtremeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianClgExtremeResetRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onExtremeResetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianClgExtremeResetRes)
	end
end

function DivineDiShiTianClgAgent:sendPM_DivineDiShiTianClgExtremeGainPrizeReq(activityId)
	local req = DivineDiShiTianClgExtension_pb.PM_DivineDiShiTianClgExtremeGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineDiShiTianClgAgent:handlePM_DivineDiShiTianClgExtremeGainPrizeRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onExtremeGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineDiShiTianClgExtremeGainPrizeRes)
	end
end

function DivineDiShiTianClgAgent:handlePM_NotifyDivineDiShiTianClgNormalFinishRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onNotifyNormalFinishRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDivineDiShiTianClgNormalFinishRes, msg.activityId)
	end
end

function DivineDiShiTianClgAgent:handlePM_NotifyDivineDiShiTianClgExtremeFinishRes(status, msg)
	if status == 0 then
		DivineDiShiTianClgModel.instance:onNotifyExtremeFinishRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyDivineDiShiTianClgExtremeFinishRes, msg.activityId)
	end
end

DivineDiShiTianClgAgent.instance = DivineDiShiTianClgAgent.New()

return DivineDiShiTianClgAgent
