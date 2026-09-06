local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local RoleAchievementModalCell = class("RoleAchievementModalCell", Dialog)
RoleAchievementModalCell.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementModalCell.AssetName = "AchievementMedalCell"

function RoleAchievementModalCell:Ctor(...)
  RoleAchievementModalCell.super.Ctor(self, ...)
end

function RoleAchievementModalCell:OnCreate()
  self._img = self:GetChild("Medal")
end

function RoleAchievementModalCell:OnDestroy()
end

function RoleAchievementModalCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(CAchievementBagConfig:GetRecorder(data.id).imageID) or DataCommon.DefaultImageAsset
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

return RoleAchievementModalCell
