local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CreateDialogEffect = class("CreateDialogEffect", EffectBase)
local Not = require("logic.scene.luaevent.trigger.composed.triggernot")
local ComposedTrigger = require("logic.scene.luaevent.trigger.composed.composedtrigger")

function CreateDialogEffect:Ctor(id, args)
  self._id = id
  self._args = args
  self._dialogName = BeanManager.GetTableByName("popups.cpopupstypeconfig"):GetRecorder(id).path
end

function CreateDialogEffect:Run(args)
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  self._dialog = DialogManager.CreateSingletonDialog(self._dialogName)
  if self._dialog.SetData then
    self._dialog:SetData(self._args)
  end
  if self._object then
    self:AddLeaveEvent()
  end
  LuaNotificationCenter.RemoveObserver(self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function CreateDialogEffect:AddLeaveEvent()
  local gridx, gridy = NekoData.BehaviorManager.BM_Dungeon:GetActorGridPosition()
  self._leaveEvent = EventManager.CreateEvent()
  local trigger = TriggerManager.CreateTrigger("gridpos", self._leaveEvent:GetID(), {
    {x = gridx, y = gridy}
  }, true)
  local negative = Not.Create()
  negative:SetTask(trigger)
  local composedtrigger = ComposedTrigger.Create(nil, self._leaveEvent:GetID())
  composedtrigger:AddTask(negative)
  self._leaveEvent:AddTrigger("composed", composedtrigger)
  self._leaveEvent:AddEffect(EffectFactory.CreateCustomEffect(function()
    if self._dialog.Skip then
      self._dialog:Skip()
    end
  end))
  EventManager.AddEvent(self._leaveEvent)
end

function CreateDialogEffect:OnDialogDestroy(notification)
  if notification.userInfo._dialogKey ~= self._dialog._dialogKey then
    return
  end
  if self._leaveEvent then
    EventManager.RemoveEvent(self._leaveEvent:GetID())
  end
  self._dialog = nil
  LuaNotificationCenter.RemoveObserver(self)
  if self._callback then
    self._callback()
    self._callback = nil
  else
    self._finished = true
  end
end

function CreateDialogEffect:Then(callback)
  if not self._finished then
    self._callback = callback
  else
    callback()
    self._finished = false
  end
end

return CreateDialogEffect
