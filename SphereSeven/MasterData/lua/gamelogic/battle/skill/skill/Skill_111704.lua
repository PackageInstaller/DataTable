---
--- 飞龙鳞
--- 效果抗性${Params[1]}%

local Skill_111704 = BaseClass("Skill_111704", Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)

    self.__snc:Inc(NumericType.ERistAdd,self.Params[1])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)

    self.__snc:Dec(NumericType.ERistAdd,self.Params[1])

end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_111704.__init = __init
Skill_111704.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_111704.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_111704.OnBattleStart = OnBattleStart

return Skill_111704