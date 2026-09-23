local this = oo.class(GridDataBase);

--初始化 equip:协议中的sEquip数据结构
function this:Init(equip)
	if equip then
		self.data = equip;
		self:InitCfg(equip.cfgid);
	end
end

--初始化配置
function this:InitCfg(cfgid)
	if(cfgid == nil) then
		LogError("初始化装备配置失败！无效配置id");		
	end
	
	if(self.cfg == nil) then		
		self.cfg = Cfgs.CfgEquip:GetByID(cfgid);
	end
end

function this:GetSuitID()
	return self.cfg and self.cfg.suitId or nil;
end

---------------------其他属性--------------------------
--设置锁定
function this:SetLock(isLock)
	isLock = isLock and isLock or false;
	if self.data then
		self.data.lock = isLock and 1 or 0;
	end
end

--设置等级
function this:SetLevel(lv)
	lv = lv or 0;
	if self.data then
		self.data.level = lv;
	end
end

--设置强化经验值
function this:SetExp(exp)
	exp = exp or 0;
	if self.data then
		self.data.exp = exp;
	end
end

--设置穿戴装备的卡牌ID
function this:SetCardID(cardId)
	cardId = cardId or nil;
	if self.data then
		self.data.card_id = cardId
	end
end

--设置是否为新装备
function this:SetNew(isNew)
	isNew = isNew == nil and false or isNew;
	if self.data then
		self.data.is_new = isNew;
	end
end

--hasLock:是否包含锁定的装备信息
function this:GetSkills(hasLock)
	local isJP=CSAPI.IsADVRegional(3);
	-- local isJP=true;
	if self.data and self.data.skills then
		if not isJP or hasLock then
			return self.data.skills
		else
			local list=nil;
			for k, v in ipairs(self.data.skills) do --只返回未加锁的
				if self:GetSkillIsLock(v,k)~=true then
					list=list or {};
					table.insert(list,v);
				end
			end
			return list;
		end
	end
	return nil;
end

--返回唯一ID
function this:GetID()
	return self.data and self.data.sid;
end

function this:GetCfgID()
	return self.data and self.data.cfgid or nil;
end

--返回锁定
function this:IsLock()
	local lock = false;
	if self.data then
		lock = self.data.lock == 1;
	end
	return lock;
end

function this:IsLockNum()
	return self.data and self.data.lock or 0;
end

function this:IsNewNum()
	return self.data and self.data.is_new or 0;
end

--返回等级
function this:GetLv()
	return self.data and self.data.level or 0;
end

--返回强化经验值
function this:GetExp()
	return self.data and self.data.exp or 0;
end

--返回占用中的卡牌id
function this:GetCardId()
	return self.data and self.data.card_id or nil;
end


function this:IsEquipped()
	local isEquip = false;
	if self.data and self.data.card_id ~= nil and self.data.card_id ~= "" and tonumber(self.data.card_id) ~= 0 then
		isEquip = true;
	end
	return isEquip;
end

function this:IsEquippedNum()
	local num=0;
	if self.data and self.data.card_id ~= nil and self.data.card_id ~= "" and tonumber(self.data.card_id) ~= 0 then
		num=1;
	end
	return num;
end

--返回是否是新装备
function this:IsNew()
	return self.data and self.data.is_new == 1 or false;
end

--返回入手顺序ID越大越后面获得
function this:GetOrder()
	return self.data and self.data.sid;
end

--返回技能总值 screenIds:选定的技能ID
function this:GetTotalSkillValue(screenIds)
	local count = 0;
	for i=1,g_EquipMaxSkillNum do
		local cfg=self:GetSkillInfo(i);
		if cfg then
			count=count+cfg.nLv;
		end
	end
	return count;
end

