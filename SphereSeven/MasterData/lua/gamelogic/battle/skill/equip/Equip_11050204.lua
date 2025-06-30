---
--- 暴击率提升${Params[1]}%，攻击造成击杀时，随机减少自身${Params[2]}个技能的冷却时间${Params[3]}回合（每${Params[4]}自身回合只能触发1次）
---
local Equip_11050204 = BaseClass("Equip_11050204", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriAdd, self.Params[1])
end

local function OnKillEnemy(self, deadUnits) --杀死敌人时
    base.OnKillEnemy(self, deadUnits)

    if self.LeftCooldownTurn > 0 then
        return
    end

    local reduceCoolDown = math.modf(self.Params[3])
    local skills = self.SrcUnit:GetComponent("SkillComponent"):RandomActiveSkills(self.Params[2])
    for _, skill in pairs(skills) do
        skill:ReduceCoolDownTurn(reduceCoolDown)
    end

    local coolDown = math.modf(self.Params[4])
    self:SetCooldownTurn(coolDown)
end

Equip_11050204.__init = __init
Equip_11050204.OnBattleStart = OnBattleStart
Equip_11050204.OnKillEnemy = OnKillEnemy

return Equip_11050204