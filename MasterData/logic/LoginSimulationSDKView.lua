-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginSimulationSDKView.lua

module("logic.extensions.login.view.LoginSimulationSDKView", package.seeall)

local LoginSimulationSDKView = class("LoginSimulationSDKView", ViewComponent)
local TEMP_SERVER_ARR = {
	[2] = {
		httpLoginUrl = "https://service-gf-pjaqm.100bt.com/",
		hotUpdateInfoUrl = "https://cc2dhotupdate.100bt.com",
		noticeUrl = ""
	},
	[3] = {
		httpLoginUrl = "http://10.17.1.111:8080/",
		hotUpdateInfoUrl = "cc2dhotupdate.tech.test",
		noticeUrl = ""
	},
	[4] = {
		httpLoginUrl = "http://10.20.1.32:8080/",
		hotUpdateInfoUrl = "cc2dhotupdate.tech.test",
		noticeUrl = ""
	},
	[5] = {
		httpLoginUrl = "http://10.20.1.33:8080/",
		hotUpdateInfoUrl = "cc2dhotupdate.tech.test",
		noticeUrl = ""
	}
}

LoginSimulationSDKView.IPConfigs = {
	{
		ip = "",
		name = "空IP"
	},
	{
		ip = "10.18.15.53",
		name = "东东"
	},
	{
		ip = "10.18.15.52",
		name = "艺骏"
	},
	{
		ip = "10.18.15.51",
		name = "文俊"
	}
}

function LoginSimulationSDKView:ctor()
	LoginSimulationSDKView.super.ctor(self)

	self._accoutPerf = nil
end

function LoginSimulationSDKView:buildUI()
	self._btnLogin = self:getBtn("btnLogin")
	self._btnLogin2 = self:getBtn("btnLogin2")
	self._inpAccount = self:getInput("inpAccount")
	self._inpIp = self:getInput("imgBak/inpIp")
	self._inpIpCCC = self:getGo("imgBak/inpIp"):GetComponent(ComponentType.InputField)
	self._inpVerif = self:getInput("imgVerif/inpVerif")
	self._txtAccountTip = goutil.findChildTextComponent(self.mainGO, "txtAccountTip")
	self._txtBtnLogin = goutil.findChildTextComponent(self.mainGO, "btnLogin/Text")
	self._txtAccountTip.text = "账号："
	self.cell = self:getGo("cell")
	self.container = self:getGo("container")
	self.tgBtn = goutil.findChild(self.mainGO, "tgBtn"):GetComponent("Toggle")
	self._serTgBtn_2 = self:getToggle("togGroup/serTgBtn_2")
	self._serTgBtn_3 = self:getToggle("togGroup/serTgBtn_3")
	self._serTgMap = {}

	for k, v in pairs(TEMP_SERVER_ARR) do
		local tga = self:getToggle("togGroup/serTgBtn_" .. k)

		self._serTgMap[k] = tga
		tga.toggle.isOn = false

		if CSGameUtil.GetGameConfigUrlType() == k then
			tga.toggle.isOn = true
		end
	end

	self._itemScrGo = goutil.findChild(self.mainGO, "Scroll")

	local itemScrView = goutil.findChild(self.mainGO, "Scroll/ScrollView")
	local itemScrCell = self:getGo("Scroll/Cell")

	self._itemScrollList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._itemScrCustomInput = UICustomInput.Get(self._itemScrGo)
	self._searchText = self:getInput("Right/gm/bg1/Input/Search/Input")
	self._itemSearchInputGo = self:getGo("imgBak/inpIp")
end

function LoginSimulationSDKView:bindEvents()
	self._btnLogin:AddClickListener(self._onClickLoginBtn, self)
	self._btnLogin2:AddClickListener(self._onClickLoginBtn2, self)

	for k, v in pairs(self._serTgMap) do
		v:AddOnValueChanged(self._onToggleChange, self)
	end

	self._itemScrCustomInput:AddListener(self._onItemScrCustomInputCallback, self)

	self._itemSearchInputPointerClickHandler = PointerClickHandler.Get(self._itemSearchInputGo):AddLuaHandler(function(_go, eventData)
		self:_onItemSearchInputPointerClickHandler(_go, eventData)
	end)

	if KeycodeListener.instance.enabled then
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.UpArrow, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.DownArrow, self._onKeycodeChange, self)
	end
