PopRechargePreviewLayer = class("PopRechargePreviewLayer", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local recharge_data = require("data.recharge_data")
local recharge_manager = require("controller.recharge_manager")
local supermarket_manager = require("controller.supermarket_manager")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = 134
local var_0_7 = 100

function PopRechargePreviewLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopRechargePreviewLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopRechargePreviewLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopRechargePreviewLayer.json" or "PopRechargePreviewLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.initParam = arg_3_1
	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.moveFadeOut(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.moveFadeIn(self)
	self.rootpanel:setTouchEnabled(false)
	self.rootpanel:setPositionY(self.rootpanel:getPositionY() + GameDisplay.fix_y)
	self:getRechargeData(arg_3_1)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.initParam and self.initParam.callback then
				self.initParam.callback()
			end

			recharge_manager:updateRechargeCacheData(self.updateProducts)
			activity_manager:fireEvent(activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT)
		end
	end)
end

function PopRechargePreviewLayer:initData(arg_7_1)
	local var_7_0 = self.initParam and self.initParam.group
	local var_7_1 = time_check_manager:getCurTime()
	local var_7_2, var_7_3 = recharge_manager:intersectRecharge(self.products)

	self.updateProducts = var_7_2

	local var_7_4 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		var_7_4[iter_7_1.group] = {
			order = iter_7_1.order,
			weight = iter_7_1.weight
		}
	end

	local var_7_5 = {}

	for iter_7_2, iter_7_3 in pairs(var_7_3) do
		table.insert(var_7_5, {
			group = iter_7_2,
			order = var_7_4[iter_7_2].order,
			weight = var_7_4[iter_7_2].weight,
			isCanBuy = self:checkBuyOut(iter_7_3)
		})
	end

	funcList = {
		{
			weight = 2,
			func = function(self)
				return self.order
			end
		},
		{
			weight = 4,
			func = function(self)
				return self.isCanBuy
			end
		}
	}

	global_sort_by_weight(var_7_5, funcList)

	self.group = var_7_3
	self.groupOrderList = var_7_5
	self.listOrder = self:getGroupOrder(var_7_0) or 1

	print("######", dump(var_7_3), dump(self.groupOrderList), self.listOrder)
	self:initAlert()
	AnalyticManager.click_recharge_shop_limit({
		group = self.groupOrderList[self.listOrder].group
	})
end

function PopRechargePreviewLayer:initAlert(arg_10_1)
	self.alertList = {}

	for iter_10_0, iter_10_1 in pairs(recharge_manager:getShopLimitAlertData() or {}) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			self.alertList[iter_10_3] = iter_10_0
		end
	end
end

function PopRechargePreviewLayer.getRechargeData(arg_11_0, arg_11_1)
	recharge_manager:getRechargeInfo(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == 1 then
			local var_12_0 = {}

			for iter_12_0, iter_12_1 in pairs(arg_12_1) do
				var_12_0[iter_12_1.id] = iter_12_1
			end

			arg_11_0.products = var_12_0

			arg_11_0:initData(arg_12_2)
			arg_11_0:initUI()
			arg_11_0:getNeedJumpToIndex()
			arg_11_0:updateUI()
		end
	end)
end

function PopRechargePreviewLayer:initUI()
	self.listBg = ccui.Helper:seekWidgetByName(self.rootLayer, "list_bg")
	self.tabBg = ccui.Helper:seekWidgetByName(self.rootLayer, "choose_bg")
	self.tabPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_tab")
	self.btnClose = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_close")
	self.btnRecharge = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_recharge")

	self.tabBg:setTouchEnabled(true)
	self.listBg:setTouchEnabled(true)
	self.tabPanel:setVisible(false)
	self.btnClose:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)
		self.hideActions.moveFadeOut(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.btnRecharge:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		arg_16_0:setBright(false)
		LayerManager:pushInLayer("PopSupermarketLayer", {
			callback = function()
				arg_16_0:setBright(true)
			end
		})
	end)
	self:initRechargeTabList()
end

function PopRechargePreviewLayer:updateUI()
	self:updateShowPanel()
end

function PopRechargePreviewLayer:updateShowPanel()
	if self.shoptimelimitLayer then
		self.shoptimelimitLayer:runAction(cc.RemoveSelf:create())

		self.shoptimelimitLayer = nil
	end

	local var_19_0, var_19_1 = self:getParam()

	require("view.Layer.Pops.PopBaseLayer")

	var_19_0.disabledEnterAni = true
	self.shoptimelimitLayer = PopShopTimeLimitRechargeIconLayer:create(var_19_0)

	self.shoptimelimitLayer:setPositionY(-40)
	self.shoptimelimitLayer:setPositionX(-70)
	self.rootpanel:addChild(self.shoptimelimitLayer, 5)

	if cc.FileUtils:getInstance():isFileExist("mainScenebg/activity/shoptimelimit/" .. var_19_1 .. "/list_bg.png") then
		self.listBg:loadTexture("mainScenebg/activity/shoptimelimit/" .. var_19_1 .. "/list_bg.png")
	else
		self.listBg:loadTexture("PopRechargePreviewLayer/list_bg.png", var_0_5)
	end
