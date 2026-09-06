-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/agent/UltimateWarAgent.lua

module("logic.extensions.ultimatewar.agent.UltimateWarAgent", package.seeall)

local UltimateWarAgent = class("UltimateWarAgent", BaseAgent)

function UltimateWarAgent:sendPM_UltimateWarGetMainInfoReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarGetMainInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarGetMainInfoRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarGetMainInfoRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarUpPetLevelReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarUpPetLevelReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarUpPetLevelRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarUpPetLevelRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarFinishPlotReq(activityId, plotId)
	local req = UltimateWarExtension_pb.PM_UltimateWarFinishPlotReq()

	req.activityId = activityId
	req.plotId = plotId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarFinishPlotRes(status, msg)
	UltimateWarController.instance:handlePM_UltimateWarFinishPlotRes(status, msg)
end

function UltimateWarAgent:sendPM_UltimateWarFirstStepInfoReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarFirstStepInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarFirstStepInfoRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarFirstStepInfoRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarDispatchReq(activityId, pointId, raceIds)
	local req = UltimateWarExtension_pb.PM_UltimateWarDispatchReq()

	req.activityId = activityId
	req.pointId = pointId

	for _, v in ipairs(raceIds) do
		req.raceIds:append(v)
	end

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarDispatchRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarDispatchRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarGainHangingPrizeReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarGainHangingPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarGainHangingPrizeRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarGainHangingPrizeRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarSecondStepInfoReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarSecondStepInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarSecondStepInfoRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarSecondStepInfoRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarTowerFightReq(activityId, towerId, form)
	local req = UltimateWarExtension_pb.PM_UltimateWarTowerFightReq()

	req.activityId = activityId
	req.towerId = towerId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarTowerFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarTowerFightRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarContinueTowerFightReq(activityId, towerId)
	local req = UltimateWarExtension_pb.PM_UltimateWarContinueTowerFightReq()

	req.activityId = activityId
	req.towerId = towerId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarContinueTowerFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarContinueTowerFightRes(msg)
	end
end

function UltimateWarAgent:handlePM_UltimateWarNotifyTowerFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarNotifyTowerFightRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarTowerBossFightReq(activityId, form)
	local req = UltimateWarExtension_pb.PM_UltimateWarTowerBossFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarTowerBossFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarTowerBossFightRes(msg)
	end
end

function UltimateWarAgent:handlePM_UltimateWarNotifyTowerBossFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarNotifyTowerBossFightRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarGainTowerBossPrizeReq(activityId, type, subId, prizeIdList)
	local req = UltimateWarExtension_pb.PM_UltimateWarGainTowerBossPrizeReq()

	req.activityId = activityId
	req.type = type
	req.subId = subId

	if prizeIdList then
		for _, v in ipairs(prizeIdList) do
			req.prizeId:append(v)
		end
	end

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarGainTowerBossPrizeRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarGainTowerBossPrizeRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarSubmitTowerBossFormReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarSubmitTowerBossFormReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarSubmitTowerBossFormRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarSubmitTowerBossFormRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarThirdStepInfoReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarThirdStepInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarThirdStepInfoRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarThirdStepInfoRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarThirdStepFightReq(activityId, bossId, form)
	local req = UltimateWarExtension_pb.PM_UltimateWarThirdStepFightReq()

	req.activityId = activityId
	req.bossId = bossId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarThirdStepFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarThirdStepFightRes(msg)
	end
end

function UltimateWarAgent:handlePM_UltimateWarNotifyThirdStepFightRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarNotifyThirdStepFightRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarThirdStepCheckInReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarThirdStepCheckInReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarThirdStepCheckInRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarThirdStepCheckInRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarThirdStepGainPrizeReq(activityId, prizeId)
	local req = UltimateWarExtension_pb.PM_UltimateWarThirdStepGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarThirdStepGainPrizeRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarThirdStepGainPrizeRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarRankViewReq(activityId, type)
	local req = UltimateWarExtension_pb.PM_UltimateWarRankViewReq()

	req.activityId = activityId
	req.type = type

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarRankViewRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarRankViewRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarRecordReq(activityId)
	local req = UltimateWarExtension_pb.PM_UltimateWarRecordReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarRecordRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarRecordRes(msg)
	end
end

function UltimateWarAgent:sendPM_UltimateWarVoteReq(activityId, selectVoteId)
	local req = UltimateWarExtension_pb.PM_UltimateWarVoteReq()

	req.activityId = activityId
	req.selectVoteId = selectVoteId

	self:sendMsg(req)
end

function UltimateWarAgent:handlePM_UltimateWarVoteRes(status, msg)
	if status == 0 then
		UltimateWarController.instance:handlePM_UltimateWarVoteRes(msg)
	end
end

UltimateWarAgent.instance = UltimateWarAgent.New()

return UltimateWarAgent
