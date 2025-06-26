-- chunkname: @IQIGame\\UI\\LoginUI.lua

local LoginUI = {
	debugPassWorld = "1423",
	debugPassWorldTemp = "",
	ServerItems = {}
}

LoginUI = Base:Extend("LoginUI", "IQIGame.Onigao.UI.LoginUI", LoginUI)

local TOGGLE_PANEL_UNAME_PWD = 1
local TOGGLE_PANEL_SELECTED_SERVER = 2
local TOGGLE_PANEL_SERVER_LIST = 3
local TOGGLE_PANEL_SDK = 4
local RegisterView = require("IQIGame.UI.Login.RegisterView")
local LoginServerItem = require("IQIGame.UI.Login.LoginServerItem")

function LoginUI:OnInit()
	self.IDTextComponent = self.IDText:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.PswTextComponent = self.PswText:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.GuestBtnComponent = self.GuestBtn:GetComponent("Button")
	self.LoginBtnComponent = self.LoginBtn:GetComponent("Button")
	self.EnterGameBtnComponent = self.EnterGameBtn:GetComponent("Button")
	self.ChangeServerBtnComponent = self.ChangeServerBtn:GetComponent("Button")
	self.ShowSDKLoginBtnComponent = self.ShowSDKLoginBtn:GetComponent("Button")
	self.BtnChangeAccountComponent = self.BtnChangeAccount:GetComponent("Button")
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

	function self.DelegateOnGetServerList(serverList, lastLoginServerID, uid, checkOtherAccount)
		self:OnGetServerList(serverList, lastLoginServerID, uid, checkOtherAccount)
	end

	function self.DelegateLogin()
		self:Login()
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

	function self.DelegateOnActiveAccountSuccess()
		self:OnActiveAccountSuccess()
	end

	function self.DelegateOnClickShowSDKLoginBtn()
		self:OnClickShowSDKLoginBtn()
	end

	function self.DelegateOnClickChangeAccount()
		self:OnClickChangeAccount()
	end

	function self.DelegateOnClickEntertainmentRatingBtn()
		self:OnClickEntertainmentRatingBtn()
	end

	function self.DelegateOnClickBtnCustomerService()
		self:OnClickBtnCustomerService()
	end

	function self.DelegateOnClickRepairBtn()
		self:OnClickRepairBtn()
	end

	function self.DelegateBtn4399()
		self:OnBtn4399()
	end

	function self.DelegateBtnAccountTransfer()
		self:OnBtnAccountTransfer()
	end

	self.registerView = RegisterView.__New(self.Register, function()
		self.InputPanel:SetActive(true)
	end)

	self.registerView:Hide()

	self.togglePanels = {}
	self.togglePanels[TOGGLE_PANEL_UNAME_PWD] = self.InputPanel
	self.togglePanels[TOGGLE_PANEL_SELECTED_SERVER] = self.ServerPanel
	self.togglePanels[TOGGLE_PANEL_SERVER_LIST] = self.ServerListPanel
	self.togglePanels[TOGGLE_PANEL_SDK] = self.SdkPanel
	self.CurrentServerStateIcons = {}

	for i = 1, 4 do
		self.CurrentServerStateIcons[i] = self.CurrentServerState.transform:Find("Image_State" .. i).gameObject
	end

	UGUIUtil.SetText(self.goBtnGuestTxt, LoginUIApi:GetString("goBtnGuestTxt"))
	UGUIUtil.SetText(self.goBtnLoginTxt, LoginUIApi:GetString("goBtnLoginTxt"))
	UGUIUtil.SetText(self.goEnterTxt, LoginUIApi:GetString("goEnterTxt"))
	UGUIUtil.SetText(self.goViewTitle2, LoginUIApi:GetString("goViewTitle2"))
	UGUIUtil.SetText(self.goViewTitle3, LoginUIApi:GetString("goViewTitle3"))
	UGUIUtil.SetText(self.goBtnRegisterTxt, LoginUIApi:GetString("goBtnRegisterTxt"))
	UGUIUtil.SetTextInChildren(self.BtnCustomerService, LoginUIApi:GetString("BtnCustomerServiceTxt"))

	self.IDTextComponent.placeholder.text = LoginUIApi:GetString("IDInputPlaceholder")
	self.PswTextComponent.placeholder.text = LoginUIApi:GetString("PswInputPlaceholder")

	local data = LuaCodeInterface.GetDeviceInfo()
	local version = data.version
	local assetVersion = data.assetVersion

	UGUIUtil.SetText(self.VersionText, LoginUIApi:GetString("VersionText", version, assetVersion))

	self.LastLoginBtnController = LoginServerItem.New(self.LastLoginBtn, function(serverData)
		self:SelectServer(serverData)
	end)
