local BrandDialog = class("BrandDialog", Dialog)
BrandDialog.AssetBundleName = "ui/layouts.secondconfirm"
BrandDialog.AssetName = "BrandDialog"

function BrandDialog:Ctor(...)
  BrandDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function BrandDialog:OnCreate()
  self._icon = self:GetChild("IconImage")
  self._title = self:GetChild("TitleText")
  self._text = self:GetChild("ContentText")
  CS.PixelNeko.Animation.EventTriggerHelper.AddStateUpdateListener(self:GetRootWindow():GetUIObject(), self.OnStateUpdate, self)
end

function BrandDialog:OnDestroy()
end

function BrandDialog:Refresh()
  local recorder = BeanManager.GetTableByName("ui.cimagepath"):GetRecorder(self._cfg.img)
  self._icon:SetSprite(recorder.assetBundle, recorder.assetName)
  self._text:SetText(TextManager.GetText(self._cfg.contentTextID))
  self._title:SetText(TextManager.GetText(self._cfg.titleTextID))
end

function BrandDialog:SetData(id)
  self._cfg = BeanManager.GetTableByName("popups.cpopupgetitem"):GetRecorder(tonumber(id))
  if not self._cfg then
    LogError("tip", "invalid cpopupgetitem id " .. id)
  end
  self:Refresh()
end

function BrandDialog:OnStateUpdate(handle, stateName, normalizedTime)
  self:Destroy()
end

return BrandDialog
