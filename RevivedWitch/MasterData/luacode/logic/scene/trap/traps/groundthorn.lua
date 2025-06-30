-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/traps/groundthorn.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Trap = require("logic.scene.trap.trap")
local GroundThorn = class("GroundThorn", Trap)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local BinaryState = require("logic.scene.trap.components.state.binarystate")
local SingleDamage = require("logic.scene.trap.components.effect.singledamage")
GroundThorn.Ctor = function(self, instanceid, id, object, traparea, initialstate)
  -- function num : 0_0 , upvalues : GroundThorn, FixedPos
  ((GroundThorn.super).Ctor)(self, instanceid, id, object, initialstate)
  self._damageBuilder = (FixedPos.Create)(self, traparea)
end

GroundThorn.Activate = function(self)
  -- function num : 0_1 , upvalues : GroundThorn
  ((GroundThorn.super).Activate)(self)
  self:BuildStateEffects()
  ;
  (self._animator):SetInteger("trapState", self:GetState())
  local effects = (self._stateEffects)[self:GetState()]
  ;
  (effects[#effects]):Run()
end

GroundThorn.BuildStateEffects = function(self)
  -- function num : 0_2 , upvalues : GroundThorn, _ENV, SingleDamage
  ((GroundThorn.super).BuildStateEffects)(self)
  ;
  (table.insert)((self._stateEffects)[1], (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : self
    (self._damageBuilder):Destroy()
  end
))
  ;
  (table.insert)((self._stateEffects)[2], (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_1 , upvalues : self, _ENV
    local event = (self._damageBuilder):BuildEnterEvent()
    ;
    (EventManager.AddEvent)(event)
  end
))
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._damageEffects)[2] = (SingleDamage.Create)(function()
    -- function num : 0_2_2 , upvalues : self
    self:OnDamage()
  end
)
end

GroundThorn.OnStateChange = function(self)
  -- function num : 0_3 , upvalues : GroundThorn
  ((GroundThorn.super).OnStateChange)(self)
end

GroundThorn.OnLeaveArea = function(self)
  -- function num : 0_4
  self._onDamage = false
  ;
  ((self._damageEffects)[2]):Reset()
end

GroundThorn.Destroy = function(self)
  -- function num : 0_5 , upvalues : GroundThorn
  ((GroundThorn.super).Destroy)(self)
end

GroundThorn.OnEnterArea = function(self)
  -- function num : 0_6
  self._onDamage = true
end

GroundThorn.OnDamage = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local active_controlller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if active_controlller.OnTrapDamage then
    active_controlller:OnTrapDamage(self._id)
  end
end

return GroundThorn

