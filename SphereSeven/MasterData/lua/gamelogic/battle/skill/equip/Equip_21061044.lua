---
--- 对友方角色增加增益buff时，使其行动值增加${Params[1]}%。
---

local Equip_21061044 = BaseClass("Equip_21061044", Skill)
local base = Skill

local function __init(self)
    self.Data.ActValueAdd = self.Params[1]
end

local function OnBuffAddEvent(self, buff)
    base.OnBuffAddEvent(self, buff)

    if self.IsDisabled then
        return
    end

    if buff.SrcUnit ~= self.SrcUnit then
        return
    end

    if not BattleUtil.IsFriend(buff.TargetUnit, self.SrcUnit) then
        return
    end

    buff.TargetUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Data.ActValueAdd)
    
end

Equip_21061044.__init = __init
Equip_21061044.OnBuffAddEvent = OnBuffAddEvent

return Equip_21061044