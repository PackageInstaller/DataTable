local RogueSData = require "RogueSData"
local this = MgrRegister("RogueSMgr")

function this:Init()
    self:Clear()
    self:InitMissionTime()
    self:InitCfg()
    self:GetRogueSInfo()
end

function this:Clear()
    self.datasDic = {} -- 各关数据
    self.fightData = nil -- 重连数据
    self.sectionDatas = nil -- 所属章节数据 普通、困难(有Rogue+RogueS)
end

function this:InitCfg()
    self.datasDic = {}
    for k, v in pairs(self.sectionDatas) do
        local cfgs = Cfgs.DungeonGroup:GetGroup(v:GetID())
        for k, v in ipairs(cfgs) do
            local _data = RogueSData.New()
            _data:InitCfg(v)
            self.datasDic[v.id] = _data
        end
    end
end

-- 活动任务结束时间
function this:InitMissionTime()
    self.endTime = nil
    --
    self.sectionDatas = {}
    self.sectionDatas[1] = DungeonMgr:GetSectionData(12001)
    self.sectionDatas[2] = DungeonMgr:GetSectionData(12002)
end
-- 限时任务剩余时间 秒
function this:GetRogueTime()
    if (self.endTime and self.endTime > TimeUtil:GetTime()) then
        return self.endTime - TimeUtil:GetTime()
    end
    return 0
end

function this:GetData(id)
    for k, v in pairs(self.datasDic) do
        if (v:GetCfg().id == id) then
            return v
        end
    end
    return nil
end

-- 普通或困难
function this:GetDatas(nType)
    local _datas = {}
    for k, v in pairs(self.datasDic) do
        if (v:GetCfg().nType == nType) then
            table.insert(_datas, v)
        end
    end
    if (#_datas > 1) then
        table.sort(_datas, function(a, b)
            return a:GetID() < b:GetID()
        end)
    end
    return _datas
end

-- 请求基础数据
function this:GetRogueSInfo(cb)
    self.GetRogueInfoCB = cb
    FightProto:GetRogueSInfo()
end

-- 初始化数据
function this:GetRogueSInfoRet(proto)
    self._datasDic = self._datasDic or {}
    for k, v in ipairs(proto.datas) do
        self._datasDic[v.id] = v
    end
    if (not proto.is_finish) then
        return
    end
    -- 奖励
    self.gained = proto.gained
    -- 当前解锁的最大关卡
    self.maxGroup = proto.maxGroup or -1
    -- 各关数据
    for k, v in pairs(self.datasDic) do
        local _data = self._datasDic[v:GetID()]
        local isLock = false
        if (v:GetCfg().perLevel) then
            isLock = v:GetCfg().perLevel > self.maxGroup
        end
        self.datasDic[v:GetID()]:InitData(_data, isLock)
    end
    if (self.GetRogueInfoCB) then
        self.GetRogueInfoCB()
    end
    self.GetRogueInfoCB = nil
    self._datasDic = nil
    -- red  
    local num1 = self:IsRed() and 1 or 0
    local num2 = RedPointMgr:GetData(RedPointType.RogueS)
    if (num2 == nil or num2 ~= num1) then
        RedPointMgr:UpdateData(RedPointType.RogueS, num2)
    end
end

-- 奖励情况
function this:RogueSGainRet(gained)
    self.gained = gained
    -- red  
    local num1 = self:IsRed() and 1 or 0
    local num2 = RedPointMgr:GetData(RedPointType.RogueS)
    if (num2 == nil or num2 ~= num1) then
        RedPointMgr:UpdateData(RedPointType.RogueS, num2)
    end
end
-- 最大领取下标
function this:GetRogueSGainMaxIndex(starIx)
    if (self.gained) then
        for k, v in pairs(self.gained) do
            if (v.id == starIx) then
                return v.index
            end
        end
    end
    return 0
end
-- 难度总星数
function this:GetStars(starIx)
    local num = 0
    for k, v in pairs(self.datasDic) do
        if (v:GetCfg().starIx == starIx) then
            num = num + v:GetStars()
        end
    end
    return num
end

-- 重连的数据
function this:FightingRogueSData(proto)
    self.fightData = proto
end
function this:GetFightingRogueSData()
    return self.fightData
end

-- 总轮数
function this:GetLen(id)
    local num = 0
    local cfg = Cfgs.DungeonGroup:GetByID(id)
    local _cfgs = Cfgs.MainLine:GetGroup(cfg.group)
    for k, v in pairs(_cfgs) do
        if (v.dungeonGroup == id) then
            num = num + 1
        end
    end
    return num
end

function this:Quit(id)
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("Section", {
            type = 4
        })
        local cfg = Cfgs.DungeonGroup:GetByID(id)
        CSAPI.OpenView("RogueMain")
        CSAPI.OpenView("RogueSView", id, cfg.nType)
    end)
end

-- 根据难道获取星表id
function this:GetStarIxByNType(nType)
    local starIx = 1601
    local cfgs = Cfgs.DungeonGroup:GetGroup(self.sectionDatas[nType]:GetID())
    for k, v in pairs(cfgs) do
        if (v.nType == nType) then
            starIx = v.starIx
            break
        end
    end
    return starIx
end

function this:CheckRedByStarIx(starIx)
    local getIndex = self:GetRogueSGainMaxIndex(starIx)
    local stars = self:GetStars(starIx)
    local cfgs = Cfgs.CfgSectionStarReward:GetByID(starIx)
    if (cfgs.arr) then
        for k, v in ipairs(cfgs.arr) do
            if (stars >= v.starNum and v.index > getIndex) then
                return true
            end
        end
    end
    return false
end

-- 检测奖励红点 难度
function this:CheckRedByNType(nType)
    local starIx = self:GetStarIxByNType(nType)
    return self:CheckRedByStarIx(starIx)
end

-- 整体是否有红点
function this:IsRed()
    local isRed = false
    if (self.sectionDatas ~= nil) then
        for k = 1, 2 do
            if (self:CheckRedByNType(k)) then
                isRed = true
            end
        end
    end
    return isRed
end

function this:GetCacheNType()
    return self.cacheNType or 1
end
function this:SetCacheNType(nType)
    self.cacheNType = nType
end

function this:GetNextGroup(group)
    if (self.datasDic[group + 1]) then
        return group + 1
    end
    return group
end

-- 困难模式前置章节是否已通
function this:CheckPerOpen()
    if (self.sectionDatas[2]) then
        local preSection = self.sectionDatas[2]:GetCfg().preSection
        if (preSection) then
            local preSectionData = DungeonMgr:GetSectionData(preSection)
            if preSectionData:GetState() ~= 2 then
                -- LanguageMgr:ShowTips(25001, preSectionData:GetName())
                local str = LanguageMgr:GetTips(25001, preSectionData:GetName())
                return false, str
            end
        end
    end
    return true
end

-- 困难模式是否已开启
function this:CheckHardOpen()
    local str = LanguageMgr:GetTips(44002)
    if (self.maxGroup > 0) then
        local cfg = Cfgs.DungeonGroup:GetByID(self.maxGroup)
        if (cfg.nType == 2) then
            return true
        end
        local cfg2 = Cfgs.DungeonGroup:GetByID(self.maxGroup + 1)
        if (cfg2.nType == 2) then
            return true
        end
    end
    return false, str
end

return this
