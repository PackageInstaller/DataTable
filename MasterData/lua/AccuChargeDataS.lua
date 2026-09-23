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

function this:GetID()
    return self:GetCfg().id
end

function this:GetCfg()
    return self.cfg
end

function this:GetCur()
    return math.floor(self.cfg.money / 100)
end

function this:GetNums()
    return AccuChargeMgr:GetScore2(), self:GetCur()
end

function this:CheckIsFinish()
    return AccuChargeMgr:GetScore2() >= self:GetCur()
end

function this:CheckIsGet()
    return AccuChargeMgr:CheckIsGet2(self.cfg.id)
end

function this:GetSortType()
    self.sType = 0
    if (not self:CheckIsGet()) then
        self.sType = self:CheckIsFinish() and 2 or 1
    end
    return self.sType
end

function this:IsRed()
    return self:GetSortType() == 2
end

return this
