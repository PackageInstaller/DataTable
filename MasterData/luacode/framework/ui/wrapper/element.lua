-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrapper/element.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local RectTransformStaticFunctions = ((CS.PixelNeko).Lua).RectTransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local Element = class("Element")
Element.Ctor = function(self, gameObject)
  -- function num : 0_0
  self._uiObject = gameObject
end

Element.GetUIObject = function(self)
  -- function num : 0_1
  return self._uiObject
end

Element.SetActive = function(self, active)
  -- function num : 0_2 , upvalues : _ENV, TransformStaticFunctions
  local activeBool = nil
  local typeStr = type(active)
  if typeStr == "nil" then
    activeBool = typeStr == "boolean"
    activeBool = active
    ;
    (TransformStaticFunctions.SetActive)(self._uiObject, activeBool)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

Element.IsActive = function(self)
  -- function num : 0_3 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.IsActive)(self._uiObject)
end

Element.IsAciveInHierarchy = function(self)
  -- function num : 0_4 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.IsAciveInHierarchy)(self._uiObject)
end

Element.SetName = function(self, name)
  -- function num : 0_5 , upvalues : TransformStaticFunctions
  (TransformStaticFunctions.SetName)(self._uiObject, name)
end

Element.SetParent = function(self, parent)
  -- function num : 0_6 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetParent)(self._uiObject, parent)
end

Element.IsChildOf = function(self, parent)
  -- function num : 0_7 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.IsChildOf)(self._uiObject, parent._uiObject)
end

Element.GetDeltaSize = function(self)
  -- function num : 0_8 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetDeltaSize)(self._uiObject)
end

Element.SetDeltaSize = function(self, width, height)
  -- function num : 0_9 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetDeltaSize)(self._uiObject, width, height)
end

Element.GetRectSize = function(self)
  -- function num : 0_10 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetRectSize)(self._uiObject)
end

Element.GetAnchoredPosition = function(self)
  -- function num : 0_11 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetAnchoredPosition)(self._uiObject)
end

Element.SetAnchoredPosition = function(self, x, y)
  -- function num : 0_12 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetAnchoredPosition)(self._uiObject, x, y)
end

Element.SetPivotPosition = function(self, x, y)
  -- function num : 0_13 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetPivotPosition)(self._uiObject, x, y)
end

Element.GetPivotPosition = function(self)
  -- function num : 0_14 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetPivotPosition)(self._uiObject)
end

Element.GetSize = function(self)
  -- function num : 0_15 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetSize)(self._uiObject)
end

Element.SetSize = function(self, anchorX, offsetX, anchorY, offsetY)
  -- function num : 0_16 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetSize)(self._uiObject, anchorX, offsetX, anchorY, offsetY)
end

Element.GetWidth = function(self)
  -- function num : 0_17 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetWidth)(self._uiObject)
end

Element.SetWidth = function(self, anchor, offset)
  -- function num : 0_18 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetWidth)(self._uiObject, anchor, offset)
end

Element.GetHeight = function(self)
  -- function num : 0_19 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetHeight)(self._uiObject)
end

Element.SetHeight = function(self, anchor, offset)
  -- function num : 0_20 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetHeight)(self._uiObject, anchor, offset)
end

Element.GetPosition = function(self)
  -- function num : 0_21 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetPosition)(self._uiObject)
end

Element.SetPosition = function(self, anchorX, offsetX, anchorY, offsetY)
  -- function num : 0_22 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetPosition)(self._uiObject, anchorX, offsetX, anchorY, offsetY)
end

Element.GetXPosition = function(self)
  -- function num : 0_23 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetXPosition)(self._uiObject)
end

Element.SetXPosition = function(self, anchorX, offsetX)
  -- function num : 0_24 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetXPosition)(self._uiObject, anchorX, offsetX)
end

Element.GetYPosition = function(self)
  -- function num : 0_25 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetYPosition)(self._uiObject)
end

Element.SetYPosition = function(self, anchorY, offsetY)
  -- function num : 0_26 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetYPosition)(self._uiObject, anchorY, offsetY)
end

Element.SetLocalScale = function(self, x, y, z)
  -- function num : 0_27 , upvalues : TransformStaticFunctions
  (TransformStaticFunctions.SetLocalScale)(self._uiObject, x, y, z)
end

Element.GetLocalPointInUiRootPanel = function(self)
  -- function num : 0_28 , upvalues : UIManager
  return (UIManager.GetLocalPointInUiRootPanel)(self._uiObject)
end

Element.SetZRotation = function(self, beginVectorX, beginVectorY, endVectorX, endVectorY)
  -- function num : 0_29 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetZRotation)(self._uiObject, beginVectorX, beginVectorY, endVectorX, endVectorY)
end

Element.GetLocalScale = function(self)
  -- function num : 0_30 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.GetLocalScale)(self._uiObject)
end

Element.GetLossyScale = function(self)
  -- function num : 0_31 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.GetLossyScale)(self._uiObject)
end

Element.GetLocalPosition = function(self)
  -- function num : 0_32 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.GetLocalPosition)(self._uiObject)
end

Element.SetLocalPosition = function(self, x, y, z)
  -- function num : 0_33 , upvalues : TransformStaticFunctions
  return (TransformStaticFunctions.SetLocalPosition)(self._uiObject, x, y, z)
end

Element.SetLocalEuler = function(self, x, y, z)
  -- function num : 0_34 , upvalues : TransformStaticFunctions
  (TransformStaticFunctions.SetLocalEuler)(self._uiObject, x, y, z)
end

Element.SetAnchorAndOffset = function(self, anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX, offsetMaxY)
  -- function num : 0_35 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetAnchorAndOffset)(self._uiObject, anchorMinX, anchorMinY, anchorMaxX, anchorMaxY, offsetMinX, offsetMinY, offsetMaxX, offsetMaxY)
end

Element.GetAnchorAndOffset = function(self)
  -- function num : 0_36 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetAnchorAndOffset)(self._uiObject)
end

Element.FindChild = function(self, path)
  -- function num : 0_37 , upvalues : UIManager
  return (UIManager.GetChildLuaWindow)(self._uiObject, path)
end

Element.GetAnchor = function(self)
  -- function num : 0_38 , upvalues : RectTransformStaticFunctions
  return (RectTransformStaticFunctions.GetAnchor)(self._uiObject)
end

Element.SetAnchor = function(self, anchorMinX, anchorMinY, anchorMaxX, anchorMaxY)
  -- function num : 0_39 , upvalues : RectTransformStaticFunctions
  (RectTransformStaticFunctions.SetAnchor)(self._uiObject, anchorMinX, anchorMinY, anchorMaxX, anchorMaxY)
end

return Element

