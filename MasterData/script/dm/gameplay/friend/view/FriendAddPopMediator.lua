-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendAddPopMediator.lua

FriendAddPopMediator = class("FriendAddPopMediator", DmPopupViewMediator, _M)

FriendAddPopMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
FriendAddPopMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function FriendAddPopMediator:initialize()
	super.initialize(self)
end

function FriendAddPopMediator:dispose()
	super.dispose(self)
end

function FriendAddPopMediator:onRemove()
	super.onRemove(self)
end

function FriendAddPopMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")

	self:mapButtonHandlerClick("main.btnNode.button", {
		clickAudio = "Se_Click_Common_1",
		func = "onApplyClicked"
	})
	self:bindWidget("main.btnNode", OneLevelViceButton, {})
end

function FriendAddPopMediator:userInject()
	return
end

function FriendAddPopMediator:enterWithData(data)
	self._data = data
	self._player = self._developSystem:getPlayer()

	self:mapEventListeners()
	self:initPopupCommonWidgets()
	self:setupView()
	self:setTextField()
end

function FriendAddPopMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FRIEND_ADD_SUCC, self, self.onApplySuccCallback)
end

function FriendAddPopMediator:onApplySuccCallback(event)
	self:getEventDispatcher():dispatchEvent(ShowTipEvent({
		tip = Strings:get("Friend_UI15")
	}))
	self:close()
end

function FriendAddPopMediator:initPopupCommonWidgets()
	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Friend_UI30"),
		title1 = Strings:get("UITitle_EN_Haoyoushenqing"),
		bgSize = cc.size(835, 478),
		fontSize = getCurrentLanguage() ~= GameLanguageType.CN and 40 or nil
	})
end

function FriendAddPopMediator:setupView()
	local headBg = self._main:getChildByName("headimg")

	headBg:removeAllChildren()

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		clipType = 4,
		headFrameScale = 0.4,
		id = self._data:getHeadId(),
		size = cc.size(74, 74),
		headFrameId = self._data:getHeadFrame()
	})

	oldIcon:setScale(0.4)
	headicon:addTo(headBg):center(headBg:getContentSize())

	local nameText = self._main:getChildByName("Text_name")

	nameText:setString(self._data:getNickName())
	nameText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local combatText = self._main:getChildByName("Text_combat")

	combatText:setString(self._data:getCombat())
	combatText:enableOutline(cc.c4b(0, 0, 0, 255), 1)

	local lineGradiantVec2 = {
		{
			ratio = 0.6,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	combatText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	if nameText:getContentSize().width > 115 then
		local shiftDis = nameText:getContentSize().width - 115
		local combatBg = self._main:getChildByName("combatBg")

		combatText:setPositionX(combatText:getPositionX() + shiftDis)
		combatBg:setPositionX(combatBg:getPositionX() + shiftDis)
	end

	local unionText = self._main:getChildByName("Text_union")

	unionText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	if self._data:getUnionName() == "" or self._data:getUnionName() == nil then
		unionText:setString(Strings:get("RelationText9"))
	else
		unionText:setString(Strings:get("Resource_SheTuan") .. ":" .. self._data:getUnionName())
	end

	local vipNode = self._main:getChildByName("vipnode")

	self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidget:new(vipNode))

	self._playerVipWidget:updateView(self._data:getVipLevel())
	vipNode:setPositionX(nameText:getPositionX() + nameText:getContentSize().width + 10)
	vipNode:setVisible(false)

	local levelText = self._main:getChildByName("Text_level")

	levelText:setString("Lv." .. self._data:getLevel())
	levelText:setLocalZOrder(10)
	levelText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function FriendAddPopMediator:setTextField()
	self._editBox = self._main:getChildByName("text_field")

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Friend_Apply_MaxWords", "content")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:setPlaceholderFontColor(cc.c4b(255, 255, 255, 170.85000000000002))
	self._editBox:getPlaceholderLabel():enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._editBox:getContentLabel():enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._editBox:setText(self._friendSystem:getRecommendMessage(self._data:getRecommendType(), self._data:getRecommendFactor()))
	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			self._editBox:setText("")
		elseif eventName == "ended" then
			self._oldStr = self._editBox:getText()
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			-- block empty
		elseif eventName == "ForbiddenWord" then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get("Common_Tip1")
			}))
		elseif eventName == "Exceed" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Tips_WordNumber_Limit", {
					number = maxLength
				})
			}))
		end
	end)
end

function FriendAddPopMediator:onCloseClicked(sender, eventType)
	self:close()
end

function FriendAddPopMediator:onApplyClicked(sender, eventType)
	local str = self._editBox:getText()

	self._friendSystem:requestAddFriend(self._data:getRid(), str)
end
