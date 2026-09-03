-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recharge/view/FirstRechargeMediator.lua

FirstRechargeMediator = class("FirstRechargeMediator", DmPopupViewMediator, _M)

FirstRechargeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
FirstRechargeMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
FirstRechargeMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local kBtnHandlers = {
	["main.button_info"] = "onClickHeroInfo",
	["main.btn_back"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickBack"
	}
}
local _tab = {}

function FirstRechargeMediator:initialize()
	super.initialize(self)
end

function FirstRechargeMediator:dispose()
	AudioEngine:getInstance():stopEffect(self._soundId)
	super.dispose(self)
end

function FirstRechargeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._player = self._developSystem:getPlayer()
	self._rechargeInfo = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Charge_Activity", "content")
	_tab = {}

	for k, v in pairs(self._rechargeInfo) do
		_tab[#_tab + 1] = k
	end

	table.sort(_tab, function(a, b)
		return tonumber(a) < tonumber(b)
	end)
end

function FirstRechargeMediator:onTouchMaskLayer()
	return
end

function FirstRechargeMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DIAMOND_RECHARGE_SUCC, self, self.refreshBtnView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_MONTHCARD_SUCC, self, self.refreshBtnView)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshBtnView)
end

function FirstRechargeMediator:enterWithData(data)
	self._heroId = "ZZBBWei"

	self:mapEventListeners()

	self._soundId = AudioEngine:getInstance():playRoleEffect("Voice_ZZBBWei_01", false)

	self:setupView()

	local rechargeState = self._player:getFirstRecharge()

	if rechargeState == 2 then
		self:refreshView()
	else
		self:refreshBtnView()
	end

	self:initAnim()
end

function FirstRechargeMediator:setupView()
	local view = self:getView()

	self._main = view:getChildByName("main")
	self._btnMain = self._main:getChildByName("btn_main")

	local buttonNameStr = self._btnMain:getChildByFullName("name")

	buttonNameStr:setPositionX(buttonNameStr:getPositionX() + 3)

	local textCv = self._main:getChildByName("textCv")

	textCv:setOpacity(0)
	textCv:setAdditionalKerning(4)

	self._title = self._main:getChildByName("decs")
	self._heroName = self._main:getChildByName("heroName")
	self._hero = IconFactory:createRoleIconSpriteNew({
		id = "Model_ZZBBWei",
		useAnim = true,
		frameId = "bustframe9"
	})

	local heroName = ConfigReader:getDataByNameIdAndKey("HeroBase", "ZZBBWei", "Name")

	self._heroName:setString(Strings:get(heroName))

	local anim = RoleFactory:createHeroAnimation("Model_ZZBBWei")

	anim:setScale(-0.7, 0.7)
	anim:setPosition(cc.p(5, -72))

	self._anim = anim
	self._rewardPanel = self._main:getChildByName("rewardPanel")

	local rewardId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "FirstChargeReward", "content")
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	if rewards then
		for i = 1, #rewards do
			local iconBg = self._rewardPanel:getChildByName("icon" .. i)
			local reward = rewards[i]

			if iconBg and reward then
				local icon = IconFactory:createRewardIcon(reward, {
					isWidget = true
				})

				icon:addTo(iconBg):center(iconBg:getContentSize())
				icon:setScaleNotCascade(0.8)
				IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
					needDelay = true
				})
				iconBg:setOpacity(0)
				iconBg:setScale(0.6)
			end
		end
	end

	self._text1 = ccui.ImageView:create("firstcharge_txt_04.png", ccui.TextureResType.plistType)
	self._text2 = ccui.ImageView:create("firstcharge_txt_03.png", ccui.TextureResType.plistType)
	self._bottomText = Strings:get("FirstCharge_Tips4")
end

