-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/rpc/Activity116Rpc.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.rpc.Activity116Rpc", package.seeall)

local Activity116Rpc = class("Activity116Rpc", BaseRpc)

function Activity116Rpc:sendGet116InfosRequest()
	local req = Activity116Module_pb.Get116InfosRequest()

	req.activityId = VersionActivity1_2Enum.ActivityId.Building

	self:sendMsg(req)
end

function Activity116Rpc:onReceiveGet116InfosReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveGet116InfosReply(msg)
	end
end

function Activity116Rpc:onReceiveAct116InfoUpdatePush(resultCode, msg)
	VersionActivity1_2DungeonModel.instance:onReceiveAct116InfoUpdatePush(msg)
end

function Activity116Rpc:sendUpgradeElementRequest(elementId)
	local req = Activity116Module_pb.UpgradeElementRequest()

	req.activityId = VersionActivity1_2Enum.ActivityId.Building
	req.elementId = elementId

	self:sendMsg(req)
end

function Activity116Rpc:onReceiveUpgradeElementReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveUpgradeElementReply(msg)
	end
end

function Activity116Rpc:sendBuildTrapRequest(trapId)
	local req = Activity116Module_pb.BuildTrapRequest()

	req.activityId = VersionActivity1_2Enum.ActivityId.Building
	req.trapId = trapId

	self:sendMsg(req)
end

function Activity116Rpc:onReceiveBuildTrapReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity1_2DungeonModel.instance:onReceiveBuildTrapReply(msg)
	end
end

function Activity116Rpc:sendPutTrapRequest(trapId)
	local req = Activity116Module_pb.PutTrapRequest()

	req.activityId = VersionActivity1_2Enum.ActivityId.Building
	req.trapId = trapId

	self:sendMsg(req)
end

function Activity116Rpc:onReceivePutTrapReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity1_2DungeonModel.instance:onReceivePutTrapReply(msg)
	end
end

Activity116Rpc.instance = Activity116Rpc.New()

return Activity116Rpc
