local this = require("GameLogic.Battle.Component.SsUnitBattleComponent")

--减少生命值
function this.ReduceHp(self, hp, damageType)
    hp = math.modf(hp)
    local reduceHpData = ReduceHpData.New(hp, damageType)
    -- reduceHpData.Hp = hp
    -- reduceHpData.DamageType = damageType

    self.battle_component:BeforeHpReduceEvent(self.__entity, reduceHpData)

    local buffComponent = self.__entity:GetComponent("BuffComponent")

    if reduceHpData.DamageType ~= nil and reduceHpData.DamageType ~= BattleDamageType.Real then
        local physicalShieldBuff = buffComponent:GetBuff(BattleBuffType.PhyShield)
        local magicShieldBuff = buffComponent:GetBuff(BattleBuffType.MagicShield)
        local universalShieldBuff = buffComponent:GetBuff(BattleBuffType.UniversalShield)

        if reduceHpData.DamageType == BattleDamageType.Physical then
            if physicalShieldBuff ~= nil then
                reduceHpData.Hp = physicalShieldBuff:OnReduceHp(reduceHpData.Hp)
            end
        elseif reduceHpData.DamageType == BattleDamageType.Magic then
            if magicShieldBuff ~= nil then
                reduceHpData.Hp = magicShieldBuff:OnReduceHp(reduceHpData.Hp)
            end
        end

        if reduceHpData.Hp > 0 and universalShieldBuff ~= nil then
            reduceHpData.Hp = universalShieldBuff:OnReduceHp(reduceHpData.Hp)
        end
    end

    self.numeric_component:Dec(NumericType.Hp, reduceHpData.Hp)
    Logger.BattleLog("扣除血量: " .. reduceHpData.Hp)

    local unitHp = self.numeric_component:Get(NumericType.Hp)
    if unitHp <= 0 then
        if self.character_component.Immortal > 0 then
            self.numeric_component:Set(NumericType.Hp, 1)
        else
            self.numeric_component:Set(NumericType.Hp, 0)
        end
    end
    self.__entity:GetComponent("SkillComponent"):OnHpChange()
    self.battle_component:OnReduceHpEvent(self.__entity, reduceHpData)
    self.unit_ui_component:UpdateHpBar()

    if not self.__entity.IsPlayer then
        self.battle_component.playerScore = self.battle_component.playerScore + reduceHpData.Hp
    end
    return reduceHpData.Hp
end

-- 造成伤害
function this.DealDamage(self, sourceUnit, damageData)
    if sourceUnit:GetComponent("CharacterComponent").IsDead then
        return false, 0
    end

    local damage = 0
    if damageData.HasSecKill then
        if self.is_hurt == 0 then
            damageData.Damage = self.numeric_component:Get(NumericType.Hp)
            damageData.Damage = math.ceil(damageData.Damage)
            self:GenHUDText(LangUtil.GetSysLang(51), HUDTextType.Purple, HUDTextType.Tip)
            damage = self:ReduceHp(damageData.Damage, damageData.DamageType)
            self:GenHUDText(damage, HUDTextType.Purple, HUDTextType.Dmg)
        end

        return true, damage
    end

    if self.character_component:IsImmuneDamage(damageData.DamageType, true, damageData.HasIgnoreShield) then
        if damageData.DamageType == BattleDamageType.Physical then
            self:GenHUDText(LangUtil.GetSysLang(37), HUDTextType.Grey, HUDTextType.Tip)
        elseif damageData.DamageType == BattleDamageType.Magic then
            self:GenHUDText(LangUtil.GetSysLang(38), HUDTextType.Grey, HUDTextType.Tip)
        end

        Logger.BattleLog("免疫伤害")
        return false, damage
    else
        damage = damageData.Damage
        local damageShare = self.character_component:GetDamageShare()
        if damageShare ~= nil then
            local sharedDamage = damage * damageShare.SharedPercent / 100
            damage = math.max(0, damage - sharedDamage)

            local sourceUnitSsUnitBattleComponet = damageShare.SourceUnit:GetComponent("SsUnitBattleComponent")
            sharedDamage = sourceUnitSsUnitBattleComponet:ReduceHp(sharedDamage, damageData.DamageType)
            sourceUnitSsUnitBattleComponet:GenHUDText(sharedDamage, HUDTextType.Grey, HUDTextType.Dmg)
        end

        damage = self:ReduceHp(damage, damageData.DamageType)
        if damageData.IsCri then
            self:GenHUDText(damage, HUDTextType.Red, HUDTextType.Dmg)
        else
            if damageData.IsPry then
                self:GenHUDText(damage, HUDTextType.Grey, HUDTextType.Dmg)
            else
                self:GenHUDText(damage, HUDTextType.Grey, HUDTextType.Dmg)
            end
        end

        sourceUnit:GetComponent("SkillComponent"):AfterDealDamage(damageData, damage, self.__entity)
    end

    return true, damage
