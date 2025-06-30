local this = require("GameLogic.Battle.Component.BattleComponent")

function this.OnAwake(self)
    self.CacQueue = Queue.New() --当前行动之后的反击队列，优先级最高
    self.ExtraSkillQueue = Queue.New() -- 额外技能队列
    self.SuoLifeQueue = Queue.New() --索命队列
    self.AutoGAtkQueue = Queue.New() --自动普攻队列
    self.BattleArraySkillQueue = Queue.New() --释放战阵技能队列
    self.TempSaveQueue = Queue.New() --暂存当前行动单位的队列，例如轮到一个角色选择技能，但是点击了释放战阵技能，此时当前角色放到此队列，并先处理战阵技能队列
    self.SuoLifeTempSaveQueue = Queue.New() -- 竞速被索命
    self.HighReadyQueue = Queue.New() --高优先级队列，特殊渠道入队，例如特殊buff一回合行动两次
    self.MediumReadyList = {} --按速度属性来决定行动顺序的列表，中优先级，例如特殊buff每回合开始第一个行动
    self.LowReadyQueue = Queue.New() --低优先级队列，通过速度条竞速来入队

    self.CurActUnit = nil --当前行动的单位
    self.CurAtkGroup = nil --当前攻击队伍
    self.CurTargetUnit = nil --当前目标单位
    self.CurActSkill = nil -- 当前行动的单位技能

    --self.CurCacUnit = nil -- 当前反击单位
    self.cur_selected_unit_id = 0 --当前被选择的单位Id

    self.CurTurnUnit = nil
end

-- N0.0设置当前行动单位 --
function this.SetCurAct(self, actUnit, actGroup)
    self.CurActUnit = actUnit
    self.CurAtkGroup = actGroup
end

-- NO.1判断当前行动单位是否可以行动，无法行动就跳过，可以行动才会进入释放技能或AI --
function this.IsCurActUnitEnableAct(self)
    if self.CurActUnit == nil then
        Logger.LogError("IsCurActUnitEnableAct: self.CurActUnit is nil???")
        return false
    end
    local character_component = self.CurActUnit:GetComponent("CharacterComponent")
    local hasEnableSkill = function()
        local skills = self.CurActUnit:GetComponent("SkillComponent").ActiveSkills
        local usableSkills = table.choose(skills, function (k, v)
            local targets = self:GetAllTargetsByCurrentSkill(v)
            return table.count(targets) > 0
        end)
        return table.count(usableSkills) > 0
    end
    if character_component.IsDead or
            character_component.UnableAct > 0 or
            not hasEnableSkill() then -- 当前单位可能死亡了
        return false
    end
    return true
end

function this.IsSkillEnable(self, skill)
    local character_component = self.CurActUnit:GetComponent("CharacterComponent")
    local skillComponent = self.CurActUnit:GetComponent("SkillComponent")
    if (skill.ZSkill.SkillId == skillComponent.GeneralAtkId and character_component.UnableGeneraAtk > 0) or
            (skill.ZSkill.SkillId ~= skillComponent.GeneralAtkId and character_component.UnableSkill > 0) then
        return false
    end 
    if not self.IsIgnoreCooldown and skill.LeftCooldownTurn > 0 then
        return false
    end
    return true
end

-- NO.2.1获取当前技能能够攻击的单位 --
function this.GetAllTargetsByCurrentSkill(self, skill)
    local targets = {}
    if skill == nil then
        Logger.LogError("GetAllTargetsByCurrentSkill".." : skill is nil")
        return targets
    end
    if self.CurActUnit == nil then
        Logger.LogError("GetAllTargetsByCurrentSkill".." : CurActUnit is nil")
        return targets
    end
    if not self:IsSkillEnable(skill) then
        return targets
    end
    table.walk(self.IdUnits,function (_, u)
        if self:CheckCurrentSkillToUnit(u, skill.ZSkill) then
            table.insert(targets, u)
        end
    end)
    return targets
end

