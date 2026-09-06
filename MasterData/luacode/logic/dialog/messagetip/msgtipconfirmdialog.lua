local MsgTipConfirmDialog = class("MsgTipConfirmDialog", Dialog)
MsgTipConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
MsgTipConfirmDialog.AssetName = "SingleConfirmLarge"

function MsgTipConfirmDialog:Ctor(...)
  MsgTipConfirmDialog.super.Ctor(self, ...)
  self._groupName = "Message"
  self._strList = {}
end

function MsgTipConfirmDialog:OnCreate()
  self._text = self:GetChild("Text")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function MsgTipConfirmDialog:OnDestroy()
end

function MsgTipConfirmDialog:Refresh()
  if #self._strList == 0 then
    self:Destroy()
  else
    self._text:SetText(self._strList[1])
  end
end

function MsgTipConfirmDialog:AddConfirmTip(str)
  table.insert(self._strList, str)
  if #self._strList == 1 then
    self:Refresh()
  end
end

function MsgTipConfirmDialog:OnClickConfirmBtn()
  table.remove(self._strList, 1)
  self:Refresh()
end

return MsgTipConfirmDialog
