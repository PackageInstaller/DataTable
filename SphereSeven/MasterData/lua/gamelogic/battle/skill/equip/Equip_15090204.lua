---
--- 行动后，提升攻击力最高的友军${Params[1]}%的速攻值（自身以外）
---

local Equip_15090204 = BaseClass("Equip_15090204", Skill)
local base = Skill

local function __init(self)
    self.Effected = false
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.Effected = false
end

local function OnActEnd(self)
    base.OnActEnd(self)

    if self.Effected then
        return
    end

    local enemies = self:__get_enemy_all()
    local targetUnit = BattleUtil.GetExtremeAttrTarget(enemies, NumericType.Atk, true)
    if targetUnit ~= nil then
        targetUnit:GetComponent("BattleUnitComponent"):ChangeActValue(-self.Params[1])
    end

    self.Effected = true
end

Equip_15090204.__init = __init
Equip_15090204.OnBattleStart = OnBattleStart
Equip_15090204.OnActEnd = OnActEnd

return Equip_15090204