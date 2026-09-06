local Live2DStaticFunctions = CS.PixelNeko.Lua.UI.Live2DStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local Window = require("framework.ui.wrapper.window")
local Live2D = class("Live2D", Window)

function Live2D:Ctor(gameObject)
  Live2D.super.Ctor(self, gameObject)
end

function Live2D:GetLive2DGameObject(handler)
  return Live2DStaticFunctions.GetLive2DGameObject(self._uiObject, handler)
end

function Live2D:AddLive2D(assetBundle, assetName, scale)
  return Live2DStaticFunctions.AddLive2D(self._uiObject, assetBundle, assetName, scale)
end

function Live2D:Release(handler)
  Live2DStaticFunctions.Release(self._uiObject, handler)
end

function Live2D:SetOpacity(handler, value)
  Live2DStaticFunctions.SetOpacity(self._uiObject, handler, value)
end

function Live2D:GetOpacity(handler)
  return Live2DStaticFunctions.GetOpacity(self._uiObject, handler)
end

function Live2D:PlayLive2DAnimation(animationName, handler)
  return Live2DStaticFunctions.PlayLive2DAnimation(self._uiObject, handler, animationName)
end

function Live2D:SetLive2DAnimatorTrigger(handler, name)
  if Live2DStaticFunctions.SetLive2DAnimatorTrigger then
    return Live2DStaticFunctions.SetLive2DAnimatorTrigger(self._uiObject, handler, name)
  end
end

function Live2D:SetLive2DAnimatorBool(handler, name, value)
  if Live2DStaticFunctions.SetLive2DAnimatorBool then
    return Live2DStaticFunctions.SetLive2DAnimatorBool(self._uiObject, handler, name, value)
  end
end

function Live2D:SetLive2DAnimatorFloat(handler, name, value)
  if Live2DStaticFunctions.SetLive2DAnimatorFloat then
    return Live2DStaticFunctions.SetLive2DAnimatorFloat(self._uiObject, handler, name, value)
  end
end

function Live2D:SetLive2DAnimatorInteger(handler, name, value)
  return Live2DStaticFunctions.SetLive2DAnimatorInteger(self._uiObject, handler, name, value)
end

function Live2D:GetColorTint(handler)
  return Live2DStaticFunctions.GetColorTint(self._uiObject, handler)
end

function Live2D:SetColorTint(handler, r, g, b, a)
  Live2DStaticFunctions.SetColorTint(self._uiObject, handler, r, g, b, a)
end

function Live2D:EnableLookAtMouse(handler)
  Live2DStaticFunctions.EnableLookAtMouse(self._uiObject, handler)
end

function Live2D:DisableLookAtMouse(handler)
  Live2DStaticFunctions.DisableLookAtMouse(self._uiObject, handler)
end

function Live2D:EnableClick(handler, raycastHitArrayLength)
  LogWarning("Live2D", "已弃用, 请使用 AddPointerDownListener/RemovePointerDownListener 代替.")
  Live2DStaticFunctions.EnableClick(self._uiObject, handler, raycastHitArrayLength)
end

function Live2D:DisableClick(handler)
  LogWarning("Live2D", "已弃用, 请使用 AddPointerDownListener/RemovePointerDownListener 代替.")
  Live2DStaticFunctions.DisableClick(self._uiObject, handler)
end

function Live2D:GetClickInfo(handler, mousePosition)
  LogWarning("Live2D", "已弃用, 请使用 AddPointerDownListener/RemovePointerDownListener 代替.")
  return Live2DStaticFunctions.GetClickInfo(self._uiObject, handler, UIManager.UICamera, mousePosition.x, mousePosition.y, mousePosition.z)
end

function Live2D:OnlyFor0916Func()
  if Live2DStaticFunctions.AddPointerDownListener then
    return true
  end
  return false
end

function Live2D:AddPointerDownListener(l2dHandle, callback, ins, raycastHitLength)
  if Live2DStaticFunctions.AddPointerDownListener then
    ins = ins or {}
    raycastHitLength = raycastHitLength or 1
    return Live2DStaticFunctions.AddPointerDownListener(self._uiObject, l2dHandle, callback, ins, raycastHitLength)
  end
end

function Live2D:RemovePointerDownListener(l2dHandle, handler)
  if Live2DStaticFunctions.RemovePointerDownListener then
    Live2DStaticFunctions.RemovePointerDownListener(self._uiObject, l2dHandle, handler)
  end
end

function Live2D:SetRaycastHitsLength(l2dHandle, raycastHitLength)
  if Live2DStaticFunctions.SetRaycastHitsLength then
    Live2DStaticFunctions.SetRaycastHitsLength(self._uiObject, l2dHandle, raycastHitLength)
  end
end

return Live2D
