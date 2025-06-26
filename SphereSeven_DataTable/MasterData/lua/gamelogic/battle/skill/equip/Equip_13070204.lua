---
--- 受到攻击后，对目标造成自身物防或者魔防中较高值${Params[1]}%的额外伤害（无视双防与技能伤害无效）
---

local Equip_13070204 = BaseClass("Equip_13070204", Skill)
local base = Skill

local function __init(self)
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    local attr = math.max(self.__snc:Get(NumericType.Def), self.__snc:Get(NumericType.MagicDef))
    local damageData = DamageData.New(attr * self.Params[1] / 100, BattleDamageType.Universal)
    atkUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
end

Equip_13070204.__init = __init
Equip_13070204.AfterBeHitAll = AfterBeHitAll

return Equip_13070204