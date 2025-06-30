-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/headphotocell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HeadPhotoTable = (BeanManager.GetTableByName)("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = (BeanManager.GetTableByName)("headphoto.cheadphotoframeconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HeadPhotoCell = class("HeadPhotoCell", Dialog)
HeadPhotoCell.AssetBundleName = "ui/layouts.setting"
HeadPhotoCell.AssetName = "SettingPhotoCell"
HeadPhotoCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HeadPhotoCell
  ((HeadPhotoCell.super).Ctor)(self, ...)
end

HeadPhotoCell.OnCreate = function(self)
  -- function num : 0_1
  self._photo = self:GetChild("HeadPhotoBack/Photo")
  self._frame = self:GetChild("HeadPhotoBack/Frame")
  self._select = self:GetChild("HeadPhotoBack/Select")
  self._grey = self:GetChild("HeadPhotoBack/Grey")
  self._lock = self:GetChild("HeadPhotoBack/Lock")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

HeadPhotoCell.OnDestroy = function(self)
  -- function num : 0_2
end

HeadPhotoCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : HeadPhotoTable, CImagePathTable, _ENV, HeadPhotoFrameTable
  if (self._delegate)._tag == "HeadPhoto" then
    local headPhotoRecord = HeadPhotoTable:GetRecorder(data.id)
    if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(((self._delegate)._selectedHeadFrame).id)
    if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if data.id == ((self._delegate)._selectedHeadPhoto).id then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
  do
    if (self._delegate)._tag == "HeadFrame" then
      local headPhotoRecord = HeadPhotoTable:GetRecorder(((self._delegate)._selectedHeadPhoto).id)
      if not CImagePathTable:GetRecorder(headPhotoRecord.photoid) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._photo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(data.id)
      if not CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if data.id == ((self._delegate)._selectedHeadFrame).id then
        (self._select):SetActive(true)
      else
        ;
        (self._select):SetActive(false)
      end
    end
    do
      ;
      (self._lock):SetActive(data.lock)
      ;
      (self._grey):SetActive(data.lock)
    end
  end
end

HeadPhotoCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SetSelectedId(self._cellData)
end

HeadPhotoCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if arg.id ~= (self._cellData).id then
    (self._select):SetActive(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return HeadPhotoCell

