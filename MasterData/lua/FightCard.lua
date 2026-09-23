-- OPENDEBUG()

-- 战斗伤害公式相关系数
local arrFightCoefficient = {
    { "bedamage", 1 }, -- 受到伤害系数
    { "damage", 1 }, -- 伤害系数
    { "bedamage2", 1 }, -- 受到伤害系数(怪物)
    { "damage2", 1 }, -- 伤害系数(怪物)
    { "bedamage3", 1 }, -- 受到伤害系数
    { "damage3", 1 }, -- 伤害系数    
    { "becure", 1 }, -- 受到治疗系数
    { "cure", 1 }, -- 治疗系数
    { "suck", 0 }, -- 吸血系数
    { "damagePhysics", 1 }, -- 物理伤害系数
    { "damageLight", 1 }, -- 光束伤害系数
    { "damageSpecial", 1 }, -- 特殊伤害系数
    { "careerAdjust", 1.2 }, -- 职业克制修正
}

-----------------------------------------------------------
FightCardBase = oo.class()
function FightCardBase:Init(team, id, teamID, uid, data, typ)

    LogDebugEx("FightCardBase:Init", id, teamID, uid, typ)
    ASSERT(id)
    self.id = id
    self.type = CardType.Monster
    self.progress = 0 -- 进度
    self.team = team

    if data then
        self:LoadData(data, typ)
    else
        self:LoadConfig()
    end

    data = data or {}
    for i, v in ipairs(arrFightCoefficient) do
        local key = v[1]
        self[key] = data[key] or v[2]
    end

    self.teamID = teamID
    self.uid = uid
    self.isLive = true
    self.pos = {}
    self.grids = {} -- 所占格子
    self.parent = {}
    self.buffAttr = {} -- buff所带属性
    self.attrPercent = {} -- 属性加成
    self.shield = {} -- 吸收盾

    self.tempAttr = {} -- 临时属性
    self.tempAttrPercent = {} -- 临时属性加成
    self.arrValue = {} -- 标记列表
    self.arrSign = {} -- 标记列表
    self.arrTempSign = {} -- 临时标记列表
    self.arrTempBuffEffct = {} -- 临时buff效果列表

    -- self:print()
    if data.npcid then
        self.isNpc = true
    end

    if typ then
        self.type = typ
    end

    if self.bIsCommander then
        -- 指挥官技能
        self.skillMgr = CommanderSkillMgr(self, self.skills)
        -- self.bufferMgr	= BuffMgr(self, self.team.fightMgr)
    else
        self.skillMgr = SkillMgr(self, self.skills, self.aiSetting)
        self.bufferMgr = BuffMgr(self, self.team.fightMgr)

        if self.unite then
            self.mapUnite = {}
            for k, v in pairs(self.unite) do
                self.mapUnite[v] = true
            end
        end
    end

    self.log = self.team.fightMgr.log

    self.tmpPrintLog = {} -- 临时给客户端打印日志

    -- if self.sTransform then
    -- 	self.sTransform = loadstring("return {"..self.sTransform.."}")()
    -- 	for i,v in ipairs(self.sTransform) do
    -- 		ASSERT(v[3] < 1)
    -- 	end
    -- end

    self.nUseCount = 0 -- 使用技能次数
    -- -- 无限血机制
    -- self.nTotalDamage = 0 -- 总被伤害量统计
    -- self.nStateDamage = 0 -- 阶段被伤害量统计
end

function FightCardBase:Destroy()
    -- LogDebugEx("FightCardBase:Destroy()", self.name)
    if self.bIsCommander then
        -- 指挥官技能
        self.skillMgr:Destroy()
    else
        self.skillMgr:Destroy()
        self.bufferMgr:Destroy()
    end

    for k,v in pairs(self) do
        self[k] = nil
    end
end

-- 加载角色(从配置)
function FightCardBase:LoadConfig()
    local config = MonsterData[self.id]
    ASSERT(config, "找不到怪物配置" .. self.id)

    table.copy(config, self)

    self.np = config.np or 0
    self.sp_base = config.sp
    self.xp_base = config.xp
    self.maxsp = config.maxsp or g_SpMax
    self.gridsID = config.grids

    self.hp = self.maxhp
    self.sp = self.sp_base or 0
    self.xp = self.xp_base or 0

    if config.isboss then
        self.type = CardType.Boss
        self.team.fightMgr:BossAppear(true) -- boss出现
        LogDebugEx("boss出现", self.id)
    end

    local dupId = self.team.fightMgr:GetDupId()
    if dupId and dupId > 0 then
        local dupCfg = MainLine[dupId]
        if dupCfg and (dupCfg.type == eDuplicateType.AbattoirRand or dupCfg.type == eDuplicateType.AbattoirSelect) then
            self.type = CardType.Mirror
        end
    end
    self.isMonster = true -- 从怪物表读取数据
end

-- 加载角色(从数据)
function FightCardBase:LoadData(data, typ)
    --LogTable(data, "FightCardBase:LoadData"..self.id)
    --LogTrace()
    --LogDebugEx("FightCardBase:LoadData",self.id, typ)
    self.type = typ or data.type or CardType.Card
    local config = MonsterData[self.id] or CardData[self.id]
    ASSERT(config)

    table.copy(config, self)
    if not IsRelease then
        ASSERT(self.name, "FightCardBase:LoadData() name is empty!")
    end
    self.name = self.name or "None"

    -- 通用属性
    self.sp = data.sp or 0
    self.maxsp = data.maxsp or g_SpMax
    self.maxxp = data.maxxp or 0
    self.gridsID = data.gridsID or config.grids
    self.xp = 0

    table.copy(data, self)

    self.hp = data.hp or self.maxhp
    self.grids = {} -- 所占格子

    self.isMonster = data.npcid and true
    -- LogTable(config.canFly, "FightCardBase:LoadData"..self.id)
end

-- 属性关键字
AttrTable = { "matchLevel", "level", "attack", "maxhp", "defense", "speed", "crit_rate", "crit", "hit", "resist", "sp", "sp_race", "sp_race2" }

-- 加载数值模板
function FightCardBase:LoadMonsterNumerical(level)
    LogDebugEx("LoadMonsterNumerical", level, self.numerical)
    if not self.numerical then
        return
    end

    local key = self.numerical .. "_" .. level
    local config = Cfgs.MonsterNumerical:GetByKey(key)
    ASSERT(config, "找不到配置:数值模板" .. key)

    for k, v in pairs(AttrTable) do
        self[v] = config[v]
    end
    self.hp = self.maxhp
end

-- 重置临时属性(攻击结束清理)
function FightCardBase:ResetTempAttr()
    self.tempAttr = {} -- 临时属性
    self.tempAttrPercent = {} -- 临时属性加成
end

-- 重置临时标记(回合结束清理)
function FightCardBase:ResetTempSign()
    LogDebugEx("FightCardBase:ResetTempSign()")
    -- LogTrace()
    self.arrTempSign = {} -- 临时标记列表
    self.arrTempBuffEffct = {} -- 临时buff效果列表
end

-- 出生事件
function FightCardBase:OnBorn()
    if not self.buff then
        return
    end
    for i, buffID in ipairs(self.buff) do
        self:AddBuff(self, buffID)
    end
    --LogTrace()
end

-- 坐标
function FightCardBase:SetPos(row, col)
    self.pos = { row, col }
    -- self:SetGrids(self.pos)
end

function FightCardBase:GetPos()
    return { self.pos[1], self.pos[2] }
end

-- 完整站位
function FightCardBase:SetGrids(pos)
    for i, v in ipairs(self.grids) do
        if v[1] == pos[1] and v[2] == pos[2] then
            return
        end
    end
    table.insert(self.grids, pos)
end

function FightCardBase:GetGrids()
    return self.grids
end

function FightCardBase:Rand(max)
    local mgr = self.team.fightMgr
    local rand = mgr:GetRand()
    local r = rand:Rand(max)
    return r
end

function FightCardBase:RandEx(num, num2)
    local mgr = self.team.fightMgr
    local rand = mgr:GetRand()
    local r = rand:RandEx(num, num2)
    return r
end

function FightCardBase:SendError(...)
    local mgr = self.team.fightMgr
    for i, v in ipairs(mgr.arrPlayer) do
        local player = GetPlayer(v.uid)
        GCTipTool:SendToPlrEx(player, ...)
    end
end

-- 重置伤害统计
function FightCardBase:ResetDamageStats(oSkill)
    self.currentSkill = oSkill -- 当前技能
    self.nHpBefore = self.hp -- 备份当前hp
    self.nLastHitDamage = 0 -- 上次的伤害量
    self.nSkillDamage = 0 -- 统计这次技能的总伤害
    self.nOverDamage = 0 -- 过量伤害(死亡时那一击)
    self.nOverDamageTotal = 0 -- 过量伤害(总过量伤害)

    -- 所有角色分开统计
    local mgr = self.team.fightMgr
    for i, v in ipairs(mgr.arrCard) do
        v.nBeSkillDamage = 0 -- 统计这次技能的收到总伤害
        v.nBeSkillDamagePhysics = 0 -- 统计这次技能的收到物理伤害
        v.nBeSkillDamageLight = 0 -- 统计这次技能的收到光束伤害
    end
end

-------------------------
-- 可修改的战斗属性
AttrMap = {}
AttrMap.hp            = "hp"
AttrMap.maxhp         = "maxhp"
AttrMap.defense       = "defense"
AttrMap.speed         = "speed"
AttrMap.crit_rate     = "crit_rate"
AttrMap.crit          = "crit"
AttrMap.attack        = "attack"
AttrMap.hit           = "hit"
AttrMap.resist        = "resist"
AttrMap.bedamage      = "bedamage"    -- 受到伤害系数
AttrMap.damage        = "damage"        -- 伤害系数
AttrMap.bedamage2     = "bedamage2"    -- 受到伤害系数
AttrMap.damage2       = "damage2"        -- 伤害系数
AttrMap.bedamage3     = "bedamage3"    -- 受到伤害系数
AttrMap.damage3       = "damage3"        -- 伤害系数
AttrMap.becure        = "becure"        -- 受到治疗系数
AttrMap.cure          = "cure"        -- 治疗系数
AttrMap.damagePhysics = "damagePhysics"    -- 物理伤害系数
AttrMap.damageLight   = "damageLight"    -- 光束伤害系数
AttrMap.damageSpecial = "damageSpecial"    -- 特殊伤害系数
AttrMap.suck          = "suck"        -- 吸收系数
AttrMap.careerAdjust  = "careerAdjust"        -- 克制伤害系数