end

function LoginSimulationSDKView:unbindEvents()
	self._btnLogin:RemoveClickListener()
	self._btnLogin2:RemoveClickListener()

	for k, v in pairs(self._serTgMap) do
		v:RemoveOnValueChanged()
	end

	self._itemScrCustomInput:RemoveListener()
	PointerClickHandler.Get(self._itemSearchInputGo):RemoveLuaHandler(self._itemSearchInputPointerClickHandler)

	if KeycodeListener.instance.enabled then
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.UpArrow, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.DownArrow, self._onKeycodeChange, self)
	end
end

function LoginSimulationSDKView:_onKeycodeChange(keycode, isOn)
	local inst = KeycodeListener.instance

	if inst:isOn(UnityEngine.KeyCode.UpArrow) and self._inpIpCCC.isFocused then
		self._currentIndex = self._currentIndex - 1
		self._currentIndex = self._currentIndex % #LoginSimulationSDKView.IPConfigs

		local info = LoginSimulationSDKView.IPConfigs[self._currentIndex + 1]

		self._inpIp:SetText(info.ip)
		self:_setVisItemScr(false)
		TipsFacade.instance:openCommonTips("当前选择服务器：" .. info.name)
	end

	if inst:isOn(UnityEngine.KeyCode.DownArrow) and self._inpIpCCC.isFocused then
		self._currentIndex = self._currentIndex + 1
		self._currentIndex = self._currentIndex % #LoginSimulationSDKView.IPConfigs

		local info = LoginSimulationSDKView.IPConfigs[self._currentIndex + 1]

		self._inpIp:SetText(info.ip)
		self:_setVisItemScr(false)
		TipsFacade.instance:openCommonTips("当前选择服务器：" .. info.name)
	end
end

function LoginSimulationSDKView:_onToggleChange(obj, isOn)
	if not self._isToggleChanged and isOn then
		self._isToggleChanged = true

		for i, v in pairs(self._serTgMap) do
			if obj ~= v.gameObject then
				v.toggle.isOn = false
			end
		end

		self._isToggleChanged = false
	end
end

function LoginSimulationSDKView:onEnter()
	self._accoutPerf = Framework.LocalStorage.Instance:GetString("account", "")

	self._inpAccount:SetText(self._accoutPerf)

	local txtIp = Framework.LocalStorage.Instance:GetString("simulatedIp", "")
	local txtVerif = Framework.LocalStorage.Instance:GetString("tempAuthCode", "")

	self._inpIp:SetText(txtIp)
	self._inpVerif:SetText(txtVerif)

	local tag = Framework.LocalStorage.Instance:GetString("tag_selected", "true")

	self.tgBtn.isOn = tag == "true"
	self._isToggleChanged = false

	local list = {}
	local oldStr = Framework.LocalStorage.Instance:GetString("accountList")

	if not string.nilorempty(oldStr) then
		local accounts = GameUtil.jsonToTable(oldStr)

		for k, v in pairs(accounts) do
			table.insert(list, v)
		end
	end

	self._accountList = list

	self:createAccount()
	self:_setVisItemScr(false)
	self:_updateItemSearch()

	self._currentIndex = 0
end

function LoginSimulationSDKView:createAccount()
	goutil.clearChildren(self.container)

	for i, value in ipairs(self._accountList) do
		local go = goutil.clone(self.cell)

		goutil.addChildToParent(go, self.container)
		GameUtil.SetActive(go, true)

		local txt = goutil.findChildTextComponent(go, "txt")
		local btn = goutil.findChild(go, "btn")

		txt.text = value

		GameUtil.addClickHandler(go, function()
			LoginModel.instance.platformId = -1
			LoginModel.instance.sessionId = value

			self:setSdkInfoOk()
		end)
		GameUtil.addClickHandler(btn, function()
			for idx, v in ipairs(self._accountList) do
				if v == value then
					table.remove(self._accountList, idx)

					break
				end
			end

			local str = GameUtil.jsonToString(self._accountList)

			Framework.LocalStorage.Instance:SetString("accountList", str)
			self:createAccount()
		end)
	end
