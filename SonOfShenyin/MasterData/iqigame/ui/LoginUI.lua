-- chunkname: @IQIGame\\UI\\LoginUI.lua

local LoginUI = Base:Extend("LoginUI", "IQIGame.Onigao.UI.LoginUI", {
	debugPassWorld = "1423",
	debugPassWorldTemp = "",
	ServerItems = {}
})
local TOGGLE_PANEL_UNAME_PWD = 1
local TOGGLE_PANEL_SELECTED_SERVER = 2
local TOGGLE_PANEL_SERVER_LIST = 3
local TOGGLE_PANEL_SDK = 4
local TOGGLE_PANEL_LOGINMAIN = 5
local json = require("Util.json")
local RegisterView = require("IQIGame.UI.Login.RegisterView")
local LoginServerItem = require("IQIGame.UI.Login.LoginServerItem")
local UserProtocolWindow = require("IQIGame.UI.Login.UserProtocolWindow")
local AccountManagerWindow = require("IQIGame.UI.Login.AccountManager")
local AgePromptView = require("IQIGame.UI.Login.AgePromptView")

function LoginUI:OnInit()
	self.IDTextComponent = self.IDText:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.PswTextComponent = self.PswText:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.GuestBtnComponent = self.GuestBtn:GetComponent("Button")
	self.LoginBtnComponent = self.LoginBtn:GetComponent("Button")
	self.EnterGameBtnComponent = self.EnterGameBtn:GetComponent("Button")
	self.ChangeServerBtnComponent = self.ChangeServerBtn:GetComponent("Button")
	self.ShowSDKLoginBtnComponent = self.ShowSDKLoginBtn:GetComponent("Button")
	self.AccountBtnComponent = self.AccountLoginBtn:GetComponent("Button")
	self.RegisterAccountBtnComponent = self.RegisterAccountBtn:GetComponent("Button")
	self.TouristLoginBtnComponent = self.TouristLoginBtn:GetComponent("Button")
	self.toggleGuideCtrl = self.toggleGuideCtrl:GetComponent("Toggle")
	self.btnDebug1 = self.goDebugBlock.transform:Find("Button_01"):GetComponent("Button")
	self.btnDebug2 = self.goDebugBlock.transform:Find("Button_02"):GetComponent("Button")
	self.btnDebug3 = self.goDebugBlock.transform:Find("Button_03"):GetComponent("Button")
	self.btnDebug4 = self.goDebugBlock.transform:Find("Button_04"):GetComponent("Button")
	self.btnDebug5 = self.goDebugBlock.transform:Find("Button_05"):GetComponent("Button")

	function self.onClickBtnDebug1Delegate()
		self:OnClickBtnDebug1()
	end

	function self.onClickBtnDebug2Delegate()
		self:OnClickBtnDebug2()
	end

	function self.onClickBtnDebug3Delegate()
		self:OnClickBtnDebug3()
	end

	function self.onClickBtnDebug4Delegate()
		self:OnClickBtnDebug4()
	end

	function self.onClickBtnDebug5Delegate()
		self:OnClickBtnDebug5()
	end

	function self.delegateBtnRegister()
		self:OnClickBtnRegister()
	end

	function self.delegateBtnNotice()
		self:OnClickBtnNotice()
	end

	function self.DelegateGetGuestInfo()
		self:GetGuestInfo()
	end

	function self.DelegateOnGetGuestInfo(uName, pwd)
		self:OnGetGuestInfo(uName, pwd)
	end

	function self.DelegateOnGetGuestInfoFailed()
		self:OnGetGuestInfoFailed()
	end

	function self.DelegateOnGetServerList(serverList, lastLoginServerID, uid)
		self:OnGetServerList(serverList, lastLoginServerID, uid)
	end

	function self.DelegateLogin()
		self:Login()
	end

	function self.DelegateOnLoadRole()
		self:OnLoadRole()
	end

	function self.DelegateOnEnterGame()
		self:OnEnterGame()
	end

	function self.DelegateShowServerList()
		self:ShowServerList()
	end

	function self.DelegateUpdateServerItem(cell)
		self:UpdateServerItem(cell)
	end

	function self.DelegateOnUIOpen(sender, args)
		self:OnUIOpen(sender, args)
	end

	function self.DelegateOnActiveAccountSuccess()
		self:OnActiveAccountSuccess()
	end

	function self.DelegateOnClickShowSDKLoginBtn()
		self:OnClickShowSDKLoginBtn()
	end

	function self.DelegateOnClickUserProtocolBtn()
		self:OnClickUserProtocolBtn()
	end

	function self.DelegateOnClickPrivacyPolicyBtn()
		self:OnClickPrivacyPolicyBtn()
	end

	function self.DelegateOnClickChildPrivacyBtn()
		self:OnClickChildPrivacyBtn()
	end

	function self.DelegateOnClickAccountBtn()
		self:OnCommonBtnClick(TOGGLE_PANEL_UNAME_PWD)
	end

	function self.DelegateOnClickRegisterBtn()
		self:OnClickBtnRegister()
	end

	function self.DelegateOnClickTouristBtn()
		return
	end

	function self.DelegateOnClickLogoutBtn()
		self:OnClickLogoutBtn()
	end

	function self.DelegateOnClickUpLogBtn()
		return
	end

	function self.DelegateReturnMainBtn()
		self:OnCommonBtnClick(TOGGLE_PANEL_LOGINMAIN)
	end

	function self.DelegateAccountManagerBtn()
		self.AccountManagerWindow:Show()
	end

	function self.DelegateChangAccount()
		self:ChangAccountCallBack()
	end

	function self.DelegateUserInfo(userName)
		self:SetUserInfo(userName)
	end

	function self.DelegateProtocolToggle(state)
		self:ToggleValueChange(state)
	end

	function self.DelegateAgePromptBtn()
		self:OpenAgePromptPanel()
	end

	function self.buttonGuideCtrlDelegate()
		self:OnButtonGuideCtrlClick()
	end

	function self.toggleGuideCtrlDelegate(ison)
		self:OnToggleGuideCtrlChange(ison)
	end

	function self.delegateOnClickRecordBtn()
		self:OnClickRecordBtn()
	end

	function self.delegateOnClickUserCenterBtn()
		self:OnClickUserCenterBtn()
	end

	self.togglePanels = {}
	self.togglePanels[TOGGLE_PANEL_UNAME_PWD] = self.InputPanel
	self.togglePanels[TOGGLE_PANEL_SELECTED_SERVER] = self.ServerPanel
	self.togglePanels[TOGGLE_PANEL_SERVER_LIST] = self.ServerListPanel
	self.togglePanels[TOGGLE_PANEL_SDK] = self.SdkPanel
	self.togglePanels[TOGGLE_PANEL_LOGINMAIN] = self.LoginMain
	self.AgePromptView = AgePromptView.New(self.AgePromptPanel)

	self.AgePromptView:Hide()

	self.CurrentServerStateIcons = {}

	for i = 1, 4 do
		self.CurrentServerStateIcons[i] = self.CurrentServerState.transform:Find("Image_State" .. i).gameObject
	end

	UGUIUtil.SetText(self.goEnterTxt, LoginUIApi:SetEnterTxt())
	UGUIUtil.SetText(self.goViewTitle2, LoginUIApi:SetViewTitle2())
	UGUIUtil.SetText(self.goViewTitle3, LoginUIApi:SetViewTitle3())
	UGUIUtil.SetText(self.ProtocolLabel1, LoginUIApi:GetProtocolLabel1())
	UGUIUtil.SetText(self.ProtocolLabel2, LoginUIApi:GetProtocolLabel2())
	UGUIUtil.SetText(self.stateTitle1, LoginUIApi:GetStateTitle(1))
	UGUIUtil.SetText(self.stateTitle2, LoginUIApi:GetStateTitle(2))
	UGUIUtil.SetText(self.stateTitle3, LoginUIApi:GetStateTitle(3))
	UGUIUtil.SetText(self.stateTitle4, LoginUIApi:GetStateTitle(4))
	UGUIUtil.SetTextInChildren(self.UserProtocolBtn, LoginUIApi:GetUserProtocolBtnText())
	UGUIUtil.SetTextInChildren(self.PrivacyPolicyBtn, LoginUIApi:GetPrivacyPolicyBtnText())
	UGUIUtil.SetTextInChildren(self.ChildPrivacyBtn, LoginUIApi:GetChildPrivacyBtnText())
	UGUIUtil.SetTextInChildren(self.PrivacyAgreeBtn, LoginUIApi:GetOtherBtnInfo(1))
	UGUIUtil.SetTextInChildren(self.UserAgreeBtn, LoginUIApi:GetOtherBtnInfo(2))
	UGUIUtil.SetTextInChildren(self.NoticeBtn, LoginUIApi:GetOtherBtnInfo(3))
	UGUIUtil.SetTextInChildren(self.AccountManagerBtn, LoginUIApi:GetOtherBtnInfo(4))
	UGUIUtil.SetTextInChildren(self.AccountLoginBtn, LoginUIApi:SetBtnLoginTxt())
	UGUIUtil.SetTextInChildren(self.RegisterAccountBtn, LoginUIApi:SetBtnRegisterTxt())
	UGUIUtil.SetTextInChildren(self.TouristLoginBtn, LoginUIApi:SetBtnGuestTxt())
	UGUIUtil.SetTextInChildren(self.UpBugLogBtn, LoginUIApi:GetUpBugBtnText())
	UGUIUtil.SetTextInChildren(self.Button_LogoutBtn, LoginUIApi:GetLogOutBtnText())
	UGUIUtil.SetText(self.goBtnLoginTxt, LoginUIApi:SetBtnLogin1Txt())

	local deviceInfodata = LuaCodeInterface.GetDeviceInfo()

	UGUIUtil.SetText(self.verisonText, "Ver:" .. deviceInfodata.version .. "_" .. deviceInfodata.assetVersion)

	self.LastLoginBtnController = LoginServerItem.New(self.LastLoginBtn, function(serverData)
		self:SelectServer(serverData)
	end)
	self.registerView = RegisterView.__New(self.Register, function()
		self:OnCommonBtnClick(TOGGLE_PANEL_LOGINMAIN)
	end)

	self.registerView:Hide()

	self.UserProtocolWindow = UserProtocolWindow.New(self.ProtocolWindow)

	self.UserProtocolWindow:Hide()

	self.AccountManagerWindow = AccountManagerWindow.New(self.AccountMangerPanel)

	self.AccountManagerWindow:Hide()
	self:InitGMToggle()
