-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/event/eventmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EventManager = {}
local Event = require("logic.scene.luaevent.event.event")
local TransactionalEvent = require("logic.scene.luaevent.event.transactionalevent")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local cSceneJump = (BeanManager.GetTableByName)("scene.cscenejump")
local ctimelinebyselection = (BeanManager.GetTableByName)("event.ctimelinebyselection")
local _id = 0
local _sceneEvents = {}
local _globalEvents = {}
local _finishedEvents = {}
local _delay_changes = {}
local _updating = false
local _changed = false
local _loading = false
EventManager.Init = function()
  -- function num : 0_0 , upvalues : _sceneEvents, _globalEvents, _finishedEvents, _delay_changes, _updating, _id, _changed, _loading
  _sceneEvents = {
inactive = {}
, 
active = {}
}
  _globalEvents = {
inactive = {}
, 
active = {}
}
  _finishedEvents = {}
  _delay_changes = {
add = {}
, 
delete = {}
}
  _updating = false
  _id = 0
  _changed = false
  _loading = false
end

EventManager.UnInit = function()
  -- function num : 0_1 , upvalues : _sceneEvents, _globalEvents, _delay_changes, _updating, _id, _changed, _finishedEvents, _loading
  _sceneEvents = nil
  _globalEvents = nil
  _delay_changes = nil
  _updating = false
  _id = 0
  _changed = false
  _finishedEvents = nil
  _loading = false
end

EventManager.CreateEvent = function(repeate)
  -- function num : 0_2 , upvalues : _id, Event
  _id = _id + 1
  local event = (Event.Create)(_id, repeate)
  return event
end

EventManager.CreateTransactionalEvent = function(repeate, type)
  -- function num : 0_3 , upvalues : _id, TransactionalEvent
  _id = _id + 1
  local event = (TransactionalEvent.Create)(_id, repeate, type)
  return event
end

local addevent_impl = function(event, global)
  -- function num : 0_4 , upvalues : _globalEvents, _sceneEvents
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  if global then
    (_globalEvents.inactive)[event:GetID()] = event
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (_sceneEvents.inactive)[event:GetID()] = event
  end
  event:Activate()
end

