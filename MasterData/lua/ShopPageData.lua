--商店分页数据
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end


function this:SetCfg(cfgId)
	if(cfgId == nil) then
		LogError("初始化商店分页数据失败！无效配置id");		
	end
	if(self.cfg == nil) then		
		self.cfg = Cfgs.CfgShopPage:GetByID(cfgId);
		if(self.cfg == nil) then		
			LogError("找不到商店分页数据！id = " .. cfgId);	
		end
	end
end

function this:SetData(data)
	self.data=data;
end

--返回商店名多语言ID
function this:GetNameID()
	return self.cfg and self.cfg.nameID or nil;
end

function this:GetName()
	return self.cfg and self.cfg.sName or nil;
end

function this:GetIcon()
	return self.cfg and self.cfg.icon or nil;
end

function this:GetIsHot()
	return self.cfg and self.cfg.isHot==1 or nil;
end

function this:GetStoreVer()
	return self.cfg and self.cfg.storeVer or nil;
end

--返回ID
function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

--是否默认打开
function this:IsDefaultOpen()
	return self.cfg and self.cfg.nDefault == 1 or false;
end

--返回页面商品类型
function this:GetCommodityType()
	return self.cfg and self.cfg.commodityType or nil;
end

function this:GetTips()
	return self.cfg and self.cfg.tips or nil;
end

function this:IsHide()
	return self.cfg and self.cfg.isHide or false;
end

function this:GetOpenTime()
	local time = self:GetOpenTimeData();
	if time>0 then
		return TimeUtil:GetTimeStr2(time);
	else
		return nil;
	end
end

function this:GetCloseTime()
	local time = self:GetCloseTimeData();
	if time>0 then
		return TimeUtil:GetTimeStr2(time);
	else
		return nil;
	end
end

function this:GetCheckNew()
	return self.cfg and self.cfg.checkNew==1 or false;
end

--返回开始时间秒数
function this:GetOpenTimeData()
	local time = 0;
	if self.data and self.data.open_time then
		time = self.data.open_time;
	end
	return time;
end

--返回关闭时间秒数
function this:GetCloseTimeData()
	local time = 0;
	if self.data and self.data.close_time then
		time = self.data.close_time;
	end
	return time;
end


--是否在开启时间内
function this:IsOpen()
	local isOpen = false;
	local currentTime = TimeUtil:GetTime();
	local openTime = self:GetOpenTimeData();
	local closeTime = self:GetCloseTimeData()
	if openTime == 0 and closeTime == 0 then
		isOpen = true;
	elseif (openTime==0 or currentTime >= openTime) and (closeTime==0 or currentTime < closeTime) then
		isOpen = true;
	end
	return isOpen;
end

--返回商品展示的类型
function this:GetShowType()
	return self.cfg and self.cfg.showType or 1;
end

function this:GetBG()
	return self.cfg and self.cfg.bg or "bg_27";
end

--特殊货币类型
function this:GetGoldType()
	return self.cfg.goldInfo;
end

--返回固定类型中需要检测刷新的数据列表
function this:GetRefreshInfos(topTabID)
	local itemDatas = {};
	if self:GetCommodityType()==CommodityType.Normal then
		--固定道具
		local cfgs=Cfgs.CfgCommodity:GetGroup(self:GetID());
		if cfgs then
			local nowTime=TimeUtil:GetTime();
			for k, v in ipairs(cfgs) do
				local itemData =ShopMgr:GetFixedCommodity(v.id)
				local beginTime=itemData:GetBuyStartTime();
				local endTime=itemData:GetBuyEndTime();
				local resetTime=itemData:GetResetTime();;
				-- if itemData:HasData() and ((itemData:GetResetType()~=0 and (resetTime==0 or nowTime<=resetTime)) or (beginTime~=nil and nowTime<=beginTime) or (endTime~=nil and nowTime<=endTime)) and ((topTabID~=nil and itemData:GetTabID()==topTabID) or topTabID==nil) then 
				local canAdd=true;
				if CSAPI.IsAppReview() and self:GetShowType()==6 and itemData:GetType()==CommodityItemType.Skin and itemData:GetID()~=ShopCommFunc.fixedSkinID then--皮肤
					canAdd=false;
				end
				if itemData:HasData() and ((itemData:GetResetType()~=0 and (itemData:GetResetTime()==0 or nowTime<=itemData:GetResetTime())) or (beginTime~=nil and nowTime<=beginTime) or (endTime~=nil and nowTime<=endTime)) and ((topTabID~=nil and itemData:GetTabID()==topTabID) or topTabID==nil) and canAdd==true then 
					-- if itemData:GetID()==80001 then
					-- 	LogError("22222222222222222222");
					-- end
					table.insert(itemDatas, itemData);
				end
			end
		end
	end
	return itemDatas;
end

