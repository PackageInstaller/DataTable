---
--- 战斗中第一次受到攻击时,减少${Params[1]}%的最终伤害,解除自身所有异常状态并提升${Params[2]}%的行动值。在一场战斗中只会触发一次。
---

local Equip_21051014 = BaseClass("Equip_21051014", Skill)
local base = Skill

local function __init(self)
    self.Data.DamageReducePct = self.Params[1]
    self.Data.ActValueAdd = self.Params[2]

    self.Data.Triggered = false
    self.Data.BuffRemoved = false
end

local function BeforeBeHit(self, activeSkillResult, atkUnit)
    base.BeforeHit(self, activeSkillResult, atkUnit)

    if self.Data.Triggered then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    activeSkillResult.ExtraFinalDamagePct = activeSkillResult.ExtraFinalDamagePct - self.Data.DamageReducePct
    activeSkillResult.ActChange = activeSkillResult.ActChange + self.Data.ActValueAdd

    self.Data.Triggered = true
end

local function AfterBeHitAll(self, atkUnit, activeSkillResult)
    base.AfterBeHitAll(self, atkUnit, activeSkillResult)

    if self.Data.BuffRemoved then
        return
    end

    self.__sbc:RemoveAllBuff(true)
    
    self.Data.BuffRemoved = true
end

Equip_21051014.__init = __init
Equip_21051014.BeforeBeHit = BeforeBeHit
Equip_21051014.AfterBeHitAll = AfterBeHitAll

return Equip_21051014