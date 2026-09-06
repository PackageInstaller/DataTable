local CStringRes = BeanManager.GetTableByName("message.cstringres")
local OffLinePVPEmptyDialog = class("OffLinePVPEmptyDialog", Dialog)
OffLinePVPEmptyDialog.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePVPEmptyDialog.AssetName = "OffLinePVPEmpty"

function OffLinePVPEmptyDialog:Ctor(...)
  OffLinePVPEmptyDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function OffLinePVPEmptyDialog:OnCreate()
  self._describeTxt = self:GetChild("Back/Txt")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

function OffLinePVPEmptyDialog:OnBackBtnClicked()
  self:Destroy()
end

function OffLinePVPEmptyDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function OffLinePVPEmptyDialog:SetWaitDescribe()
  local str = CStringRes:GetRecorder(1375).msgTextID
  str = TextManager.GetText(str)
  self._describeTxt:SetText(str)
end

return OffLinePVPEmptyDialog
