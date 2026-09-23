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
    return self:GetCfg().id
end

function this:GetCfg()
    return self.cfg
end

function this:IsBuy()
    local count = BagMgr:GetCount(self:GetCfg().item)
    return count > 0
end

function this:IsDownload()
    return true--ASMRMgr.IsDownloadedCV(self:GetCfg().cue_sheet2) -- 等再次打包时才改回下载模式
end

function this:IsRed()
    return ASMRMgr:CheckRed(self:GetCfg().item)
end

return this
