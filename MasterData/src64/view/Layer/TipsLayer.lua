TipsLayer = class("TipsLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = "public/button/public_button_normal_y.png"
local var_0_2 = "public/button/public_button_off.png"
local var_0_3 = 320
local var_0_4 = 680
local var_0_5 = 1
local var_0_6 = 2
local var_0_8 = -20

function TipsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = TipsLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function TipsLayer:init(arg_3_1)
	self.tips = arg_3_1.tips
	self.nowPage = 1
	self.layout = ccui.Layout:create()

	self.layout:setContentSize(cc.size(640, GameDisplay.height))
	self.layout:setAnchorPoint(cc.p(0.5, 0.5))
	self.layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.layout:setBackGroundColor(cc.c3b(0, 0, 0))
	self.layout:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self.layout:setTouchEnabled(true)
	self:addChild(self.layout)

	self.tipImage = ccui.ImageView:create(self.tips[1])

	self.tipImage:setPosition(cc.p(var_0_3, var_0_4))
	self.layout:addChild(self.tipImage)

	self.buttonNext = ccui.Button:create(var_0_1, nil, var_0_2, var_0_0)

	self.buttonNext:setAnchorPoint(cc.p(0.5, 1))
	self.buttonNext:setPosition(cc.p(405, var_0_8))
	self.buttonNext:setVisible(true)
	self.buttonNext:setTouchEnabled(true)
	self.tipImage:addChild(self.buttonNext)

	local var_3_0 = cc.Label:createWithTTF(L_TIPS_NEXT_PAGE, FONT_BUTTON, 28)

	var_3_0:setColor(cc.c3b(47, 47, 47))
	var_3_0:setPosition(cc.p(self.buttonNext:getContentSize().width / 2, self.buttonNext:getContentSize().height / 2))
	var_3_0:setName("label_next")
	self.buttonNext:addChild(var_3_0)

	self.buttonLast = ccui.Button:create(var_0_1, nil, var_0_2, var_0_0)

	self.buttonLast:setAnchorPoint(cc.p(0.5, 1))
	self.buttonLast:setPosition(cc.p(135, var_0_8))
	self.buttonLast:setVisible(true)
	self.buttonLast:setBright(false)
	self.tipImage:addChild(self.buttonLast)

	local var_3_1 = cc.Label:createWithTTF(L_TIPS_LAST_PAGE, FONT_BUTTON, 28)

	var_3_1:setColor(cc.c3b(47, 47, 47))
	var_3_1:setPosition(cc.p(self.buttonLast:getContentSize().width / 2, self.buttonLast:getContentSize().height / 2))
	self.buttonLast:addChild(var_3_1)
	global_window_open_action(self.tipImage)

	if #self.tips == 1 then
		self.buttonNext:setVisible(false)
		self.buttonLast:setVisible(false)
	end

	self.buttonLast:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		self:lastPageEffect()
	end)
	self.buttonNext:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_5_0:isBright() then
			return
		end

		self:nextPageEffect()
	end)
	self.layout:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.tipImage, function()
			LayerManager:removePopLayer()
		end)
	end)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" and callback then
			callback()
		end
	end)
end

function TipsLayer:changePageEffect(arg_9_1)
	if self.runing then
		return
	end

	if arg_9_1 == var_0_5 and self.nowPage == #self.tips then
		global_window_close_action(self.tipImage, function()
			LayerManager:removePopLayer()
		end)

		return
	end

	local var_9_0 = 0.2

	self.runing = true

	self.tipImage:runAction((cc.Sequence:create(cc.FadeOut:create(var_9_0), cc.CallFunc:create(function()
		if arg_9_1 == var_0_5 then
			self.nowPage = self.nowPage + 1

			self.tipImage:loadTexture(self.tips[self.nowPage])
			self.buttonNext:setPositionX(540 * 3 / 4)
			self.buttonLast:setPositionX(540 / 4)

			if self.nowPage < #self.tips then
				if self.nowPage == 2 then
					self.buttonLast:setBright(true)
					self.buttonLast:setTouchEnabled(true)
				end
			else
				self.buttonNext:getChildByName("label_next"):setString(L_BUTTON_TEXT.Close)
			end
		elseif arg_9_1 == var_0_6 then
			self.nowPage = self.nowPage - 1

			if self.nowPage < 1 then
				return
			end

			self.tipImage:loadTexture(self.tips[self.nowPage])
			self.buttonNext:setPositionX(540 * 3 / 4)
			self.buttonLast:setPositionX(540 / 4)

			if self.nowPage > 1 then
				if self.nowPage == #self.tips - 1 then
					self.buttonNext:getChildByName("label_next"):setString(L_TIPS_NEXT_PAGE)
					self.buttonNext:setVisible(true)
					self.buttonNext:setTouchEnabled(true)
				end
			else
				self.buttonLast:setBright(false)
				self.buttonLast:setTouchEnabled(true)
			end
		end

		self.runing = false
	end), cc.FadeIn:create(var_9_0))))
end

function TipsLayer:nextPageEffect()
	self:changePageEffect(var_0_5)
end

function TipsLayer:lastPageEffect()
	self:changePageEffect(var_0_6)
end

function TipsLayer:initBg(arg_14_1)
	local var_14_0 = ccui.Layout:create()

	var_14_0:setTouchEnabled(true)
	var_14_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_14_0:setOpacity(0)
	self:addChild(var_14_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_15_0)
		self:addChild(arg_15_0, -2)
		arg_15_0:setPositionY(arg_15_0:getPositionY() - GameDisplay.fix_y)

		local var_15_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_15_0:setAnchorPoint(cc.p(0, 0))
		var_15_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_15_0, -1)
		self:init(arg_14_1, initInfo)
		var_14_0:setOpacity(102)
		var_14_0:setTouchEnabled(false)
	end)
end

function TipsLayer:exit()
	global_window_close_action(self.tipImage, function()
		LayerManager:removePopLayer()
	end)
end
