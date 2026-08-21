-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\SDKImp\\SDKImpByted.lua

local SDKImpCommon = require("SDK/SDKImp/SDKImpCommon")
local SDKImpByted = Class("SDKImpByted", SDKImpCommon, true)
local SDKCore = require("SDK/SDKCore")
local DeviceHelper = require("Helper/DeviceHelper")
local SDKConst = require("SDK/SDKConst")
local UIManager = require("UI/UIManager")
local ResAccountNotice = require("SDK/SDKImp/ResAccountNotice")
local ResIgnoreNotice = require("SDK/SDKImp/ResIgnoreNotice")
local VersionUtils = require("System/VersionUtils")
local WebView = require("SDK/Plugin/WebView")
local ResMall = require("ClientData/ResMall")
local ResChannelHideActivityConfig = require("ClientData/ResChannelHideActivityConfig")
local U3DOceanSDK = Framework.SDK.U3DOceanSDK
local AttName = SDKConst.AttName
local ChannelID = SDKConst.ChannelID

function SDKImpByted:init()
	self:initNoticeData()
	self:_replaceDMMText()
	self:hideSpecialChannelMallSubPanel()
	SDKImpByted.super.init(self)
end

function SDKImpByted:initNoticeData()
	if VersionUtils.isOldVersionSDK_jp() then
		self.isOldVersion = true
		self.accountNotice = ResAccountNotice[2]
		self.ignoreNotice = ResIgnoreNotice[2]
	else
		self.isOldVersion = false
		self.accountNotice = ResAccountNotice[1]
		self.ignoreNotice = ResIgnoreNotice[1]
	end
end

function SDKImpByted:accountCenter()
	local bindDlg = UIManager.getUI("accountBindAndSingDlg", true)

	if bindDlg then
		bindDlg:openForBind(false)
	end
end

function SDKImpByted:_doLogin()
	U3DOceanSDK.Login()

	local spinner = UIManager.getUI("loginSpinner", true, true)

	if spinner then
		spinner:setText(Lang.get(30402))
		spinner:delayedClose(15)
	end
end

function SDKImpByted:customerService()
	local parameter = {}

	if CurAvatar then
		parameter.role_id = CurAvatar.uid
		parameter.server_id = SvrListManager.getSelectedSvrID()
	end

	local customerServiceData = {}

	customerServiceData[AttName.WEB_TITLE] = ""
	customerServiceData[AttName.WEB_CALLBACK] = 0
	customerServiceData[AttName.WEB_ORIENTATION] = 0

	if self:getUserID() then
		customerServiceData[AttName.WEB_URL] = ClientUtils.composeGetUrl("https://cs.bytegsdk.com/chat", parameter)
	else
		customerServiceData[AttName.WEB_URL] = "https://cs.bytegsdk.com/email"
	end

	if DeviceHelper.isWindows() then
		customerServiceData[AttName.WEB_URL] = "https://figurestory.nvsgames.com/dmg#contact"
	end

	ChannelUtil.doAnyFunction("customerService", customerServiceData)
end

function SDKImpByted:questionnaire(url, callback)
	self.questionnaireCB = callback

	local parameter = {}

	if CurAvatar then
		parameter.role_id = CurAvatar.uid
		parameter.server_id = SvrListManager.getSelectedSvrID()
	end

	local customerServiceData = {}

	customerServiceData[AttName.WEB_TITLE] = ""
	customerServiceData[AttName.WEB_CALLBACK] = 1
	customerServiceData[AttName.WEB_URL] = ClientUtils.composeGetUrl(url, parameter, string.find(url, "?"))

	if string.find(url, "account_cancellation") then
		customerServiceData[AttName.WEB_ORIENTATION] = 2
	else
		customerServiceData[AttName.WEB_ORIENTATION] = 0
	end

	ChannelUtil.doAnyFunction("questionnaire", customerServiceData)
end

function SDKImpByted:showNotice()
	local notice = UIManager.getUI("loginNoticeJP")

	if notice then
		notice:show()
	end
end

