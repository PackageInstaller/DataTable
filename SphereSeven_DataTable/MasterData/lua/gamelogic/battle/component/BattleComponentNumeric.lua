local this = require("GameLogic.Battle.Component.BattleComponent")

function this.GetComponent(self, atkUnit, hurtUnit)
    -- 攻击者
    self.atkUnit = atkUnit
    self.atkUnit_battle_unit_component = atkUnit:GetComponent("BattleUnitComponent")
    self.atkUnit_battle_component = atkUnit:GetComponent("SsUnitBattleComponent")
    self.atkUnit_character_component = atkUnit:GetComponent("CharacterComponent")
    self.atkUnit_numeric_component = atkUnit:GetComponent("NumericComponent")
    self.atkUnit_skill_component = atkUnit:GetComponent("SkillComponent")
    self.atkUnit_buff_component = atkUnit:GetComponent("BuffComponent")
    self.atkUnit_effect_component = atkUnit:GetComponent("SsUnitEffectComponent")
    self.atkUnit_sound_component = atkUnit:GetComponent("SsUnitSoundComponent")
    self.atkUnit_matrix_component = atkUnit:GetComponent("SsUnitMatrixComponent")
    -- 被攻击者
    self.hurtUnit = hurtUnit
    self.hurtUnit_battle_unit_component = hurtUnit:GetComponent("BattleUnitComponent")
    self.hurtUnit_battle_component = hurtUnit:GetComponent("SsUnitBattleComponent")
    self.hurtUnit_character_component = hurtUnit:GetComponent("CharacterComponent")
    self.hurtUnit_numeric_component = hurtUnit:GetComponent("NumericComponent")
    self.hurtUnit_skill_component = hurtUnit:GetComponent("SkillComponent")
    self.hurtUnit_buff_component = hurtUnit:GetComponent("BuffComponent")
    self.hurtUnit_animator_component = hurtUnit:GetComponent("SsUnitAnimatorComponent")
    self.hurtUnit_sound_component = hurtUnit:GetComponent("SsUnitSoundComponent")
    self.hurtUnit_voice_component = hurtUnit:GetComponent("SsUnitVoiceComponent")
    self.hurtUnit_matrix_component = hurtUnit:GetComponent("SsUnitMatrixComponent")
end

function this.ClampValueZero2One(self, val)
    if val < 0 then
        return 0
    end
    if val > 1 then
        return 1
    end
    return val
end

-- NO.1 能不能攻击（暂时没用）
function this.IsCanHurt(self, activeSkillResult)
    activeSkillResult.CanHurtByGAtk = true
    activeSkillResult.CanHurtBySkill = true
    local isCanHurt = true
    if self.hurtUnit_character_component.OnlyHurtByGeneraAtk > 0 then --只能受到来自普通攻击的伤害
        if not self.atkUnit_battle_component:CurActIsSkill(ActiveSkillType.GeneralAtk) then --不是普攻
            isCanHurt = false --不会受伤
            activeSkillResult.CanHurtByGAtk = false
        end
    elseif self.hurtUnit_character_component.OnlyHurtBySkill > 0 then --只能收到来自技能攻击的伤害
        if self.atkUnit_battle_component:CurActIsSkill(ActiveSkillType.GeneralAtk) then --是普攻
            isCanHurt = false --不会受伤
            activeSkillResult.CanHurtBySkill = false
        end
    end
    return isCanHurt
end

-- NO.2 判断闪避
function this.IsPry(self, activeSkillResult)
    -- 闪避计算点
    local isPry = false
    -- 优先看命中和闪避，如果技能效果必须命中
    if activeSkillResult.IsMustHit then
        isPry = false
    elseif self.hurtUnit_character_component.UnablePry > 0 then --无法闪避
        isPry = false
    elseif self.hurtUnit_character_component.MustPry > self.atkUnit_character_component.MustHit then --如果必定闪避并且行动单位必定命中
        isPry = true
    elseif self.hurtUnit_character_component.MustPry <  self.atkUnit_character_component.MustHit then
        isPry = false
    else
        local atkHit = self.atkUnit_numeric_component:Get(NumericType.Hit)
        local hurtPry = self.hurtUnit_numeric_component:Get(NumericType.Pry)
        local hitProb = 100 + atkHit - hurtPry
        if not BattleUtil.IsPctProbHit(hitProb) then
            isPry = true
            Logger.BattleLog("闪避了")
        end
    end
    -- 如果闪避了
    if isPry then
        self.hurtUnit_skill_component:OnPrySuccess(activeSkillResult) -- 技能调用闪避成功
        self.hurtUnit_buff_component:OnPrySuccess(activeSkillResult) -- buff调用闪避成功
        activeSkillResult.HitScale = 0.75
    end
    Logger.BattleLog("命中系数: " .. activeSkillResult.HitScale)
    activeSkillResult.IsPry = isPry
    return isPry
end

