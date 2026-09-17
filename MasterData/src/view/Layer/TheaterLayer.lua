local TheaterLayer = class("TheaterLayer", function()
	return ccui.Layout:create()
end)
local theater_director = require("controller.theater_director")
local script_class_data = require("data.script_class_data")
local emoji_data = require("data.emoji_data")
local var_0_4 = config._DEBUG and 0 or 1

function TheaterLayer:create(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = TheaterLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function TheaterLayer:init(arg_3_1, arg_3_2, arg_3_3)
	self._running = true

	self:initUI(arg_3_1)
	self:initDirector(arg_3_1)

	self.barrage = BarrageLayer:create(arg_3_1)

	self:addChild(self.barrage, 9)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "enter" then
			self:startPlay(arg_3_3)
			self.barrage:startShowBarrage()
			LayerManager:showTopBottomLayer({
				ListButtonLayer = false,
				TopcostLayer = false
			})
		elseif arg_4_0 == "exit" then
			GuideListener.showAllGuides(true)
			LayerManager:showTopBottomLayer({
				ListButtonLayer = true,
				TopcostLayer = true
			})

			if arg_3_2 then
				arg_3_2()
			end
		end
	end)
end

function TheaterLayer:initUI(arg_5_1)
	self:setContentSize(cc.size(640, 570))
	self:setTouchEnabled(true)

	if script_class_data[arg_5_1].bg_1 then
		for iter_5_0 = 1, 3 do
			local var_5_0 = cc.Sprite:create(FIGHT_BG_PATH .. script_class_data[arg_5_1]["bg_" .. iter_5_0] .. ".png")

			var_5_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_5_0:setPosition(cc.p(320, 285))
			self:addChild(var_5_0, -iter_5_0)
		end
	else
		self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self:setBackGroundColor(cc.c3b(15, 15, 15))
	end

	self.curtain = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 640, 570)

	self.curtain:setAnchorPoint(cc.p(0, 0))
	self:setPosition(cc.p(0, 0))
	self:addChild(self.curtain, 10)
	self:addInputCom()
end

function TheaterLayer:initDirector(arg_6_1)
	self.director = theater_director(arg_6_1, self)

	self.director:registerExitEvent(function()
		self._running = false

		self.curtain:runAction(cc.FadeIn:create(0.5))
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	end)
end

function TheaterLayer:startPlay(arg_8_1)
	if arg_8_1 then
		self.curtain:setOpacity(0)
		self.curtain:runAction(cc.Sequence:create(cc.FadeIn:create(1), cc.Spawn:create(cc.FadeOut:create(1), cc.CallFunc:create(function()
			self.director:startPlay()
		end))))
	else
		self.curtain:runAction(cc.Spawn:create(cc.FadeOut:create(1), cc.CallFunc:create(function()
			self.director:startPlay()
		end)))
	end
end

function TheaterLayer:stopPlay()
	if self.director then
		self.director:removeSelf()
	end
end

function TheaterLayer:addInputCom()
	self.inputPanel = ccui.Layout:create()

	self.inputPanel:setContentSize(cc.size(640, 520))
	self.inputPanel:setPosition(cc.p(0, -520))
	self.inputPanel:setTouchEnabled(true)
	self:addChild(self.inputPanel)

	local var_12_0 = ccui.ImageView:create("FightLayer/chatbg.png", var_0_4)

	var_12_0:setScale9Enabled(true)
	var_12_0:setContentSize(cc.size(640, 520))
	var_12_0:setPosition(cc.p(320, 260))
	self.inputPanel:addChild(var_12_0)
	self:createEmojiPanel()
	self:createEmojiList()
	self:createInputField()
end

local var_0_5 = 580
local var_0_6 = 160
local var_0_7 = 580
local var_0_8 = 160
local var_0_9 = 45
local var_0_10 = 60
local var_0_11 = 100

function TheaterLayer:createEmojiList()
	local var_13_0 = ccui.ScrollView:create()

	var_13_0:setContentSize(cc.size(var_0_5, var_0_6))
	var_13_0:setDirection(ccui.ScrollViewDir.horizontal)
	var_13_0:setPosition(cc.p(30, 0))
	self.inputPanel:addChild(var_13_0)

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(emoji_data) do
		table.insert(var_13_1, {
			id = iter_13_0,
			order = iter_13_1.order
		})
	end

	table.sort(var_13_1, function(arg_14_0, arg_14_1)
		return arg_14_0.order < arg_14_1.order
	end)

	var_0_7 = var_0_9 + var_0_11 * #var_13_1

	if var_0_7 < var_0_5 then
		var_0_7 = var_0_5
	end

	var_13_0:setInnerContainerSize(cc.size(var_0_7, var_0_8))

	var_13_0.selected = var_13_1[1].id

	for iter_13_2, iter_13_3 in ipairs(var_13_1) do
		local var_13_2 = iter_13_3.id
		local var_13_3 = ccui.Button:create("emoji/" .. emoji_data[iter_13_3.id].emoji2 .. ".png", "emoji/" .. emoji_data[iter_13_3.id].emoji1 .. ".png", "emoji/" .. emoji_data[iter_13_3.id].emoji1 .. ".png")

		var_13_3:setScale(0.5)
		var_13_3:setPosition(cc.p(var_0_9 + (iter_13_2 - 1) * var_0_11, var_0_10))
		var_13_3:setTag(iter_13_3.id)
		var_13_0:addChild(var_13_3)
		var_13_3:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_15_0:getTag() == var_13_0.selected then
				return
			end

			var_13_0:getChildByTag(var_13_0.selected):runAction(cc.ScaleTo:create(0.1, 0.5))
			var_13_0:getChildByTag(var_13_0.selected):setBright(true)
			arg_15_0:runAction(cc.ScaleTo:create(0.1, 0.7))
			arg_15_0:setBright(false)
			self:updateEmojiPanel(var_13_2)

			var_13_0.selected = arg_15_0:getTag()
		end)

		if iter_13_2 == 1 then
			var_13_3:setScale(0.7)
			var_13_3:setBright(false)
		end
	end

	self:updateEmojiPanel(var_13_0.selected)
