local SendLogConfirmDialog = class("SendLogConfirmDialog", Dialog)
SendLogConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
SendLogConfirmDialog.AssetName = "SendLogConfirm"

function SendLogConfirmDialog:Ctor(...)
  SendLogConfirmDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SendLogConfirmDialog:OnCreate()
  self._toggleList = {}
  for i = 1, 4 do
    self._toggleList[i] = self:GetChild("Send/TypeSelect/Toggle" .. i)
  end
  self._toggleList[1]:SetIsOnType(true)
  self._contactMethod = {}
  for i = 1, 2 do
    self._contactMethod[i] = self:GetChild("Send/ContactSelect/Toggle" .. i)
  end
  self._contact = self:GetChild("Send/ContactInputField")
  self._send = self:GetChild("Send")
  self._introduction = self:GetChild("Send/IntroductionInputField")
  self._confirmBtn = self:GetChild("Send/ConfirmButton")
  self._cancleBtn = self:GetChild("Send/CloseButton")
  self._userIdText = self:GetChild("Send/userID")
  self._fail = self:GetChild("Send/Failed")
  self._wait = self:GetChild("Wait")
  self._finish = self:GetChild("Finished")
  self._finishClose = self:GetChild("Finished/CloseButton")
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmButtonClicked2, self)
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._finishClose:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  local userid = CS.UnityEngine.PlayerPrefs.GetString("lastUserId", "0")
  self._userIdText:SetText(userid)
end

function SendLogConfirmDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SendLogConfirmDialog:OnConfirmButtonClicked2()
  self._fail:SetActive(false)
  local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
  if userid == "0" then
    userid = CS.UnityEngine.PlayerPrefs.GetString("lastUserId", "0")
  end
  local feedbacktype = ""
  if self._toggleList[1]:GetIsOnType() then
    feedbacktype = "战斗卡死"
  elseif self._toggleList[2]:GetIsOnType() then
    feedbacktype = "流程卡死"
  elseif self._toggleList[3]:GetIsOnType() then
    feedbacktype = "运行卡顿"
  elseif self._toggleList[4]:GetIsOnType() then
    feedbacktype = "其他问题"
  end
  local destribe = string.trim(self._introduction:GetText())
  local serverId = CS.UnityEngine.PlayerPrefs.GetInt("serverId", 0)
  local other = {}
  local c1, c2 = self._contactMethod[1]:GetIsOnType(), self._contactMethod[2]:GetIsOnType()
  if c1 or c2 then
    local value = string.trim(self._contact:GetText())
    if 0 < string.len(value) then
      other.contact = value
      other.contactMethod = c1 and "QQ" or "手机"
    end
  end
  local success = CS.PixelNeko.P1.Feedback.LogTrace.UploadFeedback("https://fusdmnclog.leiting.com/api/feedback", tostring(userid), feedbacktype, destribe, tostring(serverId), other)
  if not success then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100114)
    self:Destroy()
  else
    self._wait:SetActive(true)
    self._send:SetActive(false)
  end
end

function SendLogConfirmDialog:OnBackBtnClicked()
  self:Destroy()
end

function SendLogConfirmDialog:OnUpdate()
  if self._wait:IsActive() then
    local p, s = CS.PixelNeko.P1.Feedback.LogTrace.GetProgress()
    if s == CS.PixelNeko.P1.Feedback.Status.Success then
      self._wait:SetActive(false)
      self._finish:SetActive(true)
    elseif s == CS.PixelNeko.P1.Feedback.Status.SendingMessageFail or s == CS.PixelNeko.P1.Feedback.Status.UploadingFileFail then
      self._fail:SetActive(true)
      self._wait:SetActive(false)
      self._send:SetActive(true)
    end
  end
end

return SendLogConfirmDialog