-- NO.3 判断暴击
function this.IsCri(self, activeSkillResult)
    if activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Real then
        Logger.BattleLog("真实伤害不暴击")
        return
    end

    local isCri = false
    if self.atkUnit_character_component.UnableCri > 0 or self.hurtUnit_character_component.UnableBeCri > 0 then --攻击方无法暴击 受击方无法被暴击
        isCri = false
    elseif self.atkUnit_character_component.MustCri > 0 or activeSkillResult.IsMustCri then --必定暴击
        isCri = true
    elseif self.hurtUnit_character_component.IsMustBeCri > 0 then --必定被暴击
        isCri = true
    elseif self.atkUnit_battle_component.IsCac and self.atkUnit_character_component.IsCacMustCri then
        --是反击并有反击带会心buff
        isCri = true
    else
        local cri = self.atkUnit_numeric_component:Get(NumericType.Cri)
        local antiCri = self.hurtUnit_numeric_component:Get(NumericType.AntiCri)
        local extraCri = activeSkillResult.ExtraCri
        local criProb = cri + extraCri - antiCri
        Logger.BattleLog("暴击结算，攻方暴击率: " .. cri .. " 受方抗暴率: " .. antiCri .. " 额外暴击率: " .. extraCri .. " 最终暴击率: " .. criProb)

        if BattleUtil.IsPctProbHit(criProb) then
            isCri = true
            Logger.BattleLog("暴击了")
        else
            Logger.BattleLog("没有暴击")
        end
    end
    
    activeSkillResult.IsCri = isCri
    if isCri then
        self.atkUnit_skill_component:OnCri(self.hurtUnit, activeSkillResult)
        self:GetCriScale(activeSkillResult)
    end
end

-- NO.7 获取最终伤害加成
-- function this.GetFinalDamageScale(self, activeSkillResult)
--     local finalDamageScale = self.atkUnit_numeric_component:Get(NumericType.FinalDamage)/100 - 1
--     local finalHurtScale = self.hurtUnit_numeric_component:Get(NumericType.FinalHurt)/100 - 1
--     if self.atkUnit_battle_component:CurActSkillIsGeneralAtk() then
--         local d = self.atkUnit_numeric_component:Get(NumericType.GAtkFinalDamage)/100 - 1 
--         local h = self.hurtUnit_numeric_component:Get(NumericType.GAtkFinalHurt)/100 - 1
--         finalDamageScale = finalDamageScale + d
--         finalHurtScale = finalHurtScale + h
--     else
--         local d = self.atkUnit_numeric_component:Get(NumericType.SkillFinalDamage)/100 - 1
--         local h = self.hurtUnit_numeric_component:Get(NumericType.SkillFinalHurt)/100 - 1
--         finalDamageScale = finalDamageScale + d
--         finalHurtScale = finalHurtScale + h
--     end
--     if self.atkUnit_battle_component.IsCac then
--         local d = self.atkUnit_numeric_component:Get(NumericType.CacFinalDamage)/100 - 1
--         local h = self.hurtUnit_numeric_component:Get(NumericType.CacFinalHurt)/100 - 1
--         finalDamageScale = finalDamageScale + d
--         finalHurtScale = finalHurtScale + h
--     end
--     if activeSkillResult.IsCri then
--         local d = self.atkUnit_numeric_component:Get(NumericType.CriFinalDamage)/100 - 1 
--         local h = self.hurtUnit_numeric_component:Get(NumericType.CriFinalHurt)/100 - 1
--         finalDamageScale = finalDamageScale + d
--         finalHurtScale = finalHurtScale + h
--     end
--     -- 对debuff有上害加成
--     -- if self.atkUnit_character_component.IsDebuffAddHitPct > 0 and self.hurtUnit_buff_component:HasDeBuff() then
--     --     activeSkillResult.FinalDamage = activeSkillResult.FinalDamage * (1 + self.atkUnit_character_component.IsDebuffAddHitPct / 100)
--     -- end

--     activeSkillResult.FinalDamageScale = 1 + finalDamageScale - finalHurtScale + activeSkillResult.ExtraFinalDamagePct / 100
--     Logger.BattleLog("最终伤害系数: " .. activeSkillResult.FinalDamageScale)
-- end

-- NO.9 吸血反伤挫志
function this.SpecialDamage(self, activeSkillResult)
    if activeSkillResult.FinalDamage > 0 then
        --吸血
        if not (self.hurtUnit_character_component.ImmuneSuckHp > 0) and activeSkillResult.IsSuckHp then
            local hp = math.modf(activeSkillResult.FinalDamage * activeSkillResult.SuckHpScale)
            if hp > 0 then
                activeSkillResult.SuckHp = hp
            end
        end
        --反伤
        local reflectPct = self.hurtUnit_numeric_component:Get(NumericType.ReflectDamage)
        if self.atkUnit_character_component.ImmuneAllDamage <= 0 and self.atkUnit_character_component.ImmuneReflectDamage <= 0 and reflectPct > 0 then
            if reflectPct > 50 then reflectPct = 50 end -- 最高50%
            local hp = math.modf(activeSkillResult.FinalDamage * reflectPct / 100)
            if hp > 0 then
                activeSkillResult.ReflectHp = hp
            end
        end
    end
    -- 即死 
    if activeSkillResult.IsSecKill and self.hurtUnit_character_component.ImmuneAllDeBuff == 0 and self.hurtUnit_character_component.ImmuneAllDeBuff2 == 0 and self.hurtUnit_character_component.ImmuneSecKill <= 0 then --即死计算点
        activeSkillResult.FinalDamage = self.hurtUnit_numeric_component:Get(NumericType.Hp)
        activeSkillResult.FinalDamage = math.ceil(activeSkillResult.FinalDamage)
        activeSkillResult.HasSecKill = true
    end
    if not (self.hurtUnit_character_component.ImmuneDemoralize > 0) and activeSkillResult.IsDemoralize then
        activeSkillResult.HasDemoralize = true
    end
