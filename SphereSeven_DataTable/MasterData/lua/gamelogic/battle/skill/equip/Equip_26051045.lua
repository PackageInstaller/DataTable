---
--- 每有一名友军阵亡,攻击力提升${Params[1]}%的攻击力。
---

local Equip_26051045 = BaseClass("Equip_26051045", Skill)
local base = Skill

local function __init(self)
    self.Data.AtkPct = self.Params[1]

    self.Data.TotalAtkPct = 0
end

local function OnFriendDead(self)
    base.OnFriendDead(self)

    if self.__scc.IsDead then
        return
    end

    self.__snc:Inc(NumericType.AtkPct, self.Data.AtkPct)
    self.Data.TotalAtkPct = self.Data.TotalAtkPct + self.Data.AtkPct
end

local function OnDead(self)
    base.OnDead(self)
    self.__snc:Dec(NumericType.AtkPct, self.Data.TotalAtkPct)
    self.Data.TotalAtkPct = 0
end

Equip_26051045.__init = __init
Equip_26051045.OnFriendDead = OnFriendDead
Equip_26051045.OnDead = OnDead

return Equip_26051045