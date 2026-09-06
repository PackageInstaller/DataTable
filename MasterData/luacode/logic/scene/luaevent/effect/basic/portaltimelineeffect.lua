local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DynamicTimelineTable = BeanManager.GetTableByName("timeline.ctimelinedynamic")
local PortalTimelineEffect = class("PortalTimelineEffect", EffectBase)
local ctimelinevol = BeanManager.GetTableByName("timeline.ctimelinevol")

function PortalTimelineEffect:Ctor(id)
  self._portalID = id
end

function PortalTimelineEffect:Destroy()
end

function PortalTimelineEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if active_controller.StopWalking then
    active_controller:StopWalking()
  end
  if active_controller.PlayPortalTimeline then
    active_controller:PlayPortalTimeline(active_controller:GetPortal(self._portalID):GetObject())
  end
end

function PortalTimelineEffect:Then(callback)
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("timeline", event:GetID(), active_controller:GetPortalTimelineDirector())
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = EffectFactory.CreateCustomEffect(callback)
  event:AddEffect(effect)
  effect = EffectFactory.CreateCustomEffect(function()
    LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  end)
  event:AddEffect(effect)
  EventManager.AddEvent(event)
end

return PortalTimelineEffect
