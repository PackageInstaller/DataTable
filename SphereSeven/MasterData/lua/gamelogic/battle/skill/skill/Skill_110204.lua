---
--- 精准
--- 暴击率+10%(Params[1])

local Skill_110204 = BaseClass("Skill_110204",Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.CriAdd, self.Params[1])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.CriAdd, self.Params[1])
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_110204.__init = __init
Skill_110204.OnBattleStart = OnBattleStart
Skill_110204.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_110204.OnPassiveSkillDisabled = OnPassiveSkillDisabled

return Skill_110204