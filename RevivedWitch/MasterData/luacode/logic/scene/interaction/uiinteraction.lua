-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/interaction/uiinteraction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DirectionState = ((CS.PixelNeko).Lua).DirectionState
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local ButtonEffects = require("logic.scene.interaction.buttoneffects")
local UIInteraction = {}
UIInteraction.CreateUIHUD = function()
  -- function num : 0_0 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonhud")
  dialog:Refresh()
end

UIInteraction.DestroyUIHUD = function()
  -- function num : 0_1 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonhud")
end

UIInteraction.ShowUIHUD = function()
  -- function num : 0_2 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
  if dialog then
    dialog:SetActive(true)
    dialog:Refresh()
  end
end

UIInteraction.HideUIHUD = function()
  -- function num : 0_3 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
  if dialog then
    dialog:SetActive(false)
  end
end

local setUtility = function(poslist, dirlist, actorObj, x, y, dirs)
  -- function num : 0_4 , upvalues : _ENV
  poslist[#poslist + 1] = {x = x, y = y}
  dirlist[#dirlist + 1] = clone(dirs)
  return #poslist
end

local SetPosList = function(actorObj, position, no_block)
  -- function num : 0_5 , upvalues : setUtility, DirectionState
  local poslist = {}
  local dirlist = {}
  for i = position.y, position.y + position.h - 1 do
    setUtility(poslist, dirlist, actorObj, position.x - 1, i, {DirectionState.UpRight, DirectionState.Right, DirectionState.DownRight})
    setUtility(poslist, dirlist, actorObj, position.x + position.w, i, {DirectionState.UpLeft, DirectionState.Left, DirectionState.DownLeft})
  end
  for i = position.x, position.x + position.w - 1 do
    setUtility(poslist, dirlist, actorObj, i, position.y - 1, {DirectionState.DownLeft, DirectionState.Down, DirectionState.DownRight})
    setUtility(poslist, dirlist, actorObj, i, position.y + position.h, {DirectionState.UpLeft, DirectionState.Up, DirectionState.UpRight})
  end
  if no_block then
    setUtility(poslist, dirlist, actorObj, position.x, position.y, {})
  end
  return poslist, dirlist
end

UIInteraction.eventList = {}
UIInteraction.RefreshList = function()
  -- function num : 0_6 , upvalues : UIInteraction, _ENV
  local head = (UIInteraction.eventList)[1]
  if not head or not head.type then
    (DialogManager.DestroySingletonDialog)("dungeon.dungeonact")
    ;
    (DialogManager.DestroySingletonDialog)("dungeon.dungeonskillbubble")
  else
    if head.type ~= 3 then
      ((DialogManager.CreateSingletonDialog)("dungeon.dungeonact")):SetData(head.eventid, head.type, head.value)
    else
      ;
      ((DialogManager.CreateSingletonDialog)("dungeon.dungeonskillbubble")):SetData(head.eventid, head.value)
    end
  end
end

UIInteraction.SetActButton = function(eventid, id, value)
  -- function num : 0_7 , upvalues : UIInteraction, _ENV
  (UIInteraction.RemoveActButton)(id)
  ;
  (table.insert)(UIInteraction.eventList, 1, {id = id, eventid = eventid, type = ((UIInteraction.GetInteractiveObj)(id)):GetType(), value = value})
  ;
  (UIInteraction.RefreshList)()
end

UIInteraction.RemoveActButton = function(id)
  -- function num : 0_8 , upvalues : _ENV, UIInteraction
  if id then
    for i,v in ipairs(UIInteraction.eventList) do
      if v.id == id then
        (EventManager.RemoveEvent)(v.eventid)
        ;
        (table.remove)(UIInteraction.eventList, i)
        break
      end
    end
    do
      ;
      (UIInteraction.RefreshList)()
      LogError("UIInteraction", "remove act button need id")
    end
  end
end

UIInteraction.SetEventData = function(id, eventid)
  -- function num : 0_9 , upvalues : _ENV, UIInteraction
  if id then
    local found = false
    for i,v in ipairs(UIInteraction.eventList) do
      if v.id == id then
        v.eventid = eventid
        found = true
      end
    end
    if not found then
      (table.insert)(UIInteraction.eventList, {id = id, eventid = eventid})
    end
    ;
    (UIInteraction.RefreshList)()
  else
    do
      LogError("UIInteraction", "remove act button need id")
    end
  end
end

UIInteraction.ClearActButton = function()
  -- function num : 0_10 , upvalues : _ENV, UIInteraction
  for _,v in pairs(UIInteraction.eventList) do
    (EventManager.RemoveEvent)(v.eventid)
  end
  UIInteraction.eventList = {}
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonact")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.dungeonskillbubble")
end

UIInteraction.HideInteractiveUI = function()
  -- function num : 0_11 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("dungeon.dungeonact")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
  dialog = (DialogManager.GetDialog)("dungeon.dungeonskillbubble")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
end

UIInteraction.ShowInteractiveUI = function()
  -- function num : 0_12 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("dungeon.dungeonact")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
  dialog = (DialogManager.GetDialog)("dungeon.dungeonskillbubble")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
end

UIInteraction.InteractiveObj = {}
UIInteraction.AddSceneInteractiveObj = function(sceneObj)
  -- function num : 0_13 , upvalues : _ENV, UIInteraction
  for _,obj in ipairs(UIInteraction.InteractiveObj) do
    if obj:GetInteractiveId() == sceneObj:GetInteractiveId() then
      LogError("UIInteraction", "there is already exist id " .. obj:GetInteractiveId())
      return false
    end
  end
  ;
  (table.insert)(UIInteraction.InteractiveObj, sceneObj)
  return true
end

UIInteraction.RemoveSceneInteractiveObj = function(interactiveId)
  -- function num : 0_14 , upvalues : _ENV, UIInteraction
  if interactiveId then
    for i,obj in ipairs(UIInteraction.InteractiveObj) do
      if obj:GetInteractiveId() == interactiveId then
        (UIInteraction.RemoveActButton)(interactiveId)
        ;
        (table.remove)(UIInteraction.InteractiveObj, i)
        obj:Destroy()
        return 
      end
    end
  else
    do
      LogError("UIInteraction", "no interactive Id giving")
    end
  end
end

UIInteraction.GetInteractiveObj = function(id)
  -- function num : 0_15 , upvalues : _ENV, UIInteraction
  for _,obj in ipairs(UIInteraction.InteractiveObj) do
    if obj:GetInteractiveId() == id then
      return obj
    end
  end
end

UIInteraction.ClearInteractiveObj = function()
  -- function num : 0_16 , upvalues : _ENV, UIInteraction
  for _,obj in ipairs(UIInteraction.InteractiveObj) do
    obj:Destroy()
  end
  UIInteraction.InteractiveObj = {}
  LogInfo("UIInteraction", "have remove all interactive object in this scene")
end

UIInteraction.SetInteractiveData = function(id)
  -- function num : 0_17 , upvalues : _ENV, UIInteraction, SetPosList
  local sceneobject = nil
  for _,obj in ipairs(UIInteraction.InteractiveObj) do
    if obj:GetInteractiveId() == id then
      sceneobject = obj
    end
  end
  if not sceneobject then
    LogWarning("UIInteraction", "there is no id " .. id .. " interactive object")
    return 
  end
  local controller = (SceneManager.GetSceneControllerByID)(sceneobject:GetSceneId())
  local poslist, dirlist = SetPosList(((controller._sceneRef).actor).object, sceneobject:GetPosition(), not sceneobject:BlockInConfig())
  ;
  (UIInteraction.AddInteractiveEvent)(sceneobject, poslist, dirlist, id)
end

UIInteraction.AddInteractiveEvent = function(object, poslist, dirlist, value)
  -- function num : 0_18 , upvalues : _ENV, ComposedTrigger, Or, And, UIInteraction
  if object:GetState() == 1 and not object:IsRepeat() then
    return 
  end
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
    -- function num : 0_18_0 , upvalues : UIInteraction, event, object, value, poslist, dirlist
    (UIInteraction.SetActButton)(event:GetID(), object:GetInteractiveId(), value)
    ;
    (UIInteraction.RemoveInteractiveEvent)(object, poslist, dirlist, value)
  end
))
  ;
  (EventManager.AddEvent)(event)
  ;
  (UIInteraction.SetEventData)(object:GetInteractiveId(), event:GetID())
