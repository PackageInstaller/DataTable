-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/portal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Portal = class("Portal")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local PortalType = {OneWay = 1, BothWay = 2}
local GateType = {Entrance = 1, Exit = 2}
local ArrowEffectPath = {[1] = "Up", [2] = "Right", [3] = "Down", [4] = "Left"}
Portal.Ctor = function(self, id, object)
  -- function num : 0_0 , upvalues : _ENV, PortalType, GateType, ArrowEffectPath
  self._id = id
  self._object = object
  self._cfg = ((BeanManager.GetTableByName)("sceneinteractive.cgateconfig")):GetRecorder(id)
  if (self._cfg).type == PortalType.OneWay and (self._cfg).direction == GateType.Exit then
    (self._object):SetActive(false)
  end
  do
    if (self._cfg).Arrow > 0 then
      local arrowEffect = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(self._object, ArrowEffectPath[(self._cfg).Arrow])
      arrowEffect:SetActive(true)
    end
    local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(object)
    self._pos = {x = x, y = z}
    self._gridpos = {x = (math.floor)(x / 0.4 + 0.5), y = (math.floor)(z / -0.56 + 0.5)}
    local p = ((self._cfg).coordinate):split(",")
    self._cfgpos = {x = tonumber(p[1]), y = tonumber(p[2])}
  end
end

Portal.Destroy = function(self)
  -- function num : 0_1
  if self._builder then
    (self._builder):Destroy()
    self._builder = nil
  end
end

Portal.GetID = function(self)
  -- function num : 0_2
  return self._id
end

Portal.GetObject = function(self)
  -- function num : 0_3
  return self._object
end

Portal.GetPosition = function(self)
  -- function num : 0_4
  return self._gridpos
end

Portal.Init = function(self)
  -- function num : 0_5 , upvalues : FixedPos, PortalType, GateType, _ENV
  if not self._builder then
    self._builder = (FixedPos.Create)(self, {self._gridpos})
  end
  if (self._cfg).type == PortalType.BothWay or (self._cfg).type == PortalType.OneWay and (self._cfg).direction == GateType.Entrance then
    if self._miniMapId then
      ((NekoData.BehaviorManager).BM_MiniMap):RemoveObject(self._miniMapId)
      self._miniMapId = nil
    end
    self._miniMapId = ((NekoData.BehaviorManager).BM_MiniMap):AddObject((self._cfg).minimapIcon, (self._cfgpos).y, (self._cfgpos).x, true)
  end
end

Portal.Activate = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._builder then
    (EventManager.AddEvent)((self._builder):BuildEnterEvent())
  end
end

Portal.ActivateDelay = function(self)
  -- function num : 0_7 , upvalues : FixedPos, _ENV
  if not self._builder then
    self._builder = (FixedPos.Create)(self, {self._gridpos})
  end
  ;
  (EventManager.AddEvent)((self._builder):BuildLeaveEvent())
end

Portal.Deactivate = function(self)
  -- function num : 0_8
  if self._builder then
    (self._builder):Destroy()
    self._builder = nil
  end
end

Portal.OnEnterArea = function(self)
  -- function num : 0_9 , upvalues : _ENV, PortalType, GateType, ComposedEffect
  if self._teleporting then
    return 
  end
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller.GetBuffManager then
    local manager = controller:GetBuffManager()
    local current_buff = manager:GetCurrentBuff()
    if current_buff and current_buff:GetType() == 1 and current_buff:GetState() == 1 then
      manager:OnBuffTimeout(current_buff:GetID())
    end
  end
  do
    local actor = (controller:GetPathResolver()):GetActor()
    do
      local speed = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetSpeed)(actor)
      if (self._cfg).type == PortalType.BothWay or (self._cfg).type == PortalType.OneWay and (self._cfg).direction == GateType.Entrance then
        local target = controller:GetPortal(((self._cfg).GateID)[1])
        target:Deactivate()
        local root = (ComposedEffect.Create)()
        local pos = target:GetPosition()
        root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_9_0 , upvalues : self
    self._teleporting = true
  end
))
        root:AddEffect((EffectFactory.CreateFreezeEffect)())
        root:AddEffect((EffectFactory.CreateMoveToWorldPosEffect)("[actor]", speed, (self._pos).x, 0, (self._pos).y, true))
        root:AddEffect((EffectFactory.CreatePortalTimelineEffect)(self._id))
        root:AddEffect((EffectFactory.CreateFlyToEffect)("[actor]", pos.x, pos.y, true))
        root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_9_1 , upvalues : target, _ENV, actor, speed, controller
    target:ActivateDelay()
    ;
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetSpeed)(actor, speed)
    controller:StopWalking()
  end
))
        if target:GetPortalType() == PortalType.OneWay and target:GetGateType() == GateType.Exit then
          root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_9_2 , upvalues : target
    target:SetActive(true)
  end
))
          local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "trapState", 1)
          effect:Bind(target:GetObject())
          root:AddEffect(effect)
          root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_9_3 , upvalues : target
    target:SetActive(false)
  end
))
          effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "trapState", 0)
          effect:Bind(target:GetObject())
          root:AddEffect(effect)
        end
        do
          root:AddEffect((EffectFactory.CreateThawEffect)())
          root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_9_4 , upvalues : self, _ENV
    self._teleporting = false
    print("leave portal", self._id)
  end
))
          root:Run()
        end
      end
    end
  end
end

Portal.OnLeaveArea = function(self)
  -- function num : 0_10
end

Portal.SetActive = function(self, flag)
  -- function num : 0_11
  (self._object):SetActive(flag)
end

Portal.GetGateType = function(self)
  -- function num : 0_12
  return (self._cfg).direction
end

Portal.GetPortalType = function(self)
  -- function num : 0_13
  return (self._cfg).type
end

Portal.RemoveMiniMapImg = function(self)
  -- function num : 0_14 , upvalues : PortalType, GateType, _ENV
  if ((self._cfg).type == PortalType.BothWay or (self._cfg).type ~= PortalType.OneWay or (self._cfg).direction == GateType.Entrance) and self._miniMapId then
    ((NekoData.BehaviorManager).BM_MiniMap):RemoveObject(self._miniMapId)
    self._miniMapId = nil
  end
end

return Portal