end

function TheaterLayer:createEmojiPanel()
	self.emojiPanel = ccui.Layout:create()

	self.emojiPanel:setContentSize(cc.size(580, 320))
	self.emojiPanel:setPosition(cc.p(30, 130))
	self.inputPanel:addChild(self.emojiPanel, 1)
end

function TheaterLayer:updateEmojiPanel(arg_17_1)
	self.emojiPanel:removeAllChildren()

	while emoji_data[arg_17_1]["emoji" .. 1] do
		local var_17_0 = ccui.Button:create("emoji/" .. emoji_data[arg_17_1]["emoji" .. 1] .. ".png", nil, nil)

		var_17_0:setPosition(cc.p(80 + (1 - 1) % 4 * 135, 250 - math.floor((1 - 1) / 4) * 150))
		var_17_0:setName(emoji_data[arg_17_1]["emoji" .. 1])
		var_17_0:setOpacity(0)
		self.emojiPanel:addChild(var_17_0)

		local var_17_1 = cc.Label:createWithTTF(emoji_data[arg_17_1]["info" .. 1], FONT_DES, 30)

		var_17_1:setAnchorPoint(cc.p(0.5, 1))
		var_17_1:setPosition(cc.p(var_17_0:getContentSize().width / 2, 20))
		var_17_0:addChild(var_17_1)
		var_17_0:setScale(0.8)
		var_17_0:runAction(cc.FadeIn:create(0.1))
		var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.barrage:sendBarrage(arg_18_0:getName(), 2)
		end)
	end
end

local function var_0_12()
	local var_19_0 = cc.EditBox:create(cc.size(510, 42), (config._DEBUG or nil) and (cc.Scale9Sprite:create("FightLayer/danmu_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("FightLayer/danmu_bg.png")))

	var_19_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_19_0:setPlaceholderFont(FONT_DES, 30)
	var_19_0:setFontSize(30)
	var_19_0:setFontColor(cc.c3b(255, 255, 255))
	var_19_0:setPlaceHolder(L_BARRAGE_TO_REPLY)
	var_19_0:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	var_19_0:setMaxLength(60)
	var_19_0:setReturnType(cc.KEYBOARD_RETURNTYPE_SEND)
	var_19_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_19_0:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_SENTENCE)

	return var_19_0
end

function TheaterLayer:createInputField()
	local var_20_0 = var_0_12()

	var_20_0:setPosition(cc.p(270, 485))
	self.inputPanel:addChild(var_20_0, 2)

	local var_20_1 = ccui.Button:create(TRIPLE_YELLOW_BUTTON, nil, TRIPLE_YELLOW_BUTTON, var_0_4)

	var_20_1:setScale(0.8)
	var_20_1:setPosition(cc.p(590, 480))
	self.inputPanel:addChild(var_20_1, 2)

	local var_20_2 = cc.Label:createWithTTF(L_SEND, FONT_DES, 30)

	var_20_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_20_2:setColor(cc.c3b(15, 15, 15))
	var_20_2:setPosition(cc.p(70, 30))
	var_20_1:addChild(var_20_2)
	var_20_1:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self._running then
			return
		end

		local var_21_0 = var_20_0:getText()

		if string.len(var_21_0) > 0 then
			self.barrage:sendBarrage(var_21_0, 1)
			var_20_0:setText("")
		end
	end)

	local var_20_3 = ccui.Layout:create()

	var_20_3:setContentSize(cc.size(640, 1136))
	var_20_3:setPosition(cc.p(0, -520))
	var_20_3:setTouchEnabled(true)
	var_20_3:setVisible(false)
	self:addChild(var_20_3, 10)
	var_20_3:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.director:resumePerform()
		self.barrage:resumeBarrage()
		arg_22_0:setVisible(false)
	end)
	var_20_0:registerScriptEditBoxHandler(function(arg_23_0)
		print("script event: ", arg_23_0)

		if arg_23_0 == "began" then
			self.director:pausePerform()
			self.barrage:pauseBarrage()
			var_20_3:setVisible(true)
		elseif arg_23_0 == "ended" then
			var_20_3:setVisible(false)
			self.director:resumePerform()
			self.barrage:resumeBarrage()
		elseif arg_23_0 == "return" then
			var_20_3:setVisible(false)
			self.director:resumePerform()
			self.barrage:resumeBarrage()
		end
	end)
end

return TheaterLayer
