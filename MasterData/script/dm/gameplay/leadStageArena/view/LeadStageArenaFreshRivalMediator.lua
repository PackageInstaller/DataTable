-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/leadStageArena/view/LeadStageArenaFreshRivalMediator.lua

LeadStageArenaFreshRivalMediator = class("LeadStageArenaFreshRivalMediator", DmPopupViewMediator, _M)

LeadStageArenaFreshRivalMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.checkBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCheck"
	}
}

function LeadStageArenaFreshRivalMediator:initialize()
	super.initialize(self)
end

function LeadStageArenaFreshRivalMediator:dispose()
	super.dispose(self)
end

function LeadStageArenaFreshRivalMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._sureBtn = self:bindWidget("main.sureBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})
	self._checkBtnImg = self._main:getChildByFullName("checkBtn.image")
end

function LeadStageArenaFreshRivalMediator:userInject()
	return
end

function LeadStageArenaFreshRivalMediator:enterWithData(data)
	local var_5_0 = self._main:getChildByFullName("bgNode")
	local var_5_1 = PopupNormalWidget
	local var_5_2 = {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = data.title
	}

	var_5_2.title1 = data.title1 or ""

	local widget = self:bindWidget(var_5_0, var_5_1, var_5_2)
	local desc = self._main:getChildByName("tipLabel")

	if data.isRich then
		if not data.content then
			local text = ""
			local textData = string.split(text, "<font")

			if #textData <= 1 then
				text = Strings:get("UPDATE_UI9", {
					text = text,
					fontName = TTF_FONT_FZYH_R
				})
			end

			local label = ccui.RichText:createWithXML(text, {})

			label:setAnchorPoint(cc.p(0.5, 0.5))
			label:setVerticalSpace(5)
			label:rebuildElements(true)
			label:formatText()

			if label:getContentSize().width > 670 then
				label:renderContent(670, 0)
			end

			desc:setVisible(false)
			label:addTo(self._main):setPosition(desc:getPosition()):offset(0, 5)
		end
	else
		desc:setString(data.content)
		desc:getVirtualRenderer():setLineHeight(35)
	end

	self._sureBtn:setButtonName(data.buttonText, data.buttonText1)

	local playerId = self:getDevelopSystem():getPlayer():getRid()
	local openServerDay = self._developSystem:getServerOpenDay()
	local showDay = cc.UserDefault:getInstance():getStringForKey(playerId .. UserDefaultKey.KLeadStageAreanaTishiState, "0-0")
	local strTab = string.split(showDay, "-")
	local isOpen = tonumber(strTab[1])
	local openDay = tonumber(strTab[2])

	if openDay ~= openServerDay then
		self._checkBtnImg:setVisible(false)
	else
		self._checkBtnImg:setVisible(isOpen == 1 and true or false)
	end

	self._isClicked = false
end

function LeadStageArenaFreshRivalMediator:onClickCheck(sender, eventType)
	self._isClicked = true

	local isVisible = self._checkBtnImg:isVisible()

	self._checkBtnImg:setVisible(not isVisible)
end

function LeadStageArenaFreshRivalMediator:onOKClicked(sender, eventType)
	if self._isClicked then
		local playerId = self:getDevelopSystem():getPlayer():getRid()
		local str1 = self._checkBtnImg:isVisible() and 1 or 0
		local openServerDay = self._developSystem:getServerOpenDay()

		cc.UserDefault:getInstance():setStringForKey(playerId .. UserDefaultKey.KLeadStageAreanaTishiState, str1 .. "-" .. openServerDay)
	end

	self:close({
		response = AlertResponse.kOK
	})
end

function LeadStageArenaFreshRivalMediator:onCloseClicked(sender, eventType)
	self:close({
		response = AlertResponse.kClose
	})
end

function LeadStageArenaFreshRivalMediator:willBeClosed(payload)
	if type(payload) ~= "table" then
		payload = {
			response = AlertResponse.kCancel
		}
	end

	super.willBeClosed(self, payload)
end

function LeadStageArenaFreshRivalMediator:onTouchMaskLayer()
	self:close({
		response = AlertResponse.kClose
	})
end
