---
--- 對方使用非攻擊型的技能時，解除自身${Params[1]}個異常狀態並提高自身${Params[2]}%的行動值；每回合能觸發${Params[1]}次
---

local Skill_10434 = BaseClass("Skill_10434",Skill)
local base = Skill

local function __init(self)
    self.Data.DebuffRemoveCount = self.Params[1]
    self.Data.ActValueAdd = self.Params[2]
    self.Data.TriggerTimesPerTurn = self.Params[3]

    self.Data.TriggerTimes = 0
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    self.Data.TriggerTimes = 0
end

local function OnAtkEndEvent(self, atkUnit)
    base.OnAtkEndEvent(self, atkUnit)

    if self.IsDisabled then
        return
    end

    if self.Data.TriggerTimes > self.Data.TriggerTimesPerTurn then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end
    
    if self.__bc.CurActSkill.ZSkill.SkillType == BattleSkillType.Damage then
        return
    end

    local buffs = self.__sbc:RandomGetBuff(true, self.Data.DebuffRemoveCount)
    for _, buff in pairs(buffs) do
        self.__sbc:RemoveOneBuff(buff)
    end

    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Data.ActValueAdd)
    self.Data.TriggerTimes = self.Data.TriggerTimes + 1
end

Skill_10434.__init = __init
Skill_10434.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_10434.OnAtkEndEvent = OnAtkEndEvent

return Skill_10434