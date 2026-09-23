require "ChatData"
local this = MgrRegister("ChatMgr")

function this:Init()
	self:Clear()
	self.typeDatas[ChatType.World] = {} --初始化后就能获取世界聊天		
end

function this:Clear()
	self.infoDatas = {}
	self.typeDatas = {}
	self.curType = 0
	self.friendUids = {}
	self.currUid = 0
end

--获取聊天历史回调
function this:GetInfoRet(proto)
	-- LogError("获取聊天历史")
	-- LogError(proto)
	local datas = {}
	if(proto.infos and #proto.infos > 0) then
		for i, v in ipairs(proto.infos) do
			local isSelf = v.uid == PlayerClient:GetUid()
			self:SetMsg(v, isSelf)	
			if(i == g_ChatCacheCnt) then
				break
			end					
		end
		self.typeDatas[proto.infos[1].type] = self:GetTypeData(proto.infos[1].type)	
		datas = self.typeDatas[proto.infos[1].type]
	end	
	EventMgr.Dispatch(EventType.Chat_UpdateInfos, datas)
end

--获取聊天历史
function this:GetInfo(_type)
	if(not _type) then
		LogError("数据类型为空！")
		return
	end
	
	self.curType = _type
	if not self.typeDatas[_type] then --第一次获取时
		self:ClearMsg(_type)		
		ChatProto:GetInfo(_type)		
	else
		local typeData = self:GetTypeData(_type) --从本地获取
		EventMgr.Dispatch(EventType.Chat_UpdateInfos, typeData)
	end
end

--获取类型数据
function this:GetTypeData(_type)
	if not self.typeDatas[_type] then
		if self.curType == ChatType.Friend then --第一次获取好友数据时删除旧有本地数据
			self:ClearMsg(_type)
		end
		local infoDatas = self:GetMsg(_type)
		local typeDatas = {}
		for i, v in ipairs(infoDatas) do
			local data = ChatData.New()
			data:SetData(v)
			table.insert(typeDatas, data)
		end
		self.typeDatas[_type] = typeDatas
	end
	return self.typeDatas[_type]
end

--收到聊天消息
function this:RecvMsg(proto)
	--LogError("收到新消息")
	if(proto.infos) then
		for i, v in ipairs(proto.infos) do --整理消息，尚未获取本地信息的不需要整理
			if self.typeDatas[v.type] then
				local _isSelf = PlayerClient:GetUid() == v.uid	
				self:SetChatInfo(v, _isSelf)	
				if v.type == ChatType.World then --主界面信息更新
					EventMgr.Dispatch(EventType.Chat_NewInfo_Menu, {name = v.name, content = v.content})
				end	
			end				
		end
		EventMgr.Dispatch(EventType.Chat_UpdateInfos, self.typeDatas[self.curType]) --刷新界面
	end		
end

--发送消息
function this:SendMsg(data)
	--LogError("发送消息!")
	if(data == nil) then
		LogError("没有数据传入!")
		return
	end	
	if(self.curType == ChatType.Notice) then --无法发送公告频道
		return
	end
	if(self.curType == ChatType.Friend) then
		local proto = {"FriendProto:SendMsg", {uid = data.uids[1], msg = data.content}}
		NetMgr.net:Send(proto)
	else
		ChatProto:SendMsg(data)
	end
end

--设置聊天信息
function this:SetChatInfo(_info, _isSelf)
	self:SetMsg(_info, _isSelf)	
	local typeDatas = self.typeDatas[_info.type]
	local data = ChatData.New()
	data:SetData({data = _info, isSelf = _isSelf})
	table.insert(typeDatas, 1, data)
	if #typeDatas > g_ChatCacheCnt then
		table.remove(typeDatas, #typeDatas)
	end
	self.typeDatas[_info.type] = typeDatas			
end

--保存本地信息
function this:SetMsg(info, _isSelf)
	local infoDatas = self:GetMsg(info.type)
	info.content = MsgParser:getString(info.content)
	table.insert(infoDatas, {data = info, isSelf = _isSelf})
	if(#self.infoDatas > g_ChatCacheCnt) then --超过100条消息的删除末尾
		table.remove(infoDatas, #infoDatas)
	end
	self.infoDatas[info.type] = infoDatas
	FileUtil.SaveToFile(info.type .. "Chat.txt", infoDatas)
end

--获取本地信息
function this:GetMsg(_type)
	if(not self.infoDatas[_type]) then
		local oldDatas = FileUtil.LoadByPath(_type .. "Chat.txt")		
		self.infoDatas[_type] = oldDatas or {}
	end
	return self.infoDatas[_type]
end

--清空本地信息
function this:ClearMsg(_type)
	FileUtil.SaveToFile(_type .. "Chat.txt", {})
	self.infoDatas[_type] = nil
	self.typeDatas[_type] = nil
end

function this:GetCurType()
	return self.curType
end

--仅有好友发送信息返回
function this:SendMsgRet(proto)
	if proto then
		self:SetFriendInfo(proto, true)	
		--self:SetCurrFriend(proto.uid)
		EventMgr.Dispatch(EventType.Chat_UpdateInfos, self.typeDatas[self.curType]) --刷新界面
	end
end

--收到好友消息
function this:RecvNotice(proto)
	if proto then
		self:SetFriendInfo(proto, false)
		self:AddFriendUid(proto.uid)
		EventMgr.Dispatch(EventType.Chat_UpdateInfos, self.typeDatas[self.curType]) --刷新界面
	end
end

--设置好友数据
function this:SetFriendInfo(_proto, _isSelf)
	local _data = FriendMgr:GetData(_proto.uid)
	if not _data then
		--LogError("找到不到好友对应ID数据！" .. _proto.uid)
		return
	end
	if not _isSelf then
		_data:IsNewInfo(true)
	end	
	local info = {
		uid = _proto.uid,
		type = ChatType.Friend .. _proto.uid,
		content = _proto.msg,
		sTime = _proto.time,
		name = _data:GetName(),
		iconId = _data:GetIconId()
	}
	self:SetMsg(info, _isSelf)
	local typeDatas = self.typeDatas[info.type] or {}
	local data = ChatData.New()
	data:SetData({data = info, isSelf = _isSelf})
	table.insert(typeDatas, 1, data)
	if #typeDatas > g_ChatCacheCnt then
		table.remove(typeDatas, #typeDatas)
	end
	self.typeDatas[info.type] = typeDatas
end

--好友uid缓存
function this:AddFriendUid(_uid)
	self.friendUids = self.friendUids or {}
	if #self.friendUids > 0 then
		for i, v in ipairs(self.friendUids) do
			if v == _uid then	--已有则删除
				table.remove(self.friendUids, i)
				break
			end
		end
	end
	table.insert(self.friendUids, 1, _uid)
	if #self.friendUids > 4 then
		table.remove(self.friendUids, #self.friendUids)
	end
end

--推出好友uid
function this:PushFriendUid(_uid)
	self.friendUids = self.friendUids or {}
	for i, v in ipairs(self.friendUids) do
		if v == _uid then
			table.remove(self.friendUids, i)
			self.currUid = v
		end
	end
end

--获取好友uid组
function this:GetFriendUids()
	return self.friendUids
end

--设置当前好友uid
function this:SetCurrUid(_uid)
	self.currUid = _uid
end

--获取当前好友uid
function this:GetCurrUid()
	return self.currUid
end

return this 