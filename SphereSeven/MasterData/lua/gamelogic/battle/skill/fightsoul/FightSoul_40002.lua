---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/18 14:16
---
local FightSoul_40002 = BaseClass("FightSoul_40002",Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkPct, self.Params[1])
end

local function OnActEnd(self)
    base.OnActEnd(self)
    local zSkill = self.__bc.CurActSkill.ZSkill
    if zSkill == nil or zSkill.EnemyRange ~= EnemyRange.Single then
        return
    end
    local targetUnit = self.__bc.CurActSkill.TargetUnits[1]
    if not targetUnit:GetComponent("BuffComponent"):HasDeBuff() then
        return
    end

    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[2])
end

FightSoul_40002.__init = __init
FightSoul_40002.OnBattleStart = OnBattleStart
FightSoul_40002.OnActEnd = OnActEnd

return FightSoul_40002