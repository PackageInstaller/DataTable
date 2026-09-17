PopOpenBagInfoLayer = class("PopOpenBagInfoLayer", function()
	return PopBaseLayer:create()
end)

function PopOpenBagInfoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopOpenBagInfoLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local item_data = require("data.item_data")
local activity_openbag_data = require("data.activity_openbag_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local var_0_7 = 110
local var_0_8 = 5
local var_0_9 = "mainScenebg/market/"
local var_0_10 = config._DEBUG and 0 or 1
local l2utils = require("controller.l2utils")

function PopOpenBagInfoLayer:init(arg_3_1)
	print("open poplayer : PopOpenBagInfoLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0.5))
	self.rootLayer:setPositionY(GameDisplay:getScreenSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.rootLayer)
	self:initUI(arg_3_1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopOpenBagInfoLayer:initUI(arg_5_1)
	self:initExitTouchEvent()
	self:initOpenBagDrop(arg_5_1)
	self:initShopInfo(arg_5_1)
	self:initDetail()
end

function PopOpenBagInfoLayer:initExitTouchEvent()
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self:exit()
	end)
end

function PopOpenBagInfoLayer:initShopInfo(arg_8_1)
	local var_8_0 = ccui.ImageView:create(var_0_9 .. arg_8_1.itemid .. ".png")

	var_8_0:setTouchEnabled(true)
	var_8_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 + 220))
	self.rootLayer:addChild(var_8_0)

	local var_8_1 = ccui.Button:create("public/button/btn_detail_blue.png", nil, "public/button/btn_detail_blue.png", var_0_10)

	var_8_0:addChild(var_8_1)
	var_8_1:setScale(0.77)
	var_8_1:setPosition(cc.p(176, -25))
	var_8_1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "open_bag_" .. arg_8_1.itemid
		})
	end)

	if arg_8_1.slidecost then
		local var_8_2 = ccui.ImageView:create(arg_8_1.slidecost.costtype, var_0_10)

		var_8_2:setPositionX(var_8_0:getContentSize().width * 1 / 4 - 25)
		var_8_2:setPositionY(-433)
		var_8_0:addChild(var_8_2)

		local var_8_3 = cc.Label:createWithTTF(arg_8_1.slidecost.costnum, FONT_DES, 23)

		var_8_3:setAnchorPoint(cc.p(0, 0.5))
		var_8_3:setPositionX(var_8_2:getPositionX() + var_8_2:getContentSize().width / 2 + 5)
		var_8_3:setPositionY(var_8_2:getPositionY())
		var_8_3:setColor(cc.c3b(255, 245, 220))
		var_8_0:addChild(var_8_3)

		local var_8_4 = ccui.ImageView:create(arg_8_1.slidecost.costtype, var_0_10)

		var_8_4:setPositionX(var_8_0:getContentSize().width * 3 / 4 - 25)
		var_8_4:setPositionY(-433)
		var_8_0:addChild(var_8_4)

		local var_8_5 = cc.Label:createWithTTF(arg_8_1.slidecost.costnum * 5, FONT_DES, 23)

		var_8_5:setAnchorPoint(cc.p(0, 0.5))
		var_8_5:setPositionX(var_8_4:getPositionX() + var_8_4:getContentSize().width / 2 + 5)
		var_8_5:setPositionY(var_8_4:getPositionY())
		var_8_5:setColor(cc.c3b(255, 245, 220))
		var_8_0:addChild(var_8_5)
	end

	local var_8_6 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_10)

	var_8_6:setPosition(cc.p(var_8_0:getContentSize().width * 1 / 4, -380))

	local var_8_7 = cc.Label:createWithTTF((arg_8_1.slidecost or nil) and (L_BUY_ONE or L_USE_ONE), FONT_BUTTON, 26)

	var_8_7:setColor(cc.c3b(12, 12, 12))
	var_8_7:setPosition(cc.p(var_8_6:getContentSize().width / 2, var_8_6:getContentSize().height / 2))
	var_8_6:addChild(var_8_7)
	var_8_0:addChild(var_8_6)
	var_8_6:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0.nowNum = 1
		arg_10_0.closePop = false

		l2utils:performNodeWithDelay(arg_10_0)

		if arg_8_1.ShopSliderCallback then
			arg_8_1.ShopSliderCallback(arg_10_0, arg_10_1, callback)
		end
	end)

	local var_8_8 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_10)
	local var_8_9 = cc.Label:createWithTTF((arg_8_1.slidecost or nil) and (L_BUY_FIVE or L_USE_FIVE), FONT_BUTTON, 26)

	var_8_9:setColor(cc.c3b(12, 12, 12))
	var_8_8:setPosition(cc.p(var_8_0:getContentSize().width * 3 / 4, -380))
	var_8_9:setPosition(cc.p(var_8_8:getContentSize().width / 2, var_8_8:getContentSize().height / 2))
	var_8_8:addChild(var_8_9)
	var_8_0:addChild(var_8_8)
	var_8_8:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0.nowNum = 5
		arg_11_0.closePop = false

		l2utils:performNodeWithDelay(arg_11_0)

		if arg_8_1.ShopSliderCallback then
			arg_8_1.ShopSliderCallback(arg_11_0, arg_11_1, callback)
		end
	end)
	self.rootLayer:setScaleY(0)
	self.rootLayer:runAction(cc.ScaleTo:create(0.2, 1))

	if arg_8_1.limit_buy_num and arg_8_1.limit_buy_num < 5 then
		var_8_6:setPositionX(280)
		costNumOne:setPositionX(300)
		costIconOne:setPositionX(260)
		var_8_8:setVisible(false)
		costNumFive:setVisible(false)
		costIconFive:setVisible(false)
	end

	if not arg_8_1.limit_buy_num and item_manager:getItemNumber(arg_8_1.itemid) < 5 then
		var_8_6:setPositionX(280)
		var_8_8:setVisible(false)
	end
