local Switch = class("Switch")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local Future = require("logic.scene.luaevent.effect.future")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local SceneObj = require("logic.manager.experimental.types.sceneobj")

function Switch:Ctor(instanceid, id, object, initialstate, path, preservestate)
  self._instanceid = instanceid
  self._id = id
  self._object = object
  self._path = path
  self._state = initialstate or 0
  self._initialState = initialstate
  self._preserveState = preservestate
  self._stateEffects = {}
  self._effectArgs = {
    switches = {},
    traps = {}
  }
  self._effectAreas = {}
  self._cameraMoved = false
end

function Switch:Destroy()
  self:Deactivate()
end

function Switch:GetInstanceID()
  return self._instanceid
end

function Switch:GetID()
  return self._id
end

function Switch:GetObject()
  return self._object
end

function Switch:GetType()
  return self._type
end

function Switch:SetType(type)
  self._type = type
end

function Switch:AddEffectArea(area)
  self._effectAreas[#self._effectAreas + 1] = area
end

function Switch:GetEffectArea()
  return self._effectAreas
end

function Switch:GetKey()
  return self._key
end

function Switch:SetKey(key)
  self._key = key
end

function Switch:GetPath()
  return self._path
end

function Switch:BuildStateEffects()
  for state, effectid in pairs(self._stateEffects) do
    self._stateEffects[state] = StaticEvent.CreateSwitchEffect(effectid, self._effectArgs)
    self._stateEffects[state]:Bind(self._object)
  end
end

function Switch:AddStateEffect(state, effectid)
  self._stateEffects = self._stateEffects or {}
  self._stateEffects[state] = effectid
end

function Switch:AppendStateEffect(state, effect)
  if not self._stateEffects[state] then
    return false
  end
  self._stateEffects[state]:AddEffect(effect)
  self._stateEffects[state]:Bind(self._object)
  return true
end

function Switch:Activate()
  self:BuildStateEffects()
end

function Switch:BuildSceneObject()
  local id = -1000 * self._instanceid - self._id
  local sceneid = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon):GetSceneID()
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(self._object)
  local buttonid = BeanManager.GetTableByName("trap.ctrapbutton"):GetRecorder(self._type).buttonId
  self._sceneobject = SceneObj.Create(id, sceneid, self._object, {
    x = math.floor(x / 0.4 + 0.5),
    y = math.floor(z / -0.56 + 0.5)
  }, 1, 5, buttonid)
  UIInteraction.AddSceneInteractiveObj(self._sceneobject)
  UIInteraction.SetInteractiveData(self._sceneobject:GetInteractiveId())
end

function Switch:Deactivate()
  if self._builder then
    self._builder:Destroy()
    self._builder = nil
  end
  if self._sceneobject then
    UIInteraction.RemoveSceneInteractiveObj(self._sceneobject:GetInteractiveId())
    self._sceneobject = nil
  end
end

function Switch:GetState()
  return self._state
end

function Switch:GetInitialState()
  return self._initialState
end

function Switch:ToState(state, args)
  if self._state == state and (not args or not args.init) then
    return Future.NoOp()
  end
  self._state = state
  return self:OnStateChange(args)
end

function Switch:ToNextState()
  self._state = (self._state + 1) % table.nums(self._stateEffects)
  return self:OnStateChange()
end

function Switch:CheckState()
  return Future.NoOp()
end

function Switch:OnStateChange(args)
  args = args or {}
  args.skip_camera = self._cameraMoved and self._cfg.review == 0 or self._skipCamera
  local root = EffectFactory.CreateComposedEffect()
  root:AddEffect(self._stateEffects[self._state])
  local future = Future.Create(root, args)
  return future
end

function Switch:OnEnterArea(builder)
  self:ToNextState()
end

function Switch:OnLeaveArea(builder)
end

function Switch:ShouldSaveState()
  return self._preserveState
end

function Switch:RestoreState(state)
  self._skipCamera = true
  return self:ToState(state, {init = true})
end

function Switch:AddSwitchLinks(switches)
  for _, v in ipairs(switches) do
    table.insert(self._effectArgs.switches, {
      instance = v:GetInstanceID(),
      id = v:GetID()
    })
  end
end

function Switch:AddTrapLinks(traps)
  for _, v in ipairs(traps) do
    table.insert(self._effectArgs.traps, {
      instance = v:GetInstanceID(),
      id = v:GetID()
    })
  end
end

return Switch
