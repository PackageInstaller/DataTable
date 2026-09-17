PopQuickEntranceLayer = class("PopQuickEntranceLayer", function()
	return PopBaseLayer:create()
end)

local patrol_manager = require("controller.patrol_manager")
local lab_manager = require("controller.lab_manager")
local order_manager = require("controller.order_manager")
local activity_manager = require("controller.activity_manager")
local alert_manager = require("controller.alert_manager")
local var_0_5 = config._DEBUG and 0 or 1

local function var_0_6(arg_3_0)
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_0) do
		if iter_3_1.id > 0 then
			var_3_0 = var_3_0 + 1
		end
	end

	return var_3_0
end

local var_0_8 = {
	{
		switchtype = "pop",
		LayerName = "PatrolFightLayer",
		order = 1,
		updateFunc = function(self)
			local var_2_0, var_2_1 = patrol_manager:get_can_get_reward_num()
			local var_2_2 = cc.Label:createWithTTF(L_BUTTON_TEXT.CanGet .. ":" .. var_2_1, FONT_DES, 20)

			var_2_2:setAnchorPoint(cc.p(0, 0.5))
			var_2_2:setPosition(cc.p(12, 25))
			self:addChild(var_2_2)

			local var_2_3 = cc.Label:createWithTTF(L_PATROLING .. var_2_0, FONT_DES, 20)

			var_2_3:setAnchorPoint(cc.p(0, 0.5))
			var_2_3:setPosition(cc.p(12, 50))
			self:addChild(var_2_3)

			if var_2_1 > 0 and self.isUnlock > 0 then
				global_add_alert_tag(self, {
					x = self:getContentSize().width,
					y = self:getContentSize().height + 6
				}, nil, 4)

				local var_2_4 = self:getChildByName("reddot")

				var_2_4:setScale(0.7)
				var_2_4:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, 16)), cc.MoveBy:create(0.15, cc.p(0, -24)), cc.MoveBy:create(0.05, cc.p(0, 8)), cc.DelayTime:create(0.8)))))
			else
				global_remove_alert_tag(self)
			end
		end
	},
	{
		switchtype = "layer",
		LayerName = "SchoolOrderLayer",
		order = 2,
		updateFunc = function(self)
			local var_4_0 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_4_0:setAnchorPoint(cc.p(0, 0.5))
			var_4_0:setPosition(cc.p(12, 25))
			var_4_0:setVisible(self.isUnlock > 0)
			self:addChild(var_4_0)

			local var_4_1 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_4_1:setAnchorPoint(cc.p(0, 0.5))
			var_4_1:setPosition(cc.p(12, 50))
			var_4_1:setVisible(self.isUnlock > 0)
			self:addChild(var_4_1)

			if alert_manager.alertsys[ALERT_ORDER_NEW] and self.isUnlock > 0 then
				global_add_alert_tag(self, {
					x = self:getContentSize().width,
					y = self:getContentSize().height
				}, nil, 2)
			elseif alert_manager.alertsys[ALERT_ORDER] and self.isUnlock > 0 then
				global_add_alert_tag(self, {
					x = self:getContentSize().width,
					y = self:getContentSize().height
				})
			else
				global_remove_alert_tag(self)
			end

			activity_manager:registerEventListener("PopQuickEntranceLayer", activity_manager.activityEventId.SCHOOL_ORDER_INFO_UPDATE, function(arg_5_0)
				local var_5_0 = math.min(#arg_5_0.orderlist, 10)

				if #arg_5_0.orderlist <= 10 then
					var_5_0 = var_0_6(arg_5_0.orderlist)
				end

				var_4_0:setString(L_ORDER_REFSH_COUNT .. math.max(#arg_5_0.orderlist - 10, 0))
				var_4_1:setString(L_ORDER_COUNT .. var_5_0)
			end)
			order_manager:get_order_info()
		end
	},
	{
		switchtype = "layer",
		LayerName = "ExploreOfferLayer",
		order = 3,
		updateFunc = function(arg_6_0)
			return
		end
	},
	{
		switchtype = "layer",
		LayerName = "LabMenuLayer",
		order = 4,
		updateFunc = function(self)
			local var_7_0 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_7_0:setAnchorPoint(cc.p(0, 0.5))
			var_7_0:setPosition(cc.p(12, 25))
			self:addChild(var_7_0)
			var_7_0:setVisible(self.isUnlock > 0)
			lab_manager:get_lab_production_list(function(arg_8_0)
				local var_8_0 = 0

				for iter_8_0 = 1, #arg_8_0 do
					if arg_8_0[iter_8_0].status == 2 then
						var_8_0 = var_8_0 + 1
					end
				end

				var_7_0:setString(L_BUTTON_TEXT.CanGet .. ":" .. var_8_0)

				if var_8_0 > 0 and self.isUnlock > 0 then
					global_add_alert_tag(self, {
						x = self:getContentSize().width,
						y = self:getContentSize().height
					})
				else
					global_remove_alert_tag(self)
				end
			end)
		end
	}
}

function PopQuickEntranceLayer.create(arg_10_0, arg_10_1)
	local var_10_0 = PopQuickEntranceLayer.new()

	var_10_0:initBg(arg_10_1)

	return var_10_0
end

function PopQuickEntranceLayer:init(arg_11_1)
	print("open poplayer : PopQuickEntranceLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0.5))
	self.rootLayer:setPositionY(GameDisplay:getScreenSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.rootLayer)
	self:initUI(arg_11_1)
	self:registerScriptHandler(function(arg_12_0)
		if arg_12_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopQuickEntranceLayer")
		end
	end)
end

function PopQuickEntranceLayer:initUI(arg_13_1)
	self:initPanel()
	self:initExitTouchEvent()
	self:initBtns()
	self:playJoinEffect()
end

function PopQuickEntranceLayer:initPanel()
	self.bg = ccui.ImageView:create("PopQuickEntranceLayer/bg.png", var_0_5)

	self.bg:setAnchorPoint(cc.p(1, 0.5))
	self.bg:setPosition(cc.p(0, self.rootLayer:getContentSize().height / 2))
	self.bg:setTouchEnabled(true)
	self.bg:setName("bg")
	self.rootLayer:addChild(self.bg)

	local var_14_0 = ccui.ImageView:create("PopQuickEntranceLayer/title.png", var_0_5)

	var_14_0:setPosition(cc.p(190, 800))
	self.bg:addChild(var_14_0)
end

function PopQuickEntranceLayer:playJoinEffect()
	self.bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(self.bg:getContentSize().width, self.bg:getPositionY()))))
