-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/landscapeportal.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LandscapePortal = class("LandscapePortal")
local ComposedEffect = require("logic.scene.luaevent.effect.composed.composedeffect")
local cscrollscenetimeline = (BeanManager.GetTableByName)("timeline.cscrollscenetimeline")
LandscapePortal.Ctor = function(self, id)
  -- function num : 0_0 , upvalues : cscrollscenetimeline
  self._id = id
  self._cfg = cscrollscenetimeline:GetRecorder(id)
end

LandscapePortal.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._eventID then
    (EventManager.RemoveEvent)(self._eventID)
  end
end

LandscapePortal.GetID = function(self)
  -- function num : 0_2
  return self._id
end

LandscapePortal.GetTriggerID = function(self)
  -- function num : 0_3
  return (self._cfg).triggerID
end

LandscapePortal.Activate = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._eventID then
    return 
  end
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local event = (EventManager.CreateEvent)((self._cfg).isRepeat == 1)
  local trigger = (TriggerManager.CreateTrigger)("collision", event:GetID(), tostring((self._cfg).triggerID))
  local root = (EffectFactory.CreateComposedEffect)()
  local target = controller:GetPortal((self._cfg).transTargetID)
  if target then
    root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_0 , upvalues : target
    target:Deactivate()
  end
))
  end
  root:AddEffect((EffectFactory.CreateTimelineEffect)(self._id))
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_1 , upvalues : _ENV, self, target
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cchangescrollscenestate")
    req.id = self._id
    req:Send()
    if target then
      target:Activate()
    end
  end
))
  event:AddEffect(root)
  event:AddTrigger(trigger:GetType(), trigger)
  ;
  (EventManager.AddEvent)(event)
  self._eventID = event:GetID()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LandscapePortal.Deactivate = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._eventID then
    (EventManager.RemoveEvent)(self._eventID)
    self._eventID = nil
  end
end

return LandscapePortal

