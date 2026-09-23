local this = {}

--光环信息类
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
	if cfgId then
        self.cfg=Cfgs.cfgHalo:GetByID(cfgId);
    end
    if self.cfg==nil then
        LogError("CfgHalo中找不到对应ID："..tostring(cfgId).."的配置信息");
    end
end

function this:SetData(data)
	self.data=data;
	if self.data~=nil then
		self:InitCfg(data.cfgid);
		--初始化光环坐标信息
		self.coords={};
		local cfg=self:GetCfg()
		--计算当前属性词条上限
		self.maxAttrNum=2; --最低2条
		self.lockAttr=nil;--锁定的词条
		local fInfo=nil;
		local mapInfos={};
		for k, v in ipairs(cfg.infos) do
			if v.coorId then
				local coord=HaloCoordinate.New()
				coord:SetData({id=v.coorId,haloId=self:GetID(),lv=v.index});
				table.insert(self.coords,coord);
			end
			if fInfo==nil then
				fInfo=v;
			else
				for i, val in pairs(HaloUtil.keyList) do
					if fInfo[i]==nil and v[i]~=nil and mapInfos[i]==nil then
						mapInfos[i]=1;
						self.maxAttrNum=self.maxAttrNum+1;
						self.lockAttr=self.lockAttr==nil and {key=i,addtive=v[i],cfg=v} or nil;
						break;
					end
				end
			end
		end
		--初始化当前槽位数量和槽位上限数量
		local lv=self:GetLv();
	end
end

function this:GetData()
	return self.data or nil;
end

function this:GetCfg()
	return self.cfg or nil;
end

function this:GetID()
	return self.data and self.data.cfgid or nil;
end

function this:GetLv()
	return self.data and self.data.level or 1;
end

function this:GetMaxLv()
	return self.cfg and #self.cfg.infos or 1;
end

function this:GetMaxAttrNum()
	return self.maxAttrNum or 2;
end

function this:GetLockAttr()
	return self.lockAttr or nil;
end

function this:IsMax()
	local lv=self:GetLv();
	local maxLv=self:GetMaxLv()
	return lv>=maxLv;
end

function this:GetExp()
	return self.data and self.data.exp or 0;
end

function this:GetCard()
	local card=nil;
	if self.data and self.data.cid then
		card=FormationUtil.FindTeamCard(self.data.cid);
	end
	return card;
end

function this:LoadIcon(go)
	local coord=self:GetCurCoord();
	if coord then
		coord:LoadIcon(go)
	end
end

--返回槽位加成属性
function this:GetAddition(key)
	--根据装备跟当前等级获取加成属性
	local list=nil;
	if self.data then
		local ret=Halo:CalHaloEquipAttr(self.data);
		key=key or "attrAdd"
		list=ret[key];
	end
	return list;
end

--返回槽位加成的属性的格式化内容
function this:GetAdditionFormat()
	local fList=nil;
	local list=self:GetAddition();
	if list then--格式化内容
		fList={};
		for k, v in ipairs(list) do
			local attrCfg=HaloUtil.GetPropertyEnumCfg(v[1]);
			if attrCfg then
				local num =HaloUtil.GetPropertyValueStr(v[1],v[2]);
				table.insert(fList,{cfg=attrCfg,addtive=num,addtiveNum=v[2],isLock=false});
			end
		end
	end
	return fList;
end

--返回当前等级所需要的升级条件
function this:GetCurrLvUpCond()
	if self.cfg and self.cfg.infos then
		local lv=self:GetLv()
		if self.cfg.infos[lv] and self.cfg.infos[lv].lvUpCond  then
			return self.cfg.infos[lv].lvUpCond 
		end
	end
	return nil;
end

--返回当前解锁的最大等级上限
function this:GetUnlockMaxLv()
	local maxLv=1;
	local lockDesc=nil;
	if self.cfg then
		for k, v in ipairs(self.cfg.infos) do
			if v.lvUpCond~=nil then
				local isPass,desc=HaloUtil.IsCondUnLock(self:GetCard(),self:GetLv(),v.lvUpCond);
				if isPass then
					maxLv=v.index
					lockDesc=nil
				else
					maxLv=v.index-1
					lockDesc=desc
					break;
				end
			else
				maxLv=v.index;
				lockDesc=nil;
			end
		end
	end
	return maxLv,lockDesc;
end

function this:GetLevelUpCost(lv)
	if lv==nil or lv==0 then
		lv=self:GetLv();
	end
	local list={};
	if self.cfg and self.cfg.infos and self.cfg.infos[lv] then
		list=self.cfg.infos[lv].jCosts;
	end
	return list;
end

--返回目标等级的升级道具
function this:GetLevelUpItems(lv)
	if lv==nil or lv==0 then
		lv=self:GetLv();
	end
	local list={};
	if self.cfg and self.cfg.infos and self.cfg.infos[lv] then
		for i, v in ipairs(self.cfg.infos[lv].jItems) do
			table.insert(list,{goods=BagMgr:GetFakeData(v[1]),id=v[1],num=v[2]});
		end
	end
	return list;
end

function this:GetUpdateShow(lv)
	if lv==nil or lv==0 then
		lv=self:GetLv();
	end
	local isShowBase=true;
	if self.cfg and self.cfg.infos and self.cfg.infos[lv] then
		isShowBase=self.cfg.infos[lv].updateshow==2;
	end
	return isShowBase;
end

--返回光环特殊加成
function this:GetSpecialCfg(lv)
	--获取当前光环中的特殊效果信息
	local cfg=nil;
	if lv==nil or lv==0 then
		lv=self:GetLv();
	end
	if self.cfg and self.cfg.infos and self.cfg.infos[lv] and self.cfg.infos[lv].haloEffect then
		cfg=Cfgs.cfgHaloEffect:GetByID(self.cfg.infos[lv].haloEffect);
		lv=self.cfg.infos[lv].index;
	end
	return cfg,lv;
end

-- function this:IsUnLock()
-- 	local isUnLock=true;
-- 	local lockStr=nil;
-- 	local card=self:GetCard()
-- 	if self.cfg and self.cfg.lockCond then
-- 		isUnLock,lockStr=HaloUtil.IsCondUnLock(card,self.cfg.lockCond)
-- 	end
-- 	return isUnLock,lockStr
-- end

function this:GetCoordInfos()
	return self.coords or {};
end

function this:GetCurCoord()
	local coord=nil;
	if self.coords then
		for k, v in ipairs(self.coords) do
			if self.data and self.data.curCoor~=nil and self.data.curCoor==v:GetID() then
				coord=v;
				break;
			elseif (self.data==nil or (self.data and self.data.curCoor==nil)) and v:GetLockLv()<=self:GetLv() then
				coord=v;
				break; --返回解锁的第一个
			end
		end
	end
	return coord;
end

function this:GetCurCoordPos()
	local coord=self:GetCurCoord();
	if coord~=nil then
		return coord:GetCoord();
	end
end

function this:GetCurCoordIcon()
	local coord=self:GetCurCoord();
	if coord~=nil then
		return coord:GetIcon();
	end
end

return this;