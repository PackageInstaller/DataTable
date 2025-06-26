-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/furniturestoretabbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDormFurTypeSpecial = (BeanManager.GetTableByName)("courtyard.cdormfurtypespecial")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local FurnitureStoreTabBtnCell = class("FurnitureStoreTabBtnCell", Dialog)
FurnitureStoreTabBtnCell.AssetBundleName = "ui/layouts.yard"
FurnitureStoreTabBtnCell.AssetName = "FurnitureShopGroupBtn"
FurnitureStoreTabBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureStoreTabBtnCell
  ((FurnitureStoreTabBtnCell.super).Ctor)(self, ...)
end

FurnitureStoreTabBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("GroupBtn")
  self._txt = self:GetChild("GroupBtn/Text")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClicked, self)
end

FurnitureStoreTabBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

FurnitureStoreTabBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CDormFurTypeSpecial, CImagePathTable, _ENV
  local recorder = nil
  if (data.recorder).id == 0 then
    recorder = CDormFurTypeSpecial:GetRecorder(1)
  else
    recorder = data.recorder
  end
  local imgRecord = CImagePathTable:GetRecorder(recorder.imagenorm)
  ;
  (self._btn):SetTextImgNormal(imgRecord.assetBundle, imgRecord.assetName)
  imgRecord = CImagePathTable:GetRecorder(recorder.imageselect)
  ;
  (self._btn):SetTextImgSelected(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._txt):SetText((TextManager.GetText)(recorder.nameTextID))
  ;
  (self._btn):SetSelected((data.recorder).id == (self._delegate)._selectTabId)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

FurnitureStoreTabBtnCell.OnBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectTabId(((self._cellData).recorder).id)
end

FurnitureStoreTabBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if ((self._cellData).recorder).id ~= (self._delegate)._selectTabId then
    (self._btn):SetSelected(eventName ~= "SetSelectTabId")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return FurnitureStoreTabBtnCell

