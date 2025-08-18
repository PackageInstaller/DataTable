-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\AccountBindAndSignDlg.lua

local UIControls = require("UI/UIControls")
local SDKConst = require("SDK/SDKConst")
local Analytics = require("SDK/Analytics")
local LoginState = SDKConst.LoginState
local GameSettingHelper = Framework.Settings.GameSettingHelper
local AnalyticUtils = Framework.SDK.AnalyticUtils
local AttName = SDKConst.AttName
local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local UserData = require("Helper/UserData")
local strClassName = "AccountBindAndSignDlg"
local AccountBindAndSignDlg = Class(strClassName, UIControls.Window)
local PROTOCOL_TYPE = {
	agreement = "agreement",
	privacy = "privacy"
}

function AccountBindAndSignDlg:ctor()
	self.hasBind = {}
	self.startLoginTime = os.time()
	self.startBindTime = os.time()
	self.textPanelName = UIControls.Label(self, "BgPanel/TextTitle")
	self.btnGoogleLogin = UIControls.Button(self, "BgPanel/WayPanel/BtnWay1", "Text")
	self.googleBindPanel = UIControls.Panel(self, "BgPanel/WayPanel/BtnWay1/ImgBind")
	self.btnTwitterLogin = UIControls.Button(self, "BgPanel/WayPanel/BtnWay2", "Text")

	self.btnTwitterLogin:addEventClick(Functor(self.onClick, self, SDKConst.JP_LoginType.GMUserTypeTwitter))

	self.twitterBindPanel = UIControls.Panel(self, "BgPanel/WayPanel/BtnWay2/ImgBind")
	self.btnLeadCodeLogin = UIControls.Button(self, "BgPanel/WayPanel/BtnWay3", "Text")

	self.btnLeadCodeLogin:addEventClick(Functor(self.onClick, self, SDKConst.JP_LoginType.GMUserTypeLeadCode))

	self.leadCodeBindPanel = UIControls.Panel(self, "BgPanel/WayPanel/BtnWay3/ImgBind")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.platform = GameSettingHelper.GetPlatformName()

	if self.platform == "iOS" then
		self.btnGoogleLogin:addEventClick(Functor(self.onClick, self, SDKConst.JP_LoginType.GMUsertypeApple))
		self.btnGoogleLogin:setImage("Atlas/LoginAtlas/LoginAtlas1", "IconApple")
		self.btnGoogleLogin:setText("")
		self.btnTwitterLogin:setText("")
		self.btnLeadCodeLogin:setText("")
	elseif self.platform == "Android" then
		self.btnGoogleLogin:addEventClick(Functor(self.onClick, self, SDKConst.JP_LoginType.GMUserTypeGoogle))
		self.btnGoogleLogin:setImage("Atlas/LoginAtlas/LoginAtlas1", "IconGoogle")
		self.btnGoogleLogin:setText(Lang.get(51863))
		self.btnTwitterLogin:setText(Lang.get(51864))
		self.btnLeadCodeLogin:setText(Lang.get(30415))
	else
		self.btnGoogleLogin:addEventClick(Functor(self.onClick, self, SDKConst.JP_LoginType.GMUsertypeApple))
		self.btnGoogleLogin:setImage("Atlas/LoginAtlas/LoginAtlas1", "IconGoogle")
		self.btnGoogleLogin:setText(Lang.get(51863))
		self.btnTwitterLogin:setText(Lang.get(51864))
		self.btnLeadCodeLogin:setText(Lang.get(30415))
	end

	self.btnAgreement = UIControls.Button(self, "BgPanel/OtherFuncPanel/BtnAgreement")

	self.btnAgreement:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.agreement))

	self.btnPrivacy = UIControls.Button(self, "BgPanel/OtherFuncPanel/BtnPrivacy")

	self.btnPrivacy:addEventClick(Functor(self.showAgreement, self, PROTOCOL_TYPE.privacy))

	self.btnLogout = UIControls.Button(self, "BgPanel/BtnLogout")

	self.btnLogout:addEventClick(self.logoutAccount)

	self._sdkImp = SDKAgent.getSDKImp()

	if self._sdkImp and not self._sdkImp.user_types then
		-- block empty
	end
end

function AccountBindAndSignDlg:zysTestFunction()
	local infos = "[{\"avatar_url\":\"https://p3.pstatp.com/thumb/3793/3131589739\",\"nickname\" :\"guest150961\", \"puid\" : \"0\", \"user_type\" : 1 },  { \"avatar_url\":\"https://lh4.googleusercontent.com/-C4HpfWMKyZ8/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmZXJzCoNwFWs5BiMKDv1UnV6xoew/s300-c/photo.jpg\", \"nickname\" : \"Yu CHen\",\"puid\" : \"6912257061620417537\",\"user_type\" : \"11\" } ]"
	local user_types = {}
	local connects = ClientUtils.string2Table(infos)

	for _, v in ipairs(connects) do
		table.insert(user_types, v.user_type)
	end

	if self._sdkImp then
		self._sdkImp.user_types = user_types
	end
end

function AccountBindAndSignDlg:logoutAccount()
	if DeviceHelper.isIOS() and VersionUtils.hasAbilityIOSAccOff() then
		local url = "https://gsdk-sg.bytegsdk.com/h5/account_cancellation?hide_nav_bar=1&hide_title_bar=1&orientation=portrait"

		SDKAgent.questionnaire(url, Slot(self._logoffCallback, self))
	elseif DeviceHelper.isAndroid() and VersionUtils.hasAbilityJPVIPMonthCard() then
		local url = "https://gsdk-sg.bytegsdk.com/h5/account_cancellation?hide_nav_bar=1&hide_title_bar=1&orientation=portrait"

		SDKAgent.questionnaire(url, Slot(self._logoffCallback, self))
	else
		local function yesFunc()
			UIManager.getUI("infoNotice", true):showSystemInfo(173)
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, Lang.get(42727), yesFunc, nil, nil, Lang.get(42728))
	end
