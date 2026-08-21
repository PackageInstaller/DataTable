---
--- 刑天袭
--- 对生命值最多的单名敌人造成${Params[1]}%物理伤害。如果造成击杀，对生命值最多的单名敌人追加使用技能${Params[2]}
---

local Skill_114003 = BaseClass("Skill_114003", Skill)
local base = Skill

local function __init(self)
    self.Data.thisTurnBeHurt = false
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * damageScale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }

    return result
end

local function OnKillEnemy(self, deadUnit)
    base.OnKillEnemy(self, deadUnit)

    local enemies = self:__get_enemy_all()
    local targetUnit = BattleUtil.GetExtremeAttrTarget(enemies, NumericType.Hp, true)
    if targetUnit then
        self.__subc.ExtraSkill = self.SrcUnit:GetComponent("SkillComponent").ActiveSkills[self.Params[1]]
        self.__subc.ExtraSkillTarget = targetUnit
    end
end



Skill_114003.__init = __init
Skill_114003.OnUseActiveSkill = OnUseActiveSkill
Skill_114003.OnKillEnemy = OnKillEnemy

return Skill_114003