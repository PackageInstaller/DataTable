ShareProto={}
---4901分享发送   返回 ClientProto:RewardNotice 和 PlayerProto:ItemUpdate
function ShareProto:AddShareCount(msg)
    local proto = {"ShareProto:AddShareCount", msg};
    NetMgr.net:Send(proto);
end
-----4902  首次分享奖励 (没用 已经被服务端删除)
--function ShareProto:FirstShareRet(proto)
--    Log("首次分享奖励返回")
--    Log(proto)
--end