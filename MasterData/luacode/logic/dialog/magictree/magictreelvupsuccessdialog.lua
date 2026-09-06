local CTreeLvUp = BeanManager.GetTableByName("courtyard.ctreelvup")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local MagicTreeLvUpSuccessDialog = class("MagicTreeLvUpSuccessDialog", Dialog)
MagicTreeLvUpSuccessDialog.AssetBundleName = "ui/layouts.yard"
MagicTreeLvUpSuccessDialog.AssetName = "MagicTreeNewAni"

function MagicTreeLvUpSuccessDialog:Ctor(...)
  MagicTreeLvUpSuccessDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MagicTreeLvUpSuccessDialog:OnCreate()
  self._image = self:GetChild("Tree")
  self._lastLv = self:GetChild("Lv/Txt2")
  self._curLv = self:GetChild("Lv/Txt3")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function MagicTreeLvUpSuccessDialog:OnDestroy()
end

function MagicTreeLvUpSuccessDialog:Init(lastLv, curLv)
  local record = CTreeLvUp:GetRecorder(curLv)
  local imgRecord = CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  self._lastLv:SetText(lastLv)
  self._curLv:SetText(curLv)
end

function MagicTreeLvUpSuccessDialog:OnBackBtnClicked()
  self:Destroy()
end

return MagicTreeLvUpSuccessDialog
