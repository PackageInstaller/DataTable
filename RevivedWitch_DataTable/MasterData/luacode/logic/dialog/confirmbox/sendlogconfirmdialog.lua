-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/sendlogconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SendLogConfirmDialog = class("SendLogConfirmDialog", Dialog)
SendLogConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
SendLogConfirmDialog.AssetName = "SendLogConfirm"
SendLogConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SendLogConfirmDialog
  ((SendLogConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SendLogConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._toggleList = {}
  for i = 1, 4 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self._toggleList)[i] = self:GetChild("Send/TypeSelect/Toggle" .. i)
  end
  ;
  ((self._toggleList)[1]):SetIsOnType(true)
  self._contactMethod = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

    (self._contactMethod)[i] = self:GetChild("Send/ContactSelect/Toggle" .. i)
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
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmButtonClicked2, self)
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._finishClose):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("lastUserId", "0")
  ;
  (self._userIdText):SetText(userid)
end

SendLogConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SendLogConfirmDialog.OnConfirmButtonClicked2 = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._fail):SetActive(false)
  local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
  if userid == "0" then
    userid = (((CS.UnityEngine).PlayerPrefs).GetString)("lastUserId", "0")
  end
  local feedbacktype = ""
  if ((self._toggleList)[1]):GetIsOnType() then
    feedbacktype = "战斗卡死"
  else
    if ((self._toggleList)[2]):GetIsOnType() then
      feedbacktype = "流程卡死"
    else
      if ((self._toggleList)[3]):GetIsOnType() then
        feedbacktype = "运行卡顿"
      else
        if ((self._toggleList)[4]):GetIsOnType() then
          feedbacktype = "其他问题"
        end
      end
    end
  end
  local destribe = (string.trim)((self._introduction):GetText())
  local serverId = (((CS.UnityEngine).PlayerPrefs).GetInt)("serverId", 0)
  local other = {}
  local c1, c2 = ((self._contactMethod)[1]):GetIsOnType(), ((self._contactMethod)[2]):GetIsOnType()
  do
    if c1 or c2 then
      local value = (string.trim)((self._contact):GetText())
      if (string.len)(value) > 0 then
        other.contact = value
        other.contactMethod = c1 and "QQ" or "手机"
      end
    end
    local success = (((((CS.PixelNeko).P1).Feedback).LogTrace).UploadFeedback)("https://fusdmnclog.leiting.com/api/feedback", tostring(userid), feedbacktype, destribe, tostring(serverId), other)
    if not success then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100114)
      self:Destroy()
    else
      ;
      (self._wait):SetActive(true)
      ;
      (self._send):SetActive(false)
    end
  end
end

SendLogConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

SendLogConfirmDialog.OnUpdate = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self._wait):IsActive() then
    local p, s = (((((CS.PixelNeko).P1).Feedback).LogTrace).GetProgress)()
    if s == ((((CS.PixelNeko).P1).Feedback).Status).Success then
      (self._wait):SetActive(false)
      ;
      (self._finish):SetActive(true)
    else
      if s == ((((CS.PixelNeko).P1).Feedback).Status).SendingMessageFail or s == ((((CS.PixelNeko).P1).Feedback).Status).UploadingFileFail then
        (self._fail):SetActive(true)
        ;
        (self._wait):SetActive(false)
        ;
        (self._send):SetActive(true)
      end
    end
  end
end

return SendLogConfirmDialog

