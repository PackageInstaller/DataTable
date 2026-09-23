CrossBossProto = {};

-- 获取全服boss数据
function CrossBossProto:GetData()
    local proto = {"CrossBossProto:GetData"}
    NetMgr.net:Send(proto)
end

function CrossBossProto:GetDataRet(proto)
    VirCatMgr:SetDatas(proto)
end

-- 节点更新推送
function CrossBossProto:NodeStatePush(proto)
    VirCatMgr:UpdateNodes(proto)
end

-- 请求选择最终boss词条
function CrossBossProto:ChooseFinalBuff(actId, buffId, callBack)
    self.chooseFinalBuffCallBack = callBack
    local proto = {"CrossBossProto:ChooseFinalBuff", {
        actId = actId,
        buffId = buffId
    }}
    NetMgr.net:Send(proto)
end

function CrossBossProto:ChooseFinalBuffRet(proto)
    if self.chooseFinalBuffCallBack then
        self.chooseFinalBuffCallBack(proto)
        self.chooseFinalBuffCallBack = nil
    end
end

-- 请求全服boss扫荡
function CrossBossProto:CrossBossModUp(actId, nodeId, idx)
    local proto = {"CrossBossProto:CrossBossModUp", {
        actId = actId,
        nodeId = nodeId,
        idx = idx
    }}
    NetMgr.net:Send(proto)
end

-- 请求全服boss扫荡存档
function CrossBossProto:CrossBossModSave(actId, nodeId, idx, callBack)
    self.crossBossModSave = callBack
    local proto = {"CrossBossProto:CrossBossModSave", {
        actId = actId,
        nodeId = nodeId,
        idx = idx
    }}
    NetMgr.net:Send(proto)
end

-- 请求删除全服boss扫荡存档
function CrossBossProto:CrossBossModSaveDel(actId, nodeId, idx,callBack)
    self.crossBossModSaveDel = callBack
    local proto = {"CrossBossProto:CrossBossModSaveDel", {
        actId = actId,
        nodeId = nodeId,
        idx = idx
    }}
    NetMgr.net:Send(proto)
end

-- 全服boss下发节点扫荡存档
function CrossBossProto:CrossBossSendModSaveData(proto)
    if self.crossBossModSaveDel then
        self.crossBossModSaveDel(proto)
        self.crossBossModSaveDel= nil
    end
    if proto and proto.arrCard then
        VirCatMgr:UpdateCards(proto.arrCard)
    end
     VirCatMgr:UpdateSaves(proto)
    if self.crossBossModSave then
        self.crossBossModSave()
        self.crossBossModSave = nil
    end
end

function CrossBossProto:EnterCrossBossFight(data)
    local proto = {"CrossBossProto:EnterCrossBossFight", data}
    NetMgr.net:Send(proto)
end

function CrossBossProto:CrossBossFightOver(proto)
    if proto then
        if proto.arrCard then
            VirCatMgr:UpdateCards(proto.arrCard)
        end
        if proto.arrTeam then
            VirCatMgr:UpdateTeams(proto.arrTeam)
        end
        if proto.modSaveData then
            VirCatMgr:UpdateSaveDatas(proto.modSaveData)
        end
    end
    FightOverTool.OnVirCatOver(proto)
end

function CrossBossProto:CrossBossGetStageReward(actId,idx)
    local proto = {"CrossBossProto:CrossBossGetStageReward", {actId = actId,idx = idx}}
    NetMgr.net:Send(proto)
end
