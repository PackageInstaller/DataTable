--商品数据管理
local this = MgrRegister("ShopMgr")
require "LoginCommFuns"
-- Init函数中 存放了从服务器获取到的商店购买记录
function this:Init()
	EventMgr.AddListener(EventType.Player_Update,this.OnPlayerUpdate)
end

function this:OnCommodityInfoRet(proto)
	if proto and proto.infos then
		for k, v in ipairs(proto.infos) do
			this:UpdateData(v.id, v);
		end
		self:UpdateMonthDays(proto.m_cnt); --只针对普通月卡有效
	end
	if proto and proto.is_finish then --发送完成
		-- LogError("ShopInit-------------");
		self:SearchRefreshIDs();
		if self.localRecords ==nil then
			self:LoadLocalRecord();
		end
		if self.storeVerInfo==nil then
			local info=FileUtil.LoadByPath("StoreVer.txt");
			if info and info.ver~=nil then
				self.storeVerInfo=self.storeVerInfo or {}
				self.storeVerInfo[4]={ver=info.ver}
			else
				self.storeVerInfo=info;
			end
		end
		self:CheckCommReset();
		-- self:CheckRedInfo();
	end
end

--初始化商店页签开启/关闭时间
function this:InitShopOpenTime(proto)
	if proto and proto.infos then
		self.shopOpenTimes=self.shopOpenTimes or {};
		for k,v in ipairs(proto.infos) do
			local key=tostring(v.shop_id);
			if v.group_id then
				key=string.format("%s_%s",v.shop_id,v.group_id);
			end
			self.shopOpenTimes[key]=v;
		end
	end
end

--获取商店开启时间信息 id 页签id group_id 子页签id
function this:GetPageTimeInfo(id,group_id)
	if self.shopOpenTimes then
		local key=tostring(id);
		if group_id then
			key=string.format("%s_%s",id,group_id);
		end
		return self.shopOpenTimes[key];
	end
end

function this.OnPlayerUpdate()
	this:CheckRedInfo();
end
-- local ids={80001,50003,50004,80025,80027,80107,80108}
function this:UpdateData(id, info,checkRed)
	if self.records == nil then
		self.records = {};
	end
	self.records[id] = info;
	self.comms=self.comms or {};
	if self.comms[id]==nil then
		local itemData = CommodityData.New();
		itemData:SetCfg(id);
		itemData:SetData(info);
		self.comms[id]=itemData;
	else
		local itemData=self.comms[id];
		itemData:SetData(info);
	end
	if checkRed then
		self:CheckRedInfo();
		self:CheckRegressionShopRedInfo();
	end
end

--更新月卡\周卡信息
function this:UpdateMonthCard(proto)
	self.monthCardInfo=proto.infos;
	self:CheckRedInfo();
	EventMgr.Dispatch(EventType.Shop_MonthCard_DaysChange,self:GetMonthCardDays());
end

--返回月卡信息
function this:GetMonthCardInfo(type)
	if self.monthCardInfo then
		for k,v in ipairs(self.monthCardInfo) do
			local goods=GoodsData({id=v.item_id});
			if goods and goods:GetMemberCardType()==type then
				return v;
			end
		end
	end
end

function this:GetMonthCardInfoByID(id)
	if self.monthCardInfo then
		for k,v in ipairs(self.monthCardInfo) do
			if v.item_id==id then
				return v;
			end
		end
	end
end

function this:UpdateMonthDays(days)
	self.m_cnt=days or 0;
	EventMgr.Dispatch(EventType.Shop_MonthCard_DaysChange,self.m_cnt);
end

--返回月卡有效期
function this:GetMonthCardDays()
	local info = self:GetMonthCardInfoByID(ITEM_ID.MonthCard);
	if info~=nil then
		return info.l_cnt;
	end
	return self.m_cnt or 0;
end

--返回已开启的商店页数据
function this:GetPageByID(id)
	if id then
		local cfg=Cfgs.CfgShopPage:GetByID(id);
		if cfg then
			local pageData=ShopPageData.New();
			pageData:SetCfg(id);
			pageData:SetData(self:GetPageTimeInfo(id));
			--判断当前商店是否开启
			if pageData:IsOpen() then--当前商店页开启则返回
				return pageData;
			end
		end
	end
	return nil;