end

-- 造成伤害
-- 用于非主动技能, 会套用伤害计算公式、加成, 但是无法再触发额外逻辑
function this.Hurt(self, sourceUnit, damageType, value)
    local activeSkillResult = ActiveSkillResult.New()
    activeSkillResult.FeixiaoDamage =
    {
        Type = damageType,
        Value = value
    }
    activeSkillResult.MultistageNum = 1

    BattleCalculator.GetBaseScale(activeSkillResult, sourceUnit, self.__entity)
    BattleCalculator.GetElementalCounter(activeSkillResult, sourceUnit, self.__entity)
    BattleCalculator.ExtraDamage(activeSkillResult, sourceUnit, self.__entity)
    BattleCalculator.GetFinalDamageScale(activeSkillResult, sourceUnit, self.__entity)
    BattleCalculator.CalcDamage(activeSkillResult, sourceUnit, self.__entity)

    self:DealDamage(sourceUnit, DamageData.CreateFromActiveSkillResult(activeSkillResult))
end

--回复生命值
function this.HealHp(self, hp, ignoreZeroHp)
    hp = math.modf(hp)
    if self.character_component.UnableRecHeal > 0 or self.character_component.IsDeading then
        return
    end
    -- 没死亡，但是血量为0也不能回血
    if not ignoreZeroHp and self.numeric_component:Get(NumericType.Hp) <= 0 then
        return
    end
    -- 死亡不许回血，必须先复活
    if self.character_component.IsDead then
        return
    end
    self.numeric_component:Inc(NumericType.Hp,hp)
    if self.numeric_component:Get(NumericType.Hp) > self.numeric_component:Get(NumericType.MaxHp) then
        self.numeric_component:Set(NumericType.Hp,self.numeric_component:Get(NumericType.MaxHp))
    end
    self.__entity:GetComponent("SkillComponent"):OnHpChange()
    self.__entity:GetComponent("SkillComponent"):OnHeal()
    self.battle_component:OnHealEvent(self.__entity, hp)
    self.unit_ui_component:UpdateHpBar()
    self:GenHUDText(math.modf(hp), HUDTextType.Green, HUDTextType.Dmg)
end

-- --新手指引受到伤害调用
-- function this.OnGuideHurtEvent(self)
--     local guide= Game.Scene:GetComponent("GuideComponent")
--     local GuideComplete, GuideStep ,run = guide:GetCurrentData()
--     if  GuideStep>15 and  GuideComplete==0 and self.__entity.IsPlayer and table.indexof(guide.GuideAppointStep,17) then
--         guide:AppointGuide(17)
--         local battle_component = Game.Scene:GetComponent("BattleComponent")
--         guide.BattleSpeed = battle_component.BattleSpeed
--         Game.Scene:GetComponent("BattleComponent"):SetBattleSpeed(BattleSpeedMode.Pause)
--     end
-- end