end

function LoginUI:GetPreloadAssetPaths()
	return nil
end

function LoginUI:GetOpenPreloadAssetPaths(userData)
	self.LoginBGCfg = CfgLoginBGTable[42000001]

	if self.LoginBGCfg ~= nil then
		return {
			UIGlobalApi.UIPath .. self.LoginBGCfg.PrefabUrl
		}
	end

	return nil
end

function LoginUI:OnOpen(userData)
	self.AccountUID = nil

	self:ChangAccountCallBack()
	self:ChangeBG()
	NetCommController.Clear()

	if LoginModule.FirstLogin then
		LoginModule.FirstLogin = false
	end

	GameEntry.MouseEffect:Enable()
	self:ResetDebugPassWorld()

	local agreeProtocol = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.AgreeProtocol)

	self.ProtocolAgreeToggle:GetComponent("Toggle").isOn = true
	PlayerModule.disableGuide = PlayerPrefsUtil.GetString("", "OpenGuidePrefs") == "true" or false

	local toggleIndex = self:GetInitToggleIndex()

	self:ToggleTo(toggleIndex)
	self.Button_LogoutBtn:SetActive(false)
	self.UpBugLogBtn:SetActive(false)
	self.userCenterBtn:SetActive(false)
	self:CreateUIDShowObj()

	local sceneID = 1
	local sceneListConfig = CfgSceneListTable[sceneID]

	if sceneListConfig ~= nil then
		local bgmCid = CfgSceneListTable[sceneID].BGM

		LuaUtility.PlayBGMWithID(bgmCid)
	end

	if SDKLoginModule.IsSDKMode() then
		SDKLoginModule.Init()
	end
