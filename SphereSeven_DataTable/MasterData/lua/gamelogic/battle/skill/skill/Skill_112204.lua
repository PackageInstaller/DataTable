---
--- 虚空之躯
--- 受到的最终伤害${Params[1]}%。

local Skill_112204 = BaseClass("Skill_112204", Skill)
local base = Skill

local function __init(self)

end


local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.FinalHurtAdd,self.Params[1])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.FinalHurtAdd,self.Params[1])
end


local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_112204.__init = __init
Skill_112204.OnBattleStart = OnBattleStart
Skill_112204.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_112204.OnPassiveSkillDisabled = OnPassiveSkillDisabled

return Skill_112204