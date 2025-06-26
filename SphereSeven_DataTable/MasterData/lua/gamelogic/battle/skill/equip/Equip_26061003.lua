---
--- 战斗中队友第一次阵亡时，提升自身行动值${Params[1]}%。
---

local Equip_26061003 = BaseClass("Equip_26061003", Skill)
local base = Skill

local function __init(self)
    self.Triggered = false
end

local function OnBattleStart(self)
    base.OnBattleStart(self)

    self.Triggered = false
end

local function OnFriendDead(self)
    if self.Triggered then
        return
    end

    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])

    self.Triggered = true
end

Equip_26061003.__init = __init
Equip_26061003.OnBattleStart = OnBattleStart
Equip_26061003.OnFriendDead = OnFriendDead

return Equip_26061003