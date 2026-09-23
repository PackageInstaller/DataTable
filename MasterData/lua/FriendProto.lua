FriendProto = {
	assitInfoReturn = nil,
}

----------------------------------好友--------------------------------------
--好友添加通知
function FriendProto:FriendAdd(proto)
	FriendMgr:FriendAdd(proto)
end
--好友刷新通知
function FriendProto:FriendFlush(proto)
	FriendMgr:FriendFlush(proto)
end
--查看协战信息返回
function FriendProto:HelpFigtInfoRet(proto)
	FriendMgr:HelpFigtInfoRet(proto)
end
--查看卡牌信息
function FriendProto:HelpFightCard(uid, cid, func)
	self.getHelpFriendCardCall = func;
	local proto = {"FriendProto:HelpFightCard", {uid = uid, cid = cid}};
	NetMgr.net:Send(proto);
end

--查看卡牌信息返回
function FriendProto:HelpFightCardRet(proto)
	Log("-------------------FriendProto:HelpFightCardRet--------------");
	Log(proto);
	if self.getHelpFriendCardCall then
		self.getHelpFriendCardCall(proto)
		self.getHelpFriendCardCall = nil;
	end
	--FriendMgr:HelpFightCardRet(proto)
end
--搜索好友返回
function FriendProto:SearchRet(proto)
	FriendMgr:SearchRet(proto)
end
--修改玩家状态返回
function FriendProto:OpRet(proto)
	FriendMgr:OpRet(proto)
end
--修改玩家名称返回
function FriendProto:AliasRet(proto)
	FriendMgr:AliasRet(proto)
end
--获取推荐返回
function FriendProto:GetRecomendRet(proto)
	FriendMgr:GetRecomendRet(proto)
end
--发送信息返回
function FriendProto:SendMsgRet(proto)
	ChatMgr:SendMsgRet(proto)
end
--消息通知
function FriendProto:RecvNotice(proto)
	ChatMgr:RecvNotice(proto)
end

--获取协战信息
function FriendProto:GetAssitInfo(uid, callBack)
	self.assitInfoReturn = callBack;
	local proto = {"FriendProto:GetAssitInfo", {uid = uid}};
	NetMgr.net:Send(proto);
	UIUtil:AddNetWeakHandle(500);
end

--协战信息添加
function FriendProto:AssitInfoAdd(proto)
	if self.assitInfoReturn then
		self.assitInfoReturn(proto);
		self.assitInfoReturn = nil;
	else
		FriendMgr:OnAssitInfoAdd(proto);
	end
	EventMgr.Dispatch(EventType.Team_AssistInfo_Init);
end

--获取玩家面板信息返回
function FriendProto:FriendPaneInfoRet(proto)
	FriendMgr:FriendPaneInfoRet(proto)
end

--返回好友指定的助战卡牌数据
function FriendProto:GetFriendCard(uid, cids, ix, func)
	self.getFriendCardCall = func;
	local proto = {"FriendProto:GetFriendCard", {uid = uid, cids = cids, ix = ix}};
	NetMgr.net:Send(proto);
end

function FriendProto:GetFriendCardRet(proto)
	Log("-------------------FriendProto:GetFriendCardRet--------------");
	Log(proto);
	if self.getFriendCardCall then
		self.getFriendCardCall(proto)
		self.getFriendCardCall = nil;
	end
end 