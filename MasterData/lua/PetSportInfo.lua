--宠物运动信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgPetSport:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgPetSport中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id or 1;
end

function this:GetName()
    return self.cfg and self.cfg.name or ""
end

function this:GetPicture()
    return self.cfg and self.cfg.picture or ""
end

function this:GetIcon()
    return self.cfg and self.cfg.icon or ""
end

function this:GetDesc()
    return self.cfg and self.cfg.des or "";
end

function this:GetIntervalTime()
    return self.cfg and self.cfg.interval or 30;
end

function this:GetHappyChange(idx)
    if idx and self.cfg and self.cfg.infos[idx] then
        return self.cfg.infos[idx].happyChange
    end
    return 0
end

function this:GetFoodChange(idx)
    if idx and self.cfg and self.cfg.infos[idx] then
        return self.cfg.infos[idx].foodChange
    end
    return 0
end

function this:GetWashChange(idx)
    if idx and self.cfg and self.cfg.infos[idx] then
        return self.cfg.infos[idx].washChange
    end
    return 0
end

function this:GetMinTime()
    local time=0;
    if  self.cfg and self.cfg.time then
        time=self.cfg.time[1]
    end
    return time;
end

function this:GetMaxTime()
    local time=0;
    if self.cfg and self.cfg.time then
        time=self.cfg.time[2]
    end
    return time;
end

return this