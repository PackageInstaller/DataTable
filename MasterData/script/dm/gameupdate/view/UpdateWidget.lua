-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/view/UpdateWidget.lua

require("cocos.ui.GuiConstants")

local function bindUpdateWidget(self, nodeOrName, widgetClass, ...)
	assert(nodeOrName ~= nil and widgetClass ~= nil, "Invalid parameters")

	local widgetNode = nodeOrName

	if type(nodeOrName) == "string" then
		local rootView = self:getView()

		widgetNode = rootView:getChildByFullName(nodeOrName)

		assert(widgetNode ~= nil, string.format("Widget node not found for name `%s`", nodeOrName))
	end

	return (widgetClass:new(widgetNode, ...))
end

local function mapButtonHandlerClick(mediator, buttonNameOrObj, handler, view)
	local rootView = view or mediator and mediator:getView()
	local button = type(buttonNameOrObj) == "string" and rootView:getChildByFullName(buttonNameOrObj) or buttonNameOrObj

	if DEBUG and DEBUG > 0 then
		assert(button ~= nil, string.format("Button '%s' not found!", tostring(buttonNameOrObj)))
	end

	if button then
		local method
		local options = {}

		options.eventType = ccui.TouchEventType.ended

		local isInstance = false

		if type(handler) == "function" then
			method = handler
		elseif type(handler) == "string" then
			method = mediator[handler]
			isInstance = true
		elseif type(handler) == "table" then
			if type(handler.func) == "function" then
				method = handler.func
			end

			if type(handler.func) == "string" then
				method = mediator[handler.func]
				isInstance = true
			end

			options.eventType = handler.eventType or options.eventType
		else
			return
		end

		if method then
			if options.eventType ~= ccui.TouchEventType.ended then
				if not button.addTouchEventListener then
					-- block empty
				end
			end
		end
	end
end

local PopupUpdateTitle = {}

function PopupUpdateTitle:new(...)
	local result = setmetatable({}, {
		__index = PopupUpdateTitle
	})

	result:initialize(...)

	return result
end

function PopupUpdateTitle:initialize(view, data)
	self._view = view

	self:setupView(data)
end

function PopupUpdateTitle:getView()
	return self._view
end

function PopupUpdateTitle:setupView(data)
	local view = self:getView()

	self._titleText1 = view:getChildByFullName("Text_1")

	self._titleText1:setLocalZOrder(2)

	if data.title then
		self._titleText1:setString(data.title)
	end

	if data.title1 then
		view:getChildByFullName("Text_2"):setString(data.title1)
	end
end

local PopupUpdateWidget = {}

function PopupUpdateWidget:new(...)
	local result = setmetatable({}, {
		__index = PopupUpdateWidget
	})

	result:initialize(...)

	return result
end

function PopupUpdateWidget:initialize(view, data)
	self._view = view

	self:setupView(data)
end

function PopupUpdateWidget:getView()
	return self._view
end

function PopupUpdateWidget:setupView(data)
	local view = self:getView()
	local bg = view:getChildByFullName("Image_bg")

	if bg then
		local component = bg:getComponent("ComExtensionData")

		if component then
			local jsonString = component:getCustomProperty()
			local cjson = require("cjson.safe")
			local data = cjson.decode(jsonString)

			bg:loadTexture("asset/ui/popup/" .. data.bg)

			local size = bg:getContentSize()
			local scale9data = data.scale9data
			local capInsets = cc.rect(scale9data[1], scale9data[4], size.width - scale9data[1] - scale9data[2], size.height - scale9data[3] - scale9data[4])

			bg:setCapInsets(capInsets)
		end
	end

	if data.bgSize then
		self:setContentSize(data.bgSize.width, data.bgSize.height)
	end

	local closeBtn = view:getChildByFullName("btn_close")

	closeBtn:setLocalZOrder(10)

	if data.btnHandler then
		closeBtn:setVisible(true)
		mapButtonHandlerClick(self, "btn_close", data.btnHandler)
	else
		closeBtn:setVisible(false)
	end

	if data.title then
		bindUpdateWidget(self, "title_node", PopupUpdateTitle, data)
	end
end

