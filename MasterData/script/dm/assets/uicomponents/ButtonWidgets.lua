-- chunkname: @/tmp/or_script/lua_compile/dm/assets/uicomponents/ButtonWidgets.lua

ButtonWidget = class("ButtonWidget", BaseWidget)

ButtonWidget:has("_button", {
	rw = ""
})

function ButtonWidget:initialize(view, data)
	super.initialize(self, view)

	self._button = view:getChildByName("button")
	self._nameText = view:getChildByName("name")
	self._nameText1 = view:getChildByName("name1")

	if data and data.btnSize then
		self._button:setContentSize(cc.size(data.btnSize.width, data.btnSize.height))
		self._nameText:setContentSize(cc.size(data.btnSize.width - 70, 40))
	end

	mapButtonHandlerClick(self, "button", data.handler)
end

function ButtonWidget:userInject(injector)
	return
end

function ButtonWidget:dispose()
	self._button = nil

	super.dispose(self)
end

CommonButtonWithName = class("CommonButtonWithName", ButtonWidget)

CommonButtonWithName:has("_nameText", {
	is = "r"
})
CommonButtonWithName:has("_nameText1", {
	is = "r"
})

function CommonButtonWithName:initialize(view, data)
	super.initialize(self, view, data)

	local component = view:getComponent("ComExtensionData")

	if component then
		local translateIds = component:getCustomProperty()

		translateIds = string.split(translateIds, "&")

		local buttonName = Strings:get(translateIds[1], data.nameStringEnv)
		local buttonName1 = Strings:get(translateIds[2], data.nameStringEnv)

		self:setButtonName(buttonName, buttonName1)
	end

	self:setButtonNameStyle()
end

function CommonButtonWithName:dispose()
	self._nameText = nil
	self._nameText1 = nil

	super.dispose(self)
end

function CommonButtonWithName:setTimeLimit(sender)
	sender._isColdTime = true

	local cDTime = 5
	local str = self._nameText:getString()

	self._nameText:setString(str .. "(" .. tostring(cDTime) .. ")")

	local action = schedule(sender, function()
		cDTime = cDTime - 1

		self._nameText:setString(str .. "(" .. tostring(cDTime) .. ")")

		if cDTime <= 0 then
			sender:stopActionByTag(66666)

			sender._isColdTime = false

			self._nameText:setString(str)
		end
	end, 1, 66666)
end

function CommonButtonWithName:setButtonName(buttonName, buttonName1)
	self._nameText:setString(buttonName)

	if self._nameText1 then
		self._nameText1:setString("")
	end
end

function CommonButtonWithName:setButtonClickName(buttonName)
	self._button:setName(buttonName)
end

function CommonButtonWithName:setGray(gray)
	if self._button then
		self._button:setGray(gray)
	end
end

function CommonButtonWithName:setButtonNameStyle()
	return
end

OneLevelMainButton = class("OneLevelMainButton", CommonButtonWithName)

function OneLevelMainButton:initialize(view, data)
	super.initialize(self, view, data)

	if data.showAnim then
		self:showAnim()
	end
end

function OneLevelMainButton:showAnim()
	local anim = cc.MovieClip:create("btn_xinchongzhi")

	anim:addTo(self:getButton()):setScale(1.2)
	anim:setPosition(cc.p(self:getButton():getContentSize().width / 2 - 2, self:getButton():getContentSize().height / 2 - 2))
end

function OneLevelMainButton.class:createWidgetNode()
	local resFile = "asset/ui/OneLevelMainButton.csb"

	return cc.CSLoader:createNode(resFile)
end

function OneLevelMainButton:setButtonNameStyle()
	if self._nameText1 then
		self._nameText1:enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	end
end

OneLevelViceButton = class("OneLevelViceButton", CommonButtonWithName)

function OneLevelViceButton:initialize(view, data)
	super.initialize(self, view, data)

	if data.showAnim then
		self:showAnim()
	end
end

function OneLevelViceButton:showAnim()
	local anim = cc.MovieClip:create("btn_xinchongzhi")

	anim:addTo(self:getButton()):setScale(1.2)
	anim:setPosition(cc.p(self:getButton():getContentSize().width / 2 - 2, self:getButton():getContentSize().height / 2 - 2))
end

function OneLevelViceButton.class:createWidgetNode()
	local resFile = "asset/ui/OneLevelViceButton.csb"

	return cc.CSLoader:createNode(resFile)
end

function OneLevelViceButton:setButtonNameStyle()
	if self._nameText1 then
		self._nameText1:enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	end
end

TwoLevelMainButton = class("TwoLevelMainButton", CommonButtonWithName)

function TwoLevelMainButton.class:createWidgetNode()
	local resFile = "asset/ui/TwoLevelMainButton.csb"

	return cc.CSLoader:createNode(resFile)
end

function TwoLevelMainButton:setButtonNameStyle()
	if self._nameText1 then
		self._nameText1:enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	end
end

TwoLevelViceButton = class("TwoLevelViceButton", CommonButtonWithName)

function TwoLevelViceButton.class:createWidgetNode()
	local resFile = "asset/ui/TwoLevelViceButton.csb"

	return cc.CSLoader:createNode(resFile)
end

function TwoLevelViceButton:setButtonNameStyle()
	if self._nameText1 then
		self._nameText1:enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	end
end

ThreeLevelMainButton = class("ThreeLevelMainButton", CommonButtonWithName)

function ThreeLevelMainButton.class:createWidgetNode()
	local resFile = "asset/ui/ThreeLevelMainButton.csb"

	return cc.CSLoader:createNode(resFile)
end

function ThreeLevelMainButton:setButtonNameStyle()
	return
end

ThreeLevelViceButton = class("ThreeLevelViceButton", CommonButtonWithName)

function ThreeLevelViceButton.class:createWidgetNode()
	local resFile = "asset/ui/ThreeLevelViceButton.csb"

	return cc.CSLoader:createNode(resFile)
end

function ThreeLevelViceButton:setButtonNameStyle()
	return
end