end

function this:GetCommodityTypeByData(comm)
	if comm then
		local pageData=self:GetPageByID(comm:GetShopID(),comm:GetTabID())
		if pageData then
			return pageData:GetCommodityType();
		end
	end
end

function this:CheckRedInfo()
	local data=nil;
    local page=self:GetPageByID(3);--检测礼包页是否有免费礼包领取
	if page then
		for k,v in ipairs(page:GetCommodityInfos(true)) do
			local price=v:GetRealPrice();
			if (price==nil or (price and price.num==0)) and v:IsOver()~=true and v:GetBuyLimit() then --免费物品且未售罄
				data= data or {};
				data[page:GetID()]=data[page:GetID()] or {}
				data[page:GetID()][v:GetID()]=data[page:GetID()][v:GetID()] or true;
				if v:GetTabID()~=nil then
					data.cTab=data.cTab or {};
					data.cTab[v:GetTabID()]=data.cTab[v:GetTabID()] or true;
				end
			end
		end
	end
	if self.pagesNewInfo~=nil and next(self.pagesNewInfo) then
		data=data or {};
		data.isRed=true;
	end
    RedPointMgr:UpdateData(RedPointType.Shop,data)  
end

--回归商店的红点
function this:CheckRegressionShopRedInfo()
	local data=self:GetRegressionShopRedInfo();
    RedPointMgr:UpdateData(RedPointType.RegressionShop,data)  
end

function this:GetRegressionShopRedInfo()
	local data=nil;
	if RegressionMgr==nil or (RegressionMgr~=nil and RegressionMgr:IsHuiGui()~=true)  then --非回归玩家则返回空
		return data;
	end
    local page=self:GetPageByID(3001);--检测是否有免费礼包领取
	if page then
		for k,v in ipairs(page:GetCommodityInfos(true)) do
			local price=v:GetRealPrice();
			if (price==nil or (price and price.num==0)) and v:IsOver()~=true and v:GetBuyLimit() then --免费物品且未售罄
				data= data or {};
				data[page:GetID()]=data[page:GetID()] or {}
				data[page:GetID()][v:GetID()]=data[page:GetID()][v:GetID()] or true;
				if v:GetTabID()~=nil then
					data.cTab=data.cTab or {};
					data.cTab[v:GetTabID()]=data.cTab[v:GetTabID()] or true;
				end
			end
		end
	end
	return data;
end

--返回所有已开启的商店页数据 isHide:是否隐藏不显示的商店
function this:GetAllPages(isHide)
	local list={};
	for k,v in pairs(Cfgs.CfgShopPage:GetAll()) do 
		local isAdd=false;
		if (isHide==true and v.isHide~=1) or isHide~=true then
			isAdd=true
		-- else
		-- 	isAdd=true
		end
		if isAdd then
			local pageData=self:GetPageByID(v.id);
			if pageData then--当前商店页开启则返回
				table.insert(list,pageData);
			end
		end
	end
	table.sort(list,function(a,b)
        return a:GetSort()<b:GetSort();
    end)
	return list;
end

function this:GetRecordInfos(commodityID)
	if commodityID and self.records and self.records[commodityID]~=nil then
		return self.records[commodityID];
	end
	return nil
end

--缓存兑换数据
function this:SetExchangeData(proto)
	if proto then
		self.exchangeData=self.exchangeData or {};
		self.exchangeData[proto.cfgid]=proto;
	end
end

--更新兑换数据
function this:UpdateExchangeData(proto)
	local data=self:GetExchangeData(proto.cfgid);
	if proto and data then
		for k,v in ipairs(data.infos) do
			if v.id==proto.id and k==proto.index then
				v.buyLimit=proto.buyLimit;
				v.had_get=proto.had_get;
				break;
			end
		end
	end
	self:CheckRedInfo();
	EventMgr.Dispatch(EventType.Shop_RandComm_Refresh)
end

