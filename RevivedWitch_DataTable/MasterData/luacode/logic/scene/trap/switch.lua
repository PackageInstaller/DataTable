-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/trap/switch.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Switch = class("Switch")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local SceneObj = require("logic.manager.experimental.types.sceneobj")
Switch.Ctor = function(self, instanceid, id, object, initialstate, path, preservestate)
  -- function num : 0_0
  self._instanceid = instanceid
  self._id = id
  self._object = object
  self._path = path
  self._state = initialstate or 0
  self._initialState = initialstate
  self._preserveState = preservestate
  self._stateEffects = {}
  self._effectArgs = {
switches = {}
, 
traps = {}
}
  self._effectAreas = {}
  self._cameraMoved = false
end

Switch.Destroy = function(self)
  -- function num : 0_1
  self:Deactivate()
end

Switch.GetInstanceID = function(self)
  -- function num : 0_2
  return self._instanceid
end

Switch.GetID = function(self)
  -- function num : 0_3
  return self._id
end

Switch.GetObject = function(self)
  -- function num : 0_4
  return self._object
end

Switch.GetType = function(self)
  -- function num : 0_5
  return self._type
end

Switch.SetType = function(self, type)
  -- function num : 0_6
  self._type = type
end

Switch.AddEffectArea = function(self, area)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (self._effectAreas)[#self._effectAreas + 1] = area
end

Switch.GetEffectArea = function(self)
  -- function num : 0_8
  return self._effectAreas
end

Switch.GetKey = function(self)
  -- function num : 0_9
  return self._key
end

Switch.SetKey = function(self, key)
  -- function num : 0_10
  self._key = key
end

Switch.GetPath = function(self)
  -- function num : 0_11
  return self._path
end

Switch.BuildStateEffects = function(self)
  -- function num : 0_12 , upvalues : _ENV, StaticEvent
  for state,effectid in pairs(self._stateEffects) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    (self._stateEffects)[state] = (StaticEvent.CreateSwitchEffect)(effectid, self._effectArgs)
    ;
    ((self._stateEffects)[state]):Bind(self._object)
  end
end

Switch.AddStateEffect = function(self, state, effectid)
  -- function num : 0_13
  if not self._stateEffects then
    self._stateEffects = {}
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._stateEffects)[state] = effectid
  end
end

Switch.AppendStateEffect = function(self, state, effect)
  -- function num : 0_14
  if not (self._stateEffects)[state] then
    return false
  end
  ;
  ((self._stateEffects)[state]):AddEffect(effect)
  ;
  ((self._stateEffects)[state]):Bind(self._object)
  return true
end

Switch.Activate = function(self)
  -- function num : 0_15
  self:BuildStateEffects()
end

Switch.BuildSceneObject = function(self)
  -- function num : 0_16 , upvalues : _ENV, SceneObj, UIInteraction
  local id = -1000 * self._instanceid - self._id
  local sceneid = ((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)):GetSceneID()
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(self._object)
  local buttonid = (((BeanManager.GetTableByName)("trap.ctrapbutton")):GetRecorder(self._type)).buttonId
  self._sceneobject = (SceneObj.Create)(id, sceneid, self._object, {x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z / -0.56 + 0.5)}, 1, 5, buttonid)
  ;
  (UIInteraction.AddSceneInteractiveObj)(self._sceneobject)
  ;
  (UIInteraction.SetInteractiveData)((self._sceneobject):GetInteractiveId())
end

Switch.Deactivate = function(self)
  -- function num : 0_17 , upvalues : UIInteraction
  if self._builder then
    (self._builder):Destroy()
    self._builder = nil
  end
  if self._sceneobject then
    (UIInteraction.RemoveSceneInteractiveObj)((self._sceneobject):GetInteractiveId())
    self._sceneobject = nil
  end
end

Switch.GetState = function(self)
  -- function num : 0_18
  return self._state
end

Switch.GetInitialState = function(self)
  -- function num : 0_19
  return self._initialState
end

Switch.ToState = function(self, state, args)
  -- function num : 0_20 , upvalues : Future
  if self._state == state and (not args or not args.init) then
    return (Future.NoOp)()
  end
  self._state = state
  return self:OnStateChange(args)
end

Switch.ToNextState = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self._state = (self._state + 1) % (table.nums)(self._stateEffects)
  return self:OnStateChange()
end

Switch.CheckState = function(self)
  -- function num : 0_22 , upvalues : Future
  return (Future.NoOp)()
end

Switch.OnStateChange = function(self, args)
  -- function num : 0_23 , upvalues : _ENV, Future
  if not args then
    args = {}
  end
  -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P3

  args.skip_camera = (self._cameraMoved and (self._cfg).review == 0)
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((self._stateEffects)[self._state])
  local future = (Future.Create)(root, args)
  do return future end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Switch.OnEnterArea = function(self, builder)
  -- function num : 0_24
  self:ToNextState()
end

Switch.OnLeaveArea = function(self, builder)
  -- function num : 0_25
end

Switch.ShouldSaveState = function(self)
  -- function num : 0_26
  return self._preserveState
end

Switch.RestoreState = function(self, state)
  -- function num : 0_27
  self._skipCamera = true
  return self:ToState(state, {init = true})
end

Switch.AddSwitchLinks = function(self, switches)
  -- function num : 0_28 , upvalues : _ENV
  for _,v in ipairs(switches) do
    (table.insert)((self._effectArgs).switches, {instance = v:GetInstanceID(), id = v:GetID()})
  end
end

Switch.AddTrapLinks = function(self, traps)
  -- function num : 0_29 , upvalues : _ENV
  for _,v in ipairs(traps) do
    (table.insert)((self._effectArgs).traps, {instance = v:GetInstanceID(), id = v:GetID()})
  end
end

return Switch