end

function AccountBindAndSignDlg:_logoffCallback(data)
	Framework.Tools.LuaToolkit.LogEx("cwtjp _logoffCallback:" .. ClientUtils.table2String(data))
	SDKAgent.logout()
end

function AccountBindAndSignDlg:openForBind(bind)
	self.isForBind = bind

	if bind then
		self:refreshBindData()
		self.textPanelName:setText(Lang.get(1349))
	else
		self.textPanelName:setText(Lang.get(30399))
	end
end

function AccountBindAndSignDlg:refreshBindData()
	if self._sdkImp and self._sdkImp.user_types then
		for _, v in ipairs(self._sdkImp.user_types) do
			table.insert(self.hasBind, tostring(v))

			if tostring(v) == SDKConst.JP_LoginType.GMUsertypeApple and self.platform == "iOS" then
				self.googleBindPanel:setVisible(true)
			elseif tostring(v) == SDKConst.JP_LoginType.GMUserTypeGoogle and self.platform == "Android" then
				self.googleBindPanel:setVisible(true)
			elseif tostring(v) == SDKConst.JP_LoginType.GMUserTypeTwitter then
				self.twitterBindPanel:setVisible(true)
			end
		end
	end

	if self._sdkImp and self._sdkImp.successionId then
		self.leadCodeBindPanel:setVisible(true)
	end
end

function AccountBindAndSignDlg:onClick(loginType)
	local yes_changeSvr

	if loginType == SDKConst.JP_LoginType.GMUserTypeLeadCode then
		function yes_changeSvr()
			if not self._sdkImp or not self._sdkImp.successionId then
				self:muteAllBtn(Lang.get(45584))
			end

			SDKAgent.querySuccessionCode()

			local leadCodeBind = UIManager.getUI("leadCodeBindDlg")

			if leadCodeBind then
				leadCodeBind:openForBind(self.isForBind)
			end
		end
	else
		function yes_changeSvr()
			for _, v in ipairs(self.hasBind) do
				if loginType == v and self.isForBind then
					MsgManager.notice(Lang.get(30400))

					return
				end
			end

			local notice

			if self.isForBind then
				SDKAgent.authBind(loginType)

				self.startBindTime = os.time()
				notice = Lang.get(30401)
			else
				if loginType == SDKConst.JP_LoginType.GMUserTypeGoogle and AccountManager.getLoginState() == LoginState.LOGIN then
					SDKAgent.logout(Slot(SDKAgent.authLogin, loginType))
				else
					SDKAgent.authLogin(loginType)
				end

				self.startLoginTime = os.time()
				notice = Lang.get(30402)
			end

			self:muteAllBtn(notice)
		end
	end

	if not self.isForBind then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(50621), "既に「フィギュアストーリー」をプレイしている場合は【確認】を選択してください\n以前のゲームデータを引き継いでプレイすることができます。<color=#ff3939>異なるOS</color>でプレイしてした場合、<color=#ff3939>引き継ぐ前のOS</color>で所持していた。<color=#ff3939>有償ダイヤは引き継ぎ先であるOSでの使用はできません。</color>引継ぐ前のOSに戻ると使用できます", yes_changeSvr, nil, nil, nil, nil, nil, UIConst.TXTALIGN_UL)
	elseif self.isForBind then
		yes_changeSvr()
	end
end

function AccountBindAndSignDlg:bindResult(data)
	if data then
		local result = tonumber(data[AttName.RESULT]) == 1

		if result then
			if self.isForBind then
				MsgManager.notice(Lang.get(30003))
				self:refreshBindData()
			else
				MsgManager.notice(Lang.get(30403))

				local serverListDlg = UIManager.getUI("servers")

				if serverListDlg then
					serverListDlg:showServers()
				end
			end
		end

		self:reportBuriedPoint(result)
	end

	self:closeAll()
end

function AccountBindAndSignDlg:reportBuriedPoint(result)
	local data = Analytics.getByteLogParamNoUser()

	data.event = "guide_flow"

	if result then
		if self.isForBind then
			data.guide_id = 150
			data.duration = os.time() - self.startLoginTime
		else
			data.guide_id = 110
			data.duration = os.time() - self.startBindTime

			return
		end
	elseif self.isForBind then
		data.guide_id = 140
		data.duration = os.time() - self.startLoginTime
	else
		data.guide_id = 115
		data.duration = os.time() - self.startBindTime
	end

	Analytics.sendLogByted("guide_flow", ClientUtils.table2String(data))
end

function AccountBindAndSignDlg:showAgreement(protocol)
	SDKAgent.openAgreement(protocol)
end

function AccountBindAndSignDlg:muteAllBtn(notice)
	local spinner = UIManager.getUI("loginSpinner", true, true)

	if spinner then
		spinner:setText(notice)
		spinner:delayedClose(15)
	end
end

function AccountBindAndSignDlg:onCloseClick()
	self:setVisible(false)
end

function AccountBindAndSignDlg:closeAll()
	self:onCloseClick()

	local code = UIManager.tryGetUI("leadCodeBindDlg")

	if code then
		code:onCloseClick()
	end

	local choose = UIManager.tryGetUI("accountChooseDlg")

	if choose then
		choose:onCloseClick()
	end
end

return AccountBindAndSignDlg