end

function LoginUI:GetPreloadAssetPaths()
	return nil
end

function LoginUI:GetOpenPreloadAssetPaths(userData)
	local uName = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserName)
	local loginBG = PlayerPrefsUtil.GetString(uName, Constant.PlayerPrefsConst.UserLoginBG)

	if loginBG == "" or loginBG == nil then
		loginBG = SettingModule.currentBG

		PlayerPrefsUtil.SetString(uName, Constant.PlayerPrefsConst.UserLoginBG, loginBG)
	end

	self.LoginBGCfg = CfgLoginBGTable[tonumber(loginBG)]

	if self.LoginBGCfg ~= nil then
		return {
			UIGlobalApi.UIPath .. self.LoginBGCfg.PrefabUrl
		}
	end

	return nil
end

function LoginUI:OnOpen(userData)
	GmListModule.Initialize()

	local toggleIndex = self:GetInitToggleIndex()

	self:ToggleTo(toggleIndex)

	local uName = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserName)

	if uName ~= nil and uName ~= "" then
		self.IDTextComponent.text = LoginUIApi:GetString("IDText", uName)
		self.PswTextComponent.text = LoginUIApi:GetString("PswText", PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Password))
	end

	self:ChangeBG()
	self.togglePanels[toggleIndex]:SetActive(false)
	Timer.New(function()
		self.togglePanels[toggleIndex]:SetActive(true)
		LuaCodeInterface.TweenAlpha(self.togglePanels[toggleIndex], 1, 0, 1, nil)
	end, 1):Start()
	NetCommController.Clear()

	if CfgDiscreteDataTable[6520061].Data[1] == 1 and LuaCodeInterface.GetOS() == "IOS" then
		self.BtnNotice:SetActive(false)
	end

	if LuaCodeInterface.GetOS() == "IOS" then
		if LoginModule.isShowWebNoticeByIOS and CfgDiscreteDataTable[6520061].Data[1] == 0 then
			LoginModule.GetNotice(false)
		else
			SDKLoginModule.StartLogin()
		end
	else
		LoginModule.GetNotice(false)
	end

	LoginModule.isShowWebNoticeByIOS = false

	GameEntry.MouseEffect:Enable()
	self:ResetDebugPassWorld()
	self.BtnChangeAccount:SetActive(false)
	self.BtnCustomerService:SetActive(SDKLoginModule.isShowAccountHelp())

	local isShow = SDKLoginModule.IsHeroChannel() and LoginModule.LoginResponse ~= nil

	self.BtnAccountTransfer:SetActive(isShow)
end

function LoginUI:OnClose(userData)
	self.registerView:Hide()
	self:Clear()
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
	if self.registerView ~= nil then
		self.registerView:OnDestroy()
	end

	for instanceId, serverItem in pairs(self.ServerItems) do
		serverItem:Dispose()
	end
end

