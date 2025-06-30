-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/sdklogindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ServerListManager = require("logic.net.serverlistmanager")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BreakOrReconnect = require("logic.fsm.gamefsm.breakorreconnect")
local SdkLoginDialog = class("SdkLoginDialog", Dialog)
SdkLoginDialog.AssetBundleName = "ui/layouts.login"
SdkLoginDialog.AssetName = "LoginLeiTingSDK"
local columnNums = 6
SdkLoginDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SdkLoginDialog
  ((SdkLoginDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SdkLoginDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, columnNums, GridFrame
  self._loginOnline = self:GetChild("SubmitButton")
  self._qqLoginOnline = self:GetChild("SubmitButtonQQ")
  self._wxLoginOnline = self:GetChild("SubmitButtonWechat")
  self._problemFeedBack = self:GetChild("SendLogButton")
  ;
  (self._problemFeedBack):SetActive(false)
  self._notice = self:GetChild("NoticeButton")
  self._logout = self:GetChild("SignoutBtn")
  self._customerService = self:GetChild("ContactBtn")
  self._privacyPolicy = self:GetChild("SecretBtn")
  self._userPolicy = self:GetChild("UserBtn")
  self._beianButton = self:GetChild("BeianText")
  self._panel = self:GetChild("Frame")
  ;
  (self._qqLoginOnline):Subscribe_PointerClickEvent(self.OnQQLoginClicked, self)
  ;
  (self._wxLoginOnline):Subscribe_PointerClickEvent(self.OnWXLoginClicked, self)
  ;
  (self._problemFeedBack):Subscribe_PointerClickEvent(self.ProblemFeedBack, self)
  ;
  (self._notice):Subscribe_PointerClickEvent(self.OnNoticeClick, self)
  ;
  (self._logout):Subscribe_PointerClickEvent(self.OnLogoutClick, self)
  ;
  (self._customerService):Subscribe_PointerClickEvent(self.OnCustomerServiceClick, self)
  ;
  (self._privacyPolicy):Subscribe_PointerClickEvent(self.OnPrivacyPolicyClick, self)
  ;
  (self._userPolicy):Subscribe_PointerClickEvent(self.OnUserPolicyClick, self)
  ;
  (self._loginOnline):Subscribe_PointerClickEvent(self.OnGameLoginClicked, self)
  ;
  (self._beianButton):Subscribe_PointerClickEvent(self.OnBeiAnClick, self)
  self._pvButton = self:GetChild("PVBtn")
  ;
  (self._pvButton):Subscribe_PointerClickEvent(self.OnPVBtnClicked, self)
  self._pvEffect = self:GetChild("PVBtn/Effect")
  self._ageTips = self:GetChild("AgeTips")
  ;
  (self._ageTips):Subscribe_PointerClickEvent(self.OnAgeTipsClicked, self)
  self._agreeBtn = self:GetChild("Chkbox/Background")
  ;
  (self._agreeBtn):Subscribe_PointerClickEvent(self.OnAgreeBtnClicked, self)
  self._agreeImg = self:GetChild("Chkbox/Background/Checkmark")
  self.agreecheck = false
  self:InitAgreeBtn()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLoginResult, Common.n_LoginResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLogoutResult, Common.n_LogoutResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMainConnectException, Common.n_MainConnectException, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnIPServerResponse, Common.n_QuestIPResult, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnLoginNotice, Common.n_LoginAnnouncement, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(1)
  self._serverListData = client_server_list
  if #self._serverListData == 1 then
    (self._panel):SetActive(false)
    local ipServerDomainList = ((self._serverListData)[1]).ipServerDomain
    local ipServerPortList = ((self._serverListData)[1]).ipServerPort
    local ipIndex = (math.random)(1, #ipServerDomainList)
    self._ip_quest_domain = ipServerDomainList[ipIndex]
    self._ip_quest_port = ipServerPortList[ipIndex]
  else
    do
      ;
      (self._panel):SetActive(true)
      do
        local canSlide = true
        if #self._serverListData <= columnNums * 2 then
          canSlide = false
        end
        self._frame = (GridFrame.Create)(self._panel, self, true, columnNums, canSlide)
        ;
        (self._frame):ReloadAllCell()
        if GlobalGameFSM and GlobalGameFSM:GetLastState() == "Init" then
          self:OnSdkLogin()
        end
        self._lastClickTime = 0
      end
    end
  end
end

SdkLoginDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._frame then
    (self._frame):Destroy()
    self._frame = nil
  end
end

SdkLoginDialog.OnSdkLogin = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local curtime = (os.time)()
  if curtime - self._lastClickTime <= 3 then
    LogInfo("SdkManager", "sdk wait login")
    return 
  end
  if self.agreecheck == false then
    ((NekoData.BehaviorManager).BM_Message):AddMessageTip("需要勾选同意协议才能登录")
    return 
  end
  self._lastClickTime = curtime
  ;
  (SdkManager.Login)((JSON.encode)({loginType = "normal"}))
end

SdkLoginDialog.OnGameLoginClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Login):GetSDKLoginResult() then
    self:OnSdkLogin()
    return 
  end
  self:GameLogin()
end

SdkLoginDialog.GameLogin = function(self)
  -- function num : 0_5 , upvalues : _ENV, ServerListManager
  local resultJson = ((NekoData.BehaviorManager).BM_Login):GetSDKLoginResult()
  self._channel = (SdkManager.GetChannel)()
  if resultJson.status ~= "1" then
    return 
  end
  self._token = resultJson.token
  self._account = resultJson.userId
  ;
  (SdkManager.SetSdkAccount)(resultJson.userId)
  LogInfoFormat(" SdkLoginDialog ", "OnLoginResult status:%s ,userId:%s,token:%s userName:%s channelNo:%s ", resultJson.status, resultJson.userId, resultJson.token, resultJson.userName, resultJson.channelNo)
  ;
  (ServerListManager.QuestIPAndPort)(self._token, self._channel, self._ip_quest_domain, self._ip_quest_port, self._account, resultJson.channelNo)
end

SdkLoginDialog.OnQQLoginClicked = function(self, args)
  -- function num : 0_6 , upvalues : _ENV
  (SdkManager.Login)((JSON.encode)({loginType = "QQ"}))
end

SdkLoginDialog.OnWXLoginClicked = function(self, args)
  -- function num : 0_7 , upvalues : _ENV
  (SdkManager.Login)((JSON.encode)({loginType = "WinXin"}))
end

SdkLoginDialog.ProblemFeedBack = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("confirmbox.sendlogconfirmdialog")
end

SdkLoginDialog.OnMainConnectException = function(self, noti)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddMessageTip((noti.userInfo):GetException())
end

SdkLoginDialog.OnLoginResult = function(self, notification)
  -- function num : 0_10 , upvalues : BreakOrReconnect
  if BreakOrReconnect.reconnectFSM then
    return 
  end
end

SdkLoginDialog.OnLogoutResult = function(self)
  -- function num : 0_11
end

SdkLoginDialog.OnIPServerResponse = function(self, notification)
  -- function num : 0_12 , upvalues : BreakOrReconnect, _ENV, ServerListManager
  if BreakOrReconnect.reconnectFSM then
    return 
  end
  local resultJson = (JSON.decode)(notification.userInfo)
  if resultJson.result == (ServerListManager.IPServerResponseResultType).RESULT_SUCCESS then
    if resultJson.ip then
      self._ip = resultJson.ip
    else
      LogError("SdkLoginDialog", "ip server return ip is nil")
    end
    if resultJson.port then
      self._port = resultJson.port
    else
      LogError("SdkLoginDialog", "ip server return port is nil")
    end
    if self._ip and self._port then
      LogInfoFormat("SdkLoginDialog", "ip: [%s], port: [%d] account:%s token:%s", self._ip, self._port, self._account, self._token)
      ;
      (LuaNetManager.ConnectToServer)(self._ip, self._port, self._account, self._token, self._channel)
    end
  end
end

SdkLoginDialog.OnNoticeClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if (NoticeManager.IsPending)() then
    self._task = (GameTimer.AddTask)(3, 0, function()
    -- function num : 0_13_0 , upvalues : self
    self._task = nil
    self:OnNoticeClick()
  end
)
  end
  local dialog = (DialogManager.CreateSingletonDialog)("notice.loginnoticedialog")
  local error, update = (NoticeManager.GetLoginNotice)()
  if error.version then
    dialog:SetData(error)
  else
    if update.version then
      dialog:SetData(update)
    else
      LogError("notice", "no available notice")
      ;
      (DialogManager.DestroySingletonDialog)("notice.loginnoticedialog")
    end
  end
end

SdkLoginDialog.OnLoginNotice = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self:OnNoticeClick()
  else
    local error, update = (NoticeManager.GetLoginNotice)()
    if error and error.popup then
      ((DialogManager.CreateSingletonDialog)("notice.loginnoticedialog")):SetData(error)
    else
      if update and update.popup then
        ((DialogManager.CreateSingletonDialog)("notice.loginnoticedialog")):SetData(update)
      end
    end
  end
end

SdkLoginDialog.OnLogoutClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local platform = (SdkManager.GetPlatform)()
  if platform == "Android" then
    (SdkManager.Logout)()
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100194)
    self:OnSdkLogin()
  end
end

SdkLoginDialog.OnCustomerServiceClick = function(self)
  -- function num : 0_16 , upvalues : _ENV
  ((SdkManager.GetAgent)()):ShowCustomerService("")
end

SdkLoginDialog.OnPrivacyPolicyClick = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)("http://www.szjasmine.com/yszc/fushudmn_moli_yszc.html")
end

