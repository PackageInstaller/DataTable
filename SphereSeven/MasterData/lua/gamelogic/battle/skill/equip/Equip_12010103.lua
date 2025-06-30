---
--- 暴击率提升${Params[1]}%
---
local Equip_12010103 = BaseClass("Equip_12010103", Skill)
local base = Skill

local function __init(self)
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.CriAdd, self.Params[1])
end


Equip_12010103.__init = __init
Equip_12010103.OnBattleStart = OnBattleStart

return Equip_12010103