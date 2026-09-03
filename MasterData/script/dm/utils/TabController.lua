-- chunkname: @/tmp/or_script/lua_compile/dm/utils/TabController.lua

TabController = class("TabController", _G.DisposableObject, _M)

TabController:has("_openSound", {
	is = "rw"
})

local darkZorder = -200
local lightZorder = 900

TabClickAnswerState = {
	kBegan = 1,
	kEnd = 2,
	kNone = 3
}

function TabController:initialize(buttons, singleClickDelegate, style)
	assert(buttons ~= nil and type(buttons) == "table", "error:buttons invalid")

	self._buttons = buttons
	self._singleClickDelegate = singleClickDelegate

	super.initialize(self)

	self._curButton = nil
	self._invalidButtons = nil
	self._openSound = false
	style = style or {}
	self._clickState = style.clickState or TabClickAnswerState.kBegan
	self._clickSound = style.sound or "Se_Click_Tab_1"
	self._ignoreRepeatClick = style.ignoreRepeatClick
	self._buttonDelegate = style.buttonClick
	self._fontStyle = style.fontStyle
	self._showAnim = style.showAnim

	self:_setupTabs()
end

function TabController:refreshView(buttons, singleClickDelegate)
	self._buttons = buttons
	self._singleClickDelegate = self._singleClickDelegate or singleClickDelegate
	self._curButton = nil
	self._invalidButtons = nil

	self:_setupTabs()
end

function TabController:selectTabByTag(buttonTag, data)
	for _, button in pairs(self._buttons) do
		if button:getTag() == buttonTag then
			self:_trySelectTab(button, data)

			break
		end
	end
end

function TabController:refreshSelectBtn(button)
	if self._invalidButtons == nil or table.find(self._invalidButtons, button) == nil then
		self._curButton = button
	end

	self:_updateTabs()
end

function TabController:setInvalidButtons(invalidButtons)
	self._invalidButtons = invalidButtons
end

function TabController:refreshBtnZorder(buttonTag)
	for _, button in pairs(self._buttons) do
		if button:getTag() == buttonTag then
			button:setLocalZOrder(lightZorder)
		else
			button:setLocalZOrder(darkZorder)
		end
	end
end

function TabController:refreshTabImagesVisible(button, isLight)
	local indexTag = button.index

	for index = 1, 2 do
		local lightNode = button:getChildByName("light_" .. index)
		local darkNode = button:getChildByName("dark_" .. index)

		if lightNode then
			lightNode:setLocalZOrder(lightZorder + indexTag)
			lightNode:setVisible(isLight)

			if self._showAnim == 1 then
				self:showBtnAnim1(lightNode, isLight)
			elseif self._showAnim == 2 then
				self:showBtnAnim2(lightNode, isLight)
			end
		end

		if darkNode then
			darkNode:setVisible(not isLight)
			darkNode:setLocalZOrder(darkZorder + indexTag)
		end
	end

	local abObjectNode = button:getChildByName("abObject")

	if abObjectNode then
		abObjectNode:setLocalZOrder(1000)

		if abObjectNode:getDescription() == "Label" and self._fontStyle then
			if isLight then
				if not self._fontStyle.light[1] then
					local fontColor = self._fontStyle.dark[1]

					if isLight then
						if not self._fontStyle.light[2] then
							local fontOutline = self._fontStyle.dark[2]

							if isLight then
								if not self._fontStyle.light[3] then
									local fontOutlineShadow = self._fontStyle.dark[3]

									abObjectNode:setTextColor(fontColor)
									abObjectNode:enableOutline(fontOutline, fontOutlineShadow)
								end
							end
						end
					end
				end
			end
		end
	end
end

function TabController:showBtnAnim1(lightNode, isLight)
	lightNode:getChildByName("text"):enableOutline(cc.c4b(69, 35, 6, 255), 2)
	lightNode:getChildByName("text"):setTextColor(cc.c3b(255, 255, 255))

	if not lightNode:getChildByName("Anim") then
		local anim = cc.MovieClip:create("dh_anniuxiaoguo")

		anim:addTo(lightNode)
		anim:setName("Anim")
		anim:addEndCallback(function()
			anim:stop()
		end)
		anim:addCallbackAtFrame(10, function()
			lightNode:getChildByName("text"):disableEffect(1)
			lightNode:getChildByName("text"):enableOutline(cc.c4b(57, 75, 10, 255), 2)
			lightNode:getChildByName("text"):setTextColor(cc.c3b(223, 255, 4))
		end)
		anim:stop()
		anim:setLocalZOrder(1)
		lightNode:getChildByName("text"):setLocalZOrder(2)
		anim:setPosition(cc.p(47, 65))
	end

	if isLight then
		lightNode:getChildByName("Anim"):gotoAndPlay(0)
	end
end