function SDKImpByted:agreement(protocol)
	if protocol then
		local customerServiceData = {}

		customerServiceData[AttName.WEB_TITLE] = ""
		customerServiceData[AttName.WEB_CALLBACK] = 0

		if protocol == "agreement" then
			if DeviceHelper.isWindows() then
				customerServiceData[AttName.WEB_URL] = "https://sf19-draftcdn-sg.ibytedtos.com/obj/ies-hotsoon-draft-sg/GSDK/termofservicedmm.html"
			else
				customerServiceData[AttName.WEB_URL] = "https://lf16-ga17cdn-sg.bytedgame.com/obj/lf-game-alisg/gdl_app_4255/termofservice.html"
			end
		elseif protocol == "privacy" then
			if DeviceHelper.isWindows() then
				customerServiceData[AttName.WEB_URL] = "https://sf16-draftcdn-sg.ibytedtos.com/obj/ies-hotsoon-draft-sg/GSDK/privacypolicydmm.html"
			else
				customerServiceData[AttName.WEB_URL] = "https://sf1-cdn-tos.douyinstatic.com/obj/ies-hotsoon-draft/GSDK/figurestoryprivacypolicy.html"
			end
		end

		customerServiceData[AttName.WEB_ORIENTATION] = 0

		ChannelUtil.doAnyFunction("sdkShowWebView", customerServiceData)
	else
		UIManager.getUI("agreementPop", true)
	end
end

function SDKImpByted:onQuestionnaireFinish(data)
	if self.questionnaireCB then
		self.questionnaireCB(data)

		self.questionnaireCB = nil
	end
end

function SDKImpByted:isAgeLimit()
	local isLimit = false
	local notice = 0

	return isLimit, notice
end

function SDKImpByted:isLoginLocked()
	local loginDlg = UIManager.tryGetUI("login")

	if loginDlg then
		local isOn = loginDlg:getAgreementIsOn()

		if not ClientUtils.isFirstOpen() and not isOn then
			MsgManager.notice(Lang.get(30427))
		end

		return not isOn
	else
		return false
	end
end

function SDKImpByted:getSdkOpenID()
	local sdk_opid = SDKCore.getUserValue(AttName.SDK_OPEN_ID)

	if sdk_opid and sdk_opid ~= "" then
		return sdk_opid
	elseif self._sdkOpenId and self._sdkOpenId ~= "" then
		return self._sdkOpenId
	else
		ChannelUtil.doAnyFunction("querySdkOpenId", {})

		return nil
	end
end

function SDKImpByted:_doSwitchAccount()
	local bindDlg = UIManager.getUI("accountBindAndSingDlg", true)

	if bindDlg then
		bindDlg:openForBind(false)
	end
end

function SDKImpByted:_setUserID(id)
	SDKImpByted.super._setUserID(self, id)

	local data = {}

	data[AttName.SDK_OPEN_ID] = id

	SDKCore.addUserData(data)
end

function SDKImpByted:_doSDKPay(content)
	if DeviceHelper.isWindows() then
		local sdkOrder = ClientUtils.string2Table(content)
		local price = tonumber(utils.splitString(sdkOrder.product_id, ".")[4])
		local point = tonumber(SDKCore.getUserValue("point"))

		if price <= point then
			local function yesFunc()
				SDKImpByted.super._doSDKPay(self, content)
			end

			local message = string.format("%sDMMポイントを消費して\nパックを購入しますか？\n所持DMMポイント：%s\n<color=#ffa500>有料ダイヤはDMM版でご利用いただけます</color>", price, point)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "tips", message, yesFunc, nil, nil, "はい", "キャンセル")
		else
			local function yesFunc()
				WebView.unityOpenUrl("https://point.dmm.com/choice/pay")
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "tips", "チャージ操作を終了いたします", Slot(self._doU3DOceanSDKLogin, self))
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "tips", Lang.get(76349), yesFunc, nil, nil, Lang.get(50621), "キャンセル")
		end
	else
		SDKImpByted.super._doSDKPay(self, content)
	end
end

function SDKImpByted:_doU3DOceanSDKLogin()
	U3DOceanSDK.Login()
end

function SDKImpByted:setSdkOpenID(data)
	local result = tonumber(data[AttName.RESULT]) == 1

	if result then
		self._sdkOpenId = data[AttName.SDK_OPEN_ID]
	end
end

function SDKImpByted:LoginResult(data)
	self:CloseSpinner()

	local result = tonumber(data[AttName.RESULT]) == 1

	if result then
		self.curUserType = data.userType
		self.user_types = {}
		self.successionId = nil

		local con = data.connect_infos or {}

		for _, v in ipairs(con) do
			table.insert(self.user_types, v.user_type)
		end

		data[AttName.CHANNEL_ID] = ChannelID.BYTED

		self:_onSDKLoginSucc(data)
	else
		self:failNotice(data)
	end

	local lcBindDlg = UIManager.tryGetUI("accountBindAndSingDlg")

	if lcBindDlg then
		lcBindDlg:bindResult(data)
	end
