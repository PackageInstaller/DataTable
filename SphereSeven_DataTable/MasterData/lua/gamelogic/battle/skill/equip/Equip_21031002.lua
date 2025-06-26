---
--- 每次自身回合开始时,赋予随机前排敌人{Params[1]}回合的【冻结】。
---

local Equip_21031002 = BaseClass("Equip_21031002", Skill)
local base = Skill

local function __init(self)
    self.Data.BuffTurn = self.Params[1]
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    local targets = table.choose(self:__get_enemy_front(),function (_,v) return
        (not v:GetComponent("CharacterComponent").IsDead)
    end )

    local target = table.randget(targets)
    if target ~= nil then
        target:GetComponent("BuffComponent"):CreateBuff(BattleBuffType.Freeze, self.SkillId, self.SrcUnit, target, self.Data.BuffTurn)
    end
end

Equip_21031002.__init = __init
Equip_21031002.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return Equip_21031002