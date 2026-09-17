TalkBubbleSprite = class("TalkBubbleSprite", function()
	return ccui.Button:create()
end)
EMOJI_PATH = "emoji/"

function TalkBubbleSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local var_2_0 = TalkBubbleSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)

	return var_2_0
end

function TalkBubbleSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	if arg_3_1 == nil or arg_3_1 == "" then
		arg_3_1 = " "
	end

	if arg_3_2 == nil then
		arg_3_2 = 24
	end

	if arg_3_3 == nil then
		arg_3_3 = 1
	end

	if arg_3_6 == nil then
		arg_3_6 = 1
	end

	if arg_3_4 == nil then
		arg_3_4 = 1
	end

	if pos == nil then
		pos = cc.p(0, 0)
	end

	self.fontSize = arg_3_2
	self.direction = arg_3_3
	self.emojiType = arg_3_6
	self.emojiScale = arg_3_4
	self.pos = pos
	self.delay = arg_3_5
	self.callBack = arg_3_7
	self.bubble = nil
	self.lengthLabel = cc.Label:createWithTTF("", "fonts/new1.ttf", self.fontSize)

	self.lengthLabel:setVisible(false)
	self:addChild(self.lengthLabel)

	self.wordList = {}
	self.imageList = {}
	self.orderList = {}
	self.lineHeight = {}
	self.lineHeightCount = 0
	self.maxLineLength = 200

	self:transcoding(arg_3_1)

	self.colSpace = self.fontSize / 2
	self.width = self.colSpace * 2

	if #self.imageList == 1 and #self.orderList == 1 then
		self:printEmoji()

		return
	end

	for iter_3_0, iter_3_1 in pairs(self.orderList) do
		if iter_3_1 == 2 then
			break
		end

		if iter_3_0 == #self.orderList then
			self:setMaxLength()
		end
	end

	self.image = {}
	self.imageIndex = 1
	self.imageCount = 0
	self.lineSpace = 5
	self.top = 15
	self.maxHeight = 0
	self.maxWidth = 0
	self.height = 0
	self.scale = cc.p(1, 1)

	if #self.orderList > 0 then
		local var_3_0 = 1

		for iter_3_2 = 1, #self.orderList do
			if self.orderList[iter_3_2] == 0 then
				var_3_0 = var_3_0 + 1
			end
		end

		self.height = (self.lineSpace + self.fontSize) * var_3_0 + self.top
	end

	local var_3_2 = 0
	local var_3_3 = 0

	for iter_3_3 = 1, #self.orderList do
		if self.orderList[iter_3_3] == 1 then
			var_3_3 = var_3_3 + self:getWordWidth(self.wordList[1], self.fontSize)
		end

		if self.orderList[iter_3_3] == 2 then
			local var_3_5 = self:getImageSize(EMOJI_PATH .. self.imageList[1] .. ".png")

			var_3_5.width = var_3_5.width * self.emojiScale
			var_3_5.height = var_3_5.height * self.emojiScale

			if var_3_2 < var_3_5.height then
				var_3_2 = var_3_5.height
			end

			var_3_3 = var_3_3 + var_3_5.width
		end

		if self.orderList[iter_3_3] == 0 or iter_3_3 == #self.orderList then
			if var_3_2 > self.fontSize then
				self.height = self.height + var_3_2 - self.fontSize
				self.lineHeightCount = self.lineHeightCount + 1
				self.lineHeight[self.lineHeightCount] = var_3_2
			else
				self.lineHeightCount = self.lineHeightCount + 1
				self.lineHeight[self.lineHeightCount] = self.fontSize
			end

			if self.width < var_3_3 + self.colSpace * 2 then
				self.width = var_3_3 + self.colSpace * 2
			end

			var_3_2 = 0
			var_3_3 = 0
		end
	end

	if self.delay ~= 0 then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(self.delay), cc.CallFunc:create(function()
			self:touchDisappear(self.callBack, "timeOut")
		end)))
	end

	if #self.orderList == 1 and self.orderList[1] == 2 then
		self:talk(2)
	else
		self:talk(1)
	end

	self.bubble:setTouchEnabled(false)