function FightCardBase:Get(key)
    -- LogDebugEx("FightCardBase:Get", key)
    -- if key == "defense" then
    -- 	return (self[key] + self:GetBuffAttr(key) + self:GetTempAttr(key)) *
    -- 	(1 + self:GetAttrPercent(key) + self:GetTempAttrPercent(key)) + self.edefense -- 装备属性
    -- elseif key == "attack" then
    -- 	return (self[key] + self:GetBuffAttr(key) + self:GetTempAttr(key)) *
    -- 	(1 + self:GetAttrPercent(key) + self:GetTempAttrPercent(key)) + self.eattack -- 装备属性
    -- else
    if AttrMap[key] then
        -- LogDebugEx("val = ",self[key] , self:GetBuffAttr(key) , self:GetTempAttr(key) ,
        -- self:GetAttrPercent(key) , self:GetTempAttrPercent(key))

        -- 原来公式(临时属性加到基础属性中)
        -- local val = (self[key] + self:GetBuffAttr(key) + self:GetTempAttr(key)) *
        -- (1 + self:GetAttrPercent(key) + self:GetTempAttrPercent(key))

        -- 修改临时属性在计算完加成属性再加上去
        local val = (self[key] + self:GetBuffAttr(key)) *
                (1 + self:GetAttrPercent(key) + self:GetTempAttrPercent(key)) + self:GetTempAttr(key)

        if val <= 0 then
            val = 0
            if key == "attack" then
                val = 1
            end
        end
        return val
    else
        return self[key]
    end
end

function FightCardBase:GetID()
    return self.id
end

function FightCardBase:GetTeamID()
    return self.teamID
end

function FightCardBase:GetUID()
    return self.uid
end

function FightCardBase:GetType()
    return self.type
end

function FightCardBase:GetData()
    local data = {
        oid = self.oid,
        id = self.id,
        teamID = self.teamID,
        uid = self.uid,
        type = self.type,
        model = self.model,

        -- 通用属性
        name = self.name,
        skills = self.skills,
        eskills = self.eskills,
        buff = self.buff,
        np = self.np,
        maxcost = self.maxcost,
        numerical = self.numerical,
        matchLevel = self.matchLevel,
        level = self.level,
        attack = self:Get("attack"),
        maxhp = self:Get("maxhp"),
        defense = self:Get("defense"),
        speed = self:Get("speed"),
        crit = self:Get("crit"),
        crit_rate = self:Get("crit_rate"),
        hit = self.hit,
        resist = self.resist,
        sp = self.sp,
        sp_race = self.sp_race,
        sp_race2 = self.sp_race2,
        hp = self.hp,
        career = self.career,
        -- isUseCommon = self.isUseCommon,
        isLeader = self.isLeader,
    }
    return data
end

function FightCardBase:GetSkill(skillID)
    local skillMgr = self.skillMgr
    local oSkill = skillMgr:GetSkill(skillID)
    return oSkill
end

-- Ai选择目标
function FightCardBase:AISelectTarget(team, oSkill)
    --LogDebugEx("FightCardBase:AISelectTarget")
    if team then
        if oSkill.type == SkillType.Revive then
            -- 复活技能
            return team.filter:GetOneDead(math.random(10000))
        end

        if oSkill.range_key == "one_except_self" then
            -- 排除自己
            --LogDebugEx("one_except_self")
            return self:AIStrategySelectTarget(team, oSkill, self)
        end

        return self:AIStrategySelectTarget(team, oSkill, nil)
    end

    return {}
end

-- Ai选择目标(call skill 调用, 不会用到系统随机)
function FightCardBase:AISelectTarget4CallSkill(team, oSkill)
    --LogDebugEx("FightCardBase:AISelectTarget")
    if team then
        if oSkill.type == SkillType.Revive then
            -- 复活技能
            return team.filter:GetOneDead(self:Rand(10000))
        end

        if oSkill.range_key == "one_except_self" then
            -- 排除自己
            --LogDebugEx("one_except_self")
            return self:AIStrategySelectTarget4CallSkill(team, oSkill, self)
        end

        return self:AIStrategySelectTarget4CallSkill(team, oSkill, nil)
    end

    return {}
end

-- 目标选择策略簇
local funAIStrategySelectTarget = {}

-- 1.血量最低
funAIStrategySelectTarget[1] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetMinAttribute("hp", 1, exclude) or {}
end

-- 2.攻击最大
funAIStrategySelectTarget[2] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetMaxAttribute("attack", 1, exclude) or {}
end

-- 3.速度最快
funAIStrategySelectTarget[3] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetMaxAttribute("speed", 1, exclude) or {}
end

-- 4.防御最低
funAIStrategySelectTarget[4] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetMinAttribute("defense", 1, exclude) or {}
end

-- 5.标志buff单位
funAIStrategySelectTarget[5] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetHasBuffID(g_SummonAIBuffID, 1, exclude) or {}
end

-- 6.选择克制单位有效(有盾克制盾, 再克护甲)
funAIStrategySelectTarget[6] = function(team, oSkill, exclude, aiStrategy, rand)
    return team.filter:GetRestrain(oSkill.attackType, rand) or {}
end

-- 7.最多一行
funAIStrategySelectTarget[7] = function(team, oSkill, exclude, aiStrategy, rand)
    return team.filter:GetMaxRow(rand) or {}
end

-- 8.最多一列
funAIStrategySelectTarget[8] = function(team, oSkill, exclude, aiStrategy, rand)
    return team.filter:GetMaxCol(true, rand) or {}
end

-- 9.血量最高
funAIStrategySelectTarget[9] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetMaxAttribute("hp", 1, exclude) or {}
end

-- 10.人数最多的田字范围
funAIStrategySelectTarget[10] = function(team, oSkill, exclude, aiStrategy, rand)
    return team.filter:GetMaxTian(rand) or {}
end

-- 11.人数最多的十字范围
funAIStrategySelectTarget[11] = function(team, oSkill, exclude, aiStrategy, rand)
    return team.filter:GetMaxCross(rand) or {}
end

-- 12.拥有某个buff的人
funAIStrategySelectTarget[12] = function(team, oSkill, exclude, aiStrategy, rand)
    --LogDebugEx("funAIStrategySelectTarget[12]")
    --LogTable(aiStrategy)
    -- LogTrace()
    return team.filter:HasBuff(aiStrategy[2], aiStrategy[3], rand) or {}
end

-- 13.血量比最低
funAIStrategySelectTarget[13] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetMinPercentHp(1) or {}
end

-- 14.同调角色
funAIStrategySelectTarget[14] = function(team, oSkill, exclude, aiStrategy)
    return team.filter:GetUnite(exclude) or {}
end


-- Ai选择目标
function FightCardBase:AIStrategySelectTarget(team, oSkill, exclude)

    --LogDebugEx("AIStrategySelectTarget", oSkill.id)

    --LogTable(skill[oSkill.id], "skill")
    local aiStrategy = oSkill.aiStrategy or {}
    local ts = {}
    --LogTable(oSkill.aiStrategy, "oSkill.aiStrategy")

    local fun = funAIStrategySelectTarget[aiStrategy[1]]
    if fun then
        ts = fun(team, oSkill, exclude, aiStrategy)
    end
    -- 随机
    if #ts == 0 then
        return team.filter:GetRand(math.random(10000), exclude, true) -- 包含
    end

    return ts
end

function FightCardBase:AIStrategySelectTarget4CallSkill(team, oSkill, exclude)

    --LogDebugEx("AIStrategySelectTarget", oSkill.id)

    --LogTable(skill[oSkill.id], "skill")
    local aiStrategy = oSkill.aiStrategy_src or {} --oSkill.aiStrategy or {}  -- 后端没有同步ai到前端, 导致数据不一致
    local ts = {}
    --LogTable(oSkill.aiStrategy, "oSkill.aiStrategy")

    local fun = funAIStrategySelectTarget[aiStrategy[1]]
    if fun then
        ts = fun(team, oSkill, exclude, aiStrategy, self:Rand(10000))
    end
    -- 随机
    if #ts == 0 then
        return team.filter:GetRand(self:Rand(10000), exclude)
    end

    return ts
end


-- 获取技能释放对象列表
function FightCardBase:GetSkillRange(skillID, targetdata)
    -- LogTable(targetdata, "GetSkillRange"..skillID)
    local oSkill = self:GetSkill(skillID)
    if not oSkill then
        ASSERT(oSkill, self.name .. "没有找到技能" .. skillID)
        return {}
    end

    local mgr = self.team.fightMgr

    -- local team = self:GetTeam(targetdata.teamID)
    LogDebugEx("FightCardBase:GetSkillRange====", oSkill.target_camp, oSkill.range_key)
    local team, target, targetIDs
    if oSkill.target_camp == 0 then
        -- 敌方
        team = mgr:GetEnemyTeam(self)
        -- LogTable(team)
        LogDebug("----------")
        team:Print()
        -- 嘲讽对象
        if self.sneer then  
            if self.sneer:IsLive() then
                LogDebug("------------重选嘲讽对象----------------")
                targetdata.pos = self.sneer:GetPos()
            else
                -- 嘲讽的对象可能死亡或者被同调不在场
                self.sneer = nil
            end
        end
    elseif oSkill.target_camp == 1 then
        -- 我方
        team = self.team
    elseif oSkill.target_camp == 4 then
        -- 	-- 我方(不含自己)
        -- 	team = self.team
        ASSERT(nil, "target_camp请填1 range_key填one_except_self")
    elseif oSkill.target_camp == 3 then
        -- 全体
        ASSERT(nil, "未实现")
    else
        -- 自己
        return { self.oid }
    end

    LogTable(targetdata, "targetdata = ")
    if oSkill.range_key == "one" then
        local card = mgr:GetPosCard(targetdata.teamID, targetdata.pos)
        if not card or not card:IsLive() then
            -- ASSERT("角色死亡")
            -- if oSkill.type == SkillType.Revive then
            -- 	return {card.oid}
            -- end
            return {}
        end
        return { card.oid }

    elseif oSkill.range_key == "one_except_self" then
        --LogDebugEx("GetSkillRange one_except_self")
        local card = mgr:GetPosCard(targetdata.teamID, targetdata.pos)
        if not card or not card:IsLive() then
            return {}
        end
        if card == self then
            --ASSERT()
            card = team.filter:GetRand(1, self)[1]
            if not card then
                return {}
            end
        end
        return { card.oid }
    elseif oSkill.range_key == "one_col" then
        target = team.filter:GetCol(targetdata.pos[1], targetdata.pos[2], true) or {}
    elseif oSkill.range_key == "one_row" then
        --LogTable(targetdata.pos, "one_row")
        target = team.filter:GetRow(targetdata.pos[1], targetdata.pos[2]) or {}
    elseif oSkill.range_key == "all" then
        target = team.filter:GetAll() or {}
    elseif oSkill.range_key == "shizi1" then
        target = team.filter:DynamicCross(targetdata.pos[1], targetdata.pos[2], true)
    elseif oSkill.range_key == "tian" then
        target = team.filter:GetRect(targetdata.pos[1], targetdata.pos[2], 2, 2) or {}
    elseif oSkill.range_key == "two_col" then
        target = team.filter:Get2Col(targetdata.pos[1], targetdata.pos[2], true) or {}
    elseif oSkill.range_key == "two_row" then
        target = team.filter:Get2Row(targetdata.pos[1], targetdata.pos[2]) or {}
    elseif oSkill.range_key == "all1" then
        --前端选择全部, 但实际随机一个目标做表现
        card = team.filter:GetRand(1, self)[1]
        ASSERT(card)
        return { card.oid }
    else
        ASSERT("oSkill.range_key = " .. oSkill.range_key)
    end
    -- if table.empty(target) then
    -- 	ASSERT()
    -- end
    targetIDs = team.filter:GetIDList(target)
    return targetIDs
