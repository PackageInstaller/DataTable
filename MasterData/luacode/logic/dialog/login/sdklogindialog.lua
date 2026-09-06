local ServerListManager = require("logic.net.serverlistmanager")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local BreakOrReconnect = require("logic.fsm.gamefsm.breakorreconnect")
local SdkLoginDialog = class("SdkLoginDialog", Dialog)
SdkLoginDialog.AssetBundleName = "ui/layouts.login"
SdkLoginDialog.AssetName = "LoginLeiTingSDK"
local columnNums = 6

function SdkLoginDialog:Ctor(...)
  SdkLoginDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function SdkLoginDialog:OnCreate()
  self._loginOnline = self:GetChild("SubmitButton")
  self._qqLoginOnline = self:GetChild("SubmitButtonQQ")
  self._wxLoginOnline = self:GetChild("SubmitButtonWechat")
  self._problemFeedBack = self:GetChild("SendLogButton")
  self._problemFeedBack:SetActive(false)
  self._notice = self:GetChild("NoticeButton")
  self._logout = self:GetChild("SignoutBtn")
  self._customerService = self:GetChild("ContactBtn")
  self._privacyPolicy = self:GetChild("SecretBtn")
  self._userPolicy = self:GetChild("UserBtn")
  self._beianButton = self:GetChild("BeianText")
  self._panel = self:GetChild("Frame")
  self._privacyPolicyText = self:GetChild("Chkbox/Privacy")
  self._privacyPolicyText:Subscribe_PointerClickEvent(self.OnPrivacyPolicyClick, self)
  self._userPolicyText = self:GetChild("Chkbox/Agreement")
  self._userPolicyText:Subscribe_PointerClickEvent(self.OnUserPolicyClick, self)
  self._qqLoginOnline:Subscribe_PointerClickEvent(self.OnQQLoginClicked, self)
  self._wxLoginOnline:Subscribe_PointerClickEvent(self.OnWXLoginClicked, self)
  self._problemFeedBack:Subscribe_PointerClickEvent(self.ProblemFeedBack, self)
  self._logout:Subscribe_PointerClickEvent(self.OnLogoutClick, self)
  self._customerService:Subscribe_PointerClickEvent(self.OnCustomerServiceClick, self)
  self._privacyPolicy:Subscribe_PointerClickEvent(self.OnPrivacyPolicyClick, self)
  self._userPolicy:Subscribe_PointerClickEvent(self.OnUserPolicyClick, self)
  self._loginOnline:Subscribe_PointerClickEvent(self.OnGameLoginClicked, self)
  self._beianButton:Subscribe_PointerClickEvent(self.OnBeiAnClick, self)
  self._pvButton = self:GetChild("PVBtn")
  self._pvButton:Subscribe_PointerClickEvent(self.OnPVBtnClicked, self)
  self._pvEffect = self:GetChild("PVBtn/Effect")
  self._ageTips = self:GetChild("AgeTips")
  self._ageTips:Subscribe_PointerClickEvent(self.OnAgeTipsClicked, self)
  self._agreeBtn = self:GetChild("Chkbox/Background")
  self._agreeBtn:Subscribe_PointerClickEvent(self.OnAgreeBtnClicked, self)
  self._agreeImg = self:GetChild("Chkbox/Background/Checkmark")
  self.agreecheck = false
  self:InitAgreeBtn()
  LuaNotificationCenter.AddObserver(self, self.OnLoginResult, Common.n_LoginResult, nil)
  LuaNotificationCenter.AddObserver(self, self.OnLogoutResult, Common.n_LogoutResult, nil)
  LuaNotificationCenter.AddObserver(self, self.OnMainConnectException, Common.n_MainConnectException, nil)
  LuaNotificationCenter.AddObserver(self, self.OnIPServerResponse, Common.n_QuestIPResult, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(1)
  self._serverListData = client_server_list
  if #self._serverListData == 1 then
    self._panel:SetActive(false)
    local ipServerDomainList = self._serverListData[1].ipServerDomain
    local ipServerPortList = self._serverListData[1].ipServerPort
    local ipIndex = math.random(1, #ipServerDomainList)
    self._ip_quest_domain = ipServerDomainList[ipIndex]
    self._ip_quest_port = ipServerPortList[ipIndex]
  else
    self._panel:SetActive(true)
    local canSlide = true
    if #self._serverListData <= columnNums * 2 then
      canSlide = false
    end
    self._frame = GridFrame.Create(self._panel, self, true, columnNums, canSlide)
    self._frame:ReloadAllCell()
  end
  if GlobalGameFSM and GlobalGameFSM:GetLastState() == "Init" then
    self:OnSdkLogin()
  end
  self._lastClickTime = 0
end

function SdkLoginDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
end

function SdkLoginDialog:OnSdkLogin()
  LogInfo("SdkLoginDialog", "OnSdkLogin 1")
  local curtime = os.time()
  if curtime - self._lastClickTime <= 3 then
    LogInfo("SdkManager", "sdk wait login")
    LogInfo("SdkLoginDialog", "OnSdkLogin 2")
    return
  end
  LogInfo("SdkLoginDialog", "OnSdkLogin 3")
  if self.agreecheck == false then
    NekoData.BehaviorManager.BM_Message:AddMessageTip("需要勾选同意协议才能登录")
    LogInfo("SdkLoginDialog", "OnSdkLogin 4")
    return
  end
  LogInfo("SdkLoginDialog", "OnSdkLogin 5")
  self._lastClickTime = curtime
  SdkManager.Login(JSON.encode({loginType = "normal"}))
end

function SdkLoginDialog:OnGameLoginClicked()
  LogInfo("SdkLoginDialog", "OnGameLoginClicked 1 ")
  if not NekoData.BehaviorManager.BM_Login:GetSDKLoginResult() then
    LogInfo("SdkLoginDialog", "OnGameLoginClicked 2")
    self:OnSdkLogin()
    return
  end
  LogInfo("SdkLoginDialog", "OnGameLoginClicked 3 ")
  self:GameLogin()
end

function SdkLoginDialog:GameLogin()
  LogInfo("SdkLoginDialog", "GameLogin 1")
  local resultJson = NekoData.BehaviorManager.BM_Login:GetSDKLoginResult()
  self._channel = SdkManager.GetChannel()
  if resultJson.status ~= "1" then
    LogInfo("SdkLoginDialog", "GameLogin 2")
    if SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
      LogInfo("SdkLoginDialog", "GameLogin 3")
      self:OnSdkLogin()
    end
    return
  end
  LogInfo("SdkLoginDialog", "GameLogin 4")
  self._token = resultJson.token
  self._account = resultJson.userId
  SdkManager.SetSdkAccount(resultJson.userId)
  LogInfoFormat(" SdkLoginDialog ", "OnLoginResult status:%s ,userId:%s,token:%s userName:%s channelNo:%s ", resultJson.status, resultJson.userId, resultJson.token, resultJson.userName, resultJson.channelNo)
  if self._ip_quest_domain then
    ServerListManager.QuestIPAndPort(self._token, self._channel, self._ip_quest_domain, self._ip_quest_port, self._account, resultJson.channelNo)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100512)
  end
end

function SdkLoginDialog:OnQQLoginClicked(args)
  SdkManager.Login(JSON.encode({loginType = "QQ"}))
end

function SdkLoginDialog:OnWXLoginClicked(args)
  SdkManager.Login(JSON.encode({loginType = "WinXin"}))
end

function SdkLoginDialog:ProblemFeedBack()
  DialogManager.CreateSingletonDialog("confirmbox.sendlogconfirmdialog")
end

function SdkLoginDialog:OnMainConnectException(noti)
  NekoData.BehaviorManager.BM_Message:AddMessageTip(noti.userInfo:GetException())
end

function SdkLoginDialog:OnLoginResult(notification)
  if BreakOrReconnect.reconnectFSM then
    return
  end
end

function SdkLoginDialog:OnLogoutResult()
end

function SdkLoginDialog:OnIPServerResponse(notification)
  if BreakOrReconnect.reconnectFSM then
    return
  end
  local resultJson = JSON.decode(notification.userInfo)
  if resultJson.result == ServerListManager.IPServerResponseResultType.RESULT_SUCCESS then
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
      LuaNetManager.ConnectToServer(self._ip, self._port, self._account, self._token, self._channel)
    end
  end
end

function SdkLoginDialog:OnLogoutClick()
  local platform = SdkManager.GetPlatform()
  if platform == "Android" then
    SdkManager.Logout()
    NekoData.BehaviorManager.BM_Message:SendMessageById(100194)
    self:OnSdkLogin()
  end
end

function SdkLoginDialog:OnCustomerServiceClick()
  SdkManager.GetAgent():ShowCustomerService("")
end

function SdkLoginDialog:OnPrivacyPolicyClick()
  LogInfoFormat("SdkLoginDialog", "OnPrivacyPolicyClick 1")
  if SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
    LogInfoFormat("SdkLoginDialog", "OnPrivacyPolicyClick 2")
    local channel = SdkManager.GetChannelID()
    local Record = SdkManager:GetQuickChannelRecord(tonumber(channel))
    if Record then
      LogInfoFormat("SdkLoginDialog", "OnPrivacyPolicyClick 3")
      CS.PixelNeko.Tools.ShareHelper.OpenURL(Record.yinsiurl)
    else
      LogInfoFormat("SdkLoginDialog", "OnPrivacyPolicyClick 4")
      CS.PixelNeko.Tools.ShareHelper.OpenURL("http://www.szjasmine.com/yszc/fushudmn_moli_yszc.html")
    end
  else
    LogInfoFormat("SdkLoginDialog", "OnPrivacyPolicyClick 5")
    CS.PixelNeko.Tools.ShareHelper.OpenURL("http://www.szjasmine.com/yszc/fushudmn_moli_yszc.html")
  end
  LogInfoFormat("SdkLoginDialog", "OnPrivacyPolicyClick 6")
end

function SdkLoginDialog:OnUserPolicyClick()
  LogInfoFormat("SdkLoginDialog", "OnUserPolicyClick 1")
  if SdkManager.GetChannel() == "quka" or SdkManager.GetChannel() == "qukb" then
    LogInfoFormat("SdkLoginDialog", "OnUserPolicyClick 2")
    local channel = SdkManager.GetChannelID()
    local Record = SdkManager:GetQuickChannelRecord(tonumber(channel))
    if Record then
      LogInfoFormat("SdkLoginDialog", "OnUserPolicyClick 3")
      CS.PixelNeko.Tools.ShareHelper.OpenURL(Record.userurl)
    else
      LogInfoFormat("SdkLoginDialog", "OnUserPolicyClick 4")
      CS.PixelNeko.Tools.ShareHelper.OpenURL("http://www.szjasmine.com/yszc/molv_szmoli_yhxy.html")
    end
  else
    LogInfoFormat("SdkLoginDialog", "OnUserPolicyClick 5")
    CS.PixelNeko.Tools.ShareHelper.OpenURL("http://www.szjasmine.com/yszc/molv_szmoli_yhxy.html")
  end
  LogInfoFormat("SdkLoginDialog", "OnUserPolicyClick 6")
end

function SdkLoginDialog:OnBeiAnClick()
  CS.PixelNeko.Tools.ShareHelper.OpenURL("https://beian.miit.gov.cn/#/Integrated/index")
end

function SdkLoginDialog:NumberOfCell(frame)
  return #self._serverListData
end

function SdkLoginDialog:CellAtIndex(frame)
  return "login.logindialogcell"
end

function SdkLoginDialog:DataAtIndex(frame, index)
  return self._serverListData[index]
end

function SdkLoginDialog:OnCellClicked(data)
  if not NekoData.BehaviorManager.BM_Login:GetSDKLoginResult() then
    self:OnSdkLogin()
    return
  end
  local ipServerDomainList = data.ipServerDomain
  local ipServerPortList = data.ipServerPort
  local ipIndex = math.random(1, #ipServerDomainList)
  LogInfoFormat("SdkLoginDialog", "ipDomain %s port %s", ipServerDomainList[ipIndex], ipServerPortList[ipIndex])
  self._ip_quest_domain = ipServerDomainList[ipIndex]
  self._ip_quest_port = ipServerPortList[ipIndex]
  self:GameLogin()
end

function SdkLoginDialog:OnPVBtnClicked()
  self:RemovePVEffect()
  DialogManager.CreateSingletonDialog("playpvdialog"):SetType(true)
end

function SdkLoginDialog:TryShowPVEffect()
  if CS.UnityEngine.PlayerPrefs.GetInt("HavePlayPVEffect", 0) == 0 then
    if self._pvEffectHandler then
      self._pvEffect:ReleaseEffect(self._pvEffectHandler)
      self._pvEffectHandler = nil
    end
    self._pvEffectHandler = self._pvEffect:AddEffectAsync(EffectUtil.GetAssetBundleNameAndAssetName(1108))
  end
end

function SdkLoginDialog:RemovePVEffect()
  CS.UnityEngine.PlayerPrefs.SetInt("HavePlayPVEffect", 1)
  if self._pvEffectHandler then
    self._pvEffect:ReleaseEffect(self._pvEffectHandler)
    self._pvEffectHandler = nil
  end
end

function SdkLoginDialog:OnAgeTipsClicked()
  DialogManager.CreateSingletonDialog("login.agetipspopdialog"):Init()
end

function SdkLoginDialog:InitAgreeBtn()
  if CS.UnityEngine.PlayerPrefs.HasKey("HaveAgreeBtn") == false then
    CS.UnityEngine.PlayerPrefs.SetInt("HaveAgreeBtn", 0)
    self._agreeImg:SetActive(false)
    self.agreecheck = false
    return
  end
  self._agreeImg:SetActive(false)
  self.agreecheck = false
  if CS.UnityEngine.PlayerPrefs.GetInt("HaveAgreeBtn") == 1 then
    self._agreeImg:SetActive(true)
    self.agreecheck = true
  end
end

function SdkLoginDialog:OnAgreeBtnClicked()
  if CS.UnityEngine.PlayerPrefs.GetInt("HaveAgreeBtn") == 1 then
    CS.UnityEngine.PlayerPrefs.SetInt("HaveAgreeBtn", 0)
    self._agreeImg:SetActive(false)
    self.agreecheck = false
  else
    CS.UnityEngine.PlayerPrefs.SetInt("HaveAgreeBtn", 1)
    self._agreeImg:SetActive(true)
    self.agreecheck = true
  end
end

return SdkLoginDialog
