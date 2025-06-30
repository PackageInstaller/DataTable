---
--- 自身生命值每降低${Params[1]}%，速度提高${Params[2]}%
---

local Equip_15070204 = BaseClass("Equip_15070204", Skill)
local base = Skill

local function __init(self)
    self.speedAddPct = 0
end

local function OnHpChange(self)
    base.OnHpChange(self)

    local rate = BattleUtil.GetHpPct(self.SrcUnit) * 100 / self.Params[1]
    
    self.__snc:Dec(NumericType.SpeedPct, self.speedAddPct)

    self.speedAddPct = rate * self.Params[2]

    self.__snc:Inc(NumericType.SpeedPct, self.speedAddPct)
end

Equip_15070204.__init = __init
Equip_15070204.OnHpChange = OnHpChange

return Equip_15070204