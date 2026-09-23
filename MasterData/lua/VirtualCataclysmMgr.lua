VirCatMgr = MgrRegister("VirtualCataclysmMgr")
local this = VirCatMgr;

function this:Init()
    self:Clear()
    self:InitDatas()
    CrossBossProto:GetData()
end

function this:Clear()
    self.datas = {}
    self.saveDatas = {}
    self.activeId = 0
    self.isActive = false
    self.playerData = nil
    self.bossBuffs = nil
    self.cardIDs = nil
    self.teamIndexs = nil
    self.gets = {}
    self.stagePro = nil
end

function this:InitDatas()
    local cfgs = Cfgs.cfgVirtualCataclysmNode:GetAll()
    if cfgs then
        for k, v in pairs(cfgs) do
            local data = VirCatNodeData.New()
            data:Init(v)
            self.datas[v.id] = data
        end
    end
end

function this:SetDatas(proto)
    if proto then
        self.activeId = proto.actId
        self.isActive = proto.state
        self.stage = proto.curStage
        self.stagePro = proto.stageProgress
        self.bossBuffs = proto.buffList
        self:SetPlayerData(proto.playerData)
        self:UpdateDatas(proto.nodeList)
        -- 关卡
        if MenuMgr.isInit then --防止未初始化完成就检测数据
            DungeonMgr:CheckRedPointData()
        end
    end
    EventMgr.Dispatch(EventType.VirtualCataclysm_Panel_Update)
end

function this:UpdateDatas(list)
    if list and #list > 0 then
        for i, v in ipairs(list) do
            if self.datas and self.datas[v.nodeId] then
                self.datas[v.nodeId]:InitData(v)
            end
        end
    end
end

function this:UpdateCards(list)
    self.cardIDs = {}
    if list and #list > 0 then
        for i, v in ipairs(list) do
            self.cardIDs[v] = v
        end
    end
end

function this:UpdateTeams(list)
    self.teamIndexs = {}
    if list and #list > 0 then
        for i, v in ipairs(list) do
            self.teamIndexs[v] = v
        end
    end
end

function this:UpdateNodes(proto)
    if proto then
        self.activeId = proto.actId
        self.stage = proto.curStage
        self:UpdateDatas(proto.dirtyNodeList)
    end
    EventMgr.Dispatch(EventType.VirtualCataclysm_Panel_Update)
end

function this:GetData(id)
    return self.datas and self.datas[id]
end

