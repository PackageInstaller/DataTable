-- 肉鸽
local RogueData = require "RogueData"
local this = MgrRegister("RogueMgr")

function this:Init()
    self:Clear()
    self:InitMissionTime()
    self:GetRogueInfo() --红点需求
end

function this:Clear()
    self.datasDic = {} -- 各关数据
    self.curData = nil -- 当前进行中的数据
    self.sectionID = 11001 -- 所属章节id
end

-- 活动任务结束时间
function this:InitMissionTime()
    self.endTime = nil
    local cfgs = Cfgs.CfgRogueTask:GetAll()
    for k, v in pairs(cfgs) do
        if (v.sCloseTime ~= nil) then
            self.endTime = TimeUtil:GetTimeStampBySplit(v.sCloseTime)
            break
        end
    end
end

-- 请求基础数据（打开界面再请求）
function this:GetRogueInfo(cb)
    self:InitCfg()
    self.GetRogueInfoCB = cb
    FightProto:GetRogueInfo()
end

function this:InitCfg()
    self.datasDic = {}
    local cfgs = Cfgs.DungeonGroup:GetGroup(self.sectionID)
    for k, v in ipairs(cfgs) do
        local _data = RogueData.New()
        _data:InitCfg(v)
        self.datasDic[v.id] = _data
    end
end

-- 更新数据
function this:GetRogueInfoRet(proto)
    self._datasDic = self._datasDic or {}
    for k, v in ipairs(proto.datas) do
        self._datasDic[v.id] = v
    end
    if (not proto.is_finish) then
        return
    end
    -- 当前解锁的最大关卡
    local maxGroup = proto.maxGroup or -1
    -- 各关数据
    for k, v in pairs(self.datasDic) do
        local _data = self._datasDic[v:GetID()]
        local isLock = false
        if (v:GetCfg().perLevel) then
            isLock = v:GetCfg().perLevel > maxGroup
        end
        self.datasDic[v:GetID()]:InitData(_data, isLock)
    end
    self._datasDic = nil
    if (self.GetRogueInfoCB) then
        self.GetRogueInfoCB()
    end
    self.GetRogueInfoCB = nil
    --red  
    local num1 = self:IsRed() and 1 or 0
    local num2 = RedPointMgr:GetData(RedPointType.Rogue)
    if(num2==nil or num2~=num1) then 
        RedPointMgr:UpdateData(RedPointType.Rogue, num2)
    end
end

function this:GetData(id)
    for k, v in pairs(self.datasDic) do
        if (v:GetCfg().id == id) then
            return v
        end
    end
    return nil
end

-- 测试或挑战
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

function this:GetSectionID()
    return self.sectionID
end

---------------------------------------当前数据------------------------------------------------
-- 更新数据
function this:FightingRogueData(proto)
    self.curData = proto
end

function this:SetSelectBuffs(_selectBuffs)
    self.curData.selectBuffs = _selectBuffs
end
function this:SetSelectPos(_selectPos)
    self.curData.selectPos = _selectPos
end

-- 当前挑战的数据： round：挑战中的轮次
function this:GetCurData()
    return self.curData
end
function this:ClearCurData()
    self.curData = nil
end

-- 是否挑战中 
function this:CheckIsChallenge(id)
    if (self.curData and self.curData.group == id) then
        return true
    end
    return false
end

-- 限时任务剩余时间 秒
function this:GetRogueTime()
    if (self.endTime and self.endTime > TimeUtil:GetTime()) then
        return self.endTime - TimeUtil:GetTime()
    end
    return 0
end

-- 当前已选的词条
function this:GetSelectBuffs()
    return self.curData.selectBuffs
end

-- 当前可选词条
function this:GetRandomBuffs()
    return self.curData.randomBuffs
end

-- 当前关卡的数据
function this:GetCurData2()
    if (self.curData) then
        local group = self.curData.group
        return self:GetData(group)
    end
    return nil
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
function this:FightToBack(save, group,cb)
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("Section", {
            type = 4
        })
        CSAPI.OpenView("RogueMain")
        if (save) then
            local cfg = Cfgs.DungeonGroup:GetByID(group)
            CSAPI.OpenView("RogueView",nil,cfg.nType)
        else
            CSAPI.OpenView("RogueView", nil, group,cb)
        end
    end)
end

function this:NeedToBuffView()
    self.isNeedToBuffView = true  
end
function this:CheckNeedToBuffView()
    local b = self.isNeedToBuffView
    self.isNeedToBuffView = false 
    return b 
end
------------------------------任务--------------------------------------------------------
--是否有任务红点
function this:IsRed()
    local isRed = false 
    local _redData = RedPointMgr:GetData(RedPointType.Rogue)
    if(_redData and _redData==1) then
        isRed = true  
    end
    return isRed
end

return this
