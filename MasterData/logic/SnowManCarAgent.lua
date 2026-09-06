-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/agent/SnowManCarAgent.lua

module("logic.extensions.snowmancar.agent.SnowManCarAgent", package.seeall)

local SnowManCarAgent = class("SnowManCarAgent", BaseAgent)

function SnowManCarAgent:sendPM_SnowmanCarInfoReq(activityId)
	local req = SnowmanCarExtension_pb.PM_SnowmanCarInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SnowManCarAgent:handlePM_SnowmanCarInfoRes(status, msg)
	if status == 0 then
		SnowManCarModel.instance:onSnowmanCarInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SnowmanCarInfoRes)
	end
end

function SnowManCarAgent:sendPM_SnowmanCarStartReq(activityId, clientKey)
	local req = SnowmanCarExtension_pb.PM_SnowmanCarStartReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function SnowManCarAgent:handlePM_SnowmanCarStartRes(status, msg)
	if status == 0 then
		SnowManCarModel.instance:onSnowmanCarStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SnowmanCarStartRes)
	end
end

function SnowManCarAgent:sendPM_SnowmanCarEndReq(activityId, score, encryptedKey)
	local req = SnowmanCarExtension_pb.PM_SnowmanCarEndReq()

	req.activityId = activityId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function SnowManCarAgent:handlePM_SnowmanCarEndRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.SnowmanCarEndRes)
	end
end

function SnowManCarAgent:sendPM_SnowmanCarGainPrizeReq(activityId, prizeId)
	local req = SnowmanCarExtension_pb.PM_SnowmanCarGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SnowManCarAgent:handlePM_SnowmanCarGainPrizeRes(status, msg)
	if status == 0 then
		self:sendPM_SnowmanCarInfoReq(msg.activityId)
	end
end

SnowManCarAgent.instance = SnowManCarAgent.New()

return SnowManCarAgent
