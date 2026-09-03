-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/PopupViewGroup.lua

PopupViewGroup = class("PopupViewGroup", _G.DisposableObject)

PopupViewGroup:has("_mediatorMap", {
	is = "r"
}):injectWith("legs_contextMediatorMap")

function PopupViewGroup:initialize(sceneMediator, rootNode)
	super.initialize(self)

	self._sceneMediator = sceneMediator
	self._groupLayer = rootNode
	self._popupViewStack = {}
end

function PopupViewGroup:dispose()
	super.dispose(self)
end

function PopupViewGroup:setVisible(isVisible)
	self._groupLayer:setVisible(isVisible)
end

local kMaskDefaultColor = cc.c4b(0, 0, 0, 180)

function PopupViewGroup:getMaskLayer()
	if self._maskLayer == nil then
		local viewSize = self._sceneMediator:getFullScreenFrame()
		local maskLayer = cc.LayerColor:create(kMaskDefaultColor, viewSize.width, viewSize.height)

		self._maskLayer = maskLayer

		self._groupLayer:addChild(maskLayer, -1)
		maskLayer:setTouchEnabled(true)
		maskLayer:setVisible(false)

		self._maskLayer = maskLayer

		maskLayer:registerScriptTouchHandler(function(eventType, x, y)
			local node = self._maskLayer

			while node ~= nil do
				if not node:isVisible() then
					return false
				end

				node = node:getParent()
			end

			if eventType == "began" then
				local topInfo = self._popupViewStack[#self._popupViewStack]

				if topInfo ~= nil then
					local mediatorMap = self:getMediatorMap()
					local mediator = mediatorMap:retrieveMediator(topInfo.view)

					if mediator ~= nil then
						mediator:onTouchMaskLayer()
					end
				end

				return true
			end
		end, false, 0, true)
	end

	return self._maskLayer
end

function PopupViewGroup:attachBackground(background)
	if background == nil then
		return nil
	end

	local backgroundNode, adaption

	if type(background) == "table" then
		backgroundNode = background.node
		adaption = background.adaption
		background = background.image
	end

	if backgroundNode == nil and background ~= nil then
		backgroundNode = cc.Sprite:create(background) or cc.Sprite:createWithSpriteFrameName(background)
	end

	if backgroundNode ~= nil then
		self._groupLayer:addChild(backgroundNode, 1)
		backgroundNode:setVisible(false)

		local rect = self._sceneMediator:getFullScreenFrame()

		if adaption == "stretch" then
			backgroundNode:stretch(rect)
		elseif adaption == "cover" then
			backgroundNode:coverRegion(rect, cc.p(0.5, 0.5))
		elseif adaption == "fit" then
			backgroundNode:fitRegion(rect, cc.p(0.5, 0.5))
		else
			backgroundNode:center(rect)
		end
	end

	return backgroundNode
end

function PopupViewGroup:detachBackground(backgroundNode)
	if backgroundNode ~= nil then
		backgroundNode:removeFromParent(true)

		if self._backgroundNode == backgroundNode then
			self._backgroundNode = nil
		end
	end
end

function PopupViewGroup:getPopupInfoByIndex(index)
	return self._popupViewStack[index]
end

function PopupViewGroup:showTopMostBackground(reset)
	if self._backgroundNode ~= nil then
		if not reset then
			return
		end

		self._backgroundNode:setVisible(false)

		self._backgroundNode = nil
	end

	local popupViewStack = self._popupViewStack

	for index = #popupViewStack, 1, -1 do
		local popupInfo = popupViewStack[index]

		if popupInfo.backgroundNode ~= nil then
			self._backgroundNode = popupInfo.backgroundNode

			self._backgroundNode:setVisible(true)

			break
		end
	end
end

function PopupViewGroup:addPopupView(popupView, options, data, delegate)
	assert(popupView ~= nil, "Invalid popup view")

	local topIndex = #self._popupViewStack
	local newZOrder = 10
	local topInfo = self._popupViewStack[topIndex]

	if topInfo ~= nil then
		if options and not options.remainLastView then
			topInfo.view:setVisible(false)
		end

		newZOrder = topInfo.zOrder + 2
	end

	local var_10_0 = {
		view = popupView,
		zOrder = newZOrder
	}

	if options then
		var_10_0.maskOpacity = options.maskOpacity or kMaskDefaultColor.a
	end

	if options then
		var_10_0.maskColor = options.maskColor or kMaskDefaultColor
	end

	var_10_0.fullScreen = options and options.fullScreen

	local popupInfo = var_10_0

	self._popupViewStack[topIndex + 1] = popupInfo

	local transition = options and options.transition
	local maskLayer = self:getMaskLayer()

	if maskLayer ~= nil then
		maskLayer:setVisible(true)
		maskLayer:setLocalZOrder(newZOrder - 1)
		maskLayer:setColor(popupInfo.maskColor)

		if popupInfo.maskOpacity > 0 and #self._popupViewStack == 1 and transition ~= nil then
			local duration = 0.3

			maskLayer:setOpacity(0)
			maskLayer:fadeTo({
				time = duration,
				opacity = popupInfo.maskOpacity
			})
		else
			maskLayer:setOpacity(popupInfo.maskOpacity)
		end
	end

	popupInfo.backgroundNode = self:attachBackground(options and options.background)

	self:showTopMostBackground(true)
	self._groupLayer:addChild(popupView, newZOrder)

	if self._sceneMediator ~= nil then
		self._sceneMediator:didAddPopupView(popupView, self)
	end

	local mediator = self:getMediatorMap():retrieveMediator(popupView)

	if mediator ~= nil then
		mediator:setPopupDelegate(delegate)
		mediator:adjustLayout(self._sceneMediator:getFullScreenFrame())
		mediator:enterWithData(data)
	end

	if mediator ~= nil then
		mediator:willStartEnterTransition(transition)
	end

	local function didFinishTransition(_, transition)
		if mediator ~= nil then
			mediator:didFinishEnterTransition(transition)
		end
	end

	if transition ~= nil then
		transition:runTransitionAnimation(popupView, didFinishTransition)
	else
		didFinishTransition(popupView, transition)
	end

	return mediator
end

function PopupViewGroup:removePopupView(popupView, options, data)
	if popupView == nil then
		return
	end

	local popupViewStack = self._popupViewStack
	local index = #popupViewStack
	local popupInfo = popupViewStack[index]

	if popupInfo ~= nil and popupInfo.view == popupView then
		popupViewStack[index] = nil
	else
		popupInfo = nil
		index = index - 1

		while index > 0 do
			popupInfo = popupViewStack[index]

			if popupViewStack[index] ~= nil and popupInfo.view == popupView then
				table.remove(popupViewStack, index)

				break
			end

			popupInfo = nil
			index = index - 1
		end
	end

	if popupInfo == nil then
		return
	end

	local popupMediator = self:getMediatorMap():retrieveMediator(popupView)
	local transition = options and options.transition

	if popupMediator ~= nil then
		popupMediator:willStartExitTransition(transition)
	end

	local maskLayer = self:getMaskLayer()
	local topPopup = self._popupViewStack[#self._popupViewStack]

	if transition ~= nil and maskLayer ~= nil and not topPopup then
		maskLayer:stopAllActions()

		local duration = 0.2
		local action = cc.FadeOut:create(duration)

		maskLayer:runAction(action)
	end

	local function didFinishTransition(_, transition)
		topPopup = self._popupViewStack[#self._popupViewStack]

		if self._sceneMediator ~= nil then
			self._sceneMediator:willRemovePopupView(popupView, self)
		end

		if maskLayer ~= nil then
			if topPopup ~= nil then
				topPopup.view:setVisible(true)
				maskLayer:setVisible(true)
				maskLayer:setLocalZOrder(topPopup.zOrder - 1)
				maskLayer:setOpacity(topPopup.maskOpacity)
				maskLayer:setColor(topPopup.maskColor)
			else
				maskLayer:setVisible(false)
			end

			if popupInfo.backgroundNode ~= nil then
				self:detachBackground(popupInfo.backgroundNode)

				popupInfo.backgroundNode = nil

				self:showTopMostBackground(false)
			end
		end

		if popupMediator ~= nil then
			popupMediator:didFinishExitTransition(transition)
		end

		popupView:removeFromParent()
	end

	if transition ~= nil then
		transition:runTransitionAnimation(popupView, didFinishTransition)
	else
		didFinishTransition(popupView, transition)
	end
end

function PopupViewGroup:closeAllPopups()
	local popupViewStack = self._popupViewStack
	local topPopup = popupViewStack[#popupViewStack]

	while topPopup ~= nil do
		local popupView = topPopup.view

		if popupView ~= nil then
			self:removePopupView(popupView)
		else
			popupViewStack[#popupViewStack] = nil
		end

		topPopup = popupViewStack[#popupViewStack]
	end
end

function PopupViewGroup:isCoveringFullScreen()
	local popupViewStack = self._popupViewStack

	for i = #popupViewStack, 1, -1 do
		local popupInfo = popupViewStack[i]

		if popupInfo.fullScreen then
			return true
		end
	end

	return false
end

function PopupViewGroup:getViewCount()
	return #self._popupViewStack
end
