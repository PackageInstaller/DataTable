-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/agent/FanTianChallengeAgent.lua

module("logic.extensions.fantianchallenge.agent.FanTianChallengeAgent", package.seeall)

local FanTianChallengeAgent = class("FanTianChallengeAgent", BaseAgent)

function FanTianChallengeAgent:ctor()
	return
end

function FanTianChallengeAgent:setExtId(extId)
	FanTianChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function FanTianChallengeAgent:sendPM_FanTianClgGetInfoReq(activityId)
	local req = FanTianChallengeExtension_pb.PM_FanTianClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FanTianChallengeAgent:handlePM_FanTianClgGetInfoRes(status, msg)
	if status == 0 then
		FanTianChallengeController.instance:handlePM_FanTianClgGetInfoRes(msg)
	end
end

function FanTianChallengeAgent:sendPM_FanTianClgFightReq(activityId, tierId, stageId, form_pb)
	local req = FanTianChallengeExtension_pb.PM_FanTianClgFightReq()

	req.activityId = activityId
	req.tierId = tierId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function FanTianChallengeAgent:handlePM_FanTianClgFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FanTianChallengeAgent:sendPM_FanTianClgGainProgressPrizeReq(activityId, dataBitId)
	local req = FanTianChallengeExtension_pb.PM_FanTianClgGainProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function FanTianChallengeAgent:handlePM_FanTianClgGainProgressPrizeRes(status, msg)
	if status == 0 then
		FanTianChallengeController.instance:handlePM_FanTianClgGainProgressPrizeRes(msg)
	end
end

function FanTianChallengeAgent:handlePM_FanTianClgNotifyFightResultRes(status, msg)
	FanTianChallengeController.instance:onGetFighMsg(msg)
end

FanTianChallengeAgent.instance = FanTianChallengeAgent.New()

return FanTianChallengeAgent
