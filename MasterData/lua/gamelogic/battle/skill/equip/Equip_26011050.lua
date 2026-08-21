---
--- 攻击攻击力低于自身的目标时,最终伤害提高${Params[1]}%
---

local Equip_26011050 = BaseClass("Equip_26011050", Skill)
local base = Skill

local function __init(self)
    self.Data.FinalDamageAddPct = self.Params[1]
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    local targetAtk = targetUnit:GetComponent("NumericComponent"):Get(NumericType.Atk)
    local selfAtk = self.__snc:Get(NumericType.Atk)

    if selfAtk > targetAtk then
        activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Data.FinalDamageAddPct
    end
end

Equip_26011050.__init = __init
Equip_26011050.BeforeHit = BeforeHit

return Equip_26011050