-- NO.2.2技能是否可以攻击某个单位
function this.CheckCurrentSkillToUnit(self, unit, zSkill)
    -- 无效的话，是什么类型原因
    local actGroup = self.CurActUnit:GetComponent("SsUnitMatrixComponent").Group --行动单位的阵营
    local unit_character_component = unit:GetComponent("CharacterComponent") --数值组件
    local targetGroup = unit:GetComponent("SsUnitMatrixComponent").Group --选中单位的阵营

    local isValid = false
    -- 技能可以攻击敌方（主动）、己方（主动）、敌方（主动）和己方（被动）
    -- 有敌方则攻击敌方，没敌方则攻击己方
    if zSkill.IsTargetEnemy == 1 and targetGroup ~= actGroup then
        -- 角色死亡或者隐身，则技能对该单位无效
        if unit_character_component.IsDead then
            isValid = false
            return isValid
        end
                
        -- 近战技能只能攻击前排
        if zSkill.Distance == AtkDistance.Close then -- 近程
            if table.any(self:GetEnemyFrontRow(actGroup),function(v) return v.UID == unit.UID end) then
                isValid = true
            end
        else --远程
            local IsEnemyGroupUnitsAllHide = self:IsEnemyGroupUnitsAllHide(actGroup)
            return unit:GetComponent("CharacterComponent"):CanBeEnemyTargetCandidate(IsEnemyGroupUnitsAllHide)
        end
        --目标为友方单位
    elseif zSkill.IsTargetEnemy == 0 and zSkill.IsTargetFriend == 1 and targetGroup == actGroup then
        if zSkill.IsReviveSkill == 1 then
            isValid = unit_character_component.IsDead
            return isValid
        end
        if unit_character_component.IsDead then
            isValid = false
            return isValid
        end
        local friendRange = UIData.GetSkillAttr(SkillAttr.FriendRange, zSkill, unit.BattleCharacter)
        if friendRange == FriendRange.FrontRow then
            if unit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Front then
                isValid = true
            else
                isValid = false
            end
        elseif friendRange == FriendRange.BackRow then
            if unit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Back then
                isValid = true
            else
                isValid = false
            end
        elseif friendRange == FriendRange.FrontAndBackRow then
            if unit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Front or unit:GetComponent("SsUnitMatrixComponent").Row == MatrixRow.Back then
                isValid = true
            else
                isValid = false
            end
        else
            isValid = true
        end
    end
    return isValid
end

-- NO.AI自动战斗:角色技能才会进来
function this.AutoAI(self, isGAtk)
    -- 进入AI了，行动对象可不能没有
    if self.CurActUnit == nil then
        Logger.LogError("AutoAI:self.CurActUnit == nil")
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end

    -- AI一个技能
    local curSkill = self:GetAISkill(isGAtk)

    -- 当前角色没有可用的技能
    if curSkill == nil then
        Logger.LogError("AutoAI:curskill == nil ???")
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end

    -- 设置成当前行动技能
    self:SetCurActSkill(curSkill, true)

    local zSkill = curSkill.ZSkill
    self.CurActUnit.UseSkill = zSkill

    -- AI一个目标,释放技能
    self:DoSkill(self:GetAITarget(zSkill))
end

