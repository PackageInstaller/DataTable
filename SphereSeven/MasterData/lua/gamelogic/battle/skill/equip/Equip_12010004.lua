---
--- 自身生命值每降低${Params[1]}%，攻击力提升${Params[2]}%,暴击率提升${Params[3]}%
---
local Equip_12010004 = BaseClass("Equip_12010004", Skill)
local base = Skill

local function __init(self)
    self.atkAddPct = 0
    self.criAdd = 0
end

local function OnHpChange(self)
    base.OnHpChange(self)

    local rate = BattleUtil.GetHpPct(self.SrcUnit) * 100 / self.Params[1]
    
    self.__snc:Dec(NumericType.AtkPct, self.atkAddPct)
    self.__snc:Dec(NumericType.CriAdd, self.criAdd)

    self.atkAddPct = rate * self.Params[2]
    self.criAdd = rate * self.Params[3]

    self.__snc:Inc(NumericType.AtkPct, self.atkAddPct)
    self.__snc:Inc(NumericType.CriAdd, self.criAdd)
end

Equip_12010004.__init = __init
Equip_12010004.OnHpChange = OnHpChange

return Equip_12010004