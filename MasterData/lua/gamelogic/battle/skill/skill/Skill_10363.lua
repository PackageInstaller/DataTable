
local Skill_10363 = BaseClass("Skill_10363",Skill)
local base = Skill

local function __init(self)
    
end

local function OnUseActiveSkill(self, targetUnit)
    local result = ActiveSkillResult.New()
    local damageScale = self.Params[1] / 100
    local extraScale = (1 - BattleUtil.GetHpPct(self.SrcUnit)) * self.Params[2] / 100
    local scale = damageScale + extraScale

    local atk = self.__snc:Get(NumericType.Atk)
    local damageNum = atk * scale / self.MultistageNum
    result.FeixiaoDamage = {
        Type = BattleDamageType.Physical,
        Value = damageNum
    }
    return result
end

local function OnKillEnemy(self, deadUnit)
    if self.__bc.CurActSkill == self then
        local killCount = table.count(deadUnit)
        self.__sbc:IncAllBuffTurn(false, math.min(math.floor(killCount / self.Params[3]) * self.Params[4], self.Params[5]))
    end
end

Skill_10363.__init = __init
Skill_10363.OnUseActiveSkill = OnUseActiveSkill
Skill_10363.OnKillEnemy = OnKillEnemy

return Skill_10363