---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/7/13 1:22
--- 乾坤
---
local Buff_2032 = BaseClass("Buff_2032",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    local nonGeneralAtkSkills = table.filter(self.__tsc.ActiveSkills,function (k,_) return k==self.__tsc.GeneralAtkId end)
    table.walk(nonGeneralAtkSkills,function (_,v)
        v.CooldownTurn = v.CooldownTurn - 2
    end)
end

local function OnRemoved(self)
    local nonGeneralAtkSkills = table.filter(self.__tsc.ActiveSkills,function (k,_) return k==self.__tsc.GeneralAtkId end)
    table.walk(nonGeneralAtkSkills,function (_,v)
        v.CooldownTurn = v.CooldownTurn + 2
    end)
    base.OnRemoved(self)
end

Buff_2032.OnOccur = OnOccur
Buff_2032.OnRemoved = OnRemoved

return Buff_2032