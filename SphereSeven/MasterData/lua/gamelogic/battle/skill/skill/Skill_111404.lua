---
--- 坚石外壳
--- 受到物理伤害时，有&{Params[1]}%的概率发动反击。受到的法术最终伤害提升&{Params[2]}%。

local Skill_111404 = BaseClass("Skill_111404", Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.MagicHurtAdd, -self.Params[2])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.MagicHurtAdd, -self.Params[2])
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    if self.IsDisabled then
        return
    end

    if not BattleUtil.IsPctProbHit(self.Params[1]) then
        return
    end
    
    if self.__bc.CurActType ~= ActType.Cac then
        self.__subc.CacUnit = atkUnit
    end
end

Skill_111404.__init = __init
Skill_111404.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_111404.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_111404.OnBattleStart = OnBattleStart
Skill_111404.AfterHurt = AfterHurt

return Skill_111404