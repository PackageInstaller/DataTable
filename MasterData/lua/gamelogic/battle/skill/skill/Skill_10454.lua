---
--- 萬年不朽
--- 获得永久的【隐身】状态（不会被解除）。

local Skill_10454 = BaseClass("Skill_10454",Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__sbc:CreateBuff(BattleBuffType.Hide, self.SkillId, self.SrcUnit, self.SrcUnit, 0, true)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__sbc:RemoveBuff(BattleBuffType.Hide, self.SkillId, 1)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

Skill_10454.__init = __init
Skill_10454.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_10454.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_10454.OnBattleStart = OnBattleStart


return Skill_10454