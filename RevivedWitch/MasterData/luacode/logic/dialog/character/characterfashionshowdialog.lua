-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterfashionshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CharacterFashionShowDialog = class("CharacterFashionShowDialog", Dialog)
CharacterFashionShowDialog.AssetBundleName = "ui/layouts.baseshop"
CharacterFashionShowDialog.AssetName = "FashionCharShow"
CharacterFashionShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterFashionShowDialog
  ((CharacterFashionShowDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._handler = nil
end

CharacterFashionShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : UIManager, _ENV, CVarconfig
  self._rolePanel = self:GetChild("Role")
  self._live2D = self:GetChild("Role/Live2D")
  self._rolePhoto = self:GetChild("Role/Photo")
  ;
  (self._rootWindow):Subscribe_DragEvent(self.OnDrag, self)
  ;
  (self._rootWindow):Subscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Subscribe_BeginZoomEvent(self.OnBeginZoom, self)
  ;
  (self._rootWindow):Subscribe_ZoomEvent(self.OnZoom, self)
  ;
  (self._rootWindow):Subscribe_EndZoomEvent(self.OnEndZoom, self)
  ;
  (self._rootWindow):Subscribe_CancelZoomEvent(self.OnCancelZoom, self)
  ;
  (UIManager.SetGameObjectZoomEnable)((self._rootWindow)._uiObject, true)
  self._backBtn = self:GetChild("BackBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._maxScale = tonumber((CVarconfig:GetRecorder(54)).Value)
  self._minScale = tonumber((CVarconfig:GetRecorder(55)).Value)
  self._width = (self:GetRootWindow()):GetRectSize()
end

CharacterFashionShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_2
  self:Destroy()
end

CharacterFashionShowDialog.OnDestroy = function(self)
  -- function num : 0_3
  if self._handler then
    (self._live2D):Release(self._handler)
    self._live2D = nil
    self._handler = nil
  end
  ;
  (self._rootWindow):Unsubscribe_DragEvent(self.OnDrag, self)
  ;
  (self._rootWindow):Unsubscribe_EndDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Unsubscribe_CancelDragEvent(self.OnEndDrag, self)
  ;
  (self._rootWindow):Unsubscribe_BeginZoomEvent(self.OnBeginZoom, self)
  ;
  (self._rootWindow):Unsubscribe_ZoomEvent(self.OnZoom, self)
  ;
  (self._rootWindow):Unsubscribe_EndZoomEvent(self.OnEndZoom, self)
  ;
  (self._rootWindow):Unsubscribe_CancelZoomEvent(self.OnCancelZoom, self)
end

CharacterFashionShowDialog.SetData = function(self, skinId)
  -- function num : 0_4 , upvalues : CSkin, _ENV, CNpcShapeTable, CImagePathTable
  local skin = CSkin:GetRecorder(skinId)
  local IsFashionLive2D = false
  if skin.shapeType ~= 2 then
    IsFashionLive2D = not skin
    LogErrorFormat("CharacterFashionShowDialog", "skin with id %s is not exist in cskin", skinId)
    local shapeRecord = CNpcShapeTable:GetRecorder(skin.shapeID)
    ;
    (self._rolePanel):SetAnimatorTrigger("loadReady")
    if IsFashionLive2D and (Live2DManager.CanUse)() and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" and not self._handler then
      (self._rolePhoto):SetActive(false)
      self._handler = (self._live2D):AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
      ;
      (self._live2D):SetZRotation(1, 0, 0, 1)
    end
    if not CImagePathTable:GetRecorder(shapeRecord.lihuiID) then
      local lihuiImage = DataCommon.DefaultImageAsset
    end
    ;
    (self._rolePhoto):SetActive(true)
    ;
    (self._rolePhoto):SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    do
      local scale = shapeRecord.photoScale
      ;
      (self._rolePhoto):SetLocalScale(scale, scale, scale)
      ;
      (self._rolePhoto):SetAnchoredPosition((shapeRecord.photoLocation)[1], (shapeRecord.photoLocation)[2])
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

CharacterFashionShowDialog.OnDrag = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  warn("drag: ", (args.delta).x, (args.delta).y)
  local x, y, z = (self._rolePanel):GetLocalPosition()
  x = x + (args.delta).x
  y = y + (args.delta).y
  if self._width * 0.5 < x then
    x = self._width * 0.5
  end
  if x < -(self._width * 0.5) then
    x = -self._width * 0.5
  end
  if self._height * 0.5 < y then
    y = self._height * 0.5
  end
  if y < -(self._height * 0.5) then
    y = -self._height * 0.5
  end
  ;
  (self._rolePanel):SetLocalPosition(x, y, z)
end

CharacterFashionShowDialog.OnBeginZoom = function(self, args)
  -- function num : 0_6
  self._beginScale = (self._rolePanel):GetLocalScale()
  local scale = self._beginScale * args.scale
  if self._maxScale < scale then
    scale = self._maxScale
  end
  if scale < self._minScale then
    scale = self._minScale
  end
  ;
  (self._rolePanel):SetLocalScale(scale, scale, 1)
end

CharacterFashionShowDialog.OnZoom = function(self, args)
  -- function num : 0_7
  local scale = self._beginScale * args.scale
  if self._maxScale < scale then
    scale = self._maxScale
  end
  if scale < self._minScale then
    scale = self._minScale
  end
  ;
  (self._rolePanel):SetLocalScale(scale, scale, 1)
end

CharacterFashionShowDialog.OnEndZoom = function(self, args)
  -- function num : 0_8
  local scale = self._beginScale * args.scale
  if self._maxScale < scale then
    scale = self._maxScale
  end
  if scale < self._minScale then
    scale = self._minScale
  end
  ;
  (self._rolePanel):SetLocalScale(scale, scale, 1)
end

CharacterFashionShowDialog.OnCancelZoom = function(self, args)
  -- function num : 0_9
end

return CharacterFashionShowDialog

