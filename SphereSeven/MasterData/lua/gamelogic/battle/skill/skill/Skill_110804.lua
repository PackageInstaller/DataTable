---
--- 深渊魔物
--- 每个回合开始时，解除所有前排敌人1个强化状态

local Skill_110804 = BaseClass("Skill_110804",Skill)
local base = Skill

local function __init(self)

end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    if self.IsDisabled then
        return
    end
    local targets = self:__get_enemy_front()
    table.walk(targets, function(k, v)
        v:GetComponent("BuffComponent"):RandomRemoveOneBuff(false)
    end)
end

Skill_110804.__init = __init
Skill_110804.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Skill_110804