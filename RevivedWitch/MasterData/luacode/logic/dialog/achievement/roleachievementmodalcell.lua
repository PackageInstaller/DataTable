-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementmodalcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local RoleAchievementModalCell = class("RoleAchievementModalCell", Dialog)
RoleAchievementModalCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementModalCell.AssetName = "AchievementMedalCell"
RoleAchievementModalCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementModalCell
  ((RoleAchievementModalCell.super).Ctor)(self, ...)
end

RoleAchievementModalCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Medal")
end

RoleAchievementModalCell.OnDestroy = function(self)
  -- function num : 0_2
end

RoleAchievementModalCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, CAchievementBagConfig, _ENV
  if not CImagePathTable:GetRecorder((CAchievementBagConfig:GetRecorder(data.id)).imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

return RoleAchievementModalCell

