--光环解锁条件
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
	if cfgId then
        self.cfg=Cfgs.cfgHaloCondition:GetByID(cfgId);
    end
    if self.cfg==nil then
        LogError("cfgHaloCondition中找不到对应ID："..tostring(cfgId).."的配置信息");
    end
end

--设置下标（自定义参数，不一定有，主要用于区分在一组条件中当前条件属于第几个）
function this:SetIndex(i)
	self.index=i;
end

function this:GetIndex()
	return self.index or 0;
end

function this:GetType()
	return self.cfg and self.cfg.type or nil;
end

function this:GetParam()
	return self.cfg and self.cfg.param1 or nil;
end

function this:GetUnLockDesc()
	return self.cfg and self.cfg.unlockdesc or "";
end

function this:IsPass(cardData,haloLv)
	if cardData~=nil then
		local type=self:GetType();
		local param=self:GetParam();
		if type==HaloEnum.HaloCondType.CardLv then
			param=tonumber(param);
			return cardData:GetLv()>=param,self:GetUnLockDesc();
		elseif type==HaloEnum.HaloCondType.CardBreakLv then
			param=tonumber(param);
			return cardData:GetBreakLevel()>=param,self:GetUnLockDesc();
		elseif type==HaloEnum.HaloCondType.HaloLv then
			param=tonumber(param);
			haloLv=haloLv or 0;
			return haloLv>=param,self:GetUnLockDesc();
		end
	end
	return false,self:GetUnLockDesc()
end


return this;