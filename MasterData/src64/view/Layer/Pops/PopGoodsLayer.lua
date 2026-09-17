PopGoodsLayer = class("PopGoodsLayer", function(arg_1_0)
	return PopItemLayer:create(arg_1_0)
end)

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local shop_manager = require("controller.shop_manager")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9

function PopGoodsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGoodsLayer.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGoodsLayer:init(arg_3_1)
	self.msg = arg_3_1
	self.layerone = self:Layer_Shop_Btn(arg_3_1)
	self.layertwo = self:Layer_Shop_Slider(arg_3_1)

	self.layerone:setPosition(cc.p(0, 300))
	self.layertwo:setPosition(cc.p(0, 300))
	self.rootpanel:addChild(self.layerone, 1)
	self.rootpanel:addChild(self.layertwo, 1)
	self:updateWithCoupins(arg_3_1)
	self:updateToFlopShop(arg_3_1)
	self:initMiniHead()

	var_0_9 = self

	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_9 = nil
		end
	end)
end

function PopGoodsLayer:initMiniHead()
	local var_5_0

	if item_data[self.msg.itemid].bag_item_type == kITEM_WEAPON then
		var_5_0 = item_data[self.msg.itemid].modelid
	elseif item_data[self.msg.itemid].bag_item_type == kITEM_GIFT_FOR_FRIEND and item_data[self.msg.itemid].exclusive then
		var_5_0 = major_factor_data[item_data[self.msg.itemid].exclusive].model
	elseif item_data[self.msg.itemid].bag_item_type == kITEM_FURNITURE_GIFT then
		local var_5_1 = item_data[self.msg.itemid] and item_data[self.msg.itemid].suit_id
		local var_5_2 = furnitureSuitData[var_5_1] and furnitureSuitData[var_5_1].servantid

		var_5_0 = major_factor_data[var_5_2] and major_factor_data[var_5_2].model
	end

	if not var_5_0 then
		return
	end

	if self.rootpanel:getChildByName("isShowHaveServant") then
		self.rootpanel:getChildByName("isShowHaveServant"):removeFromParent()
	end

	if self.rootpanel:getChildByName("mask") then
		self.rootpanel:getChildByName("mask"):removeFromParent()
	end

	if self.rootpanel:getChildByName("di") then
		self.rootpanel:getChildByName("di"):removeFromParent()
	end

	local var_5_3 = cc.p(495, 640)
	local var_5_4 = "roleimage/role1/" .. model_data[var_5_0].cute_role .. ".png"
	local var_5_5

	if config._DEBUG then
		var_5_5 = cc.Sprite:create("public/rolebg/q_mask.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/q_mask.png")
	end

	local var_5_6 = cc.Sprite:create(var_5_4)

	var_5_6:setScale(0.35)

	local var_5_7 = cc.ClippingNode:create(var_5_5)

	var_5_7:setAlphaThreshold(0.5)
	var_5_7:setContentSize(cc.size(118, 118))
	var_5_7:setPosition(var_5_3)
	var_5_7:addChild(var_5_6)

	self.miniHeadNode = var_5_7

	self.miniHeadNode:setName("isShowHaveServant")
	self.rootpanel:addChild(var_5_7, 99)

	local var_5_8 = ccui.ImageView:create("public/rolebg/q_avatar_lock.png", var_0_8)

	var_5_8:setName("mask")
	var_5_8:setPosition(var_5_3)
	self.rootpanel:addChild(var_5_8, 99)
	var_5_8:setVisible(not self:isShowHaveServant(self.msg.itemid))

	local var_5_9 = ccui.ImageView:create("public/rolebg/q_avatar_di.png", var_0_8)

	var_5_9:setName("di")
	var_5_9:setPosition(var_5_3)
	self.rootpanel:addChild(var_5_9, 98)
end