function LoginUI:OnAddListeners()
	self.GuestBtnComponent.onClick:AddListener(self.DelegateGetGuestInfo)
	self.LoginBtnComponent.onClick:AddListener(self.DelegateLogin)
	self.EnterGameBtnComponent.onClick:AddListener(self.DelegateOnEnterGame)
	self.ChangeServerBtnComponent.onClick:AddListener(self.DelegateShowServerList)
	self.ShowSDKLoginBtnComponent.onClick:AddListener(self.DelegateOnClickShowSDKLoginBtn)
	self.BtnChangeAccountComponent.onClick:AddListener(self.DelegateOnClickChangeAccount)
	self.btnDebug1.onClick:AddListener(self.onClickBtnDebug1Delegate)
	self.btnDebug2.onClick:AddListener(self.onClickBtnDebug2Delegate)
	self.btnDebug3.onClick:AddListener(self.onClickBtnDebug3Delegate)
	self.btnDebug4.onClick:AddListener(self.onClickBtnDebug4Delegate)
	self.btnDebug5.onClick:AddListener(self.onClickBtnDebug5Delegate)
	self.BtnRegister:GetComponent("Button").onClick:AddListener(self.delegateBtnRegister)
	self.BtnNotice:GetComponent("Button").onClick:AddListener(self.delegateBtnNotice)
	self.EntertainmentRatingBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEntertainmentRatingBtn)
	self.BtnCustomerService:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnCustomerService)
	self.RepairBtn:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickRepairBtn)
	self.Btn4399:GetComponent("Button").onClick:AddListener(self.DelegateBtn4399)
	self.BtnAccountTransfer:GetComponent("Button").onClick:AddListener(self.DelegateBtnAccountTransfer)
	EventDispatcher.AddEventListener(EventID.GetServerList, self.DelegateOnGetServerList)
	EventDispatcher.AddEventListener(EventID.ActiveAccountSuccess, self.DelegateOnActiveAccountSuccess)
end

function LoginUI:OnRemoveListeners()
	self.GuestBtnComponent.onClick:RemoveListener(self.DelegateGetGuestInfo)
	self.LoginBtnComponent.onClick:RemoveListener(self.DelegateLogin)
	self.EnterGameBtnComponent.onClick:RemoveListener(self.DelegateOnEnterGame)
	self.ChangeServerBtnComponent.onClick:RemoveListener(self.DelegateShowServerList)
	self.ShowSDKLoginBtnComponent.onClick:RemoveListener(self.DelegateOnClickShowSDKLoginBtn)
	self.BtnChangeAccountComponent.onClick:RemoveListener(self.DelegateOnClickChangeAccount)
	self.btnDebug1.onClick:RemoveListener(self.onClickBtnDebug1Delegate)
	self.btnDebug2.onClick:RemoveListener(self.onClickBtnDebug2Delegate)
	self.btnDebug3.onClick:RemoveListener(self.onClickBtnDebug3Delegate)
	self.btnDebug4.onClick:RemoveListener(self.onClickBtnDebug4Delegate)
	self.btnDebug5.onClick:RemoveListener(self.onClickBtnDebug5Delegate)
	self.BtnRegister:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRegister)
	self.BtnNotice:GetComponent("Button").onClick:RemoveListener(self.delegateBtnNotice)
	self.EntertainmentRatingBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEntertainmentRatingBtn)
	self.BtnCustomerService:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnCustomerService)
	self.RepairBtn:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickRepairBtn)
	self.Btn4399:GetComponent("Button").onClick:RemoveListener(self.DelegateBtn4399)
	self.BtnAccountTransfer:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAccountTransfer)
	EventDispatcher.RemoveEventListener(EventID.GetServerList, self.DelegateOnGetServerList)
	EventDispatcher.RemoveEventListener(EventID.ActiveAccountSuccess, self.DelegateOnActiveAccountSuccess)
end

function LoginUI:GetInitToggleIndex()
	if SDKLoginModule.IsSDKMode() then
		return TOGGLE_PANEL_SDK
	end

	return TOGGLE_PANEL_UNAME_PWD
end

function LoginUI:GetGuestInfo()
	EventDispatcher.AddEventListener(EventID.GetGuestInfoSuceed, self.DelegateOnGetGuestInfo)
	EventDispatcher.AddEventListener(EventID.GetGuestInfoFailed, self.DelegateOnGetGuestInfoFailed)
	LoginModule.GetGuestInfo()
end

function LoginUI:OnGetGuestInfo(uName, pwd)
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoSuceed, self.DelegateOnGetGuestInfo)
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoFailed, self.DelegateOnGetGuestInfoFailed)

	self.IDTextComponent.text = LoginUIApi:GetString("IDText", uName)
	self.PswTextComponent.text = LoginUIApi:GetString("PswText", pwd)
