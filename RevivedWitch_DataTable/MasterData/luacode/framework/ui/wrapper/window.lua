-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/window.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local CanvasGroupStaticFunction = ((CS.PixelNeko).Lua).CanvasGroupStaticFunction
local TouchScreenKeyBoardStaticFunctions = ((CS.PixelNeko).Lua).TouchScreenKeyBoardStaticFunctions
local ClipBoardStaticFunctions = ((CS.PixelNeko).Lua).ClipBoardStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local Element = require("framework.ui.wrapper.element")
local Window = class("Window", Element)
Window.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Window
  ((Window.super).Ctor)(self, gameObject)
end

Window.SetUserData = function(self, userData)
  -- function num : 0_1
  self._userData = userData
end

Window.GetUserData = function(self)
  -- function num : 0_2
  return self._userData
end

Window.Subscribe_UpdateEvent = function(self, callback, ins)
  -- function num : 0_3 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddUpdateListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_UpdateEvent = function(self, handler)
  -- function num : 0_4 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveUpdateListener)(self._uiObject, handler)
end

Window.Subscribe_LateUpdateEvent = function(self, callback, ins)
  -- function num : 0_5 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddLateUpdateListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_LateUpdateEvent = function(self, handler)
  -- function num : 0_6 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveLateUpdateListener)(self._uiObject, handler)
end

Window.Subscribe_DestroyWindowEvent = function(self, callback, ins)
  -- function num : 0_7 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddDestroyWindowListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_DestroyWindowEvent = function(self, handler)
  -- function num : 0_8 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveDestroyWindowListener)(self._uiObject, handler)
end

Window.Subscribe_PointerDownEvent = function(self, callback, ins)
  -- function num : 0_9 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddPointerDownListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_PointerDownEvent = function(self, handler)
  -- function num : 0_10 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemovePointerDownListener)(self._uiObject, handler)
end

Window.Subscribe_PointerMoveEvent = function(self, callback, ins)
  -- function num : 0_11 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddPointerMoveListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_PointerMoveEvent = function(self, handler)
  -- function num : 0_12 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemovePointerMoveListener)(self._uiObject, handler)
end

Window.Subscribe_PointerUpEvent = function(self, callback, ins)
  -- function num : 0_13 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddPointerUpListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_PointerUpEvent = function(self, handler)
  -- function num : 0_14 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemovePointerUpListener)(self._uiObject, handler)
end

Window.Subscribe_PointerCancelEvent = function(self, callback, ins)
  -- function num : 0_15 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddPointerCancelListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_PointerCancelEvent = function(self, handler)
  -- function num : 0_16 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemovePointerCancelListener)(self._uiObject, handler)
end

Window.Subscribe_PointerClickEvent = function(self, callback, ins)
  -- function num : 0_17 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddPointerClickListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_PointerClickEvent = function(self, handler)
  -- function num : 0_18 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemovePointerClickListener)(self._uiObject, handler)
end

Window.Subscribe_BeginDragEvent = function(self, callback, ins)
  -- function num : 0_19 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddBeginDragListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_BeginDragEvent = function(self, handler)
  -- function num : 0_20 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveBeginDragListener)(self._uiObject, handler)
end

Window.Subscribe_DragEvent = function(self, callback, ins)
  -- function num : 0_21 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddDragListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_DragEvent = function(self, handler)
  -- function num : 0_22 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveDragListener)(self._uiObject, handler)
end

Window.Subscribe_EndDragEvent = function(self, callback, ins)
  -- function num : 0_23 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddEndDragListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_EndDragEvent = function(self, handler)
  -- function num : 0_24 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveEndDragListener)(self._uiObject, handler)
end

Window.Subscribe_CancelDragEvent = function(self, callback, ins)
  -- function num : 0_25 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddCancelDragListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_CancelDragEvent = function(self, handler)
  -- function num : 0_26 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveCancelDragListener)(self._uiObject, handler)
end

Window.Subscribe_BeginZoomEvent = function(self, callback, ins)
  -- function num : 0_27 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddBeginZoomListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_BeginZoomEvent = function(self, handler)
  -- function num : 0_28 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveBeginZoomListener)(self._uiObject, handler)
end

Window.Subscribe_ZoomEvent = function(self, callback, ins)
  -- function num : 0_29 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddZoomListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_ZoomEvent = function(self, handler)
  -- function num : 0_30 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveZoomListener)(self._uiObject, handler)
end

Window.Subscribe_EndZoomEvent = function(self, callback, ins)
  -- function num : 0_31 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddEndZoomListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_EndZoomEvent = function(self, handler)
  -- function num : 0_32 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveEndZoomListener)(self._uiObject, handler)
end

Window.Subscribe_CancelZoomEvent = function(self, callback, ins)
  -- function num : 0_33 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddCancelZoomListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_CancelZoomEvent = function(self, handler)
  -- function num : 0_34 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveCancelZoomListener)(self._uiObject, handler)
end

Window.Subscribe_BeginLongPressEvent = function(self, callback, ins)
  -- function num : 0_35 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddBeginLongPressListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_BeginLongPressEvent = function(self, handler)
  -- function num : 0_36 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveBeginLongPressListener)(self._uiObject, handler)
end

Window.Subscribe_LongPressEvent = function(self, callback, ins)
  -- function num : 0_37 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddLongPressListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_LongPressEvent = function(self, handler)
  -- function num : 0_38 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveLongPressListener)(self._uiObject, handler)
