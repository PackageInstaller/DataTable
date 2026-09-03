-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/BaseSceneMediator.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

require(__PACKAGE__ .. "PopupViewGroup")

BaseSceneMediator = class("BaseSceneMediator", legs.Mediator)

BaseSceneMediator:has("_viewLayer", {
	is = "r"
})
BaseSceneMediator:has("_popupLayer", {
	is = "r"
})
BaseSceneMediator:has("_effectLayer", {
	is = "r"
})
BaseSceneMediator:has("_residentLayer", {
	is = "r"
})

local LayerZOrders = {
	kViewLayer = 0,
	kPopupLayer = 10,
	kResidentLayer = 9,
	kEffectLayer = 30
}

function BaseSceneMediator:initialize()
	super.initialize(self)
end

function BaseSceneMediator:dispose()
	super.dispose(self)
end

function BaseSceneMediator:onRegister()
	super.onRegister(self)

	local injector = self:getInjector()

	injector:mapValue("BaseSceneMediator", self, "activeScene")

	local rootView = self:getView()
	local residentLayer = injector:getInstance("__residentLayer__")

	if residentLayer then
		residentLayer:addTo(rootView, LayerZOrders.kResidentLayer)

		self._residentLayer = residentLayer
	end

	self:initViewLayer(rootView)
	self:initPopupLayer(rootView)
	self:initEffectLayer(rootView)
end

function BaseSceneMediator:onRemove()
	if self._globalPopupGroup ~= nil then
		self._globalPopupGroup:dispose()

		self._globalPopupGroup = nil
	end

	for i = 1, #self._areaViewStack do
		local areaInfo = self._areaViewStack[i]

		if areaInfo.popupGroup ~= nil then
			areaInfo.popupGroup:dispose()

			areaInfo.popupGroup = nil
		end
	end

	if self._residentLayer ~= nil and not tolua.isnull(self._residentLayer) and self._residentLayer:getParent() then
		self._residentLayer:removeFromParent()
	end

	self._residentLayer = nil

	super.onRemove(self)
end

function BaseSceneMediator:getFullScreenFrame()
	if self._fullScreenFrame == nil then
		local director = cc.Director:getInstance()
		local size = director:getVisibleSize()
		local origin = director:getVisibleOrigin()

		self._fullScreenFrame = cc.rect(origin.x, origin.y, size.width, size.height)
	end

	local frame = self._fullScreenFrame

	return cc.rect(frame.x, frame.y, frame.width, frame.height)
end

function BaseSceneMediator:getSafeScreenFrame()
	if self._safeScreenFrame == nil then
		local director = cc.Director:getInstance()
		local size = director:getVisibleSize()
		local origin = director:getVisibleOrigin()
		local safeAreaInset = director:getOpenGLView():getSafeAreaInset()

		self._safeScreenFrame = cc.rect(origin.x + safeAreaInset.left, origin.y + safeAreaInset.bottom, size.width - safeAreaInset.left - safeAreaInset.right, size.height - safeAreaInset.bottom - safeAreaInset.top)
	end

	local frame = self._safeScreenFrame

	return cc.rect(frame.x, frame.y, frame.width, frame.height)
end

function BaseSceneMediator:getAreaFrame()
	return self:getSafeScreenFrame()
end

function BaseSceneMediator:enterWithData(data)
	return
end

function BaseSceneMediator:initViewLayer(rootView)
	self._areaViewStack = {}
	self._viewLayer = cc.Node:create()

	rootView:addChild(self._viewLayer, LayerZOrders.kViewLayer)
	self.mapEventListener(self, self._viewLayer, EVT_DISMISS_VIEW, self, self.onDismissView)
end

