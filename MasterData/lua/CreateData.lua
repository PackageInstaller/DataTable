-- 建筑工厂
CreateData = {}
local this = CreateData

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins
end

function this:SetData(cfg)
    self.cfg = cfg
    -- 首抽信息
    self.first_10 = false -- 是否已首抽
    self.had_try_cnt = 0 -- 已重构次数
    self.logs = nil -- 保存的列表   sCardCreateLog
    self.last_op = nil -- 最后一次数据，中途重登时使用，如果没有，则从logs中获取
    self.isSave = false -- 当前抽卡结果是否已保存到logs
    self.isDy = false
    if (self.cfg.nType == 4 or self.cfg.nType == 5) then
        self.isDy = true
        self.dyEndTime = 0
    end
end

function this:GetCfg()
    return self.cfg
end
function this:GetID()
    return self.cfg.id
end
function this:GetId()
    return self.cfg.id
end

function this:GetLastOP()
    return self.last_op
end

function this:GetLogs()
    return self.logs
end

function this:GetCount()
    return self.had_try_cnt, self:GetFirstTryCnt()
end

function this:GetIsSvale()
    return self.isSave
end

function this:GetFirstTryCnt()
    return self.cfg.nFirstTryCnt or 0
end

-- 首抽完成记录
function this:IsOverFirst10()
    self.first_10 = true
    self.logs = nil
    self.last_op = nil
end

-- 是否有未完成的10连
function this:CheckNeedContinue()
    if (self:GetFirstTryCnt() > 0 and self.first_10 == false and self.had_try_cnt > 0) then
        return true
    end
    return false
end

-- 是否需要首次10连
function this:NeedFirst10()
    if (self:GetFirstTryCnt() > 0 and self.first_10 == false) then
        return true
    end
    return false
end

-- 登录后获取
function this:InitFirstInfo(_sFirstCreateInfo)
    if (_sFirstCreateInfo) then
        self.first_10 = _sFirstCreateInfo.first_10
        self.had_try_cnt = _sFirstCreateInfo.had_try_cnt
    end
end

-- 登录后获取
function this:InitLogInfo(_sCardCreateLogInfo)
    if (_sCardCreateLogInfo) then
        self.logs = _sCardCreateLogInfo.logs
        self.last_op = _sCardCreateLogInfo.last_op
        if (self.last_op and self.last_op.rewards ~= nil) then
            self.isSave = false
        else
            self.isSave = true
        end
    end
end

function this:InitBD(sel_Infos, id)
    self.sel_Infos = sel_Infos
    if (self.sel_Infos) then
        self.sel_Infos.num = id
    end
end

function this:SetBDCid(cid)
    if (cid ~= 0) then
        self.sel_Infos = self.sel_Infos or {}
        self.sel_Infos.num = cid
        self.sel_Infos.type = 0
    else
        self.sel_Infos = {}
    end
end

function this:GetBDData()
    return self.sel_Infos
end

-- 抽卡后重置某些信息
function this:RefreshInfo()
    self.had_try_cnt = self.had_try_cnt + 1
    self.last_op = nil
    self.isSave = false
end
-- 卡池开放时间
function this:GetStartTime()
    if (self:CheckIsDy()) then
        return nil
    end
    if (self.cfg.sStart == nil) then
        return nil
    else
        return TimeUtil:GetTimeStampBySplit(self.cfg.sStart) -- GCalHelp:GetTimeStampBySplit(self.cfg.sStart)
    end
end
-- 卡池是否已开放
function this:CheckIsStart()
    if (self:CheckIsDy()) then
        if (TimeUtil:GetTime() < self.dyEndTime) then
            return true
        end
        return false
    end
    local _time = self:GetStartTime()
    if (_time and TimeUtil:GetTime() < _time) then
        return false
    end
    return true
end

-- 卡池结束时间
function this:GetEndTime()
    if (self:CheckIsDy()) then
        return self.dyEndTime
    end
    if (self.cfg.sEnd == nil) then
        return nil
    else
        return TimeUtil:GetTimeStampBySplit(self.cfg.sEnd) -- GCalHelp:GetTimeStampBySplit(self.cfg.sEnd)
    end
end

-- 卡池是否已关闭
function this:CheckIsEnd()
    if (self:CheckIsDy()) then
        if (TimeUtil:GetTime() >= self.dyEndTime) then
            return true
        end
        return false
    end
    local _time = self:GetEndTime()
    if (_time and TimeUtil:GetTime() >= _time) then
        return true
    end
    return false
