---
--- 行动后，${Params[1]}%的概率延长随机友军身上的一个BUFF ${Params[2]}回合（含有tag${Params[3]}, ${Params[4]}...的除外）
---

local Equip_12060204 = BaseClass("Equip_12060204", Skill)
local base = Skill

local function __init(self)
end

local function OnActEnd(self)
    base.OnActEnd(self)
    if not BattleUtil.IsPctProbHit(self.Params[1]) then
        return
    end

    local tags = {}
    for i = 3, #self.Params, 1 do
        local number = math.modf(self.Params[i])
        table.insert(tags, number)
    end

    local friends = table.randtake(self:__get_friend_all(), 1)
    for _, targetUnit in pairs(friends) do
        local buffs = targetUnit:GetComponent("BuffComponent"):RandomGetBuff(true, 1, function(buff) return buff:HasAnyTag(tags) end)
        for _, buff in pairs(buffs) do
            buff:IncLeftTurn(self.Params[2])
        end
    end

end

Equip_12060204.__init = __init
Equip_12060204.OnActEnd = OnActEnd

return Equip_12060204