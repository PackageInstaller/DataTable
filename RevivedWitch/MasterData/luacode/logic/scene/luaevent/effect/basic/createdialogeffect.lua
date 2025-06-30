-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/createdialogeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CreateDialogEffect = class("CreateDialogEffect", EffectBase)
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")
CreateDialogEffect.Ctor = function(self, id, args)
  -- function num : 0_0 , upvalues : _ENV
  self._id = id
  self._args = args
  self._dialogName = (((BeanManager.GetTableByName)("popups.cpopupstypeconfig")):GetRecorder(id)).path
end

CreateDialogEffect.Run = function(self, args)
  -- function num : 0_1 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  self._dialog = (DialogManager.CreateSingletonDialog)(self._dialogName)
  if (self._dialog).SetData then
    (self._dialog):SetData(self._args)
  end
  if self._object then
    self:AddLeaveEvent()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

CreateDialogEffect.AddLeaveEvent = function(self)
  -- function num : 0_2 , upvalues : _ENV, Not, ComposedTrigger
  local gridx, gridy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  self._leaveEvent = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("gridpos", (self._leaveEvent):GetID(), {
{x = gridx, y = gridy}
}, true)
  local negative = (Not.Create)()
  negative:SetTask(trigger)
  local composedtrigger = (ComposedTrigger.Create)(nil, (self._leaveEvent):GetID())
  composedtrigger:AddTask(negative)
  ;
  (self._leaveEvent):AddTrigger("composed", composedtrigger)
  ;
  (self._leaveEvent):AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_2_0 , upvalues : self
    if (self._dialog).Skip then
      (self._dialog):Skip()
    end
  end
))
  ;
  (EventManager.AddEvent)(self._leaveEvent)
end

CreateDialogEffect.OnDialogDestroy = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  if (notification.userInfo)._dialogKey ~= (self._dialog)._dialogKey then
    return 
  end
  if self._leaveEvent then
    (EventManager.RemoveEvent)((self._leaveEvent):GetID())
  end
  self._dialog = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._callback then
    (self._callback)()
    self._callback = nil
  else
    self._finished = true
  end
end

CreateDialogEffect.Then = function(self, callback)
  -- function num : 0_4
  if not self._finished then
    self._callback = callback
  else
    callback()
    self._finished = false
  end
end

return CreateDialogEffect

