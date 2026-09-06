local GetItemDialog = class("GetItemDialog", Dialog)
GetItemDialog.AssetBundleName = "ui/layouts.secondconfirm"
GetItemDialog.AssetName = "GetItemDialog"

function GetItemDialog:Ctor(...)
  GetItemDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GetItemDialog:OnCreate()
  self._title = self:GetChild("TitleText")
  self._text = self:GetChild("ContentText")
  self._exit = self:GetChild("ConfirmButton")
  self._icon = self:GetChild("IconImage")
  self._exit:Subscribe_PointerClickEvent(self.OnCloseClick, self)
end

function GetItemDialog:OnDestroy()
end

function GetItemDialog:Refresh()
  local recorder = BeanManager.GetTableByName("ui.cimagepath"):GetRecorder(self._cfg.img) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(recorder.assetBundle, recorder.assetName)
  self._text:SetText(TextManager.GetText(self._cfg.contentTextID))
  self._title:SetText(TextManager.GetText(self._cfg.titleTextID))
end

function GetItemDialog:SetData(id)
  self._cfg = BeanManager.GetTableByName("popups.cpopupgetitem"):GetRecorder(tonumber(id))
  if not self._cfg then
    LogError("tip", "invalid cpopupgetitem id " .. id)
  end
  self:Refresh()
end

function GetItemDialog:OnCloseClick()
  if not self._closing then
    self._closing = true
    self:GetRootWindow():Subscribe_AnimationEvent(self._cfg.endAni, self.OnAnimatorStateExit, self)
    self:GetRootWindow():PlayAnimation(self._cfg.endAni)
  end
end

function GetItemDialog:OnAnimatorStateExit(handle, stateName, normalizedTime)
  self:Destroy()
end

return GetItemDialog
