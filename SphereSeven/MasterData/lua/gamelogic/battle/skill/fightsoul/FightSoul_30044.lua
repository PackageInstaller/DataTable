---
--- 持有护盾状态的友军受到攻击后，对其造成自身自身攻击力${Params[1]}%的治疗。每个友军每回合最多触发1次。
---
local FightSoul_30044 = BaseClass("FightSoul_30044",Skill)
local base = Skill

local function __init(self)
    self.triggerMap = {}
    self.triggeredRecord = {}
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnStart(self)

    self.triggeredRecord = {}
end

local function BeforeHitEvent(self, activeSkillResult, atkUnit, targetUnit)
    base.BeforeHitEvent(self, activeSkillResult, atkUnit, targetUnit)

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    if targetUnit:GetComponent("CharacterComponent").IsDead then
        return
    end
    if not BattleUtil.IsFriend(self.SrcUnit, targetUnit) then
        return
    end
    if not BattleUtil.HasShield(targetUnit) then
        return
    end

    if self.triggeredRecord[targetUnit.UID] ~= nil then
        return
    end

    self.triggerMap[targetUnit.UID] = true
end

local function OnAtkEndEvent(self, atkUnit)
    base.OnAtkEndEvent(self, atkUnit)

    if table.count(self.triggerMap) <= 0 then
        return
    end

    if BattleUtil.IsFriend(self.SrcUnit, atkUnit) then
        return
    end

    for _, unit in pairs(self.__bc.CurActSkill.TargetUnits) do
        if unit:GetComponent("CharacterComponent").IsDead then
            goto continue
        end

        if self.triggerMap[unit.UID] == nil then
            return
        end
    
        local heal = self.__snc:Get(NumericType.Atk) * self.Params[1] / 100
        unit:GetComponent("SsUnitBattleComponent"):Heal(heal, self.SrcUnit)
    
        self.triggeredRecord[unit.UID] = true

        ::continue::
    end

    self.triggerMap = {}
end

FightSoul_30044.__init = __init
FightSoul_30044.OnUnitSelfTurnStart = OnUnitSelfTurnStart
FightSoul_30044.BeforeHitEvent = BeforeHitEvent
FightSoul_30044.OnAtkEndEvent = OnAtkEndEvent

return FightSoul_30044