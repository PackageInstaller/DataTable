local DirectionState = CS.PixelNeko.Lua.DirectionState
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local NPCManager = {}

function NPCManager.CreateNpcUI()
  DialogManager.CreateSingletonDialog("npc.npcuidialog")
end

function NPCManager.DestroyNpcUI()
  DialogManager.DestroySingletonDialog("npc.npcuidialog")
end

function NPCManager.ShowNpcUI()
  local dialog = DialogManager.GetDialog("npc.npcuidialog")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
  dialog = DialogManager.GetDialog("npc.npcactbutton")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
end

function NPCManager.HideNpcUI()
  local dialog = DialogManager.GetDialog("npc.npcuidialog")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
  dialog = DialogManager.GetDialog("npc.npcactbutton")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
end

NPCManager.eventList = {}

function NPCManager.RefreshList()
  local head = NPCManager.eventList[1]
  if not head or not head.active then
    DialogManager.DestroySingletonDialog("npc.npcactbutton")
  else
    DialogManager.CreateSingletonDialog("npc.npcactbutton"):SetData(head.eventId, head.id)
  end
end

function NPCManager.SetActButton(eventid, npcID)
  NPCManager.RemoveActButton(npcID)
  table.insert(NPCManager.eventList, 1, {
    eventId = eventid,
    id = npcID,
    active = true
  })
  NPCManager.RefreshList()
end

function NPCManager.RemoveActButton(npcID)
  if npcID then
    for id, v in ipairs(NPCManager.eventList) do
      if v.id == npcID then
        EventManager.RemoveEvent(v.eventId)
        table.remove(NPCManager.eventList, id)
      end
    end
    NPCManager.RefreshList()
  else
    LogError("NPCManager", "remove act button need one eventId")
  end
end

function NPCManager.ClearActButton()
  for _, v in pairs(NPCManager.eventList) do
    EventManager.RemoveEvent(v.eventId)
  end
  NPCManager.eventList = {}
  DialogManager.DestroySingletonDialog("npc.npcactbutton")
end

function NPCManager.SetEventData(npcID, eventid)
  if npcID then
    local found = false
    for i, v in ipairs(NPCManager.eventList) do
      if v.id == npcID then
        v.eventId = eventid
        found = true
      end
    end
    if not found then
      table.insert(NPCManager.eventList, {eventId = eventid, id = npcID})
    end
    NPCManager.RefreshList()
  end
end

local function setUtility(poslist, dirlist, actor, x, y, index, dirs)
  poslist[index] = {}
  poslist[index].x = x
  poslist[index].y = y
  dirlist[index] = {}
  for _, v in ipairs(dirs) do
    table.insert(dirlist[index], v)
  end
  index = index + 1
  return index
end

function NPCManager.SetPosList(actor, position)
  local poslist = {}
  local dirlist = {}
  local index = 1
  index = setUtility(poslist, dirlist, actor, position.x - 1, position.y, index, {
    DirectionState.UpRight,
    DirectionState.Right,
    DirectionState.DownRight
  })
  index = setUtility(poslist, dirlist, actor, position.x + 1, position.y, index, {
    DirectionState.UpLeft,
    DirectionState.Left,
    DirectionState.DownLeft
  })
  index = setUtility(poslist, dirlist, actor, position.x, position.y - 1, index, {
    DirectionState.DownLeft,
    DirectionState.Down,
    DirectionState.DownRight
  })
  index = setUtility(poslist, dirlist, actor, position.x, position.y + 1, index, {
    DirectionState.UpLeft,
    DirectionState.Up,
    DirectionState.UpRight
  })
  setUtility(poslist, dirlist, actor, position.x, position.y, index, {})
  return poslist, dirlist
end

function NPCManager.AddNpcEvent(npcID, npcIns, poslist, dirlist)
  local event = EventManager.CreateEvent()
  local root = ComposedTrigger.Create(nil, event:GetID())
  local o = Or.Create()
  for i, _ in ipairs(poslist) do
    local a = And.Create()
    local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {
      poslist[i]
    })
    a:AddTask(trigger)
    trigger = TriggerManager.CreateTrigger("direction", event:GetID(), dirlist[i])
    a:AddTask(trigger)
    o:AddTask(a)
  end
  root:AddTask(o)
  event:AddTrigger("composed", root)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    NPCManager.SetActButton(event:GetID(), npcID)
    NPCManager.RemoveNPCEvent(npcID, npcIns, poslist, dirlist)
  end))
  EventManager.AddEvent(event)
  NPCManager.SetEventData(npcID, event:GetID())
end

function NPCManager.RemoveNPCEvent(npcID, npcIns, poslist, dirlist)
  local x, y = NekoData.BehaviorManager.BM_Dungeon:GetActorGridPosition()
  local dir = NekoData.BehaviorManager.BM_Dungeon:GetActorOrientation()
  local event = EventManager.CreateEvent()
  local root = ComposedTrigger.Create(nil, event:GetID())
  local a = And.Create()
  do
    local o = Or.Create()
    do
      local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {
        {x = x, y = y}
      })
      local n = Not.Create()
      n:SetTask(trigger)
      o:AddTask(n)
    end
    do
      local trigger = TriggerManager.CreateTrigger("direction", event:GetID(), {dir})
      local n = Not.Create()
      n:SetTask(trigger)
      o:AddTask(n)
    end
    a:AddTask(o)
  end
  if npcIns:BlockInConfig() then
    local o = Or.Create()
    do
      local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {
        npcIns:GetPosition()
      })
      local n = Not.Create()
      n:SetTask(trigger)
      o:AddTask(n)
    end
    do
      local dir
      for i, v in pairs(poslist) do
        if v.x == x and v.y == y then
          dir = dirlist[i]
          break
        end
      end
      local trigger = TriggerManager.CreateTrigger("direction", event:GetID(), dir)
      local n = Not.Create()
      n:SetTask(trigger)
      o:AddTask(n)
    end
    a:AddTask(o)
  end
  root:AddTask(a)
  event:AddTrigger("composed", root)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    local cx, cy = NekoData.BehaviorManager.BM_Dungeon:GetActorGridPosition()
    local cdir = NekoData.BehaviorManager.BM_Dungeon:GetActorOrientation()
    NPCManager.RemoveActButton(npcID)
    NPCManager.AddNpcEvent(npcID, npcIns, poslist, dirlist)
  end))
  EventManager.AddEvent(event)
  NPCManager.SetEventData(npcID, event:GetID())
end

function NPCManager.FinishNPCEvent(serviceID)
  local NpcServiceAll = BeanManager.GetTableByName("npc.cserviceall")
  local server = NpcServiceAll:GetRecorder(serviceID)
  StaticEvent.CreateNPCEffect(server.effect):Run()
end

function NPCManager.BuildNPCInteractiveEffect(effectid)
  local effect = StaticEvent.CreateNPCEffect(effectid)
  effect:AddEffect(EffectFactory.CreateCustomEffect(function()
    NPCManager.HideNpcUI()
    EffectFactory.CreateThawEffect():Run()
  end))
  return effect
end

return NPCManager
