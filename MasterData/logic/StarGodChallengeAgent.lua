-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/agent/StarGodChallengeAgent.lua

module("logic.extensions.stargodchallenge.agent.StarGodChallengeAgent", package.seeall)

local StarGodChallengeAgent = class("StarGodChallengeAgent", BaseAgent)

function StarGodChallengeAgent:sendPM_StarGodChallengeGetInfoReq()
	local req = StarGodChallengeExtension_pb.PM_StarGodChallengeGetInfoReq()

	self:sendMsg(req)
end

function StarGodChallengeAgent:handlePM_StarGodChallengeGetInfoRes(status, msg)
	if status == 0 then
		StarGodChallengeModel.instance:onStarGodChallengeGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeGetInfoRes)
	end
end

function StarGodChallengeAgent:sendPM_StarGodChallengeSingleFightReq(form)
	local req = StarGodChallengeExtension_pb.PM_StarGodChallengeSingleFightReq()

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function StarGodChallengeAgent:handlePM_StarGodChallengeSingleFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeSingleFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function StarGodChallengeAgent:handlePM_StarGodChallengeSingleFightResultRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
		StarGodChallengeModel.instance:onStarGodChallengeSingleFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeSingleFightResultRes)
	end
end

function StarGodChallengeAgent:sendPM_StarGodChallengeSweepReq(tier, sweepTimes)
	local req = StarGodChallengeExtension_pb.PM_StarGodChallengeSweepReq()

	req.tier = tier
	req.sweepTimes = sweepTimes

	self:sendMsg(req)
end

function StarGodChallengeAgent:handlePM_StarGodChallengeSweepRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeSweepRes, msg)
	end
end

function StarGodChallengeAgent:sendPM_StarGodChallengeGetFormReq()
	local req = StarGodChallengeExtension_pb.PM_StarGodChallengeGetFormReq()

	self:sendMsg(req)
end

function StarGodChallengeAgent:handlePM_StarGodChallengeGetFormRes(status, msg)
	if status == 0 then
		StarGodChallengeModel.instance:onStarGodChallengeGetFormRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeGetFormRes)
	end
end

function StarGodChallengeAgent:sendPM_StarGodChallengeSetFormReq(form)
	local req = StarGodChallengeExtension_pb.PM_StarGodChallengeSetFormReq()

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function StarGodChallengeAgent:handlePM_StarGodChallengeSetFormRes(status, msg)
	if status == 0 then
		StarGodChallengeModel.instance:onStarGodChallengeSetFormRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeSetFormRes)
	end
end

function StarGodChallengeAgent:sendPM_StarGodChallengeReadyReq(form)
	local req = StarGodChallengeExtension_pb.PM_StarGodChallengeReadyReq()

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function StarGodChallengeAgent:handlePM_StarGodChallengeReadyRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeReadyRes)
	end
end

function StarGodChallengeAgent:handlePM_StarGodChallengeGroupFightResultRes(status, msg)
	if status == 0 then
		StarGodChallengeController.instance:onStarGodChallengeGroupFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.StarGodChallengeGroupFightResultRes)
	end
end

function StarGodChallengeAgent:handlePM_StarGodChallengeNotifyEndRes(status, msg)
	if status == 0 then
		local reason = msg.reason

		StarGodChallengeController.instance:dealFightError(reason)
	end
end

function StarGodChallengeAgent:handlePM_StarGodChallengeNotifyGameStartRes(status, msg)
	if status == 0 then
		StarGodChallengeController.instance:dealEnterTeamFight()
	end
end

StarGodChallengeAgent.instance = StarGodChallengeAgent.New()

return StarGodChallengeAgent
