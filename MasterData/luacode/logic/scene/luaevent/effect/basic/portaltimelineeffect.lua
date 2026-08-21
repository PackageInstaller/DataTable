-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/portaltimelineeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DynamicTimelineTable = (BeanManager.GetTableByName)("timeline.ctimelinedynamic")
local PortalTimelineEffect = class("PortalTimelineEffect", EffectBase)
local ctimelinevol = (BeanManager.GetTableByName)("timeline.ctimelinevol")
PortalTimelineEffect.Ctor = function(self, id)
  -- function num : 0_0
  self._portalID = id
end

PortalTimelineEffect.Destroy = function(self)
  -- function num : 0_1
end

PortalTimelineEffect.Run = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if active_controller.StopWalking then
    active_controller:StopWalking()
  end
  if active_controller.PlayPortalTimeline then
    active_controller:PlayPortalTimeline((active_controller:GetPortal(self._portalID)):GetObject())
  end
end

PortalTimelineEffect.Then = function(self, callback)
  -- function num : 0_3 , upvalues : _ENV
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("timeline", event:GetID(), active_controller:GetPortalTimelineDirector())
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = (EffectFactory.CreateCustomEffect)(callback)
  event:AddEffect(effect)
  effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  end
)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
end

return PortalTimelineEffect