end

function PopQuickEntranceLayer:initExitTouchEvent()
	local var_16_0 = ccui.Layout:create()

	var_16_0:setContentSize(cc.size(34, 120))
	var_16_0:setPosition(cc.p(550, 730))
	var_16_0:setBackGroundColorOpacity(255)
	var_16_0:setTouchEnabled(true)
	self.bg:addChild(var_16_0)
	var_16_0:setTouchEnabled(true)
	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_17_0:isBright() then
			return
		end

		arg_17_0:setBright(false)
		self:exit()
	end)
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_18_0:isBright() then
			return
		end

		arg_18_0:setBright(false)
		self:exit()
	end)
end

function PopQuickEntranceLayer:initBtns()
	self.btnList = ccui.ListView:create()

	self.btnList:setDirection(ccui.ListViewDirection.vertical)
	self.btnList:setItemsMargin(12)
	self.btnList:setAnchorPoint(cc.p(0, 0))
	self.btnList:setPosition(20, 15)
	self.btnList:setName("btnList")
	self.btnList:setContentSize(cc.size(520, 750))
	self.bg:addChild(self.btnList)

	local var_19_0 = self:sortBtnList()

	for iter_19_0 = 1, #var_19_0 do
		local var_19_1 = ccui.Button:create("PopQuickEntranceLayer/" .. var_19_0[iter_19_0].LayerName .. ".png", "PopQuickEntranceLayer/" .. var_19_0[iter_19_0].LayerName .. ".png", "PopQuickEntranceLayer/" .. var_19_0[iter_19_0].LayerName .. ".png", var_0_5)

		var_19_1:setName(var_19_0[iter_19_0].LayerName)
		self.btnList:addChild(var_19_1)

		var_19_1.isUnlock = var_19_0[iter_19_0].isUnlock

		local var_19_3 = ""

		if var_19_0[iter_19_0].switchtype == "pop" then
			local var_19_4

			var_19_4, var_19_3 = LayerManager:layerUnlocked(var_19_0[iter_19_0].LayerName, "pushInLayer", false)
		else
			local var_19_5

			var_19_5, var_19_3 = LayerManager:layerUnlocked(var_19_0[iter_19_0].LayerName, "switchShowLayer", false)
		end

		local var_19_6 = ccui.ImageView:create("PopQuickEntranceLayer/img_mask.png", var_0_5)
		local var_19_7 = ccui.Text:create(var_19_3 or "", "fonts/name.ttf", 20)

		var_19_6:addChild(var_19_7)
		var_19_7:setAnchorPoint(0, 0.5)
		var_19_7:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
		var_19_7:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_19_7:setPosition(60, 30)
		var_19_6:setPosition(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2)
		var_19_1:addChild(var_19_6)
		var_19_6:setVisible(var_19_1.isUnlock == 0)

		if var_19_0[iter_19_0].updateFunc then
			var_19_0[iter_19_0].updateFunc(var_19_1)
		end

		var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_19_0[iter_19_0].switchtype == "pop" then
				LayerManager:pushInLayer(var_19_0[iter_19_0].LayerName, {
					exitCallback = function()
						if var_19_0[iter_19_0].updateFunc then
							var_19_0[iter_19_0].updateFunc(var_19_1)
						end
					end
				})
			else
				LayerManager:switchShowLayer(var_19_0[iter_19_0].LayerName)
			end

			AnalyticManager.quick_entrance_btn({
				index = iter_19_0,
				layer = var_19_0[iter_19_0]
			})
		end)
	end