end

Window.Subscribe_EndLongPressEvent = function(self, callback, ins)
  -- function num : 0_39 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddEndLongPressListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_EndLongPressEvent = function(self, handler)
  -- function num : 0_40 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveEndLongPressListener)(self._uiObject, handler)
end

Window.Subscribe_CancelLongPressEvent = function(self, callback, ins)
  -- function num : 0_41 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddCancelLongPressListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_CancelLongPressEvent = function(self, handler)
  -- function num : 0_42 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveCancelLongPressListener)(self._uiObject, handler)
end

Window.Subscribe_DropEvent = function(self, callback, ins)
  -- function num : 0_43 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddDropListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_DropEvent = function(self, handler)
  -- function num : 0_44 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveDropListener)(self._uiObject, handler)
end

Window.Subscribe_StateEnterEvent = function(self, callback, ins)
  -- function num : 0_45 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddStateEnterListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_StateEnterEvent = function(self, handler)
  -- function num : 0_46 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveStateEnterListener)(self._uiObject, handler)
end

Window.Subscribe_StateUpdateEvent = function(self, callback, ins)
  -- function num : 0_47 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddStateUpdateListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_StateUpdateEvent = function(self, handler)
  -- function num : 0_48 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveStateUpdateListener)(self._uiObject, handler)
end

Window.Subscribe_StateExitEvent = function(self, callback, ins)
  -- function num : 0_49 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddStateExitListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_StateExitEvent = function(self, handler)
  -- function num : 0_50 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveStateExitListener)(self._uiObject, handler)
end

Window.Subscribe_AnimationEvent = function(self, clipName, callback, ins)
  -- function num : 0_51 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddAnimationEventListener)(self._uiObject, clipName, callback, ins)
end

Window.Unsubscribe_AnimationEvent = function(self, handler)
  -- function num : 0_52 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveAnimationEventListener)(self._uiObject, handler)
end

Window.Subscribe_AllAnimationEvent = function(self, callback, ins)
  -- function num : 0_53 , upvalues : StateEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (StateEventTriggerHelper.AddAllAnimationEventListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_AllAnimationEvent = function(self, handler)
  -- function num : 0_54 , upvalues : StateEventTriggerHelper
  (StateEventTriggerHelper.RemoveAllAnimationEventListener)(self._uiObject, handler)
end

Window.PlayAnimation = function(self, stateName, layer, normalizedTime)
  -- function num : 0_55 , upvalues : AnimationHelper
  if not normalizedTime then
    normalizedTime = 0
  end
  if not layer then
    layer = 0
  end
  ;
  (AnimationHelper.PlayAnimation2)(self._uiObject, stateName, layer, normalizedTime)
end

Window.SetAnimatorTrigger = function(self, name)
  -- function num : 0_56 , upvalues : AnimationHelper
  (AnimationHelper.SetAnimatorTrigger2)(self._uiObject, name)
end

Window.SetAnimatorBool = function(self, name, value)
  -- function num : 0_57 , upvalues : AnimationHelper
  (AnimationHelper.SetAnimatorBool2)(self._uiObject, name, value)
end

Window.SetAnimatorFloat = function(self, name, value)
  -- function num : 0_58 , upvalues : AnimationHelper
  (AnimationHelper.SetAnimatorFloat2)(self._uiObject, name, value)
end

Window.SetAnimatorInteger = function(self, name, value)
  -- function num : 0_59 , upvalues : AnimationHelper
  (AnimationHelper.SetAnimatorInteger2)(self._uiObject, name, value)
end

Window.SetBlocksRaycasts = function(self, flag)
  -- function num : 0_60 , upvalues : CanvasGroupStaticFunction
  (CanvasGroupStaticFunction.SetBlocksRaycasts)(self._uiObject, flag)
end

Window.GetBlocksRaycasts = function(self, flag)
  -- function num : 0_61 , upvalues : CanvasGroupStaticFunction
  return (CanvasGroupStaticFunction.GetBlocksRaycasts)(self._uiObject)
end

Window.SetAlpha = function(self, alpha)
  -- function num : 0_62 , upvalues : CanvasGroupStaticFunction
  (CanvasGroupStaticFunction.SetObjectAlpha)(self._uiObject, alpha, false)
end

Window.GetAlpha = function(self)
  -- function num : 0_63 , upvalues : CanvasGroupStaticFunction
  return (CanvasGroupStaticFunction.GetObjectAlpha)(self._uiObject)
end

Window.GetTouchScreenKeyBoardHeight = function(self)
  -- function num : 0_64 , upvalues : TouchScreenKeyBoardStaticFunctions
  return (TouchScreenKeyBoardStaticFunctions.GetTouchScreenKeyBoardHeight)()
end

Window.CopyToClipBoard = function(self, str)
  -- function num : 0_65 , upvalues : ClipBoardStaticFunctions
  return (ClipBoardStaticFunctions.CopyToClipBoard)(str)
end

Window.Subscribe_ClickLinkEvent = function(self, callback, ins)
  -- function num : 0_66 , upvalues : UIEventTriggerHelper
  if not ins then
    ins = {}
  end
  return (UIEventTriggerHelper.AddClickLinkListener)(self._uiObject, callback, ins)
end

Window.Unsubscribe_ClickLinkEvent = function(self, handler)
  -- function num : 0_67 , upvalues : UIEventTriggerHelper
  (UIEventTriggerHelper.RemoveClickLinkListener)(self._uiObject, handler)
end

return Window