end

function LoginUI:OnGetGuestInfoFailed()
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoSuceed, self.DelegateOnGetGuestInfo)
	EventDispatcher.RemoveEventListener(EventID.GetGuestInfoFailed, self.DelegateOnGetGuestInfoFailed)
end

function LoginUI:Login()
	if self.IDTextComponent.text == "" or self.PswTextComponent.text == "" then
		NoticeModule.ShowNoticeNoCallback(21040012)

		return
	end

	LoginModule.Login(string.trim(self.IDTextComponent.text), string.trim(self.PswTextComponent.text))
end

function LoginUI:ToggleTo(panelIndex)
	for i = 1, #self.togglePanels do
		self.togglePanels[i]:SetActive(i == panelIndex)
	end

	self.Effects:SetActive(panelIndex ~= TOGGLE_PANEL_SERVER_LIST)
end

function LoginUI:OnGetServerList(serverList, lastLoginServerID, uid, checkOtherAccount)
	self.LastLoginServerInfo = nil
	self.AccountUID = uid

	local server

	for i = 1, #serverList do
		server = serverList[i]

		if server.serverId == lastLoginServerID then
			self.LastLoginServerInfo = server

			break
		end
	end

	if self.LastLoginServerInfo == nil then
		for i = 1, #serverList do
			server = serverList[i]

			if server.isRmd == 1 then
				self.LastLoginServerInfo = server

				break
			end
		end

		if self.LastLoginServerInfo == nil then
			self.LastLoginServerInfo = serverList[1]
		end
	end

	self:ToggleTo(TOGGLE_PANEL_SELECTED_SERVER)

	self.CurrentServerName:GetComponent("Text").text = LoginUIApi:GetString("CurrentServerName", self.LastLoginServerInfo.serverName)

	for i = 1, #self.CurrentServerStateIcons do
		local icon = self.CurrentServerStateIcons[i]

		icon:SetActive(i == self:GetServerStateType(self.LastLoginServerInfo.state))
	end

	self.SelectedServer = self.LastLoginServerInfo
	self.ServerList = serverList

	self.registerView:Hide()

	if checkOtherAccount then
		self.BtnChangeAccount:SetActive(true)

		local changeAccountPlatform = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.ChangeAccountPlatform, 0)
		local isIos = LuaCodeInterface.GetOS() == "IOS"

		if changeAccountPlatform == 1 and isIos or changeAccountPlatform == 0 and not isIos then
			self.BtnChangeAccount.transform:Find("Image_ios").gameObject:SetActive(false)
			self.BtnChangeAccount.transform:Find("Image_android").gameObject:SetActive(true)
		else
			self.BtnChangeAccount.transform:Find("Image_ios").gameObject:SetActive(true)
			self.BtnChangeAccount.transform:Find("Image_android").gameObject:SetActive(false)
		end
	end

	local isShow = SDKLoginModule.IsHeroChannel() and LoginModule.LoginResponse ~= nil

	self.BtnAccountTransfer:SetActive(isShow)

	if SDKLoginModule.IsHeroChannel() and (LoginModule.LoginResponse.data.phone == nil or LoginModule.LoginResponse.data.phone == "") then
		UIModule.Open(Constant.UIControllerName.AccountTransferUI, Constant.UILayer.UI)
	end
end

function LoginUI:OnEnterGame()
	if LoginModule.AccountIsNotActive then
		UIModule.Open(Constant.UIControllerName.LoginActivationCodeUI, Constant.UILayer.Tooltip, {
			uid = self.AccountUID
		})
	elseif self.SelectedServer.state == 0 then
		NoticeModule.ShowNotice(21045029, function()
			LoginModule.EnterGame(self.SelectedServer)
		end)
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

	self.CurrentServerName:GetComponent("Text").text = LoginUIApi:GetString("CurrentServerName", serverInfo.serverName)

	for i = 1, #self.CurrentServerStateIcons do
		local icon = self.CurrentServerStateIcons[i]

		icon:SetActive(i == self:GetServerStateType(serverInfo.state))
	end

	self.SelectedServer = serverInfo