--返回该页面中的商品信息 isLimit:是否剔除不满足显示条件的数据 topTabID:筛选出对应topTab的数据
function this:GetCommodityInfos(isLimit,topTabID)
	local itemDatas = {};
	local tabCfg=topTabID==nil and nil or Cfgs.CfgShopTab:GetByID(topTabID);
	-- local ids={80012,80013,80014,80015};
	if self:GetCommodityType()==CommodityType.Normal then
		--固定道具
		local cfgs=Cfgs.CfgCommodity:GetGroup(self:GetID());
		if cfgs then
			for k, v in ipairs(cfgs) do
				local itemData = ShopMgr:GetFixedCommodity(v.id,true);
				local canAdd=true;
				-- for _,val in ipairs(ids) do
				-- 	if itemData:GetID()==val then
				-- 		LogError(tostring(itemData:GetID()).."\t"..tostring(itemData:GetName()).."\t"..tostring(itemData:GetBuyStart()).."\t"..tostring(itemData:GetBuyEnd()).."\t"..tostring(itemData:GetDiscountStart()).."\t"..tostring(itemData:GetDiscountEnd()));
				-- 	end
				-- end
				if (tabCfg and tabCfg.isAll~=1 and itemData:GetTabID()~=topTabID) or itemData:HasData()~=true or (tabCfg==nil and topTabID~=nil) then
					canAdd=false;
				end
				if itemData:IsShow()~=true or (itemData:IsOver() and itemData:ShowOnSoldOut()~=true) then--售罄时不显示的数据
					canAdd=false;
				end
				if CSAPI.IsAppReview() and self:GetShowType()==6 and itemData:GetType()==CommodityItemType.Skin and canAdd==true and itemData:GetID()~=ShopCommFunc.fixedSkinID then--皮肤
					canAdd=false;
				end
				if itemData:GetType()==CommodityItemType.MonthCard and itemData:GetSubType()==CommodityItemSubType.MonthCard2 and canAdd==true then --限时月卡
					--没有剩余数量且没有剩余天数就不显示
					local monthInfo=itemData:GetMonthCardInfo();
					if monthInfo and monthInfo.l_cnt==0 and itemData:IsOver() then
						canAdd=false;
					else
						canAdd=true;
					end
				end
				-- if itemData:GetShopID()==4 then
				-- 	LogError(itemData:GetID().."\t"..tostring(itemData:IsShow()).."\t"..tostring(itemData:IsOver()).."\t canAdd:"..tostring(canAdd))
				-- end
				if isLimit then
					-- if itemData:GetType()==CommodityItemType.Skin then
					-- 	if itemData:GetID()==50003 or itemData:GetID()==50005 then
					-- 		LogError(itemData:GetName().."\t"..tostring(itemData:GetShowLimitRet()).."\t"..tostring(itemData:GetNowTimeCanBuy()).."\t"..tostring(canAdd))
					-- 	end
					-- end
					if itemData:GetShowLimitRet() and itemData:GetNowTimeCanBuy() and canAdd==true then --满足显示条件和购买开始时间则可以显示
						table.insert(itemDatas, itemData);
					end
				elseif canAdd then
					table.insert(itemDatas, itemData);
				end
			end
		end
	elseif self:GetCommodityType()==CommodityType.Rand then
		--随机道具 读取奖励表
		local cfg = Cfgs.CfgRandCommodity:GetGroup(self:GetID())[1]
		local randInfo=nil;
		if cfg then
			randInfo=ShopMgr:GetExchangeData(cfg.id);
		end
		if randInfo then
			local nRewardID=cfg.nRewardId;--商店掉落池ID
			local rewardCfg=Cfgs.RewardInfo:GetByID(nRewardID);
			for k,v in ipairs(randInfo.infos) do
				local sortIdx=v.index;
				if nRewardID~=v.reward_id then --根据当前掉落池ID获取index
					for _, c in ipairs(rewardCfg.item) do
						if c.id==v.reward_id then
							sortIdx=c.index;
						end
					end
				end
				local itemData=RandCommodityData.New();
				itemData:SetData(v,sortIdx);
				itemData:SetShopID(cfg.group);
				itemData:SetPoolID(cfg.id);
				itemData:SetExchangeIndex(k);
				table.insert(itemDatas,itemData);
			end
		end
	end
	return itemDatas;
end

--投资方晶用
function this:GetCommodityInfos2()
	local itemDatas = {};
	local cfgs=Cfgs.CfgCommodity:GetGroup(self:GetID());
	local lastItem = nil
	if cfgs then
		for k, v in ipairs(cfgs) do
			local itemData = ShopMgr:GetFixedCommodity(v.id);
			local canAdd=true;
			if itemData:GetPreLimitID() then
				local _itemData = ShopMgr:GetFixedCommodity(itemData:GetPreLimitID())
				if _itemData and not _itemData:IsOver() then
					--上一个商品已开放购买
					if _itemData:GetPreLimitID() then
						local _itemData2 = ShopMgr:GetFixedCommodity(_itemData:GetPreLimitID())
						if _itemData2 and not _itemData2:IsOver() then
							canAdd = false
						end
					end
				end
			end
			-- if itemData:IsOver() and itemData:ShowOnSoldOut()~=true then--售罄时不显示的数据
			-- 	canAdd=false;
			-- end
			if canAdd then
				table.insert(itemDatas, itemData);
			end
		end
	end
	return itemDatas
end

