-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/agent/LinkGameAgent.lua

module("logic.extensions.linkgame.agent.LinkGameAgent", package.seeall)

local LinkGameAgent = class("LinkGameAgent", BaseAgent)

LinkGameAgent.handlePM_LinkGameInfoRes = "LinkGameAgent.handlePM_LinkGameInfoRes"
LinkGameAgent.handlePM_LinkGameStartGameRes = "LinkGameAgent.handlePM_LinkGameStartGameRes"
LinkGameAgent.handlePM_LinkGameEndGameRes = "LinkGameAgent.handlePM_LinkGameEndGameRes"
LinkGameAgent.handlePM_LinkGameRankRes = "LinkGameAgent.handlePM_LinkGameRankRes"

function LinkGameAgent:sendPM_LinkGameInfoReq(activityId)
	local req = LinkGameExtension_pb.PM_LinkGameInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LinkGameAgent:handlePM_LinkGameInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LinkGameAgent.handlePM_LinkGameInfoRes, msg)
	end
end

function LinkGameAgent:sendPM_LinkGameStartGameReq(activityId, stageId, clientKey)
	local req = LinkGameExtension_pb.PM_LinkGameStartGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.clientKey = clientKey

	self:sendMsg(req)
end

function LinkGameAgent:handlePM_LinkGameStartGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LinkGameAgent.handlePM_LinkGameStartGameRes, msg)
	end
end

function LinkGameAgent:sendPM_LinkGameEndGameReq(activityId, stageId, isPass, stepNum, encryptedKey)
	local req = LinkGameExtension_pb.PM_LinkGameEndGameReq()

	req.activityId = activityId
	req.stageId = stageId
	req.isPass = isPass
	req.stepNum = stepNum
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function LinkGameAgent:handlePM_LinkGameEndGameRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LinkGameAgent.handlePM_LinkGameEndGameRes, msg)
	end
end

function LinkGameAgent:sendPM_LinkGameRankReq(activityId)
	local req = LinkGameExtension_pb.PM_LinkGameRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LinkGameAgent:handlePM_LinkGameRankRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(LinkGameAgent.handlePM_LinkGameRankRes, msg)
	end
end

LinkGameAgent.instance = LinkGameAgent.New()

return LinkGameAgent
