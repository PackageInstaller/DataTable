-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/loginmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local ServerListManager = require("logic.net.serverlistmanager")
local LoginMainDialog = class("LoginMainDialog", Dialog)
LoginMainDialog.AssetBundleName = "ui/layouts.login"
LoginMainDialog.AssetName = "LoginMain"
LoginMainDialog.ErrorType = {LinkFailed = 1, LogoutFailed = 2}
LoginMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoginMainDialog
  ((LoginMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._failToLinkSDK = false
  self._failToLinkIP = false
  self._tapClickHandler = -1
end

LoginMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._loginOutBtn = self:GetChild("SignOutBtn")
  self._noticeBtn = self:GetChild("NoticeBtn")
  self._waitingLogin = self:GetChild("Waiting")
  self._changeServerBtn = self:GetChild("ChooseBtn")
  ;
  (self._loginOutBtn):SetActive(false)
  ;
  (self._waitingLogin):SetActive(true)
  ;
  (self._changeServerBtn):SetActive(false)
  ;
  (self._loginOutBtn):Subscribe_PointerClickEvent(self.OnLoginOutBtnClicked, self)
  ;
  (self._noticeBtn):Subscribe_PointerClickEvent(self.OnNoticeBtnClicked, self)
  ;
  (self._changeServerBtn):Subscribe_PointerClickEvent(self.OnChangeServerBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLoginResult, Common.n_LoginResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLogoutResult, Common.n_LogoutResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnIPServerResponse, Common.n_QuestIPResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnIPServerLinkFailed, Common.n_IPServerLinkFailed, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMainConnectException, Common.n_MainConnectException, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSdkUrlWrong, Common.n_PhoneNumSdkUrlWrong, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(1)
end

LoginMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

LoginMainDialog.Init = function(self, isTest)
  -- function num : 0_3 , upvalues : _ENV
  self._isTest = isTest
  ;
  (self._changeServerBtn):SetActive(isTest)
  if isTest then
    self._ip = nil
    self._port = nil
    ;
    (self._loginOutBtn):SetActive(false)
    self._login = false
    self._failToLinkSDK = false
    self._failToLinkIP = false
    ;
    (self._waitingLogin):SetActive(true)
    if self._tapClickHandler ~= -1 then
      (self:GetRootWindow()):Unsubscribe_PointerClickEvent(self._tapClickHandler)
      self._tapClickHandler = -1
    end
    ;
    ((DialogManager.CreateSingletonDialog)("login.loginphonedialog")):Init(self)
  else
    local ipServerDomainList = (client_server_list[1]).ipServerDomain
    local ipServerPortList = (client_server_list[1]).ipServerPort
    local ipIndex = (math.random)(1, #ipServerDomainList)
    LogInfoFormat("LoginMainDialog", "login sdkDomain %s port %s, ipDomain %s port %s", (client_server_list[1]).sdkDomain, (client_server_list[1]).sdkPort, ipServerDomainList[ipIndex], ipServerPortList[ipIndex])
    self._ip_quest_domain = ipServerDomainList[ipIndex]
    self._ip_quest_port = ipServerPortList[ipIndex]
    ;
    (SdkManager.Login)((JSON.encode)({domain = (client_server_list[1]).sdkDomain, port = (client_server_list[1]).sdkPort}))
  end
end

LoginMainDialog.OnServerCellClicked = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  local ipServerDomainList = data.ipServerDomain
  local ipServerPortList = data.ipServerPort
  local ipIndex = (math.random)(1, #ipServerDomainList)
  LogInfoFormat("LoginMainDialog", "login sdkDomain %s port %s, ipDomain %s port %s", data.sdkDomain, data.sdkPort, ipServerDomainList[ipIndex], ipServerPortList[ipIndex])
  self._ip_quest_domain = ipServerDomainList[ipIndex]
  self._ip_quest_port = ipServerPortList[ipIndex]
  ;
  (SdkManager.Login)((JSON.encode)({domain = data.sdkDomain, port = data.sdkPort}))
end

LoginMainDialog.OnTapClicked = function(self, args)
  -- function num : 0_5 , upvalues : _ENV
  if self._login then
    (LuaNetManager.ConnectToServer)(self._ip, self._port, self._token, "", self._plat)
  else
    if self._failToLinkSDK then
      self._login = false
      self._failToLinkSDK = false
      self._failToLinkIP = false
      if self._tapClickHandler ~= -1 then
        (self:GetRootWindow()):Unsubscribe_PointerClickEvent(self._tapClickHandler)
        self._tapClickHandler = -1
      end
      ;
      (self._loginOutBtn):SetActive(false)
      ;
      (self._waitingLogin):SetActive(true)
      self:Init(self._isTest)
    else
      if self._failToLinkIP then
        self._failToLinkIP = false
        if self._tapClickHandler ~= -1 then
          (self:GetRootWindow()):Unsubscribe_PointerClickEvent(self._tapClickHandler)
          self._tapClickHandler = -1
        end
        ;
        (self._loginOutBtn):SetActive(false)
        ;
        (self._waitingLogin):SetActive(true)
        self:Init(self._isTest)
      else
        self:Destroy()
      end
    end
  end
end

LoginMainDialog.OnLoginOutBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((((CS.PixelNeko).P1).PlatformManager).Logout)("")
end

LoginMainDialog.OnLoginResult = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV, ServerListManager, LoginMainDialog
  local resultJson = (JSON.decode)(notification.userInfo)
  if resultJson then
    if resultJson.result == "true" then
      (self._loginOutBtn):SetActive(true)
      if resultJson.token then
        if resultJson.phoneNum then
          self._token = tostring(resultJson.token)
          self._plat = "cell"
          self._failToLinkSDK = false
          ;
          (ServerListManager.QuestIPAndPort)(self._token, self._plat, self._ip_quest_domain, self._ip_quest_port)
        else
          LogError("LoginMainDialog", "login success but phoneNum is nil")
        end
      else
        LogError("LoginMainDialog", "login success but token is nil")
      end
    else
      if resultJson.result == "false" and resultJson.selfDefineErrorType == (LoginMainDialog.ErrorType).LinkFailed then
        self._failToLinkSDK = true
        self:OnFailedNoticeShow()
      end
    end
  else
    self._failToLinkSDK = true
    self:OnFailedNoticeShow()
  end
end

LoginMainDialog.OnLogoutResult = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV, LoginMainDialog
  local resultJson = (JSON.decode)(notification.userInfo)
  if resultJson then
    if resultJson.result == "true" then
      (self._loginOutBtn):SetActive(false)
    else
    end
  end
  if resultJson.result ~= "false" or resultJson.selfDefineErrorType == (LoginMainDialog.ErrorType).LogoutFailed then
  end
end

LoginMainDialog.OnMainConnectException = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddMessageTip((notification.userInfo):GetException())
end

LoginMainDialog.OnIPServerResponse = function(self, notification)
  -- function num : 0_10 , upvalues : _ENV
  local resultJson = (JSON.decode)(notification.userInfo)
  if resultJson.result == "true" then
    if resultJson.ip then
      self._ip = resultJson.ip
    else
      LogError("LoginMainDialog", "ip server return ip is nil")
    end
    if resultJson.port then
      self._port = resultJson.port
    else
      LogError("LoginMainDialog", "ip server return port is nil")
    end
    if self._ip and self._port then
      LogInfoFormat("LoginMainDialog", "ip: [%s], port: [%d]", self._ip, self._port)
      self._login = true
      if self._tapClickHandler ~= -1 then
        (self:GetRootWindow()):Unsubscribe_PointerClickEvent(self._tapClickHandler)
        self._tapClickHandler = -1
      end
      self._tapClickHandler = (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnTapClicked, self)
      ;
      (self._waitingLogin):SetActive(false)
    else
      self._failToLinkIP = true
      self:OnFailedNoticeShow()
    end
  else
    self._failToLinkIP = true
    self:OnFailedNoticeShow()
  end
end

LoginMainDialog.OnFailedNoticeShow = function(self)
  -- function num : 0_11 , upvalues : _ENV, CVarConfig
  if self._tapClickHandler ~= -1 then
    (self:GetRootWindow()):Unsubscribe_PointerClickEvent(self._tapClickHandler)
    self._tapClickHandler = -1
  end
  self._tapClickHandler = (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnTapClicked, self)
  ;
  (self._waitingLogin):SetActive(false)
  local flag = true
  local zeroTime = (os.date)("!*t", (os.time)())
  local startTime = (string.split)((CVarConfig:GetRecorder(13)).Value, ",")
  local endTime = (string.split)((CVarConfig:GetRecorder(14)).Value, ",")
  local startTimeTable = {year = tonumber(startTime[1]), month = tonumber(startTime[2]), day = tonumber(startTime[3]), hour = tonumber(startTime[4]) - 8, min = tonumber(startTime[5]), sec = tonumber(startTime[6])}
  local endTimeTable = {year = tonumber(endTime[1]), month = tonumber(endTime[2]), day = tonumber(endTime[3]), hour = tonumber(endTime[4]) - 8, min = tonumber(endTime[5]), sec = tonumber(endTime[6])}
  local event = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("period", nil, startTimeTable, endTimeTable)
  event:AddTrigger("period", trigger)
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_11_0 , upvalues : flag
    flag = false
  end
)
  event:AddEffect(effect)
  ;
  (EventManager.AddEvent)(event)
  ;
  (TriggerManager.OnPeriodArrival)(zeroTime)
  if flag then
    self:OnNoticeBtnClicked()
  else
    ;
    (DialogManager.CreateSingletonDialog)("login.loginneterrordialog")
  end
end

LoginMainDialog.OnNoticeBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("login.announcementdialog")
  if dialog then
    if self._login then
      dialog:Init((dialog.Status).Open)
    else
      dialog:Init((dialog.Status).Close)
    end
  end
end

LoginMainDialog.OnIPServerLinkFailed = function(self, notification)
  -- function num : 0_13 , upvalues : ServerListManager
  local e = notification.userInfo
  if e.errorType == (ServerListManager.ErrorType).LinkFail then
    self._failToLinkIP = true
    self:OnFailedNoticeShow()
  end
end

LoginMainDialog.OnSdkUrlWrong = function(self)
  -- function num : 0_14
  if self._isTest then
    self:Init(self._isTest)
  else
    self._failToLinkSDK = true
    self:OnFailedNoticeShow()
  end
end

LoginMainDialog.OnChangeServerBtnClicked = function(self)
  -- function num : 0_15
  self:Init(self._isTest)
end

return LoginMainDialog

