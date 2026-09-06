local EventManager = {}
local Event = require("logic.scene.luaevent.event.event")
local TransactionalEvent = require("logic.scene.luaevent.event.transactionalevent")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local cSceneJump = BeanManager.GetTableByName("scene.cscenejump")
local ctimelinebyselection = BeanManager.GetTableByName("event.ctimelinebyselection")
local _id = 0
local _sceneEvents = {}
local _globalEvents = {}
local _finishedEvents = {}
local _delay_changes = {}
local _updating = false
local _changed = false
local _loading = false

function EventManager.Init()
  _sceneEvents = {
    inactive = {},
    active = {}
  }
  _globalEvents = {
    inactive = {},
    active = {}
  }
  _finishedEvents = {}
  _delay_changes = {
    add = {},
    delete = {}
  }
  _updating = false
  _id = 0
  _changed = false
  _loading = false
end

function EventManager.UnInit()
  _sceneEvents = nil
  _globalEvents = nil
  _delay_changes = nil
  _updating = false
  _id = 0
  _changed = false
  _finishedEvents = nil
  _loading = false
end

function EventManager.CreateEvent(repeate)
  _id = _id + 1
  local event = Event.Create(_id, repeate)
  return event
end

function EventManager.CreateTransactionalEvent(repeate, type)
  _id = _id + 1
  local event = TransactionalEvent.Create(_id, repeate, type)
  return event
end

local function addevent_impl(event, global)
  if global then
    _globalEvents.inactive[event:GetID()] = event
  else
    _sceneEvents.inactive[event:GetID()] = event
  end
  event:Activate()
end

