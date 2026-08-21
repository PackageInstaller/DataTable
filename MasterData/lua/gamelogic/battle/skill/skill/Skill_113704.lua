---
--- 华丽的残暴
--  "每次自身回合开始时，如果自身处于强化状态，攻击力，物防，术防，速度，永久提升${Params[1]}%。
--  自身第一次行动结束后，获得${Params[2]}%回合的【暴击抵抗率提升】"

local Skill_113704 = BaseClass("Skill_113704", Skill)
local base = Skill

local function __init(self)
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    if self.IsDisabled then
        return
    end

    if self.__sbc:HasBuff() then
        self.__snc:Inc(NumericType.AtkAdd, self.Params[1])
        self.__snc:Inc(NumericType.DefAdd, self.Params[1])
        self.__snc:Inc(NumericType.MagicDefAdd, self.Params[1])
        self.__snc:Inc(NumericType.SpeedAdd, self.Params[1])
    end
end

local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    if self.IsDisabled then
        return
    end

    if self.__subc.TotalTurnNum <= 1 then
        self.__sbc:CreateBuff(BattleBuffType.CriResistIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, self.Params[1], false)
    end
end

Skill_113704.__init = __init
Skill_113704.OnUnitSelfTurnStart = OnUnitSelfTurnStart
Skill_113704.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Skill_113704