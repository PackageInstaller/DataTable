local TowerV2TipDialog = class("TowerV2TipDialog", Dialog)
TowerV2TipDialog.AssetBundleName = "ui/layouts.stair"
TowerV2TipDialog.AssetName = "StairTips"

function TowerV2TipDialog:Ctor(...)
  TowerV2TipDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function TowerV2TipDialog:OnCreate()
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._frame = self:GetChild("Back/Frame")
  self._text = self:GetChild("Back/Frame/Text")
  self._close = self:GetChild("CloseBtn")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._close:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local date = os.date("*t", NekoData.BehaviorManager.BM_TowerV2:GetNextTime())
  local text = TextManager.GetText(1900979):gsub("%$parameter(%d)%$", {
    ["1"] = date.month,
    ["2"] = date.day
  })
  self._text:SetText(text)
  local _, height = self._text:GetPreferredSize()
  self._text:SetHeight(0, height)
  self._frame:GetUIObject():GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function TowerV2TipDialog:OnDestroy()
end

function TowerV2TipDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("towerv2.towerv2tipdialog")
end

return TowerV2TipDialog
