---
--- 敌方使用非攻击技能后，自身行动值提升${Params[1]}%。并有${Params[2]}%的概率获得${Params[3]}回合的【攻击力提升】。1回合最多触发1次。
---
local FightSoul_30043 = BaseClass("FightSoul_30043", Skill)
local base = Skill

local function __init(self)
    self.triggered = false
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    self.triggered = false
end

---当有单位攻击结束时
local function OnAtkEndEvent(self, atkUnit)
    base.OnAtkEndEvent(self, atkUnit)

    if self.__scc.IsDead then
        return
    end

    if self.triggered then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    if self.__bc.CurActSkill.ZSkill.SkillType ~= BattleSkillType.Damage then
        return
    end

    self.SrcUnit:GetComponent("BattleUnitComponent"):ChangeActValue(self.Params[1])

    if ss.IsRandHit(self.Params[2] / 100) then
        local buffTurnCount = math.modf(self.Params[3])
        self.SrcUnit:GetComponent("BuffComponent"):CreateBuff(BattleBuffType.AtkIncrease, self.SkillId, self.SrcUnit, self.SrcUnit, buffTurnCount)
    end

    self.triggered = true
end


FightSoul_30043.__init = __init
FightSoul_30043.OnUnitSelfTurnStart = OnUnitSelfTurnStart
FightSoul_30043.OnAtkEndEvent = OnAtkEndEvent

return FightSoul_30043