end

function FightCardBase:AIGetTargetPos(skillID, target, targets)
    local oSkill = self:GetSkill(skillID)
    if not oSkill then
        return {}
    end
    if not target then
        return {}
    end

    local teamID = target:GetTeamID()
    local pos = target:GetPos()
    if targets and targets.pos then
        pos = targets.pos
    end
    --LogTable(pos, "原来位置")

    if oSkill.range_key == "one_col" then
        pos[1] = 1
        -- 遇到多占位的目标 拿到的位置可能不是想要的
        if target.gridsID and targets.col then 
            pos[2] = targets.col
        end
    elseif oSkill.range_key == "one_row" then
        pos[2] = 1
        -- 遇到多占位的目标 拿到的位置可能不是想要的
        if target.gridsID and targets.row then 
            pos[1] = targets.row
        end
    elseif oSkill.range_key == "tian" then
        if targets.pos then
            -- for i,v in ipairs(targets) do
            -- 	local p = v:GetPos()
            -- 	if p[1] < pos[1] then
            -- 		pos[1] = p[1]
            -- 	end
            -- 	if p[2] < pos[2] then
            -- 		pos[2] = p[2]
            -- 	end
            -- end
        else
            if pos[1] > 1 then
                pos[1] = pos[1] - 1
            end
            if pos[2] > 1 then
                pos[2] = pos[2] - 1
            end
        end
    end
    --LogTable(pos, "计算后位置")
    targetdata = {
        teamID = teamID,
        pos = pos,
    }
    return targetdata
end

-- 选中血量最少的对象
function FightCardBase:AIGetTarget(skillID)
    --LogDebugEx("AIGetTarget(skillID)", skillID)
    -- 触发AI
    local mgr = self.team.fightMgr
    local skillMgr = self.skillMgr
    local currskill = skillMgr:GetSkill(skillID)

    local team, target, targetIDs, targetdata, pos
    if currskill.target_camp == 0 then
        -- 敌方
        team = mgr:GetEnemyTeam(self)
    elseif currskill.target_camp == 1 then
        -- 我方
        team = self.team
        -- elseif currskill.target_camp == 4 then
        -- 	-- 我方(不含自己)
        -- 	team = self.team
    else
        -- 自己
        targetIDs = { self.oid }
    end

    if team then
        --LogDebug("11111111111111111111111111111111")
        -- target = team.filter:GetMinAttribute("hp") or {} -- 这里不能用AI随机打, 否则会随机到不同的角色 --self:AISelectTarget(team, currskill)
        --LogDebug("22222222222222222222222")
        target = self:AISelectTarget4CallSkill(team, currskill)

        if target[1] then
            targetdata = self:AIGetTargetPos(skillID, target[1], target)
            pos = targetdata.pos
            targetIDs = self:GetSkillRange(skillID, targetdata)
        else
            targetIDs = team.filter:GetIDList(target)
        end
    end

    local data = {}
    data.casterID = self.oid
    data.targetIDs = targetIDs
    data.pos = pos
    data.skillID = skillID

    --LogTable(data, "AIGetTarget = ")

    return data
end

-- 是否可以召唤
function FightCardBase:CanSummon(monsterID, target_camp, pos)
    LogDebugEx("FightCardBase:CanSummon", target_camp, table.Encode(pos))
    local mgr = self.team.fightMgr
    if target_camp == 1 then
        local team = self.team
        return team:CanSummon(pos)
    elseif target_camp == 2 then
        local team = mgr:GetEnemyTeam(self)
        return team:CanSummon(pos)
    end
    return true
end

-- 是否可以机神同调
function FightCardBase:CanSummonUnite(monsterID, target_camp, pos)
    LogDebugEx("FightCardBase:CanSummonUnite", target_camp, table.Encode(pos))
    local mgr = self.team.fightMgr
    if target_camp == 1 then
        local team = self.team
        return team:CanSummonUnite(pos, monsterID)
    elseif target_camp == 2 then
        local team = mgr:GetEnemyTeam(self)
        return team:CanSummonUnite(pos, monsterID)
    end
    return true
end

---------buffer接口---------------------------------------------------
-- 属性直加
function FightCardBase:AddBuffAttr(key, val)
    if not AttrMap[key] then
        return
    end

    self.buffAttr[key] = self.buffAttr[key] or 0
    self.buffAttr[key] = self.buffAttr[key] + val
end

function FightCardBase:GetBuffAttr(key)
    return self.buffAttr[key] or 0
end

-- 属性加成
function FightCardBase:AddAttrPercent(key, val)
    if not AttrMap[key] then
        return
    end

    self.attrPercent[key] = self.attrPercent[key] or 0
    self.attrPercent[key] = self.attrPercent[key] + val
    LogDebugEx("属性加成", self.name, key, val, self.attrPercent[key])
    -- LogTrace()
end

function FightCardBase:GetAttrPercent(key)
    return self.attrPercent[key] or 0
end

-- 临时属性直加
function FightCardBase:AddTempAttr(key, val)
    -- LogTrace()
    LogDebugEx("临时属性直加", self.name, key, val)
    if not AttrMap[key] then
        return
    end

    self.tempAttr[key] = self.tempAttr[key] or 0
    local old = self:Get(key)
    self.tempAttr[key] = self.tempAttr[key] + val
    LogDebugEx("FightCardBase:AddTempAttr 22", old, self:Get(key), key, val, self.tempAttr[key])
end

function FightCardBase:GetTempAttr(key)
    return self.tempAttr[key] or 0
end

-- 临时属性加成
function FightCardBase:AddTempAttrPercent(key, val)
    if not AttrMap[key] then
        return
    end

    self.tempAttrPercent[key] = self.tempAttrPercent[key] or 0
    self.tempAttrPercent[key] = self.tempAttrPercent[key] + val
end

function FightCardBase:GetTempAttrPercent(key)
    return self.tempAttrPercent[key] or 0
end

-- 嘲讽
function FightCardBase:Sneer(caster)
    self.sneer = caster
end

-- -- 隐形
-- function FightCardBase:Stealth(flag)
-- 	self.stealth = flag
-- end

-- 沉默
function FightCardBase:Silence(flag)
    LogDebugEx("沉默--", self.name)
    self.silence = flag
end

-- 无视单攻
function FightCardBase:IgnoreSingleAttack(flag)
    LogDebugEx("无视单攻--", self.name)
    self.bIgnoreSingleAttack = flag
end

-- 无视光束盾物理盾攻击
function FightCardBase:IgnoreShield(ty)
    LogDebugEx("无视光束盾物理盾攻击--", self.name)
    self.bIgnoreShield = ty
end

-- 无视分摊伤害
function FightCardBase:IgnoreShareDamage(ty)
    LogDebugEx("无视分摊伤害--", self.name)
    self.bIgnoreShareDamage = ty
end


--设置临时标记
function FightCardBase:SetTempSign(key, val)
    LogDebugEx("--设置临时标记", self.name, key, val)
    self.arrTempSign[key] = val or 0
end

--获取临时标记
function FightCardBase:GetTempSign(key)
    LogDebugEx("--获取临时标记", self.name, key, self.arrTempSign[key])
    return self.arrTempSign[key]
end

--临时标记自加
function FightCardBase:AddTempSign(key)
    LogDebugEx("--临时标记自加", self.name, key, self.arrTempSign[key])
    self.arrTempSign[key] = self.arrTempSign[key] or 0
    self.arrTempSign[key] = self.arrTempSign[key] + 1
    return self.arrTempSign[key]
end

function FightCardBase:GetTempBuffEffct(key)
    -- LogDebugEx("--获取buff临时标记", self.name, key)
    if not self.arrTempBuffEffct[key] or #self.arrTempBuffEffct[key] == 0 then
        return
    end
    return self.arrTempBuffEffct[key]
end


--设置标记
function FightCardBase:SetValue(key, val, data)
    LogDebugEx("--设置标记", self.name, key, val)

    self.arrValue[key] = val
end

--获取标记数据
function FightCardBase:GetValue(key)
    LogDebugEx("--获取标记数据", self.name, key, self.arrValue[key])
    return self.arrValue[key]
end

--删除标记
function FightCardBase:DelValue(key)
    LogDebugEx("--删除标记", self.name, key)
    self.arrValue[key] = nil
end

--增加标记，必须为数字型的标记 区间范围[min, max]选填
function FightCardBase:AddValue(key, val, min, max)
    self.arrValue[key] = self.arrValue[key] or 0
    --LogTrace()
    LogDebugEx("--增加标记", self.name, key, val, self.arrValue[key])
    self.arrValue[key] = self.arrValue[key] + val

    if min and self.arrValue[key] < min then
        self.arrValue[key] = min
    end

    if max and self.arrValue[key] > max then
        self.arrValue[key] = max
    end
end

--设置标记
function FightCardBase:SetSign(key, val, data)
    LogDebugEx("--设置标记", self.name, key, val)
    local t = data or {}
    t.val = val
    self.arrSign[key] = t
end

--获取标记数据
function FightCardBase:GetSign(key)
    LogDebugEx("--获取标记数据ex", self.name, key)
    -- LogDebugEx("--获取标记数据ex", self.name, key, self.arrSign[key])
    return self.arrSign[key]
end

--删除标记数据
function FightCardBase:DelSign(key)
    LogDebugEx("--删除标记数据", self.name, key)
    self.arrSign[key] = nil
end

-- 加盾
function FightCardBase:AddShield(buffer, val)
    -- buffer.shield = val
    table.insert(self.shield, buffer)
end

-- 去盾
function FightCardBase:DelShield(buffer)
    for i = #self.shield, 1, -1 do
        local v = self.shield[i]
        if v == buffer then
            table.remove(self.shield, i)
        end
    end
end

-- 加盾(减伤盾)
function FightCardBase:AddReduceShield(buffer)
    self.reduceShield = buffer
end

-- 去盾(减伤盾)
function FightCardBase:DelReduceShield(buffer)
    if self.reduceShield == buffer then
        self.reduceShield = nil
    end
end

-- 设置挡刀概率
function FightCardBase:SetProtect(nRate, target)
    LogDebugEx("FightCardBase:SetProtect", self.name, target.name, nRate)

    if nRate == 0 then
        self.protectTargetList = nil -- 挡刀只挡一次
        self.protectRate = nil
    else
        self.protectRate = nRate
        self.protectTargetList = self.protectTargetList or {}
        self.protectTargetList[target.oid] = true
    end
    -- LogTable(self.protectTargetList, "self.SetProtect"..target.name.."-"..self.name)
