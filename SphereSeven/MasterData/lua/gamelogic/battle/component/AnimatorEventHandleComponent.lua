---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/16 18:44
---
local AnimatorEventHandleComponent = BaseClass("AnimatorEventHandleComponent", Component)
local base = Component

local function OnSpell(self) --施法事件
    coroutine.start(function ()
        local zSkill = self.unit_battle_component:CurActZSkill() --获取当前技能配置
        self.unit_effect_component:CoPlaySpell(zSkill.SpellEfx,30) --特效组件调用
        self.unit_effect_component:CoPlayHandles(zSkill,20)
        self.unit_sound_component:CoPlaySkl(zSkill.SpellSound)
    end)
end

local function OnDamage(self)
    if self.onDamageTriggerTimes < self.maxOnDamageTriggerTimes then
        self.unit_battle_component:OnDamage()
        self.onDamageTriggerTimes = self.onDamageTriggerTimes + 1
    end
end

local function OnMissile(self)
    if self.onMissileTriggerTimes < self.maxOnMissileTriggerTimes then
        self.unit_battle_component:OnMissile()
        self.onMissileTriggerTimes = self.onMissileTriggerTimes + 1
    end
end

local function OnCutIn(self)
    coroutine.start(function ()
        self.battle_camera_component:CutinCameraON()
        self.unit_effect_component:CoPlayCutIn(self.unit_battle_component:CurActZSkill().CutInEfx)
        coroutine.waitforseconds(5)
        self.battle_camera_component:CutinCameraOFF()
    end)
end

local function OnHit(self)
    self.unit_anim_component:OnHit()
end

local function Awake(self)
    base.Awake(self)
    local ssUnitEventReceiver = self.__entity.GameObject:AddComponent(typeof(CS.SsUnitEventReceiver))
    ssUnitEventReceiver.SsUnitId = self.__entity.UID
    ssUnitEventReceiver.SpellEventHandle = Bind(self,OnSpell)
    ssUnitEventReceiver.DamageEventHandle = Bind(self,OnDamage)
    ssUnitEventReceiver.MissileEventHandle = Bind(self,OnMissile)
    ssUnitEventReceiver.CutInEventHandle = Bind(self,OnCutIn)
    ssUnitEventReceiver.HitEventHandle = Bind(self,OnHit)
    self.battle_component = Game.Scene:GetComponent("BattleComponent")
    self.battle_camera_component = Game.Scene:GetComponent("BattleCameraComponent")
    self.unit_battle_component = self.__entity:GetComponent("SsUnitBattleComponent")
    self.unit_effect_component = self.__entity:GetComponent("SsUnitEffectComponent")
    self.unit_sound_component = self.__entity:GetComponent("SsUnitSoundComponent")
    self.unit_anim_component = self.__entity:GetComponent("SsUnitAnimatorComponent")

    self.onDamageTriggerTimes = 0
    self.maxOnDamageTriggerTimes = 0

    self.onMissileTriggerTimes = 0
    self.maxOnMissileTriggerTimes = 0
end

local function Dispose(self)
    base.Dispose(self)
end

local function StartRecordSkillEfx(self)
    local skill = self.battle_component.CurActSkill
    self.onDamageTriggerTimes = 0
    self.maxOnDamageTriggerTimes = #skill.AnimEvt.OnDamage

    self.onMissileTriggerTimes = 0
    self.maxOnMissileTriggerTimes = #skill.AnimEvt.OnMissile
end

AnimatorEventHandleComponent.Awake = Awake
AnimatorEventHandleComponent.Dispose = Dispose
AnimatorEventHandleComponent.StartRecordSkillEfx = StartRecordSkillEfx

return AnimatorEventHandleComponent