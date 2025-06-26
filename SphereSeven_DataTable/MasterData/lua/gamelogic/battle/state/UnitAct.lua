local state = BaseState:New(BattleState.UnitAct)

local function GetEnableUnitBySkill(characterComponent, zSkill, ignoreHidden)
    if zSkill.IsReviveSkill == 1 then
        return characterComponent.IsDead
    elseif ignoreHidden then
        return characterComponent:IsNotDead()
    else
        return characterComponent:IsNotDeadAndNotHide()
    end
end

-- 当前技能能够攻击的所有目标
local function GetUnitSkillActiveTargets(self)
    local targets = {}
    if self.CurActUnit == nil then
        Logger.LogError("GetCurrentSkillTarget: self.CurActUnit is nil")
        return targets
    end
    if self.CurActSkill == nil then
        Logger.LogError("GetCurrentSkillTarget: self.CurActSkill is nil")
        return targets
    end
    local zSkill = self.CurActSkill.ZSkill
    if zSkill == nil then
        Logger.LogError("GetCurrentSkillTarget : zSkill is nil")
        return targets
    end
    local friendGroup = self.CurActUnit:GetComponent("SsUnitMatrixComponent").Group
    -- 目标为敌人
    if zSkill.IsTargetEnemy == 1 then
        -- 单体技能
        if self.CurActUnit:GetComponent("SsUnitBattleComponent").IsCac or zSkill.EnemyRange == EnemyRange.Single then
            if self.CurTargetUnit == nil then
                Logger.LogError("GetCurrentSkillTarget : CurTargetUnit is nil")
                return targets
            end
            table.insert(targets, self.CurTargetUnit)
        elseif zSkill.EnemyRange == EnemyRange.Row then
            local targetRow = 0
            if zSkill.Distance == AtkDistance.Range or zSkill.IsAwaken == 1 then
                if self.CurTargetUnit == nil then
                    Logger.LogError("GetCurrentSkillTarget : CurTargetUnit is nil")
                    return targets
                end
                targetRow = self.CurTargetUnit:GetComponent("SsUnitMatrixComponent").Row
            elseif zSkill.Distance == AtkDistance.Close then
                local us = table.values(self:GetEnemyFrontRow(friendGroup))
                targetRow = us[1]:GetComponent("SsUnitMatrixComponent").Row
            end
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup ~= v:GetComponent("SsUnitMatrixComponent").Group and
                        v:GetComponent("SsUnitMatrixComponent").Row == targetRow and
                        GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
            end)
            table.insertto(targets,table.values(tb))
        elseif zSkill.EnemyRange == EnemyRange.Line then
            if self.CurTargetUnit == nil then

                Logger.LogError("GetCurrentSkillTarget : CurTargetUnit is nil")
                return targets
            end
            local targetLine = self.CurTargetUnit:GetComponent("SsUnitMatrixComponent").Line
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup ~= v:GetComponent("SsUnitMatrixComponent").Group and
                        v:GetComponent("SsUnitMatrixComponent").Line == targetLine and
                        GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
            end)
            table.insertto(targets,table.values(tb))
        elseif zSkill.EnemyRange == EnemyRange.All then
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup ~= v:GetComponent("SsUnitMatrixComponent").Group and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
            end)
            table.insertto(targets,table.values(tb))
        elseif zSkill.EnemyRange == EnemyRange.Random then
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup ~= v:GetComponent("SsUnitMatrixComponent").Group and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
            end)
            local randList = table.randtake(table.values(tb), self.CurActSkill.EnemyRandNum)
            table.insertto(targets,randList)
        end
    end
    -- 目标为友方
    if zSkill.IsTargetFriend == 1 then
        local friendRange = UIData.GetSkillAttr(SkillAttr.FriendRange, zSkill, self.CurActUnit.BattleCharacter)
        if friendRange == FriendRange.Single then
            if self.CurTargetUnit == nil then
                Logger.LogError("GetCurrentSkillTarget : CurTargetUnit is nil")
                return targets
            end
            table.insert(targets, self.CurTargetUnit)
        elseif friendRange == FriendRange.Self then
            table.insert(targets, self.CurActUnit)
        elseif friendRange == FriendRange.Row then
            if self.CurTargetUnit == nil then
                Logger.LogError("GetCurrentSkillTarget : CurTargetUnit is nil")
                return targets
            end
            local targetRow = self.CurTargetUnit:GetComponent("SsUnitMatrixComponent").Row
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and
                        v:GetComponent("SsUnitMatrixComponent").Row == targetRow and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            table.insertto(targets,table.values(tb))
        elseif friendRange == FriendRange.Line then
            if self.CurTargetUnit == nil then
                Logger.LogError("GetCurrentSkillTarget : CurTargetUnit is nil")
                return targets
            end
            local targetLine = self.CurTargetUnit:GetComponent("SsUnitMatrixComponent").Line
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and
                        v:GetComponent("SsUnitMatrixComponent").Line == targetLine and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            table.insertto(targets,table.values(tb))
        elseif friendRange == FriendRange.FrontRow then
            local targetRow = MatrixRow.Front
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and
                        v:GetComponent("SsUnitMatrixComponent").Row == targetRow and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            table.insertto(targets,table.values(tb))
        elseif friendRange == FriendRange.BackRow then
            local targetRow = MatrixRow.Back
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and
                        v:GetComponent("SsUnitMatrixComponent").Row == targetRow and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide() 
            end)
            table.insertto(targets,table.values(tb))
        elseif friendRange == FriendRange.FrontAndBackRow then
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and
                        (v:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Front or 
                                v:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Back) and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            table.insertto(targets,table.values(tb))
        elseif friendRange == FriendRange.All then
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            table.insertto(targets,table.values(tb))
        elseif friendRange == FriendRange.Random then
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            local randList = table.randtake(table.values(tb), self.CurActSkill.FriendRandNum)
            table.insertto(targets, randList)
        elseif friendRange == FriendRange.SelfAndRandom then
            local tb = table.choose(self.IdUnits,function (k,v)
                return self.__entity ~= v and
                        friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
                        --v:GetComponent("CharacterComponent"):IsNotDeadAndNotHide()
            end)
            local randList = table.randtake(table.values(tb), self.CurActSkill.FriendRandNum)
            table.insertto(randList, {self.__entity})
            table.insertto(targets, randList)
        end
    end

    if zSkill.ExtraEnemyRange ~= 0 then
        if zSkill.ExtraEnemyRange == EnemyRange.All then
            local IsEnemyGroupUnitsAllHide = self:IsEnemyGroupUnitsAllHide(friendGroup)
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup ~= v:GetComponent("SsUnitMatrixComponent").Group and 
                    v:GetComponent("CharacterComponent"):CanBeEnemyTargetCandidate(IsEnemyGroupUnitsAllHide)
            end)
            table.insertto(targets,table.values(tb))
        end
    end

    if zSkill.ExtraFriendRange ~= 0 then
        if zSkill.ExtraFriendRange == FriendRange.All then
            local tb = table.choose(self.IdUnits,function (k,v)
                return friendGroup == v:GetComponent("SsUnitMatrixComponent").Group and GetEnableUnitBySkill(v:GetComponent("CharacterComponent"), zSkill, true)
            end)
            table.insertto(targets,table.values(tb))
        elseif zSkill.ExtraFriendRange == FriendRange.Self then
            table.insert(targets, self.CurActUnit)
        end
    end

    return targets
