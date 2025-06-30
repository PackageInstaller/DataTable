---
--- 单体攻击后，对目标造成自身物防或者魔防中较高值${Params[1]}%的额外伤害（无视双防与技能伤害无效）
---
local Equip_11020204 = BaseClass("Equip_11020204", Skill)
local base = Skill

local function __init(self)
end

local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    local zSkill = self.__bc.CurActSkill.ZSkill
    if zSkill == nil or zSkill.EnemyRange ~= EnemyRange.Single then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    local attr = math.max(self.__snc:Get(NumericType.Def), self.__snc:Get(NumericType.MagicDef))
    local damageData = DamageData.New(attr * self.Params[1] / 100, BattleDamageType.Universal)
    targetUnit:GetComponent("SsUnitBattleComponent"):DealDamage(self.SrcUnit, damageData)
end

Equip_11020204.__init = __init
Equip_11020204.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_11020204