local Event = class("Event")

function Event:Ctor(id, repeate)
  self._id = id
  self._repeate = repeate
  self._triggers = {}
  self._effects = {}
end

function Event:Destroy()
  for type, triggers in pairs(self._triggers) do
    for _, trigger in pairs(triggers) do
      if type == "composed" then
        trigger:Destroy()
      else
        TriggerManager.RemoveTrigger(type, trigger:GetID())
      end
    end
  end
  self._triggers = {}
  for _, v in pairs(self._effects) do
    v:Destroy()
  end
end

function Event:GetID()
  return self._id
end

function Event:SetConfigID(id)
  if id ~= self._cfgid then
    self._cfg = BeanManager.GetTableByName("event.ceventconfig"):GetRecorder(id)
  end
  self._cfgid = id
end

function Event:GetConfigID()
  return self._cfgid
end

function Event:IsRepeateEvent()
  return self._repeate
end

function Event:GetConfigType()
  return self._cfg.eventType
end

function Event:AddTrigger(type, trigger)
  self._triggers[type] = self._triggers[type] or {}
  for _, v in pairs(self._triggers[type]) do
    if v:GetID() == trigger:GetID() then
      LogError("event", "add existing trigger")
      return false
    end
  end
  table.insert(self._triggers[type], trigger)
  return true
end

function Event:Activate()
  for type, triggers in pairs(self._triggers) do
    if type == "composed" then
      for _, trigger in pairs(triggers) do
        trigger:Activate()
      end
    else
      for _, trigger in pairs(triggers) do
        TriggerManager.AddTrigger(type, trigger)
      end
    end
  end
end

local function remove_if(tbl, pred)
  for i, v in ipairs(tbl) do
    if pred(v) then
      table.remove(tbl, i)
      return true
    end
  end
  return false
end

function Event:RemoveTrigger(type, triggerid)
  local function pred(arg)
    return arg:GetID() == triggerid
  end
  
  if self._triggers[type] then
    return remove_if(self._triggers[type], pred)
  else
    for _, v in pairs(self._triggers) do
      if remove_if(v, pred) then
        return true
      end
    end
    return false
  end
end

function Event:Reset()
  for type, triggers in pairs(self._triggers) do
    if type == "composed" then
      for _, trigger in pairs(triggers) do
        trigger:Reset()
      end
    else
      for _, trigger in pairs(triggers) do
        trigger:SetState(0)
      end
    end
  end
end

function Event:GetTriggers()
  return self._triggers
end

function Event:AddEffect(effect)
  table.insert(self._effects, effect)
end

function Event:AddAlternativeEffect(effect)
  self._alternatives = self._alternatives or {}
  table.insert(self._alternatives, effect)
end

function Event:Fire(args)
  for _, v in ipairs(self._effects) do
    v:Run(args)
  end
end

function Event:FireAlternative(args)
  for _, v in ipairs(self._alternatives or self._effects) do
    v:Run(args)
  end
end

function Event:IsTriggerFired()
  local any = false
  for type, v in pairs(self._triggers) do
    any = true
    if type == "composed" then
      for _, trigger in pairs(v) do
        if not trigger:Check() then
          return false
        end
      end
    else
      for _, trigger in pairs(v) do
        if not trigger:GetState() then
          return false
        end
      end
    end
  end
  return any
end

function Event:Dump()
  local str = "event " .. self._id .. " with trigger "
  for t, v in pairs(self._triggers) do
    for _, vv in pairs(v) do
      str = str .. vv:GetID() .. ":(" .. t .. ", " .. vv:GetEventID() .. ")" .. "@" .. tostring(vv) .. ", "
    end
  end
end

function Event:GetMinimapPosition()
  if self._cfgid then
    local pos = string.split(self._cfg.coordinate, ",")
    return {
      x = tonumber(pos[1]),
      y = tonumber(pos[2])
    }
  end
end

function Event:GetMinimapIcon()
  if self._cfgid then
    return self._cfg.imageId
  end
end

function Event:ShowInMinimap()
  if self._cfgid then
    return self._cfg.isShowMinimapIcon == 1
  end
  return false
end

return Event
