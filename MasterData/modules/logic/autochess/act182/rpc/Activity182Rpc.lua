-- chunkname: @modules/logic/autochess/act182/rpc/Activity182Rpc.lua

module("modules.logic.autochess.act182.rpc.Activity182Rpc", package.seeall)

local Activity182Rpc = class("Activity182Rpc", BaseRpc)

function Activity182Rpc:sendGetAct182InfoRequest(activityId, callback, callbackObj)
	local req = Activity182Module_pb.GetAct182InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveGetAct182InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(msg.act182Info)
end

function Activity182Rpc:onReceiveAct182InfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(msg.act182Info)
end

function Activity182Rpc:sendGetAct182RandomMasterRequest(activityId)
	local req = Activity182Module_pb.GetAct182RandomMasterRequest()

	req.activityId = activityId

	self:sendMsg(req)
end

function Activity182Rpc:onReceiveGetAct182RandomMasterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actMo = Activity182Model.instance:getActMo()
	local gameMo = actMo:getGameMo(msg.activityId, AutoChessEnum.ModuleId.PVP)

	gameMo:updateMasterIdBox(msg.masterId)
	Activity182Controller.instance:dispatchEvent(Activity182Event.RandomMasterReply)
end

function Activity182Rpc:sendAct182RefreshMasterRequest(activityId, callback, callbackObj)
	local req = Activity182Module_pb.Act182RefreshMasterRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182RefreshMasterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actMo = Activity182Model.instance:getActMo()
	local gameMo = actMo:getGameMo(msg.activityId, AutoChessEnum.ModuleId.PVP)

	gameMo:updateMasterIdBox(msg.masterId, true)
end

function Activity182Rpc:sendAct182RefreshBossRequest(activityId, callback, callbackObj)
	local req = Activity182Module_pb.Act182RefreshBossRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182RefreshBossReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Activity182Model.instance:getActMo()
	local gameMo = mo:getGameMo(msg.activityId, AutoChessEnum.ModuleId.PVP)

	gameMo:updateBossId(msg.bossId)
	Activity182Controller.instance:dispatchEvent(Activity182Event.RefreshBossReply)
end

function Activity182Rpc:sendAct182ChooseCardpackRequest(activityId, cardpackId, callback, callbackObj)
	local req = Activity182Module_pb.Act182ChooseCardpackRequest()

	req.activityId = activityId
	req.cardpackId = cardpackId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182ChooseCardpackReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Activity182Model.instance:getActMo()
	local gameMo = mo:getGameMo(msg.activityId, AutoChessEnum.ModuleId.PVP)

	gameMo:updateCardPackId(msg.cardpackId)
	gameMo:updateMasterIdBox(msg.masterIds)
end

function Activity182Rpc:sendAct182SaveSnapshotRequest(activityId, callback, callbackObj)
	local req = Activity182Module_pb.Act182SaveSnapshotRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182SaveSnapshotReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Activity182Model.instance:getActMo(msg.activityId)

	mo:updateSnapshot(msg.snapshot)
end

function Activity182Rpc:sendAct182GetHasSnapshotFriendRequest(activityId, callback, callbackObj)
	local req = Activity182Module_pb.Act182GetHasSnapshotFriendRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182GetHasSnapshotFriendReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Activity182Model.instance:getActMo(msg.activityId)

	mo:updateFriendInfoList(msg.friendPlayerInfo)
	mo:updateFriendSnapshot(msg.snapshot)
end

function Activity182Rpc:sendAct182GetFriendSnapshotsRequest(activityId, friendUserId, callback, callbackObj)
	local req = Activity182Module_pb.Act182GetFriendSnapshotsRequest()

	req.activityId = activityId
	req.friendUserId = friendUserId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182GetFriendSnapshotsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Activity182Model.instance:getActMo(msg.activityId)

	mo:updateFriendSnapshot(msg.snapshots)
end

function Activity182Rpc:sendAct182GetFriendFightRecordsRequest(activityId, callback, callbackObj)
	local req = Activity182Module_pb.Act182GetFriendFightRecordsRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182GetFriendFightRecordsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local mo = Activity182Model.instance:getActMo(msg.activityId)

	mo:updateFriendFightRecords(msg.fightRecords)
end

function Activity182Rpc:sendAct182GetFriendFightMessageRequest(activityId, friendUserId, uid, callback, callbackObj)
	local req = Activity182Module_pb.Act182GetFriendFightMessageRequest()

	req.activityId = activityId
	req.friendUserId = friendUserId
	req.uid = uid

	self:sendMsg(req, callback, callbackObj)
end

function Activity182Rpc:onReceiveAct182GetFriendFightMessageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	AutoChessModel.instance:enterSceneReply(AutoChessEnum.ModuleId.Friend, msg.scene)

	local mo = AutoChessModel.instance:getChessMo()

	if mo then
		mo:cacheSvrFight()
		mo:updateSvrTurn(msg.turn)
		mo:cacheSvrFight()
		AutoChessController.instance:enterSingleGame()
	end
end

Activity182Rpc.instance = Activity182Rpc.New()

return Activity182Rpc
