-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmSceneMediator.lua

require("dm.gameplay.touch.TouchEffectWidget")

DmSceneMediator = class("DmSceneMediator", BaseSceneMediator)

function DmSceneMediator:initialize()
	super.initialize(self)
end

function DmSceneMediator:dispose()
	self:disposeTouchEffectWidget()
	super.dispose(self)
end

function DmSceneMediator:onRegister()
	super.onRegister(self)

	self._offsetSize = AdjustUtils.getAdjustOffset()

	if DEBUG == 2 then
		local button = ccui.Button:create()

		button:setPosition(cc.p(300, 600))
		button:offset(self._offsetSize.x, self._offsetSize.y)
		self:getView():addChild(button)
		button:setGlobalZOrder(999999999)
		button:setTitleText("重启刷新")
		button:setScale(2)
		button:setTitleColor(cc.c3b(255, 0, 0))
		button:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				REBOOT()
			end
		end)
		AdjustUtils.adjustLayoutByType(button, AdjustUtils.kAdjustType.Top)

		if AUDIO_DEBUG then
			button = ccui.Button:create()

			button:setPosition(cc.p(300, 570))
			button:offset(self._offsetSize.x, self._offsetSize.y)
			self:getView():addChild(button)
			button:setGlobalZOrder(999999999)
			button:setTitleText("卸载所有音效")
			button:setScale(2)
			button:setTitleColor(cc.c3b(255, 0, 0))
			button:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					dmAudio.releaseAllAcbs()
				end
			end)
			AdjustUtils.adjustLayoutByType(button, AdjustUtils.kAdjustType.Top)
		end
	end

	local leftImage = ccui.ImageView:create()

	leftImage:loadTexture("asset/common/common_screen_bar.jpg", ccui.TextureResType.localType)
	self:getView():addChild(leftImage)
	leftImage:setPosition(cc.p(AdjustUtils.getFixOffsetX() - leftImage:getContentSize().width / 2, 320))

	local winSize = cc.Director:getInstance():getWinSize()
	local rightImage = ccui.ImageView:create()

	rightImage:loadTexture("asset/common/common_screen_bar.jpg", ccui.TextureResType.localType)
	rightImage:setFlippedX(true)
	self:getView():addChild(rightImage)
	rightImage:setPosition(cc.p(winSize.width + rightImage:getContentSize().width / 2 - AdjustUtils.getFixOffsetX(), 320))

	local injector = self:getInjector()

	injector:mapValue("BaseSceneMediator", self, "activeScene")
	self._effectLayer:setPosition(self._offsetSize)
	self._effectLayer:offset(CC_DESIGN_RESOLUTION.width * 0.5, CC_DESIGN_RESOLUTION.height * 0.5)
	self:setupTouchEffectWidget()
end

function DmSceneMediator:popView(popView, options, data)
	super.popView(self, popView, options, data)
	self:viewWillShow(self:getTopViewName())
end

function DmSceneMediator:pushView(areaView, options, data)
	areaView.__enterData = data
	areaView.__options = options

	areaView:setPosition(self._offsetSize)

	local rets

	if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 or GameConfigs.dpsLoggerEnable then
		local t0 = app.getTimeInMilliseconds()

		rets = {
			super.pushView(self, areaView, options, data)
		}

		local t = app.getTimeInMilliseconds()
		local mediator_enter_t = t - t0
		local viewName = areaView.getViewName and areaView:getViewName() or ""

		if not areaView.csloader_t then
			local csloader_t = 0
			local total_t = csloader_t + mediator_enter_t
			local info = string.format("viewName:%s,totalTime:%d ,UITime:%d ,mediatorTime:%d", viewName, total_t, csloader_t, mediator_enter_t)
			local color = cc.c3b(0, 255, 0)

			if total_t > 300 then
				color = cc.c3b(230, 219, 116)
			end

			if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 then
				self:dispatch(ShowStaticTipEvent({
					delay = 5,
					tip = info,
					color = (total_t > 600 or nil) and cc.c3b(255, 0, 0)
				}))
			end

			if GameConfigs.dpsLoggerEnable then
				local content = {
					type = "viewloadtime",
					view = viewName,
					total_t = total_t,
					csloader_t = csloader_t,
					mediator_enter_t = mediator_enter_t
				}

				StatisticSystem:record(LogType.kClient, content)
			end

			areaView.csloader_t = nil
		end
	end

	rets = rets or {
		super.pushView(self, areaView, options, data)
	}

	self:viewWillShow(self:getTopViewName())

	return unpack(rets)
