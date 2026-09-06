local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local CanvasGroupStaticFunction = CS.PixelNeko.Lua.CanvasGroupStaticFunction
local TouchScreenKeyBoardStaticFunctions = CS.PixelNeko.Lua.TouchScreenKeyBoardStaticFunctions
local ClipBoardStaticFunctions = CS.PixelNeko.Lua.ClipBoardStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local Element = require("framework.ui.wrapper.element")
local Window = class("Window", Element)

function Window:Ctor(gameObject)
  Window.super.Ctor(self, gameObject)
end

function Window:SetUserData(userData)
  self._userData = userData
end

function Window:GetUserData()
  return self._userData
end

function Window:Subscribe_UpdateEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddUpdateListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_UpdateEvent(handler)
  UIEventTriggerHelper.RemoveUpdateListener(self._uiObject, handler)
end

function Window:Subscribe_LateUpdateEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddLateUpdateListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_LateUpdateEvent(handler)
  UIEventTriggerHelper.RemoveLateUpdateListener(self._uiObject, handler)
end

function Window:Subscribe_DestroyWindowEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddDestroyWindowListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_DestroyWindowEvent(handler)
  UIEventTriggerHelper.RemoveDestroyWindowListener(self._uiObject, handler)
end

function Window:Subscribe_PointerDownEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddPointerDownListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_PointerDownEvent(handler)
  UIEventTriggerHelper.RemovePointerDownListener(self._uiObject, handler)
end

function Window:Subscribe_PointerMoveEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddPointerMoveListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_PointerMoveEvent(handler)
  UIEventTriggerHelper.RemovePointerMoveListener(self._uiObject, handler)
end

function Window:Subscribe_PointerUpEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddPointerUpListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_PointerUpEvent(handler)
  UIEventTriggerHelper.RemovePointerUpListener(self._uiObject, handler)
end

function Window:Subscribe_PointerCancelEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddPointerCancelListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_PointerCancelEvent(handler)
  UIEventTriggerHelper.RemovePointerCancelListener(self._uiObject, handler)
end

function Window:Subscribe_PointerClickEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddPointerClickListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_PointerClickEvent(handler)
  UIEventTriggerHelper.RemovePointerClickListener(self._uiObject, handler)
end

function Window:Subscribe_BeginDragEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddBeginDragListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_BeginDragEvent(handler)
  UIEventTriggerHelper.RemoveBeginDragListener(self._uiObject, handler)
end

function Window:Subscribe_DragEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddDragListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_DragEvent(handler)
  UIEventTriggerHelper.RemoveDragListener(self._uiObject, handler)
end

function Window:Subscribe_EndDragEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddEndDragListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_EndDragEvent(handler)
  UIEventTriggerHelper.RemoveEndDragListener(self._uiObject, handler)
end

function Window:Subscribe_CancelDragEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddCancelDragListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_CancelDragEvent(handler)
  UIEventTriggerHelper.RemoveCancelDragListener(self._uiObject, handler)
end

function Window:Subscribe_BeginZoomEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddBeginZoomListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_BeginZoomEvent(handler)
  UIEventTriggerHelper.RemoveBeginZoomListener(self._uiObject, handler)
end

function Window:Subscribe_ZoomEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddZoomListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_ZoomEvent(handler)
  UIEventTriggerHelper.RemoveZoomListener(self._uiObject, handler)
end

function Window:Subscribe_EndZoomEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddEndZoomListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_EndZoomEvent(handler)
  UIEventTriggerHelper.RemoveEndZoomListener(self._uiObject, handler)
end

function Window:Subscribe_CancelZoomEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddCancelZoomListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_CancelZoomEvent(handler)
  UIEventTriggerHelper.RemoveCancelZoomListener(self._uiObject, handler)
end

function Window:Subscribe_BeginLongPressEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddBeginLongPressListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_BeginLongPressEvent(handler)
  UIEventTriggerHelper.RemoveBeginLongPressListener(self._uiObject, handler)