end

function PopOpenBagInfoLayer:initOpenBagDrop(arg_12_1)
	local var_12_0 = ccui.ImageView:create("public/panelbg/openbag_panel.png", var_0_10)

	var_12_0:setTouchEnabled(true)
	var_12_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2 - 245))
	self.rootLayer:addChild(var_12_0)

	self.dropList = self:getOpenbagAllDrop(arg_12_1.itemid)
	self.listlen = #self.dropList
	self.dropView = cc.TableView:create(cc.size(560, 260))

	self.dropView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.dropView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.dropView:setAnchorPoint(cc.p(0, 0))
	self.dropView:setPosition(0, 10)
	self.dropView:setDelegate()
	var_12_0:addChild(self.dropView)
	self.dropView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return 640, var_0_7
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.dropView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_2 = self:createDropSprite(arg_13_1)

			var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_2:setPosition(cc.p(320, var_0_7 / 2))
			var_13_0:addChild(var_13_2)
		else
			self:updateDropSprite(var_13_0:getChildByTag(100), arg_13_1)
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.dropView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return math.ceil(self.listlen / 5)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.dropView:reloadData()
end

function PopOpenBagInfoLayer:createDropSprite(arg_16_1)
	local var_16_0 = ccui.Layout:create()

	var_16_0:setContentSize(580, 110)
	var_16_0:setTag(100)

	for iter_16_0 = 1, var_0_8 do
		local var_16_1 = self.dropList[var_0_8 * arg_16_1 + iter_16_0]

		if self.dropList[var_0_8 * arg_16_1 + iter_16_0] then
			local var_16_2 = ccui.ImageView:create("public/box/box_activity_recharge_" .. item_data[var_16_1.dropid].equip_quality .. ".png", var_0_10)

			var_16_2:setName("item" .. iter_16_0)
			var_16_2:setPosition(cc.p(25 + 105 * (iter_16_0 - 1), 55))
			var_16_0:addChild(var_16_2)

			local var_16_3 = ccui.Button:create("equipment/" .. item_data[var_16_1.dropid].image_id .. ".png", "equipment/" .. item_data[var_16_1.dropid].image_id .. ".png", "equipment/" .. item_data[var_16_1.dropid].image_id .. ".png")

			var_16_3:setScale(var_0_7 / var_16_3:getContentSize().height * 0.8)
			var_16_3:setPosition(cc.p(var_16_2:getContentSize().width / 2, var_16_2:getContentSize().height / 2))
			var_16_2:addChild(var_16_3)

			local var_16_4 = ccui.ImageView:create("public/button/open_bag_nomal.png", var_0_10)

			var_16_4:setPosition(cc.p(var_16_2:getContentSize().width / 2, var_16_2:getContentSize().height / 2))
			var_16_4:setName("nomal_img")
			var_16_4:setVisible(var_16_1.isnomal == true)
			var_16_2:addChild(var_16_4)
			var_16_3:setSwallowTouches(false)
			var_16_3:addTouchEventListener(function(arg_17_0, arg_17_1)
				if math.abs(arg_17_0:getTouchBeganPosition().y - arg_17_0:getTouchEndPosition().y) > 15 then
					return
				end

				if arg_17_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(var_16_1.dropid)
			end)
		end
	end

	return var_16_0
end

