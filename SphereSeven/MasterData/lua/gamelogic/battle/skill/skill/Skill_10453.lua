--- 对全体敌人造成${Params[1]}%的魔法伤害，敌人数量越少，伤害倍率越高，最高额外获得${Params[2]}%的伤害倍率。
---
local Skill_10453 = BaseClass("Skill_10453",Skill)
local base = Skill

local function __init(self)
    
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100

    local aliveEnemies = table.choose(self:__get_enemy_all(), function(k, unit) return not unit:GetComponent("CharacterComponent").IsDead end)
    local enemyCount = math.max(#aliveEnemies, 1)

    local extraScale = self.Params[2] / enemyCount / 100
    local scale = damageScale + extraScale
    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * scale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Magic,
        Value = damageNum
    }
    return result
end

Skill_10453.__init = __init
Skill_10453.OnUseActiveSkill = OnUseActiveSkill

return Skill_10453