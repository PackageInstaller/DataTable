-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/charshowmodalcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local CharShowModalCell = class("CharShowModalCell", Dialog)
CharShowModalCell.AssetBundleName = "ui/layouts.basetasklist"
CharShowModalCell.AssetName = "AchievementMedalCell"
CharShowModalCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharShowModalCell
  ((CharShowModalCell.super).Ctor)(self, ...)
end

CharShowModalCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Medal")
  self._emptyImg = self:GetChild("back")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

CharShowModalCell.OnDestroy = function(self)
  -- function num : 0_2
end

CharShowModalCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAchievementBagConfig, CImagePathTable, _ENV
  self._id = data.id
  ;
  (self._emptyImg):SetActive(data.id == -1)
  ;
  (self._img):SetActive(data.id ~= -1)
  if data.id ~= -1 then
    local record = CAchievementBagConfig:GetRecorder(data.id)
    if record then
      if not CImagePathTable:GetRecorder(record.imageID) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CharShowModalCell.OnCellClicked = function(self)
  -- function num : 0_4
  if (self._delegate).OnCellClick then
    (self._delegate):OnCellClick(self._id)
  end
end

return CharShowModalCell

