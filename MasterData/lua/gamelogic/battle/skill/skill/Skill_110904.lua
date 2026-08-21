---
--- 盾牌防御
--- 自身受到的物理伤害-10%(Params[1])

local Skill_110904 = BaseClass("Skill_110904",Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.PhysicHurtAdd,self.Params[1])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.PhysicHurtAdd,self.Params[1])
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_110904.__init = __init
Skill_110904.OnBattleStart = OnBattleStart
Skill_110904.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_110904.OnPassiveSkillDisabled = OnPassiveSkillDisabled

return Skill_110904