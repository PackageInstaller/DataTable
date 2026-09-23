local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
	if cfgId then
        self.cfg = Cfgs.cfgMonopolyRandom:GetByID(cfgId)
        if self.cfg == nil then
            LogError("大富翁活动表：cfgMonopolyRandom中未找到ID：" .. tostring(cfgId) .. "对应的数据");
        end
    end
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:GetType()
	return self.cfg and self.cfg.type or RichManEnum.EventType.ExType; 
end

function this:GetValue()
	return self.cfg and self.cfg.value1 or nil;
end

function this:GetAward()
	return self.cfg and self.cfg.award or nil;
end

function this:GetDesc()
	return self.cfg and self.cfg.desc  or "";
end

function this:GetDiceDesc()
	return self.cfg and self.cfg.diceDesc  or "";
end

return this;