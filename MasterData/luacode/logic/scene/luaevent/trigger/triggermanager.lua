local TriggerManager = {}
local _controllers = {}
local _id = 0

function TriggerManager.Init()
  _controllers = {}
  _id = 0
  TriggerManager.CreateControllers()
  LuaNotificationCenter.AddObserver(TriggerManager, TriggerManager.OnBattleEnd, Common.n_BattleEnd, nil)
  LuaNotificationCenter.AddObserver(TriggerManager, TriggerManager.OnReturnFromBattle, Common.n_ReturnFromBattle, nil)
  LuaNotificationCenter.AddObserver(TriggerManager, TriggerManager.OnBattleRewardEnd, Common.n_BattleRewardEnd, nil)
  LuaNotificationCenter.AddObserver(TriggerManager, TriggerManager.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
  LuaNotificationCenter.AddObserver(TriggerManager, TriggerManager.OnTimelineEnd, Common.n_TimelineStop, nil)
  LuaNotificationCenter.AddObserver(TriggerManager, TriggerManager.OnSceneDestroy, Common.n_SceneDestroy, nil)
end

function TriggerManager.UnInit()
  for _, v in pairs(_controllers) do
    v:Destroy()
  end
  _controllers = {}
  _id = 0
  LuaNotificationCenter.RemoveObserver(TriggerManager)
end

function TriggerManager.CreateControllers()
  _controllers.gridpos = require("logic.scene.luaevent.trigger.basic.gridpos.gridpostriggercontroller").Create()
  _controllers.worldpos = require("logic.scene.luaevent.trigger.basic.worldpos.worldpostriggercontroller").Create()
  _controllers.battleend = require("logic.scene.luaevent.trigger.basic.battleend.battleendtriggercontroller").Create()
  _controllers.timer = require("logic.scene.luaevent.trigger.basic.timer.timertriggercontroller").Create()
  _controllers.counter = require("logic.scene.luaevent.trigger.basic.counter.countertriggercontroller").Create()
  _controllers.pretask = require("logic.scene.luaevent.trigger.basic.pretask.pretasktriggercontroller").Create()
  _controllers.direction = require("logic.scene.luaevent.trigger.basic.direction.directiontriggercontroller").Create()
  _controllers.rolestatus = require("logic.scene.luaevent.trigger.basic.rolestatus.rolestatustriggercontroller").Create()
  _controllers.period = require("logic.scene.luaevent.trigger.basic.period.periodtriggercontroller").Create()
  _controllers.dialogueend = require("logic.scene.luaevent.trigger.basic.dialogueend.dialogueendtriggercontroller").Create()
  _controllers.timeline = require("logic.scene.luaevent.trigger.basic.timeline.timelinetriggercontroller").Create()
  _controllers.scenedestroy = require("logic.scene.luaevent.trigger.basic.scenedestroy.scenedestroytriggercontroller").Create()
  _controllers.collision = require("logic.scene.luaevent.trigger.basic.collision.collisiontriggercontroller").Create()
  _controllers.trapopen = require("logic.scene.luaevent.trigger.basic.trapopen.trapopentriggercontroller").Create()
end

function TriggerManager.CreateTrigger(type, eventid, ...)
  if not _controllers[type] then
    return
  end
  return _controllers[type]:CreateTrigger(eventid, ...)
end

function TriggerManager.AddTrigger(type, trigger)
  if not _controllers[type] then
    return
  end
  return _controllers[type]:AddTrigger(trigger)
end

function TriggerManager.GetController(name)
  return _controllers[name]
end

function TriggerManager.GetControllers()
  return _controllers
end

function TriggerManager.GetTrigger(type, id)
  if _controllers[type] then
    return _controllers[type]:GetTrigger(id)
  else
    for _, v in pairs(_controllers) do
      local trigger = v:GetTrigger(id)
      if trigger then
        return trigger
      end
    end
  end
end

function TriggerManager.RemoveTrigger(type, id)
  if not _controllers[type] then
    return false
  end
  return _controllers[type]:RemoveTrigger(id)
end

function TriggerManager.OnSceneChange()
  for _, v in pairs(_controllers) do
    v:OnSceneChange()
  end
end

function TriggerManager.OnGridPosChange(x, y)
  _controllers.gridpos:OnCharacterMove(x, y)
end

function TriggerManager.OnWorldPosChange(x, y)
  _controllers.worldpos:OnCharacterMove(x, y)
end

function TriggerManager.OnBattleEnd(observer, notification)
  LogInfo("battle end", debug.traceback())
  _controllers.battleend:OnBattleEnd(notification.userInfo)
end

function TriggerManager.OnReturnFromBattle(observer, notification)
  LogInfo("return from battle", debug.traceback())
  _controllers.battleend:OnReturnFromBattle(notification.userInfo)
end

function TriggerManager.OnBattleRewardEnd(observer, notification)
  LogInfo("battle reward end", debug.traceback())
  _controllers.battleend:OnBattleRewardEnd(notification.userInfo)
end

function TriggerManager.OnCounterChange(tag, value)
  _controllers.counter:OnCounterChange(tag, value)
end

function TriggerManager.OnUpdate(deltaTime)
  _controllers.timer:OnUpdate(deltaTime)
end

function TriggerManager.OnChooseOption(id, option)
  _controllers.pretask:OnChooseOption(id, option)
end

function TriggerManager.OnDirectionChange(direction)
  _controllers.direction:OnDirectionChange(direction)
end

function TriggerManager.OnRoleStatusChange(type)
  _controllers.rolestatus:OnRoleStatusChange(type)
end

function TriggerManager.OnPeriodArrival(curTime)
  _controllers.period:OnPeriodArrival(curTime)
end

function TriggerManager.OnNPCChatEnd(observer, notification)
  _controllers.dialogueend:OnDialogueEnd(notification.userInfo)
end

function TriggerManager.OnTimelineEnd(observer, notification)
  _controllers.timeline:OnTimelineEnd(notification.userInfo)
end

function TriggerManager.OnSceneDestroy(observer, notification)
  _controllers.scenedestroy:OnSceneDestroy(notification.userInfo)
end

function TriggerManager.OnCollision(id)
  _controllers.collision:OnCollision(id)
end

function TriggerManager.OnCheckTrap()
  _controllers.trapopen:OnCheckTrap()
end

function TriggerManager.GenID()
  _id = _id + 1
  return _id
end

function TriggerManager.OnTriggerStateChange(trigger)
  EventManager.OnTriggerStateChange(trigger:GetEventID())
end

return TriggerManager
