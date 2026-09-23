--商店数据
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end


function this:SetCfg(cfgId)
	if(cfgId == nil) then
		LogError("初始化商店数据失败！无效配置id");		
	end
	if(self.cfg == nil) then		
		self.cfg = Cfgs.CfgShopInfo:GetByID(cfgId);
		if(self.cfg == nil) then		
			LogError("找不到商店数据！id = " .. cfgId);	
		end
	end
end

--返回ID
function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

--返回商店名称
function this:GetName()
	return self.cfg and self.cfg.sName or nil;
end

--返回商店的分页数据
function this:GetPageDatas()
	local pageDatas={};
	--获取页签数据
	local cfgs=Cfgs.CfgShopPage:GetGroup(self:GetID());
	if cfgs then
		for k,v in ipairs(cfgs) do
			local pageData=ShopMgr:GetPageByID(self:GetID(),v.id);
			--判断当前商店是否开启
			if pageData then--当前商店页开启则返回
				table.insert(pageDatas,pageData);
			end
		end
	end
	return pageDatas;
end

function this:GetPageDataByID(pageId)
	local cfg=Cfgs.CfgShopPage:GetByID(pageId);
	if cfg then
		local pageData=ShopPageData.New();
		pageData.cfg=cfg;
		return pageData;
	end
end

function this:GetDefaultOpenPageData()
	local cfgs=Cfgs.CfgShopPage:GetGroup(self:GetID());
	if cfgs then
		for k,v in ipairs(cfgs) do
			if v.nDefault==1 then--当前商店页开启则返回
				local pageData=ShopMgr:GetPageByID(self:GetID(),v.id);
				return pageData;
			end
		end
	end
end

function this:GetOpenTime()
	local time = nil;
	if self.cfg and self.cfg.openTime ~= "" and self.cfg.openTime ~= nil then
		time = self.cfg.openTime;
	end
	return time;
end

function this:GetCloseTime()
	local time = nil;
	if self.cfg and self.cfg.closeTime ~= "" and self.cfg.closeTime ~= nil then
		time = self.cfg.closeTime;
	end
	return time;
end

--返回开始时间秒数
function this:GetOpenTimeData()
	local time = self:GetOpenTime();
	if time ~= nil then
		time = TimeUtil:GetTimeStampBySplit(time);
	else
		time = 0;
	end
	return time;
end

--返回关闭时间秒数
function this:GetCloseTimeData()
	local time = self:GetCloseTime();
	if time ~= nil then
		time = TimeUtil:GetTimeStampBySplit(time);
	else
		time = 0;
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

return this; 