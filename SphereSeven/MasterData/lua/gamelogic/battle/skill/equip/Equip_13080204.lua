---
--- 回避率上升${Params[1]}%。回避后，直到下次行动回合结束后，攻击力提高${Params[2]}%。
---

local Equip_13080204 = BaseClass("Equip_13080204", Skill)
local base = Skill

local function __init(self)
    self.AtkPctAdd = 0
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.PryAdd, self.Params[1])

    self.AtkPctAdd = 0
end

local function AfterAllHurtByPry(self, atkUnit, activeSkillResult)
    base.AfterAllHurtByPry(self, atkUnit, activeSkillResult)

    self.__snc:Inc(NumericType.AtkPct, self.Params[2])
    self.AtkPctAdd = self.AtkPctAdd + self.Params[2]
end

local function OnUnitSelfTurnEnd(self)
    base.OnUnitSelfTurnEnd(self)

    self.__snc:Dec(NumericType.AtkPct, self.AtkPctAdd)
    self.AtkPctAdd = 0
end

Equip_13080204.__init = __init
Equip_13080204.OnBattleStart = OnBattleStart
Equip_13080204.AfterAllHurtByPry = AfterAllHurtByPry
Equip_13080204.OnUnitSelfTurnEnd = OnUnitSelfTurnEnd

return Equip_13080204