-- 被治疗
-- 用于非主动技能, 会套用伤害计算公式、加成, 但是无法再触发额外逻辑
function this.Heal(self, healValue, sourceUnit)
    local activeSkillResult = ActiveSkillResult.New()
    activeSkillResult.HealHp = healValue

    BattleCalculator.CalcHealHp(activeSkillResult, sourceUnit, self.__entity)
    self:HealHp(activeSkillResult.HealHp, false)
end

function this.AddDebuff(self, buffId, fromSkillId, srcUnit, turnCount, isCannotDispelled, numericType, numericVal, isCannotMultiply, data)
    if self.character_component:IsImmuneAllDeBuff() then
        return
    end

    if self.character_component:IsImmuneDeBuff(buffId) then
        return
    else
        local eacc = srcUnit:GetComponent("NumericComponent"):Get(NumericType.EAcc)
        local erist = self.numeric_component:Get(NumericType.ERist)
        local probability = 1 + (eacc - erist) / 100
        if ss.IsRandHit(math.min(probability, 0.85)) then
            self.__entity:GetComponent("BuffComponent"):CreateBuff(buffId, fromSkillId, srcUnit, self.__entity, turnCount, isCannotDispelled, numericType, numericVal, isCannotMultiply, data)
        end
    end
end

--- 被技能攻击之后
function this.AfterBeHitAll(self, atkUnit, activeSkillResult)
    self.__entity:GetComponent("SkillComponent"):AfterBeHitAll(atkUnit, activeSkillResult)
    self.__entity:GetComponent("BuffComponent"):AfterBeHitAll(atkUnit, activeSkillResult)
end

---所有伤害过后
function this.AfterAllHurt(self, atkUnit, activeSkillResult)
    -- 用于回避一次移除buff
    if self.battle_component.CurActUnit ~= nil and self.__entity:GetComponent("SsUnitMatrixComponent").Group ~= self.battle_component.CurActUnit:GetComponent("SsUnitMatrixComponent").Group then
        self.__entity:GetComponent("BuffComponent"):AfterAllHurtByNothing(atkUnit, activeSkillResult)
    end

    if self.is_hurt > 0 then
        self.__entity:GetComponent("SkillComponent"):AfterAllHurt(atkUnit, activeSkillResult)
        self.__entity:GetComponent("BuffComponent"):AfterAllHurt(atkUnit, activeSkillResult)
        self.is_hurt = 0
    end

    if self.is_pry > 0 then
        self.__entity:GetComponent("SkillComponent"):AfterAllHurtByPry(atkUnit, activeSkillResult)
        self.__entity:GetComponent("BuffComponent"):AfterAllHurtByPry(atkUnit, activeSkillResult)
        self.is_pry = 0
    end
end

function this.AfterOneTargetAllHit(self, targetUnit, activeSkillResult)
    self.__entity:GetComponent("SkillComponent"):AfterOneTargetAllHit(targetUnit, activeSkillResult)
    self.__entity:GetComponent("BuffComponent"):AfterOneTargetAllHit(targetUnit, activeSkillResult)
end

