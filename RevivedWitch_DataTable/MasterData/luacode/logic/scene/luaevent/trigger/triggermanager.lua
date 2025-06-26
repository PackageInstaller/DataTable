-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/triggermanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerManager = {}
local _controllers = {}
local _id = 0
TriggerManager.Init = function()
  -- function num : 0_0 , upvalues : _controllers, _id, TriggerManager, _ENV
  _controllers = {}
  _id = 0
  ;
  (TriggerManager.CreateControllers)()
  ;
  (LuaNotificationCenter.AddObserver)(TriggerManager, TriggerManager.OnBattleEnd, Common.n_BattleEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(TriggerManager, TriggerManager.OnReturnFromBattle, Common.n_ReturnFromBattle, nil)
  ;
  (LuaNotificationCenter.AddObserver)(TriggerManager, TriggerManager.OnBattleRewardEnd, Common.n_BattleRewardEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(TriggerManager, TriggerManager.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(TriggerManager, TriggerManager.OnTimelineEnd, Common.n_TimelineStop, nil)
  ;
  (LuaNotificationCenter.AddObserver)(TriggerManager, TriggerManager.OnSceneDestroy, Common.n_SceneDestroy, nil)
end

TriggerManager.UnInit = function()
  -- function num : 0_1 , upvalues : _ENV, _controllers, _id, TriggerManager
  for _,v in pairs(_controllers) do
    v:Destroy()
  end
  _controllers = {}
  _id = 0
  ;
  (LuaNotificationCenter.RemoveObserver)(TriggerManager)
end

TriggerManager.CreateControllers = function()
  -- function num : 0_2 , upvalues : _controllers, _ENV
  _controllers.gridpos = ((require("logic.scene.luaevent.trigger.basic.gridpos.gridpostriggercontroller")).Create)()
  _controllers.worldpos = ((require("logic.scene.luaevent.trigger.basic.worldpos.worldpostriggercontroller")).Create)()
  _controllers.battleend = ((require("logic.scene.luaevent.trigger.basic.battleend.battleendtriggercontroller")).Create)()
  _controllers.timer = ((require("logic.scene.luaevent.trigger.basic.timer.timertriggercontroller")).Create)()
  _controllers.counter = ((require("logic.scene.luaevent.trigger.basic.counter.countertriggercontroller")).Create)()
  _controllers.pretask = ((require("logic.scene.luaevent.trigger.basic.pretask.pretasktriggercontroller")).Create)()
  _controllers.direction = ((require("logic.scene.luaevent.trigger.basic.direction.directiontriggercontroller")).Create)()
  _controllers.rolestatus = ((require("logic.scene.luaevent.trigger.basic.rolestatus.rolestatustriggercontroller")).Create)()
  _controllers.period = ((require("logic.scene.luaevent.trigger.basic.period.periodtriggercontroller")).Create)()
  _controllers.dialogueend = ((require("logic.scene.luaevent.trigger.basic.dialogueend.dialogueendtriggercontroller")).Create)()
  _controllers.timeline = ((require("logic.scene.luaevent.trigger.basic.timeline.timelinetriggercontroller")).Create)()
  _controllers.scenedestroy = ((require("logic.scene.luaevent.trigger.basic.scenedestroy.scenedestroytriggercontroller")).Create)()
  _controllers.collision = ((require("logic.scene.luaevent.trigger.basic.collision.collisiontriggercontroller")).Create)()
  _controllers.trapopen = ((require("logic.scene.luaevent.trigger.basic.trapopen.trapopentriggercontroller")).Create)()
end

TriggerManager.CreateTrigger = function(type, eventid, ...)
  -- function num : 0_3 , upvalues : _controllers
  if not _controllers[type] then
    return 
  end
  return (_controllers[type]):CreateTrigger(eventid, ...)
end

TriggerManager.AddTrigger = function(type, trigger)
  -- function num : 0_4 , upvalues : _controllers
  if not _controllers[type] then
    return 
  end
  return (_controllers[type]):AddTrigger(trigger)
end

TriggerManager.GetController = function(name)
  -- function num : 0_5 , upvalues : _controllers
  return _controllers[name]
end

TriggerManager.GetControllers = function()
  -- function num : 0_6 , upvalues : _controllers
  return _controllers
end

TriggerManager.GetTrigger = function(type, id)
  -- function num : 0_7 , upvalues : _controllers, _ENV
  if _controllers[type] then
    return (_controllers[type]):GetTrigger(id)
  else
    for _,v in pairs(_controllers) do
      local trigger = v:GetTrigger(id)
      if trigger then
        return trigger
      end
    end
  end
end

TriggerManager.RemoveTrigger = function(type, id)
  -- function num : 0_8 , upvalues : _controllers
  if not _controllers[type] then
    return false
  end
  return (_controllers[type]):RemoveTrigger(id)
end

TriggerManager.OnSceneChange = function()
  -- function num : 0_9 , upvalues : _ENV, _controllers
  for _,v in pairs(_controllers) do
    v:OnSceneChange()
  end
end

TriggerManager.OnGridPosChange = function(x, y)
  -- function num : 0_10 , upvalues : _controllers
  (_controllers.gridpos):OnCharacterMove(x, y)
end

TriggerManager.OnWorldPosChange = function(x, y)
  -- function num : 0_11 , upvalues : _controllers
  (_controllers.worldpos):OnCharacterMove(x, y)
end

TriggerManager.OnBattleEnd = function(observer, notification)
  -- function num : 0_12 , upvalues : _ENV, _controllers
  LogInfo("battle end", (debug.traceback)())
  ;
  (_controllers.battleend):OnBattleEnd(notification.userInfo)
end

TriggerManager.OnReturnFromBattle = function(observer, notification)
  -- function num : 0_13 , upvalues : _ENV, _controllers
  LogInfo("return from battle", (debug.traceback)())
  ;
  (_controllers.battleend):OnReturnFromBattle(notification.userInfo)
end

TriggerManager.OnBattleRewardEnd = function(observer, notification)
  -- function num : 0_14 , upvalues : _ENV, _controllers
  LogInfo("battle reward end", (debug.traceback)())
  ;
  (_controllers.battleend):OnBattleRewardEnd(notification.userInfo)
end

TriggerManager.OnCounterChange = function(tag, value)
  -- function num : 0_15 , upvalues : _controllers
  (_controllers.counter):OnCounterChange(tag, value)
end

TriggerManager.OnUpdate = function(deltaTime)
  -- function num : 0_16 , upvalues : _controllers
  (_controllers.timer):OnUpdate(deltaTime)
end

TriggerManager.OnChooseOption = function(id, option)
  -- function num : 0_17 , upvalues : _controllers
  (_controllers.pretask):OnChooseOption(id, option)
end

TriggerManager.OnDirectionChange = function(direction)
  -- function num : 0_18 , upvalues : _controllers
  (_controllers.direction):OnDirectionChange(direction)
end

TriggerManager.OnRoleStatusChange = function(type)
  -- function num : 0_19 , upvalues : _controllers
  (_controllers.rolestatus):OnRoleStatusChange(type)
end

TriggerManager.OnPeriodArrival = function(curTime)
  -- function num : 0_20 , upvalues : _controllers
  (_controllers.period):OnPeriodArrival(curTime)
end

TriggerManager.OnNPCChatEnd = function(observer, notification)
  -- function num : 0_21 , upvalues : _controllers
  (_controllers.dialogueend):OnDialogueEnd(notification.userInfo)
end

TriggerManager.OnTimelineEnd = function(observer, notification)
  -- function num : 0_22 , upvalues : _controllers
  (_controllers.timeline):OnTimelineEnd(notification.userInfo)
end

TriggerManager.OnSceneDestroy = function(observer, notification)
  -- function num : 0_23 , upvalues : _controllers
  (_controllers.scenedestroy):OnSceneDestroy(notification.userInfo)
end

TriggerManager.OnCollision = function(id)
  -- function num : 0_24 , upvalues : _controllers
  (_controllers.collision):OnCollision(id)
end

TriggerManager.OnCheckTrap = function()
  -- function num : 0_25 , upvalues : _controllers
  (_controllers.trapopen):OnCheckTrap()
end

TriggerManager.GenID = function()
  -- function num : 0_26 , upvalues : _id
  _id = _id + 1
  return _id
end

TriggerManager.OnTriggerStateChange = function(trigger)
  -- function num : 0_27 , upvalues : _ENV
  (EventManager.OnTriggerStateChange)(trigger:GetEventID())
end

return TriggerManager

