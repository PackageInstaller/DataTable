local GridFrame = require("framework.ui.frame.grid.gridframe")
local ServerListManager = require("logic.net.serverlistmanager")
local BreakOrReconnect = require("logic.fsm.gamefsm.breakorreconnect")
local LoginDialog = class("LoginDialog", Dialog)
LoginDialog.AssetBundleName = "ui/layouts.login"
LoginDialog.AssetName = "LoginDialog"
local columnNums = 6

function LoginDialog:Ctor(...)
  LoginDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function LoginDialog:OnCreate()
  self._panel = self:GetChild("Frame")
  self._username = self:GetChild("InputField")
  self._loginOffline = self:GetChild("LoginOffline")
  self._loginOffline:Subscribe_PointerClickEvent(self.OnLoginOfflineClicked, self)
  self._problemFeedBack = self:GetChild("ProblemBtn")
  self._problemFeedBack:Subscribe_PointerClickEvent(self.ProblemFeedBack, self)
  self._problemFeedBack:SetActive(false)
  self._pvButton = self:GetChild("PVBtn")
  self._pvButton:Subscribe_PointerClickEvent(self.OnPVBtnClicked, self)
  self._pvButton:SetActive(false)
  self._pvEffect = self:GetChild("PVBtn/Effect")
  self._ageTips = self:GetChild("AgeTips")
  self._ageTips:Subscribe_PointerClickEvent(self.OnAgeTipsClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnLoginResult, Common.n_LoginResult, nil)
  LuaNotificationCenter.AddObserver(self, self.OnMainConnectException, Common.n_MainConnectException, nil)
  LuaNotificationCenter.AddObserver(self, self.OnIPServerResponse, Common.n_QuestIPResult, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(1)
  self._username:SetText(CS.UnityEngine.PlayerPrefs.GetString("loginAccount"))
  self._data = client_server_list
  local canSlide = true
  if #self._data <= columnNums * 2 then
    canSlide = false
  end
  self._frame = GridFrame.Create(self._panel, self, true, columnNums, canSlide)
  self._frame:ReloadAllCell()
end

function LoginDialog:OnDestroy()
  self._frame:Destroy()
  UIBackManager.SetUIBackShow(false)
  LuaNotificationCenter.RemoveObserver(self)
end

function LoginDialog:NumberOfCell(frame)
  return #self._data
end

function LoginDialog:CellAtIndex(frame)
  return "login.logindialogcell"
end

function LoginDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function LoginDialog:OnCellClicked(data)
  local ipServerDomainList = data.ipServerDomain
  local ipServerPortList = data.ipServerPort
  local ipIndex = math.random(1, #ipServerDomainList)
  self._ip_quest_domain = ipServerDomainList[ipIndex]
  self._ip_quest_port = ipServerPortList[ipIndex]
  self._serverID = data.serverID
  local username = self._username:GetText()
  username = string.trim(username)
  if username ~= "" then
    CS.UnityEngine.PlayerPrefs.SetString("loginAccount", username)
    SdkManager.Login(JSON.encode({
      host = data.domain,
      port = data.port,
      account = username
    }))
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100003)
  end
end

function LoginDialog:OnLoginOfflineClicked(args)
  LuaNetManager.Close()
  DialogManager.DestroySingletonDialog("login.logindialog")
end

function LoginDialog:OnMainConnectException(noti)
  NekoData.BehaviorManager.BM_Message:AddMessageTip(noti.userInfo:GetException())
end

function LoginDialog:OnLoginResult(notification)
  if BreakOrReconnect.reconnectFSM then
    return
  end
  local resultJson = JSON.decode(notification.userInfo)
  self._account = resultJson.account
  self._token = ""
  self._plat = "apps"
  ServerListManager.QuestIPAndPort(self._token, self._plat, self._ip_quest_domain, self._ip_quest_port, self._account, nil, self._serverID)
end

function LoginDialog:ProblemFeedBack()
  DialogManager.CreateSingletonDialog("confirmbox.sendlogconfirmdialog")
end

function LoginDialog:OnIPServerResponse(notification)
  if BreakOrReconnect.reconnectFSM then
    return
  end
  local resultJson = JSON.decode(notification.userInfo)
  if resultJson.result == ServerListManager.IPServerResponseResultType.RESULT_SUCCESS then
    if resultJson.ip then
      self._ip = resultJson.ip
    else
      LogError("LoginDialog", "ip server return ip is nil")
    end
    if resultJson.port then
      self._port = resultJson.port
    else
      LogError("LoginDialog", "ip server return port is nil")
    end
    if self._ip and self._port then
      LogInfoFormat("LoginDialog", "ip: [%s], port: [%d] account:%s token:%s", self._ip, self._port, self._account, self._token)
      LuaNetManager.ConnectToServer(self._ip, self._port, self._account, self._token, self._plat)
    end
  end
end

function LoginDialog:OnPVBtnClicked()
  self:RemovePVEffect()
  DialogManager.CreateSingletonDialog("playpvdialog"):SetType(true)
end

function LoginDialog:TryShowPVEffect()
  if CS.UnityEngine.PlayerPrefs.GetInt("HavePlayPVEffect", 0) == 0 then
    if self._pvEffectHandler then
      self._pvEffect:ReleaseEffect(self._pvEffectHandler)
      self._pvEffectHandler = nil
    end
    self._pvEffectHandler = self._pvEffect:AddEffectAsync(EffectUtil.GetAssetBundleNameAndAssetName(1108))
  end
end

function LoginDialog:RemovePVEffect()
  CS.UnityEngine.PlayerPrefs.SetInt("HavePlayPVEffect", 1)
  if self._pvEffectHandler then
    self._pvEffect:ReleaseEffect(self._pvEffectHandler)
    self._pvEffectHandler = nil
  end
end

function LoginDialog:OnAgeTipsClicked()
  DialogManager.CreateSingletonDialog("login.agetipspopdialog"):Init()
end

return LoginDialog
