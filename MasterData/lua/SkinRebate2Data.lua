local this = {};

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins;
end

-- 获取配置表数据
function this:Init(cfg)
    self.cfg = cfg
end

-- 获取协议数据
function this:SetData(v)
    self.data = v
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetIndex()
    return self.cfg and self.cfg.phase
end

function this:GetPercentage()
    return self.cfg and self.cfg.percentage
end

function this:GetStage()
    return self.cfg and self.cfg.picture
end

function this:GetCommodityId()
    return self.data and self.data.commodityId
end

function this:GetBuyTime()
    return self.data and self.data.buyTime
end

function this:GetState()
    return self.data and self.data.state or 0
end

function this:HasCommodity()
    return self.data ~= nil
end

function this:GetPrice()
    return self.data and self.data.buyMoney or 0
end

return this