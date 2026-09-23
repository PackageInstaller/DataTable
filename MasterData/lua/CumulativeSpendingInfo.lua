--小额付费活动信息
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgMicroPayment:GetByID(cfgId);
    end
    if self.cfg==nil then
        LogError("CfgMicroPayment中找不到对应ID："..tostring(cfgId).."的配置信息");
    end
end

function this:SetData(_data)
	self.data=_data;
	self:InitCfg(self.data.id);
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:GetName()
	return self.cfg and self.cfg.name or "";
end

function this:GetType()
	return self.cfg and self.cfg.nType or 1;
end

function this:GetIndex()
	return self.cfg and self.cfg.index or 9999;
end

function this:GetOpenType()
	return self.cfg and self.cfg.openType or nil;
end

function this:GetIcon()
	return self.cfg and self.cfg.img or nil;
end

function this:GetTriggerId()

end

function this:IsOpen()
	local sTime=self:GetStartTimeStamp();
	local eTime=self:GetEndTimeStamp();
	local cTime=TimeUtil:GetTime();
	local isOpen=false;
	if (sTime == 0 and eTime == 0) then
        isOpen= false;
    elseif (sTime~=0 and cTime >= sTime) then
        if (eTime~=0 and cTime < eTime) then
            isOpen= true
		elseif eTime==0 then
			isOpen= true;
        end
    end
	return isOpen;
end

function this:GetStartTime()
	return self.cfg and self.cfg.startTime or nil;
end

function this:GetEndTime()
	return self.cfg and self.cfg.endTime or nil;
end

function this:GetStartTimeStamp()
	local time=0;
	if self.data then
		return self.data.startTime;
	elseif self:GetStartTime()~=nil then
		if type(self:GetStartTime())=="number" then
			time=self:GetStartTime()
		else
			time=TimeUtil:GetTimeStampBySplit(self:GetStartTime())
		end
	end
	return time;
end

function this:GetEndTimeStamp()
	local time=0;
	if self.data then
		return self.data.endTime;
	elseif self:GetEndTime()~=nil then
		if type(self:GetEndTime())=="number" then
			time=self:GetEndTime()
		else
			time=TimeUtil:GetTimeStampBySplit(self:GetEndTime())
		end
	end
	return time;
end

function this:GetDesc()
	return self.cfg and self.cfg.des or ""
end

function this:GetCommodityList()
	local comms=nil;
	if self.cfg and self.cfg.shopItem then
		comms={};
		for k,v in ipairs(self.cfg.shopItem) do
			table.insert(comms,ShopMgr:GetFixedCommodity(v));
		end
	end
	return comms;
end

function this:GetOverRewards()
    local comms = {};
    if self.cfg and self.cfg.bigReward then
        for k, v in ipairs(self.cfg.bigReward) do
            local comm = ShopMgr:GetFixedCommodity(v)
            table.insert(comms, comm);
        end
    end
    return comms;
end

function this:IsOverRewards(id)
	local isTrue=false;
	if self.cfg and self.cfg.bigReward and id then
        for k, v in ipairs(self.cfg.bigReward) do
            if v == id then
                isTrue = true;
                break;
            end
        end
    end
	return isTrue;
end

function this:GetLockCfg(cfgId)
	local cfg=nil;
    if cfgId then
        cfg=Cfgs.CfgMicroCondtion:GetByID(cfgId);
    end
    if cfg==nil then
        LogError("CfgMicroCondtion中找不到对应ID："..tostring(cfgId).."的配置信息");
    end
	return cfg;
end

--返回商品解锁状态 commId:指定商品ID
function this:GetLockState(commId)
	local isLock=false;
	local desc="";
	if commId==nil or commId=="" then
		return isLock,desc;
	end
	local lockData=self.data and self.data.data or nil
	local lockCfg=self:GetLockCfg(commId);
	if lockData~=nil and lockCfg~=nil and lockCfg.conditiontype~=nil then
		local params={};
		local state=true
		for i, v in ipairs(lockCfg.conditiontype) do
			local key=eSmallPayDataName[v];
			local max=0;
			local val=0;
			local dungeonName=nil;
			local dungeonChap=nil;
			if key~=nil then
				if v==eSmallPayConType.Login then --登陆天数
					val=lockData[key] or 0;
					max=lockCfg.conditionnum1 and lockCfg.conditionnum1[i] or 0;
				elseif v==eSmallPayConType.ReduceHot then --消耗体力数量
					val=lockData[key] or 0;
					max=lockCfg.conditionnum1 and lockCfg.conditionnum1[i] or 0;
				elseif v==eSmallPayConType.PassDup then --通关关卡次数
					local key2=lockCfg.conditionnum1 and lockCfg.conditionnum1[i] or nil;
					if key2~=nil then
						local dungeonCfg= Cfgs.MainLine:GetByID(key2);
						dungeonName=dungeonCfg and dungeonCfg.name or "";
						dungeonChap=dungeonCfg and dungeonCfg.chapterID or "";
					else
						dungeonName="";
					end
					if key2~=nil and lockData[key]~=nil then
						val=lockData[key][key2] or 0;
					end
					max=lockCfg.conditionnum2 and lockCfg.conditionnum2[i] or 0;
				end
			end
			if dungeonName~=nil then
				table.insert(params,dungeonChap);
				table.insert(params,dungeonName);
			end
			if state==true then
				state=val<max
			end
			table.insert(params,val)
			table.insert(params,max)
		end
		desc=LanguageMgr:GetByID(lockCfg.languageid,table.unpack(params))
		isLock=state;
	end
	return isLock,desc;
end

return this;