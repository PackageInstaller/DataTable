local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_cfg)
    self.cfg = _cfg

    self:CheckCanUse()
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg.id
end

function this:GetItemID()
    return self.cfg.item_id
end

function this:GetName()
    return self.cfg.avatarname or ""
end

-- 描述
function this:GetDesc()
    return ""
end

-- 获取途径 
function this:GetPath()
    return self.cfg.accessmethods or ""
end

function this:GetType()
    return self.cfg.type or 1
end

-- 是否可用，过期时间
function this:CheckCanUse()
    local isCanUse = false -- 是否可用  
    local expiry = nil -- 过期时间 

    if (self.cfg.id == 1) then
        isCanUse = true
        return isCanUse, expiry
    end
    local goodsData = self:GetItemID() ~= nil and BagMgr:GetData(self:GetItemID()) or nil
    if (goodsData == nil or goodsData:GetCount() < 1) then
        return isCanUse, expiry
    end
    local _expiry = goodsData:GetHeadFrameExpiry()
    if (not _expiry or _expiry > TimeUtil:GetTime()) then
        isCanUse = true
        expiry = _expiry
    end
    return isCanUse, expiry
end

function this:CheckUse()
    return PlayerClient:GetIconTitle() == self:GetID()
end

-- 如果是商店物品并且不在可售时间则不显示（已购买则一直显示）
function this:CheckNeedShow()
    if (self:CheckCanUse()) then
        return true
    end
    if (self.cfg.shopId) then
        local shopId = self:GetCfg().shopId
        local itemData = ShopMgr:GetFixedCommodity(shopId)
        if (itemData and itemData:GetNowTimeCanBuy() and itemData:IsShow()) then
            return true
        end
        return false
    end
    --ishide
    if (self.cfg.isShow) then
        return false
    end
    return true
end

function this:GetSortIndex()
    return self.cfg.index 
end

return this
