--装备品质
EquipQuality = {
	gray = 1, --灰色
	green = 2,--绿色
	blue = 3,--蓝色
	violet = 4,--紫色
	orange = 5,--橙色
};

EquipLockIcon={
	lock="UIs/Equip/black_lock2.png",
	unLock="UIs/Equip/black_lock.png",
}

EquipCompareType={
	normal=1, --正常 data<data2时显示属性下降的样式
	reverse=2,--反向 data<data2时显示属性上升的样式
}

local this = {};

--返回装备基础属性名称
function this.GetBaseAttName(id)
	if id and Cfgs.CfgCardPropertyEnum then
		local cfg = Cfgs.CfgCardPropertyEnum:GetByID(id);
		return cfg.sName;
	end
	return "";
end

--返回装备基础属性的key
function this.GetBaseAttKey(id)
	if id and Cfgs.CfgCardPropertyEnum then
		local cfg = Cfgs.CfgCardPropertyEnum:GetByID(id);
		return cfg.sFieldName;
	end
	return nil;
end

--返回格式化之后的属性值字符串
function this.Format(id, val)
	if id == 1 or id == 2 or id == 3 or id == 4 or id == 9 or id == 10 or id == 11 or id == 12 or id == 13 then
		return tostring(math.modf(val));
	elseif id == 5 or id == 6 or id == 7 or id == 8 or id == 14 or id == 15 or id == 16 or id == 17 or id == 18 or id == 19 then
		return this.GetPercent(val);
	end
end

--返回格式化之后的加成字符串
function this.FormatAddtion(id, val)
	if id == 4 or id == 9 or id == 10 or id == 11 or id == 12 or id == 13 then
		return tostring(math.modf(val));
	elseif id == 1 or id == 2 or id == 3 or id == 5 or id == 6 or id == 7 or id == 8 or id == 14 or id == 15 or id == 16 or id == 17 or id == 18 or id == 19 then
		return this.GetPercent(val);
	end
end

function this.GetPercent(num)
	if num and type(num) == "number" then
		num = math.modf(tonumber(string.format("%.3f", num)) * 100);
	end
	return num .. "%";
end

--获取技能的类型名称
function this.GetSkillName(id)
	if id == nil then
		return "";
	end
	local cfg = Cfgs.CfgEquipSkillTypeEnum:GetByID(id);
	local name = cfg and cfg.sName or "";
	return name;
end

--根据技能类型和点数获取技能名称和描述
function this.GetSkillLevelInfo(id, point)
	local cfg=nil;
	local skillLevelInfo = Cfgs.CfgEquipSkill:GetGroup(id);
    if skillLevelInfo then
		for i = 1, #skillLevelInfo do
			if point < skillLevelInfo[i].nNeedVal then
				break;
			else
				cfg=skillLevelInfo[i];
			end
		end
		if cfg==nil then
			cfg = skillLevelInfo[1]
		end
	end
	return cfg;
end

--根据装备技能类型和点数返回对应技能ID
function this.GetEquipSkillID(id, point)
	local skillID = nil;
	local skillLevelInfo = Cfgs.CfgEquipSkill:GetGroup(id);
	if skillLevelInfo then
        for i = 1, #skillLevelInfo do
            if point < skillLevelInfo[i].nNeedVal then
				break;
			else
				skillID = skillLevelInfo[i].id;
			end
		end
	end
	return skillID;
end

function this.GetSlotIcon(s)
	s = s or 1;
	local cfg=Cfgs.CfgEquipSlotEnum:GetByID(s);
	return cfg.sName;
end

function this.OpenGetWay(equip)
	CSAPI.OpenView("GoodsGetWay", {info=equip});
end

--返回技能等级描述的格式
function this.GetDescFormat(cfg)
	local str=""
	if cfg then
		local skillLevelInfo = Cfgs.CfgEquipSkill:GetGroup(cfg.group);
		for k,v in ipairs(skillLevelInfo) do
			if cfg.nLv>v.nLv then
				str=str..v.sDetailed.."\n\n";
			elseif cfg.nLv==v.nLv then
				str=string.format("%s<color=#FFC432>%s</color>\n\n",str,v.sDetailed);
			else
				str=string.format("%s<color=#666666>%s</color>\n\n",str,v.sDetailed);
			end
		end
	end
	return str;
end

function this.GetFilterSkillList()
	local list={};
	for k,v in pairs(Cfgs.CfgEquipSkillTypeEnum:GetAll()) do
        if v.group and v.show==1 then
            table.insert(list,{id=v.id,sName=v.sName});
        end
	end
	table.sort(list,function(a,b)
		return a.id<b.id;
	end)
	return list;
end

return this; 