end

function LoginSimulationSDKView:_onClickLoginBtn2()
	self:_tryChangeWebUrl()

	local account = self:_trimWhitespace(self._inpAccount:GetText())

	self._inpAccount:SetText(account)
	Framework.LocalStorage.Instance:SetString("account", account)
	self:_trySveAccout(account)

	local platformId = -1

	printInfo("输入的模拟登录账号=" .. account .. ",platformId=" .. platformId)

	local inpIpStr = self:_trimWhitespace(self._inpIp:GetText())

	self._inpIp:SetText(inpIpStr)

	local inpVerifStr = self:_trimWhitespace(self._inpVerif:GetText())

	self._inpVerif:SetText(inpVerifStr)

	LoginModel.instance.platformId = platformId
	LoginModel.instance.sessionId = account
	LoginModel.instance.simulatedIp = inpIpStr
	LoginModel.instance.tempAuthCode = inpVerifStr

	Framework.LocalStorage.Instance:SetString("simulatedIp", inpIpStr)
	Framework.LocalStorage.Instance:SetString("tempAuthCode", inpVerifStr)
	GlobalDispatcher:dispatch(GlobalNotify.SimulationSDKLoginSuccess)
	self:close()
end

function LoginSimulationSDKView:_trySveAccout(account)
	local has = false

	for i, v in ipairs(self._accountList) do
		if v == account then
			has = true

			break
		end
	end

	if not has then
		table.insert(self._accountList, account)
	end

	while #self._accountList > 20 do
		table.remove(self._accountList, 1)
	end

	local str = GameUtil.jsonToString(self._accountList)

	Framework.LocalStorage.Instance:SetString("accountList", str)
end

function LoginSimulationSDKView:_onClickLoginBtn()
	self:_tryChangeWebUrl()

	local account = self:_trimWhitespace(self._inpAccount:GetText())

	self._inpAccount:SetText(account)
	Framework.LocalStorage.Instance:SetString("account", account)
	self:_trySveAccout(account)

	local platformId = -1

	printInfo("输入的模拟登录账号=" .. account .. ",platformId=" .. platformId)

	local inpIpStr = self:_trimWhitespace(self._inpIp:GetText())

	self._inpIp:SetText(inpIpStr)

	local inpVerifStr = self:_trimWhitespace(self._inpVerif:GetText())

	self._inpVerif:SetText(inpVerifStr)

	LoginModel.instance.platformId = platformId
	LoginModel.instance.sessionId = account
	LoginModel.instance.simulatedIp = inpIpStr
	LoginModel.instance.tempAuthCode = inpVerifStr

	Framework.LocalStorage.Instance:SetString("simulatedIp", inpIpStr)
	Framework.LocalStorage.Instance:SetString("tempAuthCode", inpVerifStr)
	GlobalDispatcher:addListener(GlobalNotify.GameWebLoginSuccess, self._onGameWebLoginSuccess, self, NotifyPriority.Low)
	GlobalDispatcher:dispatch(GlobalNotify.SimulationSDKLoginSuccess)
end

function LoginSimulationSDKView:_tryChangeWebUrl()
	for k, v in pairs(self._serTgMap) do
		if v.toggle.isOn and CSGameUtil.GetGameConfigUrlType() ~= k then
			BootstrapPjaqGameConfigMgr.GameConfigJsonData = TEMP_SERVER_ARR[k]

			function CSGameUtil.GetGameConfigUrlType()
				return k
			end
		end
	end
end

function LoginSimulationSDKView:onExit()
	Framework.LocalStorage.Instance:SetString("tag_selected", tostring(self.tgBtn.isOn))
end

