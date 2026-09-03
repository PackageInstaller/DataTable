-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/AlertMediator.lua

AlertMediator = class("AlertMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function AlertMediator:initialize()
	super.initialize(self)
end

function AlertMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function AlertMediator:onRemove()
	super.onRemove(self)
end

function AlertMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._cancelBtn = self:bindWidget("main.btn_cancel", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Cancle",
			func = bind1(self.onCancelClicked, self)
		}
	})
	self._sureBtn = self:bindWidget("main.btn_ok", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onOKClicked, self)
		}
	})
end

function AlertMediator:userInject()
	return
end

function AlertMediator:enterWithData(data)
	self._data = data

	self:setUi(data)
end

function AlertMediator:setUi(data)
	local var_7_0 = bindWidget
	local var_7_1 = self
	local var_7_2 = self._main:getChildByFullName("bg")
	local var_7_3 = PopupNormalWidget
	local var_7_4 = {}
	local var_7_5 = {
		clickAudio = "Se_Click_Close_2"
	}

	var_7_5.func = not self._data.noClose and bind1(self.onCloseClicked, self) or nil
	var_7_4.btnHandler = var_7_5
	var_7_4.title = data.title
	var_7_4.title1 = data.title1 or ""
	var_7_4.fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 45 or nil

	local tempNode = var_7_0(var_7_1, var_7_2, var_7_3, var_7_4)

	tempNode:getView():getChildByFullName("btn_close"):setVisible(not self._data.noClose)

	if not self._data.noClose then
		-- block empty
	end

	local desc = self._main:getChildByName("Text_desc1")

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

	self._cancelBtn:setVisible(false)
	self._sureBtn:setVisible(false)

	local btnShowCount = 0

	if data.cancelBtn then
		if data.cancelBtn.text then
			if data.cancelBtn.text1 then
				self._cancelBtn:setButtonName(data.cancelBtn.text, data.cancelBtn.text1)
			else
				self._cancelBtn:setButtonName(data.cancelBtn.text)
			end
		end

		self._cancelBtn:setVisible(true)

		btnShowCount = btnShowCount + 1
	end

	if data.sureBtn then
		if data.sureBtn.text then
			if data.sureBtn.text1 then
				self._sureBtn:setButtonName(data.sureBtn.text, data.sureBtn.text1)
			else
				self._sureBtn:setButtonName(data.sureBtn.text)
			end
		end

		self._sureBtn:setVisible(true)

		btnShowCount = btnShowCount + 1
	end

	if btnShowCount == 1 then
		local cancelBtn = self:getView():getChildByFullName("main.btn_cancel")
		local sureBtn = self:getView():getChildByFullName("main.btn_ok")

		sureBtn:setPositionX(567)
		cancelBtn:setPositionX(567)
	end
end

function AlertMediator:onCancelClicked(sender, eventType)
	self:close({
		response = AlertResponse.kCancel
	})
end

function AlertMediator:onOKClicked(sender, eventType)
	self:close({
		response = AlertResponse.kOK
	})
end

function AlertMediator:onCloseClicked(sender, eventType)
	self:close({
		response = AlertResponse.kClose
	})
end

function AlertMediator:willBeClosed(payload)
	if type(payload) ~= "table" then
		payload = {
			response = AlertResponse.kCancel
		}
	end

	super.willBeClosed(self, payload)
end

function AlertMediator:onTouchMaskLayer()
	if self._data.noClose then
		return
	end

	self:close({
		response = AlertResponse.kClose
	})
end
