-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/agent/DreamTeamChapterAgent.lua

module("logic.extensions.dreamteamchapter.agent.DreamTeamChapterAgent", package.seeall)

local DreamTeamChapterAgent = class("DreamTeamChapterAgent", BaseAgent)

function DreamTeamChapterAgent:sendPM_DreamTeamChapterGetInfoReq(activityId)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterGetInfoRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterGetInfoRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterSmeltReq(activityId, alchemyMaterialId)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterSmeltReq()

	req.activityId = activityId

	for _, materialId in ipairs(alchemyMaterialId or {}) do
		req.alchemyMaterialId:append(materialId)
	end

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterSmeltRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterSmeltRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterChallengeReq(activityId, challengeId, stageId, form)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterChallengeReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterChallengeRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterChallengeRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterNotifyClgRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterNotifyClgRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterChallengeBossReq(activityId, form)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterChallengeBossReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterChallengeBossRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterChallengeBossRes(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterNotifyBossClgRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterNotifyBossClgRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterOneClickGainProgressPrizeReq(activityId, progressType)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterOneClickGainProgressPrizeReq()

	req.activityId = activityId
	req.progressType = progressType

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterOneClickGainProgressPrizeRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterOneClickGainProgressPrizeRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterRankViewReq(activityId)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterRankViewRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterRankViewRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterFirstClickReq(activityId, chapterId)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterFirstClickReq()

	req.activityId = activityId
	req.chapterId = chapterId

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterFirstClickRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterFirstClickRes(msg)
	end
end

function DreamTeamChapterAgent:sendPM_DreamTeamChapterAwakenMengMengReq(activityId)
	local req = DreamTeamExtension_pb.PM_DreamTeamChapterAwakenMengMengReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DreamTeamChapterAgent:handlePM_DreamTeamChapterAwakenMengMengRes(status, msg)
	if status == 0 then
		DreamTeamChapterController.instance:handlePM_DreamTeamChapterAwakenMengMengRes(msg)
	end
end

DreamTeamChapterAgent.instance = DreamTeamChapterAgent.New()

return DreamTeamChapterAgent
