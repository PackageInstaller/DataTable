local DirectionState = CS.PixelNeko.Lua.DirectionState
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local Or = require("logic.scene.luaevent.trigger.composed.triggeror")
local And = require("logic.scene.luaevent.trigger.composed.triggerand")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local ButtonEffects = require("logic.scene.interaction.buttoneffects")
local UIInteraction = {}

function UIInteraction.CreateUIHUD()
  local dialog = DialogManager.CreateSingletonDialog("dungeon.dungeonhud")
  dialog:Refresh()
end

function UIInteraction.DestroyUIHUD()
  DialogManager.DestroySingletonDialog("dungeon.dungeonhud")
end

function UIInteraction.ShowUIHUD()
  local dialog = DialogManager.GetDialog("dungeon.dungeonhud")
  if dialog then
    dialog:SetActive(true)
    dialog:Refresh()
  end
end

function UIInteraction.HideUIHUD()
  local dialog = DialogManager.GetDialog("dungeon.dungeonhud")
  if dialog then
    dialog:SetActive(false)
  end
end

local function setUtility(poslist, dirlist, actorObj, x, y, dirs)
  poslist[#poslist + 1] = {x = x, y = y}
  dirlist[#dirlist + 1] = clone(dirs)
  return #poslist
end

local function SetPosList(actorObj, position, no_block)
  local poslist = {}
  local dirlist = {}
  for i = position.y, position.y + position.h - 1 do
    setUtility(poslist, dirlist, actorObj, position.x - 1, i, {
      DirectionState.UpRight,
      DirectionState.Right,
      DirectionState.DownRight
    })
    setUtility(poslist, dirlist, actorObj, position.x + position.w, i, {
      DirectionState.UpLeft,
      DirectionState.Left,
      DirectionState.DownLeft
    })
  end
  for i = position.x, position.x + position.w - 1 do
    setUtility(poslist, dirlist, actorObj, i, position.y - 1, {
      DirectionState.DownLeft,
      DirectionState.Down,
      DirectionState.DownRight
    })
    setUtility(poslist, dirlist, actorObj, i, position.y + position.h, {
      DirectionState.UpLeft,
      DirectionState.Up,
      DirectionState.UpRight
    })
  end
  if no_block then
    setUtility(poslist, dirlist, actorObj, position.x, position.y, {})
  end
  return poslist, dirlist
end

UIInteraction.eventList = {}

function UIInteraction.RefreshList()
  local head = UIInteraction.eventList[1]
  if not head or not head.type then
    DialogManager.DestroySingletonDialog("dungeon.dungeonact")
    DialogManager.DestroySingletonDialog("dungeon.dungeonskillbubble")
  elseif head.type ~= 3 then
    DialogManager.CreateSingletonDialog("dungeon.dungeonact"):SetData(head.eventid, head.type, head.value)
  else
    DialogManager.CreateSingletonDialog("dungeon.dungeonskillbubble"):SetData(head.eventid, head.value)
  end
end

function UIInteraction.SetActButton(eventid, id, value)
  UIInteraction.RemoveActButton(id)
  table.insert(UIInteraction.eventList, 1, {
    id = id,
    eventid = eventid,
    type = UIInteraction.GetInteractiveObj(id):GetType(),
    value = value
  })
  UIInteraction.RefreshList()
end

function UIInteraction.RemoveActButton(id)
  if id then
    for i, v in ipairs(UIInteraction.eventList) do
      if v.id == id then
        EventManager.RemoveEvent(v.eventid)
        table.remove(UIInteraction.eventList, i)
        break
      end
    end
    UIInteraction.RefreshList()
  else
    LogError("UIInteraction", "remove act button need id")
  end
end

function UIInteraction.SetEventData(id, eventid)
  if id then
    local found = false
    for i, v in ipairs(UIInteraction.eventList) do
      if v.id == id then
        v.eventid = eventid
        found = true
      end
    end
    if not found then
      table.insert(UIInteraction.eventList, {id = id, eventid = eventid})
    end
    UIInteraction.RefreshList()
  else
    LogError("UIInteraction", "remove act button need id")
  end
end

function UIInteraction.ClearActButton()
  for _, v in pairs(UIInteraction.eventList) do
    EventManager.RemoveEvent(v.eventid)
  end
  UIInteraction.eventList = {}
  DialogManager.DestroySingletonDialog("dungeon.dungeonact")
  DialogManager.DestroySingletonDialog("dungeon.dungeonskillbubble")
end

function UIInteraction.HideInteractiveUI()
  local dialog = DialogManager.GetDialog("dungeon.dungeonact")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
  dialog = DialogManager.GetDialog("dungeon.dungeonskillbubble")
  if dialog then
    dialog:GetRootWindow():SetActive(false)
  end
end

function UIInteraction.ShowInteractiveUI()
  local dialog = DialogManager.GetDialog("dungeon.dungeonact")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
  dialog = DialogManager.GetDialog("dungeon.dungeonskillbubble")
  if dialog then
    dialog:GetRootWindow():SetActive(true)
  end
end

UIInteraction.InteractiveObj = {}

function UIInteraction.AddSceneInteractiveObj(sceneObj)
  for _, obj in ipairs(UIInteraction.InteractiveObj) do
    if obj:GetInteractiveId() == sceneObj:GetInteractiveId() then
      LogError("UIInteraction", "there is already exist id " .. obj:GetInteractiveId())
      return false
    end
  end
  table.insert(UIInteraction.InteractiveObj, sceneObj)
  return true
end

function UIInteraction.RemoveSceneInteractiveObj(interactiveId)
  if interactiveId then
    for i, obj in ipairs(UIInteraction.InteractiveObj) do
      if obj:GetInteractiveId() == interactiveId then
        UIInteraction.RemoveActButton(interactiveId)
        table.remove(UIInteraction.InteractiveObj, i)
        obj:Destroy()
        return
      end
    end
  else
    LogError("UIInteraction", "no interactive Id giving")
  end
end

function UIInteraction.GetInteractiveObj(id)
  for _, obj in ipairs(UIInteraction.InteractiveObj) do
    if obj:GetInteractiveId() == id then
      return obj
    end
  end
end

function UIInteraction.ClearInteractiveObj()
  for _, obj in ipairs(UIInteraction.InteractiveObj) do
    obj:Destroy()
  end
  UIInteraction.InteractiveObj = {}
  LogInfo("UIInteraction", "have remove all interactive object in this scene")
end

function UIInteraction.SetInteractiveData(id)
  local sceneobject
  for _, obj in ipairs(UIInteraction.InteractiveObj) do
    if obj:GetInteractiveId() == id then
      sceneobject = obj
    end
  end
  if not sceneobject then
    LogWarning("UIInteraction", "there is no id " .. id .. " interactive object")
    return
  end
  local controller = SceneManager.GetSceneControllerByID(sceneobject:GetSceneId())
  local poslist, dirlist = SetPosList(controller._sceneRef.actor.object, sceneobject:GetPosition(), not sceneobject:BlockInConfig())
  UIInteraction.AddInteractiveEvent(sceneobject, poslist, dirlist, id)
end

function UIInteraction.AddInteractiveEvent(object, poslist, dirlist, value)
  if object:GetState() == 1 and not object:IsRepeat() then
    return
  end
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
    UIInteraction.SetActButton(event:GetID(), object:GetInteractiveId(), value)
    UIInteraction.RemoveInteractiveEvent(object, poslist, dirlist, value)
  end))
  EventManager.AddEvent(event)
  UIInteraction.SetEventData(object:GetInteractiveId(), event:GetID())
