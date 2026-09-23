ChatProto = {}

--获取聊天历史
function ChatProto:GetInfo(_type)
	local proto = {"ChatProto:GetInfo", {type = _type}}
	NetMgr.net:Send(proto)
end

function ChatProto:GetInfoRet(proto)
	ChatMgr:GetInfoRet(proto)
end

--发送聊天
function ChatProto:SendMsg(_info)
	local proto = {"ChatProto:SendMsg", {info = _info}}
	NetMgr.net:Send(proto)
end

function ChatProto:SendMsgRet()
	--ChatProto:GetInfo(ChatType.World)
end

--收到聊天消息
function ChatProto:RecvMsg(_infos)
    ChatMgr:RecvMsg(_infos)
end