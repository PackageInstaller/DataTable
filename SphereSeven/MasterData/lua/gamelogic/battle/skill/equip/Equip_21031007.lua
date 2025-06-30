---
--- 暴击后，造成自身速度${Params[1]}%的固定伤害
---

local Equip_21031007 = BaseClass("Equip_21031007", Skill)
local base = Skill

local function __init(self)
    self.Triggered = false
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if activeSkillResult.IsCri then
        local damage = self.__snc:Get(NumericType.Speed ) * self.Params[1] / 100
        local damageData = DamageData.New(damage, BattleDamageType.Universal)
        targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
    end
end

Equip_21031007.__init = __init
Equip_21031007.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_21031007