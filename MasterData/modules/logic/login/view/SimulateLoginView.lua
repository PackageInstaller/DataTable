-- chunkname: @modules/logic/login/view/SimulateLoginView.lua

module("modules.logic.login.view.SimulateLoginView", package.seeall)

local SimulateLoginView = class("SimulateLoginView", BaseView)
local Input = UnityEngine.Input
local KeyCode = UnityEngine.KeyCode
local kMaxHistoryCount = 10

local function _randomAccount()
	local account = ""

	math.randomseed(os.time())

	for i = 1, 6 do
		local n = math.random(0, os.time())

		n = n % 62

		if n < 10 then
			n = tostring(n)
		elseif n < 36 then
			n = n - 10 + 65
			n = string.char(n)
		else
			n = n - 36 + 97
			n = string.char(n)
		end

		account = account .. n
	end

	return account
end

function SimulateLoginView:_quickLogin()
	local account = self._inputField:GetText()

	if string.nilorempty(account) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, account)
	self:onClickModalMask()
	FrameTimerController.onDestroyViewMember(self, "_loginFrameTimer")

	self._loginFrameTimer = FrameTimerController.instance:register(self._onClickLogin, self, 3, 1)

	self._loginFrameTimer:Start()
end

function SimulateLoginView:_onUpdate()
	local ctrl = Input.GetKey(KeyCode.LeftControl) or Input.GetKey(KeyCode.RightControl)

	if ctrl and Input.GetKeyDown(KeyCode.Return) then
		self:_setLoginAccountInput(_randomAccount())
		self:_quickLogin()

		return
	end

	if Input.GetKeyDown(KeyCode.UpArrow) then
		self:_selectBeforeAccount()
	elseif Input.GetKeyDown(KeyCode.DownArrow) then
		self:_selectNextAccount()
	elseif Input.GetKeyDown(KeyCode.KeypadEnter) or Input.GetKeyDown(KeyCode.Return) then
		self:_quickLogin()
	end
end

function SimulateLoginView:_onClickLogin()
	local loginViewContainer = ViewMgr.instance:getContainer(ViewName.LoginView)

	for _, viewObj in ipairs(loginViewContainer._views) do
		if viewObj.__cname == "LoginView" then
			viewObj:_onClickLogin()

			break
		end
	end
end

local kPlayerPrefsKeys = "SimulateLoginView_HistoryAccount"

function SimulateLoginView:_saveHistoryAccount()
	local list = self:_getHistoryAccountList()
	local loginAccount = self._inputField:GetText()
	local hasSavedLoginAccount = false
	local sb = {}

	for i, v in ipairs(list) do
		if i > kMaxHistoryCount then
			break
		end

		if v.account == loginAccount then
			table.insert(sb, v.account .. "#" .. tostring(os.time()))

			hasSavedLoginAccount = true
		else
			table.insert(sb, v.account .. "#" .. tostring(v.ts))
		end
	end

	if not hasSavedLoginAccount then
		if #sb >= kMaxHistoryCount then
			table.remove(sb)
		end

		table.insert(sb, 1, loginAccount .. "#" .. tostring(os.time()))
	end

	local saveValue = table.concat(sb, "|")

	PlayerPrefsHelper.setString(kPlayerPrefsKeys, saveValue)
end

function SimulateLoginView:_getHistoryAccountPlayerPrefs()
	local list = {}
	local str = PlayerPrefsHelper.getString(kPlayerPrefsKeys, "")

	if string.nilorempty(str) then
		if not string.nilorempty(self._lastAccount) then
			list[1] = {
				account = self._lastAccount,
				ts = os.time()
			}
		end
	else
		local strList = GameUtil.splitString2(str)

		for _, v in ipairs(strList) do
			table.insert(list, {
				account = v[1],
				ts = tonumber(v[2])
			})
		end
	end

	table.sort(list, function(a, b)
		return a.ts > b.ts
	end)

	local len = #list

	for i = kMaxHistoryCount + 1, len do
		table.remove(list)
	end

	return list
