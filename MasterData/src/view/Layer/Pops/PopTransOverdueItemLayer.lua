PopTransOverdueItemLayer = class("PopTransOverdueItemLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local mail_data = require("data.mail_data")

function PopTransOverdueItemLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTransOverdueItemLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopTransOverdueItemLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.dataList = {}
	self.initParam = arg_3_1
	self.rootpanel = ccui.ImageView:create("public/panelbg/normal_bg_new.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.rootpanel)
	self.rootpanel:setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)

			if arg_3_1 and arg_3_1.exitcallback then
				arg_3_1.exitcallback()
			end
		end)
	end, 0)
	self:initUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			LayerManager:pushInLayer("PopPurchaseResultLayer", {
				items = self.initParam.items
			})
		end
	end)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self.initParam.items) do
		table.insert(var_3_0, {
			itemid = iter_3_1.entityid,
			num = iter_3_1.dropNum
		})
	end

	self:createTableView(var_3_0, cc.p(10, 10))

	local var_3_1 = {}

	for iter_3_2, iter_3_3 in pairs(self.initParam.consumes) do
		table.insert(var_3_1, {
			istrans = true,
			itemid = iter_3_3.entityid,
			num = iter_3_3.num
		})
	end

	self:createTableView(var_3_1, cc.p(10, 240))
end

function PopTransOverdueItemLayer:initUI()
	self.title = ccui.ImageView:create("public/title/title_bg.png", var_0_0)

	self.title:setPositionX(108)
	self.title:setPositionY(self.rootpanel:getContentSize().height + self.title:getContentSize().height / 2 - 2)
	self.rootpanel:addChild(self.title)

	local var_7_0 = cc.Label:createWithTTF("过期物品回收", FONT_BUTTON, 28)

	var_7_0:setColor(cc.c3b(248, 243, 255))
	var_7_0:setAnchorPoint(cc.p(0, 0.5))
	var_7_0:setPosition(cc.p(14, self.title:getContentSize().height / 2))
	self.title:addChild(var_7_0)

	local var_7_1 = ccui.ImageView:create("public/panelbg/trans_line.png", var_0_0)

	var_7_1:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_7_1:setPositionY(self.rootpanel:getContentSize().height / 2)
	self.rootpanel:addChild(var_7_1)

	self.getAwardBtn = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)

	self.getAwardBtn:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, -50))
	self.rootpanel:addChild(self.getAwardBtn)
	self.getAwardBtn:addTouchEventListener(self:getSureHanel())

	self.getAwardLabel = cc.Label:createWithTTF("确定", FONT_BUTTON, 32)

	self.getAwardLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self.getAwardLabel:setColor(cc.c3b(12, 12, 12))
	self.getAwardLabel:setPosition(cc.p(self.getAwardBtn:getContentSize().width / 2, self.getAwardBtn:getContentSize().height / 2 - 5))
	self.getAwardBtn:addChild(self.getAwardLabel)

	local var_7_2 = ccui.Layout:create()

	var_7_2:setTouchEnabled(true)
	var_7_2:setContentSize(cc.size(self.rootpanel:getContentSize().width - 40, 32))
	var_7_2:setAnchorPoint(cc.p(0, 0))
	var_7_2:setPosition(cc.p(20, 414))
	var_7_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_2:setOpacity(120)
	self.rootpanel:addChild(var_7_2)

	local var_7_3 = cc.Label:createWithTTF("班长~ 以下的物品已经过期，喵酱回收了哟", FONT_BUTTON, 18)

	var_7_3:setColor(cc.c3b(248, 243, 255))
	var_7_3:setPositionX(10)
	var_7_3:setAnchorPoint(cc.p(0, 0.5))
	var_7_3:setPositionY(var_7_2:getContentSize().height / 2)
	var_7_2:addChild(var_7_3)

	local var_7_4 = ccui.Layout:create()

	var_7_4:setTouchEnabled(true)
	var_7_4:setContentSize(cc.size(self.rootpanel:getContentSize().width - 40, 30))
	var_7_4:setAnchorPoint(cc.p(0, 0))
	var_7_4:setPosition(cc.p(20, 188))
	var_7_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_4:setOpacity(120)
	self.rootpanel:addChild(var_7_4)

	local var_7_5 = cc.Label:createWithTTF("获得收益", FONT_BUTTON, 18)

	var_7_5:setColor(cc.c3b(248, 243, 255))
	var_7_5:setPositionX(10)
	var_7_5:setAnchorPoint(cc.p(0, 0.5))
	var_7_5:setPositionY(var_7_4:getContentSize().height / 2)
	var_7_4:addChild(var_7_5)
end

