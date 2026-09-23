-- 肉鸽
local RogueTData = require "RogueTData"
local this = MgrRegister("RogueTMgr")

function this:Init()
    self:Clear()
    self:InitCfg()
    self:GetRogueTInfo() -- 红点需求
end

function this:Clear()
    self.datasDic = {} -- 各关数据
    self.proto = {}
    self.fightData = nil
    self.sectionID = 15001 -- 所属章节id
    self.maxGroup = nil -- 已通关的最高难度
    self.oldMaxGroup = nil -- 之前的最高难度
    self.maxBoss = nil
end

function this:InitCfg()
    self.datasDic = {}
    local cfgs = Cfgs.DungeonGroup:GetGroup(self.sectionID)
    for k, v in ipairs(cfgs) do
        local _data = RogueTData.New()
        _data:InitCfg(v)
        self.datasDic[v.id] = _data
    end
end

-- 请求基础数据（打开界面再请求）
function this:GetRogueTInfo(cb)
    self.maxGroup = nil
    self.fightData = nil
    -- self:InitCfg()
    self.GetRogueInfoCB = cb
    FightProto:GetRogueTInfo()
end

-- 更新数据
function this:GetRogueTInfoRet(proto)
    for k, v in ipairs(proto.data) do
        if(v.id and self.datasDic[v.id])then 
            self.datasDic[v.id]:InitData(v)
        end 
    end
    if (not proto.is_finish) then
        return
    end
    --
    self.maxGroup = nil
    if (proto.maxGroup and proto.maxGroup ~= 0) then
        self.maxGroup = proto.maxGroup
    end
    if (self.oldMaxGroup == nil or (self.maxGroup ~= nil and self.maxGroup >= self:GetMHard())) then
        self.oldMaxGroup = self.maxGroup or 0
    end
    self.proto = proto
    self.proto.data = nil
    if (self.GetRogueInfoCB) then
        self.GetRogueInfoCB()
    end
    self.maxBoss = proto.maxBoss
    self.GetRogueInfoCB = nil
    -- red  
    self:CheckReds()
end

function this:GetData(id)
    for k, v in pairs(self.datasDic) do
        if (v:GetCfg().id == id) then
            return v
        end
    end
    return nil
end

function this:GetArr()
    local arr = {}
    for k, v in pairs(self.datasDic) do
        table.insert(arr, v)
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetCfg().hard < b:GetCfg().hard
        end)
    end
    return arr
end

