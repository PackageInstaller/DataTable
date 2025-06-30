---
--- 行动前，获得自身最大生命值${Params[1]}%的万能护盾${Params[2]}回合。
---
local Equip_11020004 = BaseClass("Equip_11020004", Skill)
local base = Skill

local function __init(self)
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    local value = self.__snc:Get(NumericType.MaxHp) * self.Params[1] / 100
    local turn = math.modf(self.Params[2])
    self.__sbc:CreateBuff(BattleBuffType.UniversalShield, nil, self.SrcUnit, self.SrcUnit, turn, nil, nil, nil, nil, { ShieldValue = value })
end

Equip_11020004.__init = __init
Equip_11020004.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Equip_11020004