SdkLoginDialog.OnUserPolicyClick = function(self)
  -- function num : 0_18 , upvalues : _ENV
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)("http://www.szjasmine.com/yszc/molv_szmoli_yhxy.html")
end

SdkLoginDialog.OnBeiAnClick = function(self)
  -- function num : 0_19 , upvalues : _ENV
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)("https://beian.miit.gov.cn/#/Integrated/index")
end

SdkLoginDialog.NumberOfCell = function(self, frame)
  -- function num : 0_20
  return #self._serverListData
end

SdkLoginDialog.CellAtIndex = function(self, frame)
  -- function num : 0_21
  return "login.logindialogcell"
end

SdkLoginDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_22
  return (self._serverListData)[index]
end

SdkLoginDialog.OnCellClicked = function(self, data)
  -- function num : 0_23 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Login):GetSDKLoginResult() then
    self:OnSdkLogin()
    return 
  end
  local ipServerDomainList = data.ipServerDomain
  local ipServerPortList = data.ipServerPort
  local ipIndex = (math.random)(1, #ipServerDomainList)
  LogInfoFormat("SdkLoginDialog", "ipDomain %s port %s", ipServerDomainList[ipIndex], ipServerPortList[ipIndex])
  self._ip_quest_domain = ipServerDomainList[ipIndex]
  self._ip_quest_port = ipServerPortList[ipIndex]
  self:GameLogin()
end

SdkLoginDialog.OnPVBtnClicked = function(self)
  -- function num : 0_24 , upvalues : _ENV
  self:RemovePVEffect()
  ;
  ((DialogManager.CreateSingletonDialog)("playpvdialog")):SetType(true)
end

SdkLoginDialog.TryShowPVEffect = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if (((CS.UnityEngine).PlayerPrefs).GetInt)("HavePlayPVEffect", 0) == 0 then
    if self._pvEffectHandler then
      (self._pvEffect):ReleaseEffect(self._pvEffectHandler)
      self._pvEffectHandler = nil
    end
    self._pvEffectHandler = (self._pvEffect):AddEffectAsync((EffectUtil.GetAssetBundleNameAndAssetName)(1108))
  end
end

SdkLoginDialog.RemovePVEffect = function(self)
  -- function num : 0_26 , upvalues : _ENV
  (((CS.UnityEngine).PlayerPrefs).SetInt)("HavePlayPVEffect", 1)
  if self._pvEffectHandler then
    (self._pvEffect):ReleaseEffect(self._pvEffectHandler)
    self._pvEffectHandler = nil
  end
end

SdkLoginDialog.OnAgeTipsClicked = function(self)
  -- function num : 0_27 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("login.agetipspopdialog")):Init()
