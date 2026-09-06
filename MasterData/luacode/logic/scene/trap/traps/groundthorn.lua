local Trap = require("logic.scene.trap.trap")
local GroundThorn = class("GroundThorn", Trap)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local BinaryState = require("logic.scene.trap.components.state.binarystate")
local SingleDamage = require("logic.scene.trap.components.effect.singledamage")

function GroundThorn:Ctor(instanceid, id, object, traparea, initialstate)
  GroundThorn.super.Ctor(self, instanceid, id, object, initialstate)
  self._damageBuilder = FixedPos.Create(self, traparea)
end

function GroundThorn:Activate()
  GroundThorn.super.Activate(self)
  self:BuildStateEffects()
  self._animator:SetInteger("trapState", self:GetState())
  local effects = self._stateEffects[self:GetState()]
  effects[#effects]:Run()
end

function GroundThorn:BuildStateEffects()
  GroundThorn.super.BuildStateEffects(self)
  table.insert(self._stateEffects[1], EffectFactory.CreateCustomEffect(function()
    self._damageBuilder:Destroy()
  end))
  table.insert(self._stateEffects[2], EffectFactory.CreateCustomEffect(function()
    local event = self._damageBuilder:BuildEnterEvent()
    EventManager.AddEvent(event)
  end))
  self._damageEffects[2] = SingleDamage.Create(function()
    self:OnDamage()
  end)
end

function GroundThorn:OnStateChange()
  GroundThorn.super.OnStateChange(self)
end

function GroundThorn:OnLeaveArea()
  self._onDamage = false
  self._damageEffects[2]:Reset()
end

function GroundThorn:Destroy()
  GroundThorn.super.Destroy(self)
end

function GroundThorn:OnEnterArea()
  self._onDamage = true
end

function GroundThorn:OnDamage()
  local active_controlller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if active_controlller.OnTrapDamage then
    active_controlller:OnTrapDamage(self._id)
  end
end

return GroundThorn