function this:GetMHard()
    if (not self.mHard) then
        local arr = self:GetArr()
        self.mHard = arr[#arr]:GetID()
    end
    return self.mHard
end

-- 获取当前关卡
function this:GetMaxData()
    local id = self:GetSelectID()
    if (id and id ~= 0) then
        return self:GetData(id)
    end
    local arr = self:GetArr()
    self:SetSelectID(arr[1]:GetID())
    return arr[1]
end

function this:GetHard(id)
    if (id and id ~= 0) then
        local cfg = Cfgs.DungeonGroup:GetByID(id)
        return cfg.hard
    end
    return 0
end

function this:GetMaxHard()
    return self:GetHard(self.maxGroup)
end
function this:GetMaxHard2()
    return self:GetHard(self.maxBoss)
end

function this:SetSelectID(id)
    self.selectID = id
    PlayerPrefs.SetInt("roguet_select_id", self.selectID)
end
function this:GetSelectID()
    if (not self.selectID) then
        self.selectID = PlayerPrefs.GetInt("roguet_select_id")
    end
    if (self.selectID and self.selectID ~= 0) then
        local hard1, hard2 = 0, 0
        hard1 = self:GetHard(self.selectID)
        hard2 = self.maxGroup ~= nil and self:GetHard(self.maxGroup) or 0
        if (hard1 > (hard2 + 1)) then
            self.selectID = nil
        end
    end
    return self.selectID
end

function this:SetOldMaxGroup()
    self.oldMaxGroup = self.maxGroup
end
function this:HardIsRed()
    if (not self.maxGroup or not self.oldMaxGroup) then
        return false
    end
    return self.oldMaxGroup < self.maxGroup
end

---------------------------------------当前数据------------------------------------------------
-- 更新数据
function this:FightingRogueTData(proto)
    self.fightData = proto
end

-- 当前挑战的数据： round：挑战中的轮次
function this:GetFightData()
    return self.fightData
end
function this:ClearFightData()
    self.fightData = nil
end

-- 是否挑战中 
function this:CheckIsChallenge(id)
    if (self.fightData and self.fightData.group == id) then
        return true
    end
    return false
end

-- 限时任务剩余时间 秒
function this:GetRogueTTime()
    if (not self.endTime or self.endTime < TimeUtil:GetTime()) then
        -- 每月1号3点
        self.endTime = GCalHelp:GetRogueTNextMonth(TimeUtil:GetTime())
    end
    return self.endTime
end

-- 当前已选的词条
function this:GetSelectBuffs()
    return self.fightData.selectBuffs
end
function this:SetSelectBuffs(_selectBuffs)
    self.fightData.selectBuffs = _selectBuffs
end

function this:RogueTBuffUpRet(proto)
    for k, v in pairs(self.fightData.selectBuffs) do
        if (v == proto.id) then
            self.fightData.selectBuffs[k] = proto.new_id
        end
    end
end

function this:RogueTUseBuffRet(proto)
    self.datasDic[proto.id]:SetUseBuff(proto.useBuff)
end

function this:RogueTGainRewardRet(proto)
    if (proto.ty == 1) then
        self.proto.stageIdx = proto.idx
    else
        self.proto.periodIdx = proto.idx
    end
    self:CheckReds()
end

-- 是否已选buff
function this:CheckSelectBuff()
    if (self.fightData) then
        local len1 = self.fightData.selectBuffs and #self.fightData.selectBuffs or 0
        local cfg = Cfgs.MainLine:GetByID(self.fightData.nDuplicateID)
        local len2 = cfg and cfg.roundLevel or 1
        if (len1 >= len2) then
            return true
        end
    end
    return false
end

--------------------------------------------------------------------------------------
-- 退出界面中途保存
function this:Back(view)
    local dialogdata = {}
    dialogdata.content = LanguageMgr:GetByID(50010) or ""
    dialogdata.okCallBack = function()
        view:Close()
        EventMgr.Dispatch(EventType.Rogue_CancelBack)
    end
    dialogdata.cancelCallBack = function()
        self:ClearCurData()
        FightProto:QuitRogueFight(false, 1)
        view:Close()
        EventMgr.Dispatch(EventType.Rogue_CancelBack)
    end
    dialogdata.okText = LanguageMgr:GetByID(50022)
    dialogdata.cancelText = LanguageMgr:GetByID(50009)
    CSAPI.OpenView("Dialog", dialogdata)
end

-- 战斗中保存进度并退出
function this:FightToBack(save, group, cb)
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("Section", {
            type = 4
        })
        CSAPI.OpenView("RogueMain")
        if (save) then
            local cfg = Cfgs.DungeonGroup:GetByID(group)
            CSAPI.OpenView("RogueTView", nil, cfg.nType)
        else
            CSAPI.OpenView("RogueTView", nil, group, cb)
        end
    end)
end

