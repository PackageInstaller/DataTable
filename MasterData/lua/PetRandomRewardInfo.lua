--宠物随机奖励信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId,idx)
    if cfgId then
        self.cfg=Cfgs.CfgPetRandomReward:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgPetRandomReward中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
        if idx and idx<=#self.cfg.infos then
            self.cfg2=self.cfg.infos[idx];
        else
            LogError("PetRandomRewardInfo下标越界！"..tostring(idx));
        end
    end
end

function this:GetFeedNum()
    return self.cfg2 and self.cfg2.feedNum or 0;
end

function this:GetTime()
    return self.cfg2 and self.cfg2.time or 0;
end

function this:GetRewardId()
    return self.cfg2 and self.cfg2.reward or 0;
end

return this