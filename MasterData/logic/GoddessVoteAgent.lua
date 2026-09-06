-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/agent/GoddessVoteAgent.lua

module("logic.extensions.goddessvote.agent.GoddessVoteAgent", package.seeall)

local GoddessVoteAgent = class("GoddessVoteAgent", BaseAgent)

function GoddessVoteAgent:sendPM_GVGetInfoReq(activityId)
	local req = GoddessVoteExtension_pb.PM_GVGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GoddessVoteAgent:handlePM_GVGetInfoRes(status, msg)
	if status == 0 then
		GoddessVoteController.instance:scPushGVGetInfo(msg)
	end
end

function GoddessVoteAgent:sendPM_GVBuyVoteItemReq(activityId, count)
	local req = GoddessVoteExtension_pb.PM_GVBuyVoteItemReq()

	req.activityId = activityId
	req.count = count

	self:sendMsg(req)
end

function GoddessVoteAgent:handlePM_GVBuyVoteItemRes(status, msg)
	if status == 0 then
		GoddessVoteController.instance:scPushGVBuyVoteItem(msg)
	end
end

function GoddessVoteAgent:sendPM_GVVoteReq(activityId, raceId)
	local req = GoddessVoteExtension_pb.PM_GVVoteReq()

	req.activityId = activityId
	req.raceId = raceId

	self:sendMsg(req)
end

function GoddessVoteAgent:handlePM_GVVoteRes(status, msg)
	if status == 0 then
		GoddessVoteController.instance:scPushGVVote(msg)
	end
end

GoddessVoteAgent.instance = GoddessVoteAgent.New()

return GoddessVoteAgent
