local this = MgrRegister("EquipMgr")

this.typeIndex = nil;--按类型缓存id集合
this.currentEquipID = nil;--当前操作的装备ID
this.maxStuffNum = 10;--选择素材的最大数量
this.stuffList = StuffArray.New();--选择的素材列表

function this:SetData(data)
	if data then
		self.curSize = data.cur_size;
		self.maxSize = data.max_size;
		self.hasConvert=(data.materialNum~=nil) and data.materialNum>0 or false;
		if data.equips then
			for k, v in ipairs(data.equips) do
				self:Update(v);
			end
		end
		self:CheckBagRedInfo()
	else
		self.curSize = 0;
		self.maxSize = 0;
	end
end

--背包是否满了
function this:IsBagFull()
	if self.curSize and self.maxSize then
		return self.curSize>=self.maxSize;
	else
		return false
	end	
end

function this:Update(equip)
	self.equips = self.equips or {};
	self.typeIndex = self.typeIndex or {};
	if equip then
		local equipData = nil;
		if self.equips[equip.sid] ~= nil then
			equipData = self.equips[equip.sid];
			local type = equipData:GetSlot();
			local data = table.copy(equipData:GetData());
			for k, v in pairs(equip) do --更新指定属性
				if v ~= nil and data[k] then
					data[k] = v;
				end
			end
			local equip2=EquipData(data);
			local type2=equip2:GetSlot()
			if type~=type2 then --刷新typeIndex
				if self.typeIndex and self.typeIndex[type] then
					local idx=nil;
					for k,v in ipairs(self.typeIndex[type]) do
						if v==equip.sid then
							idx=k;
							break;
						end
					end
					table.remove(self.typeIndex[type],idx)
				end
				self.typeIndex[type2] = self.typeIndex[type2] or {};
				table.insert(self.typeIndex[type2], equip.sid);
			end
			self.equips[equip.sid]=equip2;
		else
			equipData = EquipData(equip);
			local type = equipData:GetSlot();
			self.typeIndex[type] = self.typeIndex[type] or {};
			table.insert(self.typeIndex[type], equip.sid);
			self.equips[equip.sid] = equipData;	
		end
	end
end

--删除装备
function this:RemoveEquip(id)
	if id and self.equips and self.equips[id] and self.typeIndex then
		local equip = self.equips[id];
		local type = equip:GetSlot();
		self.equips[id] = nil;
		local index = 0;
		for k, v in ipairs(self.typeIndex[type]) do
			if v == id then
				index = k;
				break;
			end
		end
		if index ~= 0 then
			table.remove(self.typeIndex[type], index);
		end
		EventMgr.Dispatch(EventType.Equip_GridNum_Refresh);
		self:CheckBagRedInfo();
	end
end

--设置装备被卡牌穿戴
function this:EquipUp(sid, cid)
	if self.equips and sid and cid then
		self.equips[sid]:SetCardID(cid);
		local card2 = RoleMgr:GetData(cid);
		if card2 then
			card2:AddEquipId(self.equips[sid]:GetSlot(), sid);
		end
	end
end

--检查是否显示背包红点
function this:CheckBagRedInfo()
	local hasRed=self.curSize>=self.maxSize
	local data=hasRed and {isMax=1} or nil
    RedPointMgr:UpdateData(RedPointType.Bag,data)
end

