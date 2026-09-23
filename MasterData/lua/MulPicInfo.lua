-- 多人插图数据
-- 卡牌角色基类
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_cfg)
    self.cfg = _cfg
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self:GetCfg().id
end

function this:GetName()
    return self:GetCfg().sName
end
function this:GetL2dName()
    return self:GetCfg().l2dName
end

function this:GetIcon()
    return self:GetCfg().icon
end

function this:GetImg()
    return self:GetCfg().img
end

function this:GetMv()
    return self:GetCfg().mv
end

-- 获取标签
function this:GetTag()
    return self:GetCfg().get_tag
end

function this:GetSort()
    return self:GetCfg().sort
end

function this:GetThemeType()
    return self.cfg.theme_type
end

function this:GetHalfBodyType()
    return self.cfg.theme_type
end

-- 是否已获得
function this:IsHad()
    local count = BagMgr:GetCount(self:GetCfg().itemId)
    return count > 0
end

function this:IsHadNum()
    return self:IsHad() and 1 or 0
end

-- 入手时间 
function this:GetAcquireTime()
    if (not self.acquireTime) then
        self.acquireTime = 0
        local goods = BagMgr:GetData(self:GetCfg().itemId)
        if (goods) then
            self.acquireTime = goods:GetAcquireTime()
        end
    end
    return self.acquireTime
end

-- -- 是否隐藏显示
-- function this:IsNoGetHide()
--     return self:GetCfg().show
-- end

-- 未获得的
-- show:是否是商品 ，shopId:显示逻辑（商品就填商品id，否则填1：显示 不填不显示）
function this:IsShow()
    -- 配置了时间的
    if (self:GetCfg().sStart or self:GetCfg().sEnd) then
        local curTime = TimeUtil:GetTime()
        local sTime = self:GetCfg().sStart and TimeUtil:GetTimeStampBySplit(self:GetCfg().sStart) or nil
        local eTime = self:GetCfg().sEnd and TimeUtil:GetTimeStampBySplit(self:GetCfg().sEnd) or nil
        if ((sTime and curTime < sTime) or (eTime and eTime < curTime)) then
            return false -- 不在显示时间内
        end
    end

    local shopId = self:GetCfg().shopId
    if (self:GetCfg().show) then
        -- 是商品
        local cfg = shopId and Cfgs.CfgCommodity:GetByID(shopId) or nil
        if (cfg) then
            local curTime = TimeUtil:GetTime()
            -- local startTime = cfg.sBuyStart and TimeUtil:GetTimeStampBySplit(cfg.sBuyStart) or nil
            -- local sBuyEnd = cfg.sBuyEnd and TimeUtil:GetTimeStampBySplit(cfg.sBuyEnd) or nil
            local itemData = ShopMgr:GetFixedCommodity(shopId)
            if (itemData) then
                if (itemData and itemData:GetNowTimeCanBuy() and itemData:IsShow()) then
                    return true 
                end
            end
        end
        return false 
    else
        -- 不是商品
        if (shopId ~= nil) then
            return shopId == 1
        end
        return false
    end
end

-- -- 出售中
-- function this:IsInSell()
--     local shopId = self:GetCfg().shopId
--     local cfg = shopId and Cfgs.CfgCommodity:GetByID(shopId) or nil
--     if (cfg) then
--         local curTime = TimeUtil:GetTime()
--         local startTime = cfg.sBuyStart and GCalHelp:GetTimeStampBySplit(cfg.sBuyStart) or nil
--         local sBuyEnd = cfg.sBuyEnd and GCalHelp:GetTimeStampBySplit(cfg.sBuyEnd) or nil
--         if (startTime and curTime < startTime) then
--             return false
--         end
--         if (sBuyEnd and curTime > sBuyEnd) then
--             return false
--         end
--         return true
--     end
--     return false
-- end

function this:GetType()
    return self:GetCfg().nType or 0
end

return this

