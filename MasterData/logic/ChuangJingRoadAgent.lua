-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/agent/ChuangJingRoadAgent.lua

module("logic.extensions.chuangjingroad.agent.ChuangJingRoadAgent", package.seeall)

local ChuangJingRoadAgent = class("ChuangJingRoadAgent", BaseAgent)

function ChuangJingRoadAgent:sendPM_ChuangJingRoadGetInfoReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadGetInfoRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onGetInfo(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadGainProgressPrizeReq(activityId, zoneId, prizeId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadGainProgressPrizeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadGainProgressPrizeRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onGetePrize(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadRankReq(activityId, zoneId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadRankReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadRankRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onGetRank(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadPetInfoReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadPetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadPetInfoRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onGetPetInfo(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadBuyPetReq(activityId, creepId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadBuyPetReq()

	req.activityId = activityId
	req.creepId = creepId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadBuyPetRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onBuyPet(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadUpgradeLevelReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadUpgradeLevelReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadUpgradeLevelRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onPetLvlUp(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadEquipmentLvReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadEquipmentLvReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadEquipmentLvRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onEquipLvlUp(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadStarGodPlusLvReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadStarGodPlusLvReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadStarGodPlusLvRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onStarGodLvlUp(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadAwakenLvUpReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadAwakenLvUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadAwakenLvUpRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onAwakenLvlUp(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadHolyStripeLevelUpReq(activityId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadHolyStripeLevelUpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadHolyStripeLevelUpRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onHolyStripeLvlUp(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadChallengeReq(activityId, zoneId, stageId, form_pb)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadBossChallengeReq(activityId, form_pb)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadBossChallengeReq()

	req.activityId = activityId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadLightBossChallengeReq(activityId, zoneId, form_pb)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadLightBossChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadLightBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadWaterBossChallengeReq(activityId, zoneId, teamId, form_pb)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadWaterBossChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.teamId = teamId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadWaterBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadFireBossChallengeReq(activityId, zoneId, teamId, form_pb)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadFireBossChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.teamId = teamId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadFireBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadGrassBossChallengeReq(activityId, zoneId, stageId, form_pb)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadGrassBossChallengeReq()

	req.activityId = activityId
	req.zoneId = zoneId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadGrassBossChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadResetBossReq(activityId, zoneId, param)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadResetBossReq()

	req.activityId = activityId
	req.zoneId = zoneId

	if param ~= nil then
		req.param = param
	end

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadResetBossRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onResetBossFight(msg)
	end
end

function ChuangJingRoadAgent:sendPM_ChuangJingRoadFirstPassInfoReq(activityId, zoneId)
	local req = ChuangJingRoadExtension_pb.PM_ChuangJingRoadFirstPassInfoReq()

	req.activityId = activityId
	req.zoneId = zoneId

	self:sendMsg(req)
end

function ChuangJingRoadAgent:handlePM_ChuangJingRoadFirstPassInfoRes(status, msg)
	if status == 0 then
		ChuangJingRoadController.instance:onGetFirstTeamInfo(msg)
	end
end

function ChuangJingRoadAgent:handlePM_NotifyChallengeFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:handlePM_NotifyChallengeBossFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end

	ChuangJingRoadController.instance:onHandleResBossFight(msg)
end

function ChuangJingRoadAgent:handlePM_NotifyChallengeLightBossFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function ChuangJingRoadAgent:handlePM_NotifyChallengeWaterBossFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end

	ChuangJingRoadController.instance:handleWaterBossFinish(msg)
end

function ChuangJingRoadAgent:handlePM_NotifyChallengeFireBossFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end

	ChuangJingRoadController.instance:handleFireBossFinish(msg)
end

function ChuangJingRoadAgent:handlePM_NotifyChallengeGrassBossFightEndRes(status, msg)
	if status == 0 then
		-- block empty
	end

	ChuangJingRoadController.instance:handleGrassBossFinish(msg)
end

ChuangJingRoadAgent.instance = ChuangJingRoadAgent.New()

return ChuangJingRoadAgent