end

-- NO.10 反击判断 1.反击无法增加能量 2.反击无法被反击 3.反击单位死亡，则反击效果取消 4.反击无法连击 5.无加成时，每回合只能反击一次
function this.IsCac(self, activeSkillResult)
    if not self.atkUnit_battle_component.IsCac then
        if self.hurtUnit_character_component.IsCacUnlimited > 0 or self.atkUnit_character_component.CacLimitCur > 0 then
            local isCac = false
            if self.hurtUnit_character_component.UnableCac > 0 then
                isCac = false
            elseif activeSkillResult.IsUnableCac then
                isCac = false
            elseif self.hurtUnit_character_component.IsMustCac > 0 and not activeSkillResult.IsUnableCac then
                isCac = true
            elseif self.hurtUnit_character_component.IsMustCac == 0 and activeSkillResult.IsUnableCac then
                isCac = false
            else
            end
            if isCac then
                self.hurtUnit_battle_component.CacUnit = self.atkUnit
            end
        end
    end
end

-- NO.11 对敌buff
function this.EnemyBuff(self, activeSkillResult)
    if self.hurtUnit_character_component:IsImmuneAllDeBuff() then
        return
    end
    local buffs = {}
    table.walk(activeSkillResult.Buffs,function (_,v)
        if self.hurtUnit_character_component:IsImmuneDeBuff(v.BuffId) then
            table.insert(buffs, v)
        else
            local eacc = self.atkUnit_numeric_component:Get(NumericType.EAcc)
            local erist = self.hurtUnit_numeric_component:Get(NumericType.ERist)
            local probability = 1 + (eacc - erist) / 100
            -- local probability = v.Hit * (1 + eacc - erist) / 100
            if ss.IsRandHit(math.min(probability, 0.85)) then
                table.insert(buffs, v)
            end
        end
    end)
    activeSkillResult.Buffs = buffs
end

-- 总体伤害计算, 技能为单位
function this.NumericHurt(self)
    local skill = self.CurActSkill
    if skill == nil then
        Logger.LogError("NumericHurt: skill is nil")
        return
    end
    local zSkill = skill.ZSkill
    if skill.OnUseActiveSkill == nil then
        Logger.LogError("NumericHurt: OnUseActiveSkill is nil")
        return
    end
    Logger.BattleLog("Skill id: " .. skill.SkillId)
    
    -- 技能对单位的攻击结果
    skill.UnitResults = {}
    -- 技能对单位逐个攻击
    table.walk(self.CurActSkill.TargetUnits, function (k, v)
        self:GetComponent(self.CurActUnit, v)
        self.atkUnit_skill_component:BeforeSkillEffect(self.hurtUnit)
        local activeSkillResult = skill:OnUseActiveSkill(v) --获取技能结果
        Logger.BattleLog("攻击力: " .. self.atkUnit:GetComponent("NumericComponent"):Get(NumericType.Atk))

        activeSkillResult.MultistageNum = skill.MultistageNum
        skill.UnitResults[v.UID] = activeSkillResult
        if zSkill.IsTargetFriend == 1 or zSkill.ExtraFriendRange ~= 0 and self.atkUnit_matrix_component.Group == self.hurtUnit_matrix_component.Group then
            if activeSkillResult.HealHp > 0 then
                BattleCalculator.CalcHealHp(activeSkillResult, self.atkUnit, self.hurtUnit)
                -- local healScale = self.atkUnit_numeric_component:Get(NumericType.HealEffect) / 100
                -- local healRecScale = self.hurtUnit_numeric_component:Get(NumericType.HealRecEffect) / 100
                -- local finalHealHp = math.modf(activeSkillResult.HealHp * (1 + healScale + healRecScale))
                -- if finalHealHp < 0 then finalHealHp = 0 end
                -- activeSkillResult.HealHp = finalHealHp
            end
        -- 判断技能能否攻击到敌方
        elseif zSkill.IsTargetEnemy == 1 or zSkill.ExtraEnemyRange ~= 0 and self.atkUnit_matrix_component.Group ~= self.hurtUnit_matrix_component.Group then
            self:AtkEnemy(activeSkillResult)
        end
        self.atkUnit_skill_component:AfterSkillEffect(self.hurtUnit)
    end)