end

function LoginUI:CreateUIDShowObj()
	PlayerModule.HideTestTitle = PlayerPrefsUtil.GetString("", "HideTestTitle") == "true"

	if GameObject.Find("UIDCanvas") ~= nil and PlayerModule.HideTestTitle == false then
		if GameObject.Find("UIDShowRoot") == nil then
			local uidObj = UnityEngine.Object.Instantiate(self.UIDShowPrefab)

			uidObj.name = self.UIDShowPrefab.name

			uidObj.transform:SetParent(GameObject.Find("UIDCanvas").transform, false)

			uidObj.transform.anchoredPosition3D = Vector3.New(0, 0, 0)

			uidObj:SetActive(true)
			UGUIUtil.SetText(GameObject.Find("TestTitle"), LoginUIApi:GetTestTips())
		end

		UGUIUtil.SetText(GameObject.Find("UIDText_New").gameObject, "")
	end
end

function LoginUI:OnClose(userData)
	self.registerView:Hide()
end

function LoginUI:OnPause()
	return
end

function LoginUI:OnResume()
	return
end

function LoginUI:OnCover()
	return
end

function LoginUI:OnReveal()
	return
end

function LoginUI:OnRefocus(userData)
	return
end

function LoginUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.registerView:OnUpdate()
end

function LoginUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoginUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoginUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoginUI:OnDestroy()
	self.registerView:OnDestroy()

	for instanceId, serverItem in pairs(self.ServerItems) do
		serverItem:Dispose()
	end

	self.UserProtocolWindow:Dispose()
	self.AccountManagerWindow:Dispose()
	self.AgePromptView:Dispose()
	LuaCodeInterface.ClearOutlet(self.GMToggleObj, self)
end

function LoginUI:OnAddListeners()
	self.GuestBtnComponent.onClick:AddListener(self.DelegateGetGuestInfo)
	self.LoginBtnComponent.onClick:AddListener(self.DelegateLogin)
	self.EnterGameBtnComponent.onClick:AddListener(self.DelegateOnEnterGame)
	self.ChangeServerBtnComponent.onClick:AddListener(self.DelegateShowServerList)
	self.ShowSDKLoginBtnComponent.onClick:AddListener(self.DelegateOnClickShowSDKLoginBtn)
	self.btnDebug1.onClick:AddListener(self.onClickBtnDebug1Delegate)
	self.btnDebug2.onClick:AddListener(self.onClickBtnDebug2Delegate)
	self.btnDebug3.onClick:AddListener(self.onClickBtnDebug3Delegate)
	self.btnDebug4.onClick:AddListener(self.onClickBtnDebug4Delegate)
	self.btnDebug5.onClick:AddListener(self.onClickBtnDebug5Delegate)
	self.BtnRegister:GetComponent("Button").onClick:AddListener(self.delegateBtnRegister)
	self.BtnNotice:GetComponent("Button").onClick:AddListener(self.delegateBtnNotice)
	self.UserProtocolBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUserProtocolBtn)
	self.PrivacyPolicyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrivacyPolicyBtn)
	self.ChildPrivacyBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChildPrivacyBtn)
	self.AccountBtnComponent.onClick:AddListener(self.DelegateOnClickAccountBtn)
	self.RegisterAccountBtnComponent.onClick:AddListener(self.DelegateOnClickRegisterBtn)
	self.UserAgreeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUserProtocolBtn)
	self.PrivacyAgreeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPrivacyPolicyBtn)
	self.NoticeBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnNotice)
	self.ReturnMainBtn:GetComponent("Button").onClick:AddListener(self.DelegateReturnMainBtn)
	self.AccountManagerBtn:GetComponent("Button").onClick:AddListener(self.DelegateAccountManagerBtn)
	self.ProtocolAgreeToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateProtocolToggle)
	self.Btn_16Plus:GetComponent("Button").onClick:AddListener(self.DelegateAgePromptBtn)
	self.Button_LogoutBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickLogoutBtn)
	self.UpBugLogBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickUpLogBtn)
	self.buttonGuideCtrl:GetComponent("Button").onClick:AddListener(self.buttonGuideCtrlDelegate)
	self.toggleGuideCtrl.onValueChanged:AddListener(self.toggleGuideCtrlDelegate)
	self.button_Record:GetComponent("Button").onClick:AddListener(self.delegateOnClickRecordBtn)
	self.userCenterBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickUserCenterBtn)
	self:AddGMToggleListener()
	EventDispatcher.AddEventListener(EventID.UpdateConnectToken, self.DelegateOnLoadRole)
	EventDispatcher.AddEventListener(EventID.GetServerList, self.DelegateOnGetServerList)
	EventDispatcher.AddEventListener(EventID.ActiveAccountSuccess, self.DelegateOnActiveAccountSuccess)
	EventDispatcher.AddEventListener(EventID.ChangAccount, self.DelegateChangAccount)
	EventDispatcher.AddEventListener(EventID.GetUserInfo, self.DelegateUserInfo)
end