end

-- 奖励表id
function this:GetRewardCfgID()
    local jCardsId = self.cfg.jCardsId
    if (jCardsId) then
        for i, v in ipairs(jCardsId) do
            if (v[1] == 0) then
                return v[2]
            end
        end
    end
    return nil
end

-- 移除类型为1并且已达成抽卡次数的卡池
function this:CheckIsRemove()
    local cfg = self:GetCfg()
    if (cfg.nType == 1 and cfg.nUseCntLimt ~= nil) then
        local num = CreateMgr:GetCreateCnt(cfg.id)
        if (num >= cfg.nUseCntLimt) then
            return true
        end
    end
    return false
end

----------------------------------累计卡池-------------------------------------------
-- 是否有累计卡池
function this:CheckChilds()
    return self:GetCfg().childIds ~= nil
end

-- 当前能否构建
function this:CheckCanCreate()

end

-- 当前第几次
function this:GetCurCount()

end
----------------------------------动态卡池-------------------------------------------

function this:InitDyOpenPool(endTime)
    self.isDy = true
    self.dyEndTime = TimeUtil:GetBJTime(endTime)
end

-- 是否是动态卡池
function this:CheckIsDy()
    return self.isDy
end
function this:GetDyEndTime()
    return self.dyEndTime
end

-- 是否已满足开启条件
function this:CheckConditions()
    if (self:GetCfg().conditions) then
        return MenuMgr:CheckConditionIsOK(self:GetCfg().conditions)
    end
    return true
end

----------------------------------免费抽卡-------------------------------------------
function this:IsOneFree()
    -- 在时间内
    local b,refreshTime = CreateMgr:IsFreeInTime()
    if (not b) then
        return false,refreshTime
    end
    -- 是免费抽卡的卡池，有次数
    if (self:GetCfg().canFreeUse and CreateMgr:GetFreeCnt() > 0) then
        return true
    end
    return false
end

----------------------------------自选抽卡-------------------------------------------
function this:GetType()
    return self:GetCfg().nType or 1
end

function this:SetChoiceInfos(choice_info)
    self.choice_infos = choice_info
    -- 修改表的数据
    local _look_cards = CfgCardPool[self:GetCfg().id].look_cards
    if (self:IsSelectRole()) then
        _look_cards = _look_cards==nil and {{0,0,0},{0,0,0}} or _look_cards
        _look_cards[1][3] = choice_info.cids[1]
        _look_cards[2][3] = choice_info.cids[2]
    -- else
    --     _look_cards = nil 
    end
    CfgCardPool[self:GetCfg().id].look_cards = _look_cards
end

function this:GetChoiceCids()
    if (self.choice_infos) then
        return self.choice_infos.cids
    end
    return {}
end

function this:IsSelectPool()
    return self:GetType() == CardPoolType.SelfChoice
end

-- {id,cids,firstCids}
function this:IsSelectRole()
    if (self.choice_infos) then
        local cids = self.choice_infos.cids or {}
        for k, v in pairs(cids) do
            if (v ~= nil) then
                return true
            end
        end
    end
    return false
end

function this:IsChoiceAndSelectPool()
    if (self:IsSelectPool() and self:IsSelectRole()) then
        return true
    end
    return false
end

-- 抽卡消耗的物品id
function this:GetCostID()
    if (self:GetCfg().jCost) then
        return self:GetCfg().jCost[1][1]
    end
    return 11002
end

-- 兑换id 微晶换抽卡劵xx
function this:GetExchangeID()
    local id = self:GetCostID() -- xx
    local cfgs = Cfgs.CfgItemExchange:GetAll()
    for k, v in pairs(cfgs) do
        if (v.id < 10000 and v.gets[1][1] == id and v.costs[1][1] == 10040) then
            return v.id
        end
    end
    return nil
end

function this:IsFirstSelectCard(cardID)
    if (self.choice_infos and self.choice_infos.firstCids) then
        for k, v in pairs(self.choice_infos.firstCids) do
            if(v==cardID)then 
                return true 
            end 
        end
    end 
    return false 
end

function this:GetFirstCids()
    if (self.choice_infos and self.choice_infos.firstCids and #self.choice_infos.firstCids>0) then
        return self.choice_infos.firstCids
    end 
    return nil
end

return this