end

function SDKImpByted:getSuccessionCodeResult(data)
	self:CloseSpinner()

	local result = tonumber(data[AttName.RESULT]) == 1

	if result then
		self.successionId = data[AttName.SUCCESSION_ID]
		self.successionCode = self:_handSuccessionCode(data[AttName.SUCCESSION_CODE])
	else
		self.successionId = nil
		self.successionCode = nil

		if not GameFsm.isInState(Const.STATE_LOGIN) then
			self:failNotice(data)
		end
	end

	local lcBindDlg = UIManager.tryGetUI("leadCodeBindDlg")

	if lcBindDlg then
		lcBindDlg:successionIDResult(result, self.successionId, self.successionCode)
	end
end

function SDKImpByted:_handSuccessionCode(code)
	if not code then
		return
	end

	local starNum = string.len(code) - 2
	local last2words = string.sub(code, -2)
	local tab = {}

	for i = 1, starNum do
		table.insert(tab, "*")
	end

	return table.concat(tab) .. last2words
end

function SDKImpByted:getUserPayInfo(data)
	self:CloseSpinner()

	local result = tonumber(data[AttName.RESULT]) == 1

	if result then
		self.ageEnum = tonumber(data.birth)
		self.usedAmount = data.amount
		self.limitAmounts = {}

		local rules = data.rules

		if rules then
			for i, v in ipairs(rules) do
				self.limitAmounts[i] = v.payment_limit
			end
		end
	else
		self:failNotice(data)
	end
end

function SDKImpByted:failNotice(data)
	local errData = ClientUtils.string2Table(data[AttName.REASON])

	if not self.ignoreNotice then
		self:initNoticeData()
	end

	if errData then
		local errCode = tonumber(errData.code)
		local extraErrorCode = tonumber(errData.extraErrorCode)

		if self:isIgnoreNotice(errCode, extraErrorCode) then
			-- block empty
		elseif errCode and self.accountNotice[errCode] then
			if not self.accountNotice[errCode][extraErrorCode] and self.accountNotice[errCode].JA then
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), self.accountNotice[errCode].JA)
			elseif not self.accountNotice[errCode][extraErrorCode] and self.accountNotice[errCode].TIPS then
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), self.accountNotice[errCode].TIPS)
			elseif self.accountNotice[errCode][extraErrorCode] and self.accountNotice[errCode][extraErrorCode].JA then
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), self.accountNotice[errCode][extraErrorCode].JA)
			elseif self.accountNotice[errCode][extraErrorCode] and self.accountNotice[errCode][extraErrorCode].TIPS then
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), self.accountNotice[errCode][extraErrorCode].TIPS)
			else
				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), errData.message)
			end
		else
			MsgManager.notice(string.format(Lang.get(45083), errCode, extraErrorCode))
		end
	end
end

function SDKImpByted:isIgnoreNotice(errCode, extraErrorCode)
	if self.isOldVersion then
		if self.ignoreNotice[errCode] then
			return true
		end
	elseif not extraErrorCode then
		if self.ignoreNotice[errCode] then
			return true
		end
	elseif self.ignoreNotice[errCode] and self.ignoreNotice[errCode][extraErrorCode] then
		return true
	end

	return false
end

function SDKImpByted:giftPack(data)
	if VersionUtils.isOldVersionSDK_jp() then
		if data[AttName.RESULT] == "1" then
			local code = tonumber(data.code)

			if code == 0 then
				MsgManager.notice("シリアルコードの入力が成功しました。")

				local gfPanel = UIManager.tryGetUI("giftExchangeDlg")

				if gfPanel then
					gfPanel:onClickCancel()
				end
			elseif code == 100 or code == 101 then
				MsgManager.notice("このシリアルコードはすでに登録されています。")
			elseif code == 102 or code == 103 or code == 104 then
				MsgManager.notice("無効または失効シリアルコードです。")
			else
				MsgManager.notice("シリアルコードの認証に失敗しました。Code = " .. code)
			end
		end
	elseif data[AttName.RESULT] == "1" then
		MsgManager.notice("シリアルコードの入力が成功しました。")

		local gfPanel = UIManager.tryGetUI("giftExchangeDlg")

		if gfPanel then
			gfPanel:onClickCancel()
		end
	else
		local code = tonumber(data.code)

		if code == -400006 or code == -400007 then
			MsgManager.notice("このシリアルコードはすでに登録されています。")
		elseif code == -400008 or code == -400009 or code == -400010 then
			MsgManager.notice("無効または失効シリアルコードです。")
		else
			MsgManager.notice("シリアルコードの認証に失敗しました。Code = " .. code)
		end
	end