-- NO.AI1已知当前行动的角色，获取一个行动的技能
function this.GetAISkill(self, isGAtk)
    -- 列出可能技能
    local curSkill --随机一个可用技能
    local reSkill  --是否有复活技能
    local hpSkill  --是否有回血技能
    local zySkill  --是否有增益技能
    local akSKill  --是否有攻击技能
    local awakenSkill --是否有觉醒技能
    local group = self.CurActUnit:GetComponent("SsUnitMatrixComponent").Group --获取行动单位阵营

    local isAuto = 0
    if self.CurActUnit.IsPlayer then
        isAuto = self.AutoSkill
    end

    -- 如果强制是普攻
    if isGAtk or isAuto == 1 then
        curSkill = self.CurActUnit:GetComponent("SkillComponent"):GetActiveSkill() --获取当前技能
        return curSkill
    end
    local skills = self.CurActUnit:GetComponent("SkillComponent").ActiveSkills --获取所有主动技能
    -- 技能顺序：复活技能 > 觉醒技能 > 加血技能 > buff技能 > 技能 > 普攻
    local usableSkills = table.choose(skills,function (k, v) --选择出可使用的技能  优先复活技能
        -- 判断该技能有没有可以攻击的单位
        local targets = self:GetAllTargetsByCurrentSkill(v)
        if table.count(targets) <= 0 then return false end
        -- 复活技能
        if v.ZSkill.IsReviveSkill == 1 then
            reSkill = v
            return true
        end
        -- 友方加血和增益
        if v.ZSkill.IsTargetFriend == 1 then
            if v.ZSkill.IsAddHP == 1 then
                hpSkill = v
            else
                zySkill = v
            end
        end
        -- 攻击敌方
        if v.ZSkill.IsTargetEnemy == 1 then
            akSKill = v
        end
        -- 觉醒技能
        if v.ZSkill.IsAwaken == 1 then
            awakenSkill = v
        end
        return true
    end)

    -- 没有可用的技能，跳过
    if table.count(usableSkills) <= 0 then
        return nil
    end

    local list = table.values(usableSkills)
    -- 随机一个可用技能
    curSkill = table.randget(list)
    -- 最终决定优先使用哪个技能
    if #list <= 1 then
        return curSkill
    end
    
    -- 判断敌方是不是都快死了 IsHPE => false 
    local isEnemyHealth = table.any(self.IdUnits,function (v)
        local nc = v:GetComponent("NumericComponent")
        return v:GetComponent("SsUnitMatrixComponent").Group ~= group and nc:Get(NumericType.Hp) / nc:Get(NumericType.MaxHp) > 0.2
    end)
    
    -- 优先级1：对方角色的血量是否都低于20%，则优先攻击，否则就用复活技能
    if reSkill ~= nil and isEnemyHealth then
        return reSkill
    end
    
    -- 优先级2：加血
    if hpSkill ~= nil and isEnemyHealth then
        if hpSkill.ZSkill.FriendRange == 6 then -- 对自己释放
            -- 单体加血，如果血量少于80%则优先加血  
            local nc = self.CurActUnit:GetComponent("NumericComponent")
            local isSelfHealth = nc:Get(NumericType.Hp) / nc:Get(NumericType.MaxHp) >= 0.8
            if not isSelfHealth then
                return hpSkill
            end
        else
            --群体加血，如果有队友血量少于80%则优先加血
            local isFriendWeak = table.any(self.IdUnits,function (v)
                if v:GetComponent("SsUnitMatrixComponent").Group == group then
                    local nc = v:GetComponent("NumericComponent")
                    if nc:Get(NumericType.Hp)/nc:Get(NumericType.MaxHp) < 0.8 and not v:GetComponent("CharacterComponent").IsDead then
                        return true
                    end
                end
                return false
            end)
            if isFriendWeak then
                return hpSkill
            end
        end
    end

    -- 优先级3：觉醒技能
    if awakenSkill ~= nil then
        return awakenSkill
    end
    
    -- 优先级4：己方buff
    if zySkill ~= nil and isEnemyHealth then
        --上次使用过buff就攻击
        if self.CurActUnit.UseSkill ~= nil and self.CurActUnit.UseSkill.IsTargetFriend == 1 then
        else
            return zySkill
        end
    end
    
    -- 优先级5：随便用
    if akSKill ~= nil then
        return akSKill
    end
    return curSkill
end

-- NO.AI2已知当前行动的技能，获取一个行动的目标
function this.GetAITarget(self, zSkill)
    if self.CurActUnit == nil then
        Logger.LogError("GetAITarget:self.CurActUnit == nil")
        return nil
    end
    if zSkill.IsNeedChoose ~= 1 then
        return nil
    end
    local group = self.CurActUnit:GetComponent("SsUnitMatrixComponent").Group --获取行动单位阵营
    local target = nil
    if zSkill.IsTargetEnemy == 1 then -- 对敌方释放
        if zSkill.Distance == AtkDistance.Close then --近程
            target = table.randget(table.values(self:GetEnemyFrontRow(group))) --随机敌方第一行一个单位
        else --随机一个敌方阵营未死亡并且没有隐藏的单位
            local IsEnemyGroupUnitsAllHide = self:IsEnemyGroupUnitsAllHide(group)
            local chooseUnits = table.choose(self.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group ~= group and v:GetComponent("CharacterComponent"):CanBeEnemyTargetCandidate(IsEnemyGroupUnitsAllHide) end)
            local curhp
            local bhp
            table.walk(chooseUnits,function(_,v)
                if target == nil then
                    target = v
                    curhp = v:GetComponent("NumericComponent"):Get(NumericType.Hp)
                else
                    bhp = v:GetComponent("NumericComponent"):Get(NumericType.Hp)
                    if curhp > bhp then
                        curhp = bhp
                        target = v
                    end
                end
            end)
            if math.random(1,10)<=3 then
                target = table.randget(table.values(chooseUnits))
            end
        end
    elseif zSkill.IsTargetFriend == 1 then --对友方释放
        if zSkill.IsReviveSkill == 1 then --如果是复活技能
            --随机一个我方死亡的单位
            local chooseUnits = table.choose(self.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == group and 
                                v:GetComponent("CharacterComponent").IsDead end)
            target = table.randget(table.values(chooseUnits))
        else
            --随机一个我方未死亡并且没有隐藏的单位
            local chooseUnits = table.choose(self.IdUnits,function (k,v) return v:GetComponent("SsUnitMatrixComponent").Group == group and 
                                not v:GetComponent("CharacterComponent").IsDead end)
            local curhp
            local bhp
            table.walk(chooseUnits,function(_,v)
                if target==nil then
                    target=v
                    curhp=v:GetComponent("NumericComponent"):Get(NumericType.Hp)
                else
                    bhp=v:GetComponent("NumericComponent"):Get(NumericType.Hp)
                    if curhp>bhp then
                        curhp=bhp
                        target=v
                    end
                end
            end)
            if math.random(1,10) <= 4 then
                target = table.randget(table.values(chooseUnits))
            end
        end
    end
    return target