--查找卡牌推荐的装备ID
function this:SearchBeastEquips(cardId)
	if cardId==nil then
		LogError("匹配芯片的卡牌ID为nil！");
		return
	end
	local card=RoleMgr:GetData(cardId);
	local equipList=EquipMgr:GetAllEquipArr(nil,false);
    local slotEquips={}; --查找结果
	slotEquips[1]=slotEquips[1] or {};
	local suitIds=card:GetCfg().equip_suits;
    if equipList then
        --根据等级>品质>ID>属性进行分组查找
        for k,v in ipairs(equipList) do
            if (v:IsEquipped() and v:GetCardId()==card:GetID()) or not v:IsEquipped() then--在自己穿戴的装备和未穿戴的中查找
				local key=1;--key为1则代表普通套装，否则为套装ID
				for ky,val in ipairs(suitIds) do--是否是推荐套装
					if v:GetSuitID()==val then 
						key=val;
						break;
					end
				end
                local slot=v:GetSlot();
                local score=v:GetScore();
				slotEquips[key]=slotEquips[key] or {};
				-- Log(key.."\tName："..v:GetName().."\tID："..v:GetID().."\tSlot："..slot.."\tScore："..score)
				-- Log(slotEquips[key][slot])
                if slotEquips[key][slot]==nil or (slotEquips[key][slot]~=nil and slotEquips[key][slot].score<score) then
					local isBig=false;
					if key~=1 then
						slotEquips[key][slot]={};
						slotEquips[key][slot].id=v:GetID();
						slotEquips[key][slot].score=score;
						if slotEquips[1][slot] and slotEquips[1][slot].score>=score then
							isBig=false;
						else
							isBig=true;
						end
					end
					if isBig or key==1 then
						slotEquips[1][slot]={}; --套装ID也参与普通计算
						slotEquips[1][slot].id=v:GetID();
						slotEquips[1][slot].score=score;
					end
					-- Log(slotEquips[1][slot])
					slotEquips[key][slot].slot=slot;
                end
            end
        end
    end
    local ids={};
	local tmpList={};
	-- Log("推荐套装ID：")
	-- Log(suitIds)
	-- Log("--------------------")
	-- Log(slotEquips)
	for k,v in pairs(slotEquips) do
		local suitAddtion=1;--套装的评分加成，用于做卡牌的套装推荐
		local isFull=true;
		for i=1,5 do
			if v[i]==nil then
				isFull=false;
				break;
			end
		end
		for ky,val in ipairs(suitIds) do
			if k==val and isFull then --整套才吃加成
				suitAddtion=(#suitIds+2)-ky;--优先度排序
				break;
			end
		end
		local total=0;
		for k,v in pairs(v) do
			total=total+v.score;
		end
		total=total*suitAddtion; --整套总分
		-- Log("当前套装："..tostring(k))
		-- Log(v);
		-- Log(k.."\t isFull:"..tostring(isFull).."\t 加成："..tostring(suitAddtion).."\t总分:"..tostring(total))
		table.insert(tmpList,{info=v,total=total,isFull=isFull,suitAddtion=suitAddtion});
	end
	table.sort(tmpList,function(a,b) --根据总分进行排序
		if a.total==b.total then
			return a.suitAddtion>b.suitAddtion;
		end
		return a.total>b.total;
	end);
	local realEquips={};--筛选出的结果
	for k,v in ipairs(tmpList) do --找到优先度最高的五个装备id
		local isBreak=false;
		for key,val in pairs(v.info) do
			if realEquips[key]==nil then
				realEquips[key]=val;
			end
			local isFull=true;
			for i=1,5 do
				if realEquips[i]==nil then
					isFull=false;
					break;
				end
			end
			if isFull then
				isBreak=true;
				break;
			end
		end
		if isBreak then
			break;
		end
	end
	-- Log("结果：----------------")
	-- Log(realEquips);
    local equips=card:GetEquips();
    for k,v in pairs(realEquips) do --剔除已穿戴的装备
        local hasEquip=false;
        if equips then
            for _,val in ipairs(equips) do
                if val:GetID()==v.id then
                    hasEquip=true;
                    break;
                end
            end
        end
        if hasEquip==false then
			local equip=self:GetEquip(v.id);
			-- Log("名字："..tostring(equip:GetName()));
            table.insert(ids,v.id);
        end
    end
	return ids;
end

--设置装备卸载
function this:EquipDown(sid)
	if self.equips and sid then
		if self.equips[sid]:IsEquipped() then --当前装备已经被装备到其他卡牌上
			local cardID = self.equips[sid]:GetCardId();
			local card = RoleMgr:GetData(cardID);
			if card ~= nil then
				card:RemoveEquipId(sid);
			end
		end
		self.equips[sid]:SetCardID();
	end
end

--返回装备素材列表
function this:GetMaterialEquips()
	local arr = nil;
	if self.equips then
		arr = {};
		for _, v in pairs(self.equips) do
			if v:GetType()==EquipType.Material then
				table.insert(arr, v);
			end
		end
	end
	return arr;
end

--根据配置表ID返回装备,有多个时只返回第一个
function this:GetEquipByCfgID(cfgId)
	local equip=nil;
	if cfgId and self.equips then
		for _, v in pairs(self.equips) do
			if v:GetCfgID()==cfgId then
				equip=v;
				break;
			end
		end
	end
	return equip;
end

--返回套装分类的装备数据 返回的数据结构：{{cfg=套装配置表数据,equips1,equip2,...}} qualityFilters:品质筛选 配置表中show不等于1则不返回，配置表中时间字段大于当前时间时不返回
function this:GetEquipSuitData2(qualityFilters,hasEquipped,notContainID)
	local arr={};
	if self.equips then
		local currTime=TimeUtil:GetTime();
		for _,cfg in pairs(Cfgs.CfgSuit:GetAll()) do
			local canAdd=true;
			if cfg.limitTime then
				local lTime=TimeUtil:GetTimeStampBySplit(cfg.limitTime)
				canAdd=currTime>=lTime;
			end
			if cfg.show==1 and canAdd then
				local list={};
				list.cfg=cfg;
				for _, v in pairs(self.equips) do
					local isFilter=false;
					if notContainID and #notContainID > 0 then
						for _, v2 in ipairs(notContainID) do
							if v:GetID() == v2 then
								isFilter=true;
								break;
							end
						end
					end
					if isFilter~=true and v:GetSuitID()==cfg.id and v:GetType()~=EquipType.Material then
						if (qualityFilters==nil or (qualityFilters and #qualityFilters==0))and ((hasEquipped~=true and v:IsEquipped()~=true) or hasEquipped==true)  then
							table.insert(list,v);
						else
							for _,val in ipairs(qualityFilters) do --筛选
								if v:GetQuality()==val and ((hasEquipped~=true and v:IsEquipped()~=true) or hasEquipped==true) then
									table.insert(list,v);
									break;
								end
							end
						end
					end
				end
				table.insert(arr,list)
			end
		end
	end
	return arr;
end

--返回套装分类的装备数据 返回的数据结构：{{cfg=套装配置表数据,1={1号位装备集合},2={2号位装备集合},3={...},4={...},5={...}},...} qualityFilters:品质筛选 配置表中show不等于1则不返回
function this:GetEquipSuitData(qualityFilters,hasEquipped,notContainID)
	local arr={};
	if self.equips then
		local currTime=TimeUtil:GetTime();
		for _,cfg in pairs(Cfgs.CfgSuit:GetAll()) do
			local canAdd=true;
			if cfg.limitTime then
				local lTime=TimeUtil:GetTimeStampBySplit(cfg.limitTime)
				canAdd=currTime>=lTime;
			end
			if cfg.show==1 and canAdd then
				local list={};
				list.cfg=cfg;
				for _, v in pairs(self.equips) do
					local isFilter=false;
					if notContainID and #notContainID > 0 then
						for _, v2 in ipairs(notContainID) do
							if v:GetID() == v2 then
								isFilter=true;
								break;
							end
						end
					end
					if isFilter~=true and v:GetSuitID()==cfg.id and v:GetType()~=EquipType.Material then
						if (qualityFilters==nil or (qualityFilters and #qualityFilters==0))and ((hasEquipped~=true and v:IsEquipped()~=true) or hasEquipped==true)  then
							list[v:GetSlot()]=list[v:GetSlot()] or {};
							table.insert(list[v:GetSlot()],v);
						else
							for _,val in ipairs(qualityFilters) do --筛选
								if v:GetQuality()==val and ((hasEquipped~=true and v:IsEquipped()~=true) or hasEquipped==true) then
									list[v:GetSlot()]=list[v:GetSlot()] or {};
									table.insert(list[v:GetSlot()],v);
									break;
								end
							end
						end
					end
				end
				table.insert(arr,list);
			end
		end
	end
	return arr;
end

--返回指定套装ID中评分最高的装备 suitId:套装id，hasEquipped：是否包含被装备的数据,notContainID：表，不需要返回的装备CID
function this:GetEquipSuitBeast(suitId,hasEquipped,notContainID)
	local arr=nil;
	local isBeast=true;
	local isFilter=false;
	for _, v in pairs(self.equips) do
		if notContainID and #notContainID > 0 then
			for _, v2 in ipairs(notContainID) do
				if v:GetID() == v2 then
					isFilter=true;
					break;
				end
			end
		end
		if isFilter~=true and v:GetSuitID()==suitId and v:GetType()~=EquipType.Material then
			arr=arr or {};
			if arr[v:GetSlot()] then
				isBeast=v:GetScore()>arr[v:GetSlot()]:GetScore();
			else
				isBeast=true;
			end
			if hasEquipped and isBeast then
				arr[v:GetSlot()]=v;
			elseif v:IsEquipped()~=true and isBeast then
				arr[v:GetSlot()]=v;
			end
		end
	end
	return arr;
end

--返回包含的套装名字关键字的装备数据 返回的数据结构：{{cfg=套装配置表数据,1={1号位装备集合},2={2号位装备集合},3={...},4={...},5={...}},...} qualityFilters:品质筛选 hasEquipped:是否包含已穿戴的
function this:GetEquipSuitDataByStr(str,qualityFilters,notContainID,hasEquipped)
	local arr={};
	if self.equips then
		local currTime=TimeUtil:GetTime();
		for _,cfg in pairs(Cfgs.CfgSuit:GetAll()) do
            if string.match(cfg.name,str) then
				local list={};
				list.cfg=cfg;
				for _, v in pairs(self.equips) do
					local isFilter=false;
					if notContainID and #notContainID > 0 then
						for _, v2 in ipairs(notContainID) do
							if v:GetID() == v2 then
								isFilter=true;
								break;
							end
						end
					end
					if hasEquipped~=true and v:IsEquipped() then
						isFilter=false;
					end
					local canAdd=true;
					if cfg.limitTime then
						local lTime=TimeUtil:GetTimeStampBySplit(cfg.limitTime)
						canAdd=currTime>=lTime;
					end
					if isFilter~=true and v:GetSuitID()==cfg.id and v:GetType()~=EquipType.Material and v.show==1 and canAdd then
						if qualityFilters==nil or (qualityFilters and #qualityFilters==0) then
							list[v:GetSlot()]=list[v:GetSlot()] or {};
							table.insert(list[v:GetSlot()],v);
						else
							for _,val in ipairs(qualityFilters) do --筛选
								if v:GetQuality()==val then
									list[v:GetSlot()]=list[v:GetSlot()] or {};
									table.insert(list[v:GetSlot()],v);
									break;
								end
							end
						end
					end
				end
				table.insert(arr,list);
			end
		end
	end
	return arr;
end

--返回符合类型的所有装备 slot:位置,notContainID:表，不需要返回的装备CID
function this:GetEquipArr(slot, notContainID,hasMaterial)
	local arr = nil;
	if slot and self.equips and self.typeIndex and self.typeIndex[slot] then
		arr = {};
		for _, v in ipairs(self.typeIndex[slot]) do
			local equip=self.equips[v]
			if (hasMaterial) or (hasMaterial~=true and equip:GetType()~=EquipType.Material) then
				if notContainID and #notContainID > 0 then
					local hasID=false;
					for _, v2 in ipairs(notContainID) do
						if v == v2 then
							hasID=true;
							break;
						end
					end
					if hasID==false then
						table.insert(arr, equip);
					end
				else
					table.insert(arr, equip);
				end
			end
		end
	end
	return arr;
end

--==============================--
--desc:返回当前所有的装备
--time:2019-04-11 05:59:58
--@cid:装备的卡牌id
--@hasMaterial:是否包含素材装备
--@return 
--==============================--
function this:GetAllEquipArr(cid,hasMaterial)
	local arr = nil;
	if type and self.equips then
		arr = {};
		for id, v in pairs(self.equips) do
			if ((hasMaterial) or (hasMaterial~=true and v:GetType()~=EquipType.Material)) then
				if cid and v:GetCardId() == cid then
					--当前选中的装备不返回
				else
					table.insert(arr, v);
				end	
			end
		end
	end
	return arr;
end

--返回装备界面强化列表 cid:剔除的装备id
function this:GetStrengthList(cid)
	local arr = nil;
	-- isContain = isContain == nil and true or isContain;
	if type and self.equips then
		arr = {};
		for id, v in pairs(self.equips) do
			if (v:IsEquipped() == false and cid==nil and v:IsLock()==false) or(cid~=nil and id~=cid and v:IsEquipped()==false and v:IsLock()==false) then
				table.insert(arr, v);
			end
		end
	end
	return arr;
end

--返回未装备的装备列表
--cid:剔除的装备ID,hasMaterial：是否包含素材装备
function this:GetNotEquippedItem(cid,hasMaterial,hasLock)
	local arr = nil;
	hasMaterial = hasMaterial == nil and true or hasMaterial;
	hasLock = hasLock == nil and true or hasLock;
	-- if type and self.equips then
	if self.equips then
		arr = {};
		for id, v in pairs(self.equips) do
			if (hasMaterial) or (hasMaterial~=true and v:GetType()~=EquipType.Material) then
				if (hasLock or (hasLock~=true and v:IsLock()~=true)) and ((v:IsEquipped() == false and cid==nil) or(cid~=nil and id~=cid and v:IsEquipped()==false)) then
					table.insert(arr, v);
				end
			end
		end
	end
	return arr;
end

--返回装备
function this:GetEquip(sid)
	if sid and StringUtil:IsEmpty(sid) == false and self.equips and self.equips[sid] then
		return self.equips[sid];
	end
	return nil;
end

--装备属性
function this:GetEquipResult(equipIds)
	local result = {}
	local equips = {}
	if(equipIds) then
		for i, v in pairs(equipIds) do
			local equip = self:GetEquip(v)
			if(equip) then
				table.insert(equips, equip.data)
			end
		end
	end
	if(#equips > 0) then
		for i, v in ipairs(equips) do
			local re = {}
			re.cfgid = v.cfgid
			re.level = v.level
			-- re.randSkillType = v.rand_skill_type
			-- re.randSkillValue = v.rand_skill_value
			local skills=v:GetSkills();
			re.skills=skills or {}
			table.insert(result, re)
		end	
	end
	return GEquipCalculator:CalEquipPropertys(result,CSAPI.IsADVRegional(3))
end

--创建假数据
function this:GetFakeData(_cfgId,_level)
	local data = {}
	data.cfgid = _cfgId
	data.level = _level or 0
	data.exp = 0
	data.num = 0
	local equipData = EquipData(data);
	return equipData
end


--返回技能筛选界面的显示配置
function this:GetSkillSortConf(conditionData,cb)
	local mData = {}
	--由上到下排序
	mData.list = {"skill"}
	--标题名(与list一一对应)
	mData.titles ={"技能"}
	--当前数据
	mData.info = conditionData
	--源数据
	mData.root = {}
	local _root = {}
	_root.Skill=EquipCommon.GetFilterSkillList();
	-- for k,v in pairs(Cfgs.CfgEquipSkillTypeEnum:GetAll()) do
	-- 	if v.show==1 then
	-- 		table.insert(_root.Skill,{id=v.id,sName=v.sName});
	-- 	end
	-- end
	-- table.sort(_root.Skill,function(a,b)
	-- 	return a.id<b.id;
	-- end)
	mData.root=_root;
	--回调
	mData.cb = cb
	return mData;
end

function this:SetSuitQuailtyVal(val)
	self.suitQuailtyVal=val;
end

function this:GetSuitQuailtyVal()
	return self.suitQuailtyVal or {1};
end

function this:SetOrderType(dataType,val)
	self.orderTypes=self.orderTypes or{}
	self.orderTypes[dataType]=self.orderTypes[dataType] or {};
	self.orderTypes[dataType]=val
end

function this:GetOrderType(dataType)
	if self.orderTypes~=nil and self.orderTypes[dataType]~=nil then
		return self.orderTypes[dataType];
	else
		self.orderTypes=self.orderTypes or{}
		self.orderTypes[dataType]={};
		if dataType==EquipViewKey.Sell  or dataType==EquipViewKey.Strength then
			self.orderTypes[dataType]=1;
		else
			self.orderTypes[dataType]=2;
		end
		return self.orderTypes[dataType]
	end
end

function this:SetScreenData(dataType,val)
	self.screenData=self.screenData or {};
	self.screenData[dataType]=self.screenData[dataType] or {};
	self.screenData[dataType]=val;
end

--返回强化素材列表缓存的筛选数据
function this:GetScreenData(dataType)
	if self.screenData~=nil and self.screenData[dataType]~=nil then
		return self.screenData[dataType];
	else
		self.screenData=self.screenData or{}
		self.screenData[dataType]={};
		local sortList=g_EquipSortOrder;
		if dataType==EquipViewKey.Strength then
			sortList=g_EquipStrengthSortOrder;
		elseif dataType==EquipViewKey.Replace then
			sortList=g_EquipSelectSortOrder;
		elseif dataType==EquipViewKey.Sell then
			sortList=g_EquipSellSortOrder;
		elseif dataType==EquipViewKey.SuitSelect then
			sortList=g_EquipSuitSortOrder;
		end
		local sort=sortList[1];
		self.screenData[dataType]={
			Sort={sort},
			Qualiy={0},
			Slot={0},
			skill={0},
			Type={0},
			Equipped={0},
			sortList=sortList,--默认排序
		};
		return self.screenData[dataType]
	end
end

function this:GetQualityColor(quality)
	quality=quality or 1;
	local colorCode="ffffff";
	local cfg=Cfgs.CfgEquipQualityEnum:GetByID(quality);
	if cfg then
		colorCode=cfg.sColor;
	end
	return colorCode;
end


--==============================--
--desc:执行筛选操作
--time:2019-06-05 02:44:55
--@data:装备数组
--@condition:筛选条件数据condition[key=""]={筛选ID1,筛选ID2...}}
--@return 
--==============================--
function this:DoScreen(data, condition)
	local list = {};
	if data then
		if condition then
			local skills={};--技能筛选
			for k,v in pairs(condition) do --将技能类型的筛选数据找出来
				local strs=StringUtil:split(k,"_");
				if strs[1]=="skill" then
					for _,val in ipairs(v) do
						if val~=0 then
							table.insert(skills,val);
						end
					end
				end
			end
			for k1, v1 in ipairs(data) do
				local isTrue=true;
				for k, v in pairs(condition) do
					local strs=StringUtil:split(k,"_");
					if strs[1]=="skill" then
						isTrue=self:ScreenSkill(v1,v);
					else
						if k == "Qualiy" then
							isTrue=self:ScreenQualiy(v1,v);
						elseif k == "Slot" then
							isTrue=self:ScreenSlot(v1,v);
						elseif k=="Type" then
							isTrue=self:ScreenType(v1,v);
						elseif k=="Equipped" then
							isTrue=self:ScreenEquipped(v1,v);
						end
					end
					if isTrue== false then
						break;
					end
				end
				if isTrue then
					table.insert(list,v1);
				end
			end
			if condition.Sort[1]==6 then --技能点数排序
				table.sort( skills, function(a,b)
					return a>b; --技能优先级由ID从大到小
				end );
				EquipSortUtil.SetSortSkillIDs(#skills>0 and skills or nil);
				table.sort(list, #skills>0 and EquipSortUtil.SortEquipBySkillPriority or EquipSortUtil.SortEquipBySkillLv);
			else
				EquipSortUtil.SetSort(condition.Sort[1],condition.sortList);
				table.sort(list, EquipSortUtil.SortEquip);
			end
			-- if skills~=nil and #skills>=1 and skills[1]~=-1 then--技能点数排序
			-- 	table.sort( skills, function(a,b)
			-- 		return a>b; --技能优先级由ID从大到小
			-- 	end );
			-- 	EquipSortUtil.SetSortSkillIDs(skills);
			-- 	table.sort(list, EquipSortUtil.SortEquipBySkillPriority);
			-- elseif condition["IsStrength"]~=nil then --强化排序
			-- 	EquipSortUtil.SetSort(1);
			-- 	table.sort(list, EquipSortUtil.SortEquipRevers);
			-- else--正常排序
			-- 	EquipSortUtil.SetSort(1);
			-- 	table.sort(list, EquipSortUtil.SortEquip);
			-- end
		else
			return data;
		end
	end
	return list;
end

--根据品质进行筛选
function this:ScreenQualiy(data,condition)
	local isTrue=false;
	for k,v in ipairs(condition) do
		if v==0 or data:GetQuality()==v  then
			isTrue=true;
			break;
		end
	end
	return isTrue;
end

--根据位置进行筛选
function this:ScreenSlot(data,condition)
	local isTrue=false;
	for k,v in ipairs(condition) do
		if v==0 or v==-1 or data:GetSlot()==v  then
			isTrue=true;
			break;
		end
	end
	return isTrue;
end

--根据技能类型进行筛选
function this:ScreenSkill(data,condition)
	local isTrue=true;
	for k,v in ipairs(condition) do
		if v==0 then
			break;
		elseif not data:ContainSkillType(v)  then
			isTrue=false;
			break;
		end
	end
	return isTrue;
end

--根据类型进行筛选
function this:ScreenType(data,condition)
	local isTrue=false;
	for k,v in ipairs(condition) do
		if v==0 or data:GetType()==v then
			isTrue=true;
			break;
		end
	end
	return isTrue;
end

--根据装备是否穿戴进行筛选
function this:ScreenEquipped(data,condition)
	local isTrue=false;
	local num=data:IsEquipped() and 1 or 2;
	for k,v in ipairs(condition) do
		if v==0 or num==v then
			isTrue=true;
			break;
		end
	end
	return isTrue;
end

function this:GetSlotImg(slot)
	if slotImg==nil then
		slotImg={"UIs/RoleEquip/arms.png","UIs/RoleEquip/armor.png","UIs/RoleEquip/hand.png","UIs/RoleEquip/jewelry.png","UIs/RoleEquip/lower_limb.png"}
	end
	if slot then
		return slotImg[slot];
	end
end

function this:GetSlotStr(slot)
	if slot then
		local cfg=Cfgs.CfgEquipSlotEnum:GetByID(slot);
		return cfg and cfg.sName or "";
	end
	return "";
end

--设置正在洗炼中的装备ID
function this:SetRefreshLastData(proto)
	if proto and proto.sid~=0 then
		self.refreshLastData=proto;
	else
		self.refreshLastData=nil;
	end
end

--返回正在洗炼中的装备ID
function this:GetRefreshLastData()
	return self.refreshLastData
end

--判断是否正在洗炼中的装备
function this:CheckIsRefreshLast(sid)
	if sid and self.refreshLastData and sid==self.refreshLastData.sid then
		--洗炼中，是否跳转到洗炼界面
		local dialogData={
            content = LanguageMgr:GetByID(75025),
            okCallBack = function()
               JumpMgr:Jump(330001);
            end
        }
        CSAPI.OpenView("Dialog", dialogData);
		return true;
	end
	return false;
end

function this:SetHasConvert(hasConvert)
	self.hasConvert=hasConvert;
end

function this:CheckHasConvert()
	return self.hasConvert;
end

function this:Clear()
	self.curSize = 0;
	self.maxSize = 0;
	self.typeIndex = nil;--按类型缓存id集合
	self.currentEquipID = nil;--当前操作的装备ID
	self.maxStuffNum = 10;--选择素材的最大数量
	self.stuffList = StuffArray.New();--选择的素材列表
	self.screenData={};
	self.equips =  {};
	self.typeIndex = {};
	self.refreshLastData=nil;
	self.hasConvert=false;
end

return this; 