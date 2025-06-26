-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/entrycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EntryCell = class("EntryCell", Dialog)
EntryCell.AssetBundleName = "ui/layouts.activitystar"
EntryCell.AssetName = "ActivityStarMainBuffCell"
EntryCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EntryCell
  ((EntryCell.super).Ctor)(self, ...)
end

EntryCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Txt")
  self._img = self:GetChild("Img")
end

EntryCell.OnDestroy = function(self)
  -- function num : 0_2
end

EntryCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  (self._txt):SetText((TextManager.GetText)(data.nameId))
  local image = CImagePathTable:GetRecorder(data.img)
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
end

return EntryCell

