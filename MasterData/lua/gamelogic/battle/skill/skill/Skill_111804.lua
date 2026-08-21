---
--- 黑龙鳞1
--- 效果抗性&{Params[1]}%。受到最终伤害-&{Params[2]}%。自身每有一个异常状态使受到的最终伤害提高&{Params[3]}%。

local Skill_111804 = BaseClass("Skill_111804", Skill)
local base = Skill

local function __init(self)

end

local function OnPassiveSkillEnabled(self)
    base.OnPassiveSkillEnabled(self)

    self.__snc:Inc(NumericType.ERistAdd, self.Params[1])
    self.__snc:Inc(NumericType.FinalHurtAdd, self.Params[2])
end

local function OnPassiveSkillDisabled(self)
    base.OnPassiveSkillDisabled(self)

    self.__snc:Dec(NumericType.ERistAdd, self.Params[1])
    self.__snc:Dec(NumericType.FinalHurtAdd, self.Params[2])

end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self:OnPassiveSkillEnabled()
end

local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.IsDeBuff then
        self.__snc:Inc(NumericType.FinalDamageAddPct, self.Params[3])
    end
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.IsDeBuff then
        self.__snc:Dec(NumericType.FinalDamageAddPct, self.Params[3])
    end
end

Skill_111804.__init = __init
Skill_111804.OnPassiveSkillEnabled = OnPassiveSkillEnabled
Skill_111804.OnPassiveSkillDisabled = OnPassiveSkillDisabled
Skill_111804.OnBattleStart = OnBattleStart
Skill_111804.OnBuffAdd = OnBuffAdd
Skill_111804.OnBuffRemove = OnBuffRemove

return Skill_111804