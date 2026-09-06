local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAchievementBagConfig = BeanManager.GetTableByName("mission.cachievebadgeconfig")
local RoleAchievementGetShowDialog = class("RoleAchievementGetShowDialog", Dialog)
RoleAchievementGetShowDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementGetShowDialog.AssetName = "AchievementMedalGet"

function RoleAchievementGetShowDialog:Ctor(...)
  RoleAchievementGetShowDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function RoleAchievementGetShowDialog:OnCreate()
  self._img = self:GetChild("Medal")
  self._name = self:GetChild("Name")
  self._effect = self:GetChild("Effect")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function RoleAchievementGetShowDialog:OnDestroy()
end

function RoleAchievementGetShowDialog:SetData(id)
  local record = CAchievementBagConfig:GetRecorder(id)
  local imageRecord = CImagePathTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.nameTextID))
  if record.colorID == 1 then
    self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1141))
  elseif record.colorID == 2 then
    self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1142))
  elseif record.colorID == 3 then
    self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1143))
  end
end

function RoleAchievementGetShowDialog:OnBackBtnClicked(args)
  if self:GetRootWindow():IsActive() then
    self:Destroy()
  end
end

return RoleAchievementGetShowDialog
