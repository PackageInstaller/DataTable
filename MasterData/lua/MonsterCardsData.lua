local this = oo.class(CharacterCardsData)

-- 设置角色物品信息
function this:Init(characterData)
    if characterData then
        self.data = characterData;
        self:InitCfg(self.data.cfgid);
        if (self.cfg) then
            local modelId = self:GetSkinID()
            self:InitModel(modelId)
        end
        -- self:InitCurData()
        self:GetTotalProperty()
    end

    self.isMonster = true
end

-- 初始化配置
function this:InitCfg(cfgid)
    if (cfgid == nil) then
        LogError("初始化物品配置失败！无效配置idCGD");
    end

    -- if(self.cfg == nil) then		
    self.cfg = Cfgs.MonsterData:GetByID(cfgid); -- 持有引用
    if self.cfg then
        self.cardCfg = Cfgs.CardData:GetByID(self.cfg.card_id); -- 卡牌引用
    end
    -- end
end

-- -- 当前使用的皮肤
-- function this:GetSkinID()
--     return self.cfg.model
-- end

-- 数值模板id
function this:GetMonsterNumericalID()
    local c = self:GetCfg();
    if c and c.numerical then
        local key = string.format("%s_%s", self:GetCfg().numerical, self:GetLv())
        local cfg = Cfgs.MonsterNumerical:GetByKey(key)
        if cfg then
            return cfg.id
        else
            LogError("未找到数值模板信息,ID:" .. tostring(self:GetCfg().numerical) .. "\t等级：" ..
                         tostring(self:GetLv()))
        end
    else
        LogError("怪物未配置数值模板ID：" .. tostring(self:GetCfgID()))
    end
end

function this:GetLv()
    return self.data.level
end

function this:GetBaseProperty()
    --self:GetMonsterNumericalID()
    if (not self.fighting) then
        self.curData = GCardCalculator:CalPropertys(self:GetCfg().id, self:GetLv(), 1, 1, nil,
            self.data.skills, nil, true)
        self.fighting = self.curData.performance or 0
    end
    -- local baseData = GCardCalculator:CalLvlPropertys(
    -- self:GetMonsterNumericalID(),
    -- self:GetLv(),
    -- 1,
    -- 1, true)
    return self.curData
end

-- 计算卡牌的最终属性
function this:GetTotalProperty()
    return self:GetBaseProperty()
    -- self.curData = GCardCalculator:CalPropertys(
    -- self:GetMonsterNumericalID(),
    -- self:GetLv(),
    -- 1,
    -- 1,
    -- nil,
    -- nil,
    -- nil, true)
    -- self.fighting = self.curData.performance or 0
    -- return self.curData
end

-- function this:GetProperty()
-- 	return 0;
-- end
function this:GetQuality()
    return self.cfg and self.cfg.quality or 1
end
-- --星级
-- function this:GetStar()
-- 	return self.cfg.quality
-- end

-- function this:GetBreakLv()
-- 	return self.cardCfg and self.cardCfg.break_level or 1;
-- end

function this:GetRoleTag()
    return self.cardCfg and self.cardCfg.role_tag or nil;
end

-- 获取名称
function this:GetName()
    return self.cfg.name
end

-- 是基础卡
function this:IsBaseCard()
    return false
end

--卡牌表
function this:GetCardCfg()
    return self.cardCfg
end

-- 获取阵营 小队
function this:GetCamp()
    return self:GetCardCfg().nClass or 1
end

function this:GetEnName()
    return self:GetCardCfg().nameEng or ""
end

-- 返回当前装备
function this:GetEquips()
    local equips = {}
    if(self.starID)then 
        local cfg = Cfgs.CfgRogueTRole:GetByID(self.starID)
        for k, v in ipairs(cfg.suitId) do
            local equip = EquipMgr:GetFakeData(v,cfg.equipLevel)
            if equip then
                table.insert(equips, equip)
            end
        end
    end 
    return equips
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

return this
