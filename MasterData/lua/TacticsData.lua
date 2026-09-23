--指挥官战术对象
local this = {};

function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end

--初始化 sSKillGroup:协议中的sSKillGroup数据结构
function this:SetData(sSKillGroup)
	if sSKillGroup then
		self.data = sSKillGroup;
		self:InitCfg(sSKillGroup.id);
	end
end

--初始化配置
function this:InitCfg(cfgid)
	if(cfgid == nil) then
		LogError("初始化指挥官战术配置失败！无效配置id");		
	end
	
	if(self.cfg == nil) then		
		self.cfg = Cfgs.CfgPlrSkillGroup:GetByID(cfgid);
	end
end

function this:GetCfgID()
	return self.cfg and self.cfg.id or nil;
end

--返回战术名称
function this:GetName()
	return self.cfg and self.cfg.sName or "";
end

--返回战术内容
function this:GetDesc()
	return self.cfg and self.cfg.desc or "";
end

--是否解锁
function this:IsUnLock()
	return self.data ~= nil;
end

--返回技能等级
function this:GetLv()
	return self.data and self.data.lv or 1;
end

--返回技能数据
function this:GetSkills()
	local cfgs = {}
	local ids =(self:IsUnLock() and self.data) and self.data.skill_ids or self.cfg.aSkillIds;
	for k, v in ipairs(ids) do
		local cfg = Cfgs.skill:GetByID(v);
		table.insert(cfgs, cfg);
	end
	return cfgs;
end

--==============================--
--desc:是否已满级
--time:2019-09-18 10:03:48
--@return 
--==============================--
function this:IsMaxLv()
	local cfgs = Cfgs.CfgPlrSkillGroupUpgrade:GetByID(self:GetCfgID())
	if(cfgs) then
		local maxLv = #cfgs.infos
		return self:GetLv() >= maxLv, maxLv
	end
	return true
end

--当前升级消耗
function this:GetCost()
	local num = 0
	local cfgs = Cfgs.CfgPlrSkillGroupUpgrade:GetByID(self:GetCfgID())
	if(cfgs) then
		local cfg = cfgs.infos[self:GetLv()]
		num =(cfg and cfg.costs) and cfg.costs[2] or 0
	end
	return num
end

--返回图标
function this:GetIcon()
	return self.cfg and self.cfg.sIcon or nil;
end

function this:GetSkillsIds()
	local cfgs = {}
	local ids =(self:IsUnLock() and self.data) and self.data.skill_ids or self.cfg.aSkillIds;
	return ids;
end

return this; 