function EventManager.AddEvent(event, global)
  if _updating then
    _delay_changes.add[#_delay_changes.add + 1] = event
  else
    addevent_impl(event, global)
  end
end

local function remove(id, list)
  for _, v in pairs(list) do
    if v[id] then
      local event = v[id]
      if _updating then
        _delay_changes.delete[id] = true
      else
        event:Destroy()
        v[id] = nil
      end
      return event
    end
  end
  return false
end

local function remove_by_cfgid(cfgid, list)
  for _, v in pairs(list) do
    for id, event in pairs(v) do
      if event:GetConfigID() == cfgid then
        if _updating then
          _delay_changes.delete[id] = true
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

local function find_by_cfgid(cfgid, list)
  for _, v in pairs(list) do
    for id, event in pairs(v) do
      if event:GetConfigID() == cfgid then
        return event
      end
    end
  end
  return false
end

function EventManager.RemoveEvent(id)
  return remove(id, _sceneEvents) or remove(id, _globalEvents)
end

function EventManager.RemoveByConfigID(id)
  if _loading then
    _loading[id] = true
  end
  return remove_by_cfgid(id, _sceneEvents) or remove_by_cfgid(id, _globalEvents)
end

function EventManager.FindByConfigID(id)
  return find_by_cfgid(id, _sceneEvents) or find_by_cfgid(id, _globalEvents)
end

local function clean_list(list)
  for k, v in pairs(list) do
    for _, event in pairs(v) do
      event:Destroy()
    end
    list[k] = {}
  end
end

function EventManager.Clear()
  clean_list(_sceneEvents)
  clean_list(_globalEvents)
  for k, v in pairs(_finishedEvents) do
    _finishedEvents[k] = nil
  end
end

function EventManager.ClearSceneEvents()
  clean_list(_sceneEvents)
end

local function update_list(list)
  local id, event = next(list.active)
  if not event then
    return false
  end
  local preserved = {}
  while id and event do
    list.active[id] = nil
    if not _delay_changes.delete[id] then
      event:Fire()
      if event:IsRepeateEvent() then
        preserved[id] = event
      else
        event:Destroy()
      end
    else
      event:Destroy()
    end
    id, event = next(list.active)
  end
  for k, v in pairs(preserved) do
    if not _delay_changes.delete[k] then
      v:Reset()
      list.inactive[k] = v
    end
  end
  return true
end

function EventManager.OnFixedUpdate()
  if not _changed then
    return
  end
  _updating = true
  local succ = update_list(_sceneEvents) or update_list(_globalEvents)
  _changed = false
  _updating = false
  local changes = clone(_delay_changes)
  _delay_changes.add = {}
  _delay_changes.delete = {}
  for id, v in pairs(changes.delete) do
    remove(id, _sceneEvents)
  end
  for _, v in ipairs(changes.add) do
    addevent_impl(v)
  end
  return succ
end

local function check_list(eventid, list)
  if list.inactive[eventid] then
    local event = list.inactive[eventid]
    if event:IsTriggerFired() then
      list.active[eventid] = event
      list.inactive[eventid] = nil
      return true
    end
  end
  if list.active[eventid] then
    local event = list.active[eventid]
    if not event:IsTriggerFired() then
      list.inactive[eventid] = event
      list.active[eventid] = nil
      return true
    end
  end
  return false
end

function EventManager.OnTriggerStateChange(eventid)
  _changed = check_list(eventid, _sceneEvents) or check_list(eventid, _globalEvents)
  EventManager.OnFixedUpdate()
end

function EventManager.LoadSceneEvents(sceneid, restore_info, reconnect)
  _loading = {}
  restore_info = restore_info or {}
  local recorder = BeanManager.GetTableByName("event.ceventconfig")
  for _, i in ipairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if (record.scene == sceneid or tostring(record.scene) == tostring(sceneid)) and not _loading[i] then
      local event = StaticEvent.CreateFromConfig(i)
      LogInfo("event", "add cfg event " .. i .. ", eventid " .. event:GetID())
      if restore_info[i] == 1 then
        if StaticEvent.IsEffectPersist(event:GetConfigType()) then
          event:FireAlternative({init = true})
          if event:IsRepeateEvent() then
            EventManager.AddEvent(StaticEvent.CreateFromConfig(event:GetConfigID()))
          end
        end
      else
        EventManager.AddEvent(event)
      end
    end
  end
  local record = cSceneJump:GetRecorder(sceneid)
  if record then
    if record.jumpType == 1 then
      for index = 1, #record.exitSituation do
        local event = EventManager.Builder.BuildSceneJumpEffect(sceneid, record.exitID[index], record.exitSituation[index])
        EventManager.AddEvent(event)
      end
    elseif record.jumpType == 2 then
      for index = 1, #record.exitSituation do
        local event = EventManager.Builder.BuildFinishExploreEffect(sceneid, record.exitID[index], record.exitSituation[index])
        EventManager.AddEvent(event)
      end
    end
  end
  for k, v in pairs(restore_info) do
    if v == 1 then
      _finishedEvents[k] = true
    end
  end
  for _, i in pairs(ctimelinebyselection:GetAllIds()) do
    local recorder = ctimelinebyselection:GetRecorder(i)
    if recorder.sceneID == sceneid and recorder.linkedEventID ~= reconnect and restore_info[recorder.linkedEventID] ~= 1 then
      local event = EventManager.Builder.BuildGuardEvent(i)
      EventManager.AddEvent(event)
    end
  end
  _loading = false
end

function EventManager.SaveDungeonFinishedEvent(eventId)
  _finishedEvents[eventId] = true
end

function EventManager.IsFinishedByEventID(id)
  return _finishedEvents[id]
end

EventManager.Temp = {}

function EventManager.Temp.AddDynamicEnemyBattleEvent(x, y, battleid)
  local battleevent = EventManager.CreateEvent()
  local poslist = {
    {
      x = x + 1,
      y = y
    },
    {
      x = x - 1,
      y = y
    },
    {
      x = x,
      y = y + 1
    },
    {
      x = x,
      y = y - 1
    }
  }
  local postrigger = TriggerManager.CreateTrigger("gridpos", battleevent:GetID(), poslist, true)
  battleevent:AddTrigger("gridpos", postrigger)
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local effect = EffectFactory.CreateBattleEffect(battleid, function()
    active_controller:RemoveEnemy(x, y)
  end)
  battleevent:AddEffect(effect)
  EventManager.AddEvent(battleevent)
end

function EventManager.Temp.AddJumpPoint(x, y)
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {
    {x = x, y = y}
  }, true)
  event:AddTrigger("gridpos", trigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    active_controller:Restart()
  end)
  event:AddEffect(effect)
  EventManager.AddEvent(event)