end

function PopQuickEntranceLayer.sortBtnList(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(var_0_8) do
		local var_22_1 = false

		var_22_1 = var_0_8[iter_22_0].switchtype == "pop" and LayerManager:layerUnlocked(var_0_8[iter_22_0].LayerName, "pushInLayer", false) or LayerManager:layerUnlocked(var_0_8[iter_22_0].LayerName, "switchShowLayer", false)
		var_22_0[iter_22_0] = {
			switchtype = iter_22_1.switchtype,
			LayerName = iter_22_1.LayerName,
			updateFunc = iter_22_1.updateFunc,
			isUnlock = var_22_1 and 1 or 0,
			order = iter_22_1.order
		}
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		if arg_23_0.isUnlock == arg_23_1.isUnlock then
			return arg_23_0.order < arg_23_1.order
		else
			return arg_23_0.isUnlock > arg_23_1.isUnlock
		end
	end)

	return var_22_0
end

function PopQuickEntranceLayer:exit()
	self.bg:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, self.bg:getPositionY())), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopQuickEntranceLayer:initBg(arg_26_1)
	local var_26_0 = ccui.Layout:create()

	var_26_0:setTouchEnabled(true)
	var_26_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_26_0:setAnchorPoint(cc.p(0, 0))
	var_26_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_26_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_26_0:setOpacity(0)
	self:addChild(var_26_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_27_0)
		self:addChild(arg_27_0, -2)
		arg_27_0:setPositionY(arg_27_0:getPositionY() - GameDisplay.fix_y)

		local var_27_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_27_0:setAnchorPoint(cc.p(0, 0))
		var_27_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_27_0, -1)
		self:init(arg_26_1)
		var_26_0:setOpacity(102)
		var_26_0:setTouchEnabled(false)
	end)
end
