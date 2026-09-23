-- 订单数据
local this = {}
function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(fid, buildId)
    self.fid = fid
    self.buildId = buildId
end

-- lockID:槽位开放等级
function this:SetData(_id, _sFlrOrder, _cRoleInfo, _lockID)
    self.id = _id
    self.sFlrOrder = _sFlrOrder
    self.cRoleInfo = _cRoleInfo
    self.lockID = _lockID
end

-- 假单/锁单
function this:IsEmpty()
    if (self.id ~= nil or self.sFlrOrder ~= nil) then
        return false
    end
    return true
end

function this:IsLock()
    return self.lockID
end

-- id
function this:GetID()
    return self.id
end

-- cfgID
function this:GetCfgID()
    return self.sFlrOrder and self.sFlrOrder.id or nil
end
function this:GetCfg()
    local cfgID = self:GetCfgID()
    local cfg = cfgID and Cfgs.CfgBTradeOrder:GetByID(cfgID) or nil
    return cfg
end

-- rid
function this:GetRid()
    return self.sFlrOrder and self.sFlrOrder.rid or nil
end

function this:GetCRoleInfo()
    return self.cRoleInfo
end

function this:IsEnough()
    local isEnough = false
    local alsoNeed = 0
    if (self.id) then
        local cfg = self:GetCfg()
        local cost = cfg.costs[1]
        local needCount = cost[2]
        local hadNum = BagMgr:GetCount(cost[1])
        isEnough = hadNum >= needCount
        if (not isEnough) then
            alsoNeed = needCount - hadNum
        end
    end
    return isEnough, alsoNeed
end

function this:GetCostID()
    local cfg = self:GetCfg()
    local cost = cfg.costs[1]
    return cost[1]
end

function this:GetIsRareNum()
    if (not self.isRareNum) then
        local cfg = self:GetCfg()
        self.isRareNum = cfg.isRare and 1 or 0
    end
    return self.isRareNum
end

-- 购买次数
function this:BCnt()
    return self.sFlrOrder.bcnt or 0
end

-- 减1
function this:SetBcnt()
    if (self.sFlrOrder.bcnt and self.sFlrOrder.bcnt > 0) then
        self.sFlrOrder.bcnt = self.sFlrOrder.bcnt - 1
    end
end

-- pl是否足够下一次刷新
function this:IsEnoughtForNext()
    local rid = self:GetRid()
    if (rid) then
        local cRoleInfo = CRoleMgr:GetData(rid)
        local pl = cRoleInfo:GetCurRealTv()
        if (pl >= math.abs(cRoleInfo:GetAbilityCurCfg().modTired)) then
            return true
        end
    end
    return false
end

-- 额外增加数量
function this:GetExtraNum()
    return self.sFlrOrder and self.sFlrOrder.cnt or 0
end

return this