function PopOpenBagInfoLayer:updateDropSprite(arg_18_1, arg_18_2)
	for iter_18_0 = 1, var_0_8 do
		local var_18_0 = arg_18_1:getChildByName("item" .. iter_18_0)

		if var_18_0 then
			var_18_0:removeFromParent()
		end
	end

	for iter_18_1 = 1, var_0_8 do
		local var_18_1 = self.dropList[var_0_8 * arg_18_2 + iter_18_1]

		if self.dropList[var_0_8 * arg_18_2 + iter_18_1] then
			local var_18_2 = ccui.ImageView:create("public/box/box_activity_recharge_" .. item_data[var_18_1.dropid].equip_quality .. ".png", var_0_10)

			var_18_2:setName("item" .. iter_18_1)
			var_18_2:setPosition(cc.p(25 + 105 * (iter_18_1 - 1), 55))
			arg_18_1:addChild(var_18_2)

			local var_18_3 = ccui.Button:create("equipment/" .. item_data[var_18_1.dropid].image_id .. ".png", "equipment/" .. item_data[var_18_1.dropid].image_id .. ".png", "equipment/" .. item_data[var_18_1.dropid].image_id .. ".png")

			var_18_3:setScale(var_0_7 / var_18_3:getContentSize().height * 0.8)
			var_18_3:setPosition(cc.p(var_18_2:getContentSize().width / 2, var_18_2:getContentSize().height / 2))
			var_18_2:addChild(var_18_3)

			local var_18_4 = ccui.ImageView:create("public/button/open_bag_nomal.png", var_0_10)

			var_18_4:setPosition(cc.p(var_18_2:getContentSize().width / 2, var_18_2:getContentSize().height / 2))
			var_18_4:setName("nomal_img")
			var_18_4:setVisible(var_18_1.isnomal == true)
			var_18_2:addChild(var_18_4)
			var_18_3:setSwallowTouches(false)
			var_18_3:addTouchEventListener(function(arg_19_0, arg_19_1)
				if math.abs(arg_19_0:getTouchBeganPosition().y - arg_19_0:getTouchEndPosition().y) > 15 then
					return
				end

				if arg_19_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(var_18_1.dropid)
			end)
		end
	end
end

function PopOpenBagInfoLayer.getOpenbagAllDrop(arg_20_0, arg_20_1)
	local var_20_0 = {}

	while activity_openbag_data[arg_20_1]["nomal_drop_" .. 1] do
		for iter_20_0, iter_20_1 in pairs((drop_manager:getAllDropsNotMerge(activity_openbag_data[arg_20_1]["nomal_drop_" .. 1]))) do
			if iter_20_1.dropid == activity_openbag_data[arg_20_1].must_item and iter_20_1.dropNum == activity_openbag_data[arg_20_1].must_num then
				iter_20_1.isnomal = true
			end

			table.insert(var_20_0, iter_20_1)
		end

		if activity_openbag_data[arg_20_1]["drop" .. 1] then
			for iter_20_2, iter_20_3 in pairs((drop_manager:getAllDropsNotMerge(activity_openbag_data[arg_20_1]["drop" .. 1]))) do
				table.insert(var_20_0, iter_20_3)
			end
		end
	end

	local var_20_2 = {}

	while var_20_0[1] do
		local var_20_3

		if var_20_2[var_20_0[1].dropid] then
			table.remove(var_20_0, 1)
		else
			var_20_2[var_20_0[1].dropid] = true
			var_20_3 = 1 + 1
		end
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		if item_data[arg_21_0.dropid].open_bag_order and item_data[arg_21_1.dropid].open_bag_order then
			return item_data[arg_21_0.dropid].open_bag_order < item_data[arg_21_1.dropid].open_bag_order
		end

		if item_data[arg_21_0.dropid].equip_quality == item_data[arg_21_1.dropid].equip_quality then
			return OPEN_BAG_ORDER[item_data[arg_21_0.dropid].bag_item_type] < OPEN_BAG_ORDER[item_data[arg_21_1.dropid].bag_item_type]
		end

		return item_data[arg_21_0.dropid].equip_quality > item_data[arg_21_1.dropid].equip_quality
	end)

	return var_20_0
end

function PopOpenBagInfoLayer.initDetail(arg_22_0)
	return
end

function PopOpenBagInfoLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopOpenBagInfoLayer:initBg(arg_25_1)
	local var_25_0 = ccui.Layout:create()

	var_25_0:setTouchEnabled(true)
	var_25_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_25_0:setAnchorPoint(cc.p(0, 0))
	var_25_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_25_0:setOpacity(0)
	self:addChild(var_25_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_26_0)
		self:addChild(arg_26_0, -2)
		arg_26_0:setPositionY(arg_26_0:getPositionY() - GameDisplay.fix_y)

		local var_26_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_26_0:setAnchorPoint(cc.p(0, 0))
		var_26_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_26_0, -1)
		self:init(arg_25_1)
		var_25_0:setOpacity(102)
		var_25_0:setTouchEnabled(false)
	end)
end
