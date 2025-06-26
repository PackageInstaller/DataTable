---
--- 暴击后，提高自身速攻值${Params[1]}%
---
local Equip_12040104 = BaseClass("Equip_12040104", Skill)
local base = Skill

local function __init(self)
end

---当攻击结束时
local function OnAtkEnd(self)
    for _, activeSkillResult in pairs(self.__bc.CurActSkill.UnitResults) do
        if activeSkillResult.IsCri then
            self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])
            return
        end
    end
end


Equip_12040104.__init = __init
Equip_12040104.OnAtkEnd = OnAtkEnd

return Equip_12040104