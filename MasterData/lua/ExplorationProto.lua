--勘探协议
ExplorationProto={}

function ExplorationProto:GetInfo(id)
    local proto = {"ExplorationProto:GetInfo", {id=id}}
	NetMgr.net:Send(proto);
end

function ExplorationProto:GetInfoRet(proto)
    ExplorationMgr:SetCurrData(proto);
end

function ExplorationProto:Update(proto)
    ExplorationMgr:Update(proto);
end

function ExplorationProto:GetReward(id,rid,ix)
    local proto = {"ExplorationProto:GetReward", {id=id,rid=rid,ix=ix}}
	NetMgr.net:Send(proto);
end

function ExplorationProto:GetRewardRet(proto)
    ExplorationMgr:OnRewardRet(proto);
end

function ExplorationProto:Upgrade(id,lv)
    local proto = {"ExplorationProto:Upgrade", {id=id,lv=lv}}
	NetMgr.net:Send(proto);
end

function ExplorationProto:UpgradeRet(proto)
    ExplorationMgr:OnUpgradeRet(proto);
end

function ExplorationProto:Open(id,type)
    local proto = {"ExplorationProto:Open", {id=id,type=type}}
	NetMgr.net:Send(proto);
end

function ExplorationProto:OpenRet(proto)
    ExplorationMgr:OnOpenRet(proto);
end

function ExplorationProto:GetTaskResetTime()
    local proto = {"ExplorationProto:GetTaskResetTime"}
	NetMgr.net:Send(proto);
end

function ExplorationProto:GetTaskResetTimeRet(proto)
    EventMgr.Dispatch(EventType.Exploration_TaskTime_Ret,proto)
end