---
--- 虔诚
--  效果抗性${Params[1]}%。攻击处于强化状态的敌人时攻击力${Params[2]}%。

local Skill_112404 = BaseClass("Skill_112404", Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.ERistAdd, self.Params[1])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.ERistAdd, self.Params[1])
end


local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function BeforeSkillEffect(self, targetUnit)
    if self.IsDisabled then
        return
    end

    self.__subc:IncTempNumeric(NumericType.AtkFinalAdd, self.Params[2])
end


Skill_112404.__init = __init
Skill_112404.OnBattleStart = OnBattleStart
Skill_112404.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_112404.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_112404.BeforeSkillEffect = BeforeSkillEffect

return Skill_112404