end
-------------------------
-- 是否挡刀
function FightCardBase:IsProtect(target)
    --LogDebugEx("IsProtect", self.oid, self.name, self.protectRate, self:IsMotionless())
    if not self:IsLive() then
        return
    end
    if not self.protectRate then
        return
    end
    if self:IsMotionless() then
        return
    end -- 无法行动

    LogDebugEx("IsProtect", self.oid, self.name, target.oid, target.name)
    LogTable(self.protectTargetList, "self.protectTargetList" .. target.oid)
    -- if self.protectTarget ~= nil and target ~= self.protectTarget then return end -- 不是保护的对象
    if not self.protectTargetList or not self.protectTargetList[target.oid] then
        LogDebug("333333333")
        return
    end -- 不是保护的对象
    local r = self:Rand(10000)
    if r <= self.protectRate then
        return true
    end
end

function FightCardBase:IsDeath()
    return not self.isLive
end

function FightCardBase:IsLive()
    return self.isLive
end

function FightCardBase:CanFly()
    return self.nMoveType == eMoveType.Fly
end

function FightCardBase:IsSummon()
    return self.type == CardType.Summon
end

function FightCardBase:IsCard()
    if self.bSummonTeammate then
        return
    end
    return self.type == CardType.Card
end

-- 是否合体怪
function FightCardBase:IsUnite()
    return self.type == CardType.Unite
end

function FightCardBase:IsMotionless()
    return self.bufferMgr:IsMotionless()
end

arrKeyOfGetBufferCount = {}
arrKeyOfGetBufferCount[1] = "GetBufferCountGroup"
arrKeyOfGetBufferCount[2] = "GetBufferCountQuality"
arrKeyOfGetBufferCount[3] = "GetBufferCountID"
arrKeyOfGetBufferCount[4] = "GetBufferCountType"

-- 获取某类buff的数量
-- typ:
-- 1. "GetBufferCountGroup" 
-- 2. "GetBufferCountQuality"
-- 3. "GetBufferCountID"
-- 4. "GetBufferCountType"
function FightCardBase:GetBufferCount(buffID, typ)
    LogDebugEx("FightCardBase:GetBufferCount", buffID, typ)
    return self.bufferMgr[typ](self.bufferMgr, buffID)
end

-- 判断是否存在buff
function FightCardBase:HasBuff(buffID, typ)

    LogDebugEx("FightCardBase:HasBuff", buffID, typ)
    typ = typ or 3
    local funkey = arrKeyOfGetBufferCount[typ]

    if self:IsLive() and self:GetBufferCount(buffID, funkey) > 0 then
        return true
    end

    return false
end

-------------------------
-- 计算下次达到终点时间
function FightCardBase:CalcNextTime()
    if self.progress > 1000 then
        return 0
    end
    local distances = 1000 - self.progress
    return distances / self:Get("speed")
end

-- 拉条时间
function FightCardBase:AddTime(t)
    self.progress = math.floor(self.progress + self:Get("speed") * t)
end

-- 获取buff总拉条比例
function FightCardBase:GetProgressPercent()

    if not self.tAddProgressBuffer then return end

    local fPercent = 0
    for k,v in pairs(self.tAddProgressBuffer) do
        fPercent = fPercent + v
    end

    if fPercent > 1 then
        return 1
    end

    if fPercent < 0 then
        return 0
    end

    return fPercent
end

-- 拉条
function FightCardBase:AddProgress(d, max, effectID, caster)
    ---注:max参数现在不用了

    -- 免疫拉条
    if d >= 0 and self:GetTempSign("ImmuneAddProgress") then
        self.log:Add({ api = "AddProgress", targetID = self.oid, attr = "progress",
                       progress = self.progress, add = 0, effectID = effectID, abnormalities = "ImmuneAddProgress" })
        return
    end

    -- 免疫退条
    if d < 0 and self:GetTempSign("ImmuneRetreat") then
        self.log:Add({ api = "AddProgress", targetID = self.oid, attr = "progress",
                       progress = self.progress, add = 0, effectID = effectID, abnormalities = "ImmuneRetreat" })
        return
    end

    local fPercent = self:GetProgressPercent()
    if fPercent then
        -- 拉条率
        d = math.floor(d * (1-fPercent))
    end

    LogDebugEx("拉条", self.name, self.progress, d)
    self.progress = self.progress + d
    if self.progress > 1000 then
        self.progress = 1001

        if d > 1001 then
            -- 插队
            self.progress = d
        end
    end
    if self.progress < 0 then
        self.progress = 0
    end

    self.log:Add({ api = "AddProgress", targetID = self.oid, attr = "progress",
                   progress = self.progress, add = d, effectID = effectID })

    local mgr = self.team.fightMgr
    if mgr.currTurn then
        mgr:UpdateProgress(nil, mgr.currTurn, false)
        if d >= 0 then
            mgr:DoEventWithLog("OnAddProgress", caster, self)
        else
            mgr:DoEventWithLog("OnReduceProgress", caster, self)
        end
    end
    mgr:PrintCardInfo("拉条结果")

end

-- 使用完后进入下一次跑条
function FightCardBase:NextProgress()
    self.progress = self.progress - 1000
    if self.progress < 0 then
        self.progress = 0
    end
end

-- 处理盾吸收伤害
function FightCardBase:DealShield(num, killer)
    local shield = 0 --盾吸收的伤害

    if num < 0 then
        --  普通盾
        for i, v in ipairs(CopyIpairs(self.shield)) do
            local ret, absorb, residue = v:OnShield(num, killer)
            if not ret then
                return false, absorb, 0
            else
                num = residue
                shield = shield + absorb
            end
        end

        -- 盾墙
        local mgr = self.team.fightMgr
        local shieldWall = mgr:GetShieldWall(self.teamID)
        for i, v in ipairs(CopyIpairs(shieldWall)) do
            local ret, absorb, residue = v:OnShieldWall(num, killer)
            if not ret then
                return false, absorb, 0
            else
                num = residue
                shield = shield + absorb
            end
        end

        -- 减伤盾
        if self.reduceShield then
            local ret, absorb, residue = self.reduceShield:OnReduceShield(num, killer)
            num = residue
            -- shield = shield + absorb --减伤盾不用显示
        end
    end

    LogDebug(string.format("盾吸收的伤害[%s],剩余伤害[%s]", shield, num))
    return true, shield, num
end

-- 加血扣血
function FightCardBase:AddHp(num, killer, bNotDeathEvent, bNotDealShield)
    LogDebugEx("FightCardBase:AddHp", self.name, self.hp, num, bNotDeathEvent, bNotDealShield)

    -- if num<-2 then Pause() end

    local onum = num
    local shield = 0
    local isshield = nil

    if not bNotDealShield then
        isshield, shield, num = self:DealShield(num, killer)
        if not isshield then
            LogDebug("完全被盾吸收,盾吸收的伤害[%s],伤害[%s]", shield, num, isshield)
            return false, shield, num
        end
    end
    local tisdeath, shield2, num2, abnormalities = self:AddHpNoShield(num, killer, bNotDeathEvent,true)
    if num < 0 then
        -- 传给统计接口
        local mgr = self.team.fightMgr
        if mgr.nTPCastRate then
            num = math.floor(num * mgr.nTPCastRate)
        end
        mgr:DamageStat(killer, -num)

    end

    return tisdeath, shield, num, abnormalities
end

-- 加血扣血(不扣盾)
function FightCardBase:AddHpNoShield(num, killer, bNotDeathEvent,isFromAddHp)
    -- LogDebugEx("FightCardBase:AddHpNoShield", num, self.hp, bNotDeathEvent)
    -- LogTrace()
    local mgr = self.team.fightMgr
    if mgr.isSingleFight and not isFromAddHp and num < 0 then
        -- 传给统计接口
        mgr:DamageStat(killer, -num)
    end

    local onum = num
    local shield = 0 --盾吸收的伤害

    if num < 0 then
        self.nBeSkillDamage = self.nBeSkillDamage or 0
        self.nBeSkillDamage = self.nBeSkillDamage - num
        -- LogDebugEx("FightCardBase:AddHpNoShield", self.name, self.nBeSkillDamage, num, self.nTotalDamage)
        
        if self.isInvincible then -- 无限血机制统计伤害 1钓鱼佬  2可杀死共用血条  3无限血共用血条
            mgr:AddInvincibleDamage(- num)
            -- self.nTotalDamage = self.nTotalDamage - num
            -- self.nStateDamage = self.nStateDamage - num
            if self.isInvincible == 2 then 
                -- self.hp = self.hp + num
                self.team:ShareHp(mgr.nInvStateDamage, mgr.nInvStatehp)
            else
                self.hp = self:Get("maxhp") -- 恢复血量
            end
            LogDebugEx("AddHpNoShield", self.isInvincible, self.hp, self:Get("maxhp") )
            self.log:Add({ api = "UpdateDamage", --[[targetID = self.oid, statehp = mgr.nInvStatehp, ]]nTotalDamage = mgr.nInvTotalDamage, nStateDamage = mgr.nInvStateDamage})
            
            return false, 0, num
        end
    end

    -- 免疫死亡
    if num < 0 and self.hp + num <= 0 and self:GetTempSign("ImmuneDeath") then
        num = 1 - self.hp
        self.hp = 1
        return false, shield, num, "ImmuneDeath"
    end

    LogDebugEx("FightCardBase:AddHp2", self.name, self.hp, onum, num)
    self.hp = self.hp + num

    if self.hp > self:Get("maxhp") then
        self.hp = self:Get("maxhp")
    end

    -- 限制回血上限
    if num > 0 and self.fCurePercent then
        local max = math.floor(self:Get("maxhp") * self.fCurePercent) -- 每次重新计算回血最大血量, 避免最大血量调整需要重新计算
        if self.hp > max then
            self.hp = max
        end
    end

    LogDebugEx("FightCardBase:AddHp end", self.name, self.hp, onum, num)
    if self.hp <= 0 then
        if self.isLive then
            self.nOverDamage = -self.hp
        end
        self.nOverDamageTotal = -self.hp

        -- 本来活着被打死才调用接口,已经死亡不再调用死亡事件
        if self.isLive and not bNotDeathEvent then
            self:OnDeath(killer)
        end
        self.isLive = false

        --LogTrace()
        return true, shield, num
    end

    return false, shield, num
end

-- 强制死亡
function FightCardBase:ForceDeath(killer)
    -- LogDebugEx("FightCardBase:ForceDeath", self:Get("hp"))
    self.log:Add({api="AddHp", death = true, targetID = self.oid, casterID = self.oid,
    attr = "hp", hp = 0, add = -(self:Get("hp")+1)}) 

    self.hp = 0
    self.isLive = false
    self.team.fightMgr.needCheckOver = self
end

