-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/timelineeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local DynamicTimelineTable = (BeanManager.GetTableByName)("timeline.ctimelinedynamic")
local TimelineEffect = class("TimelineEffect", EffectBase)
local ctimelinevol = (BeanManager.GetTableByName)("timeline.ctimelinevol")
TimelineEffect.Ctor = function(self, id, dynamic, shouldStop)
  -- function num : 0_0
  self._director = id
  self._dynamic = dynamic
  if shouldStop ~= nil then
    self._shouldStop = shouldStop
  else
    self._shouldStop = true
  end
end

TimelineEffect.Destroy = function(self)
  -- function num : 0_1
end

TimelineEffect.Run = function(self)
  -- function num : 0_2 , upvalues : _ENV, ctimelinevol
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  if self._dynamic then
    self:RunDynamic()
  else
    self:RunStatic()
  end
  local recorder = ctimelinevol:GetRecorder(self._director)
  if recorder then
    ((EffectFactory.CreateBGMEffect)("play", recorder.voiceID)):Run()
    local event = (EventManager.CreateEvent)()
    local trigger = (TriggerManager.CreateTrigger)("timeline", event:GetID(), self._director)
    event:AddTrigger(trigger:GetType(), trigger)
    event:AddEffect((EffectFactory.CreateBGMEffect)("stop", recorder.voiceID))
    ;
    (EventManager.AddEvent)(event)
  end
end

TimelineEffect.RunStatic = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if self._shouldStop and active_controller.StopWalking then
    active_controller:StopWalking()
  end
  if active_controller.PlayTimeline then
    active_controller:PlayTimeline(self._director)
  end
end

TimelineEffect.RunDynamic = function(self)
  -- function num : 0_4 , upvalues : _ENV, DynamicTimelineTable
  local active_controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if active_controller.StopWalking then
    active_controller:StopWalking()
  end
  local oneline = DynamicTimelineTable:GetRecorder(self._director)
  local timelineName = oneline.Path
  local args = {}
  local dealTable = {[1] = function(i)
    -- function num : 0_4_0 , upvalues : oneline, args, _ENV, active_controller
    if (oneline.npcID)[i] == 0 then
      args[(oneline.TrackName)[i]] = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)(((active_controller._sceneRef).actor).object, "EmojiPoint")
    else
      args[(oneline.TrackName)[i]] = (((NekoData.BehaviorManager).BM_NPC):GetNpcInstance(oneline.Name, (oneline.npcID)[i])):GetEmojiPoint()
    end
  end
, [2] = function(i)
    -- function num : 0_4_1 , upvalues : oneline, args, active_controller, _ENV
    if (oneline.npcID)[i] == 0 then
      args[(oneline.TrackName)[i]] = ((active_controller._sceneRef).actor).object
    else
      args[(oneline.TrackName)[i]] = ((NekoData.BehaviorManager).BM_NPC):GetNpcObj(oneline.Name, (oneline.npcID)[i])
    end
  end
}
  for i,type in ipairs(oneline.TrackType) do
    (dealTable[type])(i)
  end
  if active_controller.PlayTimelineBindObjectDynamically then
    active_controller:PlayTimelineBindObjectDynamically(timelineName, args)
    local event = (EventManager.CreateEvent)()
    local trigger = (TriggerManager.CreateTrigger)("timeline", event:GetID(), self._director)
    event:AddTrigger("timeline", trigger)
    local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_4_2 , upvalues : _ENV, oneline
    for i,npcId in ipairs(oneline.npcID) do
      if (oneline.TrackType)[i] == 2 then
        local npcIns = ((NekoData.BehaviorManager).BM_NPC):GetNpcInstance(oneline.Name, npcId)
        if npcIns then
          npcIns:RemoveEvent()
          npcIns:AddEvent()
        end
        local npcUIDialog = (DialogManager.CreateSingletonDialog)("npc.npcuidialog")
        npcUIDialog:UpdateChild(oneline.Name, npcId)
      end
    end
  end
)
    event:AddEffect(effect)
    ;
    (EventManager.AddEvent)(event)
  end
end

TimelineEffect.Then = function(self, callback)
  -- function num : 0_5 , upvalues : _ENV
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("timeline", event:GetID(), self._director)
  event:AddTrigger(trigger:GetType(), trigger)
  local effect = (EffectFactory.CreateCustomEffect)(callback)
  event:AddEffect(effect)
  effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    (LuaNotificationCenter.PostNotification)(Common.n_SceneEffectEnd, self, self)
  end
)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
end

return TimelineEffect

