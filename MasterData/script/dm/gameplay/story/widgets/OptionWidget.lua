-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/OptionWidget.lua

OptionWidget = class("OptionWidget", BaseWidget)

local kOptionDistanceX = 30
local kOptionDistanceY = 70
local kFirstOptionPosX = 628
local kFirstOptionPosY = {
	363,
	398,
	434,
	470
}

function OptionWidget:initialize(view)
	super.initialize(self, view)

	local winSize = cc.Director:getInstance():getVisibleSize()

	view:setContentSize(winSize)
end

function OptionWidget:dispose()
	super.dispose(self)
	self:releseSchedule()
end

function OptionWidget:setupView()
	local view = self:getView()
	local touchLayer = view:getChildByFullName("touch_layer")

	touchLayer:setTouchEnabled(true)
	touchLayer:addTouchEventListener(function(sender, eventType)
		self:onClickNext(sender, eventType)
	end)
end

function OptionWidget:updateView(data, onEnd)
	self._optionLibId = data.option
	self._onEnd = onEnd

	local translateMap = data.translateMap
	local isLeft = data.isLeft
	local view = self:getView()
	local mainPanel = view:getChildByFullName("main")
	local bg = mainPanel:getChildByName("bg")
	local leftNameText = view:getChildByFullName("main.left_name_text")
	local rightNameText = view:getChildByFullName("main.right_name_text")
	local leftPortraitParent = view:getChildByFullName("main.left_renderNode")
	local rightPortraitParent = view:getChildByFullName("main.right_renderNode")
	local leftNextImg = view:getChildByFullName("main.left_next_img")
	local rightNextImg = view:getChildByFullName("main.right_next_img")
	local nameText, portraitParent, offset

	if isLeft then
		leftNameText:setVisible(true)
		rightNameText:setVisible(false)
		leftPortraitParent:setVisible(true)
		rightPortraitParent:setVisible(false)
		leftNextImg:setVisible(true)
		rightNextImg:setVisible(false)

		nameText = leftNameText
		portraitParent = leftPortraitParent

		bg:setScaleX(1)

		offset = 100
	else
		rightNameText:setVisible(true)
		leftNameText:setVisible(false)
		rightPortraitParent:setVisible(true)
		leftPortraitParent:setVisible(false)
		leftNextImg:setVisible(false)
		rightNextImg:setVisible(true)

		nameText = rightNameText
		portraitParent = rightPortraitParent

		bg:setScaleX(-1)

		offset = -200
	end

	if data.name then
		nameText:setVisible(true)
		nameText:setString(data.name)
	else
		nameText:setVisible(false)
	end

	if data.modelId then
		local rolePic = IconFactory:createRoleIconSpriteNew({
			iconType = 2,
			id = data.modelId
		})

		rolePic:addTo(portraitParent)
	end

	self._contents = {}

	if type(data.content) == "string" then
		self._contents[1] = data.content
	else
		self._contents = data.content
	end

	local cellTemplate = view:getChildByFullName("cell")

	if data.option then
		self:clearOption()

		local optionData = ConfigReader:getRecordById("OptionLib", data.option)
		local optionNum = data.optionNums

		self._option = {}
		self._cells = {}

		local firstOptionPosY = kFirstOptionPosY[optionNum]

		for i = 1, optionNum do
			local option

			if optionData.Must[i] then
				option = optionData.Must[i]
			else
				local randomIndex = math.random(1, #optionData.Random)

				option = optionData.Random[randomIndex]
			end

			local cell = cellTemplate:clone()

			cell:setTag(i)

			local text = cell:getChildByFullName("text")
			local posX = kFirstOptionPosX + (i - 1) * kOptionDistanceX + offset
			local posY = firstOptionPosY - (i - 1) * kOptionDistanceY
			local content = ConfigReader:getDataByNameIdAndKey("Option", option, "Words")

			text:setString(Strings:get(content, translateMap))
			cell:addTo(mainPanel):posite(posX, posY)
			IconFactory:bindClickAction(cell, function()
				self:onClickOption(cell)
			end)

			self._cells[i] = cell
			self._option[i] = option
		end

		if data.hideOption then
			self._option[optionNum + 1] = optionData.Hidden

			local time = view:getChildByFullName("main.time_bg.time")
			local timeNum = optionData.HiddenTime

			time:setString(timeNum)

			local function onTick()
				timeNum = timeNum - 1

				if timeNum < 0 then
					self:selectOption(#self._option)

					return
				end

				time:setString(timeNum)
			end

			self._timeScheduler = LuaScheduler:getInstance():schedule(onTick, 1)
		else
			local timeBg = view:getChildByFullName("main.time_bg")

			timeBg:setVisible(false)
		end
	end

	self._index = 0
	self._isLeft = data.isLeft

	self:next()
end

kTypeOutInterval = 0.03

local kTypeWirterActionTag = 65536

function OptionWidget:next()
	local view = self:getView()

	if self._index >= #self._contents then
		return false
	end

	self._index = self._index + 1

	local nextImg = self._isLeft and view:getChildByFullName("main.left_next_img") or view:getChildByFullName("main.right_next_img")
	local content = self._contents[self._index]
	local contentRect = view:getChildByFullName("main.content_rect")
	local contentText = self._contentText

	if contentText == nil then
		local contentTextParent = contentRect:getParent()

		contentText = ccui.RichText:createWithXML(content, {
			fontName_FONT_1 = CUSTOM_TTF_FONT_1,
			fontName_FONT_2 = CUSTOM_TTF_FONT_2,
			fontName_FZYH_R = TTF_FONT_FZYH_R,
			fontName_FZYH_M = TTF_FONT_FZYH_M
		})

		contentText:setWrapMode(1)
		contentText:ignoreContentAdaptWithSize(false)
		contentText:setAnchorPoint(contentRect:getAnchorPoint())
		contentText:addTo(contentTextParent):posite(contentRect:getPosition()):setName("content_text")

		function contentText.playTypeWriter(contentText)
			nextImg:setVisible(false)
			contentText:stopActionByTag(kTypeWirterActionTag)
			contentText:clipContent(0, 0)

			local contentLen = contentText:getContentLength()
			local typeOutAction = TypeWriterAction:new(kTypeOutInterval, contentLen)
			local callFuncAction = cc.CallFunc:create(function()
				nextImg:setVisible(true)
			end)
			local action = cc.Sequence:create(typeOutAction, callFuncAction)

			action:setTag(kTypeWirterActionTag)
			contentText:runAction(action)
		end

		function contentText.finishTypeWriter(contentText)
			contentText:stopActionByTag(kTypeWirterActionTag)
			contentText:clipContent()
			contentText:renderContent()
			nextImg:setVisible(true)
		end

		function contentText.isTypeWriting(contentText)
			local action = contentText:getActionByTag(kTypeWirterActionTag)

			return action ~= nil
		end

		self._contentText = contentText
	else
		contentText:setString(content)
		contentText:clipContent()
	end

	local contentLineNum = contentText:getLineCount()

	contentText:renderContent(contentRect:getContentSize().width, 0, true)

	local contentLineNum = contentText:getLineCount()

	if contentLineNum == 1 then
		contentText:setAnchorPoint(cc.p(0, 0))
	else
		contentText:setAnchorPoint(cc.p(0, 0.5))
	end

	contentText:posite(contentRect:getPosition())
	contentText:playTypeWriter()

	return true
end

function OptionWidget:clearOption()
	if self._cells then
		for k, v in pairs(self._cells) do
			v:removeFromParent(true)
		end
	end

	self._cells = nil
end

function OptionWidget:onClickOption(sender)
	if self:getView():isVisible() == false then
		return
	end

	if self._contentText:isTypeWriting() then
		self._contentText:finishTypeWriter()
	else
		local tag = sender:getTag()

		self:selectOption(tag)
	end
end

function OptionWidget:selectOption(index)
	local optionId = self._option[index]
	local optionData = ConfigReader:getRecordById("Option", optionId)

	self:releseSchedule()

	if self._onEnd then
		self._onEnd(self._optionLibId, optionId)
	end

	self:getView():setVisible(false)
end

function OptionWidget:releseSchedule()
	if self._timeScheduler then
		LuaScheduler:getInstance():unschedule(self._timeScheduler)

		self._timeScheduler = nil
	end
end

function OptionWidget:onClickNext(sender, eventType)
	if self._contentText == nil then
		return
	end

	if eventType == ccui.TouchEventType.ended and self._contentText:isTypeWriting() then
		self._contentText:finishTypeWriter()
	end
end
