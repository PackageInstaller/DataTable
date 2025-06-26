---
--- 攻击力提升${Params[1]}%, 攻击前排目标时, 无视目标${Params[2]}%的物防。
---

local Equip_21041043 = BaseClass("Equip_21041043", Skill)
local base = Skill

local function __init(self)
    self.Data.AktAddPct = self.Params[1]
    self.Data.IgnoreDef = self.Params[2]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.__snc:Inc(NumericType.AtkPct, self.Data.AktAddPct)
end

local function BeforeHit(self, activeSkillResult, targetUnit)
    base.BeforeHit(self, activeSkillResult)

    if not (targetUnit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Front) then
        return
    end

    activeSkillResult.ExtraIgnoreDef = activeSkillResult.ExtraIgnoreDef + self.Data.IgnoreDef
end

Equip_21041043.__init = __init
Equip_21041043.OnBattleStart = OnBattleStart
Equip_21041043.BeforeHit = BeforeHit

return Equip_21041043