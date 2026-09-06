local LoginDialogCell = class("LoginDialogCell", Dialog)
LoginDialogCell.AssetBundleName = "ui/layouts.login"
LoginDialogCell.AssetName = "LoginDialogCell"

function LoginDialogCell:Ctor(...)
  LoginDialogCell.super.Ctor(self, ...)
end

function LoginDialogCell:OnCreate()
  self._name = self:GetChild("_Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function LoginDialogCell:OnDestroy()
end

function LoginDialogCell:RefreshCell(data)
  self._name:SetText(data.name)
end

function LoginDialogCell:OnCellClicked()
  self._delegate:OnCellClicked(self._cellData)
end

return LoginDialogCell
