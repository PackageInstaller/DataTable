PopGiftBagLayer = class("PopGiftBagLayer", function(arg_1_0)
	return PopItemLayer:create(arg_1_0)
end)

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local var_0_3 = config._DEBUG and 0 or 1

function PopGiftBagLayer.create(arg_2_0, arg_2_1)
	print(dump(arg_2_1))

	local var_2_0 = PopGiftBagLayer.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGiftBagLayer:init(arg_3_1)
	local var_3_0 = self:Layer_Shop_Btn(arg_3_1)
	local var_3_1 = self:Layer_Shop_Slider(arg_3_1)

	var_3_0:setPosition(cc.p(0, 300))
	var_3_1:setPosition(cc.p(0, 300))
	self.rootpanel:addChild(var_3_0, 1)

	if arg_3_1.itemtype ~= kITEM_SERVANT_CHIP then
		self.rootpanel:addChild(var_3_1, 1)
	else
		self.callback_button:removeFromParent()
		self.Label_button:setString(L_BUTTON_TEXT.Compound)
		self.bg:addChild(self.callback_button)
		self.callback_button:setPosition(cc.p(272, -50))
	end

	local var_3_2 = self:Layer_Drop_List(arg_3_1.items)

	var_3_2:setPosition(cc.p(20, 780))
	self.rootpanel:addChild(var_3_2, 1)
end

