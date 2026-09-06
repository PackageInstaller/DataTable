-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin1View.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin1View", package.seeall)

local ExteriorSkin1View = class("ExteriorSkin1View", ViewComponent)

function ExteriorSkin1View:ctor()
	ExteriorSkin1View.super.ctor(self)
end

function ExteriorSkin1View:unbindEvents()
	ExteriorSkin1View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeButton, self)
	self:rmAllClickEvent()

	if self.btnDressShop then
		GameUtil.rmClickHandler(self.btnDressShop, self)
	end
end

function ExteriorSkin1View:bindEvents()
	ExteriorSkin1View.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeButton, self._onClickClose, self)
	self:addClickEvent(self._btnInfo, function()
		self:_OnClickAnyFunc(ViewName.CardInfoStackView)
	end)
	self:addClickEvent(self._btnTitle, function()
		self:_OnClickAnyFunc(ViewName.TitleView)
	end)
	self:addClickEvent(self._btnCloth, function()
		self:_OnClickAnyFunc(ViewName.DressshowView)
	end)
	self:addClickEvent(self._btnSkin, function()
		self:_OnClickAnyFunc(ViewName.PetskinpreView)
	end)
	self:addClickEvent(self._btnExterior, function()
		self:_OnClickAnyFunc(ViewName.ExteriorView)
	end)
	self:addClickEvent(self._btnSticker, function()
		self:_OnClickAnyFunc(ViewName.ImpressionStickersView)
	end)
	self:addClickEvent(self.btnQuit, function()
		BootstrapLauncher.instance:applicationQuit()
	end)
	self:addClickEvent(self.btnSetting, function()
		UIStateManager.instance:open(ViewName.SystemSetting)
	end)
	self:addClickEvent(self.btnBind, function()
		self:_onClickBind()
	end)
	self.addClickEvent(self, self.btnDressShop, function()
		self:_onClickDressShop()
	end, self)
	self.addClickEvent(self, self.btnName, self.onClickUpgradeAccount, self)
	self.addClickEvent(self, self.btnName2, self.onClickHasUpgrade, self)
	self.addClickEvent(self, self.btnSexChange, self.onClickSexChange, self)
	self.addClickEvent(self, self.btnFlower, self.onClickSendFlower, self)

	if self._Btn_Share then
		self:addClickEvent(self._Btn_Share, function()
			ShareController.instance:share(1, {
				self._Btn_Share.gameObject
			}, nil, 200288)
		end)
	end

	if self.btnDressShop then
		GameUtil.addClickHandler(self.btnDressShop, self._onClickDressShop, self)
	end
end

function ExteriorSkin1View:buildUI()
	ExteriorSkin1View.super.buildUI(self)

	self._closeButton = goutil.findChildButtonComponent(self.mainGO, "Btn_Close")

	local _Nego_Right = goutil.findChild(self.mainGO, "Nego_Right")

	self._Btn_Share = goutil.findChild(self.mainGO, "Btn_Share")
	self._nodeNego_Left = goutil.findChild(self.mainGO, "Nego_Left")
	self.btnQuit = goutil.findChild(self.mainGO, "Nego_Left/btnQuit")
	self.btnSetting = goutil.findChild(self.mainGO, "Nego_Left/btnSetting")
	self.btnSettingRed = goutil.findChild(self.mainGO, "Nego_Left/btnSetting/imgRed")
	self.btnName = goutil.findChild(self.mainGO, "Nego_Left/btnName")
	self.btnName2 = goutil.findChild(self.mainGO, "Nego_Left/btnName2")
	self.btnBind = goutil.findChild(self.mainGO, "Nego_Left/btnBind")
	self.btnSexChange = goutil.findChild(self.mainGO, "Nego_Left/btnSexChange")
	self.btnFlower = goutil.findChild(self.mainGO, "Nego_Left/btnFlower")

	local _Nego_Func = goutil.findChild(_Nego_Right, "Nego_Func")

	self._btnInfo = goutil.findChild(_Nego_Func, "Btn_Info")
	self._btnTitle = goutil.findChild(_Nego_Func, "Btn_Title")
	self._btnCloth = goutil.findChild(_Nego_Func, "Btn_Cloth")
	self._btnSkin = goutil.findChild(_Nego_Func, "Btn_Skin")
	self._btnExterior = goutil.findChild(_Nego_Func, "Btn_Exterior")
	self._btnSticker = goutil.findChild(_Nego_Func, "Btn_Sticker")
	self.goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self.btnDressShop = goutil.findChild(self.mainGO, "Nego_Left/btnDressShop")
	self.dressShopLock = goutil.findChild(self.mainGO, "Nego_Left/btnDressShop/imgLock")
	self.dressShopRed = self:getGo("Nego_Left/btnDressShop/redPoint")
	self._Container = self:getGo("Container")
	self._goTitleRepoint = self:getGo("Nego_Right/Nego_Func/Btn_Title/imgRedpoint")