function PopGoodsLayer.isShowHaveServant(arg_6_0, arg_6_1)
	local var_6_0 = false
	local var_6_1 = {}

	if item_data[arg_6_1] and item_data[arg_6_1].bag_item_type == kITEM_WEAPON then
		table.insert(var_6_1, item_data[arg_6_1].servant)
	elseif item_data[arg_6_1] and item_data[arg_6_1].bag_item_type == kITEM_GIFT_FOR_FRIEND then
		for iter_6_0, iter_6_1 in pairs(servant_data) do
			if iter_6_1.major == item_data[arg_6_1].exclusive then
				table.insert(var_6_1, iter_6_1.id)
			end
		end
	elseif item_data[arg_6_1] and item_data[arg_6_1].bag_item_type == kITEM_FURNITURE_GIFT and furnitureSuitData[item_data[arg_6_1].suit_id] then
		for iter_6_2, iter_6_3 in pairs(servant_data) do
			if iter_6_3.major == furnitureSuitData[item_data[arg_6_1].suit_id].servantid then
				table.insert(var_6_1, iter_6_3.id)
			end
		end
	end

	for iter_6_4, iter_6_5 in pairs(var_6_1) do
		if playermodel.haveServant[iter_6_5] then
			var_6_0 = true

			break
		end
	end

	return var_6_0
end

