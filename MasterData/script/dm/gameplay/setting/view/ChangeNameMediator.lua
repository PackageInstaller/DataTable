-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/ChangeNameMediator.lua

ChangeNameMediator = class("ChangeNameMediator", DmPopupViewMediator, _M)

ChangeNameMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ChangeNameMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

local btnHandlers = {
	["main.touchPanel"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickDice"
	},
	["main.mStateBtn.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickok"
	}
}

function ChangeNameMediator:initialize()
	super.initialize(self)
end

function ChangeNameMediator:dispose()
	super.dispose(self)
end

function ChangeNameMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(btnHandlers)

	self._main = self:getView():getChildByName("main")
	self._editBox = self._main:getChildByName("TextField")

	self:mapEventListeners()
end

function ChangeNameMediator:onRemove()
	super.onRemove(self)
	self._settingSystem:setCurMediatorTag(nil)
end

function ChangeNameMediator:enterWithData(data)
	self._bagSystem = self._developSystem:getBagSystem()
	self._player = self._developSystem:getPlayer()

	self:setupView()

	local bgNode = self:getView():getChildByFullName("main.bg")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.close, self)
		},
		title = Strings:get("setting_ui14"),
		title1 = Strings:get("UITitle_EN_Xiugainicheng"),
		bgSize = {
			width = 690,
			height = 408
		},
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
	self:bindWidget("main.mStateBtn", OneLevelViceButton, {})
	self._settingSystem:setCurMediatorTag("ChangeNameMediator")
end

function ChangeNameMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGENAME_SUCC, self, self.close)
end

function ChangeNameMediator:setupView()
	local nameDi = self._main:getChildByName("Image_namedi")
	local pos = nameDi:convertToWorldSpace(cc.p(0, 0))

	nameDi.worldPositionY = pos.y

	nameDi:setTouchEnabled(true)
	nameDi:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._editBox:openKeyboard()
		end
	end)

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Name_MaxWords", "content")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.NAME)

	self._editBox:setText(self._player:getNickName())
	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			placeHolder = self._editBox:getPlaceHolder()
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._oldStr = self._editBox:getText()
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = sender:getMaxLength()
				})
			}))
		end
	end)

	local tips = self._main:getChildByName("Text_tips")
	local cost = self._main:getChildByFullName("Image_cost")
	local changeNameTimes = self._bagSystem:getTimeRecordById(TimeRecordType.kChangeName)._time

	if changeNameTimes < 2 then
		tips:setVisible(true)
		cost:setVisible(false)
	else
		tips:setVisible(false)
		cost:setVisible(true)

		local costText = cost:getChildByName("Text_cost")

		if self._bagSystem:getItemCount("IM_Name_Person") > 0 then
			cost:setVisible(false)

			local icon = IconFactory:createResourcePic({
				id = "IM_Name_Person"
			}, {})

			icon:setAnchorPoint(0.5, 0.5)
			icon:setPosition(cost:getPosition()):addTo(self._main)

			local size = icon:getContentSize()
			local text = costText:clone()

			text:setAnchorPoint(0, 0.5)
			text:addTo(icon):setPositionY(size.height * 0.5)
			text:setString("1")
			text:setPositionX(30 + size.width * 0.5)
		else
			local amount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_RenamePrice", "content")

			costText:setString(amount)

			if amount <= self._bagSystem:getDiamond() then
				costText:setTextColor(cc.c3b(255, 255, 255))
			else
				costText:setTextColor(cc.c3b(255, 0, 0))
			end
		end
	end
end

function ChangeNameMediator:onClickDice(sender, eventType)
	if self._editBox:getkeyboardState() then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local result, str = true, ""

	repeat
		str = self._settingSystem:getStrName()

		local var_10_0, var_10_1 = StringChecker.hasForbiddenWords(str, MaskWordType.NAME)

		str = var_10_1
	until not var_10_0

	self._editBox:setText(str)
end

function ChangeNameMediator:onClickok(sender, eventType)
	local nameStr = self._editBox:getText()

	if nameStr == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("setting_tips3")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local spaceCount = string.find(nameStr, "%s")

	if spaceCount ~= nil then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("setting_tips1")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if nameStr == self._developSystem:getPlayer():getNickName() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("setting_tips2")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local changeNameTimes = self._bagSystem:getTimeRecordById(TimeRecordType.kChangeName)._time
	local amount = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_RenamePrice", "content")

	if changeNameTimes < 2 or self._bagSystem:getItemCount("IM_Name_Person") > 0 or self._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, amount, {
		type = "tip"
	}) then
		AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
		self._settingSystem:requestChangePlayerName(nameStr)
	end
end