end

function this.UnitSelfBuff(self, activeSkillResult)

end

function this.PreCalcBuff(self, activeSkillResult)

end

-- function this.GetElementalCounter(self, activeSkillResult)
--     local atkUnitElement = self.atkUnit_battle_unit_component.Element
--     local hurtUnitElement = self.hurtUnit_battle_unit_component.Element
--     local elementalScale = 0
--     local Z_BattleElementalCounter = Z_BattleElementalCounter[atkUnitElement]
--     if Z_BattleElementalCounter == nil then return end
--     for i = 1, #Z_BattleElementalCounter.CounterType do
--         if Z_BattleElementalCounter.CounterType[i] == hurtUnitElement then
--             elementalScale = Z_BattleElementalCounter.CounterValue[i]
--             break
--         end
--     end
--     activeSkillResult.ElementalScale = 1 + elementalScale / 100
--     Logger.BattleLog("属性克制系数: " .. elementalScale)
-- end

function this.GetCriScale(self, activeSkillResult)
    if activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Real then
        return
    end
    if activeSkillResult.IsCri then
        local criDamage = self.atkUnit_numeric_component:Get(NumericType.CriDamage)
        local extraCriDamage = activeSkillResult.ExtraCriDamage
        local criDamageScale = (criDamage + extraCriDamage) / 100

        Logger.BattleLog("暴击伤害结算, " .. " 攻方暴击伤害" .. criDamage .. " 额外暴击伤害" .. extraCriDamage .. " 最终暴击系数" .. criDamageScale)
        activeSkillResult.CriScale = criDamageScale
    end
end

-- function this.GetBaseScale(self, activeSkillResult)
--     if activeSkillResult.FeixiaoDamage.Type == nil then 
--         return
--     end
--     local def = 0
--     if activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Physical then
--         def = self.hurtUnit_numeric_component:Get(NumericType.Def)* (1 + activeSkillResult.ExtraDefPct / 100)
--         Logger.BattleLog("物防: " .. def)
--     elseif activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Magic then
--         def = self.hurtUnit_numeric_component:Get(NumericType.MagicDef) * (1 + activeSkillResult.ExtraMagicDefPct / 100)
--         Logger.BattleLog("魔防: " .. def)
--     end

--     if activeSkillResult.FeixiaoDamage.Type ~= BattleDamageType.Real then
--         Logger.BattleLog("无视的防御系数: " .. activeSkillResult.ExtraIgnoreDef)
--         activeSkillResult.BaseScale = 300 / ( 300 + def * (1 - activeSkillResult.ExtraIgnoreDef / 100))
--         Logger.BattleLog("防御系数: " .. activeSkillResult.BaseScale)
--     else
--         Logger.BattleLog("真实伤害无视防御")
--         activeSkillResult.BaseScale = 1
--     end
-- end

function this.PostCalcBuff(self, activeSkillResult)

end

-- function this.ExtraDamage(self, activeSkillResult)

-- end

-- function this.CalcDamage(self, activeSkillResult)
--     local atkOutput = activeSkillResult.FeixiaoDamage.Value + activeSkillResult.ExtraDamage
--     local baseScale = activeSkillResult.BaseScale
--     local HitScale = activeSkillResult.HitScale
--     local elementalScale = activeSkillResult.ElementalScale
--     local criScale = activeSkillResult.CriScale
--     local finalScale = activeSkillResult.FinalDamageScale
--     local fluctuationScale = BattleUtil.GetRandomFloat(95, 105) / 100
--     local ultimateScale = activeSkillResult.UltimateScale

--     -- 伤害输出*(300/(300+被攻击方对应防御))*[最终伤害系数]*[命中参数]*[暴击参数]*[属性克制参数]*[伤害波动参数]
--     activeSkillResult.FinalDamage = atkOutput * baseScale * finalScale * HitScale * criScale * elementalScale * fluctuationScale * ultimateScale

--     Logger.BattleLog("最终伤害: " .. activeSkillResult.FinalDamage * self.CurActSkill.MultistageNum)
--     -- feixiao:临时特殊处理...
--     if self.CurActSkill.SkillId == 10273 then
--         activeSkillResult.FinalDamage = activeSkillResult.FinalDamage / 6
--     elseif self.CurActSkill.SkillId == 10313 then
--         activeSkillResult.FinalDamage = activeSkillResult.FinalDamage / 3
--     elseif self.CurActSkill.SkillId == 10363 then
--         activeSkillResult.FinalDamage = activeSkillResult.FinalDamage * 1.5
--     end    
--     activeSkillResult.FinalDamage = math.modf(activeSkillResult.FinalDamage)
-- end

