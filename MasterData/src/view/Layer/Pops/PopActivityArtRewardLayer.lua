PopActivityArtRewardLayer = class("PopActivityArtRewardLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 170
local var_0_1 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")

function PopActivityArtRewardLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityArtRewardLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivityArtRewardLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	var_3_0:setCascadeOpacityEnabled(false)
	self:addChild(var_3_0, -1)

	local var_3_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_1:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopActivityArtRewardLayer:init(arg_5_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "HalloweenDetailPage.json" or "HalloweenDetailPage.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, 0))
	self:addChild(self.rootLayer, 2)

	self.activityId = arg_5_1.activityId
	self.callback = arg_5_1.callback

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

function PopActivityArtRewardLayer:initUI()
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.tip = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_7")

	self.tip:setString(L_ACTIVITY_ART_RANK)

	local var_7_0 = cc.Label:createWithTTF(L_ACTIVITY_ART_RANK_DETAIL_1, FONT_NAME, 15)

	var_7_0:setPosition(cc.p(280, 780))
	self.rootpanel:addChild(var_7_0)

	local var_7_1 = cc.Label:createWithTTF(L_ACTIVITY_ART_RANK_DETAIL_2, FONT_NAME, 15)

	var_7_1:setPosition(cc.p(280, 760))
	self.rootpanel:addChild(var_7_1)

	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	self.surebtn:getChildByName("label"):setString(L_BUTTON_TEXT.UnGet)
	self:createFullScreenMask(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.rootpanel, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 120)
	self.surebtn:addTouchEventListener(self:getSurehandel())
	self:initTableView()
end

function PopActivityArtRewardLayer.getSurehandel(arg_10_0)
	return function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getArtRankListReward(arg_10_0.activityId)
	end
end

function PopActivityArtRewardLayer:initTableView()
	self.dataList = activity_manager:getArtRankDropList(self.activityId)
	self.dropView = cc.TableView:create(cc.size(640, 720))

	self.dropView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.dropView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.dropView:setAnchorPoint(cc.p(0, 0))
	self.dropView:setPosition(0, 30)
	self.dropView:setDelegate()
	self.rootpanel:addChild(self.dropView)
	self.dropView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return 640, var_0_0
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.dropView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_2 = self:createDropSprite(self.dataList[arg_13_1 + 1])

			var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_2:setPosition(cc.p(280, var_0_0 / 2))
			var_13_0:addChild(var_13_2)
			var_13_0:setLocalZOrder(999 - 10 * arg_13_1)
		else
			self:updateDropSprite(var_13_0:getChildByTag(100), self.dataList[arg_13_1 + 1])
			var_13_0:setLocalZOrder(999 - 10 * arg_13_1)
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.dropView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.dataList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.dropView:reloadData()
end

function PopActivityArtRewardLayer.createDropSprite(arg_16_0, arg_16_1)
	local var_16_0 = ccui.ImageView:create("public/panelbg/intro_bottom.png", var_0_1)

	var_16_0:setTag(100)
	var_16_0:setScale9Enabled(true)
	var_16_0:setCapInsets(cc.rect(2, 5, 5, 5))
	var_16_0:setContentSize(cc.size(502, 158))

	local var_16_1 = cc.Label:createWithTTF(L_SYSTEM_UNLOCK_WORD.RankLayer, FONT_NAME, 40)

	var_16_1:setColor(cc.c3b(255, 211, 107))
	var_16_1:setPosition(cc.p(60, 110))
	var_16_0:addChild(var_16_1)

	local var_16_2 = cc.Label:createWithTTF(arg_16_1.detail, FONT_NAME, 26)

	var_16_2:setName("lbl_detail")
	var_16_2:setPosition(cc.p(60, 50))
	var_16_0:addChild(var_16_2)

	local var_16_3 = ccui.Layout:create()

	var_16_3:setPosition(cc.p(var_16_0:getContentSize().width / 2 - 10, var_0_0 / 2 + 10))
	var_16_3:setName("drop_node")
	var_16_0:addChild(var_16_3)

	for iter_16_0, iter_16_1 in pairs((drop_manager:getAllDrops(arg_16_1.dropid))) do
		local var_16_4 = ItemPurchaseSprite:createPurchaseItem(iter_16_1.dropid, iter_16_1.dropNum)

		var_16_4:setScale(0.65)
		var_16_4:setTouchEnabled(true)
		var_16_4:setSwallowTouches(false)
		var_16_4:setPosition(cc.p(-70 + (iter_16_0 - 1) * 120, -10))
		var_16_3:addChild(var_16_4)

		if item_data[iter_16_1.dropid].bag_item_type == kITEM_SCULTURE then
			var_16_4:getChildByName("wordBg"):setVisible(false)
			var_16_4:getChildByName("numLabel"):setVisible(false)
		else
			var_16_4:getChildByName("wordBg"):setVisible(true)
			var_16_4:getChildByName("numLabel"):setVisible(true)
		end

		var_16_4:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_16_1.dropid)
		end)
	end

	return var_16_0
end

function PopActivityArtRewardLayer.updateDropSprite(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1:setTag(100)
	arg_18_1:getChildByName("lbl_detail"):setString(arg_18_2.detail)

	local var_18_0 = arg_18_1:getChildByName("drop_node")

	if var_18_0 then
		var_18_0:removeFromParent()
	end

	local var_18_1 = drop_manager:getAllDrops(arg_18_2.dropid)
	local var_18_2 = ccui.Layout:create()

	var_18_2:setPosition(cc.p(arg_18_1:getContentSize().width / 2 - 10, var_0_0 / 2 + 10))
	var_18_2:setName("drop_node")
	arg_18_1:addChild(var_18_2)

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		local var_18_3 = ItemPurchaseSprite:createPurchaseItem(iter_18_1.dropid, iter_18_1.dropNum)

		var_18_3:setScale(0.65)
		var_18_3:setTouchEnabled(true)
		var_18_3:setSwallowTouches(false)
		var_18_3:setPosition(cc.p(-70 + (iter_18_0 - 1) * 120, -10))
		var_18_2:addChild(var_18_3)

		if item_data[iter_18_1.dropid].bag_item_type == kITEM_SCULTURE then
			var_18_3:getChildByName("wordBg"):setVisible(false)
			var_18_3:getChildByName("numLabel"):setVisible(false)
		else
			var_18_3:getChildByName("wordBg"):setVisible(true)
			var_18_3:getChildByName("numLabel"):setVisible(true)
		end

		var_18_3:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_18_1.dropid)
		end)
	end
end
