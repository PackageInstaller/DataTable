-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SettingCodeExcMediator.lua

SettingCodeExcMediator = class("SettingCodeExcMediator", DmPopupViewMediator, _M)

SettingCodeExcMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local btnHandlers = {
	["main.mStateBtn.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickok"
	}
}

function SettingCodeExcMediator:onRegister()
	self:mapButtonHandlersClick(btnHandlers)

	self._main = self:getView():getChildByName("main")
	self._editBox = self._main:getChildByName("TextField")

	super.onRegister(self)
end

function SettingCodeExcMediator:dispose()
	super.dispose(self)
end

function SettingCodeExcMediator:enterWithData()
	self:setupView()

	local bgNode = self:getView():getChildByFullName("main.bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.close, self)
		},
		title = Strings:get("Setting_ExWelfare_Title"),
		title1 = Strings:get("UITitle_EN_ExWelfare"),
		bgSize = {
			width = 690,
			height = 408
		}
	})

	self.btnWidget = self:bindWidget("main.mStateBtn", OneLevelViceButton, {})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_CODE_EXCHANGE_SUC, self, self.changeSuc)

	self._keyStr = ""
end

function SettingCodeExcMediator:setupView()
	local tipsText = self._main:getChildByName("placeholdText")
	local maxLength = 20

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, true)

	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			tipsText:setVisible(false)
		elseif eventName == "ended" then
			if self._editBox:getText() == "" then
				tipsText:setVisible(true)
			end
		elseif eventName == "return" then
			if self._editBox:getText() == "" then
				tipsText:setVisible(true)
			end
		elseif eventName == "changed" then
			self._keyStr = self._editBox:getText()
		elseif eventName == "ForbiddenWord" then
			-- block empty
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)
end

function SettingCodeExcMediator:onClickok()
	local btn = self:getView():getChildByFullName("main.mStateBtn.button")

	if btn._isColdTime then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Voice_HLDNan_30_SoundDesc")
		}))

		return
	end

	if self._keyStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Setting_Welfare_ERROR")
		}))
	else
		self.btnWidget:setTimeLimit(btn)
		self._settingSystem:requestWelfareCode(self._keyStr)
	end
end

function SettingCodeExcMediator:changeSuc()
	local tipsText = self._main:getChildByName("placeholdText")

	if self._editBox.setText then
		self._editBox:setText("")
		tipsText:setVisible(true)

		self._keyStr = ""
	end
end
