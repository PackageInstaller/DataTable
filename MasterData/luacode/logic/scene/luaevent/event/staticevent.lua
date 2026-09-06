local StaticEvent = {}
local Triggers = require("data.dungeondata.event.cconditionconfig")
local Effects = require("data.dungeondata.event.ceffectconfig")
local SwitchEffects = require("data.dungeondata.trap.cswitcheffectconfig")
local InteractiveEffects = require("data.dungeondata.sceneinteractive.cinteractiveeffectconfig")
local NPCEffect = require("data.dungeondata.npc.cnpceffectconfig")

function StaticEvent.CreateFromConfig(id)
  print("create event from cfg", id, debug.traceback())
  local record = BeanManager.GetTableByName("event.ceventconfig"):GetRecorder(id)
  local event
  if StaticEvent.RequireReconnect(record.eventType) then
    event = EventManager.CreateTransactionalEvent(record.isrepeat == 1)
  else
    event = EventManager.CreateEvent(record.isrepeat == 1)
  end
  event:SetConfigID(id)
  if StaticEvent.RequireClientTrigger(record.eventType) then
    local trigger = Triggers[tonumber(record.condition)](event:GetID())
    event:AddTrigger(trigger:GetType(), trigger)
  end
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    LogWarning("staticevent", "trigger cfgid = " .. id .. ", " .. debug.traceback())
  end))
  local effect = Effects[record.effect]()
  event:AddEffect(effect)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    EventManager.SaveDungeonFinishedEvent(id)
    LuaNotificationCenter.PostNotification(Common.n_DungeonEventEnd, StaticEvent, id)
  end))
  if record.alternative_effect ~= -1 then
    event:AddAlternativeEffect(EffectFactory.CreateCustomEffect(function()
      LogWarning("staticevent", "alternative trigger cfgid = " .. id .. ", " .. debug.traceback())
    end))
    effect = Effects[record.alternative_effect]()
    event:AddAlternativeEffect(effect)
  end
  return event
end

function StaticEvent.CreateSwitchEffect(id, args)
  if id == 0 then
    return EffectFactory.CreateComposedEffect()
  end
  return SwitchEffects[id](args)
end

function StaticEvent.CreateTrapEffect(id, args)
  return StaticEvent.CreateSwitchEffect(id, args)
end

function StaticEvent.CreateInteractiveEffect(interactiveId)
  local record = BeanManager.GetTableByName("sceneinteractive.cinteractiveconfig"):GetRecorder(interactiveId)
  if record then
    local effectid = tonumber(record.effect)
    return InteractiveEffects[effectid](), record.reconnect == 1
  end
end

function StaticEvent.CreateNPCEffect(id)
  local effectid = tonumber(id)
  return NPCEffect[effectid]()
end

function StaticEvent.IsEffectPersist(mask)
  return mask == 3 or mask == 6 or mask == 8 or mask == 9
end

function StaticEvent.CanEffectRepeat(mask)
  return mask ~= 2 and mask ~= 5 and mask ~= 7
end

function StaticEvent.RequireReconnect(mask)
  return mask == 4 or mask == 5 or mask == 6 or mask == 7 or mask == 9
end

function StaticEvent.RequireClientTrigger(mask)
  return mask <= 6
end

return StaticEvent
