-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/agent/SurvivalKingAgent.lua

module("logic.extensions.survivalking.agent.SurvivalKingAgent", package.seeall)

local SurvivalKingAgent = class("SurvivalKingAgent", BaseAgent)

function SurvivalKingAgent:sendPM_SurvivalKingInfoReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingInfoRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetBaseInfo(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingGetPresetReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingGetPresetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingGetPresetRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetPresetInfo(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingSetPresetReq(activityId, groups, levelBuffId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingSetPresetReq()

	req.activityId = activityId

	if groups ~= nil then
		for i, v1 in ipairs(groups) do
			local groups = req.groups:add()

			groups:ParseFromString(v1:SerializeToString())
		end
	end

	if levelBuffId ~= nil then
		for i, v2 in ipairs(levelBuffId) do
			local levelBuffId = req.levelBuffId:add()

			levelBuffId:ParseFromString(v2:SerializeToString())
		end
	end

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingSetPresetRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleSetPresetInfo(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingSignUpReq(activityId, signUps)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingSignUpReq()

	req.activityId = activityId

	if signUps ~= nil then
		for i, v1 in ipairs(signUps) do
			local signUps = req.signUps:add()

			signUps.sessionId = v1.sessionId
			signUps.signUp = v1.signUp
		end
	end

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingSignUpRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleSignUp(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingBuyBuffReq(activityId, buffId, num)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingBuyBuffReq()

	req.activityId = activityId
	req.buffId = buffId
	req.num = num

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingBuyBuffRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleBuyBuff(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingRoomInfoReq(activityId, sessionId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingRoomInfoReq()

	req.activityId = activityId
	req.sessionId = sessionId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingRoomInfoRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetRoomInfo(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingRoomRecordReq(activityId, recordId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingRoomRecordReq()

	req.activityId = activityId
	req.recordId = recordId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingRoomRecordRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetBattleDetail(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingRecordLogReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingRecordLogReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingRecordLogRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetBattleRecord(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingRankInfoReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingRankInfoRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetRankInfo(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingPrizeInfoReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingPrizeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingPrizeInfoRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGetPrizeInfo(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingGainPrizeReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingGainPrizeRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleGainPrize(msg)
	end
end

function SurvivalKingAgent:sendPM_SurvivalKingUpgradeLevelBuffReq(activityId)
	local req = SurvivalKingExtension_pb.PM_SurvivalKingUpgradeLevelBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SurvivalKingAgent:handlePM_SurvivalKingUpgradeLevelBuffRes(status, msg)
	if status == 0 then
		SurvivalKingController.instance:handleUpgradeLevelBuff(msg)
	end
end

SurvivalKingAgent.instance = SurvivalKingAgent.New()

return SurvivalKingAgent
