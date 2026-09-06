local LuaTimelineManager = {}
local PathResolver = require("logic.scene.pathresolver")
local _current = {}
local _speed = {}
local _handler = {}
local Types = CS.PixelNeko.P1.TimeLine.TimelineEventEnum

function LuaTimelineManager.OnTimelineStart(playableDirector, status)
  print("lua timeline start", playableDirector, status, debug.traceback())
  _current[playableDirector] = true
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller and (not controller.IgnoreSpeed or not controller:IgnoreSpeed()) then
    local actor = PathResolver.Resolve("[actor]")
    if actor then
      if controller.GetBuffManager then
        local manager = controller:GetBuffManager()
        local current_buff = manager:GetCurrentBuff()
        if current_buff and current_buff:GetType() == 1 and current_buff:GetState() == 1 then
          manager:OnBuffTimeout(current_buff:GetID())
        end
      end
      _speed = CS.PixelNeko.Lua.NavMeshStaticFunctions.GetSpeed(actor)
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_TimelineStart, LuaTimelineManager, playableDirector)
end

function LuaTimelineManager.OnTimelineStop(playableDirector, status)
  print("lua timeline stop", playableDirector, status, debug.traceback())
  _current[playableDirector] = nil
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller and _speed and (not controller.IgnoreSpeed or not controller:IgnoreSpeed()) then
    local actor = PathResolver.Resolve("[actor]")
    if actor then
      CS.PixelNeko.Lua.NavMeshStaticFunctions.SetSpeed(actor, _speed)
    end
  end
  LuaNotificationCenter.PostNotification(Common.n_TimelineStop, LuaTimelineManager, playableDirector)
end

function LuaTimelineManager.OnTimelineEvent(director, type, ...)
  _handler[type](director, ...)
end

_handler[Types.StartNPCChat] = function(director, id)
  local graph = director.playableGraph
  if not graph:IsValid() then
    return
  end
  id = tonumber(id)
  CS.PixelNeko.P1.TimeLine.TimelineManager.PausePlayable(graph:GetRootPlayable(0))
  local event = EventManager.CreateEvent()
  event:AddTrigger("dialogueend", TriggerManager.CreateTrigger("dialogueend", event:GetID(), id))
  event:AddEffect(EffectFactory.CreateCustomEffect(function()
    if graph:IsValid() then
      CS.PixelNeko.P1.TimeLine.TimelineManager.ResumePlayable(graph:GetRootPlayable(0))
    end
  end))
  EventManager.AddEvent(event)
  DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(id)
end
_handler[Types.StartBattle] = function(director, id)
  local graph = director.playableGraph
  if not graph:IsValid() then
    return
  end
  id = tonumber(id)
  local effect = EffectFactory.CreateBattleEffect(id, nil)
  effect:Run()
  LuaNotificationCenter.PostNotification(Common.n_TimelineStop, LuaTimelineManager, director)
end
_handler[Types.Freeze] = function(director, animated)
  EffectFactory.CreateFreezeEffect(animated):Run()
end
_handler[Types.Thaw] = function(director, animated)
  EffectFactory.CreateThawEffect(animated):Run()
end
_handler[Types.JumpToScene] = function(director, mapid, jumppointid)
  local graph = director.playableGraph
  if not graph:IsValid() then
    return
  end
  CS.PixelNeko.P1.TimeLine.TimelineManager.PausePlayable(graph:GetRootPlayable(0))
  local effect = EffectFactory.CreateJumpEffect(tonumber(mapid), tonumber(jumppointid))
  effect:Run()
  LuaTimelineManager.OnTimelineStop(director, -2)
end
_handler[Types.BackToMainCity] = function(director, type)
  local graph = director.playableGraph
  if not graph:IsValid() then
    return
  end
  if type == "0" or type == "normal" or type == "" or not type then
    type = "normal"
  elseif type == "1" or type == "fail" then
    type = "fail"
  else
    type = tonumber(type)
    if type == nil then
      LogError("timeline", "BackToMainCity type error, " .. type .. " at " .. tostring(director))
      return
    end
  end
  CS.PixelNeko.P1.TimeLine.TimelineManager.PausePlayable(graph:GetRootPlayable(0))
  local effect = EffectFactory.CreateJumpBackEffect(type)
  effect:Run()
  LuaTimelineManager.OnTimelineStop(director, -1)
end
_handler[Types.CreateDialog] = function(director, type, args)
  type = tonumber(type)
  if type == 4 or type == 11 then
    local graph = director.playableGraph
    if not graph:IsValid() then
      return
    end
    CS.PixelNeko.P1.TimeLine.TimelineManager.PausePlayable(graph:GetRootPlayable(0))
  end
  local effect = EffectFactory.CreateDialogEffect(type, args)
  effect:Run()
  if type == 4 or type == 11 then
    effect:Then(function()
      local graph = director.playableGraph
      if graph:IsValid() then
        CS.PixelNeko.P1.TimeLine.TimelineManager.ResumePlayable(graph:GetRootPlayable(0))
      end
    end)
  end
end
_handler[Types.CreateSkillUnlockDialog] = function(director, skillId, skillItemId, roleId)
  local graph = director.playableGraph
  if not graph:IsValid() then
    return
  end
  CS.PixelNeko.P1.TimeLine.TimelineManager.PausePlayable(graph:GetRootPlayable(0))
  local effect = EffectFactory.CreateSkillUnlockDialogEffect(tonumber(skillId), tonumber(skillItemId), tonumber(roleId))
  effect:Run()
  effect:Then(function()
    local graph = director.playableGraph
    if graph:IsValid() then
      CS.PixelNeko.P1.TimeLine.TimelineManager.ResumePlayable(graph:GetRootPlayable(0))
    end
  end)
end
_handler[Types.PausePlayable] = function(director, type, args)
  LuaTimelineManager.OnTimelineStop(director, -1)
end
_handler[Types.JumpToAnyScene] = function(director, target)
  LuaTimelineManager.OnTimelineStop(director, -1)
  local req = LuaNetManager.CreateProtocol("protocol.battle.cjumptoscene")
  req.sceneId = tonumber(target)
  req:Send()
end
_handler[Types.StartHint] = function(director, type, id)
  local dialog = DialogManager.CreateSingletonDialog("dungeon.hint.dungeonhintdialog")
  if type == "random" then
    dialog:PlayRandomChat(tonumber(id))
  else
    dialog:PlayFixedChat(tonumber(id))
  end
end
_handler[Types.SendMessage] = function(director, id)
  NekoData.BehaviorManager.BM_Message:SendMessageById(tonumber(id))
end
if Types.UploadEvent_TA then
  _handler[Types.UploadEvent_TA] = function(director, id)
    local jsonStr = JSON.encode({eventName = "event", id = id})
    ThinkingAnalyticsInterface.UploadEvent_TA(jsonStr)
  end
end
if Types.SetUserPropertiesOnce_TA then
  _handler[Types.SetUserPropertiesOnce_TA] = function(director, eventName)
    local jsonStr = JSON.encode({eventName = eventName})
    ThinkingAnalyticsInterface.SetUserPropertiesOnce_TA(jsonStr)
  end
end
CS.PixelNeko.P1.TimeLine.TimelineManager.SetTimelineStartCallback(LuaTimelineManager.OnTimelineStart)
CS.PixelNeko.P1.TimeLine.TimelineManager.SetTimelineStopCallback(LuaTimelineManager.OnTimelineStop)
CS.PixelNeko.P1.TimeLine.TimelineManager.SetTimelineEventCallback(LuaTimelineManager.OnTimelineEvent)
return LuaTimelineManager