end

SdkLoginDialog.InitAgreeBtn = function(self)
  -- function num : 0_28 , upvalues : _ENV
  if (((CS.UnityEngine).PlayerPrefs).HasKey)("HaveAgreeBtn") == false then
    (((CS.UnityEngine).PlayerPrefs).SetInt)("HaveAgreeBtn", 0)
    ;
    (self._agreeImg):SetActive(false)
    self.agreecheck = false
    return 
  end
  ;
  (self._agreeImg):SetActive(false)
  self.agreecheck = false
  if (((CS.UnityEngine).PlayerPrefs).GetInt)("HaveAgreeBtn") == 1 then
    (self._agreeImg):SetActive(true)
    self.agreecheck = true
  end
end

SdkLoginDialog.OnAgreeBtnClicked = function(self)
  -- function num : 0_29 , upvalues : _ENV
  if (((CS.UnityEngine).PlayerPrefs).GetInt)("HaveAgreeBtn") == 1 then
    (((CS.UnityEngine).PlayerPrefs).SetInt)("HaveAgreeBtn", 0)
    ;
    (self._agreeImg):SetActive(false)
    self.agreecheck = false
  else
    ;
    (((CS.UnityEngine).PlayerPrefs).SetInt)("HaveAgreeBtn", 1)
    ;
    (self._agreeImg):SetActive(true)
    self.agreecheck = true
  end
end

return SdkLoginDialog

