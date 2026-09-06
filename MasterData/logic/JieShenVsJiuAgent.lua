-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/agent/JieShenVsJiuAgent.lua

module("logic.extensions.jieshenvsjiu.agent.JieShenVsJiuAgent", package.seeall)

local JieShenVsJiuAgent = class("JieShenVsJiuAgent", BaseAgent)

function JieShenVsJiuAgent:sendPM_JieShenVsJiuGetInfoReq(activityId)
	local req = JieShenVsJiuExtension_pb.PM_JieShenVsJiuGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function JieShenVsJiuAgent:handlePM_JieShenVsJiuGetInfoRes(status, msg)
	if status == 0 then
		JieShenVsJiuModel.instance:onJieShenVsJiuGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JieShenVsJiuGetInfoRes)
	end
end

function JieShenVsJiuAgent:sendPM_JieShenVsJiuChooseTeamReq(activityId, teamId)
	local req = JieShenVsJiuExtension_pb.PM_JieShenVsJiuChooseTeamReq()

	req.activityId = activityId
	req.teamId = teamId

	self:sendMsg(req)
end

function JieShenVsJiuAgent:handlePM_JieShenVsJiuChooseTeamRes(status, msg)
	if status == 0 then
		JieShenVsJiuModel.instance:chooseMyTeamId(msg.activityId, msg.myTeamId)
		GlobalDispatcher:dispatch(GlobalNotify.JieShenVsJiuChooseTeamRes)
	end
end

function JieShenVsJiuAgent:sendPM_JieShenVsJiuStartGameReq(activityId, clientKey)
	local req = JieShenVsJiuExtension_pb.PM_JieShenVsJiuStartGameReq()

	req.activityId = activityId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function JieShenVsJiuAgent:handlePM_JieShenVsJiuStartGameRes(status, msg)
	if status == 0 then
		JieShenVsJiuModel.instance:onJieShenVsJiuStartGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JieShenVsJiuStartGameRes)
	end
end

function JieShenVsJiuAgent:sendPM_JieShenVsJiuEndGameReq(activityId, score, encryptedKey)
	local req = JieShenVsJiuExtension_pb.PM_JieShenVsJiuEndGameReq()

	req.activityId = activityId
	req.score = score
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function JieShenVsJiuAgent:handlePM_JieShenVsJiuEndGameRes(status, msg)
	if status == 0 then
		JieShenVsJiuModel.instance:onJieShenVsJiuEndGameRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JieShenVsJiuEndGameRes)
	end
end

function JieShenVsJiuAgent:sendPM_JieShenVsJiuGainPrizeReq(activityId, prizeId)
	local req = JieShenVsJiuExtension_pb.PM_JieShenVsJiuGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function JieShenVsJiuAgent:handlePM_JieShenVsJiuGainPrizeRes(status, msg)
	if status == 0 then
		JieShenVsJiuModel.instance:onJieShenVsJiuGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JieShenVsJiuGainPrizeRes)
	end
end

function JieShenVsJiuAgent:sendPM_JieShenVsJiuGainWorldProgressPrizeReq(activityId, prizeId)
	local req = JieShenVsJiuExtension_pb.PM_JieShenVsJiuGainWorldProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function JieShenVsJiuAgent:handlePM_JieShenVsJiuGainWorldProgressPrizeRes(status, msg)
	if status == 0 then
		JieShenVsJiuModel.instance:onJieShenVsJiuGainWorldProgressPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.JieShenVsJiuGainWorldProgressPrizeRes)
	end
end

JieShenVsJiuAgent.instance = JieShenVsJiuAgent.New()

return JieShenVsJiuAgent
