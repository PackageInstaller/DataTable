---
--- 火之妖精
--  免疫【灼烧】，场上每有一个【灼烧】提升自身${Params[1]}%的攻击力和速度

local Skill_112804 = BaseClass("Skill_112804", Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)
    self.__snc:Inc(NumericType.ERistAdd, self.Params[1])
    self.__scc:IncImmuneDeBuff(BattleBuffType.Fire)
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)
    self.__snc:Dec(NumericType.ERistAdd, self.Params[1])
    self.__scc:DecImmuneDeBuff(BattleBuffType.Fire)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function OnBuffAddEvent(self, buff)
    base.OnBuffAddEvent(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.BuffId ~= BattleBuffType.Fire then
        return
    end

    self.__snc:Inc(NumericType.AtkPct, self.Params[1])
    self.__snc:Inc(NumericType.SpeedPct, self.Params[1])
end

local function OnBuffRemoveEvent(self, buff)
    base.OnBuffRemoveEvent(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.BuffId ~= BattleBuffType.Fire then
        return
    end

    self.__snc:Dec(NumericType.AtkPct, self.Params[1])
    self.__snc:Dec(NumericType.SpeedPct, self.Params[1])
end

Skill_112804.__init = __init
Skill_112804.OnBattleStart = OnBattleStart
Skill_112804.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_112804.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_112804.OnBuffAddEvent = OnBuffAddEvent
Skill_112804.OnBuffRemoveEvent = OnBuffRemoveEvent

return Skill_112804