-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/npcmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DirectionState = ((CS.PixelNeko).Lua).DirectionState
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local NPCManager = {}
NPCManager.CreateNpcUI = function()
  -- function num : 0_0 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("npc.npcuidialog")
end

NPCManager.DestroyNpcUI = function()
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("npc.npcuidialog")
end

NPCManager.ShowNpcUI = function()
  -- function num : 0_2 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("npc.npcuidialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
  dialog = (DialogManager.GetDialog)("npc.npcactbutton")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
end

NPCManager.HideNpcUI = function()
  -- function num : 0_3 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("npc.npcuidialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
  dialog = (DialogManager.GetDialog)("npc.npcactbutton")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
end

NPCManager.eventList = {}
NPCManager.RefreshList = function()
  -- function num : 0_4 , upvalues : NPCManager, _ENV
  local head = (NPCManager.eventList)[1]
  if not head or not head.active then
    (DialogManager.DestroySingletonDialog)("npc.npcactbutton")
  else
    ;
    ((DialogManager.CreateSingletonDialog)("npc.npcactbutton")):SetData(head.eventId, head.id)
  end
end

NPCManager.SetActButton = function(eventid, npcID)
  -- function num : 0_5 , upvalues : NPCManager, _ENV
  (NPCManager.RemoveActButton)(npcID)
  ;
  (table.insert)(NPCManager.eventList, 1, {eventId = eventid, id = npcID, active = true})
  ;
  (NPCManager.RefreshList)()
end

NPCManager.RemoveActButton = function(npcID)
  -- function num : 0_6 , upvalues : _ENV, NPCManager
  if npcID then
    for id,v in ipairs(NPCManager.eventList) do
      if v.id == npcID then
        (EventManager.RemoveEvent)(v.eventId)
        ;
        (table.remove)(NPCManager.eventList, id)
      end
    end
    ;
    (NPCManager.RefreshList)()
  else
    LogError("NPCManager", "remove act button need one eventId")
  end
end

NPCManager.ClearActButton = function()
  -- function num : 0_7 , upvalues : _ENV, NPCManager
  for _,v in pairs(NPCManager.eventList) do
    (EventManager.RemoveEvent)(v.eventId)
  end
  NPCManager.eventList = {}
  ;
  (DialogManager.DestroySingletonDialog)("npc.npcactbutton")
end

NPCManager.SetEventData = function(npcID, eventid)
  -- function num : 0_8 , upvalues : _ENV, NPCManager
  if npcID then
    local found = false
    for i,v in ipairs(NPCManager.eventList) do
      if v.id == npcID then
        v.eventId = eventid
        found = true
      end
    end
    if not found then
      (table.insert)(NPCManager.eventList, {eventId = eventid, id = npcID})
    end
    ;
    (NPCManager.RefreshList)()
  end
end

local setUtility = function(poslist, dirlist, actor, x, y, index, dirs)
  -- function num : 0_9 , upvalues : _ENV
  poslist[index] = {}
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (poslist[index]).x = x
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (poslist[index]).y = y
  dirlist[index] = {}
  for _,v in ipairs(dirs) do
    (table.insert)(dirlist[index], v)
  end
  index = index + 1
  return index
end

NPCManager.SetPosList = function(actor, position)
  -- function num : 0_10 , upvalues : setUtility, DirectionState
  local poslist = {}
  local dirlist = {}
  local index = 1
  index = setUtility(poslist, dirlist, actor, position.x - 1, position.y, index, {DirectionState.UpRight, DirectionState.Right, DirectionState.DownRight})
  index = setUtility(poslist, dirlist, actor, position.x + 1, position.y, index, {DirectionState.UpLeft, DirectionState.Left, DirectionState.DownLeft})
  index = setUtility(poslist, dirlist, actor, position.x, position.y - 1, index, {DirectionState.DownLeft, DirectionState.Down, DirectionState.DownRight})
  index = setUtility(poslist, dirlist, actor, position.x, position.y + 1, index, {DirectionState.UpLeft, DirectionState.Up, DirectionState.UpRight})
  setUtility(poslist, dirlist, actor, position.x, position.y, index, {})
  return poslist, dirlist
end

NPCManager.AddNpcEvent = function(npcID, npcIns, poslist, dirlist)
  -- function num : 0_11 , upvalues : _ENV, ComposedTrigger, Or, And, NPCManager
  local event = (EventManager.CreateEvent)()
  local root = (ComposedTrigger.Create)(nil, event:GetID())
  local o = (Or.Create)()
  for i,_ in ipairs(poslist) do
    local a = (And.Create)()
    local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {poslist[i]})
    a:AddTask(trigger)
    trigger = (TriggerManager.CreateTrigger)("direction", event:GetID(), dirlist[i])
    a:AddTask(trigger)
    o:AddTask(a)
  end
  root:AddTask(o)
  event:AddTrigger("composed", root)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_11_0 , upvalues : NPCManager, event, npcID, npcIns, poslist, dirlist
    (NPCManager.SetActButton)(event:GetID(), npcID)
    ;
    (NPCManager.RemoveNPCEvent)(npcID, npcIns, poslist, dirlist)
  end
))
  ;
  (EventManager.AddEvent)(event)
  ;
  (NPCManager.SetEventData)(npcID, event:GetID())
