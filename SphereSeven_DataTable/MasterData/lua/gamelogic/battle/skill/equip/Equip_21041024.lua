---
--- 最终伤害提升${Params[1]}%。攻击后,根据目标身上的异常状态数量每个提升自身${Params[2]}%的行动值。
---

local Equip_21041024 = BaseClass("Equip_21041024", Skill)
local base = Skill

local function __init(self)
    self.Data.DamageAddPct = self.Params[1]
    self.Data.ActValueAdd = self.Params[2]
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.FinalDamageAdd, self.Data.DamageAddPct)
end


local function AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    base.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)

    if BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end

    local debuffCount = targetUnit:GetComponent("BuffComponent"):BuffTypeCount(true)
    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Data.ActValueAdd * debuffCount)
end

Equip_21041024.__init = __init
Equip_21041024.OnBattleStart = OnBattleStart
Equip_21041024.AfterOneTargetAllHit = AfterOneTargetAllHit

return Equip_21041024