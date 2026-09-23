local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(info)
    self.info = info
end

function this:GetRank()
    return self.info and self.info.rank
end

function this:GetName()
    return self.info and self.info.name
end

function this:GetLevel()
    return self.info and self.info.level
end

function this:GetScore()
    return self.info and self.info.nDamage or ""
end

function this:GetModuleID()
    return  self.info and self.info.icon_id
end

return this