function LoginUI:OnRemoveListeners()
	self.GuestBtnComponent.onClick:RemoveListener(self.DelegateGetGuestInfo)
	self.LoginBtnComponent.onClick:RemoveListener(self.DelegateLogin)
	self.EnterGameBtnComponent.onClick:RemoveListener(self.DelegateOnEnterGame)
	self.ChangeServerBtnComponent.onClick:RemoveListener(self.DelegateShowServerList)
	self.ShowSDKLoginBtnComponent.onClick:RemoveListener(self.DelegateOnClickShowSDKLoginBtn)
	self.btnDebug1.onClick:RemoveListener(self.onClickBtnDebug1Delegate)
	self.btnDebug2.onClick:RemoveListener(self.onClickBtnDebug2Delegate)
	self.btnDebug3.onClick:RemoveListener(self.onClickBtnDebug3Delegate)
	self.btnDebug4.onClick:RemoveListener(self.onClickBtnDebug4Delegate)
	self.btnDebug5.onClick:RemoveListener(self.onClickBtnDebug5Delegate)
	self.BtnRegister:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRegister)
	self.BtnNotice:GetComponent("Button").onClick:RemoveListener(self.delegateBtnNotice)
	self.UserProtocolBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUserProtocolBtn)
	self.PrivacyPolicyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrivacyPolicyBtn)
	self.ChildPrivacyBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChildPrivacyBtn)
	self.AccountBtnComponent.onClick:RemoveListener(self.DelegateOnClickAccountBtn)
	self.TouristLoginBtnComponent.onClick:RemoveListener(self.DelegateOnClickRegisterBtn)
	self.UserAgreeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUserProtocolBtn)
	self.PrivacyAgreeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPrivacyPolicyBtn)
	self.NoticeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnNotice)
	self.ReturnMainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateReturnMainBtn)
	self.AccountManagerBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAccountManagerBtn)
	self.ProtocolAgreeToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateProtocolToggle)
	self.Btn_16Plus:GetComponent("Button").onClick:RemoveListener(self.DelegateAgePromptBtn)
	self.Button_LogoutBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickLogoutBtn)
	self.UpBugLogBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickUpLogBtn)
	self.buttonGuideCtrl:GetComponent("Button").onClick:RemoveListener(self.buttonGuideCtrlDelegate)
	self.toggleGuideCtrl.onValueChanged:RemoveListener(self.toggleGuideCtrlDelegate)
	self.button_Record:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickRecordBtn)
	self.userCenterBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickUserCenterBtn)
	self:RemoveGMToggleListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateConnectToken, self.DelegateOnLoadRole)
	EventDispatcher.RemoveEventListener(EventID.GetServerList, self.DelegateOnGetServerList)
	EventDispatcher.RemoveEventListener(EventID.ActiveAccountSuccess, self.DelegateOnActiveAccountSuccess)
	EventDispatcher.RemoveEventListener(EventID.ChangAccount, self.DelegateChangAccount)
	EventDispatcher.RemoveEventListener(EventID.GetUserInfo, self.DelegateUserInfo)
end

function LoginUI:GetInitToggleIndex()
	return TOGGLE_PANEL_LOGINMAIN
end

function LoginUI:GetGuestInfo()
	EventDispatcher.AddEventListener(EventID.GetGuestInfoSuceed, self.DelegateOnGetGuestInfo)
	EventDispatcher.AddEventListener(EventID.GetGuestInfoFailed, self.DelegateOnGetGuestInfoFailed)
	LoginModule.GetGuestInfo()
end

function LoginUI:OnGetGuestInfo(uName, pwd)
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoSuceed, self.DelegateOnGetGuestInfo)
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoFailed, self.DelegateOnGetGuestInfoFailed)

	self.IDTextComponent.text = LoginUIApi:SetID(uName)
	self.PswTextComponent.text = LoginUIApi:SetPassword(pwd)
end

function LoginUI:OnGetGuestInfoFailed()
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoSuceed, self.DelegateOnGetGuestInfo)
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoFailed, self.DelegateOnGetGuestInfoFailed)
end

function LoginUI:Login()
	if SDKLoginModule.IsSDKMode() then
		SDKLoginModule.StartLogin()

		return
	end

	if self.IDTextComponent.text == "" or self.PswTextComponent.text == "" then
		NoticeModule.ShowNoticeNoCallback(21040012)

		return
	end

	LoginModule.Login(self.IDTextComponent.text, self.PswTextComponent.text)
end

function LoginUI:OnLoadRole()
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.DelegateOnUIOpen)
end

function LoginUI:OnUIOpen(sender, args)
	local cfgSceneListData = CfgSceneListTable[PlayerModule.InitSceneID]

	if args.UIName == cfgSceneListData.LoadingUI then
		GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, self.DelegateOnUIOpen)
		UIModule.Close(Constant.UIControllerName.LoginUI)
	end
