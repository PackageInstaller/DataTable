---
--- 使用技能后，提高速攻值${Params[1]}%，获得攻击力${Params[2]}%的魔法护盾${Params[3]}回合。
---

local Equip_15090004 = BaseClass("Equip_15090004", Skill)
local base = Skill

local function __init(self)
end

local function OnAtkEnd(self)
    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])

    local shieldValue = self.__snc:Get(NumericType.Atk) * self.Params[2] / 100
    local turn = math.modf(self.Params[3])
    self.__sbc:CreateBuff(BattleBuffType.MagicShield, nil, self.SrcUnit, self.SrcUnit, turn, nil, nil, nil, nil, { ShieldValue = shieldValue })
end

Equip_15090004.__init = __init
Equip_15090004.OnAtkEnd = OnAtkEnd

return Equip_15090004