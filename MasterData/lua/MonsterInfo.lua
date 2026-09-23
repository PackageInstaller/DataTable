--怪物信息
local this={}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:Init(cfgid)
	if cfgid then
		self:InitCfg(cfgid);
		if(self.cfg) then
			local modelId = self:GetSkinID()
			self:InitModel(modelId)
		end
	end
	
	self.isMonster = true
end

function this:GetSkinID()
    return self:GetCfg() and self:GetCfg().model or nil;
end

--初始化配置
function this:InitCfg(cfgid)
	if(cfgid == nil) then
		LogError("初始化物品配置失败！无效配置idCGD");		
	end
	if(self.cfg == nil) then		
		self.cfg = Cfgs.MonsterData:GetByID(cfgid);  --持有引用
		if self.cfg then
			self.cardCfg = Cfgs.CardData:GetByID(self.cfg.card_id); --卡牌引用
		end
	end
end

function this:GetCfg()
    return self.cfg or nil;
end

function this:GetName()
    return self.cfg and self.cfg.name or "";
end

--初始化模型配置
function this:InitModel(modelId)
	if(modelId == nil) then
		LogError("该表id模型为空：" .. self.cfg.id)
		return
	end
	self.cfgModel = Cfgs.character:GetByID(modelId);
end

function this:GetCfgModel()
    return self.cfgModel or nil;
end

--返回各个属性
function this:GetProperties()
    if self.properties==nil then
        if self:GetMonsterNumericalID() then
            local curData=GCardCalculator:CalPropertys(
                self:GetCfg().id,-- self:GetMonsterNumericalID(),
                self:GetLv(),
                1,
                1,
                nil,
                self.data.skills,
                nil, true)
            self.properties={
                attack=curData.attack,
                maxhp=curData.maxhp,
                defense=curData.defense,
                speed=curData.speed,
                crit_rate=curData.crit_rate,
                crit=curData.crit,
                hit=curData.hit,
                resist=curData.resist,
                np=curData.np or 0,
                sp=curData.sp,
                sp_race=curData.sp_race,
                sp_race2=curData.sp_race2,
            };
        else
            local cfg=self:GetCfg();
            self.properties={
                attack=cfg.attack,
                maxhp=cfg.maxhp,
                defense=cfg.defense,
                speed=cfg.speed,
                crit_rate=cfg.crit_rate,
                crit=cfg.crit,
                hit=cfg.hit,
                resist=cfg.resist,
                np=cfg.np,
                sp=cfg.sp,
                sp_race=cfg.sp_race,
                sp_race2=cfg.sp_race2,
            };
        end
    end
    return self.properties;
end

--返回护甲类型
function this:GetCareer()
    return self.cfg and self.cfg.career or 1;
end

function this:GetLv()
    return self.cfg and self.cfg.level or 1;
end

function this:GetMonsterNumericalID()
    return self.cfg and self.numerical or nil;
end


function this:GetImg()
    return self:GetCfgModel() and self:GetCfgModel().card_icon1 or nil;
end

function this:GetIcon()
    return self:GetCfgModel() and self:GetCfgModel().icon or nil;
end

function this:GetCardCfg()
    return self.cardCfg;
end

--返回技能配置id
function this:GetSkills()
    local skills={};
    local cfg=self:GetCfg();
    if cfg then
        for k,v in ipairs(cfg.jcSkills) do
            table.insert(skills,v);
        end
        if cfg.tfSkills then
            for k,v in ipairs(cfg.tfSkills) do
                table.insert(skills,v);
            end
        end
    end
    return skills;
end

--返回天赋配置id
function this:GetTalents()
    return self:GetCfg() and self:GetCfg().subTfSkills or {};
end

--返回怪物信息说明
function this:GetDesc()
    if self.cfg then
        if self.cfg.isUseDesc then
            return self.cfg.desc
        elseif self.cardCfg then
            return self.cardCfg.m_Desc;
        end
    end
    return ""
end

-----------------------------------新增种族、类型、体型
--种族
function this:GetRace()
    return self.cfg and self.cfg.tRace or nil;
end

--作战类型
function this:GetStyleType()
    return self.cfg and self.cfg.tType or nil;
end

--体型
function this:GetBodyType()
    return self.cfg and self.cfg.tBody or nil;
end


return this;