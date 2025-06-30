---
--- 刑天袭
--- 对生命值最多的单名敌人造成${Params[1]}%物理伤害，并对全体敌人造成${Params[2]}%物理伤害。如果造成击杀，获得{Params[3]}回合的【攻击力提升】,并对生命值最多的单名敌人追加使用技能${Params[4]}，直到没有造成击杀为止。
---

local Skill_114015 = BaseClass("Skill_114015", Skill)
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

    self.__sbc:CreateBuff(BattleBuffType.AtkIncrease, nil, self.SrcUnit, self.SrcUnit, self.Params[3])

    local enemies = self:__get_enemy_all()
    local targetUnit = BattleUtil.GetExtremeAttrTarget(enemies, NumericType.Hp, false)
    if targetUnit then
        self.__subc.ExtraSkill = self.SrcUnit:GetComponent("SkillComponent").ActiveSkills[self.Params[4]]
        self.__subc.ExtraSkillTarget = targetUnit
        self.__subc.IgnoreExtraSkillActTypeLimit = true
    end
end

Skill_114015.__init = __init
Skill_114015.OnUseActiveSkill = OnUseActiveSkill
Skill_114015.OnAtkEnd = OnAtkEnd
Skill_114015.OnKillEnemy = OnKillEnemy

return Skill_114015