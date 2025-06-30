---
--- 自身处于异常状态时，每有一个异常状态提高速度，效果命中，效果回避${Params[1]}%
---

local Equip_16090204 = BaseClass("Equip_16090204", Skill)
local base = Skill

local function __init(self)
end

local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if not buff.IsDeBuff then
        return
    end

    self.__snc:Inc(NumericType.SpeedPct, self.Params[1])
    self.__snc:Inc(NumericType.EAccAdd, self.Params[1])
    self.__snc:Inc(NumericType.ERistAdd, self.Params[1])
end

local function OnBuffRemove(self, buff)
    base.OnBuffRemove(self, buff)

    if not buff.IsDeBuff then
        return
    end

    self.__snc:Dec(NumericType.SpeedPct, self.Params[1])
    self.__snc:Dec(NumericType.EAccAdd, self.Params[1])
    self.__snc:Dec(NumericType.ERistAdd, self.Params[1])
end

Equip_16090204.__init = __init
Equip_16090204.OnBuffAdd = OnBuffAdd
Equip_16090204.OnBuffRemove = OnBuffRemove

return Equip_16090204