function PopGoodsLayer:Layer_Shop_Btn(arg_7_1)
	local var_7_0 = cc.Layer:create()

	self.callback_button = nil
	self.costLabel = nil
	self.Label_button = cc.Label:createWithTTF("", "fonts/newkj.ttf", 30)

	self.Label_button:setName("self.Label_button")
	;(function()
		if arg_7_1.limitNum and arg_7_1.limitNum > 1 then
			self.callback_button = ccui.Button:create("public/button/public_button_orange.png", "public/button/public_button_orange.png", "public/button/public_button_orange.png", var_0_8)

			self.callback_button:setPosition(cc.p(470, 30))
		else
			self.callback_button = ccui.Button:create("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange.png", var_0_8)

			self.callback_button:setPosition(cc.p(320, 30))
		end

		self.callback_button:setName("self.callback_button")
		self.callback_button:setPressedActionEnabled(true)

		self.callback_button.nowNum = self.nowNum

		if arg_7_1.marketType == "market_collection" then
			if item_manager:getItemNumber(arg_7_1.itemid) == 0 then
				self.Label_button:setString(L_MARKET_MSG.Nothing_To_Sell)
				self.callback_button:loadTextures("public/button/public_button_gray.png", "public/button/public_button_gray.png", "public/button/public_button_gray.png", var_0_8)
				self.callback_button:setTouchEnabled(false)
			else
				self.Label_button:setString(L_BUTTON_TEXT.Sell)
			end
		else
			self.Label_button:setString(L_BUTTON_TEXT.Buy)

			if arg_7_1.baggain then
				self.Label_button:setString(L_BUTTON_TEXT.Use)
			end
		end

		if arg_7_1.slidecost and arg_7_1.slidecost.costtype and arg_7_1.slidecost.costtype == "public/currency/rmb_white.png" then
			self.Label_button:setString(L_BUTTON_TEXT.Buy)
			self.callback_button:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_off.png", var_0_8)
		end

		self.Label_button:setAnchorPoint(cc.p(0.5, 0.5))

		if arg_7_1.limitNum and arg_7_1.limitNum > 1 then
			self.Label_button:setPosition(cc.p(self.callback_button:getContentSize().width / 2, self.callback_button:getContentSize().height / 2))
		else
			self.Label_button:setPosition(cc.p(self.callback_button:getContentSize().width / 2, self.callback_button:getContentSize().height / 2 - 5))
		end

		self.Label_button:setColor(cc.c3b(41, 49, 58))
		self.callback_button:addChild(self.Label_button)
		self.callback_button:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[arg_7_1.itemid].bag_item_type == kITEM_HERO and playermodel:remain_servant_count(item_data[arg_7_1.itemid].servant) < self.nowNum then
				global_ShowBlockWords(L_GIRL_MAX)

				return
			end

			arg_9_0.num = self.nowNum

			if arg_7_1.ShopSliderCallback then
				arg_7_1.ShopSliderCallback(arg_9_0, arg_9_1, arg_7_1.shopcallback, self.selectCoupon)
			else
				self:buyShop()
			end
		end)
	end)()
	;(function()
		if arg_7_1.slidecost then
			local var_10_0 = -30

			if arg_7_1.slidecost.cost_old and arg_7_1.slidecost.costnum < arg_7_1.slidecost.cost_old then
				local var_10_1

				if config._DEBUG then
					var_10_1 = cc.Sprite:create(arg_7_1.slidecost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_7_1.slidecost.costtype)

					if arg_7_1.limitNum and arg_7_1.limitNum > 1 then
						var_10_1:setPositionX(440)

						goto label_10_0
					end
				end

				var_10_1:setPositionX(285)

				::label_10_0::

				var_10_1:setPositionY(var_10_0)
				var_7_0:addChild(var_10_1, 10)

				local var_10_2 = cc.Label:createWithTTF(arg_7_1.slidecost.cost_old, FONT_DES, 23)

				var_10_2:setAnchorPoint(cc.p(0, 0.5))
				var_10_2:setPositionX(var_10_1:getPositionX() + var_10_1:getContentSize().width / 2 + 5)
				var_10_2:setPositionY(var_10_1:getPositionY())
				var_7_0:addChild(var_10_2, 10)

				local var_10_3 = ccui.ImageView:create("public/currency/discount_line.png", var_0_8)

				var_10_3:setPositionX((var_10_1:getPositionX() + var_10_2:getPositionX() + var_10_2:getContentSize().width / 2) / 2)
				var_10_3:setPositionY(var_10_1:getPositionY())
				var_7_0:addChild(var_10_3, 11)

				var_10_0 = var_10_0 - 45
			end

			local var_10_4

			if config._DEBUG then
				var_10_4 = cc.Sprite:create(arg_7_1.slidecost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_7_1.slidecost.costtype)
			end

			var_10_4:setName("cost_icon")
			var_10_4:setAnchorPoint(0.5, 0.5)

			if arg_7_1.limitNum and arg_7_1.limitNum > 1 then
				var_10_4:setPosition(cc.p(440, var_10_0))
			else
				var_10_4:setPosition(cc.p(310 - 25, var_10_0))
			end

			if arg_7_1.slidecost.costtype:find("equipment") then
				var_10_4:setScale(0.3125)
			end

			var_7_0:addChild(var_10_4, 10)

			self.costLabel = cc.Label:createWithTTF(global_trans_number(arg_7_1.slidecost.costnum), FONT_DES, 25)

			if utfstrlen(self.costLabel:getString()) > 6 then
				self.costLabel:setScale(0.6)
			elseif utfstrlen(self.costLabel:getString()) > 5 then
				self.costLabel:setScale(0.8)
			end

			self.costLabel:setAnchorPoint(0, 0.5)
			self.costLabel:setPosition(cc.p(var_10_4:getPositionX() + 30, var_10_4:getPositionY()))
			var_7_0:addChild(self.costLabel, 10)
			self.costLabel:setName("costLabel")
		end
	end)()
	;(function()
		if arg_7_1.baggain and arg_7_1.baggain.gaintype then
			local var_11_0

			if config._DEBUG then
				var_11_0 = cc.Sprite:create(arg_7_1.baggain.gaintype) or cc.Sprite:createWithSpriteFrameName(arg_7_1.baggain.gaintype)
			end

			var_11_0:setAnchorPoint(0.5, 0.5)
			var_11_0:setName("icon_bag")
			var_7_0:addChild(var_11_0, 10)

			self.costLabel = cc.Label:createWithTTF(arg_7_1.baggain.gainunit, FONT_DES, 25)

			self.costLabel:setAnchorPoint(0, 0.5)
			var_7_0:addChild(self.costLabel, 10)

			if arg_7_1.limitNum <= 1 or not arg_7_1.limitNum then
				var_11_0:setPosition(cc.p(320 - 30, -30))
			else
				var_11_0:setPosition(cc.p(320 + 120, -30))
			end

			self.costLabel:setPosition(cc.p(var_11_0:getPositionX() + 30, var_11_0:getPositionY()))
			self.costLabel:setName("self.costLabel")
		end

		if arg_7_1.limit_time and tonumber(arg_7_1.limit_time) ~= -1 then
			local var_11_1 = cc.Label:createWithTTF(arg_7_1.limit_time, FONT_DES, 24)

			var_11_1:setName("time_label")
			var_11_1:setColor(cc.c3b(242, 242, 242))

			if arg_7_1.slidecost.cost_old and arg_7_1.slidecost.costnum < arg_7_1.slidecost.cost_old then
				var_11_1:setPosition(cc.p(320, -110))
			else
				var_11_1:setPosition(cc.p(320, -60))
			end

			var_7_0:addChild(var_11_1)
		end
	end)()

	return var_7_0
