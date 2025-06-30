-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/minimap/minimapdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local RectTransformStaticFunctions = ((CS.PixelNeko).Lua).RectTransformStaticFunctions
local Vector2 = (CS.UnityEngine).Vector2
local UIManager = ((CS.PixelNeko).UI).UIManager
local MiniMapDialog = class("MiniMapDialog", Dialog)
MiniMapDialog.AssetBundleName = "ui/layouts.minimap"
MiniMapDialog.AssetName = "MiniMap"
local IsExitInSmallArea = function(self, selfRow, selfCol, targetRow, targetCol)
  -- function num : 0_0 , upvalues : _ENV
  if (math.abs)(targetRow - selfRow) <= self._halfRowCountInSmall and (math.abs)(targetCol - selfCol) <= self._halfColCountInSmall then
    return true
  end
  return false
end

MiniMapDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : MiniMapDialog
  ((MiniMapDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._container = nil
  self._navImageList = nil
  self._navImageRoot = nil
  self._miniMapAreaHalfWidth = nil
  self._miniMapAreaHalfHeight = nil
  self._halfRowCountInSmall = nil
  self._halfColCountInSmall = nil
  self._miniMap = nil
  self._canZoom = false
  self._dragHandler = nil
  self._zoomHandler = nil
  self._endZoomHandler = nil
  self._cancelZoomHandler = nil
  self._originalContainerXScale = nil
  self._originalContainerYScale = nil
  self._currentContainerXScale = nil
  self._currentContainerYScale = nil
  self._beginZoomScale = nil
  self._currentZoomScale = nil
  self._currentFullWidth = nil
  self._currentFullHeight = nil
  self._fullWidth = nil
  self._fullHeight = nil
end

MiniMapDialog.OnCreate = function(self)
  -- function num : 0_2
  self._navImageRoot = self:GetChild("NavImageRoot")
  self._container = self:GetChild("Container")
  self._containerTransform = ((self._container)._uiObject).transform
end

MiniMapDialog.Init = function(self, miniMap, navImageCount)
  -- function num : 0_3
  self._miniMap = miniMap
  local smallSize = miniMap.SmallSize
  self._miniMapAreaHalfHeight = smallSize.y / 2
  self._miniMapAreaHalfWidth = smallSize.x / 2
  local rowColCountInSmall = miniMap.RowColCountInSmall
  self._halfRowCountInSmall = rowColCountInSmall.x / 2
  self._halfColCountInSmall = rowColCountInSmall.y / 2
  self._navImageList = {}
  self._navImageParentList = {}
  for i = 1, navImageCount do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

    (self._navImageParentList)[i] = self:GetChild("NavImageRoot/NavImage" .. i)
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._navImageList)[i] = self:GetChild("NavImageRoot/NavImage" .. i .. "/NaviArrow")
  end
end

MiniMapDialog.GetMiniMapGameObject = function(self)
  -- function num : 0_4
  return (self:GetRootWindow())._uiObject
end

MiniMapDialog.ShowNavImage = function(self, isShow)
  -- function num : 0_5
  (self._navImageRoot):SetActive(isShow)
end

MiniMapDialog.CanDrag = function(self, canDrag)
  -- function num : 0_6
  if canDrag and self._dragHandler == nil then
    self._dragHandler = (self._container):Subscribe_DragEvent(self.OnDrag, self)
  else
    if canDrag == false and self._dragHandler ~= nil then
      (self._container):Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
  end
end

MiniMapDialog.CanZoom = function(self, canZoom)
  -- function num : 0_7 , upvalues : UIManager
  if canZoom and self._zoomHandler == nil then
    self._zoomHandler = (self._container):Subscribe_ZoomEvent(self.OnZoom, self)
    self._endZoomHandler = (self._container):Subscribe_EndZoomEvent(self.OnEndZoom, nil)
    self._cancelZoomHandler = (self._container):Subscribe_CancelZoomEvent(self.OnCancelZoom, nil)
    self._beginZoomScale = 1
    ;
    (UIManager.SetGameObjectZoomEnable)((self._container)._uiObject, true)
  else
    if canZoom == false and self._zoomHandler ~= nil then
      (self._container):Unsubscribe_ZoomEvent(self._zoomHandler)
      ;
      (self._container):Unsubscribe_EndZoomEvent(self._endZoomHandler)
      ;
      (self._container):Unsubscribe_CancelZoomEvent(self._cancelZoomHandler)
      self._zoomHandler = nil
      self._endZoomHandler = nil
    end
  end
end

MiniMapDialog.SetNavImage = function(self, navImageIndex, selfRow, selfCol, targetRow, targetCol)
  -- function num : 0_8 , upvalues : IsExitInSmallArea, TransformStaticFunctions
  if IsExitInSmallArea(self, selfRow, selfCol, targetRow, targetCol) == true then
    ((self._navImageParentList)[navImageIndex]):SetActive(false)
    return 
  end
  ;
  ((self._navImageParentList)[navImageIndex]):SetActive(true)
  local angle, length = self:GetNavData(selfRow, selfCol, targetRow, targetCol)
  local navImageParentObject = ((self._navImageParentList)[navImageIndex])._uiObject
  local navImageObject = ((self._navImageList)[navImageIndex])._uiObject
  ;
  (TransformStaticFunctions.SetLocalEuler)(navImageParentObject, 0, 0, angle)
  ;
  (TransformStaticFunctions.SetLocalPosition)(navImageObject, length, 0, 0)
end

MiniMapDialog.GetNavData = function(self, selfRow, selfCol, targetRow, targetCol)
  -- function num : 0_9 , upvalues : _ENV
  if selfRow == targetRow and selfCol == targetCol then
    return false
  end
  if selfRow == targetRow then
    if selfCol < targetCol then
      return 0, self._miniMapAreaHalfWidth
    else
      return 180, self._miniMapAreaHalfWidth
    end
  else
    if selfCol == targetCol then
      if selfRow < targetRow then
        return 270, self._miniMapAreaHalfHeight
      else
        return 90, self._miniMapAreaHalfHeight
      end
    end
  end
  local xDiff = targetCol - selfCol
  local yDiff = selfRow - targetRow
  local tanValue = yDiff / xDiff
  tanValue = tanValue * self._miniMapAreaHalfHeight / self._miniMapAreaHalfWidth
  local interactiveLenght = (math.abs)(self._miniMapAreaHalfWidth * (tanValue))
  local angle = ((math.atan)(tanValue))
  local length = nil
  if self._miniMapAreaHalfHeight < interactiveLenght then
    length = self._miniMapAreaHalfHeight / (math.abs)((math.sin)(angle))
  else
    length = self._miniMapAreaHalfWidth / (math.abs)((math.cos)(angle))
  end
  if targetCol < selfCol then
    if angle <= 0 then
      return 180 + (math.deg)(angle), length
    else
      return 180 + (math.deg)(angle), length
    end
  end
  return (math.deg)(angle), length
end

local SetEdgePos = function(self, deltaX, deltaY)
  -- function num : 0_10
end

MiniMapDialog.SetFullScreen = function(self)
  -- function num : 0_11 , upvalues : TransformStaticFunctions
  local scaleX, scaleY, scaleZ = (TransformStaticFunctions.GetLocalScale)(self._containerTransform)
  self._originalContainerXScale = scaleX
  self._originalContainerYScale = scaleY
  self._currentContainerXScale = scaleX
  self._currentContainerYScale = scaleY
  local fullScreenSize = (self._miniMap).FullScreenSize
  self._fullWidth = fullScreenSize.x
  self._fullHeight = fullScreenSize.y
  self._currentFullWidth = self._fullWidth
  self._currentFullHeight = self._fullHeight
end

MiniMapDialog.OnDrag = function(self, args)
  -- function num : 0_12
end

MiniMapDialog.OnZoom = function(self, args)
  -- function num : 0_13
end

MiniMapDialog.OnEndZoom = function(self, args)
  -- function num : 0_14
end

MiniMapDialog.OnCancelZoom = function(self, args)
  -- function num : 0_15
end

MiniMapDialog.OnBackBtnClicked = function(self)
  -- function num : 0_16 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return MiniMapDialog