function this:GetArr(stageId, type)
    local datas = {}
    for k, v in pairs(self.datas) do
        if not stageId or v:GetStage() == stageId then
            if not type or v:GetType() == type then
                table.insert(datas, v)
            end
        end
    end
    if #datas > 0 then
        table.sort(datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

function this:GetActiveId()
    return self.activeId
end

-- 当前阶段
function this:GetStage()
    return self.stage
end

--当前物品领取进度
function this:GetStagePro()
    return self.stagePro or 0
end

--获取可出战队伍数据
function this:GetShowTeamInfos()
    local infos = {}
    local len = 1
    for i = 1, len do --只能上阵5队
        -- if self:IsTeamShow(eTeamType.CrossBoss + (i - 1)) then
        --     if i > 3 then --前面队伍都出战过
        --         if #infos == 0 then
        --             table.insert(infos,{id = eTeamType.CrossBoss + (i - 1),index = i})
        --             break
        --         end
        --     else
                table.insert(infos,{id = eTeamType.CrossBoss + (i - 1),index = i})
        --     end
        -- end
    end
    return infos
end

-- 活动开启中
function this:IsActive()
    return self.isActive
end

--可上阵
function this:IsCardShow(cid)
    if self.cardIDs and self.cardIDs[cid] then
        return false
    end
    return true
end

--可出战
function this:IsTeamShow(index)
    if self.teamIndexs and self.teamIndexs[index] then
        return false
    end
    return true
end

---------------------------------------------扫荡相关---------------------------------------------
--存档数据更新
function this:UpdateSaves(proto)
    if proto then
        self.activeId = proto.actId
        self:UpdateSaveDatas(proto.modSaveData)
    end
    EventMgr.Dispatch(EventType.VirtualCataclysm_Save_Update)
end

--存档数据更新
function this:UpdateSaveDatas(list)
    if list and #list > 0 then
        for i, v in ipairs(list) do
            if self.saveDatas[v.nodeId .. "_" .. v.idx] then
                self.saveDatas[v.nodeId .. "_" .. v.idx]:Init(v)
            else
                local data = VirCatSaveData.New()
                data:Init(v)
                self.saveDatas[v.nodeId .. "_" .. v.idx] = data
            end
        end
    end
end

function this:GetSaveData(nodeId, index)
    return self.saveDatas and self.saveDatas["nodeId" .. "_" .. "index"]
end

--存档数据
function this:GetSaveArr(nodeId)
    local _datas = {}
    for k, v in pairs(self.saveDatas) do
        if not nodeId or v:GetID() == nodeId then
            _datas[v:GetIndex()] = v
        end
    end

    local datas = {}
    local len = self:GetSaveLen()
    if len > 0 then
        for i = 1, len do
            if _datas[i] then
                table.insert(datas,_datas[i])
            else
                table.insert(datas,{isEmpty = true})
            end
        end
    end
    return datas
end

--存档上限
function this:GetSaveLen()
    local len = 0
    local cfg = Cfgs.CfgVirtualCataclysm:GetByID(self.activeId)
    if cfg then
        len = cfg.saveNum
    end
    return len
end

function this:RemoveSaveData(nodeId,index)
    if self.saveDatas and self.saveDatas[nodeId .. "_" .. index] then
        self.saveDatas[nodeId .. "_" .. index] = nil
    end
end

--存档到达上限
function this:IsSaveMax(nodeId)
    local max = self:GetSaveLen()
    local cur = 0
    for k, v in pairs(self.saveDatas) do
        if v:GetID() == tonumber(nodeId) then
            cur = cur + 1
        end
    end
    return cur > max
end
---------------------------------------------玩家相关---------------------------------------------
-- 设置玩家数据
function this:SetPlayerData(_data)
    if _data then
        self.playerData = {}
        self.playerData.score = _data.score -- 累计积分 
        self.playerData.buffId = _data.chooseBuffId -- 当前选择的boss词条
        self:UpdateCards(_data.arrCard) --出战过角色
        self:UpdateTeams(_data.arrTeam) --出战过队伍
        self:UpdateSaveDatas(_data.modSaveData) -- 扫荡存档
        self:UpdateRewardGets(_data.arrStageRwdGet) --已领取
    end
end

function this:UpdateRewardGets(_gets)
    if _gets and #_gets>0 then
        self.gets = {}
        for i, v in ipairs(_gets) do
            self.gets[v] = 1
        end
    end
end


function this:GetPlayerData()
    return self.playerData
end

--累计积分
function this:GetScore()
    return self.playerData and self.playerData.score
end

function this:GetBuffArr()
    local infos = {}
    if self.bossBuffs and #self.bossBuffs > 0 then
        local cfg = nil
        for i, v in ipairs(self.bossBuffs) do
            cfg = Cfgs.CfgBuffVirtualCataclysm:GetByID(v)
            table.insert(infos,cfg)
        end
        table.insert(infos,{isEmpty = true}) --固定有一条是不选择
    end
    return infos
end

function this:GetSelectBuff()
    return self.playerData and self.playerData.buffId
end

function this:IsRewardGet(idx)
    return self.gets and self.gets[idx] ~= nil
end
---------------------------------------------red---------------------------------------------
function this:CheckRed()
    local isRed = self:CheckRewardRed()
    if not isRed then
        isRed = MissionMgr:CheckRed({eTaskType.CrossBoss})
    end
    return isRed
end

function this:CheckRewardRed()
    local cfg = Cfgs.CfgVirtualCataclysm:GetByID(self:GetActiveId())
    if cfg and cfg.rewardId then
        local cfgReward = Cfgs.CfgVirtualCataclysmReward:GetByID(cfg.rewardId)
        if cfgReward and cfgReward.infos then
            for i, v in ipairs(cfgReward.infos) do
                if self:GetStagePro() >= v.rate and not self:IsRewardGet(v.index) then
                    return true
                end
            end
        end
    end
    return false
end

return this
