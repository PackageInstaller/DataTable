local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DynamicTimelineTable = BeanManager.GetTableByName("timeline.ctimelinedynamic")
local TimelineEffect = class("TimelineEffect", EffectBase)
local ctimelinevol = BeanManager.GetTableByName("timeline.ctimelinevol")

function TimelineEffect:Ctor(id, dynamic, shouldStop)
  self._director = id
  self._dynamic = dynamic
  if shouldStop ~= nil then
    self._shouldStop = shouldStop
  else
    self._shouldStop = true
  end
end

function TimelineEffect:Destroy()
end

function TimelineEffect:Run()
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  if self._dynamic then
    self:RunDynamic()
  else
    self:RunStatic()
  end
  local recorder = ctimelinevol:GetRecorder(self._director)
  if recorder then
    EffectFactory.CreateBGMEffect("play", recorder.voiceID):Run()
    local event = EventManager.CreateEvent()
    local trigger = TriggerManager.CreateTrigger("timeline", event:GetID(), self._director)
    event:AddTrigger(trigger:GetType(), trigger)
    event:AddEffect(EffectFactory.CreateBGMEffect("stop", recorder.voiceID))
    EventManager.AddEvent(event)
  end
end

function TimelineEffect:RunStatic()
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if self._shouldStop and active_controller.StopWalking then
    active_controller:StopWalking()
  end
  if active_controller.PlayTimeline then
    active_controller:PlayTimeline(self._director)
  end
end

function TimelineEffect:RunDynamic()
  local active_controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if active_controller.StopWalking then
    active_controller:StopWalking()
  end
  local oneline = DynamicTimelineTable:GetRecorder(self._director)
  local timelineName = oneline.Path
  local args = {}
  local dealTable = {
    [1] = function(i)
      if oneline.npcID[i] == 0 then
        args[oneline.TrackName[i]] = CS.PixelNeko.Lua.TransformStaticFunctions.GetChild(active_controller._sceneRef.actor.object, "EmojiPoint")
      else
        args[oneline.TrackName[i]] = NekoData.BehaviorManager.BM_NPC:GetNpcInstance(oneline.Name, oneline.npcID[i]):GetEmojiPoint()
      end
    end,
    [2] = function(i)
      if oneline.npcID[i] == 0 then
        args[oneline.TrackName[i]] = active_controller._sceneRef.actor.object
      else
        args[oneline.TrackName[i]] = NekoData.BehaviorManager.BM_NPC:GetNpcObj(oneline.Name, oneline.npcID[i])
      end
    end
  }
  for i, type in ipairs(oneline.TrackType) do
    dealTable[type](i)
  end
  if active_controller.PlayTimelineBindObjectDynamically then
    active_controller:PlayTimelineBindObjectDynamically(timelineName, args)
    local event = EventManager.CreateEvent()
    local trigger = TriggerManager.CreateTrigger("timeline", event:GetID(), self._director)
    event:AddTrigger("timeline", trigger)
    local effect = EffectFactory.CreateCustomEffect(function()
      for i, npcId in ipairs(oneline.npcID) do
        if oneline.TrackType[i] == 2 then
          local npcIns = NekoData.BehaviorManager.BM_NPC:GetNpcInstance(oneline.Name, npcId)
          if npcIns then
            npcIns:RemoveEvent()
            npcIns:AddEvent()
          end
          local npcUIDialog = DialogManager.CreateSingletonDialog("npc.npcuidialog")
          npcUIDialog:UpdateChild(oneline.Name, npcId)
        end
      end
    end)
    event:AddEffect(effect)
    EventManager.AddEvent(event)
  end
end

function TimelineEffect:Then(callback)
  local event = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("timeline", event:GetID(), self._director)
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = EffectFactory.CreateCustomEffect(callback)
  event:AddEffect(effect)
  effect = EffectFactory.CreateCustomEffect(function()
    LuaNotificationCenter.PostNotification(Common.n_SceneEffectEnd, self, self)
  end)
  event:AddEffect(effect)
  EventManager.AddEvent(event)
end

return TimelineEffect
