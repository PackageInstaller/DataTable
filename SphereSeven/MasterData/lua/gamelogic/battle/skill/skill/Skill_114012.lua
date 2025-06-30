---
--- 永不停歇
--- "每次受到攻击伤害时，获得${Params[1]}层【怒火】。当【怒火】达到${Params[2]}层时，立即进行一次反击并清除所有怒火。当自己在任意回合中没有受到伤害时，在该回合结束时减少${Params[3]}层【怒火】。
--- 每有一层怒火，攻击力+${Params[4]}%。
---  *怒火：计数用特殊状态。
---  免疫【沉默】，【遗忘】，【嘲讽】。
---  处于【晕眩】，【睡眠】，【冻结】，【石化】，【麻痹】状态时，速度降低${Params[5]}%，不会无法行动。"

local Skill_114012 = BaseClass("Skill_114012", Skill)
local base = Skill

local function __init(self)
    self.Data.thisTurnBeHurt = false
    self.Data.reduceSpeed = 0
    self.Data.BuffList = 
    {
        BattleBuffType.Stunning,
        BattleBuffType.Sleeping,
        BattleBuffType.Freeze,
        BattleBuffType.Petrification,
        BattleBuffType.Paralysis,
    }
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


local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    if self.IsDisabled then
        return
    end

    local buff = self.__sbc:CreateBuff(BattleBuffType.Anger, self.SkillId, self.SrcUnit, self.SrcUnit, 0, true, nil, self.Params[1], false)
    if buff and buff.NumericVal >= self.Params[2] then
        self.__sbc:RemoveBuff(BattleBuffType.Anger, self.SkillId, buff.NumericVal)
        self.__subc.CacUnit = atkUnit
    end

    self.Data.thisTurnBeHurt = true
end

---当回合开始时
local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    self.Data.thisTurnBeHurt = false
end

---当回合结束时
local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    if not self.Data.thisTurnBeHurt then
        local buff = self.__sbc:GetBuff(BattleBuffType.Anger)
        if buff ~= nil then
            self.__sbc:RemoveBuff(BattleBuffType.Anger, self.SkillId, self.Params[3])
        end
    end
end

local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if buff.BuffId == BattleBuffType.Anger then
        self.__snc:Inc(NumericType.AtkPct, self.Params[4] * buff.NumericVal)
        return
    end

    if table.any(self.Data.BuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed + 1
        self.__scc.UnableAct = self.__scc.UnableAct - 1
    end

    if self.Data.reduceSpeed == 1 then
        self.__snc:Dec(NumericType.SpeedPct, self.Params[5])
    end
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if buff.BuffId == BattleBuffType.Anger then
        self.__snc:Dec(NumericType.AtkPct, self.Params[4] * buff.NumericVal)
        return
    end

    if table.any(self.Data.BuffList, function(buffId) return buffId == buff.BuffId end) then
        self.Data.reduceSpeed = self.Data.reduceSpeed - 1
        self.__scc.UnableAct = self.__scc.UnableAct + 1
    end

    if self.Data.reduceSpeed == 0 then
        self.__snc:Inc(NumericType.SpeedPct, self.Params[5])
    end
end

local function OnBuffMultiply(self, buff, val, data)
    if buff.BuffId ~= BattleBuffType.Anger then
        return
    end

    if val > 0 then
        self.__snc:Inc(NumericType.AtkPct, self.Params[4] * val)
    else
        self.__snc:Dec(NumericType.AtkPct, self.Params[4] * val)
    end
end

Skill_114012.__init = __init
Skill_114012.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_114012.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_114012.OnBattleStart = OnBattleStart
Skill_114012.AfterHurt = AfterHurt
Skill_114012.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_114012.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd
Skill_114012.OnBuffAdd = OnBuffAdd
Skill_114012.OnBuffRemove = OnBuffRemove
Skill_114012.OnBuffMultiply = OnBuffMultiply

return Skill_114012