function this.AtkEnemy(self, activeSkillResult)
    self:UnitSelfBuff(activeSkillResult)
    self:PreCalcBuff(activeSkillResult)

    if not self:IsCanHurt(activeSkillResult) then return end

    if activeSkillResult.FeixiaoDamage.Type ~= nil then     
        self.atkUnit_skill_component:BeforeHit(activeSkillResult, self.hurtUnit) --技能组件调用受击
        self.atkUnit_buff_component:BeforeHit(activeSkillResult) --buff组件调用

        self:BeforeHitEvent(activeSkillResult, self.atkUnit, self.hurtUnit)

        self.hurtUnit_skill_component:BeforeBeHit(activeSkillResult, self.atkUnit)
        self.hurtUnit_buff_component:BeforeBeHit(activeSkillResult, self.atkUnit)

        -- 闪避效果要在闪避前处理
        self:IsPry(activeSkillResult)

        if not activeSkillResult.IsPry then
            self:IsCri(activeSkillResult)
        end

        self.atkUnit_skill_component:OnHit(activeSkillResult, self.hurtUnit) --技能组件调用受击
        self.atkUnit_buff_component:OnHit(activeSkillResult) --buff组件调用    

        BattleCalculator.GetBaseScale(activeSkillResult, self.atkUnit, self.hurtUnit)
        BattleCalculator.GetElementalCounter(activeSkillResult, self.atkUnit, self.hurtUnit)
        BattleCalculator.ExtraDamage(activeSkillResult, self.atkUnit, self.hurtUnit)
        BattleCalculator.GetFinalDamageScale(activeSkillResult, self.atkUnit, self.hurtUnit)
        BattleCalculator.CalcDamage(activeSkillResult, self.atkUnit, self.hurtUnit)
        self:SpecialDamage(activeSkillResult)

        self:OnDamageEvent(self.atkUnit, self.hurtUnit, activeSkillResult)
        self.atkUnit_skill_component:AfterDamage(activeSkillResult, self.hurtUnit)
    
        self.hurtUnit_skill_component:AfterHurt(activeSkillResult, self.atkUnit) --技能组件调用受击
        self.hurtUnit_buff_component:AfterHurt(activeSkillResult, self.atkUnit)
    end

    if not activeSkillResult.IsPry then
        self:PostCalcBuff(activeSkillResult)
        self:EnemyBuff(activeSkillResult)
    end

    self:IsCac(activeSkillResult)
end

-- 受伤表现效果
function this.OnHurtEffect(self, atkUnit, hurtUnit)
    local skill = self.CurActSkill
    if skill == nil then
        Logger.LogError("Hurt: skill is nil")
        return
    end
    local zSkill = skill.ZSkill
    if skill.OnUseActiveSkill == nil then
        Logger.LogError("Hurt: OnUseActiveSkill is nil")
        return
    end
    
    self:GetComponent(atkUnit, hurtUnit)
    
    -- 获取这个对象的被技能攻击的结果
    local activeSkillResult = skill.UnitResults[hurtUnit.UID]

    if activeSkillResult == nil then
        Logger.LogError(string.format("activeSkillResult not find, act unit: %s, skill: %d, target unit: %s", 
                    atkUnit.Name, self.CurActSkill.SkillId, hurtUnit.Name))
        return
    end

    local unit_battle_component = hurtUnit:GetComponent("SsUnitBattleComponent")
    local sc = 1.5 - unit_battle_component.radius
    if sc < 0 then sc = 0 end
    if IsNull(hurtUnit.GameObject) then
        print("OnHurt:IsNull(self.__entity.GameObject)")
        return
    end
    hurtUnit.GameObject.transform:DOShakeScale(0.6, Vector3.New(sc * 0.1,0,0)):OnComplete(function ()
        hurtUnit.GameObject.transform.localScale = hurtUnit.Scale
    end)
    -- 技能移除buff
    table.walk(activeSkillResult.RemoveBuffs, function(k, v)
        self.hurtUnit_buff_component:RemoveOneBuff(v)
    end)
    -- 施法对象是队友（注意：TODO攻击一个对象，不同攻击帧有不同效果时）
    if zSkill.IsTargetFriend == 1 or zSkill.ExtraFriendRange ~= 0 and self.atkUnit_matrix_component.Group == self.hurtUnit_matrix_component.Group then
        self:AtkFriendEffect(activeSkillResult, skill)
    elseif zSkill.IsTargetEnemy == 1 or zSkill.ExtraEnemyRange ~=0 and self.atkUnit_matrix_component.Group ~= self.hurtUnit_matrix_component.Group then
        self:AtkEnemyEffect(activeSkillResult, skill)
    end
end

