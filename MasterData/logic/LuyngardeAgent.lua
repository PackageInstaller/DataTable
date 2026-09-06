-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/agent/LuyngardeAgent.lua

module("logic.extensions.luyngarde.agent.LuyngardeAgent", package.seeall)

local LuyngardeAgent = class("LuyngardeAgent", BaseAgent)

function LuyngardeAgent:sendPM_LuyngardeInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetInfo(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeUpgradeReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeUpgradeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeUpgradeRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleUpgradePet(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter2BossInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter2BossInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter2BossInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleChapter2Info(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter2BossSimpleRankInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter2BossSimpleRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter2BossSimpleRankInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleChapter2SimpleRankInfo(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter2BossGainKillPrizeReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter2BossGainKillPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter2BossGainKillPrizeRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGainChapter2KillPrize(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter2BossClgReq(activityId, creepsMasterId, simulated, form_pb)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter2BossClgReq()

	req.activityId = activityId
	req.creepsMasterId = creepsMasterId
	req.simulated = simulated

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter2BossClgRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleStartChapter2Challenge(msg)
	end
end

function LuyngardeAgent:handlePM_NotifyLuyngardeChapter2BossClgFinishRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleNotifyChapter2ChallengeRes(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter2BossGainPrizeReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter2BossGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter2BossGainPrizeRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGainChapter2Prize(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter2BossRankInfoReq(activityId, typeId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter2BossRankInfoReq()

	req.activityId = activityId
	req.typeId = typeId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter2BossRankInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter2RankInfo(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter3Info(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreSelectStarReq(activityId, positionId, star)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreSelectStarReq()

	req.activityId = activityId
	req.positionId = positionId
	req.star = star

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreSelectStarRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleChapter3SelectStar(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreSelfClgReq(activityId, positionId, form_pb)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreSelfClgReq()

	req.activityId = activityId
	req.positionId = positionId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreSelfClgRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:hanleChapter3SelfClg(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreSeekHelpReq(activityId, positionId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreSeekHelpReq()

	req.activityId = activityId
	req.positionId = positionId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreSeekHelpRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:hanleChapter3SeekHelp(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreResetStarReq(activityId, positionId, star)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreResetStarReq()

	req.activityId = activityId
	req.positionId = positionId
	req.star = star

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreResetStarRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:hanleChapter3ResetStar(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreHelpInfoReq(activityId, otherUserId, positionId, helpId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreHelpInfoReq()

	req.activityId = activityId
	req.otherUserId = otherUserId
	req.positionId = positionId
	req.helpId = helpId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreHelpInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter3ExploreHelpInfo(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreHelpCenterReq(activityId, star)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreHelpCenterReq()

	req.activityId = activityId

	if star ~= nil then
		req.star = star
	end

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreHelpCenterRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter3ExploreHelpCenter(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreHelpClgReq(activityId, otherUserId, helpId, positionId, form_pb)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreHelpClgReq()

	req.activityId = activityId
	req.otherUserId = otherUserId
	req.helpId = helpId
	req.positionId = positionId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreHelpClgRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:hanleChapter3HelpClg(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter3ExploreRankInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter3ExploreRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter3ExploreRankInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter3RankInfo(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter4FinalInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter4FinalInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter4FinalInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter4Info(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter4FinalChallengeReq(activityId, form_pb)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter4FinalChallengeReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter4FinalChallengeRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleStartChapter4Challenge(msg)
	end
end

function LuyngardeAgent:handlePM_NotifyLuyngardeChapter4FinalClgFinishRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleNotifyChapter4ChallengeRes(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter4FinalResetReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter4FinalResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter4FinalResetRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleResetChapter4Challenge(msg)
	end
end

function LuyngardeAgent:sendPM_LuyngardeChapter4FinalRankInfoReq(activityId)
	local req = LuyngardeExtension_pb.PM_LuyngardeChapter4FinalRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuyngardeAgent:handlePM_LuyngardeChapter4FinalRankInfoRes(status, msg)
	if status == 0 then
		LuyngardeController.instance:handleGetChapter4RankInfo(msg)
	end
end

LuyngardeAgent.instance = LuyngardeAgent.New()

return LuyngardeAgent