function PopupUpdateWidget:setContentSize(width, height)
	local view = self:getView()
	local closeBtn = view:getChildByFullName("btn_close")
	local titleNode = view:getChildByFullName("title_node")
	local bg = view:getChildByFullName("Image_bg")
	local bgSize = bg:getContentSize()

	width = width or bgSize.width
	height = height or bgSize.height

	local btnOffsetX = bgSize.width - closeBtn:getPositionX()
	local btnOffsetY = bgSize.height - closeBtn:getPositionY()
	local titleOffsetX = titleNode:getPositionX()
	local titleOffsetY = bgSize.height - titleNode:getPositionY()

	bg:setContentSize(cc.size(width, height))
	closeBtn:setPosition(width - btnOffsetX, height - btnOffsetY)
	titleNode:setPosition(titleOffsetX, height - titleOffsetY)
end

local UpdateButton = {}

function UpdateButton:new(...)
	local result = setmetatable({}, {
		__index = self
	})

	result:initialize(...)

	return result
end

function UpdateButton:initialize(view, data)
	self._view = view
	self._button = view:getChildByName("button")

	mapButtonHandlerClick(self, "button", data.handler)

	self._nameText = view:getChildByName("name")
	self._nameText1 = view:getChildByName("name1")

	if not data.ignoreAddKerning then
		self._nameText:setAdditionalKerning(8)
		self._nameText:offset(4, 0)
	end

	local component = view:getComponent("ComExtensionData")

	if component then
		local translateIds = component:getCustomProperty()

		translateIds = string.split(translateIds, "&")

		local buttonName = GameUpdateMediator.Strings:get(translateIds[1], data.nameStringEnv)
		local buttonName1 = GameUpdateMediator.Strings:get(translateIds[2], data.nameStringEnv)

		self:setButtonName(buttonName, buttonName1)
	end

	self:setButtonNameStyle()
end

function UpdateButton:getView()
	return self._view
end

function UpdateButton:getButton()
	return self._button
end

function UpdateButton:getNameText()
	return self._nameText
end

function UpdateButton:setButtonName(buttonName, buttonName1)
	self._nameText:setString(buttonName)

	if self._nameText1 then
		self._nameText1:setString(buttonName1 or "")
	end
end

function UpdateButton:setButtonNameStyle()
	return
end

function UpdateButton:setVisible(visible)
	self._view:setVisible(visible)
end

local UpdateMainButton = setmetatable({}, {
	__index = UpdateButton,
	__newindex = function(t, k, v)
		if _G.type(v) == "function" then
			local fenv = _G.getfenv(v)

			v = _G.setfenv(v, _G.setmetatable({
				super = UpdateButton
			}, {
				__index = fenv,
				__newindex = fenv
			}))
		end

		_G.rawset(t, k, v)
	end
})

function UpdateMainButton:initialize(view, data)
	super.initialize(self, view, data)

	if data.showAnim then
		self:showAnim()
	end
end

function UpdateMainButton:showAnim()
	local anim = cc.MovieClip:create("btn_xinchongzhi")

	anim:addTo(self:getButton()):setScale(1.2)
	anim:setPosition(cc.p(self:getButton():getContentSize().width / 2 - 2, self:getButton():getContentSize().height / 2 - 2))
end

function UpdateMainButton:setButtonNameStyle()
	if self._nameText1 then
		self._nameText1:enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	end
end

local UpdateViceButton = setmetatable({}, {
	__index = UpdateButton,
	__newindex = function(t, k, v)
		if _G.type(v) == "function" then
			local fenv = _G.getfenv(v)

			v = _G.setfenv(v, _G.setmetatable({
				super = UpdateButton
			}, {
				__index = fenv,
				__newindex = fenv
			}))
		end

		_G.rawset(t, k, v)
	end
})

function UpdateViceButton:initialize(view, data)
	super.initialize(self, view, data)

	if data.showAnim then
		self:showAnim()
	end
end

function UpdateViceButton:showAnim()
	local anim = cc.MovieClip:create("btn_xinchongzhi")

	anim:addTo(self:getButton()):setScale(1.2)
	anim:setPosition(cc.p(self:getButton():getContentSize().width / 2 - 2, self:getButton():getContentSize().height / 2 - 2))
end

function UpdateViceButton:setButtonNameStyle()
	if self._nameText1 then
		self._nameText1:enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
	end
end

return {
	bindUpdateWidget,
	PopupUpdateWidget,
	UpdateMainButton,
	UpdateViceButton
}
