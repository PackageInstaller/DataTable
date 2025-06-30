---
--- 反伤
---
local Buff_2020 = BaseClass("Buff_2020",Buff)
local base = Buff

local function OnOccur(self)
    base.OnOccur(self)
    self.__tnc:Inc(self.NumericType,self.NumericVal)
end

local function OnRemoved(self)
    self.__tnc:Dec(self.NumericType,self.NumericVal)
    base.OnRemoved(self)
end

Buff_2020.OnOccur = OnOccur
Buff_2020.OnRemoved = OnRemoved

return Buff_2020