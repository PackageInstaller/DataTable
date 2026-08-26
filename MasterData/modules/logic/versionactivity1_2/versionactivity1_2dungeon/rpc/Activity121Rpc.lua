-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/rpc/Activity121Rpc.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.rpc.Activity121Rpc", package.seeall)

local Activity121Rpc = class("Activity121Rpc", BaseRpc)

function Activity121Rpc:sendGet121InfosRequest()
	local req = Activity121Module_pb.Get121InfosRequest()

	req.activityId = VersionActivityEnum.ActivityId.Act121

	self:sendMsg(req)
end

function Activity121Rpc:onReceiveGet121InfosReply(resultCode, msg)
	VersionActivity1_2NoteModel.instance:onReceiveGet121InfosReply(resultCode, msg)
end

function Activity121Rpc:sendGet121BonusRequest(storyId)
	local req = Activity121Module_pb.Get121BonusRequest()

	req.activityId = VersionActivityEnum.ActivityId.Act121
	req.storyId = storyId

	self:sendMsg(req)
end

function Activity121Rpc:onReceiveGet121BonusReply(resultCode, msg)
	if resultCode == 0 then
		VersionActivity1_2NoteModel.instance:onReceiveGet121BonusReply(msg)
	end
end

function Activity121Rpc:onReceiveAct121UpdatePush(resultCode, msg)
	if resultCode == 0 then
		VersionActivity1_2NoteModel.instance:onReceiveAct121UpdatePush(msg)
	end
end

Activity121Rpc.instance = Activity121Rpc.New()

return Activity121Rpc
