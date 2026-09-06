local CMessagetipCfg = BeanManager.GetTableByName("message.cmessagetip")
local ForceUpdateDialog = class("ForceUpdateDialog", Dialog)
ForceUpdateDialog.AssetBundleName = "ui/layouts.loading"
ForceUpdateDialog.AssetName = "ReconnectionSecondConfirm"

function ForceUpdateDialog:Ctor(...)
  ForceUpdateDialog.super.Ctor(self, ...)
  self._groupName = "ClickEffect"
end

function ForceUpdateDialog:OnCreate()
  self._text = self:GetChild("Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButtonText = self:GetChild("ConfirmButton/_Text")
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
  self:Init(100422)
  self._confirmButtonText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1654))
end

function ForceUpdateDialog:OnDestroy()
end

function ForceUpdateDialog:Init(msgId)
  local msgRecord = CMessagetipCfg:GetRecorder(msgId)
  local messageStr = TextManager.GetText(msgRecord.msgTextID)
  self._text:SetText(messageStr)
end

function ForceUpdateDialog:OnClickConfirmBtn()
  NekoData.BehaviorManager.BM_Game:JumpToTheStore(2)
  if SdkManager.IsOverseas then
    LogInfo("ForceUpdateDialog", "ApplicationQuit")
    CS.UnityEngine.Application.Quit()
  end
end

return ForceUpdateDialog
