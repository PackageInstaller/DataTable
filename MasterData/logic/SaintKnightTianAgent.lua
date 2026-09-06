-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttian/agent/SaintKnightTianAgent.lua

module("logic.extensions.saintknighttian.agent.SaintKnightTianAgent", package.seeall)

local SaintKnightTianAgent = class("SaintKnightTianAgent", BaseAgent)

function SaintKnightTianAgent:sendPM_SaintKnightTianGetInfoReq(activityId)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianGetInfoRes(status, msg)
	if status == 0 then
		SaintKnightTianController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SKTianError, status)
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianPlayStageReq(activityId, stageId, simpleForm)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianPlayStageReq()

	req.activityId = activityId
	req.stageId = stageId

	if simpleForm ~= nil then
		req.simpleForm:ParseFromString(simpleForm:SerializeToString())
	end

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianPlayStageRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
		GlobalDispatcher:dispatch(GlobalNotify.SKTianError, status)
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianGetFormReq(activityId, stageId)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianGetFormReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianGetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianSetFormReq(activityId, stageId, simpleForm)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianSetFormReq()

	req.activityId = activityId
	req.stageId = stageId
	req.simpleForm = simpleForm

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianSetFormRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianGetPrizeReq(activityId, prizeId)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianGetPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianGetPrizeRes(status, msg)
	if status == 0 then
		SaintKnightTianController.instance:handleGetPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SKTianError, status)
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianGetGamePrizeReq(activityId, prizeId)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianGetGamePrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianGetGamePrizeRes(status, msg)
	if status == 0 then
		SaintKnightTianController.instance:handleGetGamePrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SKTianError, status)
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianStartGameReq(clientKey)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianStartGameReq()

	req.clientKey = clientKey

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianStartGameRes(status, msg)
	if status == 0 then
		SaintKnightTianController.instance:handleStartGame(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SKTianError, status)
	end
end

function SaintKnightTianAgent:sendPM_SaintKnightTianEndGameReq(shovelNums, encryptedKey)
	local req = SaintKnightTianExtension_pb.PM_SaintKnightTianEndGameReq()

	req.shovelNums = shovelNums
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function SaintKnightTianAgent:handlePM_SaintKnightTianEndGameRes(status, msg)
	if status == 0 then
		SaintKnightTianController.instance:handleSettleGame(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SKTianError, status)
	end
end

SaintKnightTianAgent.instance = SaintKnightTianAgent.New()

return SaintKnightTianAgent