-- 当前积分等级，积分，最大积分
function this:GetReward()
    if (not self.maxReward) then
        local cfgs = Cfgs.CfgRogueTScoreReward:GetAll()
        self.maxReward = cfgs[#cfgs].points
    end
    return self.proto.stageIdx or 0, self.proto.score or 0, self.maxReward
end

-- 周期积分等级，积分，最大积分
function this:GetScore()
    if (not self.maxScore2) then
        local cfgs = Cfgs.CfgRogueTPeriodReward:GetAll()
        self.maxScore2 = cfgs[#cfgs].points
    end
    return self.proto.periodIdx or 0, self.proto.monthScore or 0, self.maxScore2
end

function this:IsRed()
    if (self:CheckRed1()) then
        return true
    end
    if (self:CheckRed2()) then
        return true
    end
    if (self:CheckRed3()) then
        return true
    end
    if (self:CheckRed4()) then
        return true
    end
    return false
end

function this:CheckReds()
    local num1 = self:IsRed() and 1 or nil
    local num2 = RedPointMgr:GetData(RedPointType.RogueT)
    if (num2 ~= num1) then
        RedPointMgr:UpdateData(RedPointType.RogueT, num1)
    end
end

-- 阶段奖励红点
function this:CheckRed1()
    local index1 = 0 -- 满足
    local score = self.proto.score or 0
    if (score > 0) then
        local cfgs = Cfgs.CfgRogueTScoreReward:GetAll()
        for k, v in ipairs(cfgs) do
            if (v.points > score) then
                break
            end
            index1 = k
        end
    end
    local index2 = self.proto.stageIdx or 0 -- 已领取
    if (index1 > index2) then
        -- 有可领取
        return true
    end
    return false
end

-- 周期奖励红点
function this:CheckRed2()
    local index1 = 0 -- 满足
    local score = self.proto.monthScore or 0
    if (score > 0) then
        local cfgs = Cfgs.CfgRogueTPeriodReward:GetAll()
        for k, v in ipairs(cfgs) do
            if (v.points > score) then
                break
            end
            index1 = k
        end
    end
    local index2 = self.proto.periodIdx or 0 -- 已领取
    if (index1 > index2) then
        -- 有可领取
        return true
    end
    return false
end

-- 周期奖励刷新红点(首次不弹)
function this:CheckRed3()
    if(not self.proto)then 
        return false
    end 
    local time = self:GetRogueTTime()
    local win1 = self.proto.win1 or 0
    if (win1 == 0) then
        -- 首次
        FightProto:RogueTSetWindow(1, time)
    else
        if (time ~= win1) then
            return true
        end
    end
    return false
end

-- 等级扩充红点
function this:CheckRed4()
    if(not self.proto)then 
        return false
    end 
    local win2 = self.proto.win2 or 0
    local cur = g_RogueScoreLVIdx or 0
    if (win2 ~= cur) then
        return true
    end
    return false
end

function this:RogueTSetWindowRet(proto)
    if (proto.ty == 1) then
        self.proto.win1 = proto.value
    else
        self.proto.win2 = proto.value
    end
    self:CheckReds()
end

function this:GetTeamIndex(hard)
    return eTeamType.RogueT -- eTeamType.RogueT + (hard - 1)
end

function this:GetTeamIndex2(nDuplicateID)
    -- local cfg = Cfgs.MainLine:GetByID(nDuplicateID)
    -- local dgCfg = Cfgs.DungeonGroup:GetByID(cfg.dungeonGroup)
    -- return self:GetTeamIndex(dgCfg.hard or 1)
    return eTeamType.RogueT
end

-- 是否是最后一关
function this:IsMainLineLast(nDuplicateID)
    local cfg = Cfgs.MainLine:GetByID(nDuplicateID)
    local cfgs = Cfgs.MainLine:GetGroup(cfg.group)
    local arr = {}
    for k, v in pairs(cfgs) do
        if (not v.isInfinity and v.dungeonGroup == cfg.dungeonGroup) then
            table.insert(arr, v)
        end
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a.roundLevel < b.roundLevel
        end)
    end
    return arr[#arr].id == nDuplicateID
end

-- 是否是无限血关
function this:IsInfinity(nDuplicateID)
    local cfg = Cfgs.MainLine:GetByID(nDuplicateID)
    return cfg.isInfinity
end

-- 通关关卡组id获取无限血关关卡id
function this:GetInfinityID(nDuplicateID)
    local cfg = Cfgs.MainLine:GetByID(nDuplicateID)
    local cfgs = Cfgs.MainLine:GetGroup(cfg.group)
    for k, v in pairs(cfgs) do
        if (v.dungeonGroup == cfg.dungeonGroup and v.isInfinity) then
            return v.id
        end
    end
    return nil
end

-- 存档上限
function this:ArchiveMax(id)
    local cfg = Cfgs.DungeonGroup:GetByID(id)
    return cfg.archiveMax or 0
end

-- 是否可以存档
function this:CheckCanSave(nDuplicateID)
    local cfg = Cfgs.MainLine:GetByID(nDuplicateID)
    return self:ArchiveMax(cfg.dungeonGroup) > 0
end

-- 是RogueT的关卡组表
function this:CheckISDungeonGroupCfg(cfg)
    if (cfg.dungeonGroup == nil and cfg.group == self.sectionID) then
        return true
    end
    return false
end

-- 获取当前最接近的未领取的大奖
function this:GetBigRewardID()
    local lv1, s1 = RogueTMgr:GetReward()
    local cfgs = Cfgs.CfgRogueTScoreReward:GetAll()
    local len = #cfgs or 0
    for k = lv1 + 1, len, 1 do
        if (cfgs[k].points > s1 and cfgs[k].isReward) then
            return k
        end
    end
    return nil
end

function this:GetSectionData()
    return DungeonMgr:GetSectionData(self.sectionID)
end

function this:GetSectionID()
    return self.sectionID
end

-- 明星角色
function this:GetStarRoles()
    local starRoles = {}
    if (self.fightData and self.fightData.id) then
        local cfg = Cfgs.DungeonGroup:GetByID(self.fightData.id)
        if (cfg and cfg.roleid) then
            for k, v in ipairs(cfg.roleid) do
                local cid = FormationUtil.FormatNPCID(v)
                local cardData = FormationUtil.FindTeamCard(cid)
                cardData.isStar = true
                cardData.starID = cfg.roleid and cfg.roleid[1] or nil
                table.insert(starRoles, cardData)
            end
        end
    end
    return starRoles
end

function this:RogueTDelBuffRet(proto)
    if (self.datasDic[proto.id]) then
        self.datasDic[proto.id]:RogueTDelBuffRet(proto.idx)
    end
end

function this:Quit()
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("Section", {
            type = 4
        })
        CSAPI.OpenView("RogueMain")
        CSAPI.OpenView("RogueTView")
    end)
end

return this
