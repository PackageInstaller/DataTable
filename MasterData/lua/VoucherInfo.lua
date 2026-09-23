--折扣券信息
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化折扣券数据失败！无效配置id")
    end
    if (self.cfg == nil) then
        self.cfg = Cfgs.CfgVoucher:GetByID(cfgId)
        if (self.cfg == nil) then
            LogError("找不到折扣券数据！id = " .. cfgId)
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetType()
    return self.cfg and self.cfg.voucherType or 1;
end

function this:GetReduceId()
    return self.cfg and self.cfg.reduceId or 0
end

function this:GetReduceNum()
    return self.cfg and self.cfg.reduceNum or 0
end

function this:GetMinCost()
    return self.cfg and self.cfg.minCost or 0
end

function this:GetMinLevel()
    return self.cfg and self.cfg.minLevel or 0
end

function this:GetMixUse()
    return self.cfg and self.cfg.mixUse==true or false
end

function this:GetMixDiscount()
    return self.cfg and self.cfg.mixDiscount==true or false
end

function this:GetDesc()
    return self.cfg and self.cfg.describe or ""
end

--检查是否可以使用
function this:CheckCanUse(commodity,num,shopPriceKey)
    local canUse=false;
    num=num or 1;
    if commodity and commodity:CanUseVoucher(self:GetType()) then
        if PlayerClient:GetLv()<self:GetMinLevel() then--低于使用等级
            return canUse;
        end
        if commodity:GetNowDiscount()<1 and self:GetMixDiscount()~=true then --不能与折扣券一起使用
            return canUse;
        end
        local goods=commodity:GetCommodityList();
        local priceInfos=commodity:GetRealPrice(shopPriceKey);
        local price=priceInfos and priceInfos[1] or nil;
        local realNum=price and price.num*num or 0;
        if (price and (price.id~=self:GetReduceId() or realNum<self:GetMinCost()) or price==nil) then --低于最低使用价格或者抵扣物品不一致
            return false;
        end
        canUse=true;
    end
    return canUse;
end

return this