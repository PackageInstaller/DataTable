-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/LightDarkDragonAgent.lua

module("logic.extensions.lightdarkdragon.agent.LightDarkDragonAgent", package.seeall)

local LightDarkDragonAgent = class("LightDarkDragonAgent", BaseAgent)

function LightDarkDragonAgent:sendPM_LightDarkDragonInfoReq(activityId)
	local req = LightDarkDragonExtension_pb.PM_LightDarkDragonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LightDarkDragonAgent:handlePM_LightDarkDragonInfoRes(status, msg)
	if status == 0 then
		ShikongshenglongModel.instance:getInfos(msg)
	end
end

function LightDarkDragonAgent:sendPM_LightDarkDragonChallengeReq(activityId)
	local req = LightDarkDragonExtension_pb.PM_LightDarkDragonChallengeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LightDarkDragonAgent:handlePM_LightDarkDragonChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function LightDarkDragonAgent:sendPM_LightDarkDragonGetBuffReq(activityId)
	local req = LightDarkDragonExtension_pb.PM_LightDarkDragonGetBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LightDarkDragonAgent:handlePM_LightDarkDragonGetBuffRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function LightDarkDragonAgent:sendPM_LightDarkDragonSweepReq(activityId, stageId)
	ShikongshenglongModel.instance:setCurSweepId(stageId)

	local req = LightDarkDragonExtension_pb.PM_LightDarkDragonSweepReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function LightDarkDragonAgent:handlePM_LightDarkDragonSweepRes(status, msg)
	if status == 0 then
		ShikongshenglongModel.instance:setCurHaveSweep()
	end
end

function LightDarkDragonAgent:sendPM_LightDarkDragonGainDailySignPrizeReq(activityId)
	local req = LightDarkDragonExtension_pb.PM_LightDarkDragonGainDailySignPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LightDarkDragonAgent:handlePM_LightDarkDragonGainDailySignPrizeRes(status, msg)
	if status == 0 then
		local curdailysignid = msg.curDailySignId

		ShikongshenglongModel.instance:setCurSignInfo(curdailysignid)
	end
end

function LightDarkDragonAgent:handlePM_NotifyLightDarkDragonChallengeResultRes(status, msg)
	if status == 0 then
		local activityid = msg.activityId
		local iswin = msg.isWin

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)

		if iswin then
			ShikongshenglongController.instance:sendGetInfos(activityid)
		end
	end
end

LightDarkDragonAgent.instance = LightDarkDragonAgent.New()

return LightDarkDragonAgent