end

function ExteriorSkin1View:onExit()
	ExteriorSkin1View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FENGKONG_GET_INFO, self._updateFengkong, self)
	MaterialMgr.resetAll(self._shareProxy)

	if not goutil.isNil(self._curFunc) then
		self:_setSelectedInUI(self._curFunc, false)
	end

	self._curFunc = nil

	RedPointController.instance:unregRedPoint(self.btnSettingRed)
end

function ExteriorSkin1View:_updateRedpoint()
	if self._goTitleRepoint then
		self._goTitleRepoint:SetActive(TitleModel.instance:getRedActiveTotal())
	end
end

function ExteriorSkin1View:onEnter()
	ExteriorSkin1View.super.onEnter(self)
	GlobalDispatcher:removeListener(GlobalNotify.FENGKONG_GET_INFO, self._updateFengkong, self)
	self.addGEvent(self, GlobalNotify.RedPointUpdate, self._updateRedpoint, self)

	local params = self:getOpenParam() or {}

	self._avatar = params[1]

	local stackName = params[2]

	self._tabId = params[3]

	self:initData()
	GameUtil.SetActive(self.btnName, false)
	GameUtil.SetActive(self.btnName2, false)

	if not Framework.OSDef.isEditor then
		local btplatformId = BootstrapUtil.getPlatformId()

		if btplatformId == 2 or btplatformId == 10 then
			local needUpgrade = AntiAddictionController.instance:checkNeedUpgrade()

			GameUtil.SetActive(self.btnName2, not needUpgrade)
			GameUtil.SetActive(self.btnName, needUpgrade)
		end
	end

	local currViewName = ExteriorController.instance:getCurrOpenViewName()

	if not string.nilorempty(currViewName) then
		stackName = currViewName
	end

	if not string.nilorempty(stackName) then
		self:_initFuncState(stackName)
		self:_OnClickAnyFunc(stackName)
	else
		self:_initFuncState(ViewName.CardInfoStackView)
		self:_OnClickAnyFunc(ViewName.CardInfoStackView)
	end

	if self._Btn_Share then
		local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._Btn_Share.gameObject, "bubble"))

		self._shareProxy = MaterialMgr.setCellByCfg(prize, goutil.findChild(self._Btn_Share.gameObject, "bubble/reward"))
	end

	self:_updateFengkong()
	RedPointController.instance:regRedPoint(self.btnSettingRed, RedPointModel.ID_FEEDBACK, RedPointModel.ID_First_GameSetViewSharetask, RedPointModel.ID_First_GameSetViewFormBond)
	GameUtil.SetActive(self.btnBind, false)

	if BootstrapPjaqGameConfigMgr.isReview then
		GameUtil.SetActive(self._btnSkin, false)
	end

	RoleController.instance:addClockListener()
	goutil.setActive(self.btnSexChange, FuncOpenModel.instance:getFuncIsOpen(305))
	self:_updateRedpoint()
end

function ExteriorSkin1View:addClickEvent(go, handler, handlerObj)
	self.btnList = self.btnList or {}

	if go then
		local btn = GameUtil.asBtn(go)

		btn:AddClickListener(handler, handlerObj)
		table.insert(self.btnList, btn)
	end
end

function ExteriorSkin1View:rmAllClickEvent()
	for i, btn in ipairs(self.btnList) do
		btn:RemoveClickListener()
	end

	self.btnList = nil
end

function ExteriorSkin1View:initData()
	self.STACK_LIST = {
		[ViewName.CardInfoStackView] = self._btnInfo,
		[ViewName.TitleView] = self._btnTitle,
		[ViewName.DressshowView] = self._btnCloth,
		[ViewName.PetskinpreView] = self._btnSkin,
		[ViewName.ExteriorView] = self._btnExterior,
		[ViewName.ImpressionStickersView] = self._btnSticker
	}
end

function ExteriorSkin1View:_updateFengkong()
	if not Framework.OSDef.isEditor then
		local btplatformId = BootstrapUtil.getPlatformId()

		if btplatformId == 2 or btplatformId == 10 then
			local needUpgrade = AntiAddictionController.instance:checkNeedUpgrade()

			GameUtil.SetActive(self.btnName, needUpgrade)
			GameUtil.SetActive(self.btnName2, not needUpgrade)
		end
	end
end

function ExteriorSkin1View:_initFuncState(name)
	local btn = self.STACK_LIST[name]

	self:_setSelectedInUI(self._btnInfo, btn == self._btnInfo)
	self:_setSelectedInUI(self._btnTitle, btn == self._btnTitle)
	self:_setSelectedInUI(self._btnCloth, btn == self._btnCloth)
	self:_setSelectedInUI(self._btnSkin, btn == self._btnSkin)
	self:_setSelectedInUI(self._btnExterior, btn == self._btnExterior)