function TabController:showBtnAnim2(lightNode, isLight)
	local text = lightNode:getChildByName("text")
	local text1 = lightNode:getChildByName("text1")

	text:stopAllActions()
	text:setVisible(true)
	text:setScale(1)
	text:setOpacity(255)
	text1:stopAllActions()
	text1:setVisible(true)
	text1:setScale(1)
	text1:setOpacity(255)
	text1:setPosition(cc.p(75, 77))
	text1:setColor(cc.c3b(110, 108, 108))

	if not lightNode:getChildByName("Anim") then
		local anim = cc.MovieClip:create("fang_anniu")

		anim:setPlaySpeed(1.2)
		anim:addTo(lightNode)
		anim:setName("Anim")
		anim:addCallbackAtFrame(23, function()
			text:setVisible(false)
			text1:setVisible(false)
			lightNode:getChildByFullName("text1"):setColor(cc.c3b(101, 126, 32))
		end)
		anim:addCallbackAtFrame(24, function()
			local callFunc = cc.CallFunc:create(function()
				text:setVisible(true)
				text:setScale(1.2)
				text:setOpacity(125)
			end)
			local fadeIn = cc.FadeIn:create(0.16666666666666666)
			local scaleTo = cc.ScaleTo:create(0.16666666666666666, 1)
			local spawn = cc.Spawn:create(fadeIn, scaleTo)
			local seq = cc.Sequence:create(callFunc, spawn)

			text:runAction(seq)

			local callFunc1 = cc.CallFunc:create(function()
				text1:setVisible(true)
				text1:setScale(1.2)
				text1:setOpacity(125)
				text1:setPosition(cc.p(75, 70))
			end)
			local fadeIn = cc.FadeIn:create(0.13333333333333333)
			local moveTo = cc.MoveTo:create(0.13333333333333333, cc.p(75, 77))
			local scaleTo = cc.ScaleTo:create(0.13333333333333333, 1)
			local spawn = cc.Spawn:create(fadeIn, moveTo, scaleTo)
			local seq = cc.Sequence:create(callFunc1, spawn)

			text1:runAction(seq)
		end)
		anim:addCallbackAtFrame(32, function()
			anim:stop()
		end)
		anim:gotoAndStop(18)
		anim:setLocalZOrder(1)
		lightNode:getChildByName("text"):setLocalZOrder(3)
		lightNode:getChildByName("text1"):setLocalZOrder(2)
		anim:setPosition(cc.p(73, 73))
	end

	if isLight then
		lightNode:getChildByName("Anim"):gotoAndPlay(18)
	end
end

function TabController:resetBtnState(button)
	self:_dealTabImages(button, false)
end

function TabController:setSelectButton(btn)
	self._curButton = btn
end

function TabController:_setupTabs()
	for _, button in pairs(self._buttons) do
		button:addTouchEventListener(function(sender, eventType)
			if sender == self._curButton and not self._ignoreRepeatClick then
				return
			end

			if self._buttonDelegate then
				self._buttonDelegate(sender, eventType, sender:getTag())

				if eventType == ccui.TouchEventType.ended then
					self:playSound()
				end
			elseif self._singleClickDelegate then
				if eventType == ccui.TouchEventType.began then
					if self._clickState == TabClickAnswerState.kBegan then
						self:_trySingleClick(button)
					end
				elseif eventType == ccui.TouchEventType.canceled then
					self:_updateTabs()
				elseif eventType == ccui.TouchEventType.ended and self._clickState == TabClickAnswerState.kEnd then
					self:_trySingleClick(button)
				end
			end
		end)
	end
end

function TabController:_trySelectTab(button, data)
	assert(button ~= nil, "error:button=nil")

	if self._singleClickDelegate then
		self._singleClickDelegate(button:getName(), button:getTag(), data)
	end

	if self._buttonDelegate then
		self._buttonDelegate(button, ccui.TouchEventType.began, button:getTag(), data)
		self._buttonDelegate(button, ccui.TouchEventType.ended, button:getTag(), data)
	end

	self:refreshSelectBtn(button)
	self:playSound()
end

function TabController:playSound()
	if self._openSound == true then
		-- block empty
	end

	self._openSound = true
end

function TabController:_trySingleClick(button)
	assert(button ~= nil, "error:button=nil")

	if self._singleClickDelegate and self._singleClickDelegate(button:getName(), button:getTag()) == false then
		return
	end

	self:_dealTabImages(button, true)
	self:refreshSelectBtn(button)
	self:playSound()
end

function TabController:_updateTabs()
	for index, button in pairs(self._buttons) do
		button.index = index

		self:_dealTabImages(button, button == self._curButton)
	end
end

function TabController:_dealTabImages(button, isLight)
	if self._invalidButtons and table.find(self._invalidButtons, button) then
		button:setBright(true)
		self:refreshTabImagesVisible(button, false)

		return
	end

	self:refreshTabImagesVisible(button, isLight)
end
