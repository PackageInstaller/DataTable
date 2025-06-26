---
--- 攻击后排敌方目标时,最终伤害提升${Params[1]}%。
---

local Equip_26031008 = BaseClass("Equip_26031008", Skill)
local base = Skill

local function __init(self)
    self.Data.DamageAdd = self.Params[1]
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult)

    if not (targetUnit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Back) then
        return
    end

    activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct + self.Data.DamageAdd
end

Equip_26031008.__init = __init
Equip_26031008.BeforeHit = BeforeHit

return Equip_26031008