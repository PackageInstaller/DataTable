---
--- 攻击提升 攻击力提升50%
---
local Buff_10016 = BaseClass("Buff_10016",Buff)
local base = Buff

local function OnOccur(self)
    Logger.BattleLog(string.format("添加物理护盾buff, 值: %s", self.Data.ShieldValue))
    base.OnOccur(self)
end

local function OnMultiply(self, val, data)
    base.OnMultiply(self, val, data)
    self.Data.ShieldValue = self.Data.ShieldValue + data.ShieldValue
    Logger.BattleLog(string.format("叠加添加物理护盾buff, 现值: %s", self.Data.ShieldValue))
end

local function OnReduceHp(self, hp)
    local outHp
    if hp >= self.Data.ShieldValue then
        outHp = hp - self.Data.ShieldValue
        self.Data.ShieldValue = 0
        self.IsRemoved = true
    else
        self.Data.ShieldValue = self.Data.ShieldValue - hp
        outHp = 0
    end
    Logger.BattleLog(string.format("物理护盾buff抵消掉血, 应掉血:%s, 实际掉血:%s", hp, outHp))
    return outHp
end

local function OnRemoved(self)
    base.OnRemoved(self)
end

Buff_10016.OnOccur = OnOccur
Buff_10016.OnRemoved = OnRemoved
Buff_10016.OnMultiply = OnMultiply
Buff_10016.OnReduceHp = OnReduceHp

return Buff_10016