--播放死亡动画
function this.PlayDeadAnim(self, callback)
    coroutine.start(function ()
        if not self.__entity.IsPlayer then
            Game.Scene:GetComponent("PlayerBattleComponent"):PlayAnim(PlayerAnim.Atk2)
        else
            Game.Scene:GetComponent("PlayerBattleComponent"):PlayAnim(PlayerAnim.Death)
        end
        self.unit_voice_component:CoPlayDead()
        coroutine.waitforseconds(0.3)
        self.unit_effect_component:OnDead()
        coroutine.waitforseconds(0.1)
        local smrs = self.__entity.GameObject:GetComponentsInChildren(typeof(CS.UnityEngine.Renderer))
        local particles = self.__entity.GameObject:GetComponentsInChildren(typeof(ParticleSystemRenderer))
        for i = 1, 0, -0.1 do
            table.csenu(smrs,function (v)
                if i <= 0.1 then
                    v.gameObject.layer = self.battle_component.HideLayer
                else
                    v.material:SetColor("_Color",Color.New(1,1,1, i - 0.1))
                    --v.material:SetFloat("_Cutoff", i - 0.1)
                end
            end)
            table.csenu(particles,function (v)
                v.material:SetColor("_Color",Color.New(1,1,1, i))
                if i <= 0.1 then
                    v.gameObject.layer = self.battle_component.HideLayer
                end
            end)
            coroutine.waitforseconds(0.03)
        end
        table.csenu(smrs,function (v)
            v.material:SetColor("_Color",Color.New(1,1,1, 0))
        end)
        table.csenu(smrs,function (v)
            v.material:SetFloat("_Cutoff", 0.9)
        end)
        coroutine.waitforframes(1)
        if callback then callback() end
    end)
end

--处理死亡逻辑
function this.OnDead(self)
    self.character_component.IsDead = true
    self.character_component.OnceDead = true
    self:ClearExtraMove()
    table.walk(self.battle_component.IdUnits, function (k, v)
        local sbc = v:GetComponent("SsUnitBattleComponent")
        if sbc.CacUnit == self.__entity then
            sbc.CacUnit = nil
            sbc.IsCac = false
        end

        if sbc.ExtraSkillTarget == self.__entity then
            self:ClearExtraSkill()
        end
    end)
    self.unit_animator_component:ResetAnimator(SsUnitMotionType.Hit)
    self.__entity.GameObject:GetComponent(typeof(CS.UnityEngine.CapsuleCollider)).enabled = false
    self.__entity.GameObject:GetComponent(typeof(CS.UnityEngine.SphereCollider)).enabled = true
    coroutine.start(function ()
        self.__entity:GetComponent("SsUnitUIComponent"):OnDead()
        -- 先清buff 后面技能可能有死亡事件
        self.__entity:GetComponent("BuffComponent"):OnDead()
        self.__entity:GetComponent("SkillComponent"):OnDead()
        table.walk(self.battle_component.IdUnits, function (k, v)
            if v ~= self.__entity and not v:GetComponent("CharacterComponent").IsDead then
                v:GetComponent("SkillComponent"):OnDeadEvent(self.__entity)
                if v:GetComponent("SsUnitMatrixComponent").Group == self.__entity:GetComponent("SsUnitMatrixComponent").Group then
                    v:GetComponent("SkillComponent"):OnFriendDead()
                end
            end
        end)

        if not self.__entity.IsPlayer then
            Game.Scene:GetComponent("BattleComponent").KilEnemyNum = Game.Scene:GetComponent("BattleComponent").KilEnemyNum+1
            local battleComponent = Game.Scene:GetComponent("BattleComponent")
            local monsterId = self.__entity.BattleCharacter.Id
            if battleComponent.Statistics.EnemyRecords[monsterId] == nil then
                battleComponent.Statistics.EnemyRecords[monsterId] = 1
            else
                battleComponent.Statistics.EnemyRecords[monsterId] = battleComponent.Statistics.EnemyRecords[monsterId] + 1
            end
        else
            local posId = self.__entity:GetComponent("BattleUnitComponent").PosId
            local againstComponent = Game.Scene:GetComponent("AgainstComponent")
            local formation = againstComponent.PlayerFormation

            if formation.support_unit ~= nil and #formation.units == 6 and formation.isUsesupport == false then
                local unitData = {}
                unitData.isMonster = false
                unitData.unit = formation.support_unit
                unitData.unit.formation_postion = posId
                unitData.batchNum = 1
                formation.isUsesupport = true
                formation.firstDeadCharacter = self.__entity
                formation.firstDeadCharacterPosId = posId
                local ssUnit = BattleUtil.GenSsUnit(Game.Scene:GetComponent("BattleComponent"), unitData, true)
                self.battle_component.IdUnits[posId] = ssUnit
                formation.supportUid = ssUnit.UID
                ssUnit:GetComponent("SsUnitUIComponent"):BuildSrAvatar()
                ssUnit:GetComponent("NumericComponent"):Set(NumericType.HpBase, ssUnit:GetComponent("NumericComponent"):Get(NumericType.MaxHp))
                ssUnit:GetComponent("SkillComponent"):OnBattleStart()
            elseif formation.support_unit ~= nil and #formation.units == 6 and formation.isUsesupport == true then
                self.battle_component.IdUnits[formation.firstDeadCharacterPosId] = formation.firstDeadCharacter
            elseif formation.support_unit ~= nil and posId == formation.firstDeadCharacterPosId then
                self.__entity = nil
                self.battle_component.IdUnits[formation.firstDeadCharacterPosId] = formation.firstDeadCharacter

            end
        end
    end)
