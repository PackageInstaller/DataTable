---
--- 战斗开始时，使自身攻击力增加${Params[1]}%，每次行动后增加量减少${Params[2]}%。最低降低到${Params[3]}%。
---


local Equip_15090304 = BaseClass("Equip_15090304", Skill)
local base = Skill

local function __init(self)
    self.AtkAddPct = 0
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.AtkPct, self.Params[1])
    self.AtkAddPct = self.Params[1]
end

local function OnActEnd(self)
    base.OnActEnd(self)

    local decValue = self.Params[2]
    local newAtkAddPct = self.AtkAddPct - self.Params[2]
    if newAtkAddPct < self.Params[3] then
        newAtkAddPct = self.Params[3]
        decValue = self.AtkAddPct - newAtkAddPct
    end

    self.__snc:Dec(NumericType.AtkPct, decValue)
    self.AtkAddPct = newAtkAddPct
end

Equip_15090304.__init = __init
Equip_15090304.OnBattleStart = OnBattleStart
Equip_15090304.OnActEnd = OnActEnd

return Equip_15090304