end

function ExteriorSkin1View:_showDrawTab(avatar)
	self._avatar = avatar

	if self._viewParams and self._viewParams[2] then
		local tabId = self._viewParams[2]

		self:showTabAt(self._Container, ViewName.DressshowView, self._avatar, tabId)
	else
		self:showTabAt(self._Container, ViewName.DressshowView, self._avatar)
	end
end

function ExteriorSkin1View:_setSelectedInUI(mainGo, isSelected)
	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
end

function ExteriorSkin1View:_OnClickAnyFunc(name)
	if name == nil then
		FloatWordMgr.instance:show(ConstString.NotRelease)

		return
	end

	ExteriorController.instance:setCurrOpenViewName(name)
	GlobalDispatcher:dispatch(GlobalNotify.CardInfoUpdate, name)

	if name == ViewName.PetskinpreView then
		local userId

		UIStateManager.instance:push(name, (RoleModel.instance.curCardInfo.userId ~= RoleModel.instance:getUserId() or nil) and RoleModel.instance.curCardInfo.userId)
		ExteriorController.instance:setCurrOpenViewName(nil)
		ExteriorController.instance:setCurrExteriorSelectId(nil)

		return
	end

	local btn = self.STACK_LIST[name]

	if self._curFunc == btn then
		return
	end

	if not goutil.isNil(self._curFunc) then
		self:_setSelectedInUI(self._curFunc, false)
	end

	self._curFunc = btn

	self:_setSelectedInUI(self._curFunc, true)
	goutil.setActive(self._Btn_Share, true)

	if name == ViewName.DressshowView then
		local tabId = self._tabId

		if tabId then
			self:showTabAt(self._Container, ViewName.DressshowView, self._avatar, tabId)
		else
			self:showTabAt(self._Container, ViewName.DressshowView, self._avatar)
		end

		goutil.setActive(self._nodeNego_Left, true)
	elseif name == ViewName.ExteriorView or name == ViewName.OtherExteriorView then
		goutil.setActive(self._Btn_Share, false)
		goutil.setActive(self._nodeNego_Left, false)

		if RoleModel.instance.curCardInfo.userId ~= RoleModel.instance:getUserId() then
			self:showTabAt(self._Container, name, RoleModel.instance.curCardInfo.userId)

			return
		end
	elseif name == ViewName.ImpressionStickersView then
		goutil.setActive(self._nodeNego_Left, false)

		if RoleModel.instance.curCardInfo.userId ~= RoleModel.instance:getUserId() then
			self:showTabAt(self._Container, name, RoleModel.instance.curCardInfo.userId)

			return
		end
	else
		goutil.setActive(self._nodeNego_Left, true)
	end

	self:showTabAt(self._Container, name)
end

function ExteriorSkin1View:_onClickClose()
	if self._isLoadingSpine then
		return
	end

	ExteriorController.instance:setCurrOpenViewName(nil)
	ExteriorController.instance:setCurrExteriorSelectId(nil)
	UIStateManager.instance:popByName(ViewName.MyCardView)
end

function ExteriorSkin1View:_onClickBind()
	local url = "http://account.100bt.com/gameBind/index.html"

	UnityWebBridge.registerGetActionListener(function(result)
		UnityWebBridge.unregisterGetActionListener()

		local cb = result.callback
		local tar = result.target

		if tar == "userInfo" then
			local tb = {}

			tb.gameId = SDKManager.getGameId()
			tb.roleId = LoginModel.instance.userId

			UnityWebBridge.registerPostActionListener(function(res)
				UnityWebBridge.unregisterPostActionListener()
			end)
			UnityWebBridge.callbackWebView(cb, tb)
		end
	end)
	UnityWebBridge.openWebView(url, false)
end

function ExteriorSkin1View:_onClickDressShop()
	FloatWordMgr.instance:show(lang("敬请期待"))
end

function ExteriorSkin1View:onClickUpgradeAccount()
	AntiAddictionController.instance:gotoUpgradeAccount()
end

function ExteriorSkin1View:onClickHasUpgrade()
	if SDKManager.getGovAuthStatus() then
		FloatWordMgr.instance:show(lang("您已在本游戏实名"))
	else
		FloatWordMgr.instance:show("正在实名认证中")
	end
end

function ExteriorSkin1View:onClickSendFlower()
	self.curMo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

	SendFlowerController.instance:openCharmValueView(self.curMo)
end

function ExteriorSkin1View:onClickSexChange()
	local leftTime = RoleModel.instance:getNextTransformGenderTime() - ServerTime.now()

	if leftTime > 0 then
		FloatWordMgr.instance:show(langPara("还剩下%s才能再进行性别转换哦~", GameUtil.FormatTimeSymbol(leftTime)))

		return
	end

	UIStateManager.instance:push(ViewName.SexchangetipView)
end

return ExteriorSkin1View
