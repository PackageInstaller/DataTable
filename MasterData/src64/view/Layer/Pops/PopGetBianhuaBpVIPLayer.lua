PopGetBianhuaBpVIPLayer = class("PopGetBianhuaBpVIPLayer", function()
	return PopBaseLayer:create()
end)

function PopGetBianhuaBpVIPLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGetBianhuaBpVIPLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local var_0_0 = 140
local var_0_1 = 4
local var_0_2 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")

function PopGetBianhuaBpVIPLayer:init(arg_3_1)
	print("open poplayer : PopGetBianhuaBpVIPLayer")
	print("如果价格歪了就在 activity_bp_conf_data 里改:\n  “btn_pos_x”\n “btn_pos_y”\n “icon_pos_x”\n “icon_pos_y“\n 这四个自己调这玩玩\n 吴春亮不管\n 吴春亮不管\n 吴春亮不管\n 吴春亮不管\n 吴春亮不管\n 吴春亮不管\n 吴春亮不管\n")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopGetBianhuaBpVIPLayer.json" or "PopGetBianhuaBpVIPLayer.ExportJson")

	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.activityId = arg_3_1.activityId or 9
	self.imagePath = arg_3_1.imagePath or "ActivityBianhuaBP"

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopGetBianhuaBpVIPLayer")
		end
	end)
end

function PopGetBianhuaBpVIPLayer:registerActivityEventListener()
	activity_manager:registerEventListener("PopGetBianhuaBpVIPLayer", activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_6_0)
		self:updateVIPButtons()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_7_0)
		self:updateVIPButtons()
	end), self)
end

function PopGetBianhuaBpVIPLayer:initUI()
	self:addTouchEventMask()
	self:updateVIPButtons()
	self:initExitTouchEvent()
	self:initImageInJson()
	self:initDropView()
	self:initDorps()
end

function PopGetBianhuaBpVIPLayer:addTouchEventMask()
	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(cc.size(640, 200))
	var_9_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_9_0:setBackGroundColorOpacity(0)
	var_9_0:setTouchEnabled(true)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self:exit()
	end)
	self:addChild(var_9_0, 0)

	local var_9_1 = ccui.Layout:create()

	var_9_1:setContentSize(cc.size(640, 200))
	var_9_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_1:setPosition(cc.p(0, 1136))
	var_9_1:setBackGroundColorOpacity(0)
	var_9_1:setTouchEnabled(true)
	var_9_1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)
	self:addChild(var_9_1, 0)
end