end

function EventManager.Temp.Dump()
  local function dump_impl(tbl, level, str)
    level = level or 0
    
    str = str or ""
    local tmp = ""
    for k, v in pairs(tbl) do
      if k ~= "__index" and type(v) ~= "function" then
        local tab = "|-"
        tab = string.rep("  ", level) .. tab
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
  local controllers = dump_impl(TriggerManager.GetControllers())
  LogWarning("event", "dumped events:\n" .. events)
  LogWarning("event", "dumped triggers:\n" .. controllers)
  local worldx, worldy = NekoData.BehaviorManager.BM_Dungeon:GetActorWorldPosition()
  local gridx, gridy = NekoData.BehaviorManager.BM_Dungeon:GetActorGridPosition()
  LogWarning("event", string.format("current actor: (%s, %s) aka (%s, %s)", gridx, gridy, worldx, worldy))
end

EventManager.Builder = {}

function EventManager.Builder.BuildStaticBattleEvent(x, y, battleid, enemy_obj, callback)
  local event = EventManager.CreateEvent()
  local poslist = {
    {x = x, y = y}
  }
  local postrigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), poslist, true)
  event:AddTrigger("gridpos", postrigger)
  local cb
  if enemy_obj then
    if callback then
      function cb()
        enemy_obj:SetActive(false)
        
        callback()
      end
    else
      function cb()
        enemy_obj:SetActive(false)
      end
    end
  end
  local effect = EffectFactory.CreateBattleEffect(battleid, cb)
  event:AddEffect(effect)
  return event
end

function EventManager.Builder.BuildRandomItemEvent(worldx, worldy, worldw, worldh, key)
  local event = EventManager.CreateEvent()
  local pos = {
    x = worldx - worldw / 2,
    y = worldy - worldh / 2,
    w = worldw,
    h = worldh
  }
  local trigger = TriggerManager.CreateTrigger("worldpos", event:GetID(), {pos})
  event:AddTrigger("worldpos", trigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    NekoData.BehaviorManager.BM_Dungeon:OnRandomItemPick(key)
  end)
  event:AddEffect(effect)
  return event
end

function EventManager.Builder.BuildPatrolBattleEvent(colliderid, battleid, object, callback)
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("collision", event:GetID(), tostring(colliderid))
  event:AddTrigger("collision", trigger)
  
  local function cb()
    if callback then
      callback()
    end
  end
  
  local effect = EffectFactory.CreateCustomEffect(function()
    CS.PixelNeko.P1.Scene.TrapHelper.PausePatrol(object)
    CS.PixelNeko.P1.Scene.TrapHelper.PauseChase(object)
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
    if controller and controller.OnMonsterBattle then
      controller:OnMonsterBattle(colliderid)
    end
  end)
  event:AddEffect(effect)
  effect = EffectFactory.CreateBattleEffect(battleid, cb)
  event:AddEffect(effect)
  return event
end

function EventManager.Builder.BuildSceneJumpEffect(mapid, exitid, exitSituation)
  local event = EventManager.CreateEvent(true)
  local poslist = {}
  local exitInfo = string.split(exitSituation, ",")
  local xPos = tonumber(exitInfo[1])
  local yPos = tonumber(exitInfo[2])
  local xWidth = tonumber(exitInfo[3])
  local yWidth = tonumber(exitInfo[4])
  for i = 0, xWidth do
    local posx = xPos + i
    for j = 0, yWidth do
      table.insert(poslist, {
        x = posx,
        y = yPos + j
      })
    end
  end
  local postrigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), poslist, true)
  event:AddTrigger("gridpos", postrigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    local dialog = DialogManager.GetDialog("dungeon.rockerdialog")
    if dialog then
      dialog:OnPointerCancel()
    end
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
    dialog = DialogManager.GetDialog("confirmbox.secondconfirmdialog")
    if dialog and dialog:GetCurMessageId() == 33 then
      return
    end
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(33, nil, function()
      local req = LuaNetManager.CreateProtocol("protocol.battle.centerjumppoint")
      req.id = mapid
      req.outpoint = exitid
      req:Send()
    end, {}, nil, {})
  end)
  event:AddEffect(effect)
  return event
