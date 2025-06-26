local this = require("GameLogic.Battle.Component.BattleComponent")

function this.OnBattleStart(self)
    table.walk(table.choose(self.IdUnits,function (k,v) return v.IsPlayer end),function (k,v)
        v:GetComponent("SkillComponent"):OnBattleStart()
    end)
    table.walk(self.IdUnits,function (k,v)
        --v:GetComponent("BuffComponent"):OnBattleStart()
        v:GetComponent("SsUnitEffectComponent"):OnBattleStart()
    end)
end

function this.OnBatchStart(self)
    --table.walk(self.IdUnits,function (k,v)
    --    v:GetComponent("SkillComponent"):OnBattleStart()
    --end)
    table.walk(table.filter(self.IdUnits,function (k,v) return v.IsPlayer end),function (k,v)
        v:GetComponent("SkillComponent"):OnBattleStart()
    end)
    table.walk(table.filter(self.IdUnits,function (k,v) return not v.IsPlayer end),function (k,v)
        v:GetComponent("SkillComponent"):OnBatchStart()
    end)
    table.walk(table.filter(self.IdUnits,function (k,v) return v.IsPlayer end), function (k,v)
        v:GetComponent("SsUnitBattleComponent"):OnBatchStart()
    end)
end

function this.OnBatchEnd(self)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SsUnitEffectComponent"):OnBatchEnd()
    end)
end

function this.OnRoundStart(self)
    local filterTb = table.filter(self.IdUnits,function (k,v) return v:GetComponent("CharacterComponent").IsDead end)
    table.walk(filterTb,function (k,v)
        if v:GetComponent("CharacterComponent").IsDead then
            return
        end
        v:GetComponent("SsUnitUIComponent"):OnRoundStart() -- UI组件调用回合开始
        local guideList = self.GuideComponent.GuideList
        local guideStep = table.first(guideList,function (a) return a.Id==12001  end)
        if self.ZBattleLevel.Id == 1011 and  (guideStep == nil or guideStep.Step < 8) and self.against_component.LevelType == LevelType.LevelTypeStory then
            coroutine.start(function()
               coroutine.waituntil(function ()
                   local guideList1 =  Game.Scene:GetComponent("GuideComponent").GuideList
                   local  guideStep1 = table.first(guideList1,function (a) return a.Id==12001  end)
                   return guideStep1 ~= nil and  guideStep1.Step >= 8  end)
                v:GetComponent("SkillComponent"):OnRoundStart() -- 技能组件调用回合开始
            end )
        else
            v:GetComponent("SkillComponent"):OnRoundStart() -- 技能组件调用回合开始
        end


        v:GetComponent("BuffComponent"):OnRoundStart() -- buff组件调用回合开始
    end)
end

function this.OnRoundEnd(self)
    -- 过滤死亡的单位
    local filterTb = table.filter(self.IdUnits,function (k,v) return v:GetComponent("CharacterComponent").IsDead end)
    table.walk(filterTb,function (k,v) -- 未死亡单位
        v:GetComponent("SkillComponent"):OnRoundEnd()  -- 技能组件调用回合结束
        v:GetComponent("BuffComponent"):OnRoundEnd() -- buff组件调用回合结束
    end)
end

function this.OnActStart(self)
    if self.CurActUnit == nil then
        Logger.LogError("OnActStart:self.CurActUnit == nil")
        return
    end

    local record = self:GetUnitRecord(self.CurActUnit.UID)
    record:RecordMovement()

    local actUnit = self.CurActUnit:GetComponent("SsUnitBattleComponent")
    actUnit.__entity:GetComponent("SkillComponent"):OnActStart()
    actUnit.__entity:GetComponent("BuffComponent"):OnActStart()
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnActStartEvent(self.CurActUnit)
    end)
end

function this.OnAtkStart(self)
    -- 当前行动调用开始攻击    -- buff组件调用开始攻击
    if self.CurActSkill == nil then
        Logger.LogError("OnAtkStart:self.CurActSkill == nil")
        return
    end
    if self.CurActUnit == nil then
        Logger.LogError("OnAtkStart:self.CurActUnit == nil")
        return
    end
    self.CurActSkill:OnAtkStart()
    self.CurActUnit:GetComponent("BuffComponent"):OnAtkStart()
    self.CurActUnit:GetComponent("SsUnitEffectComponent"):OnAtkStart() --特效结束
end

