---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/18 11:35
--- 姒文命
---
local FightSoul_30018 = BaseClass("FightSoul_30018",Skill)
local base = Skill

local function __init(self)
end

local function OnHealEvent(self, unit, hp)
    base.OnHealEvent(self, unit, hp)
    if unit.IsPlayer ~= self.SrcUnit.IsPlayer then
        return
    end
    if BattleUtil.IsPctProbHit(self.Params[1]) then
        self.__sbc:CreateBuff(10001,self.SkillId,self.SrcUnit,self.SrcUnit,1)
    end
end

FightSoul_30018.__init = __init
FightSoul_30018.OnHealEvent = OnHealEvent

return FightSoul_30018