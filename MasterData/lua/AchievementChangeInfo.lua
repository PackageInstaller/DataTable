local this = {};

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_data)
    self.data = _data
    self.cfg = _data.cfg
end

function this:GetData()
    return self.data
end

function this:GetType()
    return 101
end

function this:GetCfgID()
    return self.cfg and self.cfg.id
end

function this:GetDesc()
    return self.cfg and self.cfg.sDescription
end


return this