--根据screenIds返回当前装备所有技能点的排序优先度和点数 screenIds按照优先度从高到低的顺序排序
function this:GetSkillSortValue(screenIds)
	local sortDatas = {
		{idx = 100, val = 0},
		{idx = 100, val = 0},
		{idx = 100, val = 0},
		{idx = 100, val = 0},
	}
	for i=1,g_EquipMaxSkillNum do
		local cfg=self:GetSkillInfo(i);
		if screenIds ~= nil and cfg then
			for	k, v in ipairs(screenIds) do
				if v == cfg.group then
					sortDatas[i].idx = k;
					sortDatas[i].val = cfg.nLv;
					break;
				end
			end
		end
	end
	table.sort(sortDatas, function(a, b)
		return a.idx < b.idx;
	end);
	return sortDatas;
end

function this:GetData()
	return self.data;
end

function this:GetCfg()
	return self.cfg
end

function this:GetCount()
	local num=0;
	if self:GetType()==EquipType.Material and self.data then
		num=self.data.num or 0;
	end
	return num;
end

function this:GetClassType()
	return "EquipData";
end

function this:GetIconScale()
    return 1;
end
---------------------配置表属性-------------------------
--物品类型
function this:GetItemType()
	return ITEM_TYPE.EQUIP
end

--返回装备类型
function this:GetType()
	return self.cfg and self.cfg.nType or 1;
end

--装备名称
function this:GetName()
	return self.cfg and self.cfg.sName or "";
end

--装备星级
function this:GetStars()
	return self.cfg and self.cfg.nStart or 1;
end

--装备品质
function this:GetQuality()
	return self.cfg and self.cfg.nQuality and tonumber(self.cfg.nQuality) or 1;
end

--装备位置
function this:GetSlot()
	return self.cfg and self.cfg.nSlot or 1;
end

--最大强化等级
function this:GetMaxLv()
	return self.cfg and self.cfg.nMaxLvl or 1;
end

--图标
function this:GetIcon()
	return self.cfg and self.cfg.sIcon or "";
	-- return "1";
end

function this:GetIconLoader()
	return ResUtil.EquipSkillIcon;
end

--图标特效
function this:GetEffect()
	return self.cfg and self.cfg.sIconEffect or "";
end

--掉落途径
function this:GetGetWayInfo()
	local infos=nil;
	if self.cfg and self.cfg.getInfo then
		infos={};
		for k,v in ipairs(self.cfg.getInfo) do
			local jumpId=v[1];
			local state,lockStr=JumpMgr:GetJumpState(jumpId);
			local outTips=nil;
			if v[2] then
				local cfg=Cfgs.CfgOutTypeEnum:GetByID(v[2]);
				outTips=cfg.sName;
			end
			table.insert(infos,{jumpId=jumpId,state=state,lockStr=lockStr,outTips=outTips});
		end
	end
	return infos;
end

function this:GetTOtherGetInfo()
	local infos=nil;
	if self.cfg and self.cfg.t_otherGet then
		-- infos=self.cfg.t_otherGet;
		infos={};
		for k,v in ipairs(self.cfg.t_otherGet) do
			local text=LanguageMgr:GetByID(v);
			if text~=nil then
				table.insert(infos,text);
			end
		end
	end
	return infos;
end
--返回单个基础属性id，加成值，num:当前第几个基础属性 card:提供基础属性的卡牌，没有的话默认读取当前使用中的卡牌
function this:GetBaseNumInfo(index, card)
	local id = nil;
	local num = 0;
	--获取卡牌数据
	if card == nil and self:IsEquipped() ~= false then
		card = RoleMgr:GetData(self:GetCardId());
	end
	local id, add, upAdd = self:GetBaseAddInfo(index);
	if id ~= nil then
		if id == 1 or id == 2 or id == 3 then --攻击，最大生命，防御需要获取卡牌基础属性进行计算
			upAdd = upAdd * self:GetLv();
			num = math.modf((add + upAdd + 1) * card:GetCurDataByKey("attack"));
		else--其余相加即可
			num = add + upAdd;
		end
	end
	return id, num;
end

--根据基础属性id返回最终加成值
function this:GetBaseAddByID(fid)
	for i=1,g_EquipMaxAttrNum do
        local id,add,upAdd=self:GetBaseAddInfo(i);
		if id==fid then
			return add+upAdd*self:GetLv();
		end
	end
