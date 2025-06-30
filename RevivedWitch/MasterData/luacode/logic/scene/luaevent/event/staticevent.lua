-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/event/staticevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StaticEvent = {}
local Triggers = require("data.dungeondata.event.cconditionconfig")
local Effects = require("data.dungeondata.event.ceffectconfig")
local SwitchEffects = require("data.dungeondata.trap.cswitcheffectconfig")
local InteractiveEffects = require("data.dungeondata.sceneinteractive.cinteractiveeffectconfig")
local NPCEffect = require("data.dungeondata.npc.cnpceffectconfig")
StaticEvent.CreateFromConfig = function(id)
  -- function num : 0_0 , upvalues : _ENV, StaticEvent, Triggers, Effects
  print("create event from cfg", id, (debug.traceback)())
  ;
  (((BeanManager.GetTableByName)("event.ceventconfig")):GetRecorder(id))
  local record = nil
  local event = nil
  if record.isrepeat ~= 1 then
    event = (EventManager.CreateTransactionalEvent)(not (StaticEvent.RequireReconnect)(record.eventType))
    event = (EventManager.CreateEvent)(record.isrepeat == 1)
    event:SetConfigID(id)
    do
      if (StaticEvent.RequireClientTrigger)(record.eventType) then
        local trigger = (Triggers[tonumber(record.condition)])(event:GetID())
        event:AddTrigger(trigger:GetType(), trigger)
      end
      event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_0 , upvalues : _ENV, id
    LogWarning("staticevent", "trigger cfgid = " .. id .. ", " .. (debug.traceback)())
  end
))
      local effect = (Effects[record.effect])()
      event:AddEffect(effect)
      event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_1 , upvalues : _ENV, id, StaticEvent
    (EventManager.SaveDungeonFinishedEvent)(id)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_DungeonEventEnd, StaticEvent, id)
  end
))
      if record.alternative_effect ~= -1 then
        event:AddAlternativeEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_0_2 , upvalues : _ENV, id
    LogWarning("staticevent", "alternative trigger cfgid = " .. id .. ", " .. (debug.traceback)())
  end
))
        effect = (Effects[record.alternative_effect])()
        event:AddAlternativeEffect(effect)
      end
      do return event end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

StaticEvent.CreateSwitchEffect = function(id, args)
  -- function num : 0_1 , upvalues : _ENV, SwitchEffects
  if id == 0 then
    return (EffectFactory.CreateComposedEffect)()
  end
  return (SwitchEffects[id])(args)
end

StaticEvent.CreateTrapEffect = function(id, args)
  -- function num : 0_2 , upvalues : StaticEvent
  return (StaticEvent.CreateSwitchEffect)(id, args)
end

StaticEvent.CreateInteractiveEffect = function(interactiveId)
  -- function num : 0_3 , upvalues : _ENV, InteractiveEffects
  local record = ((BeanManager.GetTableByName)("sceneinteractive.cinteractiveconfig")):GetRecorder(interactiveId)
  do
    if record then
      local effectid = tonumber(record.effect)
      return (InteractiveEffects[effectid])(), record.reconnect == 1
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

StaticEvent.CreateNPCEffect = function(id)
  -- function num : 0_4 , upvalues : _ENV, NPCEffect
  local effectid = tonumber(id)
  return (NPCEffect[effectid])()
end

StaticEvent.IsEffectPersist = function(mask)
  -- function num : 0_5
  do return mask == 3 or mask == 6 or mask == 8 or mask == 9 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

StaticEvent.CanEffectRepeat = function(mask)
  -- function num : 0_6
  do return mask ~= 2 and mask ~= 5 and mask ~= 7 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

StaticEvent.RequireReconnect = function(mask)
  -- function num : 0_7
  do return mask == 4 or mask == 5 or mask == 6 or mask == 7 or mask == 9 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

StaticEvent.RequireClientTrigger = function(mask)
  -- function num : 0_8
  do return mask <= 6 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return StaticEvent