end

-- NO.3AI技能，或者UI选择技能 --
function this.SetCurActSkill(self, unitSkill, isAuto)
    if self.CurActUnit == nil and unitSkill ~= nil then
        Logger.LogError("SetCurActSkill:self.CurActUnit == nil")
        return
    end

    self.CurActSkill = unitSkill
    
    -- 取消技能选择
    if self.CurActSkill == nil and self.fsm.curState.stateName == BattleState.WaitChooseTarget then
        self.fsm:Switch(BattleState.WaitChooseSkill)
        return
    end

    -- if self.CurActSkill ~= nil then
    --     Logger.LogError("SetCurActSkill : self.CurActSkill ~= nil")
    --     return
    -- end

    -- AI可以自动选择目标,然后自动攻击
    if isAuto then return end

    -- 释放角色技能
    if self.CurActSkill ~= nil then
        if self.CurActSkill.ZSkill.IsNeedChoose == 1 then
            self.fsm:Switch(BattleState.WaitChooseTarget)
        else
            self:DoSkill()
        end
    end
end

-- NO.4自动普攻和反击是可以跳出正常步骤直接开干，强制释放技能时需要做安全检测 --
function this.DoSkillForce(self, target) 
    if target == nil then
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    local target_cc = target:GetComponent("CharacterComponent")
    if target_cc.IsDead or target_cc.IsHide == 1 then
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    if self.CurActUnit == nil then
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    if self.CurActSkill == nil then
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    if target == nil then
        print("--强制连续普攻或者索命或者反击，--必须要有目标，--否则跳过行动")
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    local character_component = self.CurActUnit:GetComponent("CharacterComponent")
    if character_component.IsDead or character_component.UnableAct > 0 then
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    if not self:CheckCurrentSkillToUnit(target, self.CurActSkill.ZSkill) then
        self.fsm:Switch(BattleState.UnitActEnd)
        return
    end
    self:DoSkill(target)
end

-- NO.4对目标使用技能 --
function this.DoSkill(self, choose_unit)
    if self.CurAtkGroup ~= nil then
        self.fsm:Switch(BattleState.UnitAct)
        return
    end

    if self.CurActUnit:GetComponent("CharacterComponent").Paralysis > 0 then
        if BattleUtil.IsPctProbHit(35) then
            -- self.CurActUnit:GetComponent("SsUnitBattleComponent"):GenHUDText(LangUtil.GetSysLang(24), HUDTextType.Brown, HUDTextType.Tip)
            self.CurActUnit:GetComponent("SsUnitBattleComponent"):BuffEffect(LangUtil.GetSysLang(3125), true)
            Logger.BattleLog("麻痹状态下，35%概率行动失败")
            self.fsm:Switch(BattleState.UnitActEnd)
            return
        end
    end

    -- 常规选择技能或AI技能情况
    if self.CurActSkill == nil then
        Logger.LogError("DoSkill : self.CurActSkill == nil")
    else
        -- 设置目标单位
        self.CurTargetUnit = choose_unit

        if self.CurActSkill ~= nil then
            if self.CurActSkill.ZSkill.IsNeedChoose == 1 and self.CurTargetUnit == nil then
                Logger.LogError("DoSkill:self.CurActSkill.ZSkill.IsNeedChoose == 1 and self.CurTargetUnit == nil")
            end
        end

        -- 保险措施，角色死亡还进来了
        local character_component = self.CurActUnit:GetComponent("CharacterComponent")
        if character_component.IsDead or character_component.UnableAct > 0 then
            self.fsm:Switch(BattleState.UnitActEnd)
            return
        end
        
        self.fsm:Switch(BattleState.UnitAct)
    end
