-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switches/skate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = require("logic.scene.trap.switch")
local Skate = class("Stick", Switch)
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local Future = require("logic.scene.luaevent.effect.future")
local PathResolver = require("logic.scene.pathresolver")
Skate.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Skate, _ENV
  ((Skate.super).Ctor)(self, ...)
  local x, _, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(self._object)
  self._effectAreas = {
{x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z / -0.56 + 0.5)}
}
end

Skate.Activate = function(self)
  -- function num : 0_1 , upvalues : _ENV, FixedPos
  local info = ((self._effectArgs).switches)[#(self._effectArgs).switches]
  local switch = (SwitchManager.GetSwitch)(info.instance, info.id)
  self._lastIceArea = (switch:GetEffectArea())[1]
  self:BuildStateEffects()
  self._builder = (FixedPos.Create)(self, self._effectAreas)
  self._leaveBuilder = (FixedPos.Create)(self, {(self._waypoints)[#self._waypoints]})
  ;
  (EventManager.AddEvent)((self._builder):BuildEnterEvent())
  ;
  (EventManager.AddEvent)((self._leaveBuilder):BuildLeaveEvent())
end

Skate.Deactivate = function(self)
  -- function num : 0_2 , upvalues : Skate, _ENV
  ((Skate.super).Deactivate)(self)
  if self._builder then
    (self._builder):Destroy()
  end
  if self._timer then
    self._timer = (GameTimer.RemoveTask)(self._timer)
  end
end

local begin_recover = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cskatingoption")
    req.option = req.RECOVER
    req.switchId = self:GetID()
    req.instanceId = self:GetInstanceID()
    req:Send()
    print("begin skate recover", self._instanceid, self._id, (debug.traceback)())
  end
))
  local par = (EffectFactory.CreateEffectList)()
  for _,v in ipairs((self._effectArgs).switches) do
    local switch = (SwitchManager.GetSwitch)(v.instance, v.id)
    par:AddEffect(switch:ToState(0))
  end
  root:AddEffect(par)
  return root
end

Skate.BuildStateEffects = function(self)
  -- function num : 0_4 , upvalues : _ENV, PathResolver, begin_recover
  local endpoint = (self._waypoints)[#self._waypoints]
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._stateEffects)[0] = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateBlockChangeEffect)((self._lastIceArea).x, (self._lastIceArea).y, 1, 1, true)
  effect:SetParam("runoninit")
  ;
  ((self._stateEffects)[0]):AddEffect(effect)
  effect:SetParam("runoninit")
  ;
  ((self._stateEffects)[0]):AddEffect(effect)
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((EffectFactory.CreateFreezeEffect)())
  effect = (EffectFactory.CreateBlockChangeEffect)(endpoint.x, endpoint.y, 1, 1, false)
  effect:SetParam("runoninit")
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_0 , upvalues : _ENV, self
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cexploreoption")
    req.id = self:GetID()
    req.instanceid = self:GetInstanceID()
    req:Send()
  end
))
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_1 , upvalues : _ENV
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller.GetBuffManager then
      local manager = controller:GetBuffManager()
      local current_buff = manager:GetCurrentBuff()
      if current_buff and current_buff:GetType() == 1 and current_buff:GetState() == 1 then
        manager:OnBuffTimeout(current_buff:GetID())
      end
    end
  end
))
  effect = (EffectFactory.CreateBlockChangeEffect)((self._lastIceArea).x, (self._lastIceArea).y, 1, 1, false)
  effect:SetParam("runoninit")
  root:AddEffect(effect)
  local current_speed = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetSpeed)((PathResolver.Resolve)("[actor]"))
  local speed = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(23)).Value)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_2 , upvalues : _ENV
    ((EffectFactory.CreateAnimatorStateChangeEffect)("[actor]", "skate", 1)):Run()
  end
))
  for i,v in ipairs(self._waypoints) do
    root:AddEffect((EffectFactory.CreateMoveToEffect)("[actor]", speed, v.x, v.y, true))
  end
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_3 , upvalues : _ENV, self
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cskatingoption")
    req.option = req.END
    req.switchId = self:GetID()
    req.instanceId = self:GetInstanceID()
    req:Send()
  end
))
  root:AddEffect((EffectFactory.CreateSpeedChangeEffect)("[actor]", current_speed))
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_4 , upvalues : _ENV
    ((EffectFactory.CreateAnimatorStateChangeEffect)("[actor]", "skate", 0)):Run()
  end
))
  root:AddEffect((EffectFactory.CreateBlockChangeEffect)((self._lastIceArea).x, (self._lastIceArea).y, 1, 1, true))
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_5 , upvalues : self, _ENV, begin_recover
    self._timer = (GameTimer.AddTask)(0.25, 0, function()
      -- function num : 0_4_5_0 , upvalues : self, begin_recover, _ENV
      self._timer = nil
      local recover = begin_recover(self)
      recover:AddEffect((EffectFactory.CreateBlockChangeEffect)((self._lastIceArea).x, (self._lastIceArea).y, 1, 1, true))
      recover:AddEffect((EffectFactory.CreateThawEffect)())
      recover:Run()
    end
)
  end
))
  -- DECOMPILER ERROR at PC166: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self._stateEffects)[1] = root
end

Skate.AddWaypoints = function(self, points)
  -- function num : 0_5
  self._waypoints = points
end

Skate.SetRecoverArea = function(self, area)
  -- function num : 0_6
  self._recoverArea = area
end

Skate.OnEnterArea = function(self, builder)
  -- function num : 0_7
  if builder == self._builder and self._state == 0 then
    (self:ToNextState()):Run()
  end
end

Skate.OnLeaveArea = function(self, builder)
  -- function num : 0_8
  if builder == self._leaveBuilder and self._state ~= 0 then
    (self:ToState(0)):Run()
  end
end

return Skate