function PopGetBianhuaBpVIPLayer:updateVIPButtons()
	local var_12_0 = activity_manager:getBPVipBuyBtnPos(self.activityId)
	local var_12_1 = activity_manager:getBPVipBuyIncoPos(self.activityId)

	self.panelBg = self.rootLayer:getChildByName("panel_bg")
	self.btnGetVIP = self.panelBg:getChildByName("btn_get_vip")
	self.btnVipNeed = self.btnGetVIP:getChildByName("btn_vip_need")
	self.VIPGetted = self.btnGetVIP:getChildByName("btn_getted")
	self.VIPCoupon = self.btnGetVIP:getChildByName("vip_coupon")

	self.btnVipNeed:setVisible(not activity_manager:isBattlePassVIP(self.activityId))
	self.VIPGetted:setVisible(activity_manager:isBattlePassVIP(self.activityId))
	self.VIPCoupon:setVisible(activity_manager:getbuyBpVipCouponid(self.activityId, "vip_" .. self.activityId) ~= nil)

	local function var_12_2(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isVIPBtnLock(self.activityId) then
			return
		end

		if activity_manager:isBattlePassVIP(self.activityId) then
			return
		end

		activity_manager:buyVipById(self.activityId, "vip_" .. self.activityId)
		AnalyticManager.touch_bianhua_vipbuy({
			id = "vip_" .. self.activityId
		})
	end

	self.btnGetVIP:addTouchEventListener(var_12_2)
	self.btnVipNeed:addTouchEventListener(var_12_2)

	local var_12_3 = self.btnVipNeed:getChildByName("lbl_vip_need")

	var_12_3:setString("x" .. activity_manager:getVipPriceById(self.activityId, "vip_" .. self.activityId))
	var_12_3:setColor(cc.c3b(71, 31, 129))
	var_12_3:setPosition(var_12_0)
	var_12_3:setAnchorPoint(cc.p(0, 0.5))

	if activity_manager:isRechargeBP(self.activityId, "vip_" .. self.activityId) then
		self.btnVipNeed:getChildByName("money"):setVisible(false)
		var_12_3:setString(string.format(L_MANKEY, activity_manager:getVipPriceById(self.activityId, "vip_" .. self.activityId)))
	end

	self.btnGetSVIP = self.panelBg:getChildByName("btn_get_svip")
	self.btnSVipNeed = self.btnGetSVIP:getChildByName("btn_svip_need")
	self.SVIPGetted = self.btnGetSVIP:getChildByName("btn_getted")
	self.SVIPCoupon = self.btnGetSVIP:getChildByName("vip_coupon")

	self.btnSVipNeed:setVisible(not activity_manager:isBattlePassSVIP(self.activityId))
	self.SVIPGetted:setVisible(activity_manager:isBattlePassSVIP(self.activityId))
	self.SVIPCoupon:setVisible(activity_manager:getbuyBpVipCouponid(self.activityId, "svip_" .. self.activityId) ~= nil)

	local function var_12_4(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isVIPBtnLock(self.activityId) then
			return
		end

		if activity_manager:isBattlePassSVIP(self.activityId) then
			return
		end

		if activity_manager:isBattlePassVIP(self.activityId) then
			activity_manager:buyVipById(self.activityId, "svip_" .. self.activityId)
			AnalyticManager.touch_bianhua_vipbuy({
				id = "svip_" .. self.activityId
			})
		else
			activity_manager:buyVipById(self.activityId, "allvip_" .. self.activityId)
			AnalyticManager.touch_bianhua_vipbuy({
				id = "allvip_" .. self.activityId
			})
		end
	end

	self.btnGetSVIP:addTouchEventListener(var_12_4)
	self.btnSVipNeed:addTouchEventListener(var_12_4)

	local var_12_5 = "x%s"

	if activity_manager:isRechargeBP(self.activityId, "allvip_" .. self.activityId) then
		self.btnSVipNeed:getChildByName("money"):setVisible(false)

		var_12_5 = L_MANKEY
	end

	local var_12_6 = self.btnSVipNeed:getChildByName("lbl_vip_need")

	if activity_manager:isBattlePassVIP(self.activityId) then
		var_12_6:setString(string.format(var_12_5, activity_manager:getVipPriceById(self.activityId, "svip_" .. self.activityId)))
	else
		var_12_6:setString(string.format(var_12_5, activity_manager:getVipPriceById(self.activityId, "allvip_" .. self.activityId)))
	end

	var_12_6:setColor(cc.c3b(71, 31, 129))
	var_12_6:setPosition(var_12_0)
	var_12_6:setScale(1.1)
	var_12_3:setAnchorPoint(cc.p(0, 0.5))
	self.btnSVipNeed:getChildByName("money"):setPosition(var_12_1)
	self.btnVipNeed:getChildByName("money"):setPosition(var_12_1)
	self.btnSVipNeed:getChildByName("money"):setScale(0.6)
	self.btnSVipNeed:setLocalZOrder(1000)

	local l2utils = require("controller.l2utils")
end

function PopGetBianhuaBpVIPLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		arg_16_0:setBright(false)
		self:exit()
	end)
end

function PopGetBianhuaBpVIPLayer:initDorps()
	local var_17_0 = activity_manager:getBuySVIPDrop(self.activityId)
	local var_17_1 = ccui.ScrollView:create()

	var_17_1:setContentSize(cc.size(210, 200))
	var_17_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_17_1:setAnchorPoint(cc.p(0, 0))
	var_17_1:setPosition(330, 20)
	var_17_1:setInnerContainerSize(cc.size(95 * #var_17_0, 200))
	self.btnGetSVIP:addChild(var_17_1)

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_2 = ItemPurchaseSprite:createPurchaseItem(iter_17_1.dropid, iter_17_1.dropNum)

		var_17_2:addTouchEventListener(function()
			return
		end)
		var_17_2:setScale(0.55)
		var_17_2:setPosition(cc.p(45 + (iter_17_0 - 1) * 95, 100))
		var_17_1:addChild(var_17_2)

		local var_17_3 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

		var_17_3:setContentSize(cc.size(var_17_2:getContentSize().width, var_17_2:getContentSize().height))
		var_17_3:setPosition(cc.p(var_17_2:getContentSize().width / 2, var_17_2:getContentSize().height / 2))
		var_17_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_17_3:setName("layout")
		var_17_3:setSwallowTouches(false)
		var_17_2:addChild(var_17_3)
		var_17_2:setTouchEnabled(true)
		var_17_3:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_17_1.dropid)
		end)
	end
end

function PopGetBianhuaBpVIPLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopGetBianhuaBpVIPLayer:initDropView()
	self.dataList = activity_manager:getSpGiftPreviewList(self.activityId)
	self.tableView = cc.TableView:create(cc.size(530, 250))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(20, 2)
	self.tableView:setDelegate()
	self.panelBg:getChildByName("drop_panel"):setTouchEnabled(true)
	self.panelBg:getChildByName("drop_panel"):addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_24_0, arg_24_1)
		return 640, var_0_0
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:dequeueCell()

		if not var_23_0 then
			var_23_0 = cc.TableViewCell:create()

			for iter_23_0 = 1, var_0_1 do
				if self.dataList[arg_23_1 * var_0_1 + iter_23_0] then
					local var_23_2 = self:createSprite(self.dataList[arg_23_1 * var_0_1 + iter_23_0])

					var_23_2:setName("sprite" .. iter_23_0)
					var_23_2:setAnchorPoint(cc.p(0.5, 0.5))
					var_23_2:setPosition(cc.p(55 + 132 * (iter_23_0 - 1), var_0_0 / 2))
					var_23_0:addChild(var_23_2)
				end
			end
		else
			for iter_23_1 = 1, var_0_1 do
				local var_23_3 = var_23_0:getChildByName("sprite" .. iter_23_1)

				if var_23_3 then
					var_23_3:removeFromParent()

					var_23_3 = nil
				end

				if self.dataList[arg_23_1 * var_0_1 + iter_23_1] then
					if not var_23_3 then
						var_23_3 = self:createSprite(self.dataList[arg_23_1 * var_0_1 + iter_23_1])

						var_23_3:setName("sprite" .. iter_23_1)
						var_23_3:setAnchorPoint(cc.p(0.5, 0.5))
						var_23_3:setPosition(cc.p(55 + 132 * (iter_23_1 - 1), var_0_0 / 2))
						var_23_0:addChild(var_23_3)
					else
						var_23_3:setVisible(true)
						var_23_3:setPosition(cc.p(55 + 132 * (iter_23_1 - 1), var_0_0 / 2))
						self:updateSprite(var_23_3, self.dataList[arg_23_1 * var_0_1 + iter_23_1])
					end
				elseif var_23_3 then
					var_23_3:setVisible(false)
				end
			end
		end

		return var_23_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_25_0, arg_25_1)
		return math.floor(#self.dataList / 4) + 1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function PopGetBianhuaBpVIPLayer.createSprite(arg_26_0, arg_26_1)
	local var_26_0 = ItemPurchaseSprite:createPurchaseItem(arg_26_1.dropid, arg_26_1.dropNum)

	var_26_0:setScale(0.7)

	local var_26_1 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

	var_26_1:setContentSize(cc.size(var_26_0:getContentSize().width, var_26_0:getContentSize().height))
	var_26_1:setPosition(cc.p(var_26_0:getContentSize().width / 2, var_26_0:getContentSize().height / 2))
	var_26_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_26_1:setName("layout")
	var_26_1:setSwallowTouches(false)
	var_26_0:addChild(var_26_1)
	var_26_1:addTouchEventListener(function(arg_27_0, arg_27_1)
		if math.abs(arg_27_0:getTouchBeganPosition().y - arg_27_0:getTouchEndPosition().y) > 25 then
			return
		end

		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_26_1.dropid)
	end)

	return var_26_0