EventManager.AddEvent = function(event, global)
  -- function num : 0_5 , upvalues : _updating, _delay_changes, addevent_impl
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if _updating then
    (_delay_changes.add)[#_delay_changes.add + 1] = event
  else
    addevent_impl(event, global)
  end
end

local remove = function(id, list)
  -- function num : 0_6 , upvalues : _ENV, _updating, _delay_changes
  for _,v in pairs(list) do
    if v[id] then
      local event = v[id]
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R8 in 'UnsetPending'

      if _updating then
        (_delay_changes.delete)[id] = true
      else
        event:Destroy()
        v[id] = nil
      end
      return event
    end
  end
  return false
end

local remove_by_cfgid = function(cfgid, list)
  -- function num : 0_7 , upvalues : _ENV, _updating, _delay_changes
  for _,v in pairs(list) do
    for id,event in pairs(v) do
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R12 in 'UnsetPending'

      if event:GetConfigID() == cfgid then
        if _updating then
          (_delay_changes.delete)[id] = true
        else
          event:Destroy()
          v[id] = nil
        end
        return event
      end
    end
  end
  return false
end

local find_by_cfgid = function(cfgid, list)
  -- function num : 0_8 , upvalues : _ENV
  for _,v in pairs(list) do
    for id,event in pairs(v) do
      if event:GetConfigID() == cfgid then
        return event
      end
    end
  end
  return false
end

EventManager.RemoveEvent = function(id)
  -- function num : 0_9 , upvalues : remove, _sceneEvents, _globalEvents
  if not remove(id, _sceneEvents) then
    return remove(id, _globalEvents)
  end
end

EventManager.RemoveByConfigID = function(id)
  -- function num : 0_10 , upvalues : _loading, remove_by_cfgid, _sceneEvents, _globalEvents
  if _loading then
    _loading[id] = true
  end
  if not remove_by_cfgid(id, _sceneEvents) then
    return remove_by_cfgid(id, _globalEvents)
  end
end

EventManager.FindByConfigID = function(id)
  -- function num : 0_11 , upvalues : find_by_cfgid, _sceneEvents, _globalEvents
  if not find_by_cfgid(id, _sceneEvents) then
    return find_by_cfgid(id, _globalEvents)
  end
end

local clean_list = function(list)
  -- function num : 0_12 , upvalues : _ENV
  for k,v in pairs(list) do
    for _,event in pairs(v) do
      event:Destroy()
    end
    list[k] = {}
  end
end

EventManager.Clear = function()
  -- function num : 0_13 , upvalues : clean_list, _sceneEvents, _globalEvents, _ENV, _finishedEvents
  clean_list(_sceneEvents)
  clean_list(_globalEvents)
  for k,v in pairs(_finishedEvents) do
    _finishedEvents[k] = nil
  end
end

EventManager.ClearSceneEvents = function()
  -- function num : 0_14 , upvalues : clean_list, _sceneEvents
  clean_list(_sceneEvents)
end

local update_list = function(list)
  -- function num : 0_15 , upvalues : _ENV, _delay_changes
  local id, event = next(list.active)
  if not event then
    return false
  end
  local preserved = {}
  while 1 do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

    if id and event then
      (list.active)[id] = nil
      if not (_delay_changes.delete)[id] then
        event:Fire()
        if event:IsRepeateEvent() then
          preserved[id] = event
        else
          event:Destroy()
        end
      else
        event:Destroy()
      end
      id = next(list.active)
      -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC36: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  for k,v in pairs(preserved) do
    if not (_delay_changes.delete)[k] then
      v:Reset()
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (list.inactive)[k] = v
    end
  end
  return true
end

EventManager.OnFixedUpdate = function()
  -- function num : 0_16 , upvalues : _changed, _updating, update_list, _sceneEvents, _globalEvents, _ENV, _delay_changes, remove, addevent_impl
  if not _changed then
    return 
  end
  _updating = true
  if not update_list(_sceneEvents) then
    local succ = update_list(_globalEvents)
  end
  _changed = false
  _updating = false
  local changes = clone(_delay_changes)
  _delay_changes.add = {}
  _delay_changes.delete = {}
  for id,v in pairs(changes.delete) do
    remove(id, _sceneEvents)
  end
  for _,v in ipairs(changes.add) do
    addevent_impl(v)
  end
  return succ
end

local check_list = function(eventid, list)
  -- function num : 0_17
  do
    if (list.inactive)[eventid] then
      local event = (list.inactive)[eventid]
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

      if event:IsTriggerFired() then
        (list.active)[eventid] = event
        -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (list.inactive)[eventid] = nil
        return true
      end
    end
    do
      if (list.active)[eventid] then
        local event = (list.active)[eventid]
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

        if not event:IsTriggerFired() then
          (list.inactive)[eventid] = event
          -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (list.active)[eventid] = nil
          return true
        end
      end
      return false
    end
  end
end

EventManager.OnTriggerStateChange = function(eventid)
  -- function num : 0_18 , upvalues : _changed, check_list, _sceneEvents, _globalEvents, EventManager
  if not check_list(eventid, _sceneEvents) then
    _changed = check_list(eventid, _globalEvents)
    ;
    (EventManager.OnFixedUpdate)()
  end
end

EventManager.LoadSceneEvents = function(sceneid, restore_info, reconnect)
  -- function num : 0_19 , upvalues : _loading, _ENV, StaticEvent, EventManager, cSceneJump, _finishedEvents, ctimelinebyselection
  _loading = {}
  if not restore_info then
    restore_info = {}
  end
  local recorder = (BeanManager.GetTableByName)("event.ceventconfig")
  for _,i in ipairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if (record.scene == sceneid or tostring(record.scene) == tostring(sceneid)) and not _loading[i] then
      local event = (StaticEvent.CreateFromConfig)(i)
      LogInfo("event", "add cfg event " .. i .. ", eventid " .. event:GetID())
      if restore_info[i] == 1 and (StaticEvent.IsEffectPersist)(event:GetConfigType()) then
        event:FireAlternative({init = true})
        if event:IsRepeateEvent() then
          (EventManager.AddEvent)((StaticEvent.CreateFromConfig)(event:GetConfigID()))
        end
      end
    end
    ;
    (EventManager.AddEvent)(event)
  end
  local record = cSceneJump:GetRecorder(sceneid)
  if record then
    if record.jumpType == 1 then
      for index = 1, #record.exitSituation do
        local event = ((EventManager.Builder).BuildSceneJumpEffect)(sceneid, (record.exitID)[index], (record.exitSituation)[index])
        ;
        (EventManager.AddEvent)(event)
      end
    else
      do
        if record.jumpType == 2 then
          for index = 1, #record.exitSituation do
            local event = ((EventManager.Builder).BuildFinishExploreEffect)(sceneid, (record.exitID)[index], (record.exitSituation)[index])
            ;
            (EventManager.AddEvent)(event)
          end
        end
        do
          for k,v in pairs(restore_info) do
            if v == 1 then
              _finishedEvents[k] = true
            end
          end
          for _,i in pairs(ctimelinebyselection:GetAllIds()) do
            local recorder = ctimelinebyselection:GetRecorder(i)
            if recorder.sceneID == sceneid and recorder.linkedEventID ~= reconnect and restore_info[recorder.linkedEventID] ~= 1 then
              local event = ((EventManager.Builder).BuildGuardEvent)(i)
              ;
              (EventManager.AddEvent)(event)
            end
          end
          _loading = false
        end
      end
    end
  end
end

EventManager.SaveDungeonFinishedEvent = function(eventId)
  -- function num : 0_20 , upvalues : _finishedEvents
  _finishedEvents[eventId] = true
end

EventManager.IsFinishedByEventID = function(id)
  -- function num : 0_21 , upvalues : _finishedEvents
  return _finishedEvents[id]
end

EventManager.Temp = {}
-- DECOMPILER ERROR at PC67: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Temp).AddDynamicEnemyBattleEvent = function(x, y, battleid)
  -- function num : 0_22 , upvalues : EventManager, _ENV
  local battleevent = (EventManager.CreateEvent)()
  local poslist = {
{x = x + 1, y = y}
, 
{x = x - 1, y = y}
, 
{x = x, y = y + 1}
, 
{x = x, y = y - 1}
}
  local postrigger = (TriggerManager.CreateTrigger)("gridpos", battleevent:GetID(), poslist, true)
  battleevent:AddTrigger("gridpos", postrigger)
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local effect = (EffectFactory.CreateBattleEffect)(battleid, function()
    -- function num : 0_22_0 , upvalues : active_controller, x, y
    active_controller:RemoveEnemy(x, y)
  end
)
  battleevent:AddEffect(effect)
  ;
  (EventManager.AddEvent)(battleevent)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Temp).AddJumpPoint = function(x, y)
  -- function num : 0_23 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {
{x = x, y = y}
}, true)
  event:AddTrigger("gridpos", trigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_23_0 , upvalues : _ENV
    local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    active_controller:Restart()
  end
)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Temp).Dump = function()
  -- function num : 0_24 , upvalues : _ENV, _sceneEvents
  local dump_impl = function(tbl, level, str)
    -- function num : 0_24_0 , upvalues : _ENV, dump_impl
    if not level then
      level = 0
    end
    if not str then
      str = ""
    end
    local tmp = ""
    for k,v in pairs(tbl) do
      if k ~= "__index" and type(v) ~= "function" then
        local tab = "|-"
        tab = (string.rep)("  ", level) .. tab
        if tab ~= "|-" then
          tmp = tmp .. tab .. "  " .. tostring(k) .. "  " .. type(k) .. "  " .. tostring(v) .. "  " .. type(v) .. "\n"
        else
          tmp = tmp .. tostring(k) .. "  " .. type(k) .. "  " .. tostring(v) .. "  " .. type(v) .. "\n"
        end
        if type(v) == "table" then
          tmp = tmp .. dump_impl(v, level + 1, str)
        end
      end
    end
    return tmp
  end

  local events = dump_impl(_sceneEvents)
  local controllers = dump_impl((TriggerManager.GetControllers)())
  LogWarning("event", "dumped events:\n" .. events)
  LogWarning("event", "dumped triggers:\n" .. controllers)
  local worldx, worldy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorWorldPosition()
  local gridx, gridy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  LogWarning("event", (string.format)("current actor: (%s, %s) aka (%s, %s)", gridx, gridy, worldx, worldy))