function this.AtkFriendEffect(self, activeSkillResult, skill)
    table.insert(skill.Completes,0) --技能段数增加
    -- 技能没有敌人对象时
    if skill.ZSkill.IsTargetEnemy == 0 then
        self.atkUnit_effect_component:CoPlayHurt(skill.ZSkill.HurtEfx, self.hurtUnit:GetPosition()) -- 播放施法特效
        self.atkUnit_sound_component:CoPlaySkl(skill.ZSkill.HurtSound) -- 播放音效
    end
    -- 个别英雄需要对己方播放受击
    if skill.ZSkill.FriendHit == 1 then
        self.hurtUnit_animator_component:Play(SsUnitMotionType.Hit)
        self.hurtUnit_voice_component:CoPlayHit(skill.ZSkill.TypeName)
    end

    -- 队友对自己使用了复活技能
    if activeSkillResult.IsRevive then
        self.hurtUnit_battle_component:Revive(skill)
    end
    -- 队友对自己使用了加血技能
    if activeSkillResult.HealHp > 0 then
        self.hurtUnit_battle_component:HealHp(activeSkillResult.HealHp, activeSkillResult.IsRevive)
    end

    skill:OnHitEffect()

    if activeSkillResult.FeixiaoDispel.Type ~= nil then
        if self.hurtUnit_character_component.ImmuneDispel > 0 then
            -- 免疫驱散
        else
            local isDebuff = false
            if activeSkillResult.FeixiaoDispel.Type == BattleDispelType.Buff then
                isDebuff = false
            elseif activeSkillResult.FeixiaoDispel.Type == BattleDispelType.Debuff then
                isDebuff = true                    
            end
            local count = activeSkillResult.FeixiaoDispel.Count
            if count > 0 then
                for i = 1, count do
                    self.hurtUnit_buff_component:RandomRemoveOneBuff(isDebuff)
                end
            elseif count == -1 then
                self.hurtUnit_buff_component:RemoveAllBuff(isDebuff)
            end
        end
    end
    
    if table.count(activeSkillResult.Buffs) > 0 and self.hurtUnit.IsPlayer and skill.ZSkill.FriendRange == 3 then
        Game.Scene:GetComponent("PlayerBattleComponent"):PlayAnim(PlayerAnim.Buff)
    end
    -- 队友对自己使用了添加各种buff的技能
    table.walk(activeSkillResult.Buffs,function (_,v)
        if ss.IsRandHit(v.Hit) then
            if v.NumericType > NumericType.Max or v.NumericVal ~= 0 then
                self.hurtUnit_buff_component:CreateBuff(v.BuffId, skill.SkillId, self.atkUnit, self.hurtUnit, v.TurnCount, v.IsCannotDispelled, v.NumericType, v.NumericVal, v.IsCannotMultiply, v.Data)
            else
                self.hurtUnit_buff_component:CreateBuff(v.BuffId, skill.SkillId, self.atkUnit, self.hurtUnit, v.TurnCount, v.IsCannotDispelled, nil, nil, v.isCannotMultiply, v.Data)
            end
        end
    end)
    --activeSkillResult.Buffs = {}
end

