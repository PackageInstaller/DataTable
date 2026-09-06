local LoverUnlockDialog = class("LoverUnlockDialog", Dialog)
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
LoverUnlockDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverUnlockDialog.AssetName = "ActivityValentinesStart"

function LoverUnlockDialog:Ctor(...)
  LoverUnlockDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function LoverUnlockDialog:OnCreate()
  self._goBtn = self:GetChild("BackImage/GoBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._backImage = self:GetChild("BackImage")
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function LoverUnlockDialog:Init()
  local image = CImagePathTable:GetRecorder(13835) or DataCommon.DefaultImageAsset
  self._backImage:SetSprite(image.assetBundle, image.assetName)
end

function LoverUnlockDialog:OnDestroy()
end

function LoverUnlockDialog:OnGoBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetloveractivityinfo")
  if protocol then
    protocol:Send()
  end
end

function LoverUnlockDialog:OnBackBtnClicked()
  self:Destroy()
end

return LoverUnlockDialog