--返回兑换商店数据
function this:GetExchangeData(shopId)
	if self.exchangeData and shopId and self.exchangeData[shopId] then
		return self.exchangeData[shopId];
	end
	return nil
end

--返回兑换下次自动刷新和当前时间的差 返回nil表示没找到,返回的时间格式为秒数
function this:GetExchangeRefreshTime(shopId)
	local time=nil;
	local data=self:GetExchangeData(shopId);
	if data then
		if data.next_hour==nil then
			LogError("当前协议没有返回时间！！");
			Log(data);
			return;
		end
		time=data.next_hour-TimeUtil:GetTime();
		-- local targetTime=TimeUtil:GetTimeHMS(TimeUtil:GetTime());
		-- local day=targetTime.hour>=data.next_hour and targetTime.day+1 or targetTime.day;
		-- local nextTime=TimeUtil:GetTime2(targetTime.year,targetTime.month,day,data.next_hour,0,0);
		-- time=nextTime-TimeUtil:GetTime();
		-- Log( "NextTime:"..tostring(nextTime).."\t day:"..tostring(day).."\ttargetTime:"..targetTime.hour.."\t nextHour:"..tostring(data.next_hour).."\t time:"..tostring(time));
	end
	return time;
end

--返回兑换物品的信息
function this:GetExchangeItem(shopId,itemId)
	local data=self:GetExchangeData(shopId);
	local item=nil;
	if data and itemId then
		for k,v in ipairs(data.infos) do
			if v.id==itemId then
				item=v;
				break;
			end
		end
	end
	return item;
end

--返回兑换物品的下标 -1表示没找到
function this:GetExchangeItemIndex(shopId,itemId)
	local data=self:GetExchangeData(shopId);
	local index=-1;
	if data and itemId then
		for k,v in ipairs(data.infos) do
			if v.id==itemId then
				index=k;
				break;
			end
		end
	end
	return index;
end

--返回兑换商店手动刷新消耗
function this:GetExChangeRefreshCost(shopId)
	local cost=nil;
	local data=self:GetExchangeData(shopId);
	if data then
		local cfg=Cfgs.CfgRandCommodity:GetByID(data.cfgid);
		if cfg and cfg.aManFlushCosts then
			cost=cfg.aManFlushCosts[1];
			if cost==nil or next(cost)==nil then--不为空且无数据，视为免费
				cost={0,0}
			end
		end
	end
	return cost;
end

function this:GetExChangeCanRefresh(shopId)
	local data=self:GetExchangeData(shopId);
	if data then
		local cfg=Cfgs.CfgRandCommodity:GetByID(data.cfgid);
		if cfg and cfg.aManFlushCosts~=nil then --消耗不为空则可以刷新
			return true
		end
	end
	return false
end

--返回兑换商店中的商品的奖励表配置信息
function this:GetExChangeItemRewardCfg(rewardId,itemId)
	local rewardCfg=Cfgs.RewardInfo:GetByID(rewardId);
	local itemCfg=nil;
	for k,v in ipairs(rewardCfg.item) do
		if v.id==itemId then
			itemCfg=v;
			break;
		end
	end
	return itemCfg;
end

--返回固定道具对象 disGroup:是否包含组查询，为true时不会返回同组内在售商品
function this:GetFixedCommodity(cfgId,disGroup)
	if cfgId then
		local itemData = nil;
		if self.comms and self.comms[cfgId]~=nil then
			itemData=self.comms[cfgId];
		else
			itemData=CommodityData.New();
			itemData:SetCfg(cfgId);
			local records=self:GetRecordInfos(cfgId);
			itemData:SetData(records);
		end 
		if disGroup~=true and (itemData:HasData()~=true or itemData:GetNowTimeCanBuy()~=true) and itemData:GetShopGroupID()~=nil and self.comms then
			--查找同商品组内的在售商品信息
			for k,v in pairs(self.comms) do
				if v:GetShopGroupID()==itemData:GetShopGroupID() and v:HasData() and v:GetNowTimeCanBuy() then
					itemData=v;
					break;
				end
			end
		end
		return itemData;
	end