end

function PopRechargePreviewLayer:getParam(...)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(self.group) do
		var_20_0[iter_20_1[1].group] = iter_20_1
	end

	return {
		list = var_20_0[self.groupOrderList[self.listOrder].group]
	}, self.groupOrderList[self.listOrder].group
end

function PopRechargePreviewLayer:initRechargeTabList()
	local var_21_0 = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 70, TRANSFORM_UNIT.PX)

	self.tabList = cc.TableView:create(cc.size(140, 925))

	self.tabList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tabList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tabList:setAnchorPoint(cc.p(0, 0))
	self.tabList:setPosition(8, 10)
	self.tabList:setDelegate()
	self.tabBg:addChild(self.tabList)
	self.tabList:registerScriptHandler(function(arg_22_0, arg_22_1)
		return var_0_6, var_0_7
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tabList:registerScriptHandler(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:dequeueCell()

		if not var_23_0 then
			var_23_0 = cc.TableViewCell:create()

			local var_23_1 = self:createTabObj(arg_23_1 + 1)

			var_23_1:setName("tabObj")
			var_23_1:setPosition(cc.p(var_23_1:getContentSize().width, 0))

			if arg_23_0.withaction and arg_23_1 < 8 then
				var_23_1:setOpacity(0)
				var_23_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_23_1), cc.FadeIn:create(0.1)))
			end

			var_23_0:addChild(var_23_1)
		else
			var_23_0:getChildByName("tabObj"):update(arg_23_1 + 1)

			if arg_23_0.withaction and arg_23_1 < 8 then
				var_23_0:getChildByName("tabObj"):setOpacity(0)
				var_23_0:getChildByName("tabObj"):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_23_1), cc.FadeIn:create(0.1)))
			elseif var_23_0:getChildByName("tabObj"):getOpacity() < 255 then
				var_23_0:getChildByName("tabObj"):setOpacity(255)
			end
		end

		return var_23_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tabList:registerScriptHandler(function(arg_24_0, arg_24_1)
		return #self.groupOrderList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tabList:reloadData()
end

function PopRechargePreviewLayer:createTabObj(arg_25_1)
	local var_25_0 = self:getGroupByIndex(arg_25_1)
	local var_25_1 = self.tabPanel:clone()
	local var_25_2 = var_25_1:getChildByName("img_tab")

	var_25_1:setVisible(true)
	var_25_1:setTouchEnabled(false)
	var_25_2:setSwallowTouches(false)
	var_25_2:loadTextures("mainScenebg/activity/shoptimelimit/" .. var_25_0 .. "/tab_off.png", "mainScenebg/activity/shoptimelimit/" .. var_25_0 .. "/tab_off.png", "mainScenebg/activity/shoptimelimit/" .. var_25_0 .. "/tab_off.png")
	var_25_2:setPosition(cc.p(var_25_1:getContentSize().width / 2, var_25_1:getContentSize().height / 2))
	var_25_2:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_26_0:getTouchBeganPosition().y - arg_26_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self.listOrder == arg_26_0.index then
			return
		end

		self.listOrder = arg_26_0.index

		self:updateShowPanel()
		self:updateShowingCells()
		AnalyticManager.click_recharge_shop_limit({
			group = arg_26_0.group
		})
	end)

	var_25_2.index = arg_25_1
	var_25_2.group = var_25_0

	if self.group[var_25_0][1].finish_time then
		local var_25_3 = cc.Label:createWithTTF("·" .. global_get_finishtime_str(self.group[var_25_0][1].finish_time, time_check_manager:getCurTime(), L_TIME_REST2, 1), FONT_DES, 18)

		var_25_3:setAnchorPoint(cc.p(0, 1))
		var_25_3:setPositionX(0)
		var_25_3:setPositionY(var_25_2:getPositionY() - var_25_2:getContentSize().height / 2 - 5)
		var_25_3:setColor(cc.c3b(155, 152, 218))
		var_25_3:setName("time")
		var_25_1:addChild(var_25_3, 2)
	end

	local var_25_4 = {
		cc.p(var_25_2:getContentSize().width + 10, var_25_2:getContentSize().height + 10),
		(cc.p(var_25_2:getContentSize().width, var_25_2:getContentSize().height))
	}

	function var_25_1:update(arg_27_1)
		local var_27_0 = self:getChildByName("img_tab")
		local var_27_1 = self:getChildByName("time")

		var_27_0.index = arg_27_1
		var_27_0.group = self:getGroupByIndex(arg_27_1)

		if self.listOrder == var_27_0.index then
			var_27_0:loadTextures("mainScenebg/activity/shoptimelimit/" .. var_27_0.group .. "/tab_on.png", "mainScenebg/activity/shoptimelimit/" .. var_27_0.group .. "/tab_on.png", "mainScenebg/activity/shoptimelimit/" .. var_27_0.group .. "/tab_on.png")

			if self.alertList[var_27_0.group] then
				self.alertList[var_27_0.group] = nil

				self:deleteAlertInServe(var_27_0.group)
			end

			if var_27_0:getChildByName("reddot") then
				var_27_0:getChildByName("reddot"):removeFromParent()
			end

			if var_27_1 then
				var_27_1:setColor(cc.c3b(223, 186, 122))
			end
		else
			var_27_0:loadTextures("mainScenebg/activity/shoptimelimit/" .. var_27_0.group .. "/tab_off.png", "mainScenebg/activity/shoptimelimit/" .. var_27_0.group .. "/tab_off.png", "mainScenebg/activity/shoptimelimit/" .. var_27_0.group .. "/tab_off.png")

			if self.alertList[var_27_0.group] then
				global_add_alert_tag(var_27_0, var_25_4[self.alertList[var_27_0.group]], 5, self.alertList[var_27_0.group])
			end

			if var_27_1 then
				var_27_1:setColor(cc.c3b(206, 204, 255))
			end
		end
	end

	var_25_1:update(arg_25_1)

	return var_25_1
