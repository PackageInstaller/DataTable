-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/agent/IntegrationChallengeAgent.lua

module("logic.extensions.integrationchallenge.agent.IntegrationChallengeAgent", package.seeall)

local IntegrationChallengeAgent = class("IntegrationChallengeAgent", BaseAgent)

function IntegrationChallengeAgent:sendPM_ICGetMainBoardInfoReq(challengeId)
	local req = IntegrationChallengeExtension_pb.PM_ICGetMainBoardInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IntegrationChallengeAgent:handlePM_ICGetMainBoardInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadTwinDragonChallenge===back")

	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICGetMainBoardInfoRes(msg)
	end
end

function IntegrationChallengeAgent:sendPM_ICGetChallengeBoardInfoReq(challengeId)
	local req = IntegrationChallengeExtension_pb.PM_ICGetChallengeBoardInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IntegrationChallengeAgent:handlePM_ICGetChallengeBoardInfoRes(status, msg)
	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICGetChallengeBoardInfoRes(msg)
	end
end

function IntegrationChallengeAgent:sendPM_ICChallengeReq(challengeId, type, stageId)
	local req = IntegrationChallengeExtension_pb.PM_ICChallengeReq()

	req.challengeId = challengeId
	req.type = type
	req.stageId = stageId

	self:sendMsg(req)
end

function IntegrationChallengeAgent:handlePM_ICChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function IntegrationChallengeAgent:sendPM_ICSetNewRoundsReq(challengeId, isReset)
	local req = IntegrationChallengeExtension_pb.PM_ICSetNewRoundsReq()

	req.challengeId = challengeId
	req.isReset = isReset

	self:sendMsg(req)
end

function IntegrationChallengeAgent:handlePM_ICSetNewRoundsRes(status, msg)
	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICSetNewRoundsRes(msg)
	end
end

function IntegrationChallengeAgent:sendPM_ICIntegrateReq(challengeId)
	local req = IntegrationChallengeExtension_pb.PM_ICIntegrateReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IntegrationChallengeAgent:handlePM_ICIntegrateRes(status, msg)
	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICIntegrateRes(msg)
	end
end

function IntegrationChallengeAgent:sendPM_ICAddBuffLevelReq(challengeId)
	local req = IntegrationChallengeExtension_pb.PM_ICAddBuffLevelReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IntegrationChallengeAgent:handlePM_ICAddBuffLevelRes(status, msg)
	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICAddBuffLevelRes(msg)
	end
end

function IntegrationChallengeAgent:handlePM_ICChallengeEndRes(status, msg)
	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICChallengeEndRes(msg)
	end
end

function IntegrationChallengeAgent:handlePM_ICBuyEndRes(status, msg)
	if status == 0 then
		IntegrationChallengeController.instance:handlePM_ICBuyEndRes(msg)
	end
end

IntegrationChallengeAgent.instance = IntegrationChallengeAgent.New()

return IntegrationChallengeAgent
