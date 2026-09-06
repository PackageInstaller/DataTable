-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/agent/SlackOffGameAgent.lua

module("logic.extensions.slackoffgame.agent.SlackOffGameAgent", package.seeall)

local SlackOffGameAgent = class("SlackOffGameAgent", BaseAgent)

function SlackOffGameAgent:sendPM_SlackOffGameInfoReq(activityId)
	local req = SlackOffGameExtension_pb.PM_SlackOffGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function SlackOffGameAgent:handlePM_SlackOffGameInfoRes(status, msg)
	if status == 0 then
		SlackOffGameModel.instance:onPM_SlackOffGameInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SlackOffGameInfoRes)
	end
end

function SlackOffGameAgent:sendPM_SlackOffGameStartReq(activityId, clientKey)
	local req = SlackOffGameExtension_pb.PM_SlackOffGameStartReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function SlackOffGameAgent:handlePM_SlackOffGameStartRes(status, msg)
	if status == 0 then
		SlackOffGameModel.instance:onPM_SlackOffGameStartRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.SlackOffGameStartRes)
	end
end

function SlackOffGameAgent:sendPM_SlackOffGameEndReq(activityId, isPass, studentIds_i32_Ary, encryptedKey)
	local req = SlackOffGameExtension_pb.PM_SlackOffGameEndReq()

	req.activityId = activityId
	req.isPass = isPass

	for i, v1 in ipairs(studentIds_i32_Ary) do
		req.studentIds:append(v1)
	end

	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function SlackOffGameAgent:handlePM_SlackOffGameEndRes(status, msg)
	if status == 0 then
		self:sendPM_SlackOffGameInfoReq(msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.SlackOffGameEndRes)
	end
end

function SlackOffGameAgent:sendPM_SlackOffGameGainPrizeReq(activityId, prizeId)
	local req = SlackOffGameExtension_pb.PM_SlackOffGameGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function SlackOffGameAgent:handlePM_SlackOffGameGainPrizeRes(status, msg)
	if status == 0 then
		self:sendPM_SlackOffGameInfoReq(msg.activityId)
	end
end

SlackOffGameAgent.instance = SlackOffGameAgent.New()

return SlackOffGameAgent