end

function DmSceneMediator:switchView(areaView, options, data)
	areaView.__enterData = data
	areaView.__options = options

	areaView:setPosition(self._offsetSize)

	local rets

	if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 or GameConfigs.dpsLoggerEnable then
		local t0 = app.getTimeInMilliseconds()

		rets = {
			super.switchView(self, areaView, options, data)
		}

		local t = app.getTimeInMilliseconds()
		local mediator_enter_t = t - t0
		local viewName = areaView.getViewName and areaView:getViewName() or ""

		if not areaView.csloader_t then
			local csloader_t = 0
			local total_t = csloader_t + mediator_enter_t
			local info = string.format("viewName:%s,totalTime:%d ,UITime:%d ,mediatorTime:%d", viewName, total_t, csloader_t, mediator_enter_t)
			local color = cc.c3b(0, 255, 0)

			if total_t > 300 then
				color = cc.c3b(230, 219, 116)
			end

			if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 then
				self:dispatch(ShowStaticTipEvent({
					delay = 5,
					tip = info,
					color = (total_t > 600 or nil) and cc.c3b(255, 0, 0)
				}))
			end

			if GameConfigs.dpsLoggerEnable then
				local content = {
					type = "viewloadtime",
					view = viewName,
					total_t = total_t,
					csloader_t = csloader_t,
					mediator_enter_t = mediator_enter_t
				}

				StatisticSystem:record(LogType.kClient, content)
			end

			areaView.csloader_t = nil
		end
	end

	rets = rets or {
		super.switchView(self, areaView, options, data)
	}

	self:viewWillShow(self:getTopViewName())

	return unpack(rets)
end

function DmSceneMediator:showPopup(popupView, options, data, delegate)
	popupView.__enterData = data
	popupView.__delegate = delegate
	popupView.__options = options

	popupView:setPosition(self._offsetSize)

	local rets

	if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 or GameConfigs.dpsLoggerEnable then
		local t0 = app.getTimeInMilliseconds()

		rets = {
			super.showPopup(self, popupView, options, data, delegate)
		}

		local t = app.getTimeInMilliseconds()
		local mediator_enter_t = t - t0
		local viewName = popupView.getViewName and popupView:getViewName() or ""

		if not popupView.csloader_t then
			local csloader_t = 0
			local total_t = csloader_t + mediator_enter_t
			local info = string.format("viewName:%s,totalTime:%d ,UITime:%d ,mediatorTime:%d", viewName, total_t, csloader_t, mediator_enter_t)
			local color = cc.c3b(0, 255, 0)

			if total_t > 300 then
				color = cc.c3b(230, 219, 116)
			end

			if GAME_SHOW_TIMECONSUME or app.pkgConfig.showTimeConsume == 1 then
				self:dispatch(ShowStaticTipEvent({
					delay = 5,
					tip = info,
					color = (total_t > 600 or nil) and cc.c3b(255, 0, 0)
				}))
			end

			if GameConfigs.dpsLoggerEnable then
				local content = {
					type = "viewloadtime",
					view = viewName,
					total_t = total_t,
					csloader_t = csloader_t,
					mediator_enter_t = mediator_enter_t
				}

				StatisticSystem:record(LogType.kClient, content)
			end

			popupView.csloader_t = nil
		end
	end

	rets = rets or {
		super.showPopup(self, popupView, options, data, delegate)
	}

	return unpack(rets)
end

function DmSceneMediator:onClosePopup(event)
	super.onClosePopup(self, event)
end

function DmSceneMediator:collectgarbage()
	return
end

function DmSceneMediator:viewWillShow(name)
	return
end