end

function SDKImpByted:CloseSpinner()
	local spinner = UIManager.tryGetUI("loginSpinner")

	if spinner then
		spinner:setVisible(false)
	end
end

function SDKImpByted:isEmulator()
	if DeviceHelper.isAndroid() then
		ChannelUtil.doAnyFunction("sdkIsEmulator", {})
	end
end

function SDKImpByted:onEmulatorResult(data)
	if data[AttName.RESULT] == "1" then
		if not IS_PUBLISH_VERSION then
			MsgManager.notice("onEmulatorResult succ, result:" .. data.jp_emluator)
		end
	elseif not IS_PUBLISH_VERSION then
		MsgManager.notice("onEmulatorResult fail")
	end
end

function SDKImpByted:_replaceDMMText()
	if ChannelUtil.isDMMGame() then
		local ResItem = require("ClientData/ResItem")
		local ResInfoNotice = require("ClientData/ResInfoNotice")
		local ResAchieve = require("ClientData/ResAchieve")
		local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
		local ResGiftDrawDetail = require("ClientData/ResGiftDrawDetail")

		ResItem[510022].desc = utils.replaceString(ResItem[510022].desc, Lang.get(78291), "pt")
		ResItem[100020].desc = "接続不良によりあなたは重複購入しました。重複した分は補償金券として返還します\n次回FULIで購入する際に、この補償金券をご利用ください（補償分で充足する場合）。\nご迷惑をお掛けして誠に申し訳ございません。ご不明点はFULIカスタマーサービスにお問い合わせください"
		ResInfoNotice[38].content = utils.replaceString(ResInfoNotice[38].content, Lang.get(78291), "pt")
		ResInfoNotice[427].content = utils.replaceString(ResInfoNotice[427].content, Lang.get(78291), "pt")
		ResInfoNotice[431].content = utils.replaceString(ResInfoNotice[431].content, Lang.get(78291), "pt")
		ResAchieve[1971].action_desc = utils.replaceString(ResAchieve[1971].action_desc, Lang.get(78291), "pt")
		ResOpActivityAchieveDetail[9204][30][1].desc_name = utils.replaceString(ResOpActivityAchieveDetail[9204][30][1].desc_name, Lang.get(78291), "pt")
		ResOpActivityAchieveDetail[9404][30][1].desc_name = utils.replaceString(ResOpActivityAchieveDetail[9404][30][1].desc_name, Lang.get(78291), "pt")
		ResGiftDrawDetail[41001][1].price_level = utils.replaceString(ResGiftDrawDetail[41001][1].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41001][2].price_level = utils.replaceString(ResGiftDrawDetail[41001][2].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41001][3].price_level = utils.replaceString(ResGiftDrawDetail[41001][3].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41001][4].price_level = utils.replaceString(ResGiftDrawDetail[41001][4].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41002][1].price_level = utils.replaceString(ResGiftDrawDetail[41002][1].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41002][2].price_level = utils.replaceString(ResGiftDrawDetail[41002][2].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41002][3].price_level = utils.replaceString(ResGiftDrawDetail[41002][3].price_level, Lang.get(78291), "pt")
		ResGiftDrawDetail[41002][4].price_level = utils.replaceString(ResGiftDrawDetail[41002][4].price_level, Lang.get(78291), "pt")
	end
end

function SDKImpByted:hideSpecialChannelMallSubPanel(...)
	local logicChannelName = ChannelUtil.getLogicChannelName()

	if ResChannelHideActivityConfig[logicChannelName] then
		for _, id in ipairs(ResChannelHideActivityConfig[logicChannelName].hide_mall_subpanel_id or {}) do
			for tabId, tabInfo in pairs(ResMall) do
				for index, subId in ipairs(tabInfo.contents or {}) do
					if subId == id then
						table.remove(tabInfo.contents, index)
					end
				end
			end
		end
	end
end

return SDKImpByted
