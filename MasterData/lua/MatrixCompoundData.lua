-- 合成订单 
MatrixCompoundData = {}
local this = MatrixCompoundData
function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

function this:SetData(_cfg)
    self.cfg = _cfg
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg.id
end

function this:GetName()
    if (not self.name) then
        local getID = self.cfg.rewards[1][1]
        local cfg = Cfgs.ItemInfo:GetByID(getID)
        self.name = cfg.name
    end
    return self.name
end

function this:GetPriceNum()
    if (not self.priceNum) then
        self.priceNum = self.cfg.cost and self.cfg.cost[1][2] or 0
    end
    return self.priceNum
end

function this:GetQuality()
    if (not self.quality) then
        local getID = self.cfg.rewards[1][1]
        local cfg = Cfgs.ItemInfo:GetByID(getID)
        self.quality = cfg.quality
    end
    return self.quality
end

function this:GetGroup()
    if (not self.group) then
        local getID = self.cfg.rewards[1][1]
        local cfg = Cfgs.ItemInfo:GetByID(getID)
        self.group = cfg.group
    end
    return self.group
end

function this:CheckIsOpen()
    local isOpen, str = true, ""
    -- 建筑等级/关卡
    local buildData = MatrixMgr:GetBuildingDataByType(BuildsType.Compound)
    if (buildData:GetLv() < self.cfg.buildLv) then
        local lvStr = LanguageMgr:GetByID(1033) or "LV."
        local s = StringUtil:SetByColor(lvStr.. self.cfg.buildLv, "ffc146")
        str = LanguageMgr:GetByID(10204, s)
        isOpen = false
    elseif (self.cfg.dupId and not DungeonMgr:CheckDungeonPass(self.cfg.dupId)) then
        local sectionCfg = Cfgs.MainLine:GetByID(self.cfg.dupId)
        local s = StringUtil:SetByColor(sectionCfg.name, "ffc146")
        str = LanguageMgr:GetByID(10431, s)
        isOpen = false
    end
    return isOpen, str
end

function this:IsOpenSortIndex()
    if (not self.openSortIndex) then
        local isOpen = self:CheckIsOpen()
        self.openSortIndex = isOpen and 1 or 2
    end
    return self.openSortIndex
end

-- 获取长度为3的格子列表奖励数据
function this:GetMat3()
    local mats = {}
    local _mats = self.cfg.materials
    for k = 1, 3 do
        if (k > #_mats) then
            table.insert(mats, {})
        else
            local count = BagMgr:GetCount(_mats[k][1])
            table.insert(mats, {_mats[k][1], count})
        end
    end
    return mats
end

-- 奖励物品格子数据
function this:GetFakeRewardData()
    local reward = self.cfg.rewards[1]
    local getID = reward and reward[1] or nil
    -- local count = reward and reward[2] or 1
    -- return BagMgr:GetFakeData(getID, count * _count)
    return BagMgr:GetFakeData(getID)
end

function this:GetRewarCount(_count)
    local reward = self.cfg.rewards[1]
    local getID = reward and reward[1] or nil
    local count = reward and reward[2] or 1
    return count * _count
end

-- 材料支持购买的最大数量
function this:CalMatMaxCount()
    local maxCount = 99
    local materials = self.cfg.materials
    for k, v in ipairs(materials) do
        local need = v[2]
        local had = BagMgr:GetCount(v[1])
        local num = math.floor(had / need)
        if (num < maxCount) then
            maxCount = num
        end
    end
    return maxCount
end

-- 金币支持消耗的数量
function this:CalCostMaxCount()
    local maxCount = 99
    local cost = self.cfg.cost
    for k, v in ipairs(cost) do
        local need = v[2]
        local had = BagMgr:GetCount(v[1])
        local num = math.floor(had / need)
        if (num < maxCount) then
            maxCount = num
        end
    end
    return maxCount
end

return this

