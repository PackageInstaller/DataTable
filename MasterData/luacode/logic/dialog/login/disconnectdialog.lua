local CMessagetipCfg = BeanManager.GetTableByName("message.cmessagetip")
local DisconnectDialog = class("DisconnectDialog", Dialog)
DisconnectDialog.AssetBundleName = "ui/layouts.loading"
DisconnectDialog.AssetName = "ReconnectionSecondConfirm"

function DisconnectDialog:Ctor(...)
  DisconnectDialog.super.Ctor(self, ...)
  self._groupName = "BrokenLine"
  self._confirmBtnClickFunc = nil
end

function DisconnectDialog:OnCreate()
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function DisconnectDialog:OnDestroy()
end

function DisconnectDialog:Init(msgId, parameter, yesfunc)
  local msgRecord = CMessagetipCfg:GetRecorder(msgId)
  local messageStr = TextManager.GetText(msgRecord.msgTextID)
  if string.find(messageStr, "parameter") then
    for i = 1, table.nums(parameter) do
      messageStr = string.gsub(messageStr, "%$parameter1%$", parameter[i], 1)
    end
  end
  self._text:SetText(messageStr)
  self._confirmBtnClickFunc = yesfunc
end

function DisconnectDialog:OnClickConfirmBtn()
  if self._confirmBtnClickFunc then
    self._confirmBtnClickFunc()
    self._confirmBtnClickFunc = nil
  end
  self:Destroy()
end

return DisconnectDialog