function LoginSimulationSDKView:setSdkInfoOk()
	if self.tgBtn.isOn then
		GlobalDispatcher:addListener(GlobalNotify.GameWebLoginSuccess, self._onGameWebLoginSuccess, self, NotifyPriority.Low)
		GlobalDispatcher:addListener(GlobalNotify.GameWebLoginSvrListEmpty, self._onGameWebLoginSvrListEmpty, self, NotifyPriority.Low)
		GlobalDispatcher:dispatch(GlobalNotify.SimulationSDKLoginSuccess)
	else
		self._inpAccount:SetText(LoginModel.instance.sessionId)
	end
end

function LoginSimulationSDKView:_onGameWebLoginSuccess()
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSvrListEmpty, self._onGameWebLoginSvrListEmpty)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSuccess, self._onGameWebLoginSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSvrListEmpty, self._onGameWebLoginSvrListEmpty)
	GlobalDispatcher:addListener(GlobalNotify.GameWebStartGameSuccess, self._onGameWebStartSuccess, self, NotifyPriority.Low)

	local status = LoginModel.instance.curAreaStatus

	print(">>>>>>>>>>>>>>>>>>>>> LoginView:_realonClickLogin()", status, LoginModel.instance.gameAccount, LoginModel.instance.socketPassword)

	if status then
		LoginAgent.instance:sendHttpWebStartGameRequest(LoginModel.instance.gameAccount, LoginModel.instance.socketPassword, status.id, 0)
	end
end

function LoginSimulationSDKView:_onGameWebStartSuccess()
	GlobalDispatcher:removeListener(GlobalNotify.GameWebStartGameSuccess, self._onGameWebLoginSuccess, self)

	local list = LoginServerListModel.instance:getMoList()
	local svr

	for k, v in pairs(list) do
		for k1, v1 in pairs(v) do
			if v1.id == 10001 then
				svr = v1

				break
			end
		end

		if svr then
			break
		end
	end

	if svr == nil then
		svr = LoginServerListModel.instance:popActiveServer()
	end

	if svr then
		LoginController.instance:setServerData(svr.ip, svr.port)
		LoginController.instance:login(svr.ip, svr.port)
	else
		FloatWordMgr.instance:show("没有岛！！！")
	end

	if self._viewPresentor then
		self:close()
	end
end

function LoginSimulationSDKView:_onGameWebLoginSvrListEmpty()
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSvrListEmpty, self._onGameWebLoginSvrListEmpty)
	GlobalDispatcher:removeListener(GlobalNotify.GameWebLoginSuccess, self._onGameWebLoginSuccess, self)
	self:close()
end

function LoginSimulationSDKView:_trimWhitespace(str)
	return str:match("^%s*(.-)%s*$")
end

function LoginSimulationSDKView:_updateItemSearch()
	self._itemScrollList:reloadData(LoginSimulationSDKView.IPConfigs)
end

function LoginSimulationSDKView:_onItemScrCustomInputCallback(hover)
	if not hover then
		self:_setVisItemScr(false)
	end
end

function LoginSimulationSDKView:_setVisItemScr(isToShow)
	GameUtil.SetActive(self._itemScrGo, isToShow)
end

function LoginSimulationSDKView:_setItemSearchText(value)
	self._searchText:RemoveOnValueChanged()
	self._searchText:SetText(value)
	self._searchText:AddOnValueChanged(self._onClickSearch, self)
end

function LoginSimulationSDKView:_onClickSearch()
	self:_setVisItemScr(true)
end

function LoginSimulationSDKView:_updateItemCell(view, cell, info, tag)
	local descGo = goutil.findChild(cell, "Desc")
	local txtDesc = goutil.findChildTextComponent(cell, "Desc")

	txtDesc.text = info.name

	GameUtil.addClickHandler(descGo, GameUtil.handler(self._onClickItemCell, self, info))
end

function LoginSimulationSDKView:_clearItemCell(cell)
	local descGo = goutil.findChild(cell, "Desc")

	GameUtil.rmClickHandler(descGo)
end

function LoginSimulationSDKView:_onClickItemCell(info)
	self._inpIp:SetText(info.ip)
	self:_setVisItemScr(false)
end

function LoginSimulationSDKView:_onItemSearchInputPointerClickHandler(go, eventData)
	self:_setVisItemScr(true)
end

return LoginSimulationSDKView
