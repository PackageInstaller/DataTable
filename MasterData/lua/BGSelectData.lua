local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_cfg)
    self.cfg = _cfg
    self:SetIsGet()
end
function this:SetIsGet()
    self.isGet = false
    local item_id = self:GetCfg().item_id
    if (item_id) then
        local goodsData = BagMgr:GetData(item_id)
        if (goodsData and goodsData:GetCount() > 0) then
            self.isGet = true
            return self.isGet
        end
    end
    return self.isGet
end
function this:IsGet()
    return self.isGet
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg.id
end

function this:GetSortIndex()
    if(self:IsGet()) then 
        return 0
    end 
    return 1
end

return this
