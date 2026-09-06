local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local EffectStaticFunctions = CS.PixelNeko.Lua.UI.EffectStaticFunctions
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local Window = require("framework.ui.wrapper.window")
local Effect = class("Effect", Window)

function Effect:Ctor(gameObject)
  Effect.super.Ctor(self, gameObject)
end

function Effect:AddEffectAsync(assetBundleName, assetName)
  return EffectStaticFunctions.AddEffectAsync(self._uiObject, assetBundleName, assetName)
end

function Effect:AddEffectSync(assetBundleName, assetName)
  return EffectStaticFunctions.AddEffectSync(self._uiObject, assetBundleName, assetName)
end

function Effect:ReleaseEffect(handler)
  EffectStaticFunctions.Release(self._uiObject, handler)
end

function Effect:GetEffectObject(handler)
  local object = EffectStaticFunctions.GetEffectObject(self._uiObject, handler)
  return object
end

function Effect:GetEffectAnimatorObject(handler)
  local object = EffectStaticFunctions.GetEffectAnimatorObject(self._uiObject, handler)
  return object
end

function Effect:Subscribe_UIEffectEndEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddUIEffectEndListener(self._uiObject, callback, ins)
end

function Effect:Unsubscribe_UIEffectEndEvent(handler)
  UIEventTriggerHelper.RemoveUIEffectEndListener(self._uiObject, handler)
end

function Effect:Subscribe_EffectStateEnterEvent(effectHandler, callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddStateEnterListener(self:GetEffectAnimatorObject(effectHandler), callback, ins)
end

function Effect:Unsubscribe_EffectStateEnterEvent(effectHandler, handler)
  StateEventTriggerHelper.RemoveStateEnterListener(self:GetEffectAnimatorObject(effectHandler), handler)
end

function Effect:Subscribe_EffectStateUpdateEvent(effectHandler, callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddStateUpdateListener(self:GetEffectAnimatorObject(effectHandler), callback, ins)
end

function Effect:Unsubscribe_EffectStateUpdateEvent(effectHandler, handler)
  StateEventTriggerHelper.RemoveStateUpdateListener(self:GetEffectAnimatorObject(effectHandler), handler)
end

function Effect:Subscribe_EffectStateExitEvent(effectHandler, callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddStateExitListener(self:GetEffectAnimatorObject(effectHandler), callback, ins)
end

function Effect:Unsubscribe_EffectStateExitEvent(effectHandler, handler)
  StateEventTriggerHelper.RemoveStateExitListener(self:GetEffectAnimatorObject(effectHandler), handler)
end

function Effect:PlayEffectAnimation(effectHandler, stateName, layer, normalizedTime)
  normalizedTime = normalizedTime or 0
  layer = layer or 0
  AnimationHelper.PlayAnimation2(self:GetEffectAnimatorObject(effectHandler), stateName, layer, normalizedTime)
end

return Effect