end

function TalkBubbleSprite:setMaxLength(arg_5_1)
	local var_5_0 = {}
	local var_5_1 = {}

	local function var_5_3(arg_7_0)
		if self:getWordWidth(arg_7_0, self.fontSize) > self.maxLineLength then
			local var_7_0 = 1

			while 0 < self.maxLineLength do
				local var_7_1 = subStringGetByteCount(arg_7_0, var_7_0)

				self.lengthLabel:setString(string.sub(arg_7_0, var_7_0, var_7_0 + var_7_1 - 1))

				local var_7_2 = 0 + self.lengthLabel:getContentSize().width

				var_7_0 = var_7_0 + var_7_1
			end

			local var_7_3 = var_7_0 - 1

			var_5_0[#var_5_0 + 1] = string.sub(arg_7_0, 1, var_7_0 - 1)

			if string.sub(arg_7_0, var_7_3 + 1, #arg_7_0) ~= "" then
				var_5_1[#var_5_1 + 1] = 0
			end

			var_5_1[#var_5_1 + 1] = 1

			var_5_3(string.sub(arg_7_0, var_7_3 + 1, #arg_7_0))
		else
			var_5_0[#var_5_0 + 1] = arg_7_0
		end
	end

	for iter_5_0, iter_5_1 in pairs(self.orderList) do
		var_5_1[#var_5_1 + 1] = self.orderList[iter_5_0]

		if self.orderList[iter_5_0] == 0 or iter_5_0 == #self.orderList then
			var_5_3(self.wordList[1])
		end
	end

	self.wordList = {}
	self.orderList = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		self.wordList[#self.wordList + 1] = iter_5_3
	end

	for iter_5_4, iter_5_5 in pairs(var_5_1) do
		self.orderList[#self.orderList + 1] = iter_5_5
	end
end

function TalkBubbleSprite:talk(arg_8_1)
	if arg_8_1 == 2 then
		-- block empty
	end

	if arg_8_1 == 1 then
		self.bubble = ccui.Button:create("mainScenebg/word_bg.png", "mainScenebg/word_bg.png", "mainScenebg/word_bg.png")

		if self.direction == 1 then
			self.bubble:setAnchorPoint(cc.p(0, 0))
		else
			self.bubble:setAnchorPoint(cc.p(1, 0))
		end

		self.bubble:setFlippedY(true)

		self.scale.height = self.height / self.bubble:getContentSize().height
		self.height = self.height + 17

		self.bubble:setScale9Enabled(true)

		self.scale.width = self.width / self.bubble:getContentSize().width

		self.bubble:setCapInsets(cc.rect(65, 20, 30, 10))
		self.bubble:setScale(0.1)
	end

	if self.delay == 0 then
		self.bubble:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.bubble:setTouchEnabled(false)
			self:stopAllActions()
			self:touchDisappear(self.callBack, "touch")
		end)
	end

	self.bubble:setPosition(cc.p(0, 0))

	if self.direction == -1 then
		self.bubble:setFlippedX(true)
	end

	local var_8_0 = self.bubble:getContentSize().width
	local var_8_1 = self.bubble:getContentSize().height
	local var_8_2 = 122
	local var_8_3 = 67

	if arg_8_1 == 2 then
		self.bubble:setScale(self.scale.width, self.scale.height)
	else
		if var_8_2 < self.width then
			var_8_2 = self.width
		end

		if var_8_3 < self.height then
			var_8_3 = self.height
		end

		self.bubble:setContentSize(cc.size(var_8_2, var_8_3))
	end

	self:addChild(self.bubble)
	self.bubble:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 1.5), cc.ScaleTo:create(0.1, 1)))

	local var_8_6 = self.bubble:getPositionX() + self.colSpace
	local var_8_7 = 0

	var_8_7 = arg_8_1 == 1 and self.bubble:getPositionY() + self.height - self.fontSize - self.top + 289 / self.height or self.bubble:getPositionY() + var_8_1 * self.scale.height - self.fontSize - self.top

	local var_8_8 = 0

	self.lineHeightCount = 1

	if self.lineHeight[self.lineHeightCount] > self.fontSize then
		var_8_7 = var_8_7 - self.lineHeight[self.lineHeightCount] + self.fontSize
	end

	for iter_8_0 = 1, #self.orderList do
		if self.orderList[iter_8_0] == 1 then
			var_8_8 = var_8_8 + 1

			local var_8_10 = cc.Label:createWithTTF(self.wordList[var_8_8], "fonts/new1.ttf", self.fontSize)

			var_8_10:setAnchorPoint(cc.p(0, 0))
			var_8_10:setPosition(cc.p(var_8_6, var_8_7))
			var_8_10:setColor(cc.c3b(219, 228, 255))
			self.bubble:addChild(var_8_10)

			var_8_6 = var_8_6 + self:getWordWidth(self.wordList[var_8_8], self.fontSize)
		end

		if self.orderList[iter_8_0] == 2 then
			local var_8_11 = self.image[self.imageIndex]

			self.image[self.imageIndex]:setAnchorPoint(cc.p(0, 0))

			if #self.orderList == 1 and self.emojiType == 2 then
				var_8_11:setPosition(cc.p(var_8_6 + var_8_11:getContentSize().width * 0.215, var_8_7 - var_8_11:getContentSize().height * 0.207))
			else
				var_8_11:setPosition(cc.p(var_8_6, var_8_7))
			end

			self.imageIndex = self.imageIndex + 1

			self.bubble:addChild(var_8_11)

			if var_8_11:getContentSize().width > self.fontSize then
				-- block empty
			end

			var_8_6 = var_8_6 + var_8_11:getContentSize().width * self.emojiScale

			var_8_11:setScale(self.emojiScale)
		end

		if self.orderList[iter_8_0] == 0 then
			var_8_6 = self.bubble:getPositionX() + self.colSpace
			var_8_7 = var_8_7 - self.fontSize - self.lineSpace
			self.lineHeightCount = self.lineHeightCount + 1

			if self.lineHeight[self.lineHeightCount] and self.lineHeight[self.lineHeightCount] > self.fontSize then
				var_8_7 = var_8_7 - self.lineHeight[self.lineHeightCount] + self.fontSize
			end
		end
	end
end

function TalkBubbleSprite:getWordWidth(arg_10_1, arg_10_2)
	local var_10_1 = 0

	while 1 <= #arg_10_1 do
		self.lengthLabel:setString(string.sub(arg_10_1, 1, 1 + subStringGetByteCount(arg_10_1, 1) - 1))

		var_10_1 = var_10_1 + self.lengthLabel:getContentSize().width
	end

	return var_10_1
end

function TalkBubbleSprite:getImageSize(arg_11_1)
	self.imageCount = self.imageCount + 1

	local var_11_0

	if config._DEBUG then
		var_11_0 = cc.Sprite:create(arg_11_1) or cc.Sprite:createWithSpriteFrameName(arg_11_1)
	end

	self.image[self.imageCount] = var_11_0

	return (var_11_0:getContentSize())
end

function TalkBubbleSprite:touchDisappear(arg_12_1, arg_12_2)
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.1), cc.CallFunc:create(function()
		if arg_12_1 then
			arg_12_1(arg_12_2)
		end
	end), cc.RemoveSelf:create()))
end

function TalkBubbleSprite:printEmoji()
	self.bubble = ccui.Button:create(EMOJI_PATH .. "bg" .. ".png", EMOJI_PATH .. "bg" .. ".png", EMOJI_PATH .. "bg" .. ".png")

	if self.direction == 1 then
		self.bubble:setAnchorPoint(cc.p(0, 0))
		self.bubble:setPosition(cc.p(-40, 0))
	else
		self.bubble:setFlippedX(true)
		self.bubble:setAnchorPoint(cc.p(1, 0))
		self.bubble:setPosition(cc.p(40, 0))
	end

	self.bubble:setScale(0.1)
	self.bubble:setScale(self.emojiScale)
	self:addChild(self.bubble)

	local var_14_0 = cc.Sprite:create(EMOJI_PATH .. self.imageList[1] .. ".png")

	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(0, 0))
	self.bubble:addChild(var_14_0)

	if self.direction == 1 then
		-- block empty
	else
		var_14_0:setFlippedX(true)
	end

	if self.delay == 0 then
		self.bubble:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.bubble:setTouchEnabled(false)
			self:stopAllActions()
			self:touchDisappear(self.callBack, "touch")
		end)
	end

	self.bubble:runAction(cc.Sequence:create(cc.ScaleBy:create(0.3, 1.5), cc.ScaleBy:create(0.1, 0.6666666666666666)))

	if self.delay == nil then
		self.delay = 3
	end

	if self.delay ~= 0 then
		self:runAction(cc.Sequence:create(cc.DelayTime:create(self.delay), self:stopAllActions(), cc.CallFunc:create(function()
			self:touchDisappear(self.callBack, "timeOut")
		end)))
	end
end

function TalkBubbleSprite:transcoding(arg_17_1)
	if arg_17_1 == "" then
		return
	end

	local var_17_0 = 1
	local var_17_1 = 1
	local var_17_3 = 1
	local var_17_4 = 1
	local var_17_5 = 1
	local var_17_6 = 0

	self.wordList = {}
	self.imageList = {}
	self.orderList = {}

	while var_17_0 do
		local var_17_7 = string.find(arg_17_1, "{>", var_17_0)
		local var_17_8 = string.find(arg_17_1, "\n", var_17_0)
		local var_17_9

		if var_17_7 and var_17_8 then
			if var_17_7 < var_17_8 then
				var_17_0 = var_17_7
				var_17_9 = string.find(arg_17_1, "<}", var_17_7)
				var_17_6 = var_17_9 - var_17_7 + 2
			else
				var_17_0 = var_17_8
				var_17_6 = 1
			end
		elseif var_17_7 or var_17_8 then
			if var_17_7 then
				var_17_0 = var_17_7
				var_17_9 = string.find(arg_17_1, "<}", var_17_7)
				var_17_6 = var_17_9 - var_17_7 + 2
			else
				var_17_6 = 1
				var_17_0 = var_17_8
			end
		else
			var_17_0 = nil
		end

		if not var_17_0 and string.sub(arg_17_1, var_17_1, var_17_1) == "" then
			return
		end

		if not var_17_0 and string.sub(arg_17_1, var_17_1, var_17_1) ~= "" then
			self.wordList[var_17_3] = string.sub(arg_17_1, var_17_1, string.len(arg_17_1))
			self.orderList[var_17_5] = 1

			return
		end

		if not var_17_0 and string.sub(arg_17_1, var_17_1, var_17_1) == "" then
			return
		end

		if var_17_1 <= var_17_0 - 1 then
			self.wordList[var_17_3] = string.sub(arg_17_1, var_17_1, var_17_0 - 1)
			var_17_3 = var_17_3 + 1
			self.orderList[var_17_5] = 1
			var_17_5 = var_17_5 + 1
		end

		var_17_1 = var_17_0 + var_17_6

		if string.sub(arg_17_1, var_17_0, var_17_0 + 1) == "{>" then
			self.imageList[var_17_4] = string.sub(arg_17_1, var_17_0 + 2, var_17_9 - 1)
			var_17_4 = var_17_4 + 1
			self.orderList[var_17_5] = 2
			var_17_5 = var_17_5 + 1
		end

		if string.sub(arg_17_1, var_17_0, var_17_0) == "\n" then
			self.orderList[var_17_5] = 0
			var_17_5 = var_17_5 + 1
		end

		var_17_0 = var_17_0 + var_17_6
	end
end