end

function LoginUI:ChangeBG()
	if self.LoginBGCfg ~= nil then
		local transform = self.BackGround.transform

		for i = 0, transform.childCount - 1 do
			local obj = transform:GetChild(0).gameObject

			UnityEngine.GameObject.DestroyImmediate(obj)
		end

		local iconPath = UIGlobalApi.UIPath .. self.LoginBGCfg.PrefabUrl
		local asset = self.UIController:GetPreloadedAsset(iconPath)
		local go = UnityEngine.Object.Instantiate(asset)

		go.transform:SetParent(transform, false)
	end
end

function LoginUI:OnClickBtnRegister()
	self.registerView:Show()

	local toggleIndex = self:GetInitToggleIndex()

	self.togglePanels[toggleIndex]:SetActive(false)
end

function LoginUI:OnClickBtnNotice()
	LoginModule.GetNotice(true)
end

function LoginUI:OnClickBtnCustomerService()
	SDKLoginModule.accountHelp()
end

function LoginUI:OnClickShowSDKLoginBtn()
	if SDKLoginModule.SDKUser == nil then
		SDKLoginModule.StartLogin()
	end
end

function LoginUI:OnClickChangeAccount()
	local changeAccountPlatform = PlayerPrefsUtil.GetInt("", Constant.PlayerPrefsConst.ChangeAccountPlatform, 0)
	local isIos = LuaCodeInterface.GetOS() == "IOS"

	if changeAccountPlatform == 1 and isIos or changeAccountPlatform == 0 and not isIos then
		NoticeModule.ShowNotice(21045067)
	else
		NoticeModule.ShowNotice(21045066)
	end

	if changeAccountPlatform == 1 then
		PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.ChangeAccountPlatform, 0)
	else
		PlayerPrefsUtil.SetInt("", Constant.PlayerPrefsConst.ChangeAccountPlatform, 1)
	end

	SDKLoginModule.Login(SDKLoginModule.SDKUser)
	self.BtnChangeAccount:SetActive(false)
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

function LoginUI:OnClickEntertainmentRatingBtn()
	UIModule.Open(Constant.UIControllerName.LoginEntertainmentRatingUI, Constant.UILayer.UI)
end

function LoginUI:OnClickRepairBtn()
	NoticeModule.ShowNotice(21045071, function()
		UIModule.Open(Constant.UIControllerName.ResourceDownloadUI, Constant.UILayer.AboveAll, {
			type = 1
		})
		ResourceUpdateChecker.CheckResourcesForRepair(function(updateCount, updateTotalLength)
			if updateTotalLength == 0 then
				UIModule.Close(Constant.UIControllerName.ResourceDownloadUI)
				NoticeModule.ShowNotice(21045072)
			else
				local sizeStr = ResourceUpdateChecker.GetSizeStr(updateTotalLength)

				UIModule.Close(Constant.UIControllerName.ResourceDownloadUI)
				NoticeModule.ShowNotice(21045073, self.UpdateRepairRes, nil, nil, sizeStr)
			end
		end)
	end)
end

function LoginUI:UpdateRepairRes()
	UIModule.Open(Constant.UIControllerName.ResourceDownloadUI, Constant.UILayer.AboveAll, {
		type = 0
	})
	ResourceUpdateChecker.UpdateResourcesForRepair(function(tag, isRepair, isAllComplete)
		if isAllComplete then
			UIModule.Close(Constant.UIControllerName.ResourceDownloadUI)
		end
	end)
end

function LoginUI:Clear()
	self.ServerList = nil
	self.SelectedServer = nil
	self.LastLoginServerInfo = nil
	self.AccountUID = nil
end

function LoginUI:OnBtn4399()
	UnityEngine.Application.OpenURL("https://beian.miit.gov.cn/#/Integrated/recordQuery")
end

function LoginUI:OnBtnAccountTransfer()
	UIModule.Open(Constant.UIControllerName.AccountTransferUI, Constant.UILayer.UI)
end

return LoginUI
