local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local RectTransformStaticFunctions = CS.PixelNeko.Lua.RectTransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local Element = class("Element")

function Element:Ctor(gameObject)
  self._uiObject = gameObject
end

function Element:GetUIObject()
  return self._uiObject
end

function Element:SetActive(active)
  local activeBool
  local typeStr = type(active)
  if typeStr ~= "boolean" then
    activeBool = typeStr ~= "nil"
  else
    activeBool = active
  end
  TransformStaticFunctions.SetActive(self._uiObject, activeBool)
end

function Element:IsActive()
  return TransformStaticFunctions.IsActive(self._uiObject)
end

function Element:IsAciveInHierarchy()
  return TransformStaticFunctions.IsAciveInHierarchy(self._uiObject)
end

function Element:SetName(name)
  TransformStaticFunctions.SetName(self._uiObject, name)
end

function Element:SetParent(parent)
  RectTransformStaticFunctions.SetParent(self._uiObject, parent)
end

function Element:IsChildOf(parent)
  return TransformStaticFunctions.IsChildOf(self._uiObject, parent._uiObject)
end

function Element:GetDeltaSize()
  return RectTransformStaticFunctions.GetDeltaSize(self._uiObject)
end

function Element:SetDeltaSize(width, height)
  RectTransformStaticFunctions.SetDeltaSize(self._uiObject, width, height)
end

function Element:GetRectSize()
  return RectTransformStaticFunctions.GetRectSize(self._uiObject)
end

function Element:GetAnchoredPosition()
  return RectTransformStaticFunctions.GetAnchoredPosition(self._uiObject)
end

function Element:SetAnchoredPosition(x, y)
  RectTransformStaticFunctions.SetAnchoredPosition(self._uiObject, x, y)
end

function Element:SetPivotPosition(x, y)
  RectTransformStaticFunctions.SetPivotPosition(self._uiObject, x, y)
end

function Element:GetPivotPosition()
  return RectTransformStaticFunctions.GetPivotPosition(self._uiObject)
end

function Element:GetSize()
  return RectTransformStaticFunctions.GetSize(self._uiObject)
end

function Element:SetSize(anchorX, offsetX, anchorY, offsetY)
  RectTransformStaticFunctions.SetSize(self._uiObject, anchorX, offsetX, anchorY, offsetY)
end

function Element:GetWidth()
  return RectTransformStaticFunctions.GetWidth(self._uiObject)
end

function Element:SetWidth(anchor, offset)
  RectTransformStaticFunctions.SetWidth(self._uiObject, anchor, offset)
end

function Element:GetHeight()
  return RectTransformStaticFunctions.GetHeight(self._uiObject)
end

function Element:SetHeight(anchor, offset)
  RectTransformStaticFunctions.SetHeight(self._uiObject, anchor, offset)
end

function Element:GetPosition()
  return RectTransformStaticFunctions.GetPosition(self._uiObject)
end

function Element:SetPosition(anchorX, offsetX, anchorY, offsetY)
  RectTransformStaticFunctions.SetPosition(self._uiObject, anchorX, offsetX, anchorY, offsetY)
end

function Element:GetXPosition()
  return RectTransformStaticFunctions.GetXPosition(self._uiObject)
end

function Element:SetXPosition(anchorX, offsetX)
  RectTransformStaticFunctions.SetXPosition(self._uiObject, anchorX, offsetX)
end

function Element:GetYPosition()
  return RectTransformStaticFunctions.GetYPosition(self._uiObject)
end

function Element:SetYPosition(anchorY, offsetY)
  RectTransformStaticFunctions.SetYPosition(self._uiObject, anchorY, offsetY)
end

function Element:SetLocalScale(x, y, z)
  TransformStaticFunctions.SetLocalScale(self._uiObject, x, y, z)
end

function Element:GetLocalPointInUiRootPanel()
  return UIManager.GetLocalPointInUiRootPanel(self._uiObject)
end

function Element:SetZRotation(beginVectorX, beginVectorY, endVectorX, endVectorY)
  RectTransformStaticFunctions.SetZRotation(self._uiObject, beginVectorX, beginVectorY, endVectorX, endVectorY)
end

function Element:GetLocalScale()
  return TransformStaticFunctions.GetLocalScale(self._uiObject)
end

function Element:GetLossyScale()
  return TransformStaticFunctions.GetLossyScale(self._uiObject)
end

function Element:GetLocalPosition()
  return TransformStaticFunctions.GetLocalPosition(self._uiObject)
end

function Element:SetLocalPosition(x, y, z)
  return TransformStaticFunctions.SetLocalPosition(self._uiObject, x, y, z)
end

function Element:SetLocalEuler(x, y, z)
  TransformStaticFunctions.SetLocalEuler(self._uiObject, x, y, z)
end

function Element:SetAnchorAndOffset(anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX, offsetMaxY)
  RectTransformStaticFunctions.SetAnchorAndOffset(self._uiObject, anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX, offsetMaxY)
end

function Element:GetAnchorAndOffset()
  return RectTransformStaticFunctions.GetAnchorAndOffset(self._uiObject)
end

function Element:FindChild(path)
  return UIManager.GetChildLuaWindow(self._uiObject, path)
end

function Element:GetAnchor()
  return RectTransformStaticFunctions.GetAnchor(self._uiObject)
end

function Element:SetAnchor(anchorMinX, anchorMinY, anchorMaxX, anchorMaxY)
  RectTransformStaticFunctions.SetAnchor(self._uiObject, anchorMinX, anchorMinY, anchorMaxX, anchorMaxY)
end

return Element
