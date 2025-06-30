---
--- 行动后，${Params[1]}%的概率解除随机友军身上的一个异常状态。
---

local Equip_12060004 = BaseClass("Equip_12060004", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)

    local friends = table.randtake(self:__get_friend_all(), 1)

    for _, targetUnit in pairs(friends) do
        if BattleUtil.IsPctProbHit(self.Params[1]) then
            targetUnit:GetComponent("BuffComponent"):RandomRemoveOneBuff(true)
        end
    end
end


Equip_12060004.__init = __init
Equip_12060004.OnActEnd = OnActEnd

return Equip_12060004