---
--- 暴击伤害提升${Params[1]}%，在PVP以外的战斗中，最终伤害量提升${Params[2]}%
---
local Equip_11030204 = BaseClass("Equip_11030204", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriDamageAdd, self.Params[1])

    if self.__bc.against_component.LevelType == LevelType.LevelTypeArena then
        self.__snc:Inc(NumericType.FinalDamageAdd, self.Params[2])
    end
end

Equip_11030204.__init = __init
Equip_11030204.OnBattleStart = OnBattleStart

return Equip_11030204