end

UIInteraction.RemoveInteractiveEvent = function(object, poslist, dirlist, value)
  -- function num : 0_19 , upvalues : _ENV, ComposedTrigger, And, Or, Not, UIInteraction
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
        if object:BlockInConfig() then
          local o = (Or.Create)()
          local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {object:GetPosition()})
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
    -- function num : 0_19_0 , upvalues : UIInteraction, object, poslist, dirlist, value
    (UIInteraction.RemoveActButton)(object:GetInteractiveId())
    if object:GetState() ~= 1 or object:IsRepeat() then
      (UIInteraction.AddInteractiveEvent)(object, poslist, dirlist, value)
    end
  end
))
                  ;
                  (EventManager.AddEvent)(event)
                  ;
                  (UIInteraction.SetEventData)(object:GetInteractiveId(), event:GetID())
                end
              end
            end
          end
        end
      end
    end
  end
end

local FaceTo = function(actorObj, pos)
  -- function num : 0_20 , upvalues : _ENV
  local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(actorObj)
  local ax = (math.floor)(x / 0.4 + 0.5)
  local ay = (math.floor)(z * -1 / 0.56 + 0.5)
  if ax == pos.x and ay == pos.y - 1 then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(actorObj, 4)
  else
    if ax == pos.x and ay == pos.y + 1 then
      ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(actorObj, 0)
    else
      if ax == pos.x - 1 and ay == pos.y then
        ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(actorObj, 2)
      else
        if ax == pos.x + 1 and ay == pos.y then
          ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(actorObj, 6)
        end
      end
    end
  end
