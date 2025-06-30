---
--- 战斗的第一回合，获得${Params[1]}回合的【加速】。并提升自身速攻值${Params[2]}%。
---

local Equip_15080204 = BaseClass("Equip_15080204", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    local turn = math.modf(self.Params[1])
    self.__sbc:CreateBuff(BattleBuffType.SpeedIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, turn)
    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[2])
end

Equip_15080204.__init = __init
Equip_15080204.OnBattleStart = OnBattleStart

return Equip_15080204