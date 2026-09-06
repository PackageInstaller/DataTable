-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/agent/YiShiChallengeAgent.lua

module("logic.extensions.yishichallenge.agent.YiShiChallengeAgent", package.seeall)

local YiShiChallengeAgent = class("YiShiChallengeAgent", BaseAgent)

function YiShiChallengeAgent:sendPM_YiShiChallengeInfoReq(challengeId)
	local req = YiShiChallengeExtension_pb.PM_YiShiChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function YiShiChallengeAgent:handlePM_YiShiChallengeInfoRes(status, msg)
	if status == 0 then
		YishiChallengeModel.instance:setChallengeInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.YishiChallengeInfoReq)
	end
end

function YiShiChallengeAgent:sendPM_YiShiChallengeReq(challengeId, form)
	local req = YiShiChallengeExtension_pb.PM_YiShiChallengeReq()

	req.challengeId = challengeId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function YiShiChallengeAgent:handlePM_YiShiChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function YiShiChallengeAgent:sendPM_YiShiChallengeStageUnlockReq(challengeId, stageId)
	local req = YiShiChallengeExtension_pb.PM_YiShiChallengeStageUnlockReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function YiShiChallengeAgent:handlePM_YiShiChallengeStageUnlockRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.YishiChallengeStageUnlockReq)
	end
end

function YiShiChallengeAgent:handlePM_Notify_YiShiChallengeEndRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function YiShiChallengeAgent:sendPM_YiShiChallengeUpgradeBuffReq(challengeId)
	local req = YiShiChallengeExtension_pb.PM_YiShiChallengeUpgradeBuffReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function YiShiChallengeAgent:handlePM_YiShiChallengeUpgradeBuffRes(status, msg)
	if status == 0 then
		YishiChallengeModel.instance:setUpgradeBuffInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.YishiChallengeUpgradeBuffReq)
	end
end

YiShiChallengeAgent.instance = YiShiChallengeAgent.New()

return YiShiChallengeAgent
