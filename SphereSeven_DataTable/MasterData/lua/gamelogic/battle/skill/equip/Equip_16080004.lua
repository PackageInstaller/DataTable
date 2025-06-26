---
--- 暴击后，根据最终伤害的${Params[1]}%对目标造成额外伤害。
---

local Equip_16080004 = BaseClass("Equip_16080004", Skill)
local base = Skill

local function __init(self)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if activeSkillResult.IsCri then
        local damageData = DamageData.New(activeSkillResult.TotalDamage * self.Params[1] / 100, BattleDamageType.Universal)
        targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
    end
end


Equip_16080004.__init = __init
Equip_16080004.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_16080004