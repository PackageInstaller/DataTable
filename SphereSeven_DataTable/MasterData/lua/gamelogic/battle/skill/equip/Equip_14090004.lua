---
--- 被施加异常状态后，有${Params[1]}%的概率对来源施加相同的状态。
---

local Equip_14090004 = BaseClass("Equip_14090004", Skill)
local base = Skill

local function __init(self)
end

local function OnBuffAdd(self, buff)
    base.OnBuffAdd(self, buff)

    if not buff.IsDeBuff then
        return
    end

    if not BattleUtil.IsFriend(buff.SrcUnit, self.SrcUnit) then
        return
    end

    if BattleUtil.IsPctProbHit(self.Params[1]) then
        buff.SrcUnit:GetComponent("BuffComponent"):CreateBuff(buff.BuffId, self.SkillId, self.SrcUnit, buff.SrcUnit, buff.LeftTurn)
    end
end

Equip_14090004.__init = __init
Equip_14090004.OnBuffAdd = OnBuffAdd

return Equip_14090004