function PopGiftBagLayer.Layer_Drop_List(arg_4_0, arg_4_1)
	local var_4_0 = cc.Layer:create()
	local var_4_1 = 273
	local var_4_2 = -45
	local var_4_3 = 30

	if not arg_4_1.itemListType then
		-- block empty
	end

	local var_4_5 = {}
	local var_4_6 = {}

	if arg_4_1.gold and arg_4_1.gold ~= 0 then
		var_4_5[#var_4_5 + 1] = cc.Label:createWithTTF("", FONT_DES, 22)

		var_4_5[#var_4_5]:setString(L_GOLD .. "X" .. arg_4_1.gold)
	end

	if arg_4_1.diamond and arg_4_1.diamond ~= 0 then
		var_4_5[#var_4_5 + 1] = cc.Label:createWithTTF("", FONT_DES, 22)

		var_4_5[#var_4_5]:setString(L_DIAMOND .. "X" .. arg_4_1.diamond)
	end

	if arg_4_1.equips and #arg_4_1.equips ~= 0 then
		for iter_4_0 = 1, #arg_4_1.equips do
			print("1111111111111111")

			var_4_5[#var_4_5 + 1] = cc.Label:createWithTTF("", FONT_DES, 22)

			var_4_5[#var_4_5]:setString(item_data[arg_4_1.equips[iter_4_0].dropid].name)
		end
	end

	for iter_4_1 = 1, #var_4_5 do
		if config._DEBUG then
			var_4_6[iter_4_1] = cc.Sprite:create("public/panelbg/white_point.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/white_point.png")
		end

		var_4_6[iter_4_1]:setPosition(cc.p(var_4_1 - 20, var_4_2 - (iter_4_1 - 1) * var_4_3 - 13))
		var_4_5[iter_4_1]:setAnchorPoint(cc.p(0, 1))
		var_4_5[iter_4_1]:setPosition(cc.p(var_4_1, var_4_2 - (iter_4_1 - 1) * var_4_3))
		var_4_0:addChild(var_4_6[iter_4_1])
		var_4_0:addChild(var_4_5[iter_4_1])
	end

	return var_4_0
end

function PopGiftBagLayer:Layer_Shop_Btn(arg_5_1)
	local var_5_0 = cc.Layer:create()

	self.callback_button = nil
	self.costLabel = nil
	self.Label_button = cc.Label:createWithTTF("", "fonts/newkj.ttf", 30)

	self.Label_button:setName("self.Label_button")
	;(function()
		if arg_5_1.limitNum and arg_5_1.limitNum > 1 then
			self.callback_button = ccui.Button:create("public/button/public_button_orange.png", "public/button/public_button_orange.png", "public/button/public_button_orange.png", var_0_3)

			self.callback_button:setPosition(cc.p(470, 30))
		else
			self.callback_button = ccui.Button:create("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange.png", var_0_3)

			self.callback_button:setPosition(cc.p(320, 30))
		end

		self.callback_button:setName("self.callback_button")
		self.callback_button:setPressedActionEnabled(true)

		self.callback_button.nowNum = self.nowNum

		if arg_5_1.marketType == "market_collection" then
			if item_manager:getItemNumber(arg_5_1.itemid) == 0 then
				self.Label_button:setString(L_MARKET_MSG.Nothing_To_Sell)
				self.callback_button:loadTextures("public/button/public_button_gray.png", "public/button/public_button_gray.png", "public/button/public_button_gray.png", var_0_3)
				self.callback_button:setTouchEnabled(false)
			else
				self.Label_button:setString(L_BUTTON_TEXT.Sell)
			end
		else
			self.Label_button:setString(L_BUTTON_TEXT.Buy)

			if arg_5_1.baggain then
				self.Label_button:setString(L_BUTTON_TEXT.Use)
			end
		end

		if arg_5_1.slidecost and arg_5_1.slidecost.costtype and arg_5_1.slidecost.costtype == "public/currency/rmb_white.png" then
			self.Label_button:setString(L_BUTTON_TEXT.Buy)
			self.callback_button:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_off.png", var_0_3)
		end

		self.Label_button:setAnchorPoint(cc.p(0.5, 0.5))

		if arg_5_1.limitNum and arg_5_1.limitNum > 1 then
			self.Label_button:setPosition(cc.p(self.callback_button:getContentSize().width / 2, self.callback_button:getContentSize().height / 2))
		else
			self.Label_button:setPosition(cc.p(self.callback_button:getContentSize().width / 2, self.callback_button:getContentSize().height / 2 - 5))
		end

		self.Label_button:setColor(cc.c3b(41, 49, 58))
		self.callback_button:addChild(self.Label_button)
		self.callback_button:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_7_0.num = self.nowNum

			arg_5_1.ShopSliderCallback(arg_7_0, arg_7_1, arg_5_1.shopcallback)
		end)
	end)()
	;(function()
		if arg_5_1.slidecost then
			local var_8_0

			if config._DEBUG then
				var_8_0 = cc.Sprite:create(arg_5_1.slidecost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_5_1.slidecost.costtype)
			end

			var_8_0:setAnchorPoint(0.5, 0.5)

			if arg_5_1.limitNum and arg_5_1.limitNum > 1 then
				var_8_0:setPosition(cc.p(440, -30))
			else
				var_8_0:setPosition(cc.p(310 - 25, -30))
			end

			if arg_5_1.slidecost.costtype == "equipment/6800201.png" then
				var_8_0:setScale(0.2734375)
			end
		end

		var_5_0:addChild(var_8_0, 10)

		self.costLabel = cc.Label:createWithTTF(arg_5_1.slidecost.costnum, FONT_DES, 25)

		if utfstrlen(self.costLabel:getString()) > 6 then
			self.costLabel:setScale(0.6)
		elseif utfstrlen(self.costLabel:getString()) > 5 then
			self.costLabel:setScale(0.8)
		end

		self.costLabel:setAnchorPoint(0, 0.5)
		self.costLabel:setPosition(cc.p(var_8_0:getPositionX() + 30, var_8_0:getPositionY()))
		var_5_0:addChild(self.costLabel, 10)
		self.costLabel:setName("self.costLabel")
	end)()
	;(function()
		if arg_5_1.baggain and arg_5_1.baggain.gaintype then
			local var_9_0

			if config._DEBUG then
				var_9_0 = cc.Sprite:create(arg_5_1.baggain.gaintype) or cc.Sprite:createWithSpriteFrameName(arg_5_1.baggain.gaintype)
			end

			var_9_0:setAnchorPoint(0.5, 0.5)
			var_9_0:setName("icon_bag")
			var_5_0:addChild(var_9_0, 10)

			self.costLabel = cc.Label:createWithTTF(arg_5_1.baggain.gainunit, FONT_DES, 25)

			self.costLabel:setAnchorPoint(0, 0.5)
			var_5_0:addChild(self.costLabel, 10)

			if arg_5_1.limitNum <= 1 or not arg_5_1.limitNum then
				var_9_0:setPosition(cc.p(320 - 30, -30))
			else
				var_9_0:setPosition(cc.p(320 + 120, -30))
			end

			self.costLabel:setPosition(cc.p(var_9_0:getPositionX() + 30, var_9_0:getPositionY()))
			self.costLabel:setName("self.costLabel")
		end

		if arg_5_1.limit_time then
			local var_9_1 = cc.Label:createWithTTF(arg_5_1.limit_time, FONT_DES, 24)

			var_9_1:setColor(cc.c3b(242, 242, 242))
			var_9_1:setPosition(cc.p(320, -60))
			var_5_0:addChild(var_9_1)
		end
	end)()

	return var_5_0
end

function PopGiftBagLayer.Layer_Shop_Slider(arg_10_0, arg_10_1)
	local var_10_0 = cc.Layer:create()
	local var_10_1 = 20

	if arg_10_1.itemid and arg_10_1.ShopSliderCallback then
		arg_10_0.nowNum = math.min(1000, arg_10_1.selectNum or 1)

		local var_10_3
		local var_10_4 = 1
		local var_10_5
		local var_10_6
		local var_10_7
		local var_10_8
		local var_10_9

		if arg_10_1.slidecost and arg_10_1.slidecost.costtype == "public/currency/UI_battleEnd_diamond.png" and arg_10_1.slidecost.nowHave then
			arg_10_1.slidecost.nowHave = playermodel.diamond

			local function var_10_10()
				arg_10_0.costLabel:setString(arg_10_1.slidecost.costnum * arg_10_0.nowNum)

				if utfstrlen(arg_10_0.costLabel:getString()) > 6 then
					arg_10_0.costLabel:setScale(0.6)
				elseif utfstrlen(arg_10_0.costLabel:getString()) > 5 then
					arg_10_0.costLabel:setScale(0.8)
				else
					arg_10_0.costLabel:setScale(1)
				end

				arg_10_0.callback_button:setBright(true)

				if arg_10_1.slidecost.costnum * arg_10_0.nowNum <= (arg_10_1.slidecost.nowHave or 0) then
					arg_10_0.callback_button:setColor(cc.c3b(255, 255, 255))
					arg_10_0.Label_button:setString(L_BUTTON_TEXT.Buy)
				else
					arg_10_0.callback_button:setColor(cc.c3b(255, 255, 255))
					arg_10_0.Label_button:setString(L_MARKET_MSG.Item_Lack)
				end

				if arg_10_1.marketType == "market_collection" then
					if arg_10_0.nowNum > item_manager:getItemNumber(arg_10_1.itemid) then
						arg_10_0.Label_button:setString(L_MARKET_MSG.Item_Lack)

						return
					else
						arg_10_0.Label_button:setString(L_BUTTON_TEXT.Sell)

						return
					end
				end
			end

			local function var_10_11()
				if arg_10_1.baggain.gainunit then
					arg_10_0.costLabel:setString(arg_10_1.baggain.gainunit * arg_10_0.nowNum)
				end

				arg_10_0.callback_button:setBright(true)
				arg_10_0.callback_button:setColor(cc.c3b(255, 255, 255))
				arg_10_0.Label_button:setString(L_BUTTON_TEXT.Use)
			end

			local function var_10_12(arg_14_0, arg_14_1)
				arg_10_0.nowNum = math.ceil(tonumber(var_10_3:getPercent() / 100 * var_10_4))

				if arg_10_0.nowNum == 0 then
					arg_10_0.nowNum = 1
				end

				if arg_10_1.marketType == "market_collection" and arg_10_0.nowNum > item_manager:getItemNumber(arg_10_1.itemid) then
					global_ShowBlockWords(L_MARKET_MSG.Own_Lack)

					arg_10_0.nowNum = math.min(item_manager:getItemNumber(arg_10_1.itemid), 1000)
				end

				arg_10_0.callback_button.nowNum = arg_10_0.nowNum

				var_10_5:setString(arg_10_0.nowNum .. "/" .. var_10_4)
				var_10_3:setPercent((arg_10_0.nowNum - 1) * 100 / (var_10_4 - 1))

				if arg_10_1.slidecost then
					var_10_10()
				elseif arg_10_1.baggain then
					var_10_11()
				end
			end

			local function var_10_13(arg_15_0, arg_15_1)
				if arg_15_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_10_1.marketType == "market_collection" and arg_10_0.nowNum + 1 > item_manager:getItemNumber(arg_10_1.itemid) then
					audioManager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_MARKET_MSG.Own_Lack)

					return
				end

				if arg_10_1.limitNum then
					if arg_10_0.nowNum < var_10_4 then
						arg_10_0.nowNum = arg_10_0.nowNum + 1
						arg_10_0.callback_button.nowNum = arg_10_0.nowNum

						var_10_3:setPercent((math.ceil((arg_10_0.nowNum - 1) * 100 / (var_10_4 - 1))))
						var_10_5:setString(arg_10_0.nowNum .. "/" .. var_10_4)
					end
				else
					arg_10_0.nowNum = arg_10_0.nowNum + 1
					arg_10_0.callback_button.nowNum = arg_10_0.nowNum
				end

				if arg_10_1.slidecost then
					var_10_10()
				elseif arg_10_1.baggain then
					var_10_11()
				end
			end

			local function var_10_14(arg_16_0, arg_16_1)
				if arg_16_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_10_0.nowNum > 1 then
					arg_10_0.nowNum = arg_10_0.nowNum - 1
					arg_10_0.callback_button.nowNum = arg_10_0.nowNum

					if arg_10_1.limitNum then
						var_10_3:setPercent((math.ceil((arg_10_0.nowNum - 1) * 100 / (var_10_4 - 1))))
						var_10_5:setString(arg_10_0.nowNum .. "/" .. var_10_4)
					end
				end

				if arg_10_1.slidecost then
					var_10_10()
				elseif arg_10_1.baggain then
					var_10_11()
				end
			end
		end

		;(function()
			if arg_10_1.limitNum and arg_10_1.limitNum > 1 then
				var_10_3 = ccui.Slider:create()

				var_10_3:setName("slider")

				var_10_4 = math.min(1000, arg_10_1.limitNum)
				var_10_6 = ccui.Layout:create()

				var_10_6:setName("layout_slider")
				var_10_6:setContentSize(cc.size(240, 80))
				var_10_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
				var_10_6:setPosition(cc.p(70, -10))
				var_10_0:addChild(var_10_6, 1)

				var_10_5 = cc.Label:createWithTTF(arg_10_0.nowNum .. "/" .. var_10_4, FONT_DES, var_10_1)

				var_10_5:setPosition(cc.p(var_10_6:getContentSize().width / 2 + 80, var_10_6:getContentSize().height / 2 + 15))
				var_10_0:addChild(var_10_5, 3)
				var_10_3:loadBarTexture("public/panelbg/blue_slider_bottom.png", var_0_3)
				var_10_3:loadProgressBarTexture("public/panelbg/blue_slider_bar.png", var_0_3)
				var_10_3:loadSlidBallTextures("public/button/blue_slider_node.png", "public/button/blue_slider_node.png", "public/button/blue_slider_node.png", var_0_3)
				var_10_3:setPercent((arg_10_0.nowNum - 1) * 100 / (var_10_4 - 1))
			end
		end)()
		;(function()
			if arg_10_1.limitNum and arg_10_1.limitNum > 1 then
				local var_17_0 = ccui.Layout:create()

				var_17_0:setTouchEnabled(true)
				var_17_0:setContentSize(cc.size(var_10_3:getContentSize().width, var_10_3:getContentSize().height + 40))
				var_17_0:setAnchorPoint(cc.p(0.5, 0.5))
				var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
				var_17_0:setPosition(cc.p(var_10_3:getContentSize().width / 2, var_10_3:getContentSize().height / 2))
				var_10_3:addChild(var_17_0, 99)
				var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
					if arg_18_1 == ccui.TouchEventType.moved then
						var_10_3:setPercent(var_17_0:convertToNodeSpace((arg_18_0:getTouchMovePosition())).x * 100 / var_17_0:getContentSize().width)
					end

					if arg_18_1 == ccui.TouchEventType.began then
						var_10_3:setPercent(var_17_0:convertToNodeSpace((arg_18_0:getTouchBeganPosition())).x * 100 / var_17_0:getContentSize().width)
					end

					var_10_12()
				end)
			end
		end)()
		;(function()
			var_10_8 = ccui.Button:create("public/button/add_blue_btn.png", nil, "public/button/add_blue_btn.png", var_0_3)
			var_10_9 = ccui.Button:create("public/button/sub_blue_btn.png", nil, "public/button/sub_blue_btn.png", var_0_3)

			if arg_10_1.limitNum and arg_10_1.limitNum > 1 and var_10_4 ~= 1 and var_10_4 ~= 0 then
				var_10_3:addEventListener(var_10_12)
				var_10_6:addChild(var_10_3, 3)
				var_10_8:setPosition(cc.p(var_10_6:getContentSize().width / 2 + 125, var_10_6:getContentSize().height / 2 + 2))
				var_10_9:setPosition(cc.p(var_10_6:getContentSize().width / 2 - 100, var_10_6:getContentSize().height / 2 + 2))
				var_10_3:setPosition(cc.p(var_10_6:getContentSize().width / 2 + 12, var_10_6:getContentSize().height / 2 + 2))

				if var_10_7 then
					var_10_7:setVisible(true)
				end

				var_10_6:addChild(var_10_8, 3)
				var_10_6:addChild(var_10_9, 3)
			elseif not arg_10_1.limitNum then
				var_10_8:setPosition(cc.p(510, 380))
				var_10_9:setPosition(cc.p(310, 380))
			else
				var_10_8:setVisible(false)
				var_10_9:setVisible(false)
			end

			var_10_0:addChild(arg_10_0.callback_button, 3)
			var_10_8:setName("add_button")
			var_10_9:setName("sub_button")
			var_10_8:addTouchEventListener(var_10_13)
			var_10_9:addTouchEventListener(var_10_14)

			if arg_10_1.slidecost and arg_10_1.slidecost.costtype and arg_10_1.slidecost.costtype == "recharge/rmb_white.png" then
				var_10_8:setVisible(false)
				var_10_9:setVisible(false)
			end
		end)()
	end

	return var_10_0
end