-- 加血扣血(血量保护)
function FightCardBase:AddHpProtect(num, killer, bNotDeathEvent, bNotDealShield)

    LogDebugEx("FightCardBase:AddHpProtect")

    local onum = num
    local shield = 0
    local isshield = nil
    if not bNotDealShield then
        isshield, shield, num = self:DealShield(num, killer)
        if not isshield then
            LogDebug("完全被盾吸收,盾吸收的伤害[%s],伤害[%s]", shield, num, isshield)
            return false, shield, num
        end
    end

    -- 血量保护
    if num < 0 and self:GetTempSign("HpProtect") and self:GetTempSign("HpProtect") > 0 and self.hp + num <= self:GetTempSign("HpProtect") then
        LogDebug(string.format("血量保护,血[%d]保[%d],原扣[%d]实扣[%d]", self.hp, self:GetTempSign("HpProtect"), num, self:GetTempSign("HpProtect") - self.hp))
        num = self:GetTempSign("HpProtect") - self.hp
        self.hp = self:GetTempSign("HpProtect")
        self.nBeSkillDamage = self.nBeSkillDamage or 0
        self.nBeSkillDamage = self.nBeSkillDamage - num
        return false, shield, num, "HpProtect"
    end

    local tisdeath, shield2, num2, abnormalities = self:AddHpNoShield(num, killer, bNotDeathEvent,true)
    return tisdeath, shield, num, abnormalities
end

-- 
function FightCardBase:AddXP(num, effectID)
    LogDebugEx("FightCardBase:AddXP", self.maxxp, self.xp, num)
    --LogTrace()

    local sign = self:GetSign("signAddXp") -- 无法获取Xp标记
    if num > 0 and sign and sign.val then
        num = num - sign.val
        if num <= 0 then
            return
        end
    end

    self.xp = self.xp + num
    if self.xp > self.maxxp then
        self.xp = self.maxxp
    end
    if self.xp < 0 then
        self.xp = 0
    end
    self.log:Add({ api = "AddXp", targetID = self.oid, attr = "xp", xp = self.xp, add = num, effectID = effectID })
end

function FightCardBase:CheckXP(num)
    if self.xp and self.xp >= num then
        return true
    end
end

function FightCardBase:AddSP(num, effectID, isCost)
    LogDebugEx("FightCardBase:AddSP", self.sp, num)

    local sign = self:GetSign("signAddSP") -- 无法获取NP/SP标记
    if num > 0 and sign and sign.val then
        num = num - sign.val
        if num <= 0 then
            return
        end
    end

    self.sp = self.sp + num
    if self.sp > self.maxsp then
        self.sp = self.maxsp
    end
    if self.sp < 0 then
        self.sp = 0
    end

    self.log:Add({ api = "AddSp", targetID = self.oid, attr = "sp", sp = self.sp, add = num, effectID = effectID })
end

function FightCardBase:AddNP(num, apiSetting)
    LogDebugEx("FightCardBase:AddNP", num)

    local sign = self:GetSign("signAddNp") -- 无法获取NP/SP标记
    if num > 0 and sign and sign.val then
        num = num - sign.val

        if num < 0 then
            return
        end
    end

    local mgr = self.team.fightMgr
    mgr:AddNP(self:GetTeamID(), num, apiSetting)
end

function FightCardBase:CheckSP(num)
    if self.sp and self.sp >= num then
        return true
    end
end
----------event------------
function FightCardBase:OnTimer(tm)
end

-- 轮到我的回合
function FightCardBase:OnTurn(isMotionless)
    LogDebug("轮到:" .. self.name)
    local mgr = self.team.fightMgr
    self.skillMgr:CoolDown()
    local ty = self:GetType()
    if ty == CardType.Monster or ty == CardType.Boss then
        self:AddXP(1)
    else
        local effect = SkillEffect[72001]
        self:AddNP(g_cardCost, effect.apiSetting)
    end
end

-- 死亡
function FightCardBase:OnDeath(killer)
    LogDebugEx(self.name, "被", killer.name, "杀死")

    self.currKiller = killer

    -- 删除buff
    self.bufferMgr:OnSelfDeath()

    local mgr = self.team.fightMgr
    mgr:OnDeath(self, killer)

    self.skillMgr:DeleteEvent()
end

-- 其他人死亡
function FightCardBase:OnOtherDeath(card)
    self.bufferMgr:OnOtherDeath(card)
end

-- 主动攻击
g_SPRate_1 = g_SPRate[1]
g_SPRate_2 = g_SPRate[2]
function FightCardBase:OnAttack(caster, target, oSkill, ret)

    if self.sp_race and self.sp_race > 0 then
        -- local sp = oSkill.sp or 0
        local np = oSkill.np or 0
        self:AddSP(math.floor(self.sp_race * (g_SPRate_1 + np / g_SPRate_2)))
    end
end

-- 主动攻击后
function FightCardBase:AfterAttack(caster, target, oSkill, ret)
    for i, v in ipairs(target) do
        v:AfterBeAttack(caster, v, oSkill)
    end
end

-- 受击
function FightCardBase:OnBeAttack(caster, target, oSkill)
    LogDebugEx("FightCardBase:OnBeAttack" .. caster.name)

    local skills = self.skillMgr:GetPassiveSkills()
    if skills then
        for i, v in ipairs(skills) do
            v:OnBeAttack(caster, self)
        end
    end

    if self.sp_race2 and self.sp_race2 > 0 then
        self:AddSP(math.floor(self.sp_race2))
    end
end

-- 受击后
function FightCardBase:AfterBeAttack(caster, target, oSkill)

end

-----------------------------------------------------------
-- 是否暴击
function FightCardBase:IsCrit(caster)
    LogDebugEx("IsCrit:", self.name, caster:Get("crit"), caster:Get("crit_rate"))

    local r = self:Rand(10000)
    local crit = 1
    LogDebugEx("IsCrit-------", math.floor(caster:Get("crit_rate")*10000), r)
    if r <= math.floor(caster:Get("crit_rate") * 10000) then
        crit = caster:Get("crit")
        return crit
    end
end

-- 普通伤害(通用)
function FightCardBase:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
    LogDebugEx("FightCardBase:GetDamageCommon:", self.name, percent, crit)
    -- LogTrace()

    if self:GetTempSign("ImmuneDamage") then
        return 0, "ImmuneDamage"
    end

    -- 伤害公式
    -- 最终伤害=总攻击*暴击伤害倍数×总防御对应的受伤率%*浮动系数*攻防类型修正*伤害buff修正*（技能基础伤害%）*
    --（1+技能效果额外伤害%）*（1+装备额外伤害%）

    local float = self:Rand(10)
    crit = crit or 1

    -- （1+攻击者造成伤害增加%-攻击者造成伤害减少%）*（1+受击者受到伤害增加%-受击者受到伤害减免%）
    local damageAdjust = caster:Get("damage") * self:Get("bedamage") * caster:Get("damage2") * self:Get("bedamage2")* caster:Get("damage3") * self:Get("bedamage3")
    percent = percent or 1
    LogDebugEx(string.format("percent[%s], damage[%s], bedamage[%s], damage2[%s], bedamage2[%s], damage3[%s], bedamage3[%s]", percent, caster:Get("damage"), self:Get("bedamage"), caster:Get("damage2") , self:Get("bedamage2"), caster:Get("damage3") , self:Get("bedamage3")))
    percent = percent * damageAdjust

    if careerAdjust then
        -- 职业克制修正
        LogDebugEx("职业克制修正 careerAdjust = ", math.max(caster:Get("careerAdjust"), g_careerAdjust), percent)
        percent = percent * math.max(caster:Get("careerAdjust"), g_careerAdjust)
    end

    LogDebugEx(string.format("最终percent[%s], attack[%s], defense[%s], crit[%s], float[%s]", percent, caster:Get("attack"), self:Get("defense"), crit, 5 - float))

    -- 战斗伤害公式
    local attack = math.floor(caster:Get("attack") * crit * (g_nFightDefense / (g_nFightDefense + self:Get("defense"))) * (105 - float) / 100 * percent)
    LogDebugEx("GetDamage attack =", attack)
    return attack
end

-- 普通伤害(物理+光束护盾通用)
function FightCardBase:GetDamageShield(caster, percent, crit, eDamage, careerAdjust, log)

    LogDebugEx("FightCardBase:GetDamageShield", self.name, caster.name, percent, eDamage, caster.bIgnoreShield, self.bIgnoreShield)
    -- LogTrace()
    -- local oBuff = self.oPhysicsShield
    if not self.oPhysicsShield and not self.oLightShield then
        -- 没有盾 用通用公式
        return self:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
    end

    -- nFactor = min(0.7, max(0.2+0.05*count, 0.3))
    local nCount = math.max((self.oPhysicsShield and self.oPhysicsShield.nCount or 0),
            (self.oLightShield and self.oLightShield.nCount or 0))
    local nFactor = 1 - math.min(0.7, math.max(g_DamageShieldFactor1 + g_DamageShieldFactor2 * nCount, 0.3))
    --LogDebugEx("GetDamageShield=nCount,nFactor",  nCount, nFactor)


    if eDamage == eDamageType.Physics then
        if not caster.bIgnoreShield or caster.bIgnoreShield == eIgnoreShield.Light then
            percent = percent * nFactor
        end
    elseif eDamage == eDamageType.Light then
        if not caster.bIgnoreShield or caster.bIgnoreShield == eIgnoreShield.Physics then
            percent = percent * nFactor
        end
    end

    -- 克制时减一层
    if eDamage == eDamageType.Light then
        if self.oPhysicsShield then
            self.oPhysicsShield:OnPhysicsShield()
            if log then 
                log.restrain = 2 -- 1物理2能量
            end
        else
            if log then 
                log.restrain = nil
            end
        end
    elseif eDamage == eDamageType.Physics then
        if self.oLightShield then
            self.oLightShield:OnLightShield()
            if log then 
                log.restrain = 1 -- 1物理2能量
            end
        else
            if log then 
                log.restrain = nil
            end
        end
    end

    LogDebugEx("GetDamageShield : percent", percent)

    return self:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
end


-- -- 普通伤害(物理护盾)
-- function FightCardBase:GetDamagePhysicsShield(caster, percent, crit, eDamage, careerAdjust)

-- 	LogDebugEx("FightCardBase:GetDamagePhysicsShield", self.name, caster.name, percent, eDamage, caster.bIgnoreShield,self.bIgnoreShield)

-- 	local oBuff = self.oPhysicsShield 
-- 	if not oBuff then
-- 		return self:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
-- 	end