end

function PopRechargePreviewLayer:updateShowingCells()
	local var_28_0, var_28_1 = GetTableViewShowCellIdx(self.tabList, {
		cellsize = cc.size(var_0_6, var_0_7),
		maxcount = #self.groupOrderList
	})

	for iter_28_0 = var_28_0, var_28_1 do
		self.tabList:updateCellAtIndex(iter_28_0)
	end
end

function PopRechargePreviewLayer:getNeedJumpToIndex()
	if #self.groupOrderList == 0 then
		return
	end

	local var_29_0, var_29_1 = GetTableViewShowCellIdx(self.tabList, {
		maxcount = #self.groupOrderList,
		cellsize = cc.size(var_0_6, var_0_7)
	})

	return (self.listOrder + (var_29_1 - var_29_0 - 2) > #self.groupOrderList or nil) and #self.groupOrderList
end

function PopRechargePreviewLayer:getGroupOrder(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self.groupOrderList) do
		if iter_30_1.group == arg_30_1 then
			return iter_30_0
		end
	end

	return nil
end

function PopRechargePreviewLayer:getGroupByIndex(arg_31_1)
	return self.groupOrderList[arg_31_1].group
end

function PopRechargePreviewLayer:getAlertData()
	local var_32_0 = {
		{},
		{}
	}
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in pairs(self.products) do
		if iter_32_1.new_tag then
			local var_32_2 = supermarket_manager:getShopTimeLimitGroupByID(iter_32_1.id)

			if var_32_2 and not var_32_1[var_32_2] then
				table.insert(var_32_0[iter_32_1.new_tag], var_32_2)

				var_32_1[var_32_2] = true
			end
		end
	end

	print("alert =========", dump(var_32_0))

	return var_32_0
end

function PopRechargePreviewLayer.deleteAlertInServe(arg_33_0, arg_33_1)
	recharge_manager:deletAlertInCache(arg_33_1, time_check_manager:getCurTime())
end

function PopRechargePreviewLayer.checkBuyOut(arg_34_0, arg_34_1)
	local var_34_0 = 1

	for iter_34_0, iter_34_1 in pairs(arg_34_1) do
		if not iter_34_1.buy_limit then
			return 2
		end

		if iter_34_1.have_bought < iter_34_1.buy_limit then
			var_34_0 = 2
		end
	end

	return var_34_0
end

function PopRechargePreviewLayer:initBg(arg_35_1)
	local var_35_0 = ccui.Layout:create()

	var_35_0:setTouchEnabled(true)
	var_35_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_35_0:setAnchorPoint(cc.p(0, 0))
	var_35_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_35_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_35_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_35_0:setOpacity(0)
	self:addChild(var_35_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_36_0)
		self:addChild(arg_36_0, -2)
		arg_36_0:setPositionY(arg_36_0:getPositionY() - GameDisplay.fix_y)

		local var_36_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_36_0:setAnchorPoint(cc.p(0, 0))
		var_36_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_36_0, -1)
		self:init(arg_35_1)
		var_35_0:setOpacity(102)
		var_35_0:setTouchEnabled(false)
	end)
end

function PopRechargePreviewLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
