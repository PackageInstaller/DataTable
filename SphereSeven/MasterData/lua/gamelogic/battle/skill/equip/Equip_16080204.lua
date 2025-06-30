---
--- 自身生命值每减少${Params[1]}%，暴击伤害提高${Params[2]}%
---

local Equip_16080204 = BaseClass("Equip_16080204", Skill)
local base = Skill

local function __init(self)
    self.CriAdd = 0
end

local function OnHpChange(self)
    base.OnHpChange(self)

    local rate = BattleUtil.GetHpPct(self.SrcUnit) * 100 / self.Params[1]
    
    self.__snc:Dec(NumericType.CriAdd, self.CriAdd)

    self.CriAdd = rate * self.Params[2]

    self.__snc:Inc(NumericType.CriAdd, self.CriAdd)
end


Equip_16080204.__init = __init
Equip_16080204.OnHpChange = OnHpChange

return Equip_16080204