end

-- 设置角色透明度
function this.SetUnitColorAlpha(self, a)
    local layer = a > 0 or self.battle_component.SsUnitLayer and self.battle_component.HideLayer
    table.csenu(self.__entity.GameObject:GetComponentsInChildren(typeof(SkinnedMeshRenderer)),function (v)
        table.csenu(v.materials, function (val)
            val:SetColor("_Color",Color.New(1,1,1, a))
        end)
        v.gameObject.layer = layer
    end)
    table.csenu(self.__entity.GameObject:GetComponentsInChildren(typeof(ParticleSystemRenderer)),function (v)
        table.csenu(v.materials, function (val)
            val:SetColor("_Color",Color.New(1,1,1, a))
        end)
        v.gameObject.layer = layer
    end)
end

---复活
function this.Revive(self, skill)
    local againstComponent = Game.Scene:GetComponent("AgainstComponent")
    local formation = againstComponent.PlayerFormation
    if formation.support_unit ~= nil then
        if self.__entity.UID == formation.supportUid then
            return
        end
    end

    if self.__entity.IsPlayer then
        Game.Scene:GetComponent("PlayerBattleComponent"):PlayAnim(PlayerAnim.Resurrected)
    end
    coroutine.start(function ()
        local delay = 0
        if skill ~= nil then
            delay = skill.ZSkill.DelayHitDuration or 0
        end
        coroutine.waitforseconds(delay)
        self.unit_effect_component:OnRevive()
        self:SetUnitColorAlpha(1)
    end)
    self.unit_animator_component:ResumeAnimator()
    self.unit_animator_component:Play(SsUnitMotionType.Idle)
    self.__entity.GameObject:GetComponent(typeof(CS.UnityEngine.CapsuleCollider)).enabled = true
    self.__entity.GameObject:GetComponent(typeof(CS.UnityEngine.SphereCollider)).enabled = false
    self.unit_ui_component:OnRevive()
    self.unit_voice_component:CoPlayReLife()
    self.__entity:GetComponent("SkillComponent"):OnRevive()
    self.__entity:GetComponent("BuffComponent"):OnRevive()
    self.character_component.IsDead = false
    table.walk(self.battle_component.IdUnits, function (k, v)
        if v ~= self.__entity and v:GetComponent("SsUnitMatrixComponent").Group == self.__entity:GetComponent("SsUnitMatrixComponent").Group then
            v:GetComponent("SkillComponent"):OnFriendRevive()
        end
    end)
    self.__entity:GetComponent("SsUnitUIComponent"):SetHpBar(true)
    self:GenHUDText(LangUtil.GetSysLang(20), HUDTextType.Green, HUDTextType.Tip)
end

function this.OnBatchStart(self)
    self.BatchTurnNum = 0
end

function this.OnUnitSelfTurnStart(self)
    self.BatchTurnNum = self.BatchTurnNum + 1
    self.TotalTurnNum = self.TotalTurnNum + 1
    self:InitTurnNumeric()
end

function this.OnUnitSelfTurnEnd(self)

end

return this