end

function PopGoodsLayer.Layer_Shop_Slider(arg_12_0, arg_12_1)
	local var_12_0 = cc.Layer:create()
	local var_12_1 = 20

	if arg_12_1.itemid and arg_12_1.ShopSliderCallback or arg_12_1.shopid then
		arg_12_0.nowNum = arg_12_1.selectNum or 1

		local var_12_2
		local var_12_3 = 1
		local var_12_4
		local var_12_5
		local var_12_6
		local var_12_7
		local var_12_8

		if arg_12_1.slidecost and arg_12_1.slidecost.costtype == "public/currency/UI_battleEnd_diamond.png" and arg_12_1.slidecost.nowHave then
			arg_12_1.slidecost.nowHave = playermodel.diamond

			local function var_12_9()
				arg_12_0.costLabel:setString(arg_12_1.slidecost.costnum * arg_12_0.nowNum)

				if utfstrlen(arg_12_0.costLabel:getString()) > 6 then
					arg_12_0.costLabel:setScale(0.6)
				elseif utfstrlen(arg_12_0.costLabel:getString()) > 5 then
					arg_12_0.costLabel:setScale(0.8)
				else
					arg_12_0.costLabel:setScale(1)
				end

				arg_12_0.callback_button:setBright(true)

				if arg_12_1.slidecost.costnum * arg_12_0.nowNum <= (arg_12_1.slidecost.nowHave or 0) then
					arg_12_0.callback_button:setColor(cc.c3b(255, 255, 255))
					arg_12_0.Label_button:setString(L_BUTTON_TEXT.Buy)
				else
					arg_12_0.callback_button:setColor(cc.c3b(255, 255, 255))
					arg_12_0.Label_button:setString(L_MARKET_MSG.Item_Lack)
				end

				if arg_12_1.marketType == "market_collection" then
					if arg_12_0.nowNum > item_manager:getItemNumber(arg_12_1.itemid) then
						arg_12_0.Label_button:setString(L_MARKET_MSG.Item_Lack)

						return
					else
						arg_12_0.Label_button:setString(L_BUTTON_TEXT.Sell)

						return
					end
				end
			end

			local function var_12_10()
				if arg_12_1.baggain.gainunit then
					arg_12_0.costLabel:setString(arg_12_1.baggain.gainunit * arg_12_0.nowNum)
				end

				arg_12_0.callback_button:setBright(true)
				arg_12_0.callback_button:setColor(cc.c3b(255, 255, 255))
				arg_12_0.Label_button:setString(L_BUTTON_TEXT.Use)
			end

			local function var_12_11(arg_16_0, arg_16_1)
				arg_12_0.nowNum = math.ceil(tonumber(var_12_2:getPercent() / 100 * var_12_3))

				if arg_12_0.nowNum == 0 then
					arg_12_0.nowNum = 1
				end

				if arg_12_1.marketType == "market_collection" and arg_12_0.nowNum > item_manager:getItemNumber(arg_12_1.itemid) then
					global_ShowBlockWords(L_MARKET_MSG.Own_Lack)

					arg_12_0.nowNum = item_manager:getItemNumber(arg_12_1.itemid)
				end

				arg_12_0.callback_button.nowNum = arg_12_0.nowNum

				var_12_4:setString(arg_12_0.nowNum .. "/" .. var_12_3)
				var_12_2:setPercent((arg_12_0.nowNum - 1) * 100 / (var_12_3 - 1))

				if arg_12_1.slidecost then
					var_12_9()
				elseif arg_12_1.baggain then
					var_12_10()
				end
			end

			local function var_12_12(arg_17_0, arg_17_1)
				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_12_1.marketType == "market_collection" and arg_12_0.nowNum + 1 > item_manager:getItemNumber(arg_12_1.itemid) then
					audio_manager:playeffectMusicTest("sound/invalid")
					global_ShowBlockWords(L_MARKET_MSG.Own_Lack)

					return
				end

				if arg_12_1.limitNum then
					if arg_12_0.nowNum < var_12_3 then
						arg_12_0.nowNum = arg_12_0.nowNum + 1
						arg_12_0.callback_button.nowNum = arg_12_0.nowNum

						var_12_2:setPercent((math.ceil((arg_12_0.nowNum - 1) * 100 / (var_12_3 - 1))))
						var_12_4:setString(arg_12_0.nowNum .. "/" .. var_12_3)
					end
				else
					arg_12_0.nowNum = arg_12_0.nowNum + 1
					arg_12_0.callback_button.nowNum = arg_12_0.nowNum
				end

				if arg_12_1.slidecost then
					var_12_9()
				elseif arg_12_1.baggain then
					var_12_10()
				end
			end

			local function var_12_13(arg_18_0, arg_18_1)
				if arg_18_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_12_0.nowNum > 1 then
					arg_12_0.nowNum = arg_12_0.nowNum - 1
					arg_12_0.callback_button.nowNum = arg_12_0.nowNum

					if arg_12_1.limitNum then
						var_12_2:setPercent((math.ceil((arg_12_0.nowNum - 1) * 100 / (var_12_3 - 1))))
						var_12_4:setString(arg_12_0.nowNum .. "/" .. var_12_3)
					end
				end

				if arg_12_1.slidecost then
					var_12_9()
				elseif arg_12_1.baggain then
					var_12_10()
				end
			end
		end

		;(function()
			if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
				var_12_2 = ccui.Slider:create()

				var_12_2:setName("slider")

				var_12_3 = arg_12_1.limitNum
				var_12_5 = ccui.Layout:create()

				var_12_5:setName("layout_slider")
				var_12_5:setContentSize(cc.size(240, 80))
				var_12_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
				var_12_5:setPosition(cc.p(70, -10))
				var_12_0:addChild(var_12_5, 1)

				var_12_4 = cc.Label:createWithTTF(arg_12_0.nowNum .. "/" .. var_12_3, FONT_DES, var_12_1)

				var_12_4:setPosition(cc.p(var_12_5:getContentSize().width / 2 + 80, var_12_5:getContentSize().height / 2 + 15))
				var_12_0:addChild(var_12_4, 3)
				var_12_2:loadBarTexture("public/panelbg/blue_slider_bottom.png", var_0_8)
				var_12_2:loadProgressBarTexture("public/panelbg/blue_slider_bar.png", var_0_8)
				var_12_2:loadSlidBallTextures("public/button/blue_slider_node.png", "public/button/blue_slider_node.png", "public/button/blue_slider_node.png", var_0_8)
				var_12_2:setPercent((arg_12_0.nowNum - 1) * 100 / (var_12_3 - 1))
			end
		end)()
		;(function()
			if arg_12_1.limitNum and arg_12_1.limitNum > 1 then
				local var_19_0 = ccui.Layout:create()

				var_19_0:setTouchEnabled(true)
				var_19_0:setContentSize(cc.size(var_12_2:getContentSize().width, var_12_2:getContentSize().height + 40))
				var_19_0:setAnchorPoint(cc.p(0.5, 0.5))
				var_19_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
				var_19_0:setPosition(cc.p(var_12_2:getContentSize().width / 2, var_12_2:getContentSize().height / 2))
				var_12_2:addChild(var_19_0, 99)
				var_19_0:addTouchEventListener(function(arg_20_0, arg_20_1)
					if arg_20_1 == ccui.TouchEventType.moved then
						var_12_2:setPercent(var_19_0:convertToNodeSpace((arg_20_0:getTouchMovePosition())).x * 100 / var_19_0:getContentSize().width)
					end

					if arg_20_1 == ccui.TouchEventType.began then
						var_12_2:setPercent(var_19_0:convertToNodeSpace((arg_20_0:getTouchBeganPosition())).x * 100 / var_19_0:getContentSize().width)
					end

					var_12_11()
				end)
			end
		end)()
		;(function()
			var_12_7 = ccui.Button:create("public/button/add_blue_btn.png", nil, "public/button/add_blue_btn.png", var_0_8)
			var_12_8 = ccui.Button:create("public/button/sub_blue_btn.png", nil, "public/button/sub_blue_btn.png", var_0_8)

			if arg_12_1.limitNum and arg_12_1.limitNum > 1 and var_12_3 ~= 1 and var_12_3 ~= 0 then
				var_12_2:addEventListener(var_12_11)
				var_12_5:addChild(var_12_2, 3)
				var_12_7:setPosition(cc.p(var_12_5:getContentSize().width / 2 + 125, var_12_5:getContentSize().height / 2 + 2))
				var_12_8:setPosition(cc.p(var_12_5:getContentSize().width / 2 - 100, var_12_5:getContentSize().height / 2 + 2))
				var_12_2:setPosition(cc.p(var_12_5:getContentSize().width / 2 + 12, var_12_5:getContentSize().height / 2 + 2))

				if var_12_6 then
					var_12_6:setVisible(true)
				end

				var_12_5:addChild(var_12_7, 3)
				var_12_5:addChild(var_12_8, 3)
			elseif not arg_12_1.limitNum then
				var_12_7:setPosition(cc.p(510, 380))
				var_12_8:setPosition(cc.p(310, 380))
			else
				var_12_7:setVisible(false)
				var_12_8:setVisible(false)
			end

			var_12_0:addChild(arg_12_0.callback_button, 3)
			var_12_7:setName("add_button")
			var_12_8:setName("sub_button")
			var_12_7:addTouchEventListener(var_12_12)
			var_12_8:addTouchEventListener(var_12_13)

			if arg_12_1.slidecost and arg_12_1.slidecost.costtype and arg_12_1.slidecost.costtype == "recharge/rmb_white.png" then
				var_12_7:setVisible(false)
				var_12_8:setVisible(false)
			end
		end)()
	end

	return var_12_0
