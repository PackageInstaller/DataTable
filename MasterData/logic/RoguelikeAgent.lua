-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/agent/RoguelikeAgent.lua

module("logic.extensions.roguelike.agent.RoguelikeAgent", package.seeall)

local RoguelikeAgent = class("RoguelikeAgent", BaseAgent)

function RoguelikeAgent:sendPM_RoguelikeGetInfoReq(activityId)
	local req = RoguelikeExtension_pb.PM_RoguelikeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeGetInfoRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeGetInfoRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeLvlUpGlobalBuffReq(activityId, buffId)
	local req = RoguelikeExtension_pb.PM_RoguelikeLvlUpGlobalBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeLvlUpGlobalBuffRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeLvlUpGlobalBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeLvlUpGlobalBuffRes, msg.buffId)
	end
end

function RoguelikeAgent:sendPM_RoguelikeResetGlobalBuffLvlReq(activityId, buffId)
	local req = RoguelikeExtension_pb.PM_RoguelikeResetGlobalBuffLvlReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeResetGlobalBuffLvlRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeResetGlobalBuffLvlRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeResetGlobalBuffLvlRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeSetGlobalBuffOnOffReq(activityId, buffId, using)
	local req = RoguelikeExtension_pb.PM_RoguelikeSetGlobalBuffOnOffReq()

	req.activityId = activityId
	req.buffId = buffId
	req.using = using

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeSetGlobalBuffOnOffRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeSetGlobalBuffOnOffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeSetGlobalBuffOnOffRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeSetRentPetUsingOrNotReq(activityId, petId, using)
	local req = RoguelikeExtension_pb.PM_RoguelikeSetRentPetUsingOrNotReq()

	req.activityId = activityId
	req.petId = petId
	req.using = using

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeSetRentPetUsingOrNotRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeSetRentPetUsingOrNotRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeSetRentPetUsingOrNotRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeRerandomDropBuffReq(activityId, phaseId)
	local req = RoguelikeExtension_pb.PM_RoguelikeRerandomDropBuffReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeRerandomDropBuffRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeRerandomDropBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeRerandomDropBuffRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeSelectDropBuffReq(activityId, phaseId, buffId)
	local req = RoguelikeExtension_pb.PM_RoguelikeSelectDropBuffReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.buffId = buffId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeSelectDropBuffRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeSelectDropBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeSelectDropBuffRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeReShuffleDropBuffReq(activityId, phaseId)
	local req = RoguelikeExtension_pb.PM_RoguelikeReShuffleDropBuffReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeReShuffleDropBuffRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeReShuffleDropBuffRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeReShuffleDropBuffRes, msg.activityId, msg.phaseId)
	end
end

function RoguelikeAgent:sendPM_RoguelikeGainNormalPrizeReq(activityId, phaseId, toStageId)
	local req = RoguelikeExtension_pb.PM_RoguelikeGainNormalPrizeReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.toStageId = toStageId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeGainNormalPrizeRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeGainNormalPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeGainNormalPrizeRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeStartFightReq(activityId, phaseId, form)
	local req = RoguelikeExtension_pb.PM_RoguelikeStartFightReq()

	req.activityId = activityId
	req.phaseId = phaseId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeStartFightRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeStartFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeStartFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function RoguelikeAgent:sendPM_RoguelikeContunieFightReq(activityId, phaseId)
	local req = RoguelikeExtension_pb.PM_RoguelikeContunieFightReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeContunieFightRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeContunieFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeContunieFightRes)
	end
end

function RoguelikeAgent:handlePM_RoguelikeNotifyFightResultRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeNotifyFightResultRes, msg, msg.activityId, msg.phaseId)
	end
end

function RoguelikeAgent:sendPM_RoguelikeGetKillRankReq(activityId, phaseId)
	local req = RoguelikeExtension_pb.PM_RoguelikeGetKillRankReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeGetKillRankRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeGetKillRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeGetKillRankRes)
	end
end

function RoguelikeAgent:sendPM_RoguelikeGetPassRankReq(activityId, phaseId)
	local req = RoguelikeExtension_pb.PM_RoguelikeGetPassRankReq()

	req.activityId = activityId
	req.phaseId = phaseId

	self:sendMsg(req)
end

function RoguelikeAgent:handlePM_RoguelikeGetPassRankRes(status, msg)
	if status == 0 then
		RoguelikeModel.instance:onRoguelikeGetPassRankRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.RoguelikeGetPassRankRes)
	end
end

RoguelikeAgent.instance = RoguelikeAgent.New()

return RoguelikeAgent
