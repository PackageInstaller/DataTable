-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/live2d.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Live2DStaticFunctions = (((CS.PixelNeko).Lua).UI).Live2DStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local Window = require("framework.ui.wrapper.window")
local Live2D = class("Live2D", Window)
Live2D.Ctor = function(self, gameObject)
  -- function num : 0_0 , upvalues : Live2D
  ((Live2D.super).Ctor)(self, gameObject)
end

Live2D.GetLive2DGameObject = function(self, handler)
  -- function num : 0_1 , upvalues : Live2DStaticFunctions
  return (Live2DStaticFunctions.GetLive2DGameObject)(self._uiObject, handler)
end

Live2D.AddLive2D = function(self, assetBundle, assetName, scale)
  -- function num : 0_2 , upvalues : Live2DStaticFunctions
  return (Live2DStaticFunctions.AddLive2D)(self._uiObject, assetBundle, assetName, scale)
end

Live2D.Release = function(self, handler)
  -- function num : 0_3 , upvalues : Live2DStaticFunctions
  (Live2DStaticFunctions.Release)(self._uiObject, handler)
end

Live2D.SetOpacity = function(self, handler, value)
  -- function num : 0_4 , upvalues : Live2DStaticFunctions
  (Live2DStaticFunctions.SetOpacity)(self._uiObject, handler, value)
end

Live2D.GetOpacity = function(self, handler)
  -- function num : 0_5 , upvalues : Live2DStaticFunctions
  return (Live2DStaticFunctions.GetOpacity)(self._uiObject, handler)
end

Live2D.PlayLive2DAnimation = function(self, animationName, handler)
  -- function num : 0_6 , upvalues : Live2DStaticFunctions
  return (Live2DStaticFunctions.PlayLive2DAnimation)(self._uiObject, handler, animationName)
end

Live2D.SetLive2DAnimatorTrigger = function(self, handler, name)
  -- function num : 0_7 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.SetLive2DAnimatorTrigger then
    return (Live2DStaticFunctions.SetLive2DAnimatorTrigger)(self._uiObject, handler, name)
  end
end

Live2D.SetLive2DAnimatorBool = function(self, handler, name, value)
  -- function num : 0_8 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.SetLive2DAnimatorBool then
    return (Live2DStaticFunctions.SetLive2DAnimatorBool)(self._uiObject, handler, name, value)
  end
end

Live2D.SetLive2DAnimatorFloat = function(self, handler, name, value)
  -- function num : 0_9 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.SetLive2DAnimatorFloat then
    return (Live2DStaticFunctions.SetLive2DAnimatorFloat)(self._uiObject, handler, name, value)
  end
end

Live2D.SetLive2DAnimatorInteger = function(self, handler, name, value)
  -- function num : 0_10 , upvalues : Live2DStaticFunctions
  return (Live2DStaticFunctions.SetLive2DAnimatorInteger)(self._uiObject, handler, name, value)
end

Live2D.GetColorTint = function(self, handler)
  -- function num : 0_11 , upvalues : Live2DStaticFunctions
  return (Live2DStaticFunctions.GetColorTint)(self._uiObject, handler)
end

Live2D.SetColorTint = function(self, handler, r, g, b, a)
  -- function num : 0_12 , upvalues : Live2DStaticFunctions
  (Live2DStaticFunctions.SetColorTint)(self._uiObject, handler, r, g, b, a)
end

Live2D.EnableLookAtMouse = function(self, handler)
  -- function num : 0_13 , upvalues : Live2DStaticFunctions
  (Live2DStaticFunctions.EnableLookAtMouse)(self._uiObject, handler)
end

Live2D.DisableLookAtMouse = function(self, handler)
  -- function num : 0_14 , upvalues : Live2DStaticFunctions
  (Live2DStaticFunctions.DisableLookAtMouse)(self._uiObject, handler)
end

Live2D.EnableClick = function(self, handler, raycastHitArrayLength)
  -- function num : 0_15 , upvalues : _ENV, Live2DStaticFunctions
  LogWarning("Live2D", "已弃用, 请使用 AddPointerDownListener/RemovePointerDownListener 代替.")
  ;
  (Live2DStaticFunctions.EnableClick)(self._uiObject, handler, raycastHitArrayLength)
end

Live2D.DisableClick = function(self, handler)
  -- function num : 0_16 , upvalues : _ENV, Live2DStaticFunctions
  LogWarning("Live2D", "已弃用, 请使用 AddPointerDownListener/RemovePointerDownListener 代替.")
  ;
  (Live2DStaticFunctions.DisableClick)(self._uiObject, handler)
end

Live2D.GetClickInfo = function(self, handler, mousePosition)
  -- function num : 0_17 , upvalues : _ENV, Live2DStaticFunctions, UIManager
  LogWarning("Live2D", "已弃用, 请使用 AddPointerDownListener/RemovePointerDownListener 代替.")
  return (Live2DStaticFunctions.GetClickInfo)(self._uiObject, handler, UIManager.UICamera, mousePosition.x, mousePosition.y, mousePosition.z)
end

Live2D.OnlyFor0916Func = function(self)
  -- function num : 0_18 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.AddPointerDownListener then
    return true
  end
  return false
end

Live2D.AddPointerDownListener = function(self, l2dHandle, callback, ins, raycastHitLength)
  -- function num : 0_19 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.AddPointerDownListener then
    if not ins then
      ins = {}
    end
    if not raycastHitLength then
      raycastHitLength = 1
    end
    return (Live2DStaticFunctions.AddPointerDownListener)(self._uiObject, l2dHandle, callback, ins, raycastHitLength)
  end
end

Live2D.RemovePointerDownListener = function(self, l2dHandle, handler)
  -- function num : 0_20 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.RemovePointerDownListener then
    (Live2DStaticFunctions.RemovePointerDownListener)(self._uiObject, l2dHandle, handler)
  end
end

Live2D.SetRaycastHitsLength = function(self, l2dHandle, raycastHitLength)
  -- function num : 0_21 , upvalues : Live2DStaticFunctions
  if Live2DStaticFunctions.SetRaycastHitsLength then
    (Live2DStaticFunctions.SetRaycastHitsLength)(self._uiObject, l2dHandle, raycastHitLength)
  end
end

return Live2D

