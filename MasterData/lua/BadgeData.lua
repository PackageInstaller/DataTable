local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--设置配置
function this:Init(cfg)
    self.cfg = cfg
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg and self.cfg.id or 0 
end

function this:GetGroup()
    return self.cfg and self.cfg.group or 0 
end

function this:GetIcon()
    return self.cfg and self.cfg.icon or ""
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetTag()
    return self.cfg and self.cfg.tag or ""
end

function this:GetDesc()
    return self.cfg and self.cfg.desc or ""
end

function this:GetEffect()
    return self.cfg and self.cfg.effect or ""
end

function this:GetTimeStr()
    local str = ""
    if self.finishTime then
        str = TimeUtil:GetTimeStr2(self.finishTime,false)
    end
    return str
end

function this:GetType()
    return self.cfg and self.cfg.type
end

function this:GetSort()
    return self.cfg and self.cfg.sort or 0
end

function this:GetTypeSort()
    return self.cfg and self.cfg.typeSort or 0
end

function this:GetQuality()
    return self.cfg and self.cfg.quality or 0
end

function this:SetIsNew(b)
    self.isNew = b
end

function this:GetIsNew()
    return self.isNew
end

function this:SetFinishTime(time)
    self.finishTime = time
end

function this:GetFinishTime()
    return self.finishTime or 0
end

function this:IsGet()
    if self.finishTime and self.finishTime> 0 then
        return true
    end
    return false
end
function this:IsHide()
    return self.cfg and self.cfg.nIsHide
end

--获取开始时间
function this:GetStartTime()
    local time = 0
    if self.cfg and self.cfg.begTime then
        time = TimeUtil:GetTimeStampBySplit(self.cfg.begTime)
    end
    return time
end

return this;