-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/agent/MagicSchoolPvPAgent.lua

module("logic.extensions.magicschoolpvp.agent.MagicSchoolPvPAgent", package.seeall)

local MagicSchoolPvPAgent = class("MagicSchoolPvPAgent", BaseAgent)

function MagicSchoolPvPAgent:sendPM_MSPvPInfoReq(activityId)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPInfoRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_MSPvPInfoRes(msg)
	end
end

function MagicSchoolPvPAgent:sendPM_MSPvPGetPresetFormationReq(activityId)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPGetPresetFormationReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPGetPresetFormationRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_MSPvPGetPresetFormationRes(msg)
	end
end

function MagicSchoolPvPAgent:sendPM_MSPvPSetPresetFormationReq(activityId, simpleForm)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPSetPresetFormationReq()

	req.activityId = activityId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function MagicSchoolPvPAgent:sendPM_MSPvPAskSwitchReq(activityId, targetUserId, originBossId, askBossId)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPAskSwitchReq()

	req.activityId = activityId
	req.targetUserId = targetUserId
	req.originBossId = originBossId
	req.askBossId = askBossId

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPAskSwitchRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_MSPvPAskSwitchRes(msg)
	end
end

function MagicSchoolPvPAgent:sendPM_MSPvPAskHandleSwitchReq(activityId, agree)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPAskHandleSwitchReq()

	req.activityId = activityId
	req.agree = agree

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPAskHandleSwitchRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_MSPvPAskHandleSwitchRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_MSPvPSetPresetFormationRes(status, msg)
	MagicSchoolPvPController.instance:handlePM_MSPvPSetPresetFormationRes(status, msg)
end

function MagicSchoolPvPAgent:sendPM_MSPvPSetFormationReq(activityId, simpleForm)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPSetFormationReq()

	req.activityId = activityId

	req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPSetFormationRes(status, msg)
	MagicSchoolPvPController.instance:handlePM_MSPvPSetFormationRes(status, msg)
end

function MagicSchoolPvPAgent:sendPM_MSPvPSelectBuffReq(activityId, buffId)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPSelectBuffReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPSelectBuffRes(status, msg)
	MagicSchoolPvPController.instance:handlePM_MSPvPSelectBuffRes(status, msg)
end

function MagicSchoolPvPAgent:sendPM_MSPvPChatReq(activityId, chatId)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPChatReq()

	req.activityId = activityId
	req.chatId = chatId

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPChatRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_MSPvPChatRes(msg)
	end
end

function MagicSchoolPvPAgent:sendPM_MSPvPRankInfoReq(activityId)
	local req = MagicSchoolPvPExtension_pb.PM_MSPvPRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MagicSchoolPvPAgent:handlePM_MSPvPRankInfoRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_MSPvPRankInfoRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMSPvPMatchStartRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMSPvPMatchStartRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMSPvPMatchOverTimeRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMSPvPMatchOverTimeRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMSPvPMatchFailRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMSPvPMatchFailRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMSPvPGameStartRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMSPvPGameStartRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMSPvPAskSwitchPositionRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMSPvPAskSwitchPositionRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMSPvPAskSwitchPositionResultRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMSPvPAskSwitchPositionResultRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMsPvPWatchBattleResultRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMsPvPWatchBattleResultRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMsPvPStartSelectBuffRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMsPvPStartSelectBuffRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMsPvPFinishSelectBuffRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMsPvPFinishSelectBuffRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMsPvPGameEndRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMsPvPGameEndRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMsPvPErrorRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMsPvPErrorRes(msg)
	end
end

function MagicSchoolPvPAgent:handlePM_NotifyMsPvPChatRes(status, msg)
	if status == 0 then
		MagicSchoolPvPController.instance:handlePM_NotifyMsPvPChatRes(msg)
	end
end

MagicSchoolPvPAgent.instance = MagicSchoolPvPAgent.New()

return MagicSchoolPvPAgent
