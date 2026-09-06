local ConfirmDialog = class("ConfirmDialog", Dialog)
ConfirmDialog.AssetBundleName = "ui/layouts.gacha"
ConfirmDialog.AssetName = "GachaConfirm"

function ConfirmDialog:Ctor(...)
  ConfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._strList = {}
end

function ConfirmDialog:OnCreate()
  self._text = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function ConfirmDialog:OnDestroy()
end

function ConfirmDialog:Refresh()
  if #self._strList == 0 then
    self:Destroy()
  else
    self._text:SetText(self._strList[1].str)
  end
end

function ConfirmDialog:AddConfirmDialog(str, confirmFunc)
  table.insert(self._strList, {str = str, confirmFunc = confirmFunc})
  if #self._strList == 1 then
    self:Refresh()
  end
end

function ConfirmDialog:OnClickConfirmBtn()
  if self._strList[1].confirmFunc then
    self._strList[1].confirmFunc()
  end
  table.remove(self._strList, 1)
  self:Refresh()
end

return ConfirmDialog
