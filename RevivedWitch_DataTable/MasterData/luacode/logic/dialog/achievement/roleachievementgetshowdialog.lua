-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/achievement/roleachievementgetshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAchievementBagConfig = (BeanManager.GetTableByName)("mission.cachievebadgeconfig")
local RoleAchievementGetShowDialog = class("RoleAchievementGetShowDialog", Dialog)
RoleAchievementGetShowDialog.AssetBundleName = "ui/layouts.basetasklist"
RoleAchievementGetShowDialog.AssetName = "AchievementMedalGet"
RoleAchievementGetShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleAchievementGetShowDialog
  ((RoleAchievementGetShowDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

RoleAchievementGetShowDialog.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("Medal")
  self._name = self:GetChild("Name")
  self._effect = self:GetChild("Effect")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

RoleAchievementGetShowDialog.OnDestroy = function(self)
  -- function num : 0_2
end

RoleAchievementGetShowDialog.SetData = function(self, id)
  -- function num : 0_3 , upvalues : CAchievementBagConfig, CImagePathTable, _ENV
  local record = CAchievementBagConfig:GetRecorder(id)
  if not CImagePathTable:GetRecorder(record.imageID) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID))
  if record.colorID == 1 then
    (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1141))
  else
    if record.colorID == 2 then
      (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1142))
    else
      if record.colorID == 3 then
        (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1143))
      end
    end
  end
end

RoleAchievementGetShowDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_4
  if (self:GetRootWindow()):IsActive() then
    self:Destroy()
  end
end

return RoleAchievementGetShowDialog