end

function LoginUI:ToggleTo(panelIndex)
	for i = 1, #self.togglePanels do
		self.togglePanels[i]:SetActive(i == panelIndex)
	end

	self.Effects:SetActive(panelIndex ~= TOGGLE_PANEL_SERVER_LIST)
end

function LoginUI:OnGetServerList(serverList, lastLoginServerID, uid)
	self.AccountUID = uid

	local lastLoginServer, server, recommendServer

	for i = 1, #serverList do
		server = serverList[i]

		if server.serverId == lastLoginServerID then
			lastLoginServer = server
			self.LastLoginServerInfo = server

			break
		end

		if recommendServer == nil and server.isRmd == 1 then
			recommendServer = server
		end

		if recommendServer == nil and i == #serverList then
			recommendServer = server
		end
	end

	if lastLoginServer == nil then
		lastLoginServer = recommendServer
	end

	self:ToggleTo(TOGGLE_PANEL_SELECTED_SERVER)

	self.CurrentServerName:GetComponent("Text").text = LoginUIApi:SetServerName(lastLoginServer.serverName)

	for i = 1, #self.CurrentServerStateIcons do
		local icon = self.CurrentServerStateIcons[i]

		icon:SetActive(i == self:GetServerStateType(lastLoginServer.state))
	end

	self.SelectedServer = lastLoginServer
	LoginModule.SelectedServer = lastLoginServer
	self.ServerList = serverList

	self.registerView:Hide()
	PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.AgreeProtocol, "true")
end

function LoginUI:OnEnterGame()
	if not self.ProtocolAgreeToggle:GetComponent("Toggle").isOn then
		NoticeModule.ShowNoticeNoCallback(21056001)

		return
	end

	if LoginModule.AccountIsNotActive then
		UIModule.Open(Constant.UIControllerName.LoginActivationCodeUI, Constant.UILayer.Tooltip, {
			uid = self.AccountUID
		})
	else
		LoginModule.EnterGame(self.SelectedServer)
	end
end

function LoginUI:OnActiveAccountSuccess()
	LoginModule.EnterGame(self.SelectedServer)
end

function LoginUI:ShowServerList()
	if #self.ServerList > 1 then
		LuaCodeInterface.TryCloseChannel(NetworkChannelName.Game)
		self:OpenServerListPanel()
	end
end

