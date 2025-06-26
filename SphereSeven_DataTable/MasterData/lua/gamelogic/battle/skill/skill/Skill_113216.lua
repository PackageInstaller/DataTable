---
--- 腐尸堆叠
--- 每个自身回合结束时,提升自身攻击力,物防,魔防${Params[1]}%,上不封顶。
--- 场上每有一个友军单位,受到的最终伤害-${Params[2]}%。没有友军单位时,受到的最终伤害+${Params[3]}%。
--- 免疫【沉默】,【遗忘】,【嘲讽】。
--- 处于【晕眩】,【睡眠】,【冻结】,【石化】,【麻痹】状态时,速度降低${Params[4]}%,不会无法行动。
---

local Skill_113216 = BaseClass("Skill_113216", Skill)
local base = Skill

Skill_113216.LightenBuffList = 
{
    BattleBuffType.Stunning,
    BattleBuffType.Sleeping,
    BattleBuffType.Freeze,
    BattleBuffType.Petrification,
    BattleBuffType.Paralysis,
}

local function __init(self)
    self.Data.AtkAddPct = self.Params[1]
    self.Data.DefAddPct = self.Params[1]
    self.Data.MdefAddPct = self.Params[1]
    self.Data.HurtReducePct = self.Params[2]
    self.Data.HurtAddPct = self.Params[3]
    self.Data.SpeedReducePct = self.Params[4]

    self.Data.reduceSpeed = 0
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)

    self.__scc:IncImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:IncImmuneDeBuff(BattleBuffType.PassiveDisable)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)

    self.__scc:DecImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:DecImmuneDeBuff(BattleBuffType.PassiveDisable)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    if self.IsDisabled then
        return
    end    

    self.__snc:Inc(NumericType.AtkPct, self.Data.AtkAddPct)
    self.__snc:Inc(NumericType.DefPct, self.Data.DefAddPct)
    self.__snc:Inc(NumericType.MagicDefPct, self.Data.MdefAddPct)
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    local friends = table.choose(self.__bc.IdUnits,function (_,v) return
        (v:GetComponent("SsUnitMatrixComponent").Group == self.__smc.Group) 
        and (v ~= self.SrcUnit) 
        and (not v:GetComponent("CharacterComponent").IsDead)
    end)

    local friendCount = table.count(friends);

    if friendCount > 0 then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct - self.Data.HurtReducePct * friendCount
    else
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Data.HurtAddPct
    end
end

local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if table.any(Skill_113216.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed + 1
        self.__scc.UnableAct = self.__scc.UnableAct - 1
    end

    if self.Data.reduceSpeed == 1 then
        self.__snc:Dec(NumericType.SpeedPct, self.Data.SpeedReducePct)
    end
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if table.any(Skill_113216.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed - 1
        self.__scc.UnableAct = self.__scc.UnableAct + 1
    end

    if self.Data.reduceSpeed == 0 then
        self.__snc:Inc(NumericType.SpeedPct, self.Data.SpeedReducePct)
    end
end

Skill_113216.__init = __init
Skill_113216.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_113216.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_113216.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_113216.OnBattleStart = OnBattleStart
Skill_113216.BeforeBeHit = BeforeBeHit
Skill_113216.OnBuffAdd = OnBuffAdd
Skill_113216.OnBuffRemove = OnBuffRemove

return Skill_113216