---
--- 行动后，全体友军自身${Params[1]}%的最大生命值。
---

local Equip_11060004 = BaseClass("Equip_11060004", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    local heal = self.__snc:Get(NumericType.MaxHp) * self.Params[1] / 100

    local friends = self:__get_friend_all()
    for _, targetUnit in pairs(friends) do
        if not targetUnit:GetComponent("CharacterComponent").IsDead then
            targetUnit:GetComponent("SsUnitBattleComponent"):Heal(heal, self.SrcUnit)
        end
    end
end

Equip_11060004.__init = __init
Equip_11060004.OnActEnd = OnActEnd

return Equip_11060004