function BaseSceneMediator:pushView(areaView, options, data)
	if areaView == nil then
		return nil
	end

	local lastTopRootNode, lastTopMediator
	local topIndex = #self._areaViewStack

	if topIndex ~= 0 then
		local areaInfo = self._areaViewStack[topIndex]

		if areaView == areaInfo.view then
			return nil
		end

		lastTopRootNode = areaInfo.rootNode
		lastTopMediator = areaInfo.mediator
	end

	if lastTopMediator ~= nil then
		lastTopMediator:willBeCovered()
	end

	local rootNode = cc.Node:create()

	rootNode:addChild(areaView, 0)

	local areaInfo = {
		view = areaView,
		rootNode = rootNode
	}

	self._areaViewStack[#self._areaViewStack + 1] = areaInfo

	self._viewLayer:addChild(rootNode)

	local mediator = self:getMediatorMap():retrieveMediator(areaView)

	if mediator ~= nil then
		areaInfo.mediator = mediator

		mediator:adjustLayout(self:getAreaFrame())
		mediator:enterWithData(data)
	end

	local transition = options and options.transition

	if lastTopMediator ~= nil then
		lastTopMediator:willStartCoverTransition(transition)
	end

	if mediator ~= nil and not DisposableObject:isDisposed(mediator) then
		mediator:willStartEnterTransition(transition)
	end

	local function didFinishTransition(_, _, transition)
		if lastTopRootNode ~= nil then
			lastTopRootNode:setVisible(false)
		end

		if mediator ~= nil and not DisposableObject:isDisposed(mediator) then
			mediator:didFinishEnterTransition(transition)
		end

		if lastTopMediator ~= nil and not DisposableObject:isDisposed(lastTopMediator) then
			lastTopMediator:didFinishCoverTransition(transition)
		end
	end

	if transition ~= nil then
		transition:runTransitionAnimation(rootNode, lastTopRootNode, didFinishTransition)
	else
		didFinishTransition(rootNode, lastTopRootNode, transition)
	end

	return areaView, mediator
end

function BaseSceneMediator:popView(areaView, options, data)
	local topIndex = #self._areaViewStack

	if topIndex == 0 then
		return false
	end

	local topAreaInfo = self._areaViewStack[topIndex]

	assert(topAreaInfo ~= nil)

	if areaView ~= nil and topAreaInfo.view ~= areaView then
		return false
	end

	local topAreaMediator = topAreaInfo.mediator

	if topAreaInfo.popupGroup ~= nil then
		topAreaInfo.popupGroup:closeAllPopups()
		topAreaInfo.popupGroup:dispose()

		topAreaInfo.popupGroup = nil
	end

	self._areaViewStack[topIndex] = nil
	topIndex = #self._areaViewStack

	local prevAreaInfo = self._areaViewStack[#self._areaViewStack]
	local prevAreaMediator

	if prevAreaInfo ~= nil then
		prevAreaMediator = prevAreaInfo.mediator

		prevAreaInfo.rootNode:setVisible(true)
	end

	local transition = options and options.transition

	if prevAreaMediator ~= nil then
		prevAreaMediator:resumeWithData(data)

		if prevAreaMediator ~= nil and DisposableObject:isDisposed(prevAreaMediator) then
			prevAreaMediator = nil
		end
	end

	if prevAreaMediator ~= nil then
		prevAreaMediator:willStartResumeTransition(transition)
	end

	if topAreaMediator ~= nil then
		topAreaMediator:willStartExitTransition(transition)
	end

	local function didFinishTransition(_, _, transition)
		if topAreaMediator ~= nil then
			topAreaMediator:didFinishExitTransition(transition)
		end

		self._viewLayer:removeChild(topAreaInfo.rootNode)

		if prevAreaMediator ~= nil then
			prevAreaMediator:didFinishResumeTransition(transition)
		end
	end

	if transition ~= nil then
		transition:runTransitionAnimation(topAreaInfo.rootNode, prevAreaInfo and prevAreaInfo.rootNode, didFinishTransition)
	else
		didFinishTransition(topAreaInfo.rootNode, prevAreaInfo and prevAreaInfo.rootNode, transition)
	end

	return true
end

function BaseSceneMediator:switchView(areaView, options, data)
	if areaView == nil then
		return nil
	end

	local topIndex = #self._areaViewStack

	if options then
		if not options.replaceIndex then
			local replaceIndex = topIndex

			if replaceIndex < 0 then
				replaceIndex = topIndex + 1 + replaceIndex
			end

			if replaceIndex < 1 then
				replaceIndex = 1
			end

			if topIndex < replaceIndex then
				replaceIndex = topIndex
			end

			local removals = {}

			if topIndex > 0 then
				while replaceIndex <= topIndex do
					local topAreaInfo = self._areaViewStack[topIndex]

					topAreaInfo._index = topIndex
					removals[#removals + 1] = topAreaInfo
					topIndex = topIndex - 1
				end
			end

			for i = 1, #removals do
				local topAreaInfo = removals[i]

				if topAreaInfo.popupGroup ~= nil then
					topAreaInfo.popupGroup:closeAllPopups()
					topAreaInfo.popupGroup:dispose()

					topAreaInfo.popupGroup = nil
				end

				self._areaViewStack[topAreaInfo._index] = nil
			end

			local topAreaInfo = removals[1]
			local rootNode = cc.Node:create()

			rootNode:addChild(areaView, 0)

			local areaInfo = {
				view = areaView,
				rootNode = rootNode
			}

			self._areaViewStack[#self._areaViewStack + 1] = areaInfo

			self._viewLayer:addChild(rootNode)

			local mediator = self:getMediatorMap():retrieveMediator(areaView)

			if mediator ~= nil then
				areaInfo.mediator = mediator
				areaView.mediator = mediator

				mediator:adjustLayout(self:getAreaFrame())
				mediator:enterWithData(data)
			end

			local transition = options and options.transition

			for i = 1, #removals do
				local topAreaMediator = removals[i].mediator

				if topAreaMediator ~= nil then
					topAreaMediator:willStartExitTransition(transition)
				end
			end

			if mediator ~= nil then
				mediator:willStartEnterTransition(transition)
			end

			local function didFinishTransition(_, _, transition)
				if mediator ~= nil and not DisposableObject:isDisposed(mediator) then
					mediator:didFinishEnterTransition(transition)
				end

				for i = 1, #removals do
					local topArea = removals[i]

					if topArea.mediator ~= nil then
						topArea.mediator:didFinishExitTransition(transition)
					end

					self._viewLayer:removeChild(topArea.rootNode)
				end
			end

			if transition ~= nil then
				transition:runTransitionAnimation(rootNode, topAreaInfo and topAreaInfo.rootNode, didFinishTransition)
			else
				didFinishTransition(rootNode, topAreaInfo and topAreaInfo.rootNode, transition)
			end

			return areaView, mediator
		end
	end
end

function BaseSceneMediator:removeViewAtIndex(index, options, data)
	local viewStackSize = #self._areaViewStack
	local realIndex = index

	if index < 0 then
		realIndex = viewStackSize + 1 + index
	end

	if realIndex > 0 and realIndex == viewStackSize then
		return self:popView(nil, options, data)
	end

	local areaInfo = self._areaViewStack[realIndex]

	if areaInfo == nil then
		return false
	end

	if areaInfo.popupGroup ~= nil then
		areaInfo.popupGroup:closeAllPopups()
		areaInfo.popupGroup:dispose()

		areaInfo.popupGroup = nil
	end

	table.remove(self._areaViewStack, index)
	self._viewLayer:removeChild(areaInfo.rootNode)

	return true
end

function BaseSceneMediator:onDismissView(event)
	local view = event:getView()
	local data = event:getData()
	local options = event:getOptions()

	self:popView(view, options, data)
end

function BaseSceneMediator:getViewStackSize()
	if self._areaViewStack == nil then
		return 0
	end

	return #self._areaViewStack
end

function BaseSceneMediator:getAreaViewInfoAtIndex(index)
	if self._areaViewStack == nil then
		return nil
	end

	local realIndex = index

	if index < 0 then
		realIndex = #self._areaViewStack + 1 + index
	end

	if realIndex > 0 then
		return self._areaViewStack[realIndex]
	end

	return nil
end

function BaseSceneMediator:getViewAtIndex(index)
	if self._areaViewStack == nil then
		return nil
	end

	local realIndex = index

	if index < 0 then
		realIndex = #self._areaViewStack + 1 + index
	end

	if realIndex > 0 then
		local areaInfo = self._areaViewStack[realIndex]

		return areaInfo.view
	end

	return nil
end

function BaseSceneMediator:getViewNameAtIndex(index)
	local view = self:getViewAtIndex(index)

	if view == nil or view.getViewName == nil then
		return nil
	end

	return view:getViewName()
end

function BaseSceneMediator:getAreaViewInfoAtIndex(index)
	if self._areaViewStack == nil then
		return nil
	end

	local realIndex = index

	if index < 0 then
		realIndex = #self._areaViewStack + 1 + index
	end

	if realIndex > 0 then
		return self._areaViewStack[realIndex]
	end

	return nil
end

function BaseSceneMediator:getTopView()
	return self:getViewAtIndex(-1)
end

function BaseSceneMediator:getTopViewName()
	return self:getViewNameAtIndex(-1)
end

function BaseSceneMediator:getPopupInfoViewAtIndex(areaIndex, popIndex)
	local areaViewInfo = self._areaViewStack[areaIndex]

	if not areaViewInfo then
		return
	end

	if areaViewInfo.popupGroup then
		return areaViewInfo.popupGroup:getPopupInfoByIndex(popIndex)
	end
end

function BaseSceneMediator:initPopupLayer(rootView)
	self._popupViewGroups = {}
	self._popupViewLists = {}
	self._popupLayer = cc.Node:create()

	rootView:addChild(self._popupLayer, LayerZOrders.kPopupLayer)

	self._globalPopupGroup = self:newPopupGroup(self._popupLayer)

	self.mapEventListener(self, rootView, EVT_CLOSE_POPUP, self, self.onClosePopup)
end

function BaseSceneMediator:getPopupInfoViewAtIndex(areaIndex, popIndex)
	local areaViewInfo = self._areaViewStack[areaIndex]

	if not areaViewInfo then
		return
	end

	if areaViewInfo.popupGroup then
		return areaViewInfo.popupGroup:getPopupInfoByIndex(popIndex)
	end
end

function BaseSceneMediator:newPopupGroup(rootView)
	local popupGroup = PopupViewGroup:new(self, rootView)
	local injector = self:getInjector()

	injector:injectInto(popupGroup)

	return popupGroup
end

function BaseSceneMediator:didAddPopupView(popupView, popupGroup)
	self._popupViewGroups[popupView] = popupGroup

	table.insert(self._popupViewLists, popupView)
	self:_updatePopupGroupVisibility()
end

function BaseSceneMediator:willRemovePopupView(popupView, popupGroup)
	if popupGroup == self._popupViewGroups[popupView] then
		self._popupViewGroups[popupView] = nil

		table.removevalues(self._popupViewLists, popupView)
	end

	self:_updatePopupGroupVisibility()
end

function BaseSceneMediator:_updatePopupGroupVisibility()
	return
end

function BaseSceneMediator:_updateAreaViewVisibility()
	return
end

function BaseSceneMediator:showPopup(popupView, options, data, delegate)
	if popupView == nil then
		return
	end

	local popupGroup

	if options == nil or not options.isAreaIndependent then
		local topAreaInfo = self._areaViewStack[#self._areaViewStack]

		if topAreaInfo ~= nil then
			popupGroup = topAreaInfo.popupGroup

			if topAreaInfo.popupGroup == nil then
				popupGroup = self:newPopupGroup(topAreaInfo.rootNode)
				topAreaInfo.popupGroup = popupGroup
			end
		end
	end

	if popupGroup == nil then
		popupGroup = self._globalPopupGroup
	end

	assert(popupGroup ~= nil, "No popup group found")

	local mediator = popupGroup:addPopupView(popupView, options, data, delegate)

	self:_updateAreaViewVisibility()

	if mediator then
		popupView.mediator = mediator
	end

	return popupView, mediator
end

function BaseSceneMediator:onClosePopup(event)
	local popupView = event:getView()

	if popupView == nil then
		return
	end

	local popupGroup = self._popupViewGroups[popupView]

	if popupGroup ~= nil then
		local options = event:getOptions()
		local data = event:getData()

		popupGroup:removePopupView(popupView, options, data)
		self:_updateAreaViewVisibility()
	end
end

function BaseSceneMediator:getPopupViewCount()
	local result = 0

	if #self._areaViewStack > 0 then
		local topAreaInfo = self._areaViewStack[#self._areaViewStack]

		if topAreaInfo ~= nil then
			local popupGroup = topAreaInfo.popupGroup

			if popupGroup ~= nil then
				result = result + popupGroup:getViewCount()
			end
		end
	end

	if self._globalPopupGroup ~= nil then
		result = result + self._globalPopupGroup:getViewCount()
	end

	return result
end

function BaseSceneMediator:getTopPopupView()
	return self._popupViewLists[#self._popupViewLists]
end

function BaseSceneMediator:initEffectLayer(rootView)
	self._effectLayer = cc.Node:create()

	rootView:addChild(self._effectLayer, LayerZOrders.kEffectLayer)

	local winFrame = self:getAreaFrame()

	self._effectLayer:setPosition(winFrame.x + winFrame.width * 0.5, winFrame.y + winFrame.height * 0.5)

	self._effectFrame = cc.rect(-winFrame.width * 0.5, -winFrame.height * 0.5, winFrame.width, winFrame.height)
end

function BaseSceneMediator:addEffect(effectNode, zOrder)
	if self._effectLayer ~= nil then
		self._effectLayer:addChild(effectNode, zOrder or 0)
	end

	return effectNode
end

function BaseSceneMediator:showToast(toast, options)
	if toast == nil then
		return
	end

	if self._activeToasts == nil then
		self._activeToasts = {}
	end

	local toastsInTheGroup
	local groupName = toast:getGroupName()

	if groupName ~= nil then
		if self._groupedToasts == nil then
			self._groupedToasts = {}
		end

		toastsInTheGroup = self._groupedToasts[groupName]

		if self._groupedToasts[groupName] == nil then
			toastsInTheGroup = {}
			self._groupedToasts[groupName] = toastsInTheGroup
		end
	end

	local layer, frame = self._effectLayer, self._effectFrame

	if not toast:setup(layer, frame, options, toastsInTheGroup) then
		return
	end

	self._activeToasts[toast] = toast

	if toastsInTheGroup ~= nil then
		toastsInTheGroup[#toastsInTheGroup + 1] = toast
	end

	toast:startAnimation(function(theToast)
		self._activeToasts[theToast] = nil

		if toastsInTheGroup ~= nil then
			for i = 1, #toastsInTheGroup do
				if toastsInTheGroup[i] == theToast then
					table.remove(toastsInTheGroup, i)

					break
				end
			end
		end

		theToast:dispose()
	end)
end
