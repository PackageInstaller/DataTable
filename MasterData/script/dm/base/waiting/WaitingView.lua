-- chunkname: @/tmp/or_script/lua_compile/dm/base/waiting/WaitingView.lua

if not _G.cancelDelayCall then
	local function cancelDelayCall(entry)
		if entry ~= nil then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(entry)
		end
	end

	if not _G.delayCallByTime then
		local function delayCallByTime(delayMilliseconds, func, ...)
			local callFunc = func
			local arglist = {
				n = select("#", ...),
				...
			}
			local animTickEntry

			local function timeUp(time)
				if animTickEntry ~= nil then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(animTickEntry)

					animTickEntry = nil

					if arglist ~= nil and arglist.n > 0 then
						callFunc(unpack(arglist, 1, arglist.n))
					else
						callFunc()
					end
				end
			end

			local delay = (delayMilliseconds or 0) * 0.001

			animTickEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(timeUp, delay, false)

			return animTickEntry
		end

		WaitingView = WaitingView or {}

		local __waitingView

		WaitingStyle = {
			kLoading = 1,
			kTipInfo = 2,
			kLoadingAndTip = 3
		}

		function WaitingView:new()
			local result = setmetatable({}, {
				__index = WaitingView
			})

			result:initialize()

			return result
		end

		function WaitingView:getInstance()
			if __waitingView == nil then
				__waitingView = WaitingView:new()
			end

			return __waitingView
		end

		function WaitingView:initialize()
			self._touchCallback = nil
			self._inShow = false
			self._widgets = {}
			self._tipText = nil

			self:setupView()
		end

		function WaitingView:dispose()
			if self._delayShowTask then
				cancelDelayCall(self._delayShowTask)

				self._delayShowTask = nil
			end
		end

		function WaitingView:isVisible()
			return self._inShow
		end

		function WaitingView:getSwallowTouches()
			return self._swallowTouches
		end

		function WaitingView:setSwallowTouches(value)
			self._swallowTouches = value
		end

		function WaitingView:setupView()
			local view = cc.Node:create()
			local winSize = cc.Director:getInstance():getWinSize()
			local touchMaskLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 180), winSize.width, winSize.height)

			touchMaskLayer:setAnchorPoint(cc.p(0.5, 0.5))
			touchMaskLayer:setIgnoreAnchorPointForPosition(false)
			touchMaskLayer:setTouchEnabled(true)
			touchMaskLayer:registerScriptTouchHandler(function(eventType, x, y)
				if touchMaskLayer == nil or not touchMaskLayer:isVisible() then
					return false
				end

				if eventType == "began" then
					-- block empty
				elseif eventType == "ended" and self._touchCallback then
					local callback = self._touchCallback

					self._touchCallback = nil

					callback()
				end

				return self._swallowTouches
			end, false, -1, true)
			touchMaskLayer:addTo(view):setName("mask_layer")
			view:setPosition(winSize.width * 0.5, winSize.height * 0.5)
			cc.Director:getInstance():setNotificationNode(view)

			self._view = view
			self._touchMaskLayer = touchMaskLayer
		end

		function WaitingView:show(type, data)
			local widget = self._widgets[type]

			if widget == nil then
				widget = self:createWidget(type)
				self._widgets[type] = widget
			end

			self._touchCallback = data and data.onTouch

			self._touchMaskLayer:setVisible(true)

			self._swallowTouches = true

			local function showWidgets()
				for widgetType, widget in pairs(self._widgets) do
					if widgetType == type then
						widget:show(data)
					else
						widget:hide(data)
					end
				end
			end

			if self._delayShowTask then
				cancelDelayCall(self._delayShowTask)

				self._delayShowTask = nil
			end

			local delay = data and data.delay

			if delay then
				self._touchMaskLayer:setOpacity(0)

				self._delayShowTask = delayCallByTime(delay, function()
					self._delayShowTask = nil

					self._touchMaskLayer:setOpacity(0)
					showWidgets()
				end)
			else
				self._touchMaskLayer:setOpacity(0)
				showWidgets()
			end

			self._inShow = true
		end

		function WaitingView:hide()
			if self._delayShowTask then
				cancelDelayCall(self._delayShowTask)

				self._delayShowTask = nil
			end

			for widgetType, widget in pairs(self._widgets) do
				widget:setVisible(false)
			end

			self._touchMaskLayer:setVisible(false)

			self._touchCallback = nil
		end

		function WaitingView:setTipsString(text)
			if self._tipText then
				self._tipText:setString(text)
			end
		end

		function WaitingView:createWidget(type)
			local widget

			if type == WaitingStyle.kLoading then
				widget = cc.MovieClip:create("mengjingbbb_mingzi")

				widget:gotoAndPlay(1)

				function widget.show(widget, data)
					widget:setVisible(true)
				end

				function widget.hide(widget, data)
					widget:setVisible(false)
				end
			elseif type == WaitingStyle.kTipInfo then
				widget = cc.Node:create()

				local bg = ccui.Scale9Sprite:createWithSpriteFrameName("tips.png")

				bg:setCapInsets(cc.rect(5, 5, 5, 5))
				bg:setAnchorPoint(cc.p(0.5, 0.5))
				bg:setContentSize(cc.size(310, 94))

				local winSize = cc.Director:getInstance():getWinSize()

				bg:setPosition(cc.p(winSize.width * 0.5, winSize.height * 0.5))
				bg:addTo(widget):center(widget:getContentSize()):setName("bg")

				local tipText = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 20)

				tipText:setColor(cc.c3b(255, 255, 255))
				tipText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
				tipText:addTo(bg):center(bg:getContentSize()):offset(0, 0):setName("tip_text")
				tipText:setOverflow(cc.LabelOverflow.SHRINK)
				tipText:setDimensions(bg:getContentSize().width - 10, bg:getContentSize().height - 10)

				self._tipText = tipText

				function widget.show(widget, data)
					if data then
						widget:stopAllActions()
						widget:setVisible(true)

						if data.tip then
							local tipText = widget:getChildByFullName("bg.tip_text")

							if tipText then
								local tipStr = data.tip
								local errStr

								if data.errCode then
									errStr = tostring(data.errCode)

									if data.detail then
										errStr = errStr .. ":" .. data.detail
									end
								end

								if errStr then
									tipStr = string.format("%s\n(%s)", tipStr, tostring(errStr))
								end

								tipText:setString(tipStr)

								self._tipText = tipText
							end
						end

						if not data.noAction then
							widget:setScale(0.5)
							widget:setOpacity(122)

							local scaleAct = cc.ScaleTo:create(0.2, 1)
							local fadeInAct = cc.FadeIn:create(0.2)
							local action = cc.Spawn:create(scaleAct, fadeInAct)

							widget:runAction(action)
						else
							widget:setScale(1)
							widget:setOpacity(255)
						end
					end
				end

				function widget.hide(widget, data)
					widget:setVisible(false)
					widget:stopAllActions()
				end
			elseif type == WaitingStyle.kLoadingAndTip then
				widget = cc.Node:create()

				local bg = ccui.Scale9Sprite:createWithSpriteFrameName("tips.png")

				bg:setCapInsets(cc.rect(5, 5, 5, 5))
				bg:setAnchorPoint(cc.p(0.5, 0.5))
				bg:setContentSize(cc.size(310, 94))

				local winSize = cc.Director:getInstance():getWinSize()

				bg:setPosition(cc.p(winSize.width * 0.5, winSize.height * 0.5))
				bg:addTo(widget):center(widget:getContentSize()):setName("bg")

				local tipText = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 20)

				tipText:setColor(cc.c3b(255, 255, 255))
				tipText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
				tipText:addTo(bg):center(bg:getContentSize()):offset(0, 65):setName("tip_text")

				local anim = cc.MovieClip:create("mengjingbbb_mingzi")

				anim:gotoAndPlay(0)
				anim:setScale(0.6)
				anim:addTo(bg):center(bg:getContentSize()):offset(0, 0)

				function widget.show(widget, data)
					if data then
						widget:stopAllActions()
						widget:setVisible(true)

						if data.tip then
							local tipText = widget:getChildByFullName("bg.tip_text")

							if tipText then
								local tipStr = data.tip
								local errStr

								if data.errCode then
									errStr = tostring(data.errCode)

									if data.detail then
										errStr = errStr .. ":" .. data.detail
									end
								end

								if errStr then
									tipStr = string.format("%s\n(%s)", tipStr, tostring(errStr))
								end

								tipText:setString(tipStr)
							end

							self._tipText = tipText
						end

						if not data.noAction then
							widget:setScale(0.5)
							widget:setOpacity(122)

							local scaleAct = cc.ScaleTo:create(0.2, 1)
							local fadeInAct = cc.FadeIn:create(0.2)
							local action = cc.Spawn:create(scaleAct, fadeInAct)

							widget:runAction(action)
						else
							widget:setScale(1)
							widget:setOpacity(255)
						end
					end
				end

				function widget.hide(widget, data)
					widget:setVisible(false)
					widget:stopAllActions()
				end
			end

			widget:addTo(self._view)
			widget:setVisible(false)

			return widget
		end
	end
end