function this.AtkEnemyEffect(self, activeSkillResult, skill)
    if not activeSkillResult.CanHurtByGAtk then
        table.insert(skill.Completes, 0)
        if self.hurtUnit_battle_component.is_hurt == 0 then
            self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(28), HUDTextType.Grey, HUDTextType.Tip)
        end
        return
    end
    if not activeSkillResult.CanHurtBySkill then
        table.insert(skill.Completes, 0)
        if self.hurtUnit_battle_component.is_hurt == 0 then
            self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(29), HUDTextType.Grey, HUDTextType.Tip)
        end
        return
    end
    if activeSkillResult.IsPry then
        table.insert(skill.Completes, 0)
        self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(31), HUDTextType.Grey, HUDTextType.Tip)
        self.hurtUnit_sound_component:CoPlayCommon(CommonSoundPath.prySound) -- 闪避音效
        -- 闪避后回血
        if activeSkillResult.HealHp > 0 then
            self.hurtUnit_battle_component:HealHp(activeSkillResult.HealHp, activeSkillResult.IsRevive)
        end
        -- 闪避成功获得buff
        if self.hurtUnit_battle_component.is_pry == 0 then
            table.walk(activeSkillResult.Buffs,function (_,v)
                local zBuff = Z_Buff[v.BuffId]
                if zBuff.IsDeBuff == 0 then -- 闪避后只获得buff
                    local turnCount = v.TurnCount
                    if v.NumericType > NumericType.Max or v.NumericVal ~= 0 then
                        self.hurtUnit_buff_component:CreateBuff(v.BuffId,skill.SkillId,self.atkUnit,self.hurtUnit,turnCount,v.IsCannotDispelled,v.NumericType,v.NumericVal)
                    else
                        self.hurtUnit_buff_component:CreateBuff(v.BuffId,skill.SkillId,self.atkUnit,self.hurtUnit,turnCount,v.IsCannotDispelled)
                    end
                end
            end)
        end
        self.hurtUnit_battle_component.is_pry = self.hurtUnit_battle_component.is_pry + 1 --闪避次数+1
        -- return
    end

    table.insert(skill.Completes, activeSkillResult.FinalDamage)

    -- 扎尔击中
    skill:OnHitEffect()

    -- activeSkillResult.FinalDamage = math.modf(activeSkillResult.FinalDamage * (1 + math.random(-5, 5) / 100))
    -- if activeSkillResult.FinalDamage <= 0 then
    --     activeSkillResult.FinalDamage = math.random(1, 10)
    -- end

    if activeSkillResult.HasDamage then
        local damage = 0
        activeSkillResult.HasDamage, damage = self.hurtUnit_battle_component:DealDamage(self.atkUnit, DamageData.CreateFromActiveSkillResult(activeSkillResult))
        table.insert(activeSkillResult.RealHpDamages, damage)
        activeSkillResult.TotalRealHpDamage = activeSkillResult.TotalRealHpDamage + damage
    end
    -- if activeSkillResult.HasSecKill then
    --     if self.hurtUnit_battle_component.is_hurt == 0 then
    --         activeSkillResult.FinalDamage = self.hurtUnit_numeric_component:Get(NumericType.Hp)
    --         activeSkillResult.FinalDamage = math.ceil(activeSkillResult.FinalDamage)
    --         self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(51), HUDTextType.Purple, HUDTextType.Tip)
    --         local damage = self.hurtUnit_battle_component:ReduceHp(activeSkillResult.FinalDamage, activeSkillResult.FeixiaoDamage.Type)
    --         self.hurtUnit_battle_component:GenHUDText(damage, HUDTextType.Purple, HUDTextType.Dmg)
    --     end
    -- elseif activeSkillResult.HasDamage then
    --     if self.hurtUnit_character_component:IsImmuneDamage(activeSkillResult.FeixiaoDamage.Type, true, activeSkillResult.HasIgnoreShield) then
    --         if activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Physical then
    --             self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(37), HUDTextType.Grey, HUDTextType.Tip)
    --         elseif activeSkillResult.FeixiaoDamage.Type == BattleDamageType.Magic then
    --             self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(38), HUDTextType.Grey, HUDTextType.Tip)
    --         end

    --         Logger.BattleLog("免疫伤害")
    --         activeSkillResult.HasDamage = false
    --     else
    --         local damage = self.hurtUnit_battle_component:ReduceHp(activeSkillResult.FinalDamage, activeSkillResult.FeixiaoDamage.Type)
    --         if activeSkillResult.IsCri or activeSkillResult.IsFrenzy then                
    --             self.hurtUnit_battle_component:GenHUDText(damage, HUDTextType.Red, HUDTextType.Dmg)                
    --         else
    --             if activeSkillResult.IsPry then
    --                 self.hurtUnit_battle_component:GenHUDText(damage, HUDTextType.Grey, HUDTextType.Dmg)
    --             else
    --                 self.hurtUnit_battle_component:GenHUDText(damage, HUDTextType.Grey, HUDTextType.Dmg)
    --             end
    --         end
    --     end
    -- end

    if activeSkillResult.SuckHp > 0 then
        self.atkUnit_battle_component:HealHp(activeSkillResult.SuckHp)
    end

    if activeSkillResult.HasDamage and 
                activeSkillResult.FeixiaoLifeSteal.Value ~= nil and 
                activeSkillResult.FeixiaoLifeSteal.Value ~= 0 then
        local hp = math.modf(activeSkillResult.FinalDamage * activeSkillResult.FeixiaoLifeSteal.Value)
        self.atkUnit_battle_component:HealHp(hp)
        Logger.BattleLog("吸血: " .. hp)
    end

    -- if activeSkillResult.ReflectHp > 0 then
    --     self.atkUnit_battle_component:ReduceHp(activeSkillResult.ReflectHp)
    --     if self.hurtUnit_battle_component.is_hurt == 0 then
    --         self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(50), HUDTextType.Red, HUDTextType.Tip)
    --     end
    -- end
    if activeSkillResult.IsBlock then
        self.hurtUnit_battle_component:GenHUDText(LangUtil.GetSysLang(47), HUDTextType.Grey, HUDTextType.Tip)
        self.hurtUnit_sound_component:CoPlayCommon(CommonSoundPath.blkSound)
    end
    if self.hurtUnit_battle_component.is_hurt == 0 then
        if activeSkillResult.IsMustHit then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(30), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.IsDevastate then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(32), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.HasIgnoreDef then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(33), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.HasIgnoreShield then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(34), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.IsSuoLife then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(35), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.IsFinalHit then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(48), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.IsFrenzy then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(49), HUDTextType.Brown, HUDTextType.Tip)
        end
        if activeSkillResult.HasDemoralize then
            self.atkUnit_battle_component:GenHUDText(LangUtil.GetSysLang(56), HUDTextType.Brown, HUDTextType.Tip)
        end
        
        -- table.walksort(activeSkillResult.Damages, function (ak, bk) return ak < bk end,function (k,v)
        --     local damagePath, isImmuneDamage = self.hurtUnit_character_component:IsImmuneDamage(k, true, activeSkillResult.HasIgnoreShield)
        --     if isImmuneDamage then
        --         self.hurtUnit_battle_component:GenHUDText(damagePath, HUDTextType.Grey, HUDTextType.Tip)
        --     end
        -- end)
        if self.atkUnit_character_component.AtkBuff ~= nil then
            table.walk(self.atkUnit_character_component.AtkBuff,function(_,v)
                if v ~= nil then
                    local zBuff = Z_Buff[v.id]
                    if self.hurtUnit_character_component:IsImmuneDeBuff(v.id) then
                        if self.hurtUnit_battle_component.is_hurt == 0 then
                            if string.IsNullOrEmpty(zBuff.ImmuneBuff) then
                                Logger.LogError("can not find ImmuneBuff image by buffId: "..v.id)
                            end
                            self.hurtUnit_battle_component:GenHUDText(zBuff.ImmuneBuff, HUDTextType.Grey, HUDTextType.Tip)
                        end
                    else
                        self.hurtUnit_buff_component:CreateBuff(v.id, skill.ZSkill.Id, self.atkUnit, self.hurtUnit, v.turn, false, nil,v.num)
                    end
                end
            end)
        end
        if activeSkillResult.IsDispel then
            if self.hurtUnit_character_component.ImmuneDispel > 0 then
                -- 免疫驱散
            else
                self.hurtUnit_buff_component:RandomRemoveOneBuff()
            end
        end
        if activeSkillResult.IsPurify then
            if self.hurtUnit_character_component.ImmunePurify > 0 then
                -- 免疫净除
            else
                self.hurtUnit_buff_component:RemoveAllBuff()
            end
        end
        if activeSkillResult.FeixiaoDispel.Type ~= nil then
            if self.hurtUnit_character_component.ImmuneDispel > 0 then
                -- 免疫驱散
            else
                local isDebuff = false
                if activeSkillResult.FeixiaoDispel.Type == BattleDispelType.Buff then
                    isDebuff = false
                elseif activeSkillResult.FeixiaoDispel.Type == BattleDispelType.Debuff then
                    isDebuff = true                    
                end
                local count = activeSkillResult.FeixiaoDispel.Count
                if count > 0 then
                    for i = 1, count do
                        self.hurtUnit_buff_component:RandomRemoveOneBuff(isDebuff)
                    end
                elseif count == 0 then
                    self.hurtUnit_buff_component:RemoveAllBuff(isDebuff)
                end
            end
        end
        self.hurtUnit_voice_component:CoPlayHit(skill.ZSkill.TypeName)  --播放受击语音
    end

    if self.hurtUnit_numeric_component:Get(NumericType.Hp) <= 0 and not self.hurtUnit_character_component.IsDeading then
        self.hurtUnit_animator_component.keepHit = true
    else
        self.hurtUnit_animator_component:ResetAnimator(SsUnitMotionType.Hit)
        if self.hurtUnit_battle_component.is_hurt == 0 then
            table.walk(activeSkillResult.Buffs,function (_,v)
                local zBuff = Z_Buff[v.BuffId]
                if self.hurtUnit_character_component:IsImmuneDeBuff(v.BuffId) then
                    if self.hurtUnit_battle_component.is_hurt == 0 then
                        if string.IsNullOrEmpty(zBuff.ImmuneBuff) then
                            Logger.LogError("can not find ImmuneBuff image by buffId: "..v.BuffId)
                        end
                        self.hurtUnit_battle_component:GenHUDText(zBuff.ImmuneBuff, HUDTextType.Grey, HUDTextType.Tip)
                    end
                else
                    local turnCount = v.TurnCount
                    if v.NumericType > NumericType.Max or v.NumericVal ~= 0 then
                        self.hurtUnit_buff_component:CreateBuff(v.BuffId,skill.SkillId,self.atkUnit,self.hurtUnit,turnCount,v.IsCannotDispelled,v.NumericType,v.NumericVal)
                    else
                        self.hurtUnit_buff_component:CreateBuff(v.BuffId,skill.SkillId,self.atkUnit,self.hurtUnit,turnCount,v.IsCannotDispelled)
                    end
                end
            end)
        end
    end

    self.atkUnit_effect_component:CoPlayHurt(skill.ZSkill.HurtEfx, self.hurtUnit.HitPosPosition) -- 播放受击特效
    self.atkUnit_sound_component:CoPlaySkl(skill.ZSkill.HurtSound) --播放技能伤害音效

    local battle_com = Game.Scene:GetComponent("BattleCameraComponent")
    if battle_com then battle_com:ShakeCamera(skill.ZSkill) end--摄像机震动
    self.hurtUnit_battle_component.is_hurt = self.hurtUnit_battle_component.is_hurt + 1 --受伤次数
    -- 连续受伤表现 每隔0.3秒做一受伤动作
    if skill.ZSkill.ShowHitNum ~= nil and skill.ZSkill.ShowHitNum > 1 then
        coroutine.start(function ()
            for i = 1, skill.ZSkill.ShowHitNum, 1 do
                coroutine.waitforseconds(0.3)
                self.hurtUnit_animator_component:Play(SsUnitMotionType.Hit)
            end
        end)
    end
    self.hurtUnit_animator_component:Play(SsUnitMotionType.Hit) --播放受击动作
end

return this