end

function Window:Subscribe_LongPressEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddLongPressListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_LongPressEvent(handler)
  UIEventTriggerHelper.RemoveLongPressListener(self._uiObject, handler)
end

function Window:Subscribe_EndLongPressEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddEndLongPressListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_EndLongPressEvent(handler)
  UIEventTriggerHelper.RemoveEndLongPressListener(self._uiObject, handler)
end

function Window:Subscribe_CancelLongPressEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddCancelLongPressListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_CancelLongPressEvent(handler)
  UIEventTriggerHelper.RemoveCancelLongPressListener(self._uiObject, handler)
end

function Window:Subscribe_DropEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddDropListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_DropEvent(handler)
  UIEventTriggerHelper.RemoveDropListener(self._uiObject, handler)
end

function Window:Subscribe_StateEnterEvent(callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddStateEnterListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_StateEnterEvent(handler)
  StateEventTriggerHelper.RemoveStateEnterListener(self._uiObject, handler)
end

function Window:Subscribe_StateUpdateEvent(callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddStateUpdateListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_StateUpdateEvent(handler)
  StateEventTriggerHelper.RemoveStateUpdateListener(self._uiObject, handler)
end

function Window:Subscribe_StateExitEvent(callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddStateExitListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_StateExitEvent(handler)
  StateEventTriggerHelper.RemoveStateExitListener(self._uiObject, handler)
end

function Window:Subscribe_AnimationEvent(clipName, callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddAnimationEventListener(self._uiObject, clipName, callback, ins)
end

function Window:Unsubscribe_AnimationEvent(handler)
  StateEventTriggerHelper.RemoveAnimationEventListener(self._uiObject, handler)
end

function Window:Subscribe_AllAnimationEvent(callback, ins)
  ins = ins or {}
  return StateEventTriggerHelper.AddAllAnimationEventListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_AllAnimationEvent(handler)
  StateEventTriggerHelper.RemoveAllAnimationEventListener(self._uiObject, handler)
end

function Window:PlayAnimation(stateName, layer, normalizedTime)
  normalizedTime = normalizedTime or 0
  layer = layer or 0
  AnimationHelper.PlayAnimation2(self._uiObject, stateName, layer, normalizedTime)
end

function Window:SetAnimatorTrigger(name)
  AnimationHelper.SetAnimatorTrigger2(self._uiObject, name)
end

function Window:SetAnimatorBool(name, value)
  AnimationHelper.SetAnimatorBool2(self._uiObject, name, value)
end

function Window:SetAnimatorFloat(name, value)
  AnimationHelper.SetAnimatorFloat2(self._uiObject, name, value)
end

function Window:SetAnimatorInteger(name, value)
  AnimationHelper.SetAnimatorInteger2(self._uiObject, name, value)
end

function Window:SetBlocksRaycasts(flag)
  CanvasGroupStaticFunction.SetBlocksRaycasts(self._uiObject, flag)
end

function Window:GetBlocksRaycasts(flag)
  return CanvasGroupStaticFunction.GetBlocksRaycasts(self._uiObject)
end

function Window:SetAlpha(alpha)
  CanvasGroupStaticFunction.SetObjectAlpha(self._uiObject, alpha, false)
end

function Window:GetAlpha()
  return CanvasGroupStaticFunction.GetObjectAlpha(self._uiObject)
end

function Window:GetTouchScreenKeyBoardHeight()
  return TouchScreenKeyBoardStaticFunctions.GetTouchScreenKeyBoardHeight()
end

function Window:CopyToClipBoard(str)
  return ClipBoardStaticFunctions.CopyToClipBoard(str)
end

function Window:Subscribe_ClickLinkEvent(callback, ins)
  ins = ins or {}
  return UIEventTriggerHelper.AddClickLinkListener(self._uiObject, callback, ins)
end

function Window:Unsubscribe_ClickLinkEvent(handler)
  UIEventTriggerHelper.RemoveClickLinkListener(self._uiObject, handler)
end

return Window