end

--是否存在当期固定商品购买记录
function this:HasBuyRecord(cfgId)
	local record=self:GetRecordInfos(cfgId);
	if record then
		return record.cnt>0 
	end
	return false;
end

--group:传入组id
function this:GetPromoteInfos(group)
	local list={};
	if group then
		local cfgs=Cfgs.CfgShopReCommend:GetGroup(group);
		if cfgs~=nil then
			for k,v in ipairs(cfgs) do
				local info=ShopPromote.New();
				info:SetCfg(v.id);
				if (info:GetShowType()==1 and info:GetNowTimeCanShow()) then
					table.insert(list,info);
				elseif (info:GetShowType()==2 and info:GetNowTimeCanShow() and info:IsBuy()~=true) or  (info:GetShowType()==2 and info:GetNowTimeCanShow() and ( info:IsBuy()~=true or (k==#cfgs and #list==0))) then
					--类型2的暂时只显示1个
					if #list>=1 and list[1]~=nil and list[1]:GetSort()>info:GetSort() then
						list={};
						table.insert(list,info);
					elseif #list<1 then
						table.insert(list,info);
					end
				end
			end
			table.sort(list,function(a,b) --排序
				return a:GetSort()<b:GetSort();
			end);
		end
	end
	return list;
end

--返回推荐商品刷新的下一时间戳
function this:GetPromoteRefreshTimestamp()
	local timestamp=0;
	local sTime=0;
	local eTime=0;
	local cTime=TimeUtil:GetTime();
	for k,v in pairs(Cfgs.CfgShopReCommend:GetAll()) do
		local info=ShopPromote.New();
		info:SetCfg(v.id);
		if (info:GetShowType()==2 and info:IsBuy()~=true) or (info:GetShowType()==1) then
			sTime=info:GetStartTime();
			eTime=info:GetEndTime()
			if sTime~=0 and cTime<sTime and ( sTime<timestamp or timestamp==0 )then
				timestamp=sTime;
			end
			if eTime~=0 and cTime<eTime and (eTime<timestamp or timestamp==0 ) then
				timestamp=eTime;
			end
		end
	end
	return timestamp;
end

-- --group:传入group值
-- function this:GetPromoteInfo(group)
-- 	if group then
-- 		local cfg=Cfgs.CfgShopReCommend:GetGroup(group)[1];
-- 		if cfg then
-- 			local info=ShopPromote.New();
-- 			info:SetCfg(cfg.id);
-- 			return info;
-- 		end
-- 	end
-- end

-- -- 读取推荐广告的本地数据 
-- function this:PromoteIsRed(id)
-- 	if self.prmoteConfs==nil then
-- 		self.prmoteConfs=FileUtil.LoadByPath("ShopPromote.txt");
-- 		self.prmoteConfs=self.prmoteConfs or {};
-- 	end
-- 	if id and self.prmoteConfs and self.prmoteConfs[id] then
-- 		local promote=ShopPromote.New();
-- 		promote:SetCfg(id);
-- 		local isBetween=ShopCommFunc.TimeIsBetween(promote:GetStartTime(),promote:GetEndTime(),self.prmoteConfs[id].time);	
-- 		if isBetween then --在推广时间内是否查看过推荐数据
-- 			return self.prmoteConfs[id].isRead~=1; --看过则不显示红点
-- 		end
-- 	end
-- 	return true;--默认显示红点
-- end

-- --缓存推荐数据
-- function this:SavePromoteState(id,isRead)
-- 	self.prmoteConfs=self.prmoteConfs or {};
-- 	local info={};
-- 	info.isRead=isRead==true and 0 or 1;
-- 	info.time=TimeUtil:GetTime();
-- 	self.prmoteConfs[id]=info;
-- 	FileUtil.SaveToFile("ShopPromote.txt",self.prmoteConfs);
-- end

local localfile="store_local_record.txt";

--缓存当前本地的刷新数据
function this:SaveLocalRecord()
	if self.localRecords then
		FileUtil.SaveToFile(localfile,self.localRecords);
	end
end

--读取当前本地的刷新数据
function this:LoadLocalRecord()
	local tab=FileUtil.LoadByPath(localfile);
	self.localRecords=tab or {};
end

function this:CheckCommReset()
	--检查是否有物品重置
	local data={};
	if self.newPageIds then
		for k,v in pairs(self.newPageIds) do
			local pageData=self:GetPageByID(k);
			if pageData then
				if type(v)=="number" then --一级页签
					if pageData then
						local list=pageData:GetRefreshCommIds();
						if list then
							data[k]=data[k] or {};
							data[k][k]=list;
						end
					end
				elseif type(v)=="table" then --二级页签
					for _, val in pairs(v) do
						local list=pageData:GetRefreshCommIds(val);
						if list then
							data[k]=data[k] or {};
							data[k][val]=list;
						end
					end
				end
			end
		end
	end
	data=self:CheckSkinNewState(4,data)
	data=self:CheckSkinNewState(5,data)
	self.pagesNewInfo=data;
	self:CheckRedInfo();
	self:CheckRegressionShopRedInfo();
	EventMgr.Dispatch(EventType.Shop_NewInfo_Refresh,self.pagesNewInfo);
end

function this:CheckSkinNewState(pageID,_data)
	--检测皮肤商店是否有新内容
	local page2=self:GetPageByID(pageID);
	if page2 and page2:GetStoreVer()~=nil and page2:GetCheckNew() then--同时填了checkNew字段和商店版本不一致时才做检查
		local storeVer=page2:GetStoreVer();--检查本地缓存版本是否一致
		local storeVerInfo=self.storeVerInfo and self.storeVerInfo[pageID] or nil;
		if (storeVerInfo~=nil and storeVer~=storeVerInfo.ver) or storeVerInfo==nil then
			_data[page2:GetID()]={storeVer};
		elseif storeVerInfo~=nil and  storeVer==storeVerInfo.ver then
			_data[page2:GetID()]=nil;
		end
	end
	return _data;
end

function this:GetPageNewInfos()
	return self.pagesNewInfo or nil;
end

--设置皮肤商店New的状态
function this:SetSkinStoreNewState(pageID)
	local page2=self:GetPageByID(pageID);
	if page2 and page2:GetStoreVer()~=nil and page2:GetCheckNew() then 
		local storeVer=page2:GetStoreVer();
		-- self.storeVerInfo={ver=storeVer};
		self.storeVerInfo=self.storeVerInfo or {};
		self.storeVerInfo[pageID]=self.storeVerInfo[pageID] or {};
		self.storeVerInfo[pageID]={ver=storeVer};
		FileUtil.SaveToFile("StoreVer.txt",self.storeVerInfo);
		if self.pagesNewInfo then
			self.pagesNewInfo[pageID]=nil;
			self:CheckRedInfo();
			EventMgr.Dispatch(EventType.Shop_NewInfo_Refresh,self.pagesNewInfo);
		end
	end
end

--返回本地记录的重置信息
function this:GetCommResetRecord(id,topTabID,commId)
	local info=nil;
	-- Log("GetCommResetRecord："..tostring(id).."\t"..tostring(topTabID).."\t"..tostring(commId))
	if self.localRecords and id and commId and self.localRecords[id] then
		if topTabID then
			if self.localRecords[id][topTabID] then
				info=self.localRecords[id][topTabID][commId]
			end
		else
			info=self.localRecords[id][commId] or nil;
		end
	end
	return info;
end

--设置指定商店的重置信息（用户点击页签按钮之后获取新的时间并持续化到本地） id一级页签ID topTabID二级页签ID
function this:SetCommResetInfo(id,topTabID)
	if id==nil then
		do return end;
	end
	local pageData=self:GetPageByID(id);
	if pageData==nil then
		do return end;
	end
	--判断ID是否是要检测的商店页ID
	local isIn=false;
	if self.newPageIds and self.newPageIds[id]~=nil and topTabID==nil then
		isIn=true;
	elseif self.newPageIds and self.newPageIds[id]~=nil and topTabID then
		for k, v in pairs(self.newPageIds[id]) do
			if v==topTabID then
				isIn=true;
				break;
			end
		end
	end
	if isIn then--是的话获取最新商品重置时间
		local infos=pageData:GetCommRefreshInfos(topTabID);
		if topTabID then
			self.localRecords = self.localRecords or {};
			self.localRecords[id]=self.localRecords[id] or {}
			self.localRecords[id][topTabID]=infos;
		else
			self.localRecords[id]=infos;
		end
		self:SaveLocalRecord();
	end
	-- Log("LocalRecords:")
	-- Log(self.localRecords)
	-- Log("-------------------------")
end

function this:SearchRefreshIDs()
	self.newPageIds=nil;
	for k,v in pairs(Cfgs.CfgShopPage:GetAll()) do
		if v.checkNew and v.checkNew==1 then
			self.newPageIds=self.newPageIds or {}	
			self.newPageIds[v.id]=self.newPageIds[v.id] or {};
			if v.topGroup then
				local childs=Cfgs.CfgShopTab:GetGroup(v.topGroup);
				if childs then
					for _,val in ipairs(childs) do
						if val.checkNew and val.checkNew==1 then
							table.insert(self.newPageIds[v.id],val.id);
						end
					end
				else
					self.newPageIds[v.id]=v.id;
				end
			else
				self.newPageIds[v.id]=v.id;
			end
		end
	end
end

function this:SetShopResetTime(proto)
	self.fixedUpdateTime=proto;
end

--返回固定商店的刷新时间
function this:GetFixedUpdateTime(updateType)
	if updateType==ShopFixedUpdateType.Day then
		return self.fixedUpdateTime and self.fixedUpdateTime.d_time or 0;
	elseif updateType==ShopFixedUpdateType.Week then
		return self.fixedUpdateTime and self.fixedUpdateTime.w_time or 0;
	elseif updateType==ShopFixedUpdateType.Month then
		return self.fixedUpdateTime and self.fixedUpdateTime.m_time or 0;
	end
	return 0;
end

--设置当前跳转的折扣券ID
function this:SetJumpVoucherID(id)
	self.jumpVoucherID=id;
end

--返回当前跳转的折扣券ID
function this:GetJumpVoucherID()
	return self.jumpVoucherID;
end

--获取和皮肤返利相关的商店信息
function this:GetCommodityBySkinID(skinId)
	local cfgs = Cfgs.CfgCommodity:GetAll()
	local infos = {}
	if cfgs then
		local data = nil
		for _, cfg in pairs(cfgs) do
			if cfg.skinID and cfg.skinID == skinId then
				if not cfg.shopGroupID or cfg.shopGroupID == cfg.id then
					data = self:GetFixedCommodity(cfg.id)
					-- if data and data:GetData() then
					-- 	table.insert(infos,data)
					-- end
					if data:IsShow() then
						table.insert(infos,data)
					end
				end
			end
		end
	end
	return infos
end

function this:GetSkinFilterSets(_pageId)
	local cfgs={};
	local pageData=self:GetPageByID(_pageId);
	if pageData~=nil then
		local temp={};
		local comms=pageData:GetCommodityInfos(true);
		for _,c in ipairs(comms) do
			local skinInfo=ShopCommFunc.GetSkinInfo(c)
			if skinInfo and temp[skinInfo:GetSetID()]~=true then
				for k,v in pairs(Cfgs.CfgSkinSeriesEnum:GetAll()) do
					if skinInfo:GetSetID()==v.id then
						table.insert(cfgs,v);
						temp[v.id]=true;
					end
				end
			end
		end
	end
	return cfgs;
end

function this:Clear()
	EventMgr.RemoveListener(EventType.Player_Update,this.OnPlayerUpdate)
	self.exchangeData={};
	self.prmoteConfs=nil;
	self.monthCardInfo=nil;
	self.localRecords=nil;
	self.newPageIds={};
	self.fixedUpdateTime=nil;
	self.storeVerInfo=nil;
	self.pagesNewInfo=nil;
	self.shopOpenTimes={};
	self.jumpVoucherID=nil;
	self.comms={};
	self.records={};
end

return this; 