end

function UIInteraction.RemoveInteractiveEvent(object, poslist, dirlist, value)
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
  if object:BlockInConfig() then
    local o = Or.Create()
    do
      local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {
        object:GetPosition()
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
    UIInteraction.RemoveActButton(object:GetInteractiveId())
    if object:GetState() ~= 1 or object:IsRepeat() then
      UIInteraction.AddInteractiveEvent(object, poslist, dirlist, value)
    end
  end))
  EventManager.AddEvent(event)
  UIInteraction.SetEventData(object:GetInteractiveId(), event:GetID())
end

local function FaceTo(actorObj, pos)
  local x, y, z = CS.PixelNeko.Lua.TransformStaticFunctions.GetPosition(actorObj)
  local ax = math.floor(x / 0.4 + 0.5)
  local ay = math.floor(z * -1 / 0.56 + 0.5)
  if ax == pos.x and ay == pos.y - 1 then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(actorObj, 4)
  elseif ax == pos.x and ay == pos.y + 1 then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(actorObj, 0)
  elseif ax == pos.x - 1 and ay == pos.y then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(actorObj, 2)
  elseif ax == pos.x + 1 and ay == pos.y then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(actorObj, 6)
  end
end

local function LuaUIInteractionStopMoving(_controller, _actor, _eventid, _whichone)
  return function()
    for _, v in pairs(UIInteraction.eventList) do
      if v.eventid == _eventid then
        local sceneobject = UIInteraction.GetInteractiveObj(v.id)
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
            DialogManager.CreateSingletonDialog("login.eventreconnectdialog")
            local req = LuaNetManager.CreateProtocol("protocol.battle.cdungeonoption")
            req.optionId = sceneobject:GetInteractiveId()
            req:Send()
            DialogManager.DestroySingletonDialog("dungeon.dungeonact")
          end
        elseif sceneobject:GetType() == 2 then
          local effect = StaticEvent.CreateInteractiveEffect(sceneobject:GetInteractiveId())
        elseif sceneobject:GetType() == 3 then
          local effect = StaticEvent.CreateInteractiveEffect(sceneobject:GetInteractiveId())
        end
      end
    end
  end
end

function UIInteraction.RemoveUIReactEvent(controller, eventid, whichone)
  local actor = controller._sceneRef.actor.object
  local callback = LuaUIInteractionStopMoving(controller, actor, eventid, whichone)
  return callback()
end

return UIInteraction
