---
--- 龙之禁军
--- 战斗开始时，获得${Params[1]}回合的【免疫】。当自身处于强化状态时，受到的最终伤害减少${Params[2]}%。

local Skill_112104 = BaseClass("Skill_112104", Skill)
local base = Skill

local function __init(self)

end


local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.FinalHurtAdd,self.Params[2])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.FinalHurtAdd,self.Params[2])
end


local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()

    self.__sbc:CreateBuff(BattleBuffType.ImmuneDeBuff, self.SkillId, self.SrcUnit, self.SrcUnit, self.Params[1], false)
end

Skill_112104.__init = __init
Skill_112104.OnBattleStart = OnBattleStart
Skill_112104.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_112104.OnPassiveSkillDisabled = OnPassiveSkillDisabled

return Skill_112104