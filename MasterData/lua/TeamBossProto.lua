TeamBoss = {}

--房间列表 true:未开始的战斗的房间 false：我参加过的房间
function TeamBoss:Rooms(_isStarting)
	_isStarting = _isStarting == nil and true or _isStarting
	local proto = {"TeamBoss:Rooms", {isStarting = _isStarting}}
	NetMgr.net:Send(proto)
end
function TeamBoss:RoomsRet(proto)
	TeamBossMgr:InitInfos(proto)
	if(proto.isFinish) then
		EventMgr.Dispatch(EventType.TeamBoss_List)
	end
end

--房间更新（广播）
function TeamBoss:RoomUpdate(proto)
	TeamBossMgr:UpdateRoomInfo(proto.room, proto.isStarting)
	EventMgr.Dispatch(EventType.TeamBoss_Room_Update, proto.room)
	if(proto.room.state == TeamBossRoomState.Win or proto.room.state == TeamBossRoomState.Lost) then
		--状态改变
		EventMgr.Dispatch(EventType.TeamBoss_List)
	end
end

--创建房间
function TeamBoss:RoomCreate(_cfgid	, _ix, _isInvite)
	local proto = {"TeamBoss:RoomCreate", {cfgid = _cfgid, ix = _ix, isInvite = _isInvite}}
	NetMgr.net:Send(proto)
end
function TeamBoss:RoomCreateRet(proto)
	TeamBossMgr:AddRoom(proto.room)
	--进入房间
	CSAPI.OpenView("TeamBossPrepare", proto.room.id)
end

--申请加入房间(广播) 
function TeamBoss:JoinRoom(_id, _TeamBossJoinRoomCB)
	if(self.TeamBossJoinRoomCB ~= nil) then
		return  --当前已有一个申请
	end
	self.TeamBossJoinRoomCB = _TeamBossJoinRoomCB
	local proto = {"TeamBoss:JoinRoom", {id = _id}}
	NetMgr.net:Send(proto)
end
--加入成功会先推送TeamBossRoomUpdate给所有人，再返回以下
function TeamBoss:JoinRoomRet(proto)
	if(self.TeamBossJoinRoomCB) then
		self.TeamBossJoinRoomCB(proto.isOk, proto.id)
	end
	if(proto.isOk) then
		CSAPI.OpenView("TeamBossPrepare", proto.id)
	end
	self.TeamBossJoinRoomCB = nil
end

--邀请
function TeamBoss:RoomInvite(_uid, _id)
	local proto = {"TeamBoss:RoomInvite", {uid = _uid, id = _id}}
	NetMgr.net:Send(proto)
end
function TeamBoss:RoomInviteRet(proto)
	TeamBossMgr:RoomInviteRet(proto)
	EventMgr.Dispatch(EventType.TeamBoss_Invite_Update, proto)
end

--收到邀请
function TeamBoss:RoomBeInvite(proto)
	TeamBossMgr:RoomBeInvite(proto)
end

--应答邀请（接受：TeamBossJoinRoomRet）
function TeamBoss:RoomBeInviteRet(_uid, _id, _receive)
	local proto = {"TeamBoss:RoomBeInviteRet", {uid = _uid, id = _id, receive = _receive}}
	NetMgr.net:Send(proto)
end

--准备
function TeamBoss:Prepare(_id, _state)
	local proto = {"TeamBoss:Prepare", {id = _id, state = _state}}
	NetMgr.net:Send(proto)
end
function TeamBoss:PrepareRet(proto)
	--返回房间更新
end

--进入战斗（加入已开始的房间时可进行该操作）
function TeamBoss:Start(_id, _startCB)
	self.startCB = _startCB
	local proto = {"TeamBoss:Start", {id = _id}}
	NetMgr.net:Send(proto)
end
function TeamBoss:StartRet(proto)
	if(self.startCB and not proto.isOk) then
		self.startCB() --如果进入成功则一直锁屏，不调用该回调
	end
	self.startCB = nil
end

--离开房间
function TeamBoss:LeaveRoom(_id)
	local proto = {"TeamBoss:LeaveRoom", {id = _id}}
	NetMgr.net:Send(proto)
end
--离开房间（广播） --不推送TeamBossRoomUpdate
function TeamBoss:LeaveRoomRet(proto)
	TeamBossMgr:LeaveRoomRet(proto)
	
	EventMgr.Dispatch(EventType.TeamBoss_Room_Leave, proto)
end

--开始倒计时
function TeamBoss:CountDown(proto)
	EventMgr.Dispatch(EventType.TeamBoss_Room_Start, proto)
end

--活动结束
function TeamBoss:TimeOutClose()
	--清数据 
	TeamBossMgr:Clear()
	EventMgr.Dispatch(EventType.TeamBoss_Over)
end 