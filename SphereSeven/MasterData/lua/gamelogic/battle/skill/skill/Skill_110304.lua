---
--- 剑盾协同
--- 自身受到的最终伤害-5%(Params[2])，自身造成的最终伤害+5%(Params[1])

local Skill_110304 = BaseClass("Skill_110304",Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.FinalDamageAdd,self.Params[1])
    self.__snc:Inc(NumericType.FinalHurt,self.Params[2])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.FinalDamageAdd,self.Params[1])
    self.__snc:Inc(NumericType.FinalHurt,self.Params[2])
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_110304.__init = __init
Skill_110304.OnBattleStart = OnBattleStart
Skill_110304.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_110304.OnPassiveSkillDisabled = OnPassiveSkillDisabled

return Skill_110304