---
--- 神圣光环
--- 我方全体治疗量${Params[1]}

local Skill_111904 = BaseClass("Skill_111904", Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)

    local friends = self:__get_friend_all()
    for _, unit in pairs(friends) do
        unit:GetComponent("NumericComponent"):Inc(NumericType.CriFinalHurtAdd, self.Params[1])
    end
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)

    local friends = self:__get_friend_all()
    for _, unit in pairs(friends) do
        unit:GetComponent("NumericComponent"):Dec(NumericType.CriFinalHurtAdd, self.Params[1])
    end

end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_111904.__init = __init
Skill_111904.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_111904.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_111904.OnBattleStart = OnBattleStart

return Skill_111904