local var_0_10 = 560
local var_0_11 = 174
local var_0_12 = 145
local var_0_13 = 140
local var_0_14 = {
	cc.p(80, 70),
	cc.p(190, 70),
	cc.p(300, 70),
	(cc.p(410, 70))
}
local var_0_15 = 4
local var_0_16 = 0.55

function PopTransOverdueItemLayer:createTableView(arg_8_1, arg_8_2)
	local var_8_0 = cc.TableView:create(cc.size(var_0_10, var_0_11))

	var_8_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_8_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_8_0:setPosition(cc.p(arg_8_2.x, arg_8_2.y))
	var_8_0:setDelegate()
	self.rootpanel:addChild(var_8_0)
	var_8_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		return var_0_12, var_0_13
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_8_0:registerScriptHandler(function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:dequeueCell()

		if not var_10_0 then
			var_10_0 = cc.TableViewCell:create()

			for iter_10_0 = 1, var_0_15 do
				local var_10_1 = self:createSp()

				var_10_1:setScale(var_0_16)
				var_10_1:setName("sp_" .. iter_10_0)
				var_10_1:setPosition(var_0_14[iter_10_0])
				var_10_0:addChild(var_10_1)
			end
		end

		for iter_10_1 = 1, var_0_15 do
			local var_10_2 = var_10_0:getChildByName("sp_" .. iter_10_1)

			if arg_8_1[arg_10_1 * var_0_15 + iter_10_1] then
				var_10_2:setVisible(true)
				var_10_2:update(arg_8_1[arg_10_1 * var_0_15 + iter_10_1])
			else
				var_10_2:setVisible(false)
			end
		end

		return var_10_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_8_0:registerScriptHandler(function(arg_11_0, arg_11_1)
		return math.ceil(#arg_8_1 / var_0_15)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_8_0:reloadData()
	var_8_0:updateCellAtIndex(0)
end

function PopTransOverdueItemLayer.createSp(arg_12_0)
	local var_12_0 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

	var_12_0:setSwallowTouches(false)

	function var_12_0:update(arg_13_1)
		var_12_0.itemid = arg_13_1.itemid
		var_12_0.num = arg_13_1.num

		if self:getChildByName("itemSp") then
			self:getChildByName("itemSp"):removeFromParent()
		end

		local var_13_0 = ItemSprite:createNewWithItemId(var_12_0.itemid, var_12_0.num)

		var_13_0:setName("itemSp")
		var_13_0:setAnchorPoint(cc.p(0, 0))
		self:addChild(var_13_0)

		if not self:getChildByName("transTitle") then
			local var_13_1 = ccui.Layout:create()

			var_13_1:setScale(1 / var_0_16)
			var_13_1:setTouchEnabled(true)
			var_13_1:setContentSize(cc.size(57, 21))
			var_13_1:setAnchorPoint(cc.p(1, 1))
			var_13_1:setPosition(cc.p(self:getContentSize().width + 10, self:getContentSize().height + 10))
			var_13_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_13_1:setBackGroundColor(cc.c3b(224, 171, 11))
			var_13_1:setName("transTitle")
			self:addChild(var_13_1, 1000)

			local var_13_2 = cc.Label:createWithTTF("已过期", FONT_BUTTON, 19)

			var_13_2:setPositionX(var_13_1:getContentSize().width / 2)
			var_13_2:setPositionY(var_13_1:getContentSize().height / 2)
			var_13_1:addChild(var_13_2)
		end

		self:getChildByName("transTitle"):setVisible(arg_13_1.istrans == true)
	end

	var_12_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_0.itemid == CURRENCY_DIAMOND_PAID or arg_14_0.itemid == "diamond" then
			return
		end

		PopLayer:Item({
			hideGainButton = true,
			itemid = arg_14_0.itemid
		})
	end)

	return var_12_0
end

function PopTransOverdueItemLayer.getSureHanel(arg_15_0)
	return function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_15_0:exit()
	end
end

function PopTransOverdueItemLayer:initBg(arg_17_1)
	local var_17_0 = ccui.Layout:create()

	var_17_0:setTouchEnabled(true)
	var_17_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_17_0:setAnchorPoint(cc.p(0, 0))
	var_17_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_17_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_17_0:setOpacity(0)
	self:addChild(var_17_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_18_0)
		self:addChild(arg_18_0, -2)
		arg_18_0:setPositionY(arg_18_0:getPositionY() - GameDisplay.fix_y)

		local var_18_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_18_0:setAnchorPoint(cc.p(0, 0))
		var_18_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_18_0, -1)
		self:init(arg_17_1)
		var_17_0:setOpacity(102)
		var_17_0:setTouchEnabled(false)
	end)
end

function PopTransOverdueItemLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
