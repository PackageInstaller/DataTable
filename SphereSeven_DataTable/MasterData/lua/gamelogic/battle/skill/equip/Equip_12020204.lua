---
--- 队友承受伤害时，分担其${Params[1]}%的最终伤害（不可叠加，同类型承伤效果取最高）
---

local Equip_12020204 = BaseClass("Equip_12020204",Skill)
local base = Skill

local function __init(self)
    self.SharedIds = {}
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    local friends = self:__get_friend_all()
    for _, unit in pairs(friends) do
        if unit ~= self.SrcUnit then
            local sharedId = unit:GetComponent("CharacterComponent"):AddDamageShare(self.SrcUnit, self.Params[1])
            self.SharedIds[unit.UID] = sharedId
        end
    end
end

Equip_12020204.__init = __init
Equip_12020204.OnBattleStart = OnBattleStart


return Equip_12020204