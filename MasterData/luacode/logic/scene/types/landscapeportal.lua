local LandscapePortal = class("LandscapePortal")
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local cscrollscenetimeline = BeanManager.GetTableByName("timeline.cscrollscenetimeline")

function LandscapePortal:Ctor(id)
  self._id = id
  self._cfg = cscrollscenetimeline:GetRecorder(id)
end

function LandscapePortal:Destroy()
  if self._eventID then
    EventManager.RemoveEvent(self._eventID)
  end
end

function LandscapePortal:GetID()
  return self._id
end

function LandscapePortal:GetTriggerID()
  return self._cfg.triggerID
end

function LandscapePortal:Activate()
  if self._eventID then
    return
  end
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local event = EventManager.CreateEvent(self._cfg.isRepeat == 1)
  local trigger = TriggerManager.CreateTrigger("collision", event:GetID(), tostring(self._cfg.triggerID))
  local root = EffectFactory.CreateComposedEffect()
  local target = controller:GetPortal(self._cfg.transTargetID)
  if target then
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      target:Deactivate()
    end))
  end
  root:AddEffect(EffectFactory.CreateTimelineEffect(self._id))
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    local req = LuaNetManager.CreateProtocol("protocol.battle.cchangescrollscenestate")
    req.id = self._id
    req:Send()
    if target then
      target:Activate()
    end
  end))
  event:AddEffect(root)
  event:AddTrigger(trigger:GetType(), trigger)
  EventManager.AddEvent(event)
  self._eventID = event:GetID()
end

function LandscapePortal:Deactivate()
  if self._eventID then
    EventManager.RemoveEvent(self._eventID)
    self._eventID = nil
  end
end

return LandscapePortal