end

local LuaUIInteractionStopMoving = function(_controller, _actor, _eventid, _whichone)
  -- function num : 0_21 , upvalues : _ENV, UIInteraction, FaceTo, ButtonEffects, StaticEvent
  return function()
    -- function num : 0_21_0 , upvalues : _ENV, UIInteraction, _eventid, FaceTo, _actor, ButtonEffects, StaticEvent
    for _,v in pairs(UIInteraction.eventList) do
      if v.eventid == _eventid then
        local sceneobject = (UIInteraction.GetInteractiveObj)(v.id)
        FaceTo(_actor, sceneobject:GetPosition())
        if sceneobject:GetType() == 1 then
          local operation = sceneobject:GetOperation()
          if type(operation) == "table" then
            operation = operation[1]
          end
          local handler = ButtonEffects[operation]
          if handler then
            return handler(sceneobject)
          else
            ;
            (DialogManager.CreateSingletonDialog)("login.eventreconnectdialog")
            local req = (LuaNetManager.CreateProtocol)("protocol.battle.cdungeonoption")
            req.optionId = sceneobject:GetInteractiveId()
            req:Send()
            ;
            (DialogManager.DestroySingletonDialog)("dungeon.dungeonact")
          end
        else
        end
      end
      if sceneobject:GetType() == 2 then
        local effect = nil
      end
      -- DECOMPILER ERROR at PC63: Overwrote pending register: R6 in 'AssignReg'

      if ((StaticEvent.CreateInteractiveEffect)(sceneobject:GetInteractiveId()))(effect) == 3 then
        local effect = (StaticEvent.CreateInteractiveEffect)(effect:GetInteractiveId())
      end
    end
  end

end

UIInteraction.RemoveUIReactEvent = function(controller, eventid, whichone)
  -- function num : 0_22 , upvalues : LuaUIInteractionStopMoving
  local actor = ((controller._sceneRef).actor).object
  local callback = LuaUIInteractionStopMoving(controller, actor, eventid, whichone)
  return callback()
end

return UIInteraction

