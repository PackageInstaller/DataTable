-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/agent/MoonShadowKingChallengeAgent.lua

module("logic.extensions.moonking.agent.MoonShadowKingChallengeAgent", package.seeall)

local MoonShadowKingChallengeAgent = class("MoonShadowKingChallengeAgent", BaseAgent)

function MoonShadowKingChallengeAgent:sendPM_MoonShadowKingChallengeGetInfoReq(challengeId)
	local req = MoonShadowKingChallengeExtension_pb.PM_MoonShadowKingChallengeGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function MoonShadowKingChallengeAgent:handlePM_MoonShadowKingChallengeGetInfoRes(status, msg)
	if status == 0 then
		MoonKingController.instance:scSendMoonShadowKingChallengeGetInfo(msg)
	end
end

function MoonShadowKingChallengeAgent:sendPM_MoonShadowKingChallengeGetStageInfoReq(challengeId, groupId, stageId)
	local req = MoonShadowKingChallengeExtension_pb.PM_MoonShadowKingChallengeGetStageInfoReq()

	req.challengeId = challengeId
	req.groupId = groupId
	req.stageId = stageId

	self:sendMsg(req)
end

function MoonShadowKingChallengeAgent:handlePM_MoonShadowKingChallengeGetStageInfoRes(status, msg)
	if status == 0 then
		MoonKingController.instance:scSendMoonShadowKingChallengeGetStageInfo(msg)
	end
end

function MoonShadowKingChallengeAgent:sendPM_MoonShadowKingChallengeReq(challengeId, groupId, stageId, difficultyOptionInfos)
	local req = MoonShadowKingChallengeExtension_pb.PM_MoonShadowKingChallengeReq()

	req.challengeId = challengeId
	req.groupId = groupId
	req.stageId = stageId

	if difficultyOptionInfos and #difficultyOptionInfos > 0 then
		for i = 1, #difficultyOptionInfos do
			local groups = req.difficultyOptionInfos:add()

			groups.optionId = difficultyOptionInfos[i].optionId
			groups.optionGroup = difficultyOptionInfos[i].optionGroup
		end
	end

	self:sendMsg(req)
end

function MoonShadowKingChallengeAgent:handlePM_MoonShadowKingChallengeRes(status, msg)
	if status ~= 0 and ViewMgr.instance:isOpen(ViewName.MoonKingMission) then
		UIStateManager.instance:clear(true)
	end
end

function MoonShadowKingChallengeAgent:handlePM_MoonShadowKingChallengeEndRes(status, msg)
	if status == 0 then
		MoonKingController.instance:scSendMoonShadowKingChallengeEnd(msg)
	end
end

function MoonShadowKingChallengeAgent:sendPM_MoonShadowKingChallengeGainScorePrizeReq(challengeId, scorePrizeId)
	local req = MoonShadowKingChallengeExtension_pb.PM_MoonShadowKingChallengeGainScorePrizeReq()

	req.challengeId = challengeId
	req.scorePrizeId = scorePrizeId

	self:sendMsg(req)
end

function MoonShadowKingChallengeAgent:handlePM_MoonShadowKingChallengeGainScorePrizeRes(status, msg)
	if status == 0 then
		MoonKingController.instance:scSendMoonShadowKingChallengeGainScorePrize(msg)
	end
end

MoonShadowKingChallengeAgent.instance = MoonShadowKingChallengeAgent.New()

return MoonShadowKingChallengeAgent