function LoginUI:OpenServerListPanel()
	self:ToggleTo(TOGGLE_PANEL_SERVER_LIST)
	self.LastLoginBtnController:SetData(self.LastLoginServerInfo)

	local wrapContent = self.ServerListContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateServerItem

	wrapContent:Refresh(#self.ServerList)
end

function LoginUI:UpdateServerItem(cell)
	local itemGo = cell.gameObject
	local serverItem = self.ServerItems[itemGo:GetInstanceID()]

	if serverItem == nil then
		serverItem = LoginServerItem.New(itemGo, function(serverData)
			self:SelectServer(serverData)
		end)
		self.ServerItems[itemGo:GetInstanceID()] = serverItem
	end

	local serverData = self.ServerList[cell.index + 1]

	serverItem:SetData(serverData)
end

function LoginUI:GetServerStateType(state)
	return state + 1
end

function LoginUI:SelectServer(serverInfo)
	self:ToggleTo(TOGGLE_PANEL_SELECTED_SERVER)

	self.CurrentServerName:GetComponent("Text").text = LoginUIApi:SetServerName(serverInfo.serverName)

	for i = 1, #self.CurrentServerStateIcons do
		local icon = self.CurrentServerStateIcons[i]

		icon:SetActive(i == self:GetServerStateType(serverInfo.state))
	end

	self.SelectedServer = serverInfo
	LoginModule.SelectedServer = serverInfo

	SDKLoginModule.SelectServer()
end

function LoginUI:ChangeBG()
	if self.LoginBGCfg ~= nil then
		local transform = self.BackGround.transform

		for i = 0, transform.childCount - 1 do
			local obj = transform:GetChild(0).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local iconPath = UIGlobalApi.UIPath .. self.LoginBGCfg.PrefabUrl
		local asset = self.UIController:GetPreloadedAsset(iconPath)
		local go = UnityEngine.Object.Instantiate(asset)

		go.transform:SetParent(transform, false)
	end
end

function LoginUI:OnClickBtnRegister()
	if SDKLoginModule.IsSDKMode() then
		SDKLoginModule.StartLogin()

		return
	end

	self.registerView:Show()

	local toggleIndex = self:GetInitToggleIndex()

	self.togglePanels[toggleIndex]:SetActive(false)
end

function LoginUI:OnClickBtnNotice()
	UIModule.Open(Constant.UIControllerName.NoticeUI, Constant.UILayer.UI, {
		1
	})
end

function LoginUI:OnClickShowSDKLoginBtn()
	return
end

function LoginUI:ResetDebugPassWorld()
	self.debugPassWorldTemp = ""
end

function LoginUI:OnClickBtnDebug1()
	self.debugPassWorldTemp = self.debugPassWorldTemp .. "1"
end

function LoginUI:OnClickBtnDebug2()
	self.debugPassWorldTemp = self.debugPassWorldTemp .. "2"
end

function LoginUI:OnClickBtnDebug3()
	self.debugPassWorldTemp = self.debugPassWorldTemp .. "3"
end

function LoginUI:OnClickBtnDebug4()
	self.debugPassWorldTemp = self.debugPassWorldTemp .. "4"
end

function LoginUI:OnClickBtnDebug5()
	if self.debugPassWorldTemp == self.debugPassWorld then
		UIModule.Open(Constant.UIControllerName.GmPanelListUI, Constant.UILayer.UI)
	end

	self:ResetDebugPassWorld()
end

function LoginUI:OnClickUserProtocolBtn()
	self.UserProtocolWindow:Show(LoginUIApi:GetUserProtocolUrl(), 1)
end

function LoginUI:OnClickPrivacyPolicyBtn()
	self.UserProtocolWindow:Show(LoginUIApi:GetPrivacyPolicyUrl(), 2)
end

function LoginUI:OnClickChildPrivacyBtn()
	self.UserProtocolWindow:Show(LoginUIApi:GetChildPrivacyUrl(), 3)
end

function LoginUI:OnClickLogoutBtn()
	LoginModule.Logout(SceneTransferModule.ReturnLogin)
end

function LoginUI:OnCommonBtnClick(index)
	if SDKLoginModule.IsSDKMode() then
		SDKLoginModule.StartLogin()

		return
	end

	self:ToggleTo(index)
end

function LoginUI:PanelAlphaTween(index)
	Timer.New(function()
		self:ToggleTo(index)
		LuaCodeInterface.TweenAlpha(self.togglePanels[index], 0.2, 0, 1, nil)
	end, 1):Start()
end

function LoginUI:ChangAccountCallBack()
	local uName = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserName)

	if uName ~= nil and uName ~= "" then
		self.IDTextComponent.text = LoginUIApi:SetID(uName)
		self.PswTextComponent.text = LoginUIApi:SetPassword(PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Password))
	else
		self.IDTextComponent.text = ""
		self.PswTextComponent.text = ""
	end
end

function LoginUI:SetUserInfo(userName)
	UGUIUtil.SetText(self.UserInfoLabel, userName)
	self.userCenterBtn:SetActive(SDKLoginModule.IsSDKMode() and SDKLoginModule.GetIsOfficialChannel())

	local isOpenAgePrompt = PlayerPrefsUtil.GetString("", "IsFirstOpenAgePrompt")

	if isOpenAgePrompt ~= "true" then
		-- block empty
	end
end

function LoginUI:ToggleValueChange(state)
	return
end

function LoginUI:OpenAgePromptPanel()
	PlayerPrefsUtil.SetString("", "IsFirstOpenAgePrompt", "true")
	self.AgePromptView:Show()
end

function LoginUI:OnClickRecordBtn()
	Application.OpenURL("https://beian.miit.gov.cn/#/home")
end

function LoginUI:OnClickUserCenterBtn()
	SDKLoginModule.OpenUserCenter()
end

function LoginUI:OnButtonGuideCtrlClick()
	local boolstr = PlayerPrefsUtil.GetString("", "OpenGuidePrefs")
	local guideIsopen = false

	guideIsopen = boolstr == "true" and true or false
	self.toggleGuideCtrl.isOn = guideIsopen
	PlayerModule.disableGuide = guideIsopen

	LuaUtility.SetGameObjectShow(self.toggleGuideCtrl.gameObject, true)
end

function LoginUI:OnToggleGuideCtrlChange(ison)
	PlayerModule.disableGuide = ison

	PlayerPrefsUtil.SetString("", "OpenGuidePrefs", tostring(ison))
	PlayerPrefsUtil.Save()