end

--返回单个基础属性id，加成倍率，单次强化增加的加成倍率 num:当前第几个基础属性，如1就传1
function this:GetBaseAddInfo(index)
	local id = nil;
	local add = 0;
	local upAdd = 0;
	if index and type(index) == "number" then
		id = self.cfg["nBase" .. index];
		if id ~= nil then
			add = self.cfg["fBaseVal" .. index];
			upAdd = self.cfg["fBaseAdd" .. index];
		end
	end
	return id, add, upAdd;
end

--返回技能配置表 index:第几个技能
function this:GetSkillInfo(index)
	local cfg=nil;
	if index and self.data and self.data.skills and self.data.skills[index] then
		cfg=Cfgs.CfgEquipSkill:GetByID(self.data.skills[index]);
	end
	return cfg;
end

--是否包含某个技能
function this:ContainSkill(skillId)
	local has = false;
	if skillId then
		for i=1,g_EquipMaxSkillNum do
			local cfg=self:GetSkillInfo(i);
			if cfg and cfg.id==skillId then
				has=true;
				break;
			end
		end
	end
	return has;
end

function this:GetSkillInfoByType(skillType)
	if skillType then
		for k,v in ipairs(self.data.skills) do
			local cfg=Cfgs.CfgEquipSkill:GetByID(v);
			if cfg.group==skillType then
				return cfg;
			end
		end
	end
end

--根据主副技能类型返回技能信息
function this:GetSkillInfoByMainType(skillType,isMain)
	if skillType then
		local _isMain=false;
		local mainSkill=self:GetSkillInfo(1)
		if mainSkill and mainSkill.group==skillType then
			_isMain=true;
		end
		for k,v in ipairs(self.data.skills) do
			local cfg=Cfgs.CfgEquipSkill:GetByID(v);
			if cfg.group==skillType and ((isMain~=true and _isMain~=true) or (isMain and _isMain)) then
				return cfg;
			end
		end
	end
end

--skillTypes结构：[技能类型]=1
function this:HasAllSkillType(skillTypes,isMain)
	local has=false;
	if skillTypes then
		for k, v in pairs(skillTypes) do
			if self:GetSkillInfoByMainType(k,isMain)~=nil then
				has=true;
			else
				has=false
				break;
			end
		end
	end
	return has;
end

function this:GetMainSkillLv()
	if self.data and self.data.skills then
		local mainSkill=self:GetSkillInfo(1)
		if mainSkill then
			return mainSkill.nLv;
		end
	end
	return 0;
end

function this:GetDungeonRewards()
	return self.cfg and self.cfg.DunGeonRewards or nil;
end

--是否包含某个技能类型
function this:ContainSkillType(skillType)
	local has = false;
	if skillType then
		for i=1,g_EquipMaxSkillNum do
			local cfg=self:GetSkillInfo(i);
			if cfg and cfg.group==skillType then
				has=true;
				break;
			end
		end
	end
	return has;
end

--返回装备强化到最大等级所需的经验
function this:GetEquipMaxLvExp()
	local totalExp = 0;
	if self:GetType()==EquipType.Normal then
		if self.data then
			totalExp = totalExp - self:GetExp();
			for i = self:GetLv(), self:GetMaxLv()-1 do
				local cfg = GEquipCalculator:GetEquipExpCfg(self:GetQuality(), i);
				if cfg then
					-- Log(cfg)
					totalExp = totalExp + cfg.nExp;
				end
			end
		end
	end
	return totalExp;
end

--返回升级所需经验
function this:GetLvUpExp()
	local exp = 0;
	if self:GetType()==EquipType.Normal then
		if self.data then
			local cfg = GEquipCalculator:GetEquipExpCfg(self:GetQuality(), self:GetLv());
			if cfg then
				exp = cfg.nExp;
			end
		end
	end
	return exp;
end

