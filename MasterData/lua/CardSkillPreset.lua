--卡牌技能预设
local this={};

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

--当前记录的数据
function this:SetData(_d)
    self.data=_d;
end

--- func 设置配置表ID cid:技能ID，传入进来的ID会将最后一位归1处理(自动战斗配置表中只配置了1级技能的默认AI)
function this:SetCfgID(cid)
    local id=math.floor(cid/10)*10+1;
    self.cid=id;
    self:LoadCfg();
end

function this:LoadCfg()
    if self.cid~=nil then
        local cfg=Cfgs.cfgAutoFight:GetByID(self.cid);
        if  cfg==nil then
            LogError("读取自动战斗配置出错！"..tostring(self.cid));
        end
        self.cfg=cfg;
    end
end

function this:GetCfgID()
    return self.cid;
end

function this:GetCfg()
    if self.cfg==nil then
        self:LoadCfg();
    end
    return self.cfg;
end

--AI技能策略配置信息数组
function this:GetSkillStrategyCfgs()
    local list=nil;
    if self.cfg and self.cfg.skillStrategy then
        list={};
        for k,v in ipairs(self.cfg.skillStrategy) do
            local cfg=Cfgs.cfgSkillStrategyItem:GetByID(v);
            if cfg then
                table.insert(list,cfg);
            end
        end
    end
    return list;
end

--AI选择目标配置信息数组
function this:GetAIStrategyCfgs()
    local list=nil;
    if self.cfg and self.cfg.aiStrategy then
        list={};
        for k,v in ipairs(self.cfg.aiStrategy) do
            local cfg=Cfgs.cfgAIStrategyItem:GetByID(v);
            if cfg then
                table.insert(list,cfg);
            end
        end
    end
    return list;
end

--返回当前选择的技能策略配置表
function this:GetCurrSkillStrategyCfg()
    local d=self:GetData();
    if d and d[2] and self.cfg then
        local cid=self.cfg.skillStrategy[d[2]];
        local cfg=Cfgs.cfgSkillStrategyItem:GetByID(cid);
        return cfg;
    end
    return nil;
end

--返回当前选择的AI选择目标的配置表
function this:GetCurrAIStrategyCfg()
    local d=self:GetData();
    if d and d[3] and self.cfg then
        local cid=self.cfg.aiStrategy[d[3]];
        local cfg=Cfgs.cfgAIStrategyItem:GetByID(cid);
        return cfg;
    end
    return nil;
end

--返回各项的默认配置信息,数组1，2，3的值分别对应释放顺序的值，释放策略列的下标，选择目标列的下标
function this:GetDefaultConfigs()
    local list=nil;
    if self.cfg then
        list={}
        for k,v in ipairs(self.cfg.default) do
            table.insert(list,v);
        end
    end
    return list;
end

--返回当前记录的数据
function this:GetData()
    if self.data==nil then
        self.data=self:GetDefaultConfigs();
    end
    return self.data;
end

--返回技能表配置
function this:GetSkillCfg()
    if self.cid then
        local cfg = Cfgs.skill:GetByID(self.cid);
        return cfg;
    end
    return nil;
end

return this;