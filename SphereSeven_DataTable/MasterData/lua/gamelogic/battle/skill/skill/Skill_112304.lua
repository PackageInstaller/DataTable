---
--- 虚空之眼
--  造成的最终伤害提高${Params[1]}%。

local Skill_112304 = BaseClass("Skill_112304", Skill)
local base = Skill

local function __init(self)

end


local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.FinalDamageAdd,self.Params[1])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.FinalDamageAdd,self.Params[1])
end


local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_112304.__init = __init
Skill_112304.OnBattleStart = OnBattleStart
Skill_112304.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_112304.OnPassiveSkillDisabled = OnPassiveSkillDisabled

return Skill_112304