function FirstRechargeMediator:initAnim()
	local mcPanel = self:getView():getChildByName("mcPanel")
	local mc = cc.MovieClip:create("cccccccccc_shouchong")

	mc:setPlaySpeed(1.6)
	mc:addTo(mcPanel)
	mc:center(cc.size(200, 200))
	mc:addCallbackAtFrame(95, function()
		mc:stop()
	end)

	for i = 1, 4 do
		mc:addCallbackAtFrame(12 + i * 1, function()
			local index = 5 - i
			local _icon = self._rewardPanel:getChildByName("icon" .. index)

			_icon:runAction(cc.Spawn:create(cc.FadeIn:create(0.22), cc.ScaleTo:create(0.22, 1)))
		end)
	end

	mc:addCallbackAtFrame(51, function()
		local childMc = mc:getChildByName("bottomText")
		local textPanel = childMc:getChildByName("textInstance")
		local Text = ccui.Text:create(self._bottomText, TTF_FONT_FZYH_R, 18)

		Text:setColor(cc.c3b(255, 255, 235))
		Text:enableOutline(cc.c4b(0, 0, 0, 219), 1)
		textPanel:addChild(Text)
		childMc:addCallbackAtFrame(20, function()
			childMc:stop()
		end)
	end)

	local titleMcPanel = mc:getChildByName("title")

	self._title:changeParent(titleMcPanel)
	self._title:setPosition(cc.p(-115, 3))

	local heroNamePanel = mc:getChildByName("giftHeroName")

	self._heroName:changeParent(heroNamePanel)
	self._heroName:setPosition(cc.p(-5, 2))

	local heroInstance = mc:getChildByName("heroInstance")

	self._hero:addTo(heroInstance)
	self._hero:setPosition(cc.p(-20, -100))

	local text1McPanel = mc:getChildByName("text1")

	self._text1:addTo(text1McPanel)

	local text2McPanel = mc:getChildByName("text2")

	if self._text2 then
		self._text2:addTo(text2McPanel)
	end

	local buttonMcPanel = mc:getChildByName("button")

	self._btnMain:changeParent(buttonMcPanel)
	self._btnMain:setPosition(cc.p(0, 23))

	local spanHeroPanel = mc:getChildByName("span")

	spanHeroPanel:removeAllChildren()
	self._anim:addTo(spanHeroPanel)

	local textCv = self._main:getChildByName("textCv")

	textCv:runAction(cc.FadeIn:create(0.75))

	local text1 = self._main:getChildByName("testState1")
	local text2 = self._main:getChildByName("testState2")

	text1:setOpacity(0)
	text2:setOpacity(0)
	text1:runAction(cc.FadeIn:create(0.75))
	text2:runAction(cc.FadeIn:create(0.75))

	self._mc = mc

	local rarityAnim = IconFactory:getHeroRarityAnim(15)

	rarityAnim:addTo(heroNamePanel)
	rarityAnim:setPosition(cc.p(160, 0))
end

function FirstRechargeMediator:refreshView()
	self:refreshBtnView()

	local rewardInfo = self._rechargeInfo[tostring(self._accState)]
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardInfo, "Content")
	local parent = self._anim:getParent()
	local text1 = self._main:getChildByName("testState1")
	local text2 = self._main:getChildByName("testState2")

	if self._accState == 580 then
		self._text1:loadTexture("firstcharge_txt_01.png", ccui.TextureResType.plistType)
		self._text2:setVisible(false)
		self._title:setString(Strings:get("Acc_Recharge_580"))
		text1:setVisible(true)
		text2:setVisible(false)

		self._anim = IconFactory:createEquipPic({
			star = 2,
			id = rewards[1].code
		})

		self._anim:setScale(0.9)
		self._anim:setPosition(cc.p(0, 0))
	elseif self._accState == 1280 then
		self._text1:loadTexture("firstcharge_txt_05.png", ccui.TextureResType.plistType)
		self._text2:setVisible(true)
		self._text2:loadTexture("firstcharge_txt_02.png", ccui.TextureResType.plistType)
		self._title:setString(Strings:get("Acc_Recharge_1280"))
		text1:setVisible(false)
		text2:setVisible(true)

		local anim = RoleFactory:createHeroAnimation("Model_ZZBBWei")

		anim:setScale(-0.7, 0.7)
		anim:setPosition(cc.p(0, -50))

		self._anim = anim
	end

	if parent then
		parent:removeAllChildren()
		self._anim:addTo(parent)
	end

	for i = 1, #rewards do
		local iconBg = self._rewardPanel:getChildByName("icon" .. i)

		iconBg:removeAllChildren()

		local reward = rewards[i]

		if iconBg and reward then
			local icon = IconFactory:createRewardIcon(reward, {
				isWidget = true
			})

			icon:setScaleNotCascade(0.8)
			icon:addTo(iconBg):center(iconBg:getContentSize())
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
				needDelay = true
			})
		end
	end