-- 	-- 物理伤害减伤0.5，光束伤害减伤0.33
-- 	if eDamage == eDamageType.Physics then
-- 		if not caster.bIgnoreShield or caster.bIgnoreShield == eIgnoreShield.Light  then
-- 			percent = percent * oBuff.nPhysicsFactor
-- 		end
-- 	elseif eDamage == eDamageType.Light then
-- 		if not caster.bIgnoreShield or caster.bIgnoreShield == eIgnoreShield.Physics  then
-- 			percent = percent * oBuff.nLightFactor
-- 		end
-- 	elseif eDamage == eDamageType.Special then
-- 		if not caster.bIgnoreShield or caster.bIgnoreShield ~= eIgnoreShield.Special  then
-- 			percent = percent * oBuff.nLightFactor
-- 		end
-- 	end

-- 	if eDamage == eDamageType.Light then
-- 		oBuff:OnPhysicsShield()
-- 	end

-- 	LogDebugEx("percent", percent)

-- 	return self:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
-- end

-- -- 普通伤害(光束护盾)
-- function FightCardBase:GetDamageLightShield(caster, percent, crit, eDamage, careerAdjust)

-- 	LogDebug("FightCardBase:GetDamageLightShield")
-- 	local oBuff = self.oLightShield 
-- 	if not oBuff then
-- 		return self:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
-- 	end

-- 	-- 物理伤害减伤0.5，光束伤害减伤0.33
-- 	if eDamage == eDamageType.Physics then
-- 		if not caster.bIgnoreShield or caster.bIgnoreShield == eIgnoreShield.Light  then
-- 			percent = percent * oBuff.nPhysicsFactor
-- 		end
-- 	elseif eDamage == eDamageType.Light then
-- 		if not caster.bIgnoreShield or caster.bIgnoreShield == eIgnoreShield.Physics  then
-- 			percent = percent * oBuff.nLightFactor
-- 		end
-- 	elseif eDamage == eDamageType.Special then
-- 		if not caster.bIgnoreShield or caster.bIgnoreShield ~= eIgnoreShield.Special  then
-- 			percent = percent * oBuff.nPhysicsFactor
-- 		end
-- 	end

-- 	if eDamage == eDamageType.Physics then
-- 		oBuff:OnLightShield()
-- 	end
-- 	return self:GetDamageCommon(caster, percent, crit, eDamage, careerAdjust)
-- end

FightCardBase.GetDamage = FightCardBase.GetDamageCommon

-- 伤害
function FightCardBase:Damage(caster, percent)

    local crit = self:IsCrit(caster)
    local attack = self:GetDamage(caster, percent, crit)
    self:AddHp(-attack, caster)
    return attack
end

-- 固定伤害
function FightCardBase:FixedDamage(caster, attack)
    self:AddHp(-attack, caster)
    return attack
end

-- 检测是否免疫加buff
function FightCardBase:CheckAddBuff(caster, buffID, effectID)
    local config = BufferConfig[buffID]
    ASSERT(config, "没有配置buffID=" .. buffID)
    -- if not config then return end

    local log = { api = "AddBuff", id = caster.oid, targetID = self.oid, bufferID = buffID, effectID = effectID }


    -- LogDebugEx("ImmuneBuffQuality", config.goodOrBad, self:GetTempBuffEffct("ImmuneBuffQuality" .. config.goodOrBad))
    -- 判断buffer是否免疫
    if self:GetTempBuffEffct("ImmuneBuffQuality" .. config.goodOrBad) then
        log.abnormalities = "ImmuneBuffQuality" .. config.goodOrBad
        self.log:Add(log)
        return true
    end

    if self:GetTempBuffEffct("ImmuneBufferGroup" .. config.group) then
        log.abnormalities = "ImmuneBufferGroup" .. config.group
        self.log:Add(log)
        return true
    end

    if self:GetTempBuffEffct("ImmuneBuffID" .. config.id) then
        log.abnormalities = "ImmuneBuffID" .. config.id
        self.log:Add(log)
        return true
    end
end

-- 加buff
function FightCardBase:AddBuff(caster, buffID, nRoundNum, effectID, addType)
    LogDebugEx("FightCardBase:AddBuff", buffID)

    if self:CheckAddBuff(caster, buffID, effectID) then
        return
    end
    local log = { api = "AddBuff", id = caster.oid, targetID = self.oid, bufferID = buffID, effectID = effectID }
    self.log:Add(log)

    local buff = self.bufferMgr:Add(self, caster, buffID, nRoundNum, effectID)
    if buff then
        log.uuid = buff.uuid
        log.round = buff.round
    end
    return buff
end

-- 加buff层数
function FightCardBase:AddBuffCount(caster, buffID, nCount, limit, effectID)
    LogDebugEx("FightCardBase:AddBuffCount", buffID)

    if self:CheckAddBuff(caster, buffID, effectID) then
        return
    end
    -- local log = {api="AddBuff", id = caster.oid, targetID = self.oid, bufferID = buffID, effectID = effectID}

    local buff = self.bufferMgr:AddCount(self, caster, buffID, nCount, limit, effectID, log)
    -- if buff then
    -- 	log.uuid = buff.uuid
    -- 	log.nCount = buff.nCount
    -- end

    return buff
end


-- 减buff
function FightCardBase:DelBuff(caster, buffID)
end

-- 变身属性转换
function FightCardBase:Transform(state)

    LogDebugEx("FightCardBase:Transform", self.oid, self.name)
    local log = { api = "Transform", id = self.oid, attr = {}, state = state }

    -- 临时存储原始数值
    self.tTransfoAttr = self.tTransfoAttr or {}

    local skillMgr = self.skillMgr
    skillMgr:DeleteEvent()

    if self.tTransfo[state] then
        local config = Transform[self.tTransfo[state]]
        ASSERT(config, "没有变身技能配置 id = " .. self.id .. " state = " .. state)
        local cfgNewCardData = CardData[config.id]
        ASSERT(cfgNewCardData, "没有变身卡牌配置 id = " .. self.id .. " model = " .. config.model)
        self.sTransformModel = config.model -- 变身模型
        if self.modelA and self.modelA > 0 then
            self.sTransformModel = self.modelA
        end
        log.model = self.sTransformModel

        -- 123技能,天赋(等级继承)   特殊技能不继承(读卡牌配置),  其他技能完全继承
        if not self.tTransfoSkills then
            local tTransfoSkills = {}
            local tmpSkills = {}
            for i, v in ipairs(skillMgr.skills) do
                LogDebugEx("原来技能", i, v.id, v.upgrade_type, v.main_type)
                if v.type ~= SkillType.Summon and v.type ~= SkillType.Unite and v.type ~= SkillType.SummonUnite
                        and v.type ~= SkillType.Transform then
                    -- 排除特殊技能

                    if (v.upgrade_type and v.upgrade_type >= CardSkillUpType.A and v.upgrade_type <= CardSkillUpType.OverLoad) then

                        -- 需要修改等级(123技能)
                        if tmpSkills[v.upgrade_type] then
                            ASSERT(nil, v.upgrade_type .. "技能类型重复" .. tmpSkills[v.upgrade_type].id .. "&" .. v.id)
                        end
                        tmpSkills[v.upgrade_type] = v
                    elseif (v.upgrade_type and v.upgrade_type >= 9) then
                        -- 不继承
                    elseif v.main_type == SkillMainType.CardTalent then
                        -- 需要修改等级(主天赋)
                        if tmpSkills[5] then
                            ASSERT(nil, "主天赋重复" .. tmpSkills[5].id .. "&" .. v.id)
                        end
                        tmpSkills[5] = v
                    else
                        -- 其他技能完全继承
                        table.insert(tTransfoSkills, v.id)
                    end
                end
            end
            -- LogTable(tmpSkills)
            for i, skillID in ipairs(cfgNewCardData.jcSkills or {}) do
                -- LogDebugEx("-------", skillID)
                local cfgSkill = skill[skillID]
                ASSERT(cfgSkill, "找不到变身技能配置jc id = " .. skillID)
                -- LogTable(cfgSkill)
                local sold = tmpSkills[cfgSkill.upgrade_type]
                local flag = true
                if sold then
                    local newSkillID = math.floor(skillID / 10) * 10 + sold.lv
                    if skill[newSkillID] then
                        table.insert(tTransfoSkills, newSkillID)
                        flag = false
                    end
                end

                if flag then
                    table.insert(tTransfoSkills, skillID)
                end
            end

            for i, skillID in ipairs(cfgNewCardData.tfSkills or {}) do
                local cfgSkill = skill[skillID]
                ASSERT(cfgSkill, "找不到变身技能配置tf id = " .. skillID)
                local sold = tmpSkills[5]
                local flag = true
                if sold then
                    local newSkillID = math.floor(skillID / 10) * 10 + sold.lv
                    if skill[newSkillID] then
                        table.insert(tTransfoSkills, newSkillID)
                        flag = false
                    end
                end
                if flag then
                    table.insert(tTransfoSkills, skillID)
                end
            end

            for i, skillID in ipairs(cfgNewCardData.tcSkills or {}) do
                table.insert(tTransfoSkills, skillID)
            end

            LogTable(tTransfoSkills, "变身技能")
            self.tTransfoSkills = tTransfoSkills
        end
        log.skills = self.tTransfoSkills
        skillMgr.list = log.skills
        skillMgr:InitSkill()

        local from, to, percent, transRate = loadstring("return " .. config.sTransform)()
        LogDebugEx("sTransform", from, to, percent, transRate)
        ASSERT(percent <= 1)

        if not self[from] or not self[to] then
            ASSERT()
            return
        end

        -- LogDebugEx("sTransform-222--",from, to, self[from], self[to])
        -- log.sattr = {}
        -- log.sattr[from]	= self[from]
        -- log.sattr[to]	= self[to]

        if not self.tTransfoAttr[from] then
            self.tTransfoAttr[from] = self[from]
        end

        if not self.tTransfoAttr[to] then
            self.tTransfoAttr[to] = self[to]
        end

        --attack	maxhp	defense	speed
        function IsNeedFloor(key)
            local list = { "attack", "maxhp", "defense", "speed" }
            for i, v in ipairs(list) do
                if key == v then
                    return true
                end
            end
        end

        local base = self.tTransfoAttr[from] * percent
        self[from] = self[from] - base
        self[to] = self[to] + base * transRate

        if IsNeedFloor(from) then
            self[from] = math.floor(self[from])
        end
        if IsNeedFloor(to) then
            self[to] = math.floor(self[to])
        end

        if from == "maxhp" and self.hp > self:Get("maxhp") then
            self.hp = self.maxhp
            log.attr.hp = self.maxhp
        end

        log.attr[from] = self[from]
        log.attr[to] = self[to]

        self.nTransformState = state
    else
        log.model = self.model
        log.skills = table.copy(self.skills)
        skillMgr.list = log.skills
        skillMgr:InitSkill()
        skillMgr:SetAI()

        -- 还原属性
        for k, v in pairs(self.tTransfoAttr) do
            self[k] = v
            log.attr[k] = v
        end

        self.nTransformState = nil
        self.sTransformModel = nil
    end
    self.log:Add(log)
    
    local mgr = self.team.fightMgr
    mgr:DoEventWithLog("OnTransform", self, self)
end