end

EventManager.Builder = {}
-- DECOMPILER ERROR at PC78: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildStaticBattleEvent = function(x, y, battleid, enemy_obj, callback)
  -- function num : 0_25 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)()
  local poslist = {
{x = x, y = y}
}
  local postrigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), poslist, true)
  event:AddTrigger("gridpos", postrigger)
  local cb = nil
  if enemy_obj then
    if callback then
      cb = function()
    -- function num : 0_25_0 , upvalues : enemy_obj, callback
    enemy_obj:SetActive(false)
    callback()
  end

    else
      cb = function()
    -- function num : 0_25_1 , upvalues : enemy_obj
    enemy_obj:SetActive(false)
  end

    end
  end
  local effect = (EffectFactory.CreateBattleEffect)(battleid, cb)
  event:AddEffect(effect)
  return event
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildRandomItemEvent = function(worldx, worldy, worldw, worldh, key)
  -- function num : 0_26 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)()
  local pos = {x = worldx - worldw / 2, y = worldy - worldh / 2, w = worldw, h = worldh}
  local trigger = (TriggerManager.CreateTrigger)("worldpos", event:GetID(), {pos})
  event:AddTrigger("worldpos", trigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_26_0 , upvalues : _ENV, key
    ((NekoData.BehaviorManager).BM_Dungeon):OnRandomItemPick(key)
  end
)
  event:AddEffect(effect)
  return event
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildPatrolBattleEvent = function(colliderid, battleid, object, callback)
  -- function num : 0_27 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("collision", event:GetID(), tostring(colliderid))
  event:AddTrigger("collision", trigger)
  local cb = function()
    -- function num : 0_27_0 , upvalues : callback
    if callback then
      callback()
    end
  end

  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_27_1 , upvalues : _ENV, object, colliderid
    (((((CS.PixelNeko).P1).Scene).TrapHelper).PausePatrol)(object)
    ;
    (((((CS.PixelNeko).P1).Scene).TrapHelper).PauseChase)(object)
    local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
    if controller and controller.OnMonsterBattle then
      controller:OnMonsterBattle(colliderid)
    end
  end
)
  event:AddEffect(effect)
  effect = (EffectFactory.CreateBattleEffect)(battleid, cb)
  event:AddEffect(effect)
  return event
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildSceneJumpEffect = function(mapid, exitid, exitSituation)
  -- function num : 0_28 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)(true)
  local poslist = {}
  local exitInfo = (string.split)(exitSituation, ",")
  local xPos = tonumber(exitInfo[1])
  local yPos = tonumber(exitInfo[2])
  local xWidth = tonumber(exitInfo[3])
  local yWidth = tonumber(exitInfo[4])
  for i = 0, xWidth do
    local posx = xPos + i
    for j = 0, yWidth do
      (table.insert)(poslist, {x = posx, y = yPos + j})
    end
  end
  local postrigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), poslist, true)
  event:AddTrigger("gridpos", postrigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_28_0 , upvalues : _ENV, mapid, exitid
    local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dialog then
      dialog:OnPointerCancel()
    end
    ;
    ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
    dialog = (DialogManager.GetDialog)("confirmbox.secondconfirmdialog")
    if dialog and dialog:GetCurMessageId() == 33 then
      return 
    end
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(33, nil, function()
      -- function num : 0_28_0_0 , upvalues : _ENV, mapid, exitid
      local req = (LuaNetManager.CreateProtocol)("protocol.battle.centerjumppoint")
      req.id = mapid
      req.outpoint = exitid
      req:Send()
    end
, {}, nil, {})
  end
)
  event:AddEffect(effect)
  return event
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildFinishExploreEffect = function(mapid, exitid, exitSituation)
  -- function num : 0_29 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)(true)
  local poslist = {}
  local exitInfo = (string.split)(exitSituation, ",")
  local xPos = tonumber(exitInfo[1])
  local yPos = tonumber(exitInfo[2])
  local xWidth = tonumber(exitInfo[3])
  local yWidth = tonumber(exitInfo[4])
  for i = 0, xWidth do
    local posx = xPos + i
    for j = 0, yWidth do
      (table.insert)(poslist, {x = posx, y = yPos + j})
    end
  end
  local postrigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), poslist, true)
  event:AddTrigger("gridpos", postrigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_29_0 , upvalues : _ENV, mapid, exitid
    local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
    if dialog then
      dialog:OnPointerCancel()
    end
    ;
    ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
    dialog = (DialogManager.GetDialog)("confirmbox.secondconfirmdialog")
    if dialog and dialog:GetCurMessageId() == 34 then
      return 
    end
    local floorID = ((NekoData.BehaviorManager).BM_Game):GetFloorIDWithSceneID(mapid)
    if not ((NekoData.BehaviorManager).BM_Game):GetFloorIsPassWithMainLineId(floorID) and ((NekoData.BehaviorManager).BM_Game):GetFloorIsNeedToBack(floorID) then
      ((DialogManager.CreateSingletonDialog)("dungeon.autoreturnconfirmdialog")):SetCallBack(function()
      -- function num : 0_29_0_0 , upvalues : _ENV, mapid, exitid
      local req = (LuaNetManager.CreateProtocol)("protocol.battle.ccompletezone")
      req.floorId = mapid
      req.outPoint = exitid
      req:Send()
    end
)
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(34, nil, function()
      -- function num : 0_29_0_1 , upvalues : _ENV, mapid, exitid
      local req = (LuaNetManager.CreateProtocol)("protocol.battle.ccompletezone")
      req.floorId = mapid
      req.outPoint = exitid
      req:Send()
    end
, {}, nil, {})
    end
  end
)
  event:AddEffect(effect)
  return event
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildGuardEvent = function(id)
  -- function num : 0_30 , upvalues : ctimelinebyselection, EventManager, _ENV
  local recorder = ctimelinebyselection:GetRecorder(id)
  local event = (EventManager.CreateEvent)()
  local pos = (string.split)(recorder.area, ",")
  pos = {x = tonumber(pos[1]), y = tonumber(pos[2]), w = tonumber(pos[3]), h = tonumber(pos[4])}
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {pos})
  event:AddTrigger(trigger:GetType(), trigger)
  event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_30_0 , upvalues : _ENV, recorder, EventManager, id
    ((EffectFactory.CreateFreezeEffect)()):Run()
    ;
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(recorder.confirmID, nil, function()
      -- function num : 0_30_0_0 , upvalues : _ENV, recorder
      local root = (EffectFactory.CreateComposedEffect)()
      root:AddEffect((EffectFactory.CreateTimelineEffect)(recorder.timelineConfirm))
      root:AddEffect((EffectFactory.CreateThawEffect)())
      root:Run()
    end
, nil, function()
      -- function num : 0_30_0_1 , upvalues : _ENV, recorder, EventManager, id
      local root = (EffectFactory.CreateComposedEffect)()
      root:AddEffect((EffectFactory.CreateTimelineEffect)(recorder.timelineCancel))
      root:AddEffect((EffectFactory.CreateCustomEffect)(function()
        -- function num : 0_30_0_1_0 , upvalues : EventManager, id
        local e = ((EventManager.Builder).BuildGuardEvent)(id)
        ;
        (EventManager.AddEvent)(e)
      end
))
      root:AddEffect((EffectFactory.CreateThawEffect)())
      root:Run()
    end
, nil)
  end
))
  return event
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R21 in 'UnsetPending'

;
(EventManager.Builder).BuildHintEvent = function(area, typeid, random, priority)
  -- function num : 0_31 , upvalues : EventManager, _ENV
  local event = (EventManager.CreateEvent)(false)
  local trigger = (TriggerManager.CreateTrigger)("gridpos", event:GetID(), {area}, true)
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_31_0 , upvalues : _ENV, priority, random, typeid
    local dialog = (DialogManager.GetDialog)("dungeon.hint.dungeonhintdialog")
    -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

    if dialog and priority <= dialog:GetPriority() then
      return 
    end
    dialog = (DialogManager.CreateSingletonDialog)("dungeon.hint.dungeonhintdialog")
    dialog:SetPriority(priority)
    if not typeid then
      dialog:PlayRandomChat(not random or 1)
      dialog:PlayFixedChat(typeid or 1)
    end
  end
)
  event:AddEffect(effect)
  return event
end

return EventManager

