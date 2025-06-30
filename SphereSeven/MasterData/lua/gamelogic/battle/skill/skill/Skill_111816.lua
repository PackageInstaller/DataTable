---
--- 黑龙鳞
--- 效果抗性&{Params[1]}%。受到最终伤害-&{Params[2]}%。自身每有一个异常状态使受到的最终伤害提高&{Params[3]}%, 若受击时自身异常状态数量不多于&{Params[4]}个，受击后提升自身&{Params[5]}%的行动值。
--- 免疫【沉默】，【遗忘】，【嘲讽】。
--- 处于【晕眩】，【睡眠】，【冻结】，【石化】，【麻痹】状态时，速度降低&{Params[6]}%，不会无法行动。
---

local Skill_111816 = BaseClass("Skill_111816", Skill)
local base = Skill

Skill_111816.LightenBuffList = 
{
    BattleBuffType.Stunning,
    BattleBuffType.Sleeping,
    BattleBuffType.Freeze,
    BattleBuffType.Petrification,
    BattleBuffType.Paralysis,
}

local function __init(self)
    self.Data.reduceSpeed = 0
end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)

    self.__snc:Inc(NumericType.ERistAdd, self.Params[1])
    self.__snc:Inc(NumericType.FinalHurtAdd, self.Params[2])

    self.__scc:IncImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:IncImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:IncImmuneDeBuff(BattleBuffType.PassiveDisable)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)

    self.__snc:Dec(NumericType.ERistAdd, self.Params[1])
    self.__snc:Dec(NumericType.FinalHurtAdd, self.Params[2])

    self.__scc:DecImmuneDeBuff(BattleBuffType.Taunted)
    self.__scc:DecImmuneDeBuff(BattleBuffType.Silence)
    self.__scc:DecImmuneDeBuff(BattleBuffType.PassiveDisable)

end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    if self.__sbc:BuffTypeCount(true) <= self.Params[4] then
        activeSkillResult.ActChange = activeSkillResult.ActChange + self.Params[5]
    end
end


local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.IsDeBuff then
        self.__snc:Inc(NumericType.FinalDamageAddPct, self.Params[3])
    end

    if table.any(self.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed + 1
        self.__scc.UnableAct = self.__scc.UnableAct - 1
    end

    if self.Data.reduceSpeed == 1 then
        self.__snc:Dec(NumericType.SpeedPct, self.Params[6])
    end
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.IsDeBuff then
        self.__snc:Dec(NumericType.FinalDamageAddPct, self.Params[3])
    end

    if table.any(self.LightenBuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed - 1
        self.__scc.UnableAct = self.__scc.UnableAct + 1
    end

    if self.Data.reduceSpeed == 0 then
        self.__snc:Inc(NumericType.SpeedPct, self.Params[6])
    end
end

Skill_111816.__init = __init
Skill_111816.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_111816.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_111816.OnBattleStart = OnBattleStart
Skill_111816.BeforeBeHit = BeforeBeHit
Skill_111816.OnBuffAdd = OnBuffAdd
Skill_111816.OnBuffRemove = OnBuffRemove

return Skill_111816