-- 镜像技能
function FightCardBase:AddMirrorSkill(oSkill, target)

    LogDebugEx("FightCardBase:AddMirrorSkill", self.oid, self.name, target.oid, target.name)

    ASSERT(oSkill.upgrade_type == 3 or oSkill.upgrade_type == 4, "技能类型有误") -- 大招或者overload

    -- self.oSrcSkill = oSkill -- 保留原技能
    local targetSkillMgr = target.skillMgr

    local oTargetSkill = targetSkillMgr.mapSlotSkills[oSkill.upgrade_type] -- 目标的大招技能
    ASSERT(oTargetSkill)
    self.nMirrorSkillID = oTargetSkill.id
    local log = { api = "AddMirrorSkill", id = self.oid, targetID = target.oid, nMirrorSkillID = self.nMirrorSkillID }

    local skillMgr = self.skillMgr
    skillMgr:AddMirrorSkill(self.nMirrorSkillID)

    self.log:Add(log)
end

function FightCardBase:GetClientData()
    local data = {
        id = self.oid,
        cfgId = self.id,
        model = self.sTransformModel or self.model, -- 变身模型
        skills = self.skillMgr.list, --self.skills,
        eskills = self.eskills,
        hp = self:Get("hp"),
        maxhp = self:Get("maxhp"),
        name = self.name,
        sp = self.sp,
        maxsp = self.maxsp or g_SpMax,
        xp = self.xp,
        maxxp = self.maxxp,
        grids = self:GetGrids(),
        type = self.type,
        career = self.career,
        level = self.level or 1,
        -- isUseCommon	= self.isUseCommon,
        isLeader = self.isLeader,
        fuid = self.fuid,
    }
    return data
end

function FightCardBase:GetShowData()
    local data = {
        teamId = self:GetTeamID(),
        rowIndex = self:GetPos()[1],
        colIndex = self:GetPos()[2],
        uid = self.uid,
        characterData = self:GetClientData()
    }
    return data
end

-- 使用技能次数
function FightCardBase:OnUseSkill()
    self.nUseCount = self.nUseCount + 1
end
----------------------------------------------
-- 服务端卡牌
FightCardServer = oo.class(FightCardBase)
function FightCardServer:Init(team, id, teamID, uid, data, typ)
    FightCardBase.Init(self, team, id, teamID, uid, data, typ)
end

-- 轮到我的回合
function FightCardServer:AIOnTurn(isMotionless)


    LogDebugEx("FightCardServer:AIOnTurn", isMotionless or self.bAIOnTurn, isMotionless, self.bAIOnTurn)
    local mgr = self.team.fightMgr
    -- local bIsAuto = mgr.bIsAuto

    -- 无法行动
    if isMotionless then
        -- if bIsAuto then
        -- 	mgr:Wait(1)
        -- end
        return true
    end

    -- if self.bAIOnTurn then
    -- 	mgr:Wait(1)
    -- 	return true
    -- end

    local ty = self:GetType()
    LogDebugEx("AIOnTurn", self.name, ty, isMotionless)

    if ty == CardType.Monster or ty == CardType.Boss --[[or ty == CardType.Summon]] or ty == CardType.Mirror or ty == CardType.WorldBoss --[[or bIsAuto]] then
        -- 触发AI
        self.team.fightMgr.log:Clean()
        self:DoAI()
        return true
    elseif ty == CardType.Summon or ty == CardType.Unite then
        if self:GetTeamID() == 1 or mgr.type == SceneType.PVP then
            --
            -- 我方或者pvp敌方的召唤物(或合体)需要手动操作
        else
            -- if mgr.type == SceneType.PVPMirror and self:GetTeamID() ~= 1 then
            -- 其他情况AI托管
            self.team.fightMgr.log:Clean()
            self:DoAI()
            return true
        end
    elseif ty == CardType.Card and self.bAIOnTurn and self:IsLive() then
        -- 设置为自动放技能
        self:DoAI()
        return true
    end

    LogDebugEx("AIOnTurn 没有调用AI", self.name, ty, isMotionless)
end

-- 执行AI
function FightCardServer:DoAI(isAutoFight)

    local ty = self:GetType()
    -- if ty ~= CardType.Monster and ty ~= CardType.Boss and ty ~= CardType.Summon then return end

    -- 触发AI
    local mgr = self.team.fightMgr
    local skillMgr = self.skillMgr
    local currskill = skillMgr:GetNext()
    if not currskill then
        LogDebug("FightCardServer:DoAI ==> not skill can be use")
        -- local args = GCTipTool:OneCardArg(self.cid)
        self:SendError("sNotSkillCanBeUsed", args)
        ASSERT(nil, "没有可用的技能" .. self.name)
        -- mgr:Wait(3)
        return
    end
    LogDebugEx("FightCardServer", currskill.id, type(currskill.id))
    local skillID = currskill.id

    local team, target, targetIDs, targetdata, pos
    if currskill.target_camp == 0 then
        -- 敌方
        team = mgr:GetEnemyTeam(self)
    elseif currskill.target_camp == 1 then
        -- 我方
        team = self.team
    else
        -- 自己
        targetIDs = { self.oid }
        pos = self:GetPos()
        targetdata = {
            teamID = self:GetTeamID(),
            pos = pos,
        }
    end

    if team then
        mgr:AISetFocusFire(self.team) -- AI设置集火
        local oFocusFire = self.team.oFocusFire
        if currskill.target_camp == 0 and oFocusFire and oFocusFire:IsLive() then
            -- 集火
            target = { self.team.oFocusFire }
        else
            target = self:AISelectTarget(team, currskill)
        end
        --LogTable(target, "target")
        if target[1] then
            LogDebugEx("目标是", target[1].name)

            targetdata = self:AIGetTargetPos(skillID, target[1], target)
            pos = targetdata.pos
            targetIDs = self:GetSkillRange(skillID, targetdata)

            if currskill.type == SkillType.Revive then
                targetdata.reliveID = target[1].oid
            end
        else
            -- targetIDs = team.filter:GetIDList(target)
            -- ASSERT()
            LogError("没有攻击对象")
            return
        end
    end

    -- if isAutoFight then return end

    local data = {}
    data.target = targetdata
    data.casterID = self.oid
    data.targetIDs = targetIDs
    data.pos = pos
    data.skillID = skillID
    LogTable(data, "AI Attack data= ")
    mgr:Attack(self, targetIDs, data, pos)
    mgr:AddCmd(CMD_TYPE.Skill, data)

    local action_time = (currskill.action_time / 1000)
    mgr:Wait(action_time)
end
----------------------------------------------
-- 客户端管卡牌
FightCardClient = oo.class(FightCardServer)
function FightCardClient:Init(team, id, teamID, uid, data, typ)
    FightCardBase.Init(self, team, id, teamID, uid, data, typ)
end

function FightCardClient:AddHp(num, killer, bNotDeathEvent, bNotDealShield)
    --LogDebugEx("FightCardClient:AddHp", killer.name, num)
    if num < 0 then
        local mgr = self.team.fightMgr

        if mgr.isServerMgr then
            -- LogDebugEx("----------isServerMgr------------")
        elseif mgr.DamageStat then
            mgr:DamageStat(killer, -num)
            -- LogDebugEx("----------isClientMgr------------")
        end
    end
    return FightCardBase.AddHp(self, num, killer, bNotDeathEvent, bNotDealShield)
end

function FightCardClient:AddHpNoShield(num, killer, bNotDeathEvent, isFromAddHp)
    --LogDebugEx("FightCardClient:AddHpNoShield", killer.name, num)
    if not isFromAddHp and num < 0 then
        local mgr = self.team.fightMgr

        if mgr.isServerMgr then
            -- LogDebugEx("----------isServerMgr------------")
        elseif mgr.DamageStat then
            mgr:DamageStat(killer, -num)
            --LogDebugEx("----------isClientMgr------------")
        end
    end
    return FightCardBase.AddHpNoShield(self, num, killer, bNotDeathEvent, isFromAddHp)
end
----------------------------------------------
-- if IS_CLIENT then
-- 	function GetCardClass(isClient)
-- 		if isClient then
-- 			return FightCardClient
-- 		else
-- 			return FightCardServer
-- 		end
-- 	end
-- elseif IS_SERVER then
-- 	function GetCardClass(isClient)
-- 		return FightCardServer
-- 	end
-- end

if IS_CLIENT then
    FightCard = FightCardClient
elseif IS_SERVER then
    FightCard = FightCardServer
end
-----------------------------------------------------------
-- 召唤卡牌
SummonCard = oo.class(FightCard)
function SummonCard:Init(team, id, teamID, uid, data, typ)
    FightCard.Init(self, team, id, teamID, uid, data, typ)
end

-- 死亡
function SummonCard:OnDeath(killer)
    --LogDebugEx("SummonCard:OnDeath", self.name, self.oid)
    -- LogTrace()
    FightCardBase.OnDeath(self, killer)

    self.team:DelCard(self)
    if self.oSummonOwner then
        self.oSummonOwner.oSummonObj = nil -- 设置召唤物
    end
end

function SummonCard:OnForceDeath(killer)
    -- LogTrace()
    -- 删除buff
    self.bufferMgr:OnSelfDeath()
    self.skillMgr:DeleteEvent()

    self.team:DelCard(self)

    -- 关联的召唤怪全都死了才调用
    if self.oRelevanceCard then
        for i, v in ipairs(self.oRelevanceCard) do
            if v:IsLive() then
                return
            end
        end
    end

    if self.oSummonOwner then
        self.oSummonOwner.oSummonObj = nil -- 设置召唤物
    end
end

function SummonCard:OnOtherDeath(card)

    --LogDebugEx("SummonCard:OnOtherDeath",card.name, self.name)
    FightCardBase.OnOtherDeath(self, card)

    -- 召唤者死亡
    if self.oSummonOwner and self.oSummonOwner == card then
        self.hp = 0
        self.isLive = false
        -- 强制死亡
        local log = { api = "ForceDeath", id = card.oid, targetID = self.oid }
        self.log:Add(log)
        self:OnForceDeath(card)

        -- 关联的召唤怪一起弄死
    end
end


-----------------------------------------------------------
-- 合体卡牌
UniteCard = oo.class(FightCard)
function UniteCard:Init(team, id, teamID, uid, data, typ)
    FightCard.Init(self, team, id, teamID, uid, data, typ)
end

-- -- 主动攻击
-- function UniteCard:OnAttack(caster, target, oSkill, ret)
-- 	LogDebugEx("UniteCard:OnAttack", self.sp , g_resolveSp)
-- 	FightCardBase.OnAttack(self, caster, target, oSkill, ret)
-- 	if self.sp < g_resolveSp then
-- 		self.needResolve = true
-- 	end
-- end

-- -- 受击
-- function UniteCard:OnBeAttack(caster)
-- 	LogDebugEx("UniteCard:OnBeAttack", self.sp , g_resolveSp)
-- 	FightCardBase.OnBeAttack(self, caster)
-- 	if self.sp < g_resolveSp then
-- 		self.needResolve = true
-- 	end
-- end

-- isCost :是否为技能消耗
function UniteCard:AddSP(num, effectID, isCost)
    LogDebugEx("UniteCard:AddSP", self.sp, num, isCost)
    FightCardBase.AddSP(self, num, effectID, isCost)

    -- 通过buff扣减sp也可能触发解体
    if isCost then return end -- 技能消耗, 返回
    if num >= 0 then return end -- 增加, 返回
    local mgr = self.team.fightMgr
    if mgr.bIsApply then return end -- 技能中, 返回
    if self.hp <= 1 or self.sp < g_resolveSp then
        -- 非正常的解体需要设置为技能内
        mgr.bIsApply = true
        -- mgr:Resolve(self, ret)
        self:Resolve(ret)
        mgr.bIsApply = nil
    end
end

-- 主动攻击后
function UniteCard:AfterAttack(caster, target, oSkill, ret)
    FightCardBase.AfterAttack(self, caster, target, oSkill, ret)
    if self.hp <= 1 or self.sp < g_resolveSp then
        self:Resolve(ret)
    end
end

-- 受击后
function UniteCard:AfterBeAttack(caster, target, oSkill)
    LogDebugEx("UniteCard:AfterBeAttack", self.name, self.needResolve)
    FightCardBase.AfterBeAttack(self, caster, target, oSkill)
    if self.hp <= 1 or self.sp < g_resolveSp then
        self:Resolve(self)
    end
end

-- 解体
function UniteCard:Resolve(ret)
    LogDebugEx("----------Resolve--------------", self.sp)
    -- self.team:Resolve(self, ret)
    self.team:DelCard(self) -- 删掉旧卡

    local mgr = self.team.fightMgr
    mgr:Resolve(self, ret)
    self.isLive = false
end


function UniteCard:OnRoundOver()
    -- LogDebug("self.hp = %s, self.sp = %s, oid=%s", self.hp, self.sp, self.oid, self.isResolve)
    -- if not self.isLive then return end 
    if self.isResolve then 
        return 
    end -- 禁止调用两次解体
    if self.hp <= 1 or self.sp < g_resolveSp then
        self:Resolve(self)
    end
end

-- -- 同调角色生命值为0解体
-- function UniteCard:AddHpNoShield(num, killer, bNotDeathEvent)
-- 	FightCardBase.AddHpNoShield(self, num, killer, bNotDeathEvent)
-- 	LogDebugEx("UniteCard:AddHpNoShield", num, self.hp)
-- 	if self.hp <= 1 then
-- 		self.needResolve = true
-- 	end
-- end


-- -- 伤害
-- function UniteCard:GetDamage(caster, percent)
-- 	LogDebug("GetDamage:"..self.name)
-- 	return 0, "ImmuneDamage"
-- end

-- -- 伤害
-- function UniteCard:Damage(caster, percent)
-- 	return 0
-- end

-----------------------------------------------------------
-- 公共boss卡牌(服务端)
WorldBossCardServer = oo.class(FightCardServer)
function WorldBossCardServer:Init(team, id, teamID, uid, data, typ)
    FightCardServer.Init(self, team, id, teamID, uid, data, typ)
end

--主要是处理血量和显示血量的问题
function WorldBossCardServer:UpdateHp(hp)
    -- FightCard.Init(self,team, id, teamID, uid, data, typ)
end

function WorldBossCardServer:AddHp(num, killer, bNotDeathEvent, bNotDealShield)
    return FightCardServer.AddHp(self, num, killer, bNotDeathEvent, bNotDealShield)
end

function WorldBossCardServer:AddHpNoShield(num, killer, bNotDeathEvent, isFromAddHp)
    if not isFromAddHp and num < 0 then
        -- 传给统计接口
        local mgr = self.team.fightMgr
        num = math.floor(num * mgr.nTPCastRate)
        mgr:DamageStat(killer, -num)

        LogDebugEx("GetBossHP", mgr:GetBossHP())
    end
    local tisdeath, shield2, num, abnormalities = FightCardServer.AddHpNoShield(self, num, killer, bNotDeathEvent, isFromAddHp)


    -- 本地虽然血量大于0 但是可能被其他人击杀, 故此处需要去查询是当前boss血量
    -- if self.hp > 0 and mgr:GetBossHP() < 0 then
    -- 	self.isLive = false
    -- 	if not bNotDeathEvent then
    -- 		self:OnDeath(killer)
    -- 	end
    -- 	--LogTrace()
    -- 	return true, shield, num
    -- end

    return tisdeath, shield2, num, abnormalities
end

-----------------------------------------------------------
-- 公共boss卡牌(服务端)
WorldBossCardClient = oo.class(FightCardServer)
function WorldBossCardClient:Init(team, id, teamID, uid, data, typ)
    FightCardServer.Init(self, team, id, teamID, uid, data, typ)
    self.showhp = 100000000000000
end

--主要是处理血量和显示血量的问题
function WorldBossCardClient:UpdateHp(hp)
    -- FightCard.Init(self,team, id, teamID, uid, data, typ)
    LogDebugEx("WorldBossCardClient:UpdateHp", self.hp, self.showhp, hp)
    if self.showhp < hp then
        return
    end -- 有可能前后打出伤害后收到之前的血量

    self.showhp = hp

    -- if self.maxhp <= self.showhp then
    -- 	self.maxhp = self.showhp
    -- end
end

function WorldBossCardClient:Get(key)
    if key == "hp" then
        return self.showhp
    end -- 返回
    return FightCardServer.Get(self, key)
end

function WorldBossCardClient:AddHp(num, killer, bNotDeathEvent, bNotDealShield)
    LogDebugEx("WorldBossCardClient:AddHp --", self.showhp, self.hp, num)
    if num < 0 then
        local mgr = self.team.fightMgr
        num = math.floor(num * mgr.nTPCastRate)

        if mgr.isServerMgr then
            -- LogDebugEx("----------isServerMgr------------")
        elseif mgr.DamageStat then
            mgr:DamageStat(killer, -num)
            -- LogDebugEx("----------isClientMgr------------")
        end

    end

    local oldhp = self.hp
    local tisdeath, shield2, num, abnormalities = FightCardServer.AddHp(self, num, killer, bNotDeathEvent, bNotDealShield)
    self.showhp = self.showhp + (self.hp - oldhp)
    LogDebugEx("WorldBossCardClient:AddHp after--", self.showhp, self.hp, num)
    return tisdeath, shield2, num, abnormalities
end

function WorldBossCardClient:AddHpNoShield(num, killer, bNotDeathEvent, isFromAddHp)

    LogDebugEx("WorldBossCardClient:AddHpNoShield --", self.showhp, self.hp, num, isFromAddHp)
    local isDamage = false

    if not isFromAddHp and num < 0 then
        isDamage = true
    end

    if isDamage then
        local mgr = self.team.fightMgr
        num = math.floor(num * mgr.nTPCastRate)
        if mgr.isServerMgr then
            -- LogDebugEx("----------isServerMgr------------")
        elseif mgr.DamageStat then
            mgr:DamageStat(killer, -num)
            -- LogDebugEx("----------isClientMgr------------")
        end
    end

    local oldhp = self.hp
    local tisdeath, shield2, num, abnormalities = FightCardServer.AddHpNoShield(self, num, killer, bNotDeathEvent, isFromAddHp)
    if isDamage then
        self.showhp = self.showhp + (self.hp - oldhp)
    end
    LogDebugEx("WorldBossCardClient:AddHpNoShield after--", self.showhp, self.hp, num)
    return tisdeath, shield2, num, abnormalities
end
-------------------------------------------------------------------------
if IS_CLIENT then
    WorldBossCard = WorldBossCardClient
elseif IS_SERVER then
    WorldBossCard = WorldBossCardServer
end

----------------------------------------------
-- 战斗数据恢复fightcard
FightCardTest= oo.class(FightCardServer)
-- 执行AI
function FightCardTest:DoAI(isAutoFight)
    LogTrace()
    local ty = self:GetType()
    -- if ty ~= CardType.Monster and ty ~= CardType.Boss and ty ~= CardType.Summon then return end

    -- 触发AI
    local mgr = self.team.fightMgr
    local skillMgr = self.skillMgr
    local currskill = skillMgr:GetNext()
    if not currskill then
        LogDebug("FightCardServer:DoAI ==> not skill can be use")
        -- local args = GCTipTool:OneCardArg(self.cid)
        self:SendError("sNotSkillCanBeUsed", args)
        ASSERT(nil, "没有可用的技能" .. self.name)
        -- mgr:Wait(3)
        return
    end
    LogDebugEx("FightCardServer", currskill.id, type(currskill.id))
    local skillID = currskill.id

    local team, target, targetIDs, targetdata, pos
    if currskill.target_camp == 0 then
        -- 敌方
        team = mgr:GetEnemyTeam(self)
    elseif currskill.target_camp == 1 then
        -- 我方
        team = self.team
    else
        -- 自己
        targetIDs = { self.oid }
        pos = self:GetPos()
        targetdata = {
            teamID = self:GetTeamID(),
            pos = pos,
        }
    end

    if team then
        mgr:AISetFocusFire(self.team) -- AI设置集火
        local oFocusFire = self.team.oFocusFire
        if currskill.target_camp == 0 and oFocusFire and oFocusFire:IsLive() then
            -- 集火
            target = { self.team.oFocusFire }
        else
            target = self:AISelectTarget(team, currskill)
        end
        --LogTable(target, "target")
        if target[1] then
            LogDebugEx("目标是", target[1].name)

            targetdata = self:AIGetTargetPos(skillID, target[1], target)
            pos = targetdata.pos
            targetIDs = self:GetSkillRange(skillID, targetdata)

            if currskill.type == SkillType.Revive then
                targetdata.reliveID = target[1].oid
            end
        else
            -- targetIDs = team.filter:GetIDList(target)
            -- ASSERT()
            LogError("没有攻击对象")
            return
        end
    end

    -- if isAutoFight then return end

    local data = {}
    data.target = targetdata
    data.casterID = self.oid
    data.targetIDs = targetIDs
    data.pos = pos
    data.skillID = skillID
    ---------------------------------战斗数据恢复----------------------------------------------------------
    local index = #mgr.cmds
    local skillCmdData = mgr.skillCmdData and mgr.skillCmdData[index + 1]
    if skillCmdData and skillCmdData.casterID == self.oid and skillCmdData.skillID == data.skillID then
        data = skillCmdData
        targetIDs = skillCmdData.targetIDs
        pos = skillCmdData.pos
    end
    -------------------------------------------------------------------------------------------
    LogTable(data, "AI Attack data= ")
    mgr:Attack(self, targetIDs, data, pos)
    mgr:AddCmd(CMD_TYPE.Skill, data)

    local action_time = (currskill.action_time / 1000)
    mgr:Wait(action_time)
end
