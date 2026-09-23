local this = {};
---------------------------排序子方法,返回nil是为了进行下一个方法的调用---------------------
--根据品质降序排序
function this.SortEquipByQuaily(a, b)
	if a:GetQuality() ~= b:GetQuality() then
		return a:GetQuality() > b:GetQuality();
	end
	return nil;
end

--根据等级降序排序
function this.SortEquipByLevel(a, b)
	if a:GetLv() ~= b:GetLv() then
		return a:GetLv() > b:GetLv();
	end
	return nil;
end

--根据时间降序排序
function this.SortEquipByOrder(a, b)
	if a:GetOrder() ~= b:GetOrder() then
		return a:GetOrder() > b:GetOrder();
	end
	return nil;
end

--根据锁定排序
function this.SortEquipByLock(a, b)
	if a:IsLockNum()~=b:IsLockNum() then
		return a:IsLockNum()>b:IsLockNum();
	end
	return nil;
end

--根据位置降序排序
function this.SortEquipBySlot(a, b)
	if a:GetSlot() ~= b:GetSlot() then
		return a:GetSlot() < b:GetSlot();
	end
	return nil;
end

--根据ID降序排序
function this.SortEquipByCfgID(a, b)
	if a:GetCfgID() ~= b:GetCfgID() then
		return a:GetCfgID()>b:GetCfgID();
	end
	return nil;
end

--根据是否装备排序
function this.SortEquipByEquipped(a, b)
	if a:IsEquippedNum()~= b:IsEquippedNum() then
		return a:IsEquippedNum()> b:IsEquippedNum()
	end
	return nil;
end

--根据装备类型排序
function this.SortEquipByType(a,b)
	if a:GetType()~=b:GetType() then
		return a:GetType()>b:GetType();
	end
	return nil;
end

--根据有无new字段进行排序
function this.SortEquipByNew(a,b)
	if a:IsNewNum()~= b:IsNewNum() then
		return a:IsNewNum()>b:IsNewNum()
	end
	return nil;
end

--根据装备可以提供的强化经验值排序
function this.SortEquipByMExp(a,b)
	return a:GetMaterialInfo().exp>b:GetMaterialInfo().exp;
end

---------------------------排序子方法---------------------

--排序方式
local SortFunc = {
	[1] = this.SortEquipByQuaily,
	[2] = this.SortEquipByLevel,
	[3] = this.SortEquipBySlot,
	[4] = this.SortEquipByLock,
	[5] = this.SortEquipByOrder,
	[6] = this.SortEquipByEquipped,
	[7] = this.SortEquipByNew,
	[8] = this.SortEquipByCfgID,
}

function this.SetSortSkillIDs(skillList)
	this.skillList=skillList;
end

--根据装备技能等级排序
function this.SortEquipBySkillLv(a,b)
	if a==b then
		return false;
	end
	return a:GetTotalSkillValue(this.skillList)>b:GetTotalSkillValue(this.skillList);
end

--根据技能优先级排序
function this.SortEquipBySkillPriority(a,b)
	if a==b then
		return false;
	end
	local aSortData=a:GetSkillSortValue(this.skillList);
	local bSortData=b:GetSkillSortValue(this.skillList);
	for i=1,4 do
		if aSortData[i].idx==bSortData[i].idx and aSortData[i].idx~=100 then
			if aSortData[i].val==bSortData[i].val then
				return this.SortEquipByDefault(a, b);
			else
				return aSortData[i].val>bSortData[i].val;
			end
		else
			return aSortData[i].idx<bSortData[i].idx;
		end 
	end
	return false;
end


--设置排序方式
function this.SetSort(firstIndex,_defaultList)
	this.CurrentSort = {};
	local defaultList=_defaultList or g_EquipSortOrder
	-- local list={};
	if firstIndex and type(firstIndex) == "number" then
		table.insert(this.CurrentSort, SortFunc[firstIndex]);
		-- table.insert(list,firstIndex);
		for _, v in ipairs(defaultList) do
			if v ~= firstIndex then
				table.insert(this.CurrentSort, SortFunc[v]);
				-- table.insert(list,v);
			end
		end
	else
		for _, v in ipairs(defaultList) do
			table.insert(this.CurrentSort, SortFunc[v]);
		end
	end
	-- Log("CurrentSort:");
	-- Log(list);
end

--带默认排序
function this.SortEquipByDefault(a, b)
	if a==b then
		return false;
	end
	local change1=this.SortEquipByType(a,b);
	-- local change2=this.SortEquipByEquipped(a, b);
	if change1 then
		return change1;
	-- elseif change2 then
	-- 	return change2;
	else
		for k, v in ipairs(this.CurrentSort) do
			local val = v(a, b);
			if val ~= nil then
				return val;
			end
		end
	end
	return true;
end

--排序
function this.SortEquip(a, b)
	-- if a==nil or b==nil or a==b then
	-- 	return false;
	-- end
	local isTrue=this.SortEquipByType(a,b);
	if isTrue==nil then
		for k, v in ipairs(this.CurrentSort) do
			local val = v(a, b);
			if val~=nil then
				return val;
			end
		end
	end
	return isTrue;
end

--倒序排列
function this.SortEquipRevers(a, b)
	-- if a==nil or b==nil or a==b then
	-- 	return false;
	-- end
	local isTrue=this.SortEquipByType(a,b);
	if isTrue==nil then
		for k, v in ipairs(this.CurrentSort) do
			local val = v(a, b);
			if val~=nil then
				return not val;
			end
		end
	end
	return isTrue;
end

--返回选项
-- function this.DefaultIndex()
-- 	return g_EquipSortOrder[1];
-- end


--套装排序
function this.SuitSort(a,b)
	local aNum=#a;
	local bNum=#b;
	if aNum==bNum then
		return a.cfg.id<b.cfg.id;
	else
		return aNum>bNum;
	end
end


this.SetSort(g_EquipSortOrder[1]);
return this;