end

function PopGetBianhuaBpVIPLayer.updateSprite(arg_28_0, arg_28_1, arg_28_2)
	arg_28_1:updatePurchaseItemByItemid(arg_28_2.dropid, arg_28_2.dropNum)
	arg_28_1:setSwallowTouches(false)
	arg_28_1:getChildByName("layout"):addTouchEventListener(function(arg_29_0, arg_29_1)
		if math.abs(arg_29_0:getTouchBeganPosition().y - arg_29_0:getTouchEndPosition().y) > 25 then
			return
		end

		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_28_2.dropid)
	end)
end

function PopGetBianhuaBpVIPLayer:initBg(arg_30_1)
	local var_30_0 = ccui.Layout:create()

	var_30_0:setTouchEnabled(true)
	var_30_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_30_0:setAnchorPoint(cc.p(0, 0))
	var_30_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_30_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_30_0:setOpacity(0)
	self:addChild(var_30_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_31_0)
		self:addChild(arg_31_0, -2)
		arg_31_0:setPositionY(arg_31_0:getPositionY() - GameDisplay.fix_y)

		local var_31_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_31_0:setAnchorPoint(cc.p(0, 0))
		var_31_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_31_0, -1)
		self:init(arg_30_1)
		var_30_0:setOpacity(102)
		var_30_0:setTouchEnabled(false)
	end)
end

function PopGetBianhuaBpVIPLayer:initImageInJson()
	self.btnGetVIP:loadTextures(self.imagePath .. "/btn_get_vip.png", nil, self.imagePath .. "/btn_get_vip.png", var_0_2)
	self.btnGetSVIP:loadTextures(self.imagePath .. "/btn_get_svip.png", nil, self.imagePath .. "/btn_get_svip.png", var_0_2)
	self.btnSVipNeed:loadTextures(self.imagePath .. "/btn_svip_need.png", nil, self.imagePath .. "/btn_svip_need.png", var_0_2)
	self.btnSVipNeed:loadTextures(self.imagePath .. "/btn_svip_need.png", nil, self.imagePath .. "/btn_svip_need.png", var_0_2)
	self.btnVipNeed:getChildByName("money"):loadTexture("public/currency/6800601.png", var_0_2)
	self.btnSVipNeed:getChildByName("money"):loadTexture("public/currency/6800601.png", var_0_2)

	local var_32_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "right ")

	var_32_0:setPositionY(var_32_0:getPositionY() + 275)

	local var_32_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "left")

	var_32_1:setPositionY(var_32_1:getPositionY() + 275)
	ccui.Helper:seekWidgetByName(self.rootLayer, "tltle_gift"):loadTexture(self.imagePath .. "/title_gift.png", var_0_2)
	self.btnVipNeed:loadTextures(self.imagePath .. "/btn_vip_need.png", nil, self.imagePath .. "/btn_vip_need.png", var_0_2)
end
