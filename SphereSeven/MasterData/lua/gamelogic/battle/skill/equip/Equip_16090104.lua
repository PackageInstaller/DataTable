---
--- 攻击后，如果目标处于异常状态，则对全体敌人造成自身${Params[1]}%攻击力的额外伤害
---

local Equip_16090104 = BaseClass("Equip_16090104", Skill)
local base = Skill

local function __init(self)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    if not targetUnit:GetComponent("BuffComponent"):HasDeBuff() then
        return
    end

    local value = self.__snc:Get(NumericType.Atk) * self.Params[1] / 100
    local enemies = self:__get_enemy_all()
    for _, enemy in pairs(enemies) do
        local damageData = DamageData.New(value, BattleDamageType.Universal)
        enemy:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
    end
end

Equip_16090104.__init = __init
Equip_16090104.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_16090104