function this.BeforeHitEvent(self, activeSkillResult, atkUnit, targetUnit)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("BuffComponent"):BeforeHitEvent(activeSkillResult, atkUnit, targetUnit)
        v:GetComponent("SkillComponent"):BeforeHitEvent(activeSkillResult, atkUnit, targetUnit)
    end)
end

function this.OnAtkEnd(self)
    if self.CurActUnit == nil then
        Logger.LogError("OnAtkStart:self.CurActUnit == nil")
        return
    end
    self.CurActUnit:GetComponent("BuffComponent"):OnAtkEnd() --buff组件调用攻击结束
    self.CurActUnit:GetComponent("SkillComponent"):OnAtkEnd() --技能组件调用攻击结束

    -- 攻击结束事件
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnAtkEndEvent(self.CurActUnit)
    end)
end

function this.OnActEnd(self)
    if self.CurActUnit == nil then
        Logger.LogError("OnActEnd:self.CurActUnit == nil")
        return
    end
    self.CurActUnit:GetComponent("SkillComponent"):OnActEnd() --技能组件调用攻击结束
    self.CurActUnit:GetComponent("BuffComponent"):OnActEnd() --buff组件调用攻击结束
    self.CurActUnit:GetComponent("SsUnitUIComponent"):OnActEnd() --ui组件调用攻击结束
    self.CurActUnit:GetComponent("SsUnitEffectComponent"):OnActEnd() --特效结束
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SsUnitBattleComponent"):OnActEnd()
    end)
end

function this.OnActEndEvent(self, unit)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnActEndEvent(unit)
    end)
end

function this.OnUseAwaken(self)
    if self.CurActUnit == nil then
        Logger.LogError("OnUseAwaken:self.CurActUnit == nil")
        return
    end
    self.CurActUnit:GetComponent("SkillComponent"):OnUseAwaken()
end

function this.BeforeHpReduceEvent(self, unit, reduceHpData)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):BeforeHpReduceEvent(unit, reduceHpData)
    end)
end

function this.OnReduceHpEvent(self, unit, reduceHpData)
    local record = self:GetUnitRecord(unit.UID)
    record:RecordBeHurt(reduceHpData.Hp)

    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnReduceHpEvent(unit, reduceHpData)
    end)
end

function this.OnHealEvent(self, unit, hp)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnHealEvent(unit, hp)
    end)
end

function this.OnUnitTurnStart(self, unit)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnUnitTurnStartEvent(unit)
        v:GetComponent("BuffComponent"):OnUnitTurnStartEvent(unit)
        if v == unit then
            v:GetComponent("SkillComponent"):OnUnitSelfTurnStart()
            v:GetComponent("BuffComponent"):OnUnitSelfTurnStart()
            v:GetComponent("SsUnitBattleComponent"):OnUnitSelfTurnStart()
            v:GetComponent("SsUnitUIComponent"):OnUnitSelfTurnStart()
        end
    end)
end

function this.OnUnitTurnEnd(self, unit)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnUnitTurnEndEvent(unit)
        v:GetComponent("BuffComponent"):OnUnitTurnEndEvent(unit)
        if v == unit then
            v:GetComponent("SkillComponent"):OnUnitSelfTurnEnd()
            v:GetComponent("BuffComponent"):OnUnitSelfTurnEnd()
            v:GetComponent("SsUnitBattleComponent"):OnUnitSelfTurnEnd()
            v:GetComponent("SsUnitUIComponent"):OnUnitSelfTurnEnd()
        end
    end)
end

function this.OnBuffCalcEvent(self, unit, buff)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnBuffCalcEvent(unit, buff)
    end)
end

function this.BeforeBuffAddEvent(self, buff)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):BeforeBuffAddEvent(buff)
    end)
end

function this.OnBuffAddEvent(self, buff)
    local record = self:GetUnitRecord(buff.TargetUnit.UID)
    record:RecordDebuffAttached(buff.BuffId, buff.IsDeBuff)

    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnBuffAddEvent(buff)
    end)
end

function this.OnBuffRemoveEvent(self, buff)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnBuffRemoveEvent(buff)
    end)
end

function this.OnDamageEvent(self, atkUnit, hurtUnit, activeSkillResult)
    table.walk(self.IdUnits,function (k,v)
        v:GetComponent("SkillComponent"):OnDamageEvent(atkUnit, hurtUnit, activeSkillResult)
    end)
end

return this