---
--- 攻击+${Params[1]}%。击杀敌人时，减少自身所有主动技能冷却${Params[2]}回合。（每${Params[3]}自身回合只能触发1次）
---

local Equip_23051028 = BaseClass("Equip_23051028", Skill)
local base = Skill

local function __init(self)
    self.Data.AktAddPct = self.Params[1]
    self.Data.SkillReduceCoolDown = math.modf(self.Params[2])
    self.Data.SelfCoolDown = math.modf(self.Params[3])
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.__snc:Inc(NumericType.AtkPct, self.Data.AktAddPct)
end

local function OnKillEnemy(self, deadUnits) --杀死敌人时
    base.OnKillEnemy(self, deadUnits)

    if self.LeftCooldownTurn > 0 then
        return
    end

    for _, skill in pairs(self.SrcUnit:GetComponent("SkillComponent").ActiveSkills) do
        skill:ReduceCoolDownTurn(self.Data.SkillReduceCoolDown)
    end

    self:SetCooldownTurn(self.Data.SelfCoolDown)
end

Equip_23051028.__init = __init
Equip_23051028.OnBattleStart = OnBattleStart
Equip_23051028.OnKillEnemy = OnKillEnemy

return Equip_23051028