end

function SimulateLoginView:_getHistoryAccountList()
	self._historyAccountStrList = self._historyAccountStrList or self:_getHistoryAccountPlayerPrefs()

	return self._historyAccountStrList
end

function SimulateLoginView:_initHistoryAccountData()
	self._lastAccount = PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount, "")
	self._curAccountIndex = 0
	self.__firstInited = true
end

function SimulateLoginView:_initHistoryAccount()
	if self.__isHistoryAccountInited then
		return
	end

	self.__isHistoryAccountInited = true

	self:_initHistoryAccountData()
	self:_initHistoryAccountView()
end

function SimulateLoginView:_initHistoryAccountView()
	local inputFieldGo = self._inputField.gameObject
	local go = gohelper.create2d(self.viewGO, "===History Account===")
	local imgGo = gohelper.create2d(go)
	local imgTrans = imgGo.transform
	local textGo = gohelper.clone(gohelper.findChild(inputFieldGo, "Text"), imgGo)
	local textTrans = textGo.transform
	local img = gohelper.onceAddComponent(imgGo, gohelper.Type_Image)
	local text = gohelper.findChildText(textGo, "")

	recthelper.setWidth(imgTrans, 500)
	UIDockingHelper.setDock(UIDockingHelper.Dock.MR_R, imgTrans, inputFieldGo.transform)

	text.richText = true
	textTrans.anchorMin = Vector2.New(0, 0)
	textTrans.anchorMax = Vector2.New(1, 1)
	textTrans.pivot = Vector2.New(0.5, 0.5)

	recthelper.setAnchor(textTrans, 0, 0)

	textTrans.sizeDelta = Vector2.New(0, 0)

	ZProj.UGUIHelper.SetColorAlpha(img, 0.5)

	self._historyAccountGo = go
	self._historyAccountText = text
	self._historyAccountImgTrans = imgTrans

	self:_refreshHistoryAccountView()
end

local kGreen = "#00FF00"

function SimulateLoginView:_refreshHistoryAccountView()
	local list = self:_getHistoryAccountList()
	local res = {}

	for i, v in ipairs(list) do
		local str = tostring(v.account)

		if i - 1 == self._curAccountIndex then
			str = gohelper.getRichColorText(str, kGreen)
		end

		table.insert(res, str)
	end

	self._historyAccountText.text = table.concat(res, "\n")

	recthelper.setHeight(self._historyAccountImgTrans, self._historyAccountText.preferredHeight)
end

function SimulateLoginView:_selectBeforeAccount()
	self:_initHistoryAccount()

	local N = #self:_getHistoryAccountList()
	local index = (self._curAccountIndex + N - 1) % N

	self:_onHistoryAccountDropDownChange(index)
end

function SimulateLoginView:_selectNextAccount()
	self:_initHistoryAccount()

	local N = #self:_getHistoryAccountList()
	local index = (self._curAccountIndex + 1) % N

	self:_onHistoryAccountDropDownChange(index)
end

function SimulateLoginView:_setLoginAccountInput(str)
	self._inputField:SetText(str or "")
end

