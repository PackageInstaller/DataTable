local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
     if cfgId then
        self.cfg=Cfgs.CfgGoldenRebate:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgGoldenRebate中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
    end
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:SetData(_d)
	self.data =_d;
	if self.data then
		self:InitCfg(self.data.id);
	end
end

function this:GetData()
	return self.data
end

function this:GetStartTime()
	if self.data then
		return self.data.startTime
	end
	return self.cfg and TimeUtil:GetTimeStampBySplit(self.cfg.begTime) or 0
end

function this:GetEndTime()
	if self.data then
		return self.data.endTime
	end
	return self.cfg and TimeUtil:GetTimeStampBySplit(self.cfg.endTime) or 0
end

function this:GetInfoByLevel(lv)
	if lv and self.cfg and self.cfg.infos then
		for k, v in ipairs(self.cfg.infos) do
			if v.level==lv then
				return {index=v.index,level=v.level,missionGroup=v.missionGroup,shopId=v.shopId,name=v.name,id=self.cfg.id}
			end
		end
	end
end

function this:GetInfos()
	return self.cfg and self.cfg.infos or {};
end

function this:GetPayDays()
	return self.data and self.data.chargeDay or 0;
end

function this:GetChargeMoney()
	return self.data and self.data.chargeMoney
end

return this;