end

function state:OnInit()
    state.battleComp = Game.Scene:GetComponent("BattleComponent")
end

-- CurActUnit  CurActSkill  AtkTargets  CurTargetUnit  
function state:OnEnter()
    if state.battleComp.UnitActing then 
        Logger.LogError("state.battleComp.UnitActing")
        return 
    end
    state.battleComp.UnitActing = true

    Game.Scene:GetComponent("BattleUIComponent"):OnUnitAct()
    
    if state.battleComp.CurActUnit == nil then
        Logger.LogError("UnitAct : state.battleComp.CurActSkill == nil")
        return
    end

    if state.battleComp.CurActSkill == nil then
        Logger.LogError("UnitAct : self.CurActSkill == nil")
        return
    end

    -- 关闭选择描边ChooseRing
    state.battleComp:ClearSelectedHighlight()
    -- 关闭UI技能选择
    Game.Scene:GetComponent("BattleUIComponent"):ClearSkills()
    -- 关闭当前行动单位Flag 
    state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent"):HighlightCurActOff()

    state.battleComp.CurActSkill.TargetUnits = GetUnitSkillActiveTargets(state.battleComp)
    if table.count(state.battleComp.CurActSkill.TargetUnits) <= 0 then
        Logger.LogError("--无有效攻击单位")
        state.battleComp.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    if state.battleComp.CurActUnit.IsPlayer then
        Game.Scene:GetComponent("PlayerBattleComponent"):PlayAnim(PlayerAnim.Atk1)
    end
    state.battleComp.CurActUnit:GetComponent("SsUnitBattleComponent").fsm:Switch(UnitBattleState.ActStart)
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state