function SimulateLoginView:_onHistoryAccountDropDownChange(index)
	if not self._historyAccountStrList then
		return
	end

	if self.__firstInited then
		index = 0
		self.__firstInited = false
	end

	index = GameUtil.clamp(index, 0, #self._historyAccountStrList - 1)

	if self._curAccountIndex == index then
		return
	end

	self._curAccountIndex = index

	local info = self._historyAccountStrList[index + 1]

	self:_setLoginAccountInput(info.account)
	self:_refreshHistoryAccountView()
end

function SimulateLoginView:onClose_()
	UpdateBeat:Remove(self._onUpdate, self)

	if self._hestoryAccountDropDown then
		self._hestoryAccountDropDown:RemoveOnValueChanged()
	end

	self:_saveHistoryAccount()
end

function SimulateLoginView:ctor()
	self._button = nil
	self._inputField = nil
end

function SimulateLoginView:onInitView()
	self._button = gohelper.findChildButtonWithAudio(self.viewGO, "Button")
	self._inputField = gohelper.findChildTextMeshInputField(self.viewGO, "InputField")
	self._btnAgeFit = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtn/#btn_agefit")
	self._dropServer = gohelper.findChildDropdown(self.viewGO, "autoserver")
end

function SimulateLoginView:addEvents()
	self._button:AddClickListener(self._onClickButton, self)
	self._btnAgeFit:AddClickListener(self._onClickAgeFit, self)
	self._inputField:AddOnEndEdit(self._onEndEdit, self)
end

function SimulateLoginView:removeEvents()
	self._button:RemoveClickListener()
	self._btnAgeFit:RemoveClickListener()
	self._inputField:RemoveOnEndEdit()
end

function SimulateLoginView:onOpen()
	UpdateBeat:Add(self._onUpdate, self)
	gohelper.addUIClickAudio(self._button.gameObject, AudioEnum.UI.UI_Common_Click)

	local account = PlayerPrefsHelper.getString(PlayerPrefsKey.SimulateAccount)

	self._inputField:SetText(account)
	TaskDispatcher.runRepeat(self._onTick, self, 0.1)
	gohelper.setActive(self._dropServer, false)

	if QuickEnterServerModel.enable and isDebugBuild and self._dropServer then
		local list = QuickEnterServerModel.instance:getLastEnterServerList()

		if #list > 0 then
			gohelper.setActive(self._dropServer, true)
			self._dropServer:ClearOptions()

			local options = {
				"正常登录"
			}

			for i, v in ipairs(list) do
				table.insert(options, string.format("直连【%s】", v.name))
			end

			self._dropServer:AddOptions(options)
			self._dropServer:SetValue(QuickEnterServerModel.instance:getLastIndex())
		end
	end

	local isQQ = tostring(SDKMgr.instance:getChannelId()) == "102"

	gohelper.setActive(self._btnAgeFit.gameObject, not isQQ and SettingsModel.instance:isZhRegion())
end

function SimulateLoginView:onClose()
	self:onClose_()
	TaskDispatcher.cancelTask(self._onTick, self)
end

function SimulateLoginView:_onTick()
	if not ViewMgr.instance:isOpen(ViewName.LoginView) then
		logNormal("LoginView has close, close SimulateLoginView too")
		self:closeThis()
	end
end

function SimulateLoginView:_onClickButton(param)
	local account = self._inputField:GetText()

	if string.nilorempty(account) then
		GameFacade.showToast(ToastEnum.SimulateLogin)

		return
	end

	if QuickEnterServerModel.enable and isDebugBuild and self._dropServer then
		local selectVal = self._dropServer:GetValue()

		QuickEnterServerModel.instance:setLastIndex(selectVal)

		local server = QuickEnterServerModel.instance:getLastEnterServerList()[selectVal]

		if server then
			self:closeThis()
			ViewMgr.instance:closeView(ViewName.LoginView)
			LoginModel.instance:setChannelParam("", account, "", "", "")

			LoginModel.instance.userName = account
			LoginModel.instance.sessionId = "1999"
			LoginModel.instance.serverIp = server.ip
			LoginModel.instance.serverPort = server.port
			LoginModel.instance.serverName = server.name
			LoginModel.instance.serverId = server.id

			LoginController.instance:startLogin()

			return
		end
	end

	self:closeThis()
	LoginModel.instance:setChannelParam("", account, "", "", "")
	LoginController.instance:login({})
end

function SimulateLoginView:onClickModalMask()
	self:_onClickButton()
end

function SimulateLoginView:_onClickAgeFit()
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function SimulateLoginView:_onEndEdit(text)
	PlayerPrefsHelper.setString(PlayerPrefsKey.SimulateAccount, text)
end

return SimulateLoginView