function this:ShowExchange()
	if self.cfg and self.cfg.fragmentExchange==1 then
		return true;		
	end
	return false;
end

function this:GetFragmentExchange()
	return self.cfg and self.cfg.fragmentExchange or nil;
end

function this:GetSort()
	return self.cfg and self.cfg.sort or 10000;
end

function this:GetUpdateTime()
	return self.cfg and self.cfg.updateTime or ShopFixedUpdateType.None;
end

--返回二级菜单 isFitler:为true时去掉不在显示时间内的数据，且页签下无可购买数据时也隐藏
function this:GetTopTabs(isFitler)
	local list=nil;
	if self.cfg and self.cfg.topGroup then
		local cfgs=Cfgs.CfgShopTab:GetGroup(self.cfg.topGroup);
		if isFitler then
			for k,v in ipairs(cfgs) do
				local isOpen=self:GetChildPageIsOpen(v);
				if isOpen then
					list=list or {};
					table.insert(list,v)
				end
			end
		else
			list=cfgs;
		end
		if CSAPI.IsAppReview() and list then
			for k,v in ipairs(list) do
				if v.id==ShopCommFunc.fixedHideTab then
					table.remove(list,k);
					break;
				end
			end
		end
		if list then
			table.sort(list,function(a,b)
				return a.index<b.index;
			end);
		end
	end
	return list;
end

--返回子页面配置信息
function this:GetChildPageData(id,isFilter)
	if CSAPI.IsAppReview() and id==ShopCommFunc.fixedHideTab then
		return nil
	elseif isFilter then
		local isOpen,cfg=self:GetChildPageIsOpen(nil,id);
		return cfg;
	else
		local cfg=Cfgs.CfgShopTab:GetByID(id);
		return cfg;
	end
end

function this:GetChildPageIsOpen(_cfg,id)
    local isOpen = false;
	local cfg=_cfg;
	if cfg==nil and id~=nil then
		cfg=Cfgs.CfgShopTab:GetByID(id);
		if cfg==nil then
			return isOpen,nil;
		end
	elseif cfg==nil  and id==nil then
		return  isOpen,nil;
	end
    local timeInfo = ShopMgr:GetPageTimeInfo(self:GetID(), cfg.id);
    local startTime = cfg.startTime == nil and 0 or TimeUtil:GetTimeStampBySplit(cfg.startTime);
    local endTime = cfg.endTime == nil and 0 or TimeUtil:GetTimeStampBySplit(cfg.endTime);
    if timeInfo then
        startTime = timeInfo.open_time;
        endTime = timeInfo.close_time;
    end
    if startTime == 0 and endTime == 0 then
        -- isOpen = true;
        local itemList = self:GetCommodityInfos(true, cfg.id);
        isOpen = #itemList > 0 and true or false;
    else
        local itemList = self:GetCommodityInfos(true, cfg.id);
        if #itemList > 0 then
            isOpen = ShopCommFunc.TimeIsBetween2(startTime, endTime);
        else
            isOpen = false;
        end
    end
	return isOpen,cfg;
end

--返回刷新/新出现的物品ids topTabID:二级页签ID
function this:GetRefreshCommIds(topTabID)
	local ids=nil;
	local list=self:GetCommodityInfos(true,topTabID);
	if self:GetCommodityType()==CommodityType.Normal then
		--检查每个商品是否有记录，记录时间是否小于当前重置时间，小于则判定为新物品
		for k, v in ipairs(list) do
			local record=ShopMgr:GetCommResetRecord(self:GetID(),topTabID,v:GetID());
			local currResetTime=nil;
			if v:GetResetTime()>0 then --下一次的重置时间大于0
				currResetTime=v:GetResetTime();
			elseif v:GetBuyStartTime()>0 and v:GetNowTimeCanBuy() then --存在能购买的时间切目前可以购买
				currResetTime=v:GetBuyStartTime();
			end
			-- Log(record)
			-- LogError(tostring(v:GetID()).."\t"..tostring(record).."\t"..tostring(currResetTime).."\t"..tostring(record and currResetTime~=record))
			-- if record==nil or (record and record~=0 and currResetTime>=record) then
			if (record==nil and currResetTime~=nil) or (record and currResetTime~=record) then
				ids = ids or {};
				table.insert(ids,v:GetID());
			end
		end
	end
	return ids;
end

--返回当前的商品的刷新时间
function this:GetCommRefreshInfos(topTabID)
	--有重置则使用每次重置的事件，没有重置则使用购买开始的时间
	local infos=nil;
	local list=self:GetCommodityInfos(true,topTabID);
	if self:GetCommodityType()==CommodityType.Normal then
		for k, v in ipairs(list) do
			local currResetTime=0;
			if v:GetResetTime()>0 then --下一次的重置时间大于0
				currResetTime=v:GetResetTime();
			elseif v:GetBuyStartTime()>0 and v:GetNowTimeCanBuy() then --存在能购买的时间切目前可以购买
				currResetTime=v:GetBuyStartTime();
			end
			if currResetTime>0 then
				infos = infos or {};
				infos[v:GetID()]=currResetTime;
			end
		end
	end
	return infos;
end

return this; 