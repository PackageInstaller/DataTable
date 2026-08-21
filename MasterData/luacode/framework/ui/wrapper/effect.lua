-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/effect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local EffectStaticFunctions = (((CS.PixelNeko).Lua).UI).EffectStaticFunctions
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local Window = require("framework.ui.wrapper.window")
local Effect = class("Effect", Window)
Effect.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Effect
  ((Effect.super).Ctor)(self, gameObject)
end

Effect.AddEffectAsync = function(self, assetBundleName, assetName)
  -- function num : 0_1 , upvalues : EffectStaticFunctions
  return (EffectStaticFunctions.AddEffectAsync)(self._uiObject, assetBundleName, assetName)
end

Effect.AddEffectSync = function(self, assetBundleName, assetName)
  -- function num : 0_2 , upvalues : EffectStaticFunctions
  return (EffectStaticFunctions.AddEffectSync)(self._uiObject, assetBundleName, assetName)
end

Effect.ReleaseEffect = function(self, handler)
  -- function num : 0_3 , upvalues : EffectStaticFunctions
  (EffectStaticFunctions.Release)(self._uiObject, handler)
end

Effect.GetEffectObject = function(self, handler)
  -- function num : 0_4 , upvalues : EffectStaticFunctions
  local object = (EffectStaticFunctions.GetEffectObject)(self._uiObject, handler)
  return object
end

Effect.GetEffectAnimatorObject = function(self, handler)
  -- function num : 0_5 , upvalues : EffectStaticFunctions
  local object = (EffectStaticFunctions.GetEffectAnimatorObject)(self._uiObject, handler)
  return object
end

Effect.Subscribe_UIEffectEndEvent = function(self, callback, ins)
  -- function num : 0_6 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddUIEffectEndListener)(self._uiObject, callback, ins)
end

Effect.Unsubscribe_UIEffectEndEvent = function(self, handler)
  -- function num : 0_7 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveUIEffectEndListener)(self._uiObject, handler)
end

Effect.Subscribe_EffectStateEnterEvent = function(self, effectHandler, callback, ins)
  -- function num : 0_8 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddStateEnterListener)(self:GetEffectAnimatorObject(effectHandler), callback, ins)
end

Effect.Unsubscribe_EffectStateEnterEvent = function(self, effectHandler, handler)
  -- function num : 0_9 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveStateEnterListener)(self:GetEffectAnimatorObject(effectHandler), handler)
end

Effect.Subscribe_EffectStateUpdateEvent = function(self, effectHandler, callback, ins)
  -- function num : 0_10 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddStateUpdateListener)(self:GetEffectAnimatorObject(effectHandler), callback, ins)
end

Effect.Unsubscribe_EffectStateUpdateEvent = function(self, effectHandler, handler)
  -- function num : 0_11 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveStateUpdateListener)(self:GetEffectAnimatorObject(effectHandler), handler)
end

Effect.Subscribe_EffectStateExitEvent = function(self, effectHandler, callback, ins)
  -- function num : 0_12 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddStateExitListener)(self:GetEffectAnimatorObject(effectHandler), callback, ins)
end

Effect.Unsubscribe_EffectStateExitEvent = function(self, effectHandler, handler)
  -- function num : 0_13 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveStateExitListener)(self:GetEffectAnimatorObject(effectHandler), handler)
end

Effect.PlayEffectAnimation = function(self, effectHandler, stateName, layer, normalizedTime)
  -- function num : 0_14 , upvalues : AnimationHelper
  if not normalizedTime then
    normalizedTime = 0
  end
  if not layer then
    layer = 0
  end
  ;
  (AnimationHelper.PlayAnimation2)(self:GetEffectAnimatorObject(effectHandler), stateName, layer, normalizedTime)
end

return Effect

