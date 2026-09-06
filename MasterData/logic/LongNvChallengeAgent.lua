-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/LongNvChallengeAgent.lua

module("logic.extensions.longnvchallenge.agent.LongNvChallengeAgent", package.seeall)

local LongNvChallengeAgent = class("LongNvChallengeAgent", BaseAgent)

function LongNvChallengeAgent:ctor()
	return
end

function LongNvChallengeAgent:setExtId(extId)
	LongNvChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function LongNvChallengeAgent:sendPM_LNCGetMainBoardInfoReq()
	local req = LongNvChallengeExtension_pb.PM_LNCGetMainBoardInfoReq()

	self:sendMsg(req)
end

function LongNvChallengeAgent:handlePM_LNCGetMainBoardInfoRes(status, msg)
	if status == 0 then
		LongnvModel.instance:onGetInfo(msg)
	end
end

function LongNvChallengeAgent:sendPM_LNCGetChallengeBoardInfoReq()
	local req = LongNvChallengeExtension_pb.PM_LNCGetChallengeBoardInfoReq()

	self:sendMsg(req)
end

function LongNvChallengeAgent:handlePM_LNCGetChallengeBoardInfoRes(status, msg)
	if status == 0 then
		LongnvModel.instance:onGetFightInfo(msg)
	end
end

function LongNvChallengeAgent:sendPM_LNCGetChallengeInfoReq(type)
	local req = LongNvChallengeExtension_pb.PM_LNCGetChallengeInfoReq()

	req.type = type

	self:sendMsg(req)
end

function LongNvChallengeAgent:handlePM_LNCGetChallengeInfoRes(status, msg)
	if status == 0 then
		LongnvModel.instance:onGetChallengeInfoByType(msg)
	end
end

function LongNvChallengeAgent:sendPM_LNCChallengeStageReq(type, stage)
	local req = LongNvChallengeExtension_pb.PM_LNCChallengeStageReq()

	req.type = type
	req.stage = stage

	self:sendMsg(req)
end

function LongNvChallengeAgent:handlePM_LNCChallengeStageRes(status, msg)
	if status == 0 then
		-- block empty
	else
		LongnvModel.instance:onChallengeError(status, msg)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function LongNvChallengeAgent:sendPM_LNCSweepReq()
	local req = LongNvChallengeExtension_pb.PM_LNCSweepReq()

	self:sendMsg(req)
end

function LongNvChallengeAgent:handlePM_LNCSweepRes(status, msg)
	if status == 0 then
		LongnvModel.instance:onSweep(msg)
	end
end

function LongNvChallengeAgent:sendPM_LNCBuyChallengeTimesReq()
	local req = LongNvChallengeExtension_pb.PM_LNCBuyChallengeTimesReq()

	self:sendMsg(req)
end

function LongNvChallengeAgent:handlePM_LNCBuyChallengeTimesRes(status, msg)
	if status == 0 then
		LongnvModel.instance:onBuyTimes(msg)
	end
end

function LongNvChallengeAgent:handlePM_LNCChallengeEndRes(status, msg)
	LongnvModel.instance:onChallengeEndRes(msg)
end

LongNvChallengeAgent.instance = LongNvChallengeAgent.New()

return LongNvChallengeAgent
