-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmViewMediator.lua

require("dm.gameplay.base.URLContext")
require("dm.gameplay.base.UrlEntry")

function mapButtonHandler(mediator, buttonName, handler)
	assert(false, "方法即将废弃请调用 mapButtonHandlerClick ")

	local rootView = mediator:getView()
	local button = rootView:getChildByFullName(buttonName)

	if DEBUG and DEBUG > 0 then
		assert(button ~= nil, string.format("Button '%s' not found!", buttonName))
	end

	if button then
		button:addTouchEventListener(handler)
	end
end

function mapButtonHandlers(mediator, buttonsConfig)
	assert(false, "方法即将废弃请调用 mapButtonHandlerClick ")

	local rootView = mediator:getView()

	for buttonName, handler in pairs(buttonsConfig) do
		local button = rootView:getChildByFullName(buttonName)

		if DEBUG and DEBUG > 0 then
			assert(button ~= nil, string.format("Button '%s' not found!", buttonName))
		end

		if button then
			if type(handler) == "function" then
				button:addTouchEventListener(handler)
			else
				local method = mediator[handler]

				if method then
					button:addTouchEventListener(function(sender, eventType)
						method(mediator, sender, eventType)
					end)
				end
			end
		end
	end
end

function bindWidget(mediator, nodeOrName, widgetClass, ...)
	assert(nodeOrName ~= nil and widgetClass ~= nil, "Invalid parameters")

	local widgetNode = nodeOrName

	if type(nodeOrName) == "string" then
		local rootView = mediator:getView()

		widgetNode = rootView:getChildByFullName(nodeOrName)

		assert(widgetNode ~= nil, string.format("Widget node not found for name `%s`", nodeOrName))
	end

	local widget = widgetClass:new(widgetNode, ...)

	widget:autoDispose()

	if mediator.getInjector then
		local injector = mediator:getInjector()

		if injector then
			injector:injectInto(widget)
		end
	end

	return widget
end

function gotoUrlView(mediator, url, extParams)
	local context = mediator:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

	if extParams then
		for k, value in pairs(extParams) do
			params[k] = value
		end
	end

	entry:response(context, params)

	return true
end

assert(BaseViewMediator ~= nil)

function BaseViewMediator:mapButtonHandler(buttonName, handler)
	assert(false, "方法即将废弃请调用 mapButtonHandlerClick ")

	return mapButtonHandler(self, buttonName, handler)
end

function BaseViewMediator:mapButtonHandlers(buttonsConfig)
	assert(false, "方法即将废弃请调用 mapButtonHandlersClick ")

	return mapButtonHandlers(self, buttonsConfig)
end

function BaseViewMediator:bindWidget(nodeOrName, widgetClass, ...)
	return bindWidget(self, nodeOrName, widgetClass, ...)
end

function BaseViewMediator:bindWidget(nodeOrName, widgetClass, ...)
	return bindWidget(self, nodeOrName, widgetClass, ...)
end

function mapButtonHandlerClick(mediator, buttonNameOrObj, handler, view, addLayout)
	local rootView = view or mediator and mediator:getView()
	local button = type(buttonNameOrObj) == "string" and rootView:getChildByFullName(buttonNameOrObj) or buttonNameOrObj

	if DEBUG and DEBUG > 0 then
		assert(button ~= nil, string.format("Button '%s' not found!", tostring(buttonNameOrObj)))
	end

	if button then
		if addLayout then
			local child = button:getChildByFullName(tostring(addLayout))

			if child then
				child:removeFromParent()
			end

			local touchPanel = ccui.Layout:create()
			local size = button:getContentSize()

			touchPanel:setContentSize(size)
			touchPanel:setTouchEnabled(true)
			touchPanel:setSwallowTouches(false)
			touchPanel:setAnchorPoint(0.5, 0.5)
			touchPanel:setPosition(cc.p(size.width * 0.5, size.height * 0.5))
			touchPanel:addTo(button):setName(tostring(addLayout))

			button = touchPanel

			assert(touchPanel ~= nil, string.format("Button '%s' add Layout failed!", tostring(buttonNameOrObj)))
		end

		local method
		local options = {}

		options.eventType = ccui.TouchEventType.ended
		options.clickAudio = "Se_Click_Common_1"

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
			options.clickAudio = handler.clickAudio or options.clickAudio
			options.ignoreClickAudio = handler.ignoreClickAudio
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

function legs.Mediator:mapButtonHandlersClick(buttonsConfig, view)
	for buttonName, handler in pairs(buttonsConfig) do
		self:mapButtonHandlerClick(buttonName, handler, view)
	end
end

function legs.Mediator:mapButtonHandlerClick(buttonName, handler, view, addLayout)
	mapButtonHandlerClick(self, buttonName, handler, view, addLayout)
end

function legs.Mediator:bindBackBtnFlash(bindPanel, position)
	assert(bindPanel ~= nil, "error:bindPanel = nil")
	assert(position ~= nil, "error:position = nil")

	local backBtnMC = cc.MovieClip:create("fanhui_fanhui")

	backBtnMC:setPlaySpeed(1.6)

	local posX = position.x + 50
	local posY = position.y + 65

	backBtnMC:setPosition(cc.p(posX, posY))
	bindPanel:addChild(backBtnMC)
	backBtnMC:addCallbackAtFrame(45, function()
		backBtnMC:stop()
	end)

	self._backBtnAnim = backBtnMC
end
