---
--- 攻击后,目标处于【麻痹】状态时,对所有敌方单位造成最终伤害${Params[1]}%的额外伤害。
---

local Equip_21011046 = BaseClass("Equip_21011046", Skill)
local base = Skill

local function __init(self)
    self.Data.DamageScale = self.Params[1] / 100
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if not targetUnit:GetComponent("BuffComponent"):HasBuffId(BattleBuffType.Paralysis) then
        return
    end

    local value = activeSkillResult.TotalDamage * self.Data.DamageScale
    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        if not enemy:GetComponent("CharacterComponent").IsDead then
            local damageData = DamageData.New(value, BattleDamageType.Universal)
            enemy:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
        end
    end
end

Equip_21011046.__init = __init
Equip_21011046.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_21011046