end

function PopGoodsLayer:updateWithCoupins(arg_22_1)
	if not arg_22_1.couponList or not next(arg_22_1.couponList) then
		return
	end

	local var_22_0 = arg_22_1.couponList
	local var_22_2 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_1.couponList) do
		if #var_22_2 == 0 then
			table.insert(var_22_2, iter_22_1)
		else
			for iter_22_2, iter_22_3 in pairs(var_22_2) do
				if tonumber(iter_22_1.discount1) > tonumber(iter_22_3.discount1) then
					table.insert(var_22_2, iter_22_2, iter_22_1)

					break
				elseif item_manager:getItemNumber(tonumber(iter_22_1.id)) > item_manager:getItemNumber(tonumber(iter_22_3.id)) then
					if iter_22_2 == 1 then
						print("aaaaaa2")
						table.insert(var_22_2, 1, iter_22_1)

						break
					end
				else
					table.insert(var_22_2, iter_22_2 + 1, iter_22_1)

					break
				end
			end
		end

		if #var_22_2 == 5 then
			table.remove(var_22_2, 5)

			break
		end
	end

	local var_22_3 = ccui.ImageView:create("public/panelbg/coupon_select_bg.png", var_0_8)

	var_22_3:setScaleY(#var_22_0 + 1)
	var_22_3:setAnchorPoint(cc.p(0.5, 1))
	var_22_3:setPosition(cc.p(310, 420))
	self.rootpanel:addChild(var_22_3, 1)
	self.layerone:setPositionY(self.layerone:getPositionY() - (#var_22_0 + 1 - 1) * 45)
	self.layertwo:setPositionY(self.layertwo:getPositionY() - (#var_22_0 + 1 - 1) * 45)

	if self.layerone:getChildByName("time_label") then
		self.layerone:getChildByName("time_label"):setVisible(false)
	end

	self.selectBtnList = {}

	for iter_22_4, iter_22_5 in pairs(var_22_2) do
		local var_22_4 = ccui.ImageView:create("public/panelbg/coupon_sprite_bg.png", var_0_8)

		var_22_4:setScaleY(1 / (#var_22_0 + 1))
		var_22_4:setPosition(cc.p(250, var_22_3:getContentSize().height - 5 - 11 * (iter_22_4 - 1)))
		var_22_3:addChild(var_22_4)

		local var_22_5 = ccui.ImageView:create("equipment/" .. iter_22_5.id .. ".png")

		var_22_5:setScale(0.3)
		var_22_5:setPosition(cc.p(40, 23))
		var_22_4:addChild(var_22_5)

		local var_22_6 = cc.Label:createWithTTF(iter_22_5.name .. " X" .. item_manager:getItemNumber(iter_22_5.id), FONT_NAME, 20)

		var_22_6:setColor(cc.c3b(188, 206, 226))
		var_22_6:setAnchorPoint(cc.p(0, 0.5))
		var_22_6:setPosition(cc.p(80, 23))
		var_22_4:addChild(var_22_6)

		local var_22_7

		if config._DEBUG then
			var_22_7 = cc.Sprite:create(arg_22_1.slidecost.costtype) or cc.Sprite:createWithSpriteFrameName(arg_22_1.slidecost.costtype)
		end

		var_22_7:setPosition(cc.p(355, 23))
		var_22_4:addChild(var_22_7)

		local var_22_8 = "-" .. iter_22_5.discount1

		if iter_22_5.discount1 == -1 then
			var_22_8 = L_FREE_BUY

			var_22_7:setVisible(false)

			iter_22_5.discount1 = arg_22_1.slidecost.costnum
		end

		local var_22_9 = cc.Label:createWithTTF(var_22_8, FONT_NAME, 24)

		var_22_9:setColor(cc.c3b(188, 206, 226))
		var_22_9:setPosition(cc.p(400, 23))
		var_22_4:addChild(var_22_9)

		local var_22_10 = ccui.Button:create("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_8)

		self.selectBtnList[iter_22_4] = var_22_10

		var_22_10:setPosition(cc.p(444, 22))
		var_22_4:addChild(var_22_10)
		var_22_10:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateSelectBtn(iter_22_4)

			self.selectCoupon = iter_22_5.id

			self.costLabel:setString(arg_22_1.slidecost.costnum - iter_22_5.discount1)
		end)
	end

	if var_22_0[1] then
		self:updateSelectBtn(1)

		self.selectCoupon = var_22_0[1].id

		self.costLabel:setString(arg_22_1.slidecost.costnum - var_22_0[1].discount1)
	end
end

function PopGoodsLayer:updateSelectBtn(arg_24_1)
	for iter_24_0, iter_24_1 in pairs(self.selectBtnList) do
		if iter_24_0 == arg_24_1 then
			iter_24_1:loadTextures("public/button/coupon_select.png", "public/button/coupon_select.png", "public/button/coupon_select.png", var_0_8)
		else
			iter_24_1:loadTextures("public/button/coupon_unselect.png", "public/button/coupon_unselect.png", "public/button/coupon_unselect.png", var_0_8)
		end
	end
end

function PopGoodsLayer:updateToFlopShop(arg_25_1)
	if arg_25_1.to_shop then
		cc.UserDefault:getInstance():setIntegerForKey("flopShop", 1)

		local var_25_0 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_8)

		var_25_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_0:setPosition(cc.p(self.callback_button:getPositionX(), self.callback_button:getPositionY() - 120))
		self.layertwo:addChild(var_25_0, 1)

		local var_25_1 = cc.Label:createWithTTF(L_GO_SHOP_FOR_GIFTBAG, FONT_TITLE, 30)

		var_25_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_1:setColor(cc.c3b(0, 0, 0))
		var_25_0:addChild(var_25_1)
		var_25_0:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = arg_25_1.to_shop
			})
		end)

		if not arg_25_1.limitNum or arg_25_1.limitNum < 1 then
			var_25_0:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_8)
		end

		var_25_1:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2 - 5))
	end
