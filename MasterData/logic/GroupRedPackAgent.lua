-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/agent/GroupRedPackAgent.lua

module("logic.extensions.groupredpack.agent.GroupRedPackAgent", package.seeall)

local GroupRedPackAgent = class("GroupRedPackAgent", BaseAgent)

function GroupRedPackAgent:sendPM_GroupRedPackGetInfoReq(actId)
	local req = GroupRedPackExtension_pb.PM_GroupRedPackGetInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function GroupRedPackAgent:handlePM_GroupRedPackGetInfoRes(status, msg)
	if status == 0 then
		GroupRedpackController.instance:handleGroupRedPackGetInfoRes(status, msg)
	end
end

function GroupRedPackAgent:sendPM_GroupRedPackGrapReq(actId, redPackId, type)
	local req = GroupRedPackExtension_pb.PM_GroupRedPackGrapReq()

	req.actId = actId
	req.redPackId = redPackId
	req.type = type

	self:sendMsg(req)
end

function GroupRedPackAgent:handlePM_GroupRedPackGrapRes(status, msg)
	if status == 0 then
		GroupRedpackController.instance:handleGroupRedPackGrapRes(status, msg)
	end
end

function GroupRedPackAgent:sendPM_GroupRedPackGetRecordsReq(actId)
	local req = GroupRedPackExtension_pb.PM_GroupRedPackGetRecordsReq()

	req.actId = actId

	self:sendMsg(req)
end

function GroupRedPackAgent:handlePM_GroupRedPackGetRecordsRes(status, msg)
	if status == 0 then
		GroupRedpackController.instance:handleGroupRedPackGetRecordsRes(status, msg)
	end
end

function GroupRedPackAgent:sendPM_GroupRedPackSendReq(actId, type, coverId, sloganId)
	local req = GroupRedPackExtension_pb.PM_GroupRedPackSendReq()

	req.actId = actId
	req.type = type
	req.coverId = checknumber(coverId)
	req.sloganId = checknumber(sloganId)

	self:sendMsg(req)
end

function GroupRedPackAgent:handlePM_GroupRedPackSendRes(status, msg)
	if status == 0 then
		GroupRedpackController.instance:handleGroupRedPackSendRes(status, msg)
	end
end

function GroupRedPackAgent:sendPM_GroupRedPackGetRankInfoReq(actId, groupId)
	local req = GroupRedPackExtension_pb.PM_GroupRedPackGetRankInfoReq()

	req.actId = actId
	req.groupId = groupId

	self:sendMsg(req)
end

function GroupRedPackAgent:handlePM_GroupRedPackGetRankInfoRes(status, msg)
	if status == 0 then
		GroupRedpackController.instance:handleGroupRedPackGetRankInfoRes(status, msg)
	end
end

function GroupRedPackAgent:handlePM_NotifyNewGroupRedPacksRes(status, msg)
	if status == 0 then
		GroupRedpackController.instance:handleNotifyNewGroupRedPacksRes(status, msg)
	end
end

GroupRedPackAgent.instance = GroupRedPackAgent.New()

return GroupRedPackAgent