end

function FirstRechargeMediator:refreshBtnView()
	local rechargeState = self._player:getFirstRecharge()
	local button = self._btnMain:getChildByName("button")
	local buttonText = self._btnMain:getChildByName("name")
	local callFunc, buttonTextStr

	if rechargeState == 0 then
		function callFunc(sender, eventType)
			self:onClickRecharge()
		end

		buttonTextStr = Strings:get("FirstCharge_Desc6")
	elseif rechargeState == 1 then
		function callFunc(sender, eventType)
			self:onClickGet(1)
		end

		buttonTextStr = Strings:get("Sc_Tips_1")
	elseif rechargeState == 2 then
		callFunc, buttonTextStr = self:dealAccRecharge()
	end

	mapButtonHandlerClick(nil, button, {
		func = callFunc
	})
	buttonText:setString(buttonTextStr)
end

function FirstRechargeMediator:dealAccRecharge()
	local _callFunc, _str

	function _callFunc()
		return
	end

	_str = Strings:get("Acc_Recharge_Finish")
	self._bottomText = Strings:get("Acc_Recharge_Finish")
	self._accState = 1280

	local accRechargeState = self._rechargeAndVipSystem:getRechargeAndVipModel()
	local rechargeHistory = accRechargeState:getRechargeHistory()
	local rechargeRewards = self._player:getRechargeRewards()

	for _, v in ipairs(_tab) do
		if rechargeHistory >= tonumber(v) then
			if not table.keyof(rechargeRewards, v) then
				function _callFunc()
					self:onClickGet(v)
				end

				_str = Strings:get("Sc_Tips_1")
				self._accState = tonumber(v)

				break
			end
		else
			function _callFunc()
				self:onClickRecharge()
			end

			_str = Strings:get("FirstCharge_Desc6")
			self._bottomText = Strings:get("FirstCharge_Req_Amount", {
				num = math.ceil((tonumber(v) - rechargeHistory) / 10)
			})
			self._accState = tonumber(v)

			break
		end
	end

	return _callFunc, _str
end

function FirstRechargeMediator:onGetRewardCallback(rewardData)
	local playerGotReward = self:getDevelopSystem():getPlayer():getRechargeRewards()

	if table.nums(playerGotReward) == table.nums(self._rechargeInfo) then
		self:dispatch(Event:new(EVT_CHARGETASK_FIN))
	end

	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewardData
	}))
end

function FirstRechargeMediator:onClickGet(chargeNum)
	if chargeNum == 1 then
		self._rechargeAndVipSystem:requestGetFirstRechargeReward(function(resData)
			self:refreshView()
			self:onGetRewardCallback(resData)
		end)
	else
		for k, v in pairs(self._rechargeInfo) do
			if tonumber(k) == tonumber(chargeNum) then
				self._rechargeAndVipSystem:requestGetAccRechargeReward(tonumber(chargeNum), function(resData)
					self:refreshView()
					self:onGetRewardCallback(resData)
				end)

				break
			end
		end
	end
end

function FirstRechargeMediator:onClickRecharge()
	local activitySystem = self:getInjector():getInstance(ActivitySystem)

	activitySystem:tryEnter({
		id = "__MonthCard__"
	})
end

function FirstRechargeMediator:onClickHeroInfo(sender, eventType)
	local view = self:getInjector():getInstance("HeroShowNotOwnView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, delegate, {
		hideLeftPanel = true,
		id = self._heroId
	}))
end

function FirstRechargeMediator:onClickMonthCard()
	local activitySystem = self:getInjector():getInstance("ActivitySystem")

	activitySystem:tryEnter({
		id = "MonthCard"
	})
end

function FirstRechargeMediator:onClickBack(sender, eventType)
	self:close()
end