end

function PopGoodsLayer:buyShop()
	local var_27_0 = self.msg.shopid
	local var_27_1 = require("data.shop_data")[self.msg.shopid].shop_type
	local var_27_2 = shop_manager:getPopShopInfo()

	if var_27_2.activity_level then
		global_ShowBlockWords(L_MARKET_MSG.LEVEL_BUZU)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	if var_27_2.have_bought >= var_27_2.buy_limit then
		global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
		audio_manager:playeffectMusicTest("sound/invalid")

		return
	end

	if var_27_2.sell_time and timeCheckManager:getCurTime() < global_get_time_by_date(var_27_2.sell_time) then
		global_ShowBlockWords(var_27_2.sell_time .. L_START_BUY)

		return
	end

	if self.selectCoupon then
		if var_27_2.cost > shop_manager:getCurrencyNum(var_27_2.currency) + discountManager:getCouponsDiscount(self.selectCoupon) then
			LayerManager:removePopLayer(self.__queueindex)
			shop_manager:popGoGain(var_27_2.currency)

			return
		end
	elseif var_27_2.cost * self.nowNum > shop_manager:getCurrencyNum(var_27_2.currency) then
		LayerManager:removePopLayer(self.__queueindex)
		shop_manager:popGoGain(var_27_2.currency)

		return
	end

	if shop_manager:isWeaponMax(nil, self.msg.itemid, self.nowNum) then
		global_ShowBlockWords(L_WEAPON_SELECT_MAX_STAR)

		return
	end

	if self.rpcing then
		return
	end

	local function var_27_3(arg_28_0)
		self.rpcing = false

		if var_0_9 then
			LayerManager:removePopLayer(self.__queueindex)
		end

		if arg_28_0 == 1 then
			if item_data[self.msg.itemid].bag_item_type == kITEM_HERO then
				require("view.Layer.GetRoleAnimationLayer")
				cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(self.msg.itemid), 1000)
			end

			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("on_buy_shop")))
		elseif arg_28_0 == 2 then
			global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
			audio_manager:playeffectMusicTest("sound/invalid")
		elseif arg_28_0 == 3 then
			shop_manager:popGoGain(var_27_2.currency)
		end
	end

	self.rpcing = true

	if self.selectCoupon then
		shop_manager:shop_buy_with_ticket(var_27_1, var_27_0, var_27_3, self.nowNum, nil, self.selectCoupon, 1)
	else
		shop_manager:shop_buy(var_27_1, var_27_0, var_27_3, self.nowNum)
	end
end
