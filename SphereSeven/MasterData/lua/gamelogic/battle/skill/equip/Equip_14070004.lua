---
--- 受击后，根据最终伤害量的${Params[1]}%恢复生命值
---

local Equip_14070004 = BaseClass("Equip_14070004", Skill)
local base = Skill

local function __init(self)
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if activeSkillResult.FeixiaoDamage == nil then
        return
    end
    self.SrcUnit:GetComponent("SsUnitBattleComponent"):Heal(activeSkillResult.TotalRealHpDamage * self.Params[1] / 100, self.SrcUnit)
end


Equip_14070004.__init = __init
Equip_14070004.AfterBeHitAll = AfterBeHitAll

return Equip_14070004