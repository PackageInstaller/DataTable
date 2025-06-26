---
--- 刑天袭
--- 对生命值最多的单名敌人造成${Params[1]}%物理伤害，并对全体敌人造成${Params[2]}%物理伤害。如果造成击杀，追加使用${Params[3]}。
---

local Skill_114007 = BaseClass("Skill_114007", Skill)
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

local function OnAtkEnd(self)
    base.OnAtkEnd(self)

    if self.__bc.CurActSkill ~= self then
        return
    end

    local damage = self.__snc:Get(NumericType.Atk) * self.Params[2] / 100

    local enemies = self:__get_enemy_all()
    table.walk(enemies, 
        function(key, unit)
            if not unit:GetComponent("CharacterComponent").IsDead then
                unit:GetComponent("SsUnitBattleComponent"):Hurt(self.SrcUnit, BattleDamageType.Physical, damage)
            end
        end)
end

local function OnKillEnemy(self, deadUnit)
    base.OnKillEnemy(self, deadUnit)

    local enemies = self:__get_enemy_all()
    local targetUnit = BattleUtil.GetExtremeAttrTarget(enemies, NumericType.Hp, true)
    if targetUnit then
        self.__subc.ExtraSkill = self.SrcUnit:GetComponent("SkillComponent").ActiveSkills[self.Params[3]]
        self.__subc.ExtraSkillTarget = targetUnit
    end
end

Skill_114007.__init = __init
Skill_114007.OnUseActiveSkill = OnUseActiveSkill
Skill_114007.OnAtkEnd = OnAtkEnd
Skill_114007.OnKillEnemy = OnKillEnemy

return Skill_114007