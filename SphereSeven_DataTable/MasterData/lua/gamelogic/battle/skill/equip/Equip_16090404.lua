---
--- 攻击后，对目标追加造成自身${Params[1]}%攻击力的额外伤害
---

local Equip_16090404 = BaseClass("Equip_16090404", Skill)
local base = Skill

local function __init(self)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    local damage = self.__snc:Get(NumericType.Atk) * self.Params[1] / 100
    local damageData = DamageData.New(damage, BattleDamageType.Universal)
    targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
end

Equip_16090404.__init = __init
Equip_16090404.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_16090404