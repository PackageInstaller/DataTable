---
--- 永不停歇
--- "每次受到攻击伤害时，获得${Params[1]}层【怒火】。当【怒火】达到${Params[2]}层时，立即进行一次反击并清除所有怒火。当自己在任意回合中没有受到伤害时，在该回合结束时清除所有【怒火】。
--- *怒火：计数用特殊状态。"

local Skill_114004 = BaseClass("Skill_114004", Skill)
local base = Skill

local function __init(self)
    self.Data.thisTurnBeHurt = false
end

local function AfterHurt(self, activeSkillResult, atkUnit)
    base.AfterHurt(self, activeSkillResult, atkUnit)

    if self.IsDisabled then
        return
    end

    local buff = self.__sbc:CreateBuff(BattleBuffType.Anger, self.SkillId, self.SrcUnit, self.SrcUnit, 0, true, nil, self.Params[1], false)
    if buff and buff.NumericVal >= self.Params[2] then
        self.__sbc:RemoveBuff(BattleBuffType.Anger, self.SkillId, buff.NumericVal)
        self.__subc.CacUnit = atkUnit
    end

    self.Data.thisTurnBeHurt = true
end

---当回合开始时
local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    self.Data.thisTurnBeHurt = false
end

---当回合结束时
local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    if not self.Data.thisTurnBeHurt then
        local buff = self.__sbc:GetBuff(BattleBuffType.Anger)
        if buff ~= nil then
            self.__sbc:RemoveBuff(BattleBuffType.Anger, self.SkillId, buff.NumericVal)
        end
    end
end


Skill_114004.__init = __init
Skill_114004.AfterHurt = AfterHurt
Skill_114004.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_114004.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Skill_114004