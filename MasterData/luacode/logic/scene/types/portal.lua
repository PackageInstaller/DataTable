local Portal = class("Portal")
local FixedPos = require("logic.scene.trap.components.trigger.fixedpos")
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local PortalType = {OneWay = 1, BothWay = 2}
local GateType = {Entrance = 1, Exit = 2}
local ArrowEffectPath = {
  [1] = "Up",
  [2] = "Right",
  [3] = "Down",
  [4] = "Left"
}

function Portal:Ctor(id, object)
  self._id = id
  self._object = object
  self._cfg = BeanManager.GetTableByName("sceneinteractive.cgateconfig"):GetRecorder(id)
  if self._cfg.type == PortalType.OneWay and self._cfg.direction == GateType.Exit then
    self._object:SetActive(false)
  end
  if self._cfg.Arrow > 0 then
    local arrowEffect = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(self._object, ArrowEffectPath[self._cfg.Arrow])
    arrowEffect:SetActive(true)
  end
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(object)
  self._pos = {x = x, y = z}
  self._gridpos = {
    x = math.floor(x / 0.4 + 0.5),
    y = math.floor(z / -0.56 + 0.5)
  }
  local p = self._cfg.coordinate:split(",")
  self._cfgpos = {
    x = tonumber(p[1]),
    y = tonumber(p[2])
  }
end

function Portal:Destroy()
  if self._builder then
    self._builder:Destroy()
    self._builder = nil
  end
end

function Portal:GetID()
  return self._id
end

function Portal:GetObject()
  return self._object
end

function Portal:GetPosition()
  return self._gridpos
end

function Portal:Init()
  if not self._builder then
    self._builder = FixedPos.Create(self, {
      self._gridpos
    })
  end
  if self._cfg.type == PortalType.BothWay or self._cfg.type == PortalType.OneWay and self._cfg.direction == GateType.Entrance then
    if self._miniMapId then
      NekoData.BehaviorManager.BM_MiniMap:RemoveObject(self._miniMapId)
      self._miniMapId = nil
    end
    self._miniMapId = NekoData.BehaviorManager.BM_MiniMap:AddObject(self._cfg.minimapIcon, self._cfgpos.y, self._cfgpos.x, true)
  end
end

function Portal:Activate()
  if self._builder then
    EventManager.AddEvent(self._builder:BuildEnterEvent())
  end
end

function Portal:ActivateDelay()
  if not self._builder then
    self._builder = FixedPos.Create(self, {
      self._gridpos
    })
  end
  EventManager.AddEvent(self._builder:BuildLeaveEvent())
end

function Portal:Deactivate()
  if self._builder then
    self._builder:Destroy()
    self._builder = nil
  end
end

function Portal:OnEnterArea()
  if self._teleporting then
    return
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller.GetBuffManager then
    local manager = controller:GetBuffManager()
    local current_buff = manager:GetCurrentBuff()
    if current_buff and current_buff:GetType() == 1 and current_buff:GetState() == 1 then
      manager:OnBuffTimeout(current_buff:GetID())
    end
  end
  local actor = controller:GetPathResolver():GetActor()
  local speed = CS.PixelNeko.Lua.NavMeshStaticFunctions.GetSpeed(actor)
  if self._cfg.type == PortalType.BothWay or self._cfg.type == PortalType.OneWay and self._cfg.direction == GateType.Entrance then
    local target = controller:GetPortal(self._cfg.GateID[1])
    target:Deactivate()
    local root = ComposedEffect.Create()
    local pos = target:GetPosition()
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      self._teleporting = true
    end))
    root:AddEffect(EffectFactory.CreateFreezeEffect())
    root:AddEffect(EffectFactory.CreateMoveToWorldPosEffect("[actor]", speed, self._pos.x, 0, self._pos.y, true))
    root:AddEffect(EffectFactory.CreatePortalTimelineEffect(self._id))
    root:AddEffect(EffectFactory.CreateFlyToEffect("[actor]", pos.x, pos.y, true))
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      target:ActivateDelay()
      CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(actor, speed)
      controller:StopWalking()
    end))
    if target:GetPortalType() == PortalType.OneWay and target:GetGateType() == GateType.Exit then
      root:AddEffect(EffectFactory.CreateCustomEffect(function()
        target:SetActive(true)
      end))
      local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "trapState", 1)
      effect:Bind(target:GetObject())
      root:AddEffect(effect)
      root:AddEffect(EffectFactory.CreateCustomEffect(function()
        target:SetActive(false)
      end))
      effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "trapState", 0)
      effect:Bind(target:GetObject())
      root:AddEffect(effect)
    end
    root:AddEffect(EffectFactory.CreateThawEffect())
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      self._teleporting = false
      print("leave portal", self._id)
    end))
    root:Run()
  else
  end
end

function Portal:OnLeaveArea()
end

function Portal:SetActive(flag)
  self._object:SetActive(flag)
end

function Portal:GetGateType()
  return self._cfg.direction
end

function Portal:GetPortalType()
  return self._cfg.type
end

function Portal:RemoveMiniMapImg()
  if (self._cfg.type == PortalType.BothWay or self._cfg.type == PortalType.OneWay and self._cfg.direction == GateType.Entrance) and self._miniMapId then
    NekoData.BehaviorManager.BM_MiniMap:RemoveObject(self._miniMapId)
    self._miniMapId = nil
  end
end

return Portal
