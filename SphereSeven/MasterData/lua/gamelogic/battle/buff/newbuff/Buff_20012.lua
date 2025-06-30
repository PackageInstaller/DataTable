---
--- 攻击提升 攻击力提升50%
---
local Buff_20012 = BaseClass("Buff_20012",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tsc:OnPassiveSkillDisabled()
end

local function OnRemoved(self)
    self.__tsc:OnPassiveSkillEnabled()
    base.OnRemoved(self)
end

Buff_20012.OnOccur = OnOccur
Buff_20012.OnRemoved = OnRemoved

return Buff_20012