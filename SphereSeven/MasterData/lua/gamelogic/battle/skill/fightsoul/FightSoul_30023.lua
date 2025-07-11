---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/22 16:52
--- 曹操
---
local FightSoul_30023 = BaseClass("FightSoul_30023",Skill)
local base = Skill

local function __init(self)
    self.Data.Count = 0
end

local function OnHeal(self)
    base.OnHeal(self)
    if self.Data.Count >= self.Params[2] then
        return
    end
    self.__snc:Inc(NumericType.SpeedPct, self.Params[1])
    self.Data.Count = self.Data.Count + 1
    Logger.BattleLog(string.format("战魂30023, 恢复增加速度: %s, 次数: %s", self.Params[1], self.Data.Count))
end

FightSoul_30023.__init = __init
FightSoul_30023.OnHeal = OnHeal

return FightSoul_30023