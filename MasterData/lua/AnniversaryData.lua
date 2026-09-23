local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(_cfg)
    self.cfg = _cfg
end

function this:GetID()
    return self.cfg and self.cfg.id
end

function this:GetGroup()
    return self.cfg and self.cfg.group
end

function this:GetType()
    return self.cfg and self.cfg.type
end

function this:GetIndex()
    return self.cfg and self.cfg.index or 0
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetEnName()
    return self.cfg and self.cfg.enName or ""
end

function this:GetIcon()
    return self.cfg and self.cfg.icon or ""
end

function this:GetPath()
    return self.cfg and self.cfg.path
end

function this:GetStartTime()
    local startTimeStr = self.cfg and self.cfg.sTime
    if startTimeStr and self.sTime == nil then
        self.sTime = TimeUtil:GetTimeStampBySplit(startTimeStr)
    end
    return self.sTime or 0
end

function this:GetEndTime()
    local endTimeStr = self.cfg and self.cfg.eTime
    if endTimeStr and self.eTime == nil then
        self.eTime = TimeUtil:GetTimeStampBySplit(endTimeStr)
    end
    return self.eTime or 0
end

function this:GetJumpId()
    return self.cfg and self.cfg.jumpId
end

function this:GetSummaryId()
    return self.cfg and self.cfg.summary
end

function this:GetShopId()
    return self.cfg and self.cfg.shop
end

function this:GetActiveId()
    return self.cfg and self.cfg.activity
end

function this:GetCommodityId()
    return self.cfg and self.cfg.commodity
end

function this:GetMissionInfo()
    return self.cfg and self.cfg.mission
end

function this:GetSummaryInfo()
    local cfg = Cfgs.CfgSummary:GetByID(self:GetSummaryId())
    if cfg then
        return cfg.infos
    end
    return nil
end

function this:IsOpen()
    return self:GetStartTime() <= TimeUtil:GetTime() and TimeUtil:GetTime() < self:GetEndTime()
end

return this