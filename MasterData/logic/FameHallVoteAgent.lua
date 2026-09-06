-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehallvote/agent/FameHallVoteAgent.lua

module("logic.extensions.famehallvote.agent.FameHallVoteAgent", package.seeall)

local FameHallVoteAgent = class("FameHallVoteAgent", BaseAgent)

function FameHallVoteAgent:sendPM_FameHallVoteGetInfoReq(activityId)
	local req = FameHallVoteExtension_pb.PM_FameHallVoteGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FameHallVoteAgent:handlePM_FameHallVoteGetInfoRes(status, msg)
	if status == 0 then
		FameHallVoteController.instance:handlePM_FameHallVoteGetInfoRes(msg)
	end
end

function FameHallVoteAgent:sendPM_FameHallVoteReq(activityId, voteUserId)
	local req = FameHallVoteExtension_pb.PM_FameHallVoteReq()

	req.activityId = activityId
	req.voteUserId = voteUserId

	self:sendMsg(req)
end

function FameHallVoteAgent:handlePM_FameHallVoteRes(status, msg)
	if status == 0 then
		FameHallVoteController.instance:handlePM_FameHallVoteRes(msg)
	end
end

function FameHallVoteAgent:sendPM_FameHallVoteGainPrizeReq(activityId, prizeId)
	local req = FameHallVoteExtension_pb.PM_FameHallVoteGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function FameHallVoteAgent:handlePM_FameHallVoteGainPrizeRes(status, msg)
	if status == 0 then
		FameHallVoteController.instance:handlePM_FameHallVoteGainPrizeRes(msg)
	end
end

FameHallVoteAgent.instance = FameHallVoteAgent.New()

return FameHallVoteAgent