end

function LoginUI:InitGMToggle()
	LuaCodeInterface.BindOutlet(self.GMToggleObj, self)
	self:InitGMClickDetection()

	self.Toggle1_Button = self.Toggle1:GetComponent("Button")
	self.Toggle2_Button = self.Toggle2:GetComponent("Button")
	self.Toggle3_Button = self.Toggle3:GetComponent("Button")
	self.Toggle4_Button = self.Toggle4:GetComponent("Button")
	self.Toggle5_Button = self.Toggle5:GetComponent("Button")
	self.Logo_Button = self.Logo:GetComponent("Button")
	self.GMToggle = {
		2,
		1,
		3,
		4
	}
	self.GMList = {}
end

function LoginUI:GMToggle_OnClick_1()
	self.GMList[#self.GMList + 1] = 1

	self:GMToggleDetection()
end

function LoginUI:GMToggle_OnClick_2()
	self.GMList[#self.GMList + 1] = 2

	self:GMToggleDetection()
end

function LoginUI:GMToggle_OnClick_3()
	self.GMList[#self.GMList + 1] = 3

	self:GMToggleDetection()
end

function LoginUI:GMToggle_OnClick_4()
	self.GMList[#self.GMList + 1] = 4

	self:GMToggleDetection()
end

function LoginUI:GMToggle_OnClick_5()
	self.GMList = {}
end

function LoginUI:Logo_GM_OnClick()
	self:GMToggleDetection()
end

function LoginUI:GMToggleDetection()
	local data = ServerParamData.New()

	data.type = "GM_LOGIN_SWITCH"

	local jsonStr = LoginModule.CreateLoginParam(data)

	url = LoginModule.GetRequestUrl(Constant.LoginConst.ServerParamUrl)

	HttpModule.RequestPost(url, jsonStr, function(serverResponse)
		local data = LoginModule.HttpDecrypt(serverResponse)
		local response = json.decode(data)

		log("服务器参数 = " .. data)

		if response.code ~= 0 then
			warning("Send ServerParam error : " .. getErrorMsg(response.code))
		else
			local channels = string.split(string.gsub(string.lower(response.data.param), ":", ""), ",")
			local macStr = string.lower(LuaCodeInterface.GetDeviceInfo().mac)

			if response.data.param == "ALL" or table.indexOf(channels, macStr) ~= -1 then
				UIModule.Open(Constant.UIControllerName.GMManagerPanelUI, Constant.UILayer.UI)
			end
		end
	end, function(data)
		return
	end)
end

function LoginUI:InitGMClickDetection()
	function self.Delegation_GMToggle_1()
		self:GMToggle_OnClick_1()
	end

	function self.Delegation_GMToggle_2()
		self:GMToggle_OnClick_2()
	end

	function self.Delegation_GMToggle_3()
		self:GMToggle_OnClick_3()
	end

	function self.Delegation_GMToggle_4()
		self:GMToggle_OnClick_4()
	end

	function self.Delegation_GMToggle_5()
		self:GMToggle_OnClick_5()
	end

	function self.Delegation_Logo_GM()
		self:Logo_GM_OnClick()
	end
end

function LoginUI:AddGMToggleListener()
	self.Toggle1_Button.onClick:AddListener(self.Delegation_GMToggle_1)
	self.Toggle2_Button.onClick:AddListener(self.Delegation_GMToggle_2)
	self.Toggle3_Button.onClick:AddListener(self.Delegation_GMToggle_3)
	self.Toggle4_Button.onClick:AddListener(self.Delegation_GMToggle_4)
	self.Toggle5_Button.onClick:AddListener(self.Delegation_GMToggle_5)
	self.Logo_Button.onClick:AddListener(self.Delegation_Logo_GM)
end

function LoginUI:RemoveGMToggleListener()
	self.Toggle1_Button.onClick:RemoveListener(self.Delegation_GMToggle_1)
	self.Toggle2_Button.onClick:RemoveListener(self.Delegation_GMToggle_2)
	self.Toggle3_Button.onClick:RemoveListener(self.Delegation_GMToggle_3)
	self.Toggle4_Button.onClick:RemoveListener(self.Delegation_GMToggle_4)
	self.Toggle5_Button.onClick:RemoveListener(self.Delegation_GMToggle_5)
	self.Logo_Button.onClick:RemoveListener(self.Delegation_Logo_GM)
end

return LoginUI