--添加经验并设置当前等级和经验
function this:UpLevel(exp)
	if exp and self.data then
		local totalExp = self:GetExp() + exp;
		local upLv = 0;
		for i = self:GetLv(), self:GetMaxLv() - 1 do
			local cfg = GEquipCalculator:GetEquipExpCfg(self:GetQuality(), i);
			if cfg and totalExp >= cfg.nExp then
				totalExp = totalExp - cfg.nExp;
				upLv = upLv + 1;
			else
				break;
			end
		end
		self:SetLevel(self:GetLv() + upLv);
		self:SetExp(totalExp);
	end
end

--返回当作强化素材时的信息 table类型，exp:提供的经验,gold：所需金币
function this:GetMaterialInfo()
	local info = {
		exp = 0,
		gold = 0,
	};
	if self.data then
		local cfg = nil;
		if self:GetType()==EquipType.Normal then
			cfg=GEquipCalculator:GetEquipExpCfg(self:GetQuality(), self:GetLv())
		elseif self:GetType()==EquipType.Material then
			cfg=Cfgs.CfgMaterialEquip:GetByID(self:GetQuality());
		end
		if cfg then
			info.exp = info.exp + cfg.nMaterialExp;
			info.gold = info.gold + cfg.nMaterialCost;
		end
	end
	return info;
end

--返回出售价格
function this:GetSellPrice()
	if self.data then
		local cfg = nil;
		if self:GetType()==EquipType.Normal then
			cfg=GEquipCalculator:GetEquipExpCfg(self:GetQuality(), self:GetLv())
		elseif self:GetType()==EquipType.Material then
			cfg=Cfgs.CfgMaterialEquip:GetByID(self:GetQuality());
		end
		if cfg then
			return cfg.nSellPrice;
		end
	end
	return 0;
end

--返回出售获得的奖励
function this:GetSellRewards()
	local items = nil;
	if self.data then
		local cfg = nil;
		if self:GetType()==EquipType.Normal then
			cfg=GEquipCalculator:GetEquipExpCfg(self:GetQuality(), self:GetLv())
		elseif self:GetType()==EquipType.Material then
			cfg=Cfgs.CfgMaterialEquip:GetByID(self:GetQuality());
		end
		if cfg and cfg.jSellRewards then
			items = {};
			for k, v in ipairs(cfg.jSellRewards) do
				table.insert(items, {
					id = v[1],
					num = v[2],
					type = v[3],
				});
			end
		end
	end
	return items;
end

function this:GetDesc()
	return self.cfg and self.cfg.sDesc or "";
end

function this:GetDisClickState()
	local cid=self:GetCardId();
	if cid then
		return TrialsMgr:IsEquipLock(cid)
	end
	return false;
end

--根据等级、品质、属性计算一个自动穿戴优先值
function this:GetScore()
	local score=10;
    local lv=self:GetLv()*1;
    local quality=self:GetQuality()*3;
    local baseNum=0;
    for i=1,g_EquipMaxAttrNum do
        local id,add,upAdd=self:GetBaseAddInfo(i);
        if id and add and upAdd then
            baseNum=baseNum+1;
        end
    end
    local attr=self:GetTotalSkillValue()+baseNum;
    score=lv+quality+attr;
    return score;
end

function this:GetSkillIsLock(skillID,idx)
	local isJP=CSAPI.IsADVRegional(3);
	-- local isJP=true
	if not isJP then
		return false;
	end
	if skillID==nil or idx==nil then
		LogError("GetSkillIsLock has Error SkillID="..tostring(skillID).."\tIdx:"..tostring(idx))
		return true
	end
	local data=self:GetData()
	if skillID and idx and data then
		local tips=""
		if self:GetCfg().randSkillsCondition then
			tips=LanguageMgr:GetByID(79001,self:GetCfg().randSkillsCondition[idx]);
		end
		return GEquipCalculator:IsEquipSkillLock(data,idx,skillID),tips;
	else
		LogError("GetSkillIsLock has Error SkillID="..tostring(skillID).."\tIdx:"..tostring(idx).."\t data:"..table.tostring(data))
		return true;
	end
end

----------------------------方法-------------------
return this 