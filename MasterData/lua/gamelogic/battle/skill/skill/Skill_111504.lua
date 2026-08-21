---
--- 冲锋
--- 战斗开始的第一个回合，获得${Params[1]}回合的【速度提升】

local Skill_111504 = BaseClass("Skill_111504", Skill)
local base = Skill

local function __init(self)

end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.__sbc:CreateBuff(BattleBuffType.SpeedIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, self.Params[1], false)
end

Skill_111504.__init = __init
Skill_111504.OnBattleStart = OnBattleStart

return Skill_111504