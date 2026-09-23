--特殊勘探协议
PermitProto={}

function PermitProto:GetInfo(id)
    local proto = {"PermitProto:GetInfo",{id=id}}
    NetMgr.net:Send(proto)
end

function PermitProto:GetInfoRet(proto)
    ExplorationMgr:UpdateExInfo(proto);
    EventMgr.Dispatch(EventType.SpecialExploration_Info_Ret)
end

function PermitProto:GetReward(id,index)
    local proto = {"PermitProto:GetReward",{id=id,index=index}}
    NetMgr.net:Send(proto)
end

function PermitProto:GetRewardRet(proto)
    if proto then
        ExplorationMgr:UpdateExRewardInfo(proto);
    end
    EventMgr.Dispatch(EventType.SpecialExploration_Revice_Ret)
end