end

-- 星石购买，全部复活
function this.PlayerReviveAll(self)
    self.reviveTimes = self.reviveTimes - 1
    self:ReSetBattleSkip()
    table.walk(self.IdUnits,function (_,v)
        if v:GetComponent("SsUnitMatrixComponent").Group == MatrixGroup.Friend then
            local sub=v:GetComponent("SsUnitBattleComponent")
            sub:Revive()
            sub:HealHp(v:GetComponent("CharacterComponent"):GetHealHpBase(), true)
        end
    end)
    coroutine.start(function ()
        coroutine.waitforseconds(0.3)
        -- 清空行动过后的单位和技能
        self:ClearCurActUnit()
        self.fsm:Switch(BattleState.QueueAct)
    end)
end

-- 死亡特写
function this.DeadClose(self, callback)
    local tb = table.choose(self.IdUnits,function (k,v)
        return not v:GetComponent("CharacterComponent").IsDead
                and not v:GetComponent("CharacterComponent").IsDeading -- 僵尸状态不能死
                --and v:GetComponent("CharacterComponent").IsHide == 0
                and v:GetComponent("NumericComponent"):Get(NumericType.Hp) == 0 end) --获取HP为0但仍未判定死亡的角色
    if #table.keys(tb) > 0 then
        local list = self:SortByRowAndLine(table.values(tb)) --排序
        coroutine.waitforseconds(0.5)
        table.walk(list,function (k, v)  --播放死亡动画
            v.IsPlayingDead = true
            v:GetComponent("SsUnitBattleComponent"):PlayDeadAnim(function () v.IsPlayingDead = false end)
        end)
        coroutine.waitforseconds(2) -- 等待两秒死亡动画，小心死亡动画没播放完
        coroutine.waituntil(function () return table.all(list, function (val) return not val.IsPlayingDead end) end)
        table.walk(list,function (k, v)  --判定角色死亡
            v:GetComponent("SsUnitBattleComponent"):OnDead()
        end)
        coroutine.waitforframes(1)
        table.walk(list,function (k, v)  --死亡后
            v:GetComponent("SkillComponent"):AfterDeadAnim()
        end)
        if callback ~= nil then
            callback(tb)
        end
    end
end

function this.IsUnitTurnStart(self)
    if self.CurActType == ActType.Speed or
    self.CurActType == ActType.Sinhaeng or
    self.CurActType == ActType.Storm
    then
        return true
    end

    return false
end

function this.IsUnitTurnEnd(self)
    if self.CacQueue:size() > 0 or
    self.ExtraSkillQueue:size() > 0 or
    self.SuoLifeQueue:size() > 0 or
    self.AutoGAtkQueue:size() > 0 or --连击队列大于0（索命，霸者雄心被动，拿破仑战魂）
    self.TempSaveQueue:size() > 0 or --
    self.SuoLifeTempSaveQueue:size() > 0 or
    self.CurTurnUnit == nil
    then
        return false
    end

    return true
end

function this.HasNotHidedFriend(self, unit)
    local group = unit:GetComponent("SsUnitMatrixComponent").Group
    return table.any(self.IdUnits,function (v)
        if v:GetComponent("SsUnitMatrixComponent").Group == group and
            not v:GetComponent("CharacterComponent").IsDead and
            v ~= unit and
            v:GetComponent("CharacterComponent").IsHide == 0 then
            return true
        end
        return false
    end)
end

function this.IsEnemyGroupUnitsAllHide(self, friendGroup)
    local enemyUnits = table.choose(self.IdUnits,function (k,v)
        return v:GetComponent("SsUnitMatrixComponent").Group ~= friendGroup and
                not v:GetComponent("CharacterComponent").IsDead
    end)

    return table.all(enemyUnits,function (v)
        if v:GetComponent("CharacterComponent").IsHide == 0 then
            return false
        end
        return true
    end)
end

-- 清空行动过后的单位和技能
function this.ClearCurActUnit(self)
    self:SetCurAct(nil, nil)
    self:SetCurActSkill(nil, nil)
    self.CurTargetUnit = nil
end

return this