end

NPCManager.RemoveNPCEvent = function(npcID, npcIns, poslist, dirlist)
  -- function num : 0_12 , upvalues : _ENV, ComposedTrigger, And, Or, Not, NPCManager
  local x, y = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  local dir = ((NekoData.BehaviorManager).BM_Dungeon):GetActorOrientation()
  local event = (EventManager.CreateEvent)()
  local root = (ComposedTrigger.Create)(nil, event:GetID())
  local a = (And.Create)()
  local o = (Or.Create)()
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {
{x = x, y = y}
})
  do
    local n = (Not.Create)()
    n:SetTask(trigger)
    o:AddTask(n)
    local trigger = (TriggerManager.CreateTrigger)("direction", event:GetID(), {dir})
    do
      do
        local n = (Not.Create)()
        n:SetTask(trigger)
        o:AddTask(n)
        a:AddTask(o)
        if npcIns:BlockInConfig() then
          local o = (Or.Create)()
          local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {npcIns:GetPosition()})
          do
            local n = (Not.Create)()
            n:SetTask(trigger)
            o:AddTask(n)
            local dir = nil
            for i,v in pairs(poslist) do
              if v.x == x and v.y == y then
                dir = dirlist[i]
                break
              end
            end
            do
              local trigger = (TriggerManager.CreateTrigger)("direction", event:GetID(), dir)
              do
                do
                  local n = (Not.Create)()
                  n:SetTask(trigger)
                  o:AddTask(n)
                  a:AddTask(o)
                  root:AddTask(a)
                  event:AddTrigger("composed", root)
                  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_12_0 , upvalues : _ENV, NPCManager, npcID, npcIns, poslist, dirlist
    local cx, cy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
    local cdir = ((NekoData.BehaviorManager).BM_Dungeon):GetActorOrientation()
    ;
    (NPCManager.RemoveActButton)(npcID)
    ;
    (NPCManager.AddNpcEvent)(npcID, npcIns, poslist, dirlist)
  end
))
                  ;
                  (EventManager.AddEvent)(event)
                  ;
                  (NPCManager.SetEventData)(npcID, event:GetID())
                end
              end
            end
          end
        end
      end
    end
  end
end

NPCManager.FinishNPCEvent = function(serviceID)
  -- function num : 0_13 , upvalues : _ENV, StaticEvent
  local NpcServiceAll = (BeanManager.GetTableByName)("npc.cserviceall")
  local server = NpcServiceAll:GetRecorder(serviceID)
  ;
  ((StaticEvent.CreateNPCEffect)(server.effect)):Run()
end

NPCManager.BuildNPCInteractiveEffect = function(effectid)
  -- function num : 0_14 , upvalues : StaticEvent, _ENV, NPCManager
  local effect = (StaticEvent.CreateNPCEffect)(effectid)
  effect:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_14_0 , upvalues : NPCManager, _ENV
    (NPCManager.HideNpcUI)()
    ;
    ((EffectFactory.CreateThawEffect)()):Run()
  end
))
  return effect
end

return NPCManager