function DmSceneMediator:setupTouchEffectWidget()
	local injector = self:getInjector()
	local touchEffectView = TouchEffectWidget:createWidgetNode()

	self._touchEffectWidget = injector:injectInto(TouchEffectWidget:new(touchEffectView))

	self:getView():addChild(touchEffectView, GameStyle.touchEffectZorder)
end

function DmSceneMediator:disposeTouchEffectWidget()
	if self._touchEffectWidget then
		self._touchEffectWidget:dispose()

		self._touchEffectWidget = nil
	end
end

function DmSceneMediator:showToast(toast, options)
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

	for i, v in pairs(self._activeToasts) do
		local view = v:getView()

		view:setPositionY(view:getPositionY() + toast:getView():getContentSize().height)

		if view:getPositionY() > AdjustUtils.winSize.height * 0.5 - 20 then
			view:setVisible(false)
		end

		local action = view:getActionByTag(101)

		if action then
			action:setSpeed(action:getSpeed() * 2)
		end
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

function DmSceneMediator:showQueueToast(toast, options)
	if toast == nil then
		return
	end

	local toastsInTheGroup
	local groupName = toast:getGroupName()

	if groupName ~= nil then
		if self._groupedRewardToasts == nil then
			self._groupedRewardToasts = {}
		end

		toastsInTheGroup = self._groupedRewardToasts[groupName]

		if self._groupedRewardToasts[groupName] == nil then
			toastsInTheGroup = {}
			self._groupedRewardToasts[groupName] = toastsInTheGroup
		end
	end

	local layer, frame = self._effectLayer, self._effectFrame

	if not toast:setup(layer, frame, options, toastsInTheGroup) then
		return
	end

	if toastsInTheGroup ~= nil then
		toastsInTheGroup[#toastsInTheGroup + 1] = toast
	end

	if toastsInTheGroup ~= nil and #toastsInTheGroup > 1 then
		return
	end

	local func

	function func(theToast)
		if toastsInTheGroup ~= nil then
			for i = 1, #toastsInTheGroup do
				if toastsInTheGroup[i] == theToast then
					table.remove(toastsInTheGroup, i)

					break
				end
			end
		end

		theToast:dispose()

		if #toastsInTheGroup > 0 then
			toastsInTheGroup[1]:startAnimation(func)
		end
	end

	toast:startAnimation(func)
end

function DmSceneMediator:popToIndexView(targetIndex, viewData)
	local topIndex = #self._areaViewStack

	targetIndex = targetIndex or 0
	targetIndex = topIndex < targetIndex and topIndex or targetIndex
	targetIndex = targetIndex < 0 and topIndex + targetIndex or targetIndex
	targetIndex = targetIndex < 0 and 0 or targetIndex

	local removals = {}

	while targetIndex < topIndex do
		local topAreaInfo = self._areaViewStack[topIndex]

		topAreaInfo._index = topIndex
		removals[#removals + 1] = topAreaInfo
		topIndex = topIndex - 1
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

	topIndex = #self._areaViewStack

	local prevAreaInfo = self._areaViewStack[#self._areaViewStack]
	local targetAreaMediator

	if prevAreaInfo ~= nil then
		targetAreaMediator = prevAreaInfo.mediator

		prevAreaInfo.rootNode:setVisible(true)
	end

	if targetAreaMediator ~= nil then
		targetAreaMediator:resumeWithData(viewData)

		if targetAreaMediator ~= nil and DisposableObject:isDisposed(targetAreaMediator) then
			targetAreaMediator = nil
		end
	end

	if targetAreaMediator ~= nil then
		targetAreaMediator:willStartResumeTransition()
	end

	for i = 1, #removals do
		local topAreaMediator = removals[i].mediator

		if topAreaMediator ~= nil then
			topAreaMediator:willStartExitTransition()
		end
	end

	for i = 1, #removals do
		local topArea = removals[i]

		if topArea.mediator ~= nil then
			topArea.mediator:didFinishExitTransition()
		end

		self._viewLayer:removeChild(topArea.rootNode)
	end

	if targetAreaMediator ~= nil then
		targetAreaMediator:didFinishResumeTransition()
		self:viewWillShow(self:getTopViewName())
	end
end
