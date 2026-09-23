local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_cfg)
    self.cfg = _cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetViewName()
    return self.cfg and self.cfg.viewName or ""
end

function this:GetActiveId()
    return self.cfg and self.cfg.activeId
end

function this:GetIndex()
    return self.cfg and self.cfg.index
end

return this