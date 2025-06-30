---
--- 受击后，获得最终伤害量${Params[1]}%的全能护盾${Params[2]}回合。
---

local Equip_14070104 = BaseClass("Equip_14070104", Skill)
local base = Skill

local function __init(self)
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if activeSkillResult.FeixiaoDamage == nil then
        return
    end

    local turn = math.modf(self.Params[2])
    local value = activeSkillResult.TotalRealHpDamage * self.Params[1] / 100
    self.__sbc:CreateBuff(BattleBuffType.UniversalShield, nil, self.SrcUnit, self.SrcUnit, turn, nil, nil, nil, nil, { ShieldValue = value })
end


Equip_14070104.__init = __init
Equip_14070104.AfterBeHitAll = AfterBeHitAll

return Equip_14070104