-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterjobcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CharacterJobCell = class("CharacterJobCell", Dialog)
CharacterJobCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterJobCell.AssetName = "JobDetailCell"
CharacterJobCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterJobCell
  ((CharacterJobCell.super).Ctor)(self, ...)
end

CharacterJobCell.OnCreate = function(self)
  -- function num : 0_1
  self._jobImg = self:GetChild("Job")
  self._jobTxt = self:GetChild("JobTxt")
  self._detail = self:GetChild("JobDetail")
end

CharacterJobCell.OnDestroy = function(self)
  -- function num : 0_2
end

CharacterJobCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImageTable, _ENV
  if not CImageTable:GetRecorder(data.imageId) then
    local ImageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._jobImg):SetSprite(ImageRecord.assetBundle, ImageRecord.assetName)
  ;
  (self._jobTxt):SetText(data.text)
  ;
  (self._detail):SetText(data.detail)
end

return CharacterJobCell