end

function EventManager.Builder.BuildFinishExploreEffect(mapid, exitid, exitSituation)
  local event = EventManager.CreateEvent(true)
  local poslist = {}
  local exitInfo = string.split(exitSituation, ",")
  local xPos = tonumber(exitInfo[1])
  local yPos = tonumber(exitInfo[2])
  local xWidth = tonumber(exitInfo[3])
  local yWidth = tonumber(exitInfo[4])
  for i = 0, xWidth do
    local posx = xPos + i
    for j = 0, yWidth do
      table.insert(poslist, {
        x = posx,
        y = yPos + j
      })
    end
  end
  local postrigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), poslist, true)
  event:AddTrigger("gridpos", postrigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    local dialog = DialogManager.GetDialog("dungeon.rockerdialog")
    if dialog then
      dialog:OnPointerCancel()
    end
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
    dialog = DialogManager.GetDialog("confirmbox.secondconfirmdialog")
    if dialog and dialog:GetCurMessageId() == 34 then
      return
    end
    local floorID = NekoData.BehaviorManager.BM_Game:GetFloorIDWithSceneID(mapid)
    if not NekoData.BehaviorManager.BM_Game:GetFloorIsPassWithMainLineId(floorID) and NekoData.BehaviorManager.BM_Game:GetFloorIsNeedToBack(floorID) then
      DialogManager.CreateSingletonDialog("dungeon.autoreturnconfirmdialog"):SetCallBack(function()
        local req = LuaNetManager.CreateProtocol("protocol.battle.ccompletezone")
        req.floorId = mapid
        req.outPoint = exitid
        req:Send()
      end)
    else
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(34, nil, function()
        local req = LuaNetManager.CreateProtocol("protocol.battle.ccompletezone")
        req.floorId = mapid
        req.outPoint = exitid
        req:Send()
      end, {}, nil, {})
    end
  end)
  event:AddEffect(effect)
  return event
end

function EventManager.Builder.BuildGuardEvent(id)
  local recorder = ctimelinebyselection:GetRecorder(id)
  local event = EventManager.CreateEvent()
  local pos = string.split(recorder.area, ",")
  pos = {
    x = tonumber(pos[1]),
    y = tonumber(pos[2]),
    w = tonumber(pos[3]),
    h = tonumber(pos[4])
  }
  local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {pos})
  event:AddTrigger(trigger:GetType(), trigger)
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    EffectFactory.CreateFreezeEffect():Run()
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(recorder.confirmID, nil, function()
      local root = EffectFactory.CreateComposedEffect()
      root:AddEffect(EffectFactory.CreateTimelineEffect(recorder.timelineConfirm))
      root:AddEffect(EffectFactory.CreateThawEffect())
      root:Run()
    end, nil, function()
      local root = EffectFactory.CreateComposedEffect()
      root:AddEffect(EffectFactory.CreateTimelineEffect(recorder.timelineCancel))
      root:AddEffect(EffectFactory.CreateCustomEffect(function()
        local e = EventManager.Builder.BuildGuardEvent(id)
        EventManager.AddEvent(e)
      end))
      root:AddEffect(EffectFactory.CreateThawEffect())
      root:Run()
    end, nil)
  end))
  return event
end

function EventManager.Builder.BuildHintEvent(area, typeid, random, priority)
  local event = EventManager.CreateEvent(false)
  local trigger = TriggerManager.CreateTrigger("gridpos", event:GetID(), {area}, true)
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = EffectFactory.CreateCustomEffect(function()
    local dialog = DialogManager.GetDialog("dungeon.hint.dungeonhintdialog")
    if dialog then
      if priority <= dialog:GetPriority() then
        return
      end
    else
      dialog = DialogManager.CreateSingletonDialog("dungeon.hint.dungeonhintdialog")
    end
    dialog:SetPriority(priority)
    if random then
      dialog:PlayRandomChat(typeid or 1)
    else
      dialog:PlayFixedChat(typeid or 1)
    end
  end)
  event:AddEffect(effect)
  return event
end

return EventManager
