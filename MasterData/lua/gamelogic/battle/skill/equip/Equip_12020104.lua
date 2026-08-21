---
--- 受到暴击后，对伤害来源造成${Params[1]}%最终伤害的额外伤害。
---
local Equip_12020104 = BaseClass("Equip_12020104", Skill)
local base = Skill

local function __init(self)
    self.revangeUnit = nil
    self.revangeDamage = 0
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    if activeSkillResult.IsCri then
        self.revangeUnit = atkUnit
        self.revangeDamage = activeSkillResult.TotalDamage
    end
end

local function OnAtkEndEvent(self, atkUnit)
    base.OnAtkEndEvent(self, atkUnit)

    if self.revangeUnit == nil then
        return
    end

    local revangeUnit = self.revangeUnit
    local damageData = DamageData.New(self.revangeDamage * self.Params[1] / 100, BattleDamageType.Universal)

    self.revangeUnit = nil
    self.revangeDamage = 0

    revangeUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
end


Equip_12020104.__init = __init
Equip_12020104.AfterHurt = AfterHurt
Equip_12020104.OnAtkEndEvent = OnAtkEndEvent

return Equip_12020104