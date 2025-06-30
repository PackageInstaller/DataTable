---
--- 魔蛛女皇
--- 攻击带有【中毒】的目标时，最终伤害提高${Params[1]}%，造成伤害后${Params[2]}%的概率为目标添加${Params[3]}个${Params[4]}回合随机异常状态。
--- 受到来自【中毒】单位的最终伤害-${Params[5]}%。
--- 敌方单位身上每持有1个【中毒】，其攻击力，物防，术防，速度下降${Params[6]}%。
--- 免疫【沉默】，【遗忘】，【嘲讽】，【中毒】。
--- 处于【晕眩】，【睡眠】，【冻结】，【石化】，【麻痹】状态时，速度降低${Params[7]}%，不会无法行动。
--- *随机异常范围：攻击降低，物防降低，术防降低，速度降低，精准降低，耐性降低，命中降低，回复禁止，强化禁止，拘束，麻痹，标靶，中毒。

local Skill_114216 = BaseClass("Skill_114216", Skill)
local base = Skill

Skill_114216.LightenBuffList = 
{
    BattleBuffType.Stunning,
    BattleBuffType.Sleeping,
    BattleBuffType.Freeze,
    BattleBuffType.Petrification,
    BattleBuffType.Paralysis,
}

Skill_114216.RandomDebufList = 
{
    { BuffId = BattleBuffType.AtkDecrease },
    { BuffId = BattleBuffType.DefDecrease },
    { BuffId = BattleBuffType.MagicDefDecrease },
    { BuffId = BattleBuffType.SpeedDecrease },
    { BuffId = BattleBuffType.EAccDecrease },
    { BuffId = BattleBuffType.EResistDecrease },
    { BuffId = BattleBuffType.HitDecrease },
    { BuffId = BattleBuffType.HealDisable },
    { BuffId = BattleBuffType.BuffDisable },
    { BuffId = BattleBuffType.PassiveDisable },
    { BuffId = BattleBuffType.Poison },
    { BuffId = BattleBuffType.Vulnerable },
    { BuffId = BattleBuffType.Paralysis },
    { BuffId = BattleBuffType.Restraint },
}


local function __init(self)
    self.Data.reduceSpeed = 0
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult, targetUnit)

    if targetUnit:GetComponent("BuffComponent"):HasBuffId(BattleBuffType.Poison) then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Params[1]
    end

    if BattleUtil.IsPctProbHit(self.Params[2]) then
        local randomBuffs = table.randtake(Skill_114216.RandomDebufList, self.Params[3])
        for _, randomBuff in pairs(randomBuffs) do
            table.insert(activeSkillResult.Buffs, ActiveSkillBuff.New(randomBuff.BuffId, self.Params[4]))
        end
    end
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    if self.__sbc:BuffIdCount(BattleBuffType.Poison) > 0 then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct - self.Params[5]
    end
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:IncImmuneDeBuff(BattleBuffType.PassiveDisable)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Poison)

    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        local poisonCount = enemy:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Poison)
        local snc = enemy:GetComponent("NumericComponent")
        snc:Dec(NumericType.AtkPct, self.Params[6] * poisonCount)
        snc:Dec(NumericType.DefPct, self.Params[6] * poisonCount)
        snc:Dec(NumericType.MagicDefPct, self.Params[6] * poisonCount)
        snc:Dec(NumericType.SpeedPct, self.Params[6] * poisonCount)
    end
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:DecImmuneDeBuff(BattleBuffType.PassiveDisable)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Poison)

    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        local poisonCount = enemy:GetComponent("BuffComponent"):BuffIdCount(BattleBuffType.Poison)
        local snc = enemy:GetComponent("NumericComponent")
        snc:Inc(NumericType.AtkPct, self.Params[6] * poisonCount)
        snc:Inc(NumericType.DefPct, self.Params[6] * poisonCount)
        snc:Inc(NumericType.MagicDefPct, self.Params[6] * poisonCount)
        snc:Inc(NumericType.SpeedPct, self.Params[6] * poisonCount)
    end
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if table.any(Skill_114216.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed + 1
        self.__scc.UnableAct = self.__scc.UnableAct - 1
    end

    if self.Data.reduceSpeed == 1 then
        self.__snc:Dec(NumericType.SpeedPct, self.Params[7])
    end
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if table.any(Skill_114216.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed - 1
        self.__scc.UnableAct = self.__scc.UnableAct + 1
    end

    if self.Data.reduceSpeed == 0 then
        self.__snc:Inc(NumericType.SpeedPct, self.Params[7])
    end
end

local function OnBuffAddEvent(self, buff)
    base.OnBuffAddEvent(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.BuffId ~= BattleBuffType.Poison then
        return
    end

    if BattleUtil.IsFriend(buff.TargetUnit, self.SrcUnit) then
        return
    end

    local snc = buff.TargetUnit:GetComponent("NumericComponent")
    snc:Dec(NumericType.AtkPct, self.Params[6])
    snc:Dec(NumericType.DefPct, self.Params[6])
    snc:Dec(NumericType.MagicDefPct, self.Params[6])
    snc:Dec(NumericType.SpeedPct, self.Params[6])
end

local function OnBuffRemoveEvent(self, buff)
    base.OnBuffRemoveEvent(self, buff)

    if self.IsDisabled then
        return
    end
    
    if buff.BuffId ~= BattleBuffType.Poison then
        return
    end

    if BattleUtil.IsFriend(buff.TargetUnit, self.SrcUnit) then
        return
    end

    local snc = buff.TargetUnit:GetComponent("NumericComponent")
    snc:Inc(NumericType.AtkPct, self.Params[6])
    snc:Inc(NumericType.DefPct, self.Params[6])
    snc:Inc(NumericType.MagicDefPct, self.Params[6])
    snc:Inc(NumericType.SpeedPct, self.Params[6])
end

Skill_114216.__init = __init
Skill_114216.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_114216.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_114216.OnBattleStart = OnBattleStart
Skill_114216.BeforeHit = BeforeHit
Skill_114216.BeforeBeHit = BeforeBeHit
Skill_114216.OnBuffAdd = OnBuffAdd
Skill_114216.OnBuffRemove = OnBuffRemove
Skill_114216.OnBuffAddEvent = OnBuffAddEvent
Skill_114216.OnBuffRemoveEvent = OnBuffRemoveEvent

return Skill_114216