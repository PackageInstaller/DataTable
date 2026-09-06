local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local RectTransformStaticFunctions = CS.PixelNeko.Lua.RectTransformStaticFunctions
local Vector2 = CS.UnityEngine.Vector2
local UIManager = CS.PixelNeko.UI.UIManager
local MiniMapDialog = class("MiniMapDialog", Dialog)
MiniMapDialog.AssetBundleName = "ui/layouts.minimap"
MiniMapDialog.AssetName = "MiniMap"

local function IsExitInSmallArea(self, selfRow, selfCol, targetRow, targetCol)
  if math.abs(targetRow - selfRow) <= self._halfRowCountInSmall and math.abs(targetCol - selfCol) <= self._halfColCountInSmall then
    return true
  end
  return false
end

function MiniMapDialog:Ctor(...)
  MiniMapDialog.super.Ctor(self, ...)
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

function MiniMapDialog:OnCreate()
  self._navImageRoot = self:GetChild("NavImageRoot")
  self._container = self:GetChild("Container")
  self._containerTransform = self._container._uiObject.transform
end

function MiniMapDialog:Init(miniMap, navImageCount)
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
    self._navImageParentList[i] = self:GetChild("NavImageRoot/NavImage" .. i)
    self._navImageList[i] = self:GetChild("NavImageRoot/NavImage" .. i .. "/NaviArrow")
  end
end

function MiniMapDialog:GetMiniMapGameObject()
  return self:GetRootWindow()._uiObject
end

function MiniMapDialog:ShowNavImage(isShow)
  self._navImageRoot:SetActive(isShow)
end

function MiniMapDialog:CanDrag(canDrag)
  if canDrag and self._dragHandler == nil then
    self._dragHandler = self._container:Subscribe_DragEvent(self.OnDrag, self)
  elseif canDrag == false and self._dragHandler ~= nil then
    self._container:Unsubscribe_DragEvent(self._dragHandler)
    self._dragHandler = nil
  end
end

function MiniMapDialog:CanZoom(canZoom)
  if canZoom and self._zoomHandler == nil then
    self._zoomHandler = self._container:Subscribe_ZoomEvent(self.OnZoom, self)
    self._endZoomHandler = self._container:Subscribe_EndZoomEvent(self.OnEndZoom, nil)
    self._cancelZoomHandler = self._container:Subscribe_CancelZoomEvent(self.OnCancelZoom, nil)
    self._beginZoomScale = 1
    UIManager.SetGameObjectZoomEnable(self._container._uiObject, true)
  elseif canZoom == false and self._zoomHandler ~= nil then
    self._container:Unsubscribe_ZoomEvent(self._zoomHandler)
    self._container:Unsubscribe_EndZoomEvent(self._endZoomHandler)
    self._container:Unsubscribe_CancelZoomEvent(self._cancelZoomHandler)
    self._zoomHandler = nil
    self._endZoomHandler = nil
  end
end

function MiniMapDialog:SetNavImage(navImageIndex, selfRow, selfCol, targetRow, targetCol)
  if IsExitInSmallArea(self, selfRow, selfCol, targetRow, targetCol) == true then
    self._navImageParentList[navImageIndex]:SetActive(false)
    return
  end
  self._navImageParentList[navImageIndex]:SetActive(true)
  local angle, length = self:GetNavData(selfRow, selfCol, targetRow, targetCol)
  local navImageParentObject = self._navImageParentList[navImageIndex]._uiObject
  local navImageObject = self._navImageList[navImageIndex]._uiObject
  TransformStaticFunctions.SetLocalEuler(navImageParentObject, 0, 0, angle)
  TransformStaticFunctions.SetLocalPosition(navImageObject, length, 0, 0)
end

function MiniMapDialog:GetNavData(selfRow, selfCol, targetRow, targetCol)
  if selfRow == targetRow and selfCol == targetCol then
    return false
  end
  if selfRow == targetRow then
    if selfCol < targetCol then
      return 0, self._miniMapAreaHalfWidth
    else
      return 180, self._miniMapAreaHalfWidth
    end
  elseif selfCol == targetCol then
    if selfRow < targetRow then
      return 270, self._miniMapAreaHalfHeight
    else
      return 90, self._miniMapAreaHalfHeight
    end
  end
  local xDiff = targetCol - selfCol
  local yDiff = selfRow - targetRow
  local tanValue = yDiff / xDiff
  tanValue = tanValue * self._miniMapAreaHalfHeight / self._miniMapAreaHalfWidth
  local interactiveLenght = math.abs(self._miniMapAreaHalfWidth * tanValue)
  local angle = math.atan(tanValue)
  local length
  if interactiveLenght > self._miniMapAreaHalfHeight then
    length = self._miniMapAreaHalfHeight / math.abs(math.sin(angle))
  else
    length = self._miniMapAreaHalfWidth / math.abs(math.cos(angle))
  end
  if targetCol < selfCol then
    if angle <= 0 then
      return 180 + math.deg(angle), length
    else
      return 180 + math.deg(angle), length
    end
  end
  return math.deg(angle), length
end

local function SetEdgePos(self, deltaX, deltaY)
end

function MiniMapDialog:SetFullScreen()
  local scaleX, scaleY, scaleZ = TransformStaticFunctions.GetLocalScale(self._containerTransform)
  self._originalContainerXScale = scaleX
  self._originalContainerYScale = scaleY
  self._currentContainerXScale = scaleX
  self._currentContainerYScale = scaleY
  local fullScreenSize = self._miniMap.FullScreenSize
  self._fullWidth = fullScreenSize.x
  self._fullHeight = fullScreenSize.y
  self._currentFullWidth = self._fullWidth
  self._currentFullHeight = self._fullHeight
end

function MiniMapDialog:OnDrag(args)
end

function MiniMapDialog:OnZoom(args)
end

function MiniMapDialog:OnEndZoom(args)
end

function MiniMapDialog:OnCancelZoom(args)
end

function MiniMapDialog:OnBackBtnClicked()
  return DataCommon.BackPressed_SkipResponse
end

return MiniMapDialog
