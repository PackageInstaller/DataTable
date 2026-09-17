local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local bakery_gamelogic_manager = require("controller.bakery_gamelogic_manager")
local item_manager = require("controller.item_manager")
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3

ActivityBakeryLayer = class("ActivityBakeryLayer", function()
	return ccui.Layout:create()
end)

function ActivityBakeryLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityBakeryLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityBakeryLayer:init(arg_4_1)
	self.resPath = "ActivityBakeryLayer/"
	self.activityId = arg_4_1.activityId

	bakery_gamelogic_manager:initData()
	bakery_gamelogic_manager:registerUIRef(self)
	self:initUI()

	self.layerName = "ActivityBakeryLayer" .. self.activityId

	self:registerEventListener()

	self.confdata = activity_manager:activity_get_bakery_conf(self.activityId), self.level_bg:setVisible(false)

	self:updateItemNum()
	activity_manager:get_activity_bakery_data(self.activityId, function(arg_5_0)
		self.gold_label:setString(arg_5_0.gold)
		self:initLevelInfoUI(arg_5_0, activity_manager:activity_get_bakery_level_conf(self.activityId).dropid)
		self:registerGameUIEvent()
		self:updateLevelInitGameUI()
		self:updateItemNum()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			bakery_gamelogic_manager:exitGame()
		end
	end)
	self.btn_start:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		LayerManager:pushInLayer("ActivityBakeryHelpLayer", {
			activityId = self.activityId,
			callback = function(arg_8_0)
				self.levelinfo_bg:setVisible(false)
				self.level_bg:setVisible(true)
				self.level_label_1:setString(string.format("第%d关", activity_manager:activity_get_bakery_cur_data(self.activityId).level))
				bakery_gamelogic_manager:initData()
				bakery_gamelogic_manager:registerUIRef(self)
				self:registerGameUIEvent()
				self:addGameTouchListener()
				bakery_gamelogic_manager:loadGameData(arg_8_0)
				bakery_gamelogic_manager:createMainLoop()
				self:updateBottomUI(false)
				self:updateItemNum()
			end,
			cancelCallBack = function()
				arg_7_0:setBright(true)
			end
		})
	end)

	if not RoleDefault:getInstance():getBoolForKey("ActivityBakeryGuide_" .. self.activityId, false) then
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityBakery_" .. self.activityId
		})
	end

	RoleDefault:getInstance():setBoolForKey("ActivityBakeryGuide_" .. self.activityId, true)

	if config._DEBUG then
		self:initDeBugBtn()
	end
end

function ActivityBakeryLayer:registerEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_11_0)
		self:updateItemNum()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_BAKERY_UPDATE_GOLD, function(arg_12_0)
		if arg_12_0.gold then
			self.gold_label:setString(arg_12_0.gold)
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_13_0)
		self:updateItemNum()
	end), self)
end

function ActivityBakeryLayer:initUI()
	self.bg = ccui.ImageView:create("mainScenebg/ActivityBakeryLayerBG.png")

	self.bg:setAnchorPoint(0, 0)
	self.bg:setPosition(0, -60 - GameDisplay.fix_y)
	self:addChild(self.bg)
	self:initLevelInfoUI()
	self:initOrderUI()
	self:initCakeUI()
	self:initMikeTeaUI()
	self:initTaroballsUI()
	self:initBottomUI()
end

function ActivityBakeryLayer:initLevelInfoUI(arg_15_1, arg_15_2)
	if not self.levelinfo_bg then
		local var_15_0 = ccui.ImageView:create(self.resPath .. "levelInfo_bg.png", var_0_0)

		self.bg:addChild(var_15_0, 3)
		var_15_0:setPosition(320, 1050 + GameDisplay.fix_y)

		self.levelinfo_bg = var_15_0

		local var_15_1 = cc.Label:createWithTTF("第5关", FONT_TITLE, 44)

		var_15_0:addChild(var_15_1)
		var_15_1:setPosition(255, 260)
		var_15_1:setColor(cc.c3b(250, 216, 141))

		self.level_label = var_15_1

		local var_15_2 = cc.Label:createWithTTF("目标: 获得金币10000", FONT_TITLE, 27)

		var_15_0:addChild(var_15_2)
		var_15_2:setPosition(255, 210)
		var_15_2:setColor(cc.c3b(250, 216, 141))

		self.target_label = var_15_2

		local var_15_3 = ccui.Button:create(self.resPath .. "btn_start.png", nil, self.resPath .. "btn_start.png", var_0_0)

		var_15_0:addChild(var_15_3)
		var_15_3:setPosition(255, 140)

		self.btn_start = var_15_3

		local var_15_4 = cc.Label:createWithTTF("完成奖励", FONT_NAME, 22)

		var_15_0:addChild(var_15_4)
		var_15_4:setPosition(110, 60)
		var_15_4:setColor(cc.c3b(250, 216, 141))

		self.dropListView = ccui.ListView:create()

		self.dropListView:setDirection(ccui.ListViewDirection.horizontal)
		self.dropListView:setItemsMargin(20)
		self.dropListView:setAnchorPoint(cc.p(0, 0))
		self.dropListView:setPosition(155, 10)
		self.dropListView:setContentSize(cc.size(320, 100))
		var_15_0:addChild(self.dropListView)

		local var_15_5 = ccui.Button:create(self.resPath .. "detail_btn.png", nil, self.resPath .. "detail_btn.png", var_0_0)

		var_15_0:addChild(var_15_5)
		var_15_5:setPosition(500, 270)
		var_15_5:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityDetail", {
				key = "ActivityBakery_" .. self.activityId
			})
		end)
	end

	if arg_15_1 and arg_15_1.target_gold then
		self.target_label:setString("目标: 获得金币" .. arg_15_1.target_gold)
	end

	if arg_15_1 and arg_15_1.level then
		self.level_label:setString(string.format("第%d关", arg_15_1.level))
	end

	self.dropListView:removeAllChildren()

	if arg_15_2 then
		for iter_15_0, iter_15_1 in pairs(require("controller.drop_manager"):getDropMsg(arg_15_2).equips) do
			local var_15_6 = ccui.Layout:create()

			var_15_6:setContentSize(cc.size(60, 80))

			local var_15_7 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_0)

			var_15_7:setPosition(cc.p(50, 40))

			local var_15_8, var_15_9 = create_item_icon(nil, true, iter_15_1.dropid, iter_15_1.dropNum, iter_15_1.item_attr)

			var_15_8:setPosition(30, 40)
			var_15_8:setScale(var_15_8:getScale() * 0.4)
			var_15_7:addChild(var_15_8)
			var_15_6:addChild(var_15_7)

			local var_15_10 = ccui.ImageView:create(self.resPath .. "label_bg.png", var_0_0)

			var_15_10:setAnchorPoint(0, 0)
			var_15_7:addChild(var_15_10)

			local var_15_11 = cc.Label:createWithTTF("x" .. var_15_9, FONT_DES, 15)

			var_15_11:setPosition(34, 10)
			var_15_10:addChild(var_15_11)
			self.dropListView:pushBackCustomItem(var_15_6)
		end
	end
end

function ActivityBakeryLayer:initOrderUI()
	local var_17_0 = ccui.ImageView:create(self.resPath .. "gold_bg.png", var_0_0)

	self.bg:addChild(var_17_0, 5)
	var_17_0:setAnchorPoint(0, 0)
	var_17_0:setPosition(300, 1140 + GameDisplay.fix_y)

	local var_17_1 = ccui.ImageView:create(self.resPath .. "item_icon_bg.png", var_0_0)

	var_17_0:addChild(var_17_1)
	var_17_1:setAnchorPoint(0, 0)
	var_17_1:setPosition(15, 22)

	self.item_icon_bg = var_17_1
	self.keyitem_label = cc.Label:createWithTTF("10/10", FONT_NAME, 27)

	self.keyitem_label:setAnchorPoint(0, 0)
	self.keyitem_label:setPosition(65, 10)
	var_17_1:addChild(self.keyitem_label)
	var_17_1:setTouchEnabled(true)
	var_17_1:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = self.confdata.key_item
		})
	end)

	local var_17_2 = ccui.ImageView:create(self.resPath .. "gold_icon_bg.png", var_0_0)

	var_17_0:addChild(var_17_2)
	var_17_2:setAnchorPoint(0, 0)
	var_17_2:setPosition(170, 24)

	self.gold_icon_bg = var_17_2
	self.gold_label = cc.Label:createWithTTF("99999", FONT_NAME, 27)

	self.gold_label:setAnchorPoint(0, 0)
	self.gold_label:setPosition(70, 8)
	var_17_2:addChild(self.gold_label)

	local var_17_3 = ccui.ImageView:create(self.resPath .. "level_gold_bg.png", var_0_0)

	var_17_0:addChild(var_17_3)
	var_17_3:setAnchorPoint(0, 0)
	var_17_3:setPosition(10, 32)

	self.level_gold_bg = var_17_3
	self.level_gold_label = cc.Label:createWithTTF("999", FONT_NAME, 22)

	self.level_gold_label:setAnchorPoint(0, 0)
	self.level_gold_label:setPosition(95, 4)
	var_17_3:addChild(self.level_gold_label)
	var_17_3:setVisible(false)

	local var_17_4 = ccui.ImageView:create(self.resPath .. "target_gold_bg.png", var_0_0)

	var_17_0:addChild(var_17_4)
	var_17_4:setAnchorPoint(0, 0)
	var_17_4:setPosition(180, 32)

	self.target_gold_bg = var_17_4
	self.target_gold_label = cc.Label:createWithTTF("999", FONT_NAME, 22)

	self.target_gold_label:setAnchorPoint(0, 0)
	self.target_gold_label:setPosition(70, 4)
	var_17_4:addChild(self.target_gold_label)
	var_17_4:setVisible(false)

	self.orderLayout = ccui.Layout:create()

	self.bg:addChild(self.orderLayout)
	self.orderLayout:setPosition(0, 920 + GameDisplay.fix_y)

	local var_17_5 = ccui.ImageView:create(self.resPath .. "level_bg.png", var_0_0)

	self.bg:addChild(var_17_5, 5)
	var_17_5:setAnchorPoint(0, 0)
	var_17_5:setPosition(0, 1120 + GameDisplay.fix_y)

	self.level_bg = var_17_5
	self.level_label_1 = cc.Label:createWithTTF("第100关", FONT_TITLE, 30)

	self.level_label_1:setAnchorPoint(0, 0)
	self.level_label_1:setPosition(10, 60)
	var_17_5:addChild(self.level_label_1)

	local var_17_6 = cc.Label:createWithTTF("剩余时间", FONT_NAME, 22)

	var_17_6:setAnchorPoint(0, 0)
	var_17_6:setPosition(10, 30)
	var_17_5:addChild(var_17_6)

	self.time_label = cc.Label:createWithTTF("02:59", FONT_NAME, 22)

	self.time_label:setAnchorPoint(0, 0)
	self.time_label:setPosition(120, 30)
	var_17_5:addChild(self.time_label)

	self.orders = {}

	for iter_17_0, iter_17_1 in ipairs({
		cc.p(100, 30),
		cc.p(320, 30),
		cc.p(540, 30)
	}) do
		local var_17_7 = ccui.ImageView:create(self.resPath .. "order_bg.png", var_0_0)

		self.orderLayout:addChild(var_17_7)
		var_17_7:setPosition(iter_17_1)
		table.insert(self.orders, var_17_7)
		var_17_7:setVisible(false)

		local var_17_8 = ccui.ImageView:create(self.resPath .. "emoji_bg.png", var_0_0)

		var_17_7:addChild(var_17_8)
		var_17_8:setPosition(96, 245)

		local var_17_9 = ccui.ImageView:create(self.resPath .. "emoji_happy.png", var_0_0)

		var_17_8:addChild(var_17_9)
		var_17_9:setPosition(var_17_8:getContentSize().width / 2, var_17_8:getContentSize().height / 2)

		var_17_7.emoji = var_17_9

		local var_17_10 = ccui.Slider:create()

		var_17_10:loadBarTexture(self.resPath .. "progress_bg.png", var_0_0)
		var_17_10:loadProgressBarTexture(self.resPath .. "progress_on_1.png", var_0_0)
		var_17_10:setPosition(96, 200)
		var_17_10:setPercent(50)
		var_17_7:addChild(var_17_10)

		var_17_7.progressBar = var_17_10
		var_17_7.products = {}

		for iter_17_2, iter_17_3 in ipairs({
			cc.p(60, 150),
			cc.p(135, 150),
			cc.p(60, 80),
			cc.p(135, 80)
		}) do
			local var_17_11 = ccui.ImageView:create(self.resPath .. "product_bg.png", var_0_0)

			var_17_11:setPosition(iter_17_3)
			var_17_7:addChild(var_17_11)
			table.insert(var_17_7.products, var_17_11)

			var_17_11.cake = ccui.ImageView:create(self.resPath .. "cake.png", var_0_0)

			var_17_11:addChild(var_17_11.cake)

			local var_17_12 = ccui.ImageView:create(self.resPath .. "cake_cream_1.png", var_0_0)

			var_17_12:setName("cream")
			var_17_12:setAnchorPoint(0, 0)
			var_17_11.cake:addChild(var_17_12, 2)

			local var_17_13 = ccui.ImageView:create(self.resPath .. "cake_fruit_1.png", var_0_0)

			var_17_13:setName("fruit")
			var_17_13:setAnchorPoint(0, 0)
			var_17_11.cake:addChild(var_17_13, 3)
			var_17_11.cake:setPosition(var_17_11:getContentSize().width / 2, var_17_11:getContentSize().height / 2)
			var_17_11.cake:setScale(0.4)
			var_17_11.cake:setVisible(false)

			var_17_11.milktea = ccui.ImageView:create(self.resPath .. "milktea_pearl0.png", var_0_0)

			var_17_11:addChild(var_17_11.milktea)
			var_17_11.milktea:setPosition(var_17_11:getContentSize().width / 2, var_17_11:getContentSize().height / 2)
			var_17_11.milktea:setScale(0.5)
			var_17_11.milktea:setVisible(false)

			local var_17_14 = ccui.ImageView:create(self.resPath .. "taroball_excipient1.png", var_0_0)

			var_17_14:setName("excipient1")
			var_17_14:setAnchorPoint(0, 0)

			local var_17_15 = ccui.ImageView:create(self.resPath .. "taroball_excipient2.png", var_0_0)

			var_17_15:setName("excipient2")
			var_17_15:setAnchorPoint(0, 0)

			var_17_11.taroball = ccui.ImageView:create(self.resPath .. "taroball_base.png", var_0_0)

			var_17_11:addChild(var_17_11.taroball)
			var_17_11.taroball:addChild(var_17_14)
			var_17_11.taroball:addChild(var_17_15)
			var_17_11.taroball:setPosition(var_17_11:getContentSize().width / 2, var_17_11:getContentSize().height / 2)
			var_17_11.taroball:setScale(0.5)
			var_17_11.taroball:setVisible(false)
		end

		function var_17_7:update()
			if not self or not next(self) then
				return
			end

			local var_19_0 = 1
			local var_19_1 = {}

			while self["product_" .. var_19_0] do
				if not self["product_" .. var_19_0].isfinished then
					table.insert(var_19_1, self["product_" .. var_19_0])
				end

				var_19_0 = var_19_0 + 1
			end

			for iter_19_0, iter_19_1 in ipairs(var_17_7.products) do
				if var_19_1[iter_19_0] then
					iter_19_1:setVisible(true)
					iter_19_1.cake:setVisible(var_19_1[iter_19_0].cake and true or false)
					iter_19_1.milktea:setVisible(var_19_1[iter_19_0].pearl and true or false)
					iter_19_1.taroball:setVisible(var_19_1[iter_19_0].excipient1 and true or false)

					local var_19_2 = iter_19_1.cake:getChildByName("fruit")
					local var_19_3 = iter_19_1.cake:getChildByName("cream")
					local var_19_4 = iter_19_1.taroball:getChildByName("excipient1")
					local var_19_5 = iter_19_1.taroball:getChildByName("excipient2")

					var_19_2:setVisible(false)
					var_19_3:setVisible(false)
					var_19_5:setVisible(false)
					var_19_5:setVisible(false)

					if var_19_1[iter_19_0].fruit and var_19_1[iter_19_0].fruit ~= 0 then
						var_19_2:setVisible(true)
						var_19_2:loadTexture(self.resPath .. "cake_fruit_" .. var_19_1[iter_19_0].fruit .. ".png", var_0_0)
					end

					if var_19_1[iter_19_0].cream and var_19_1[iter_19_0].cream ~= 0 then
						var_19_3:setVisible(true)
						var_19_3:loadTexture(self.resPath .. "cake_cream_" .. var_19_1[iter_19_0].cream .. ".png", var_0_0)
					end

					if var_19_1[iter_19_0].pearl then
						iter_19_1.milktea:loadTexture(self.resPath .. "milktea_pearl" .. var_19_1[iter_19_0].pearl .. ".png", var_0_0)
					end

					if var_19_1[iter_19_0].excipient1 then
						var_19_4:setVisible(var_19_1[iter_19_0].excipient1 == 1)
						var_19_5:setVisible(var_19_1[iter_19_0].excipient2 == 1)
					end
				else
					iter_19_1:setVisible(false)
				end
			end
		end

		var_17_7.ani_success = sp.SkeletonAnimation:create("spine/bakery/order_success.json", "spine/bakery/order_success.atlas", 1)

		self.orderLayout:addChild(var_17_7.ani_success, 2)
		var_17_7.ani_success:setPosition(iter_17_1.x, iter_17_1.y - 120)
		var_17_7.ani_success:setVisible(false)

		var_17_7.ani_fail = sp.SkeletonAnimation:create("spine/bakery/order_fail.json", "spine/bakery/order_fail.atlas", 1)

		self.orderLayout:addChild(var_17_7.ani_fail, 2)
		var_17_7.ani_fail:setPosition(iter_17_1)
		var_17_7.ani_fail:setScale(3)
		var_17_7.ani_fail:setVisible(false)
	end
end

function ActivityBakeryLayer:initCakeUI()
	self.ovens = {}

	for iter_20_0, iter_20_1 in ipairs({
		cc.p(20, 750),
		cc.p(20, 580),
		cc.p(460, 650)
	}) do
		local var_20_0 = ccui.ImageView:create(self.resPath .. "oven_off.png", var_0_0)

		var_20_0:setPosition(iter_20_1)
		self.bg:addChild(var_20_0, 2)
		var_20_0:setVisible(false)
		table.insert(self.ovens, var_20_0)

		local var_20_1 = ccui.Slider:create()

		var_20_1:loadBarTexture(self.resPath .. "progress_bg_s.png", var_0_0)
		var_20_1:loadProgressBarTexture(self.resPath .. "progress_on_s.png", var_0_0)
		var_20_1:setPosition(160, 160)
		var_20_1:setPercent(50)
		var_20_0:addChild(var_20_1, 2)
		var_20_1:setName("progress")
		var_20_1:setVisible(false)

		var_20_0.ani_on = sp.SkeletonAnimation:create("spine/bakery/oven_on.json", "spine/bakery/oven_on.atlas", 1)

		var_20_0:addChild(var_20_0.ani_on, 1)
		var_20_0.ani_on:setPosition(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2)
		var_20_0.ani_on:setVisible(false)

		var_20_0.ani_fail = sp.SkeletonAnimation:create("spine/bakery/oven_fail.json", "spine/bakery/oven_fail.atlas", 1)

		var_20_0:addChild(var_20_0.ani_fail, 1)
		var_20_0.ani_fail:setPosition(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2)
		var_20_0.ani_fail:setVisible(false)

		if iter_20_0 == 1 then
			var_20_0:setVisible(true)
		end
	end

	self.trays = {}

	for iter_20_2, iter_20_3 in ipairs({
		cc.p(265, 640),
		cc.p(265, 560),
		cc.p(260, 400)
	}) do
		local var_20_2 = ccui.ImageView:create(self.resPath .. "tray.png", var_0_0)

		var_20_2:setPosition(iter_20_3)
		self.bg:addChild(var_20_2)
		table.insert(self.trays, var_20_2)
		var_20_2:setVisible(false)

		function var_20_2:update()
			if not self or not next(self) then
				var_20_2:loadTexture(self.resPath .. "tray.png", var_0_0)

				for iter_21_0, iter_21_1 in pairs(var_20_2:getChildren()) do
					iter_21_1:setVisible(false)
				end
			else
				var_20_2:loadTexture(self.resPath .. "cake.png", var_0_0)

				local var_21_0 = var_20_2:getChildByName("fruit")
				local var_21_1 = var_20_2:getChildByName("cream")

				if not var_21_0 then
					var_21_0 = ccui.ImageView:create(self.resPath .. "cake_fruit_1.png", var_0_0)

					var_21_0:setAnchorPoint(0, 0)
					var_21_0:setName("fruit")
					var_20_2:addChild(var_21_0, 3)
				end

				if not var_21_1 then
					var_21_1 = ccui.ImageView:create(self.resPath .. "cake_cream_1.png", var_0_0)

					var_21_1:setAnchorPoint(0, 0)
					var_21_1:setName("cream")
					var_20_2:addChild(var_21_1, 2)
				end

				var_21_0:setVisible(false)
				var_21_1:setVisible(false)

				if self.fruit and self.fruit ~= 0 then
					var_21_0:setVisible(true)
					var_21_0:loadTexture(self.resPath .. "cake_fruit_" .. self.fruit .. ".png", var_0_0)
				end

				if self.cream and self.cream ~= 0 then
					var_21_1:setVisible(true)
					var_21_1:loadTexture(self.resPath .. "cake_cream_" .. self.cream .. ".png", var_0_0)
				end
			end
		end
	end

	self.creams = {}

	for iter_20_4, iter_20_5 in ipairs({
		cc.p(25, 440),
		cc.p(80, 440),
		cc.p(135, 440)
	}) do
		local var_20_3 = ccui.Button:create(self.resPath .. "cream" .. iter_20_4 .. ".png", nil, self.resPath .. "cream" .. iter_20_4 .. ".png", var_0_0)

		var_20_3:setPosition(iter_20_5)
		self.bg:addChild(var_20_3)
		table.insert(self.creams, var_20_3)
	end

	self.fruitpools = {}

	for iter_20_6, iter_20_7 in ipairs({
		cc.p(80, 275),
		cc.p(180, 275),
		cc.p(280, 275)
	}) do
		local var_20_4 = ccui.Button:create(self.resPath .. "fruitpool.png", nil, self.resPath .. "fruitpool.png", var_0_0)

		var_20_4:setPosition(iter_20_7)
		self.bg:addChild(var_20_4)
		table.insert(self.fruitpools, var_20_4)

		local var_20_5 = ccui.ImageView:create(self.resPath .. "fruitpool_1.png", var_0_0)

		var_20_5:setPosition(var_20_4:getContentSize().width / 2 - 6, var_20_4:getContentSize().height / 2 + 8)
		var_20_4:addChild(var_20_5)
		var_20_5:setVisible(false)

		local var_20_6 = ccui.ImageView:create(self.resPath .. "fruit_num_bg.png", var_0_0)

		var_20_6:setPosition(var_20_4:getContentSize().width / 2, -5)
		var_20_4:addChild(var_20_6)
		var_20_6:setVisible(false)

		local var_20_7 = cc.Label:createWithTTF("0", FONT_NAME, 20)

		var_20_7:setPosition(var_20_6:getContentSize().width / 2, var_20_6:getContentSize().height / 2)
		var_20_6:addChild(var_20_7)
		var_20_7:setColor(cc.c3b(239, 169, 127))

		function var_20_4.update(arg_22_0)
			if not arg_22_0 or arg_22_0 <= 0 then
				var_20_5:setVisible(false)
				var_20_6:setVisible(false)
			else
				var_20_5:setVisible(true)
				var_20_5:loadTexture(self.resPath .. "fruitpool_" .. iter_20_6 .. ".png", var_0_0)
				var_20_6:setVisible(true)
				var_20_7:setString(arg_22_0)
			end
		end
	end

	self.choppings = {}

	for iter_20_8, iter_20_9 in ipairs({
		cc.p(250, 430),
		cc.p(420, 430),
		cc.p(320, 600)
	}) do
		local var_20_8 = ccui.ImageView:create(self.resPath .. "chopping.png", var_0_0)

		var_20_8:setPosition(iter_20_9)
		self.bg:addChild(var_20_8)
		table.insert(self.choppings, var_20_8)
		var_20_8:setVisible(false)

		function var_20_8:update()
			if not self or not next(self) then
				for iter_23_0, iter_23_1 in pairs(var_20_8:getChildren()) do
					iter_23_1:setVisible(false)
				end

				var_20_8.ani:setVisible(false)
			else
				local var_23_0 = var_20_8:getChildByName("fruit")

				if not var_23_0 then
					var_23_0 = ccui.ImageView:create(self.resPath .. "chopping_fruit_1.png", var_0_0)

					var_23_0:setPosition(var_20_8:getContentSize().width / 2, var_20_8:getContentSize().height / 2)
					var_23_0:setName("fruit")
					var_20_8:addChild(var_23_0, 3)
				end

				var_23_0:setVisible(false)

				if self.fruit then
					var_23_0:setVisible(true)
					var_23_0:loadTexture(self.resPath .. "chopping_fruit_" .. self.fruit .. ".png", var_0_0)

					if not var_20_8.ani:isVisible() then
						var_20_8.ani:setVisible(true)
						var_20_8.ani:setAnimation(0, "knife_on", true)
					end
				else
					var_20_8.ani:setVisible(false)
				end
			end
		end

		local var_20_9 = ccui.Slider:create()

		var_20_9:loadBarTexture(self.resPath .. "progress_bg_s.png", var_0_0)
		var_20_9:loadProgressBarTexture(self.resPath .. "progress_on_s.png", var_0_0)
		var_20_9:setPosition(75, 115)
		var_20_9:setPercent(50)
		var_20_8:addChild(var_20_9)
		var_20_9:setName("progress")
		var_20_9:setVisible(false)

		var_20_8.ani = sp.SkeletonAnimation:create("spine/bakery/knife_on.json", "spine/bakery/knife_on.atlas", 1)

		self.bg:addChild(var_20_8.ani, 2)
		var_20_8.ani:setPosition(var_20_8:getPosition())
		var_20_8.ani:setVisible(false)
	end

	self.fruits = {}

	for iter_20_10, iter_20_11 in ipairs({
		cc.p(425, 275),
		cc.p(505, 275),
		cc.p(585, 275)
	}) do
		local var_20_10 = ccui.Button:create(self.resPath .. "fruit" .. iter_20_10 .. ".png", nil, self.resPath .. "fruit" .. iter_20_10 .. ".png", var_0_0)

		var_20_10:setPosition(iter_20_11)
		self.bg:addChild(var_20_10)
		table.insert(self.fruits, var_20_10)
	end
end

function ActivityBakeryLayer:initMikeTeaUI()
	self.milkteaMechine = ccui.ImageView:create(self.resPath .. "milkteaMechine_off.png", var_0_0)

	self.milkteaMechine:setPosition(185, 785)
	self.bg:addChild(self.milkteaMechine)

	self.milkteas = {}

	for iter_24_0, iter_24_1 in ipairs({
		cc.p(335, 765),
		cc.p(400, 765),
		cc.p(465, 765),
		cc.p(260, 670),
		cc.p(320, 670),
		cc.p(380, 670)
	}) do
		local var_24_0 = ccui.Button:create(self.resPath .. "milktea.png", nil, self.resPath .. "milktea.png", var_0_0)

		var_24_0:setPosition(iter_24_1)
		var_24_0:setVisible(false)
		self.bg:addChild(var_24_0)
		table.insert(self.milkteas, var_24_0)

		function var_24_0:update()
			if not self or not next(self) then
				var_24_0:loadTextures(self.resPath .. "milktea.png", nil, self.resPath .. "milktea.png", var_0_0)
				var_24_0:setVisible(false)
			else
				var_24_0:loadTextures(self.resPath .. "milktea_pearl" .. self.pearl .. ".png", nil, self.resPath .. "milktea_pearl" .. self.pearl .. ".png", var_0_0)
				var_24_0:setVisible(true)
			end
		end
	end

	self.pearl = ccui.Button:create(self.resPath .. "pearl.png", nil, self.resPath .. "pearl.png", var_0_0)

	self.bg:addChild(self.pearl)
	self.pearl:setPosition(277, 750)

	self.milkteaMechine.ani = sp.SkeletonAnimation:create("spine/bakery/milktea_on.json", "spine/bakery/milktea_on.atlas", 1)

	self.bg:addChild(self.milkteaMechine.ani)
	self.milkteaMechine.ani:setPosition(self.milkteaMechine:getPositionX() - 10, self.milkteaMechine:getPositionY() - 55)
	self.milkteaMechine.ani:setVisible(false)
end

function ActivityBakeryLayer:initTaroballsUI()
	self.taroballsMechine = ccui.ImageView:create(self.resPath .. "taroballsMechine.png", var_0_0)

	self.taroballsMechine:setPosition(420, 600)
	self.bg:addChild(self.taroballsMechine)

	local var_26_0 = ccui.ImageView:create(self.resPath .. "taroballsMechine_icon.png", var_0_0)

	var_26_0:setVisible(false)
	self.taroballsMechine:addChild(var_26_0)
	var_26_0:setAnchorPoint(0, 0)
	var_26_0:setName("taroballsMechine_icon")

	self.taroballs = {}

	for iter_26_0, iter_26_1 in ipairs({
		cc.p(580, 570),
		cc.p(580, 490),
		cc.p(580, 410)
	}) do
		local var_26_1 = ccui.Button:create(self.resPath .. "taroball.png", nil, self.resPath .. "taroball.png", var_0_0)

		var_26_1:setPosition(iter_26_1)
		var_26_1:setVisible(false)
		self.bg:addChild(var_26_1)
		table.insert(self.taroballs, var_26_1)

		local var_26_2 = ccui.ImageView:create(self.resPath .. "taroball_excipient1.png", var_0_0)

		var_26_2:setVisible(false)
		var_26_1:addChild(var_26_2, 2)
		var_26_2:setAnchorPoint(0, 0)

		local var_26_3 = ccui.ImageView:create(self.resPath .. "taroball_excipient2.png", var_0_0)

		var_26_3:setVisible(false)
		var_26_1:addChild(var_26_3, 2)
		var_26_3:setAnchorPoint(0, 0)

		function var_26_1:update()
			if not self or not next(self) then
				var_26_1:loadTextures(self.resPath .. "taroball.png", nil, self.resPath .. "taroball.png", var_0_0)
				var_26_2:setVisible(false)
				var_26_3:setVisible(false)
			else
				var_26_1:loadTextures(self.resPath .. "taroball_base.png", nil, self.resPath .. "taroball_base.png", var_0_0)
				var_26_2:setVisible(self.excipient1 == 1)
				var_26_3:setVisible(self.excipient2 == 1)
			end
		end
	end

	local var_26_4 = ccui.ImageView:create(self.resPath .. "excipient_base.png", var_0_0)

	self.bg:addChild(var_26_4, 2)
	var_26_4:setPosition(550, 670)

	self.excipient_base = var_26_4
	self.excipients = {}

	for iter_26_2, iter_26_3 in ipairs({
		cc.p(0, 0),
		cc.p(0, 0)
	}) do
		local var_26_5 = ccui.ImageView:create(self.resPath .. "excipient" .. iter_26_2 .. ".png", var_0_0)

		var_26_4:addChild(var_26_5)
		var_26_5:setPosition(iter_26_3)
		var_26_5:setAnchorPoint(0, 0)
		table.insert(self.excipients, var_26_5)
	end

	self.taroballsMechine.ani = sp.SkeletonAnimation:create("spine/bakery/dessert_on.json", "spine/bakery/dessert_on.atlas", 1)

	self.bg:addChild(self.taroballsMechine.ani)
	self.taroballsMechine.ani:setPosition(self.taroballsMechine:getPositionX() - 4, self.taroballsMechine:getPositionY() - 20)
	self.taroballsMechine.ani:setVisible(false)
end

function ActivityBakeryLayer:initBottomUI()
	local var_28_0 = ccui.Button:create(self.resPath .. "btn_return.png", nil, self.resPath .. "btn_return.png", var_0_0)

	self.bg:addChild(var_28_0)
	var_28_0:setPosition(40, 150)
	var_28_0:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if bakery_gamelogic_manager.mainloop then
			LayerManager:pushInLayer("PopDoLayer", {
				surecallback = function()
					LayerManager:switchShowLayer("ActivityFightCollectionLayer", {
						activityId = self.activityId
					})
				end,
				labels = {
					titleImage = "title_warorder.png",
					des = "游戏中途退出无法获得任何奖励, 班长确定要退出吗?"
				}
			})
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)

	local var_28_1 = ccui.Button:create(self.resPath .. "btn_shop.png", nil, self.resPath .. "btn_shop.png", var_0_0)

	self.bg:addChild(var_28_1)
	var_28_1:setPosition(300, 150)
	var_28_1:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_31_0 = {
			"1-" .. self.activityId .. "06"
		}

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_31_0,
			showType = var_31_0[1]
		})
	end)

	local var_28_2 = ccui.Button:create(self.resPath .. "btn_task.png", nil, self.resPath .. "btn_task.png", var_0_0)

	self.bg:addChild(var_28_2)
	var_28_2:setPosition(435, 150)
	var_28_2:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "bakery",
			activityId = self.activityId
		})
	end)

	local var_28_3 = ccui.Button:create(self.resPath .. "btn_level_up.png", nil, self.resPath .. "btn_level_up.png", var_0_0)

	self.bg:addChild(var_28_3)
	var_28_3:setPosition(570, 150)
	var_28_3:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("ActivityBakeryLevelUpLayer", {
			activityId = self.activityId
		})
	end)

	self.btn_return = var_28_0
	self.btn_shop = var_28_1
	self.btn_task = var_28_2
	self.btn_level_up = var_28_3
end

function ActivityBakeryLayer:addGameTouchListener()
	for iter_34_0, iter_34_1 in ipairs(self.ovens) do
		iter_34_1:setTouchEnabled(true)
		iter_34_1:addTouchEventListener(function(arg_35_0, arg_35_1)
			if arg_35_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:addDough(iter_34_0)
		end)
	end

	for iter_34_2, iter_34_3 in ipairs(self.trays) do
		iter_34_3:setTouchEnabled(true)
		iter_34_3:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:commitProduct(var_0_4, iter_34_2)

			if os.time() - (iter_34_3.lastTouchtime or 0) < 0.05 then
				bakery_gamelogic_manager:discardProduct(var_0_4, iter_34_2)

				iter_34_3.lastTouchtime = 0
			else
				iter_34_3.lastTouchtime = os.time()
			end
		end)
	end

	for iter_34_4, iter_34_5 in ipairs(self.creams) do
		iter_34_5:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:addCream(iter_34_4)
		end)
	end

	for iter_34_6, iter_34_7 in ipairs(self.fruitpools) do
		iter_34_7:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:addFruit(iter_34_6)
		end)
	end

	for iter_34_8, iter_34_9 in ipairs(self.fruits) do
		iter_34_9:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:choppingFruit(iter_34_8)
		end)
	end

	self.milkteaMechine:setTouchEnabled(true)
	self.milkteaMechine:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		bakery_gamelogic_manager:milkteaMachineWorking()
	end)

	for iter_34_10, iter_34_11 in ipairs(self.milkteas) do
		iter_34_11:addTouchEventListener(function(arg_41_0, arg_41_1)
			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:commitProduct(var_0_5, iter_34_10)

			if os.time() - (iter_34_11.lastTouchtime or 0) < 0.05 then
				bakery_gamelogic_manager:discardProduct(var_0_5, iter_34_10)

				iter_34_11.lastTouchtime = 0
			else
				iter_34_11.lastTouchtime = os.time()
			end
		end)
	end

	self.pearl:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		bakery_gamelogic_manager:addPearls()
	end)
	self.taroballsMechine:setTouchEnabled(true)
	self.taroballsMechine:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		bakery_gamelogic_manager:taroballsMachineWorking()
	end)

	for iter_34_12, iter_34_13 in ipairs(self.taroballs) do
		iter_34_13:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			bakery_gamelogic_manager:commitProduct(var_0_6, iter_34_12)

			if os.time() - (iter_34_13.lastTouchtime or 0) < 0.05 then
				bakery_gamelogic_manager:discardProduct(var_0_6, iter_34_12)

				iter_34_13.lastTouchtime = 0
			else
				iter_34_13.lastTouchtime = os.time()
			end
		end)
	end

	self.excipient_base:setTouchEnabled(true)
	self.excipient_base:addTouchEventListener(function(arg_45_0, arg_45_1)
		self.excipients[1]:setScale(1)
		self.excipients[2]:setScale(1)

		if arg_45_1 == ccui.TouchEventType.began then
			local var_45_0 = arg_45_0:getTouchBeganPosition().x
			local var_45_1 = arg_45_0:getTouchBeganPosition().y
			local var_45_2 = arg_45_0:convertToNodeSpace(cc.p(var_45_0, var_45_1)).y

			if arg_45_0:convertToNodeSpace(cc.p(var_45_0, var_45_1)).x < 93 then
				self.excipients[1]:setScale(1.05)
			else
				self.excipients[2]:setScale(1.05)
			end
		elseif arg_45_1 == ccui.TouchEventType.moved then
			local var_45_3 = arg_45_0:getTouchMovePosition().x
			local var_45_4 = arg_45_0:getTouchMovePosition().y
			local var_45_5 = arg_45_0:convertToNodeSpace(cc.p(var_45_3, var_45_4)).y

			if arg_45_0:convertToNodeSpace(cc.p(var_45_3, var_45_4)).x < 93 then
				self.excipients[1]:setScale(1.05)
			else
				self.excipients[2]:setScale(1.05)
			end
		elseif arg_45_1 == ccui.TouchEventType.ended then
			local var_45_6 = arg_45_0:getTouchEndPosition().x
			local var_45_7 = arg_45_0:getTouchEndPosition().y
			local var_45_8 = arg_45_0:convertToNodeSpace(cc.p(var_45_6, var_45_7)).y

			if arg_45_0:convertToNodeSpace(cc.p(var_45_6, var_45_7)).x < 93 then
				bakery_gamelogic_manager:addExcipients(1)
			else
				bakery_gamelogic_manager:addExcipients(2)
			end
		end
	end)
end

function ActivityBakeryLayer:registerGameUIEvent()
	bakery_gamelogic_manager:registerGameEvent("UPDATE_ORDERS", self, self.updateOrders)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_CAKEMACHINE", self, self.updateCakeMechine)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_MILKTEA", self, self.updateMikeTea)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_TAROBALLS", self, self.updateTaroballs)
	bakery_gamelogic_manager:registerGameEvent("UPDATE_UIPROGRESS", self, self.updateUIProgress)
	bakery_gamelogic_manager:registerGameEvent("GAME_END", self, function(arg_47_0, arg_47_1)
		arg_47_0.levelinfo_bg:setVisible(true)
		arg_47_0:updateBottomUI(true)
		activity_manager:activity_bakery_pass_level(arg_47_0.activityId, arg_47_1.gold, function(arg_48_0)
			if arg_48_0.result == 1 then
				local var_48_0 = activity_manager:activity_get_bakery_level_conf(arg_47_0.activityId)

				arg_47_0.gold_label:setString(arg_48_0.gold)
				arg_47_0:initLevelInfoUI(arg_48_0, var_48_0 and var_48_0.dropid)
				LayerManager:pushInLayer("ActivityBakeryGameEndLayer", {
					result = "win",
					drop = arg_48_0.drop,
					callback = function()
						LayerManager:pushInLayer("ActivityBakeryHelpLayer", {
							activityId = arg_47_0.activityId,
							callback = function(arg_50_0)
								arg_47_0.levelinfo_bg:setVisible(false)
								arg_47_0.level_bg:setVisible(true)
								arg_47_0.level_label_1:setString(string.format("第%d关", arg_48_0.level))
								bakery_gamelogic_manager:initData()
								arg_47_0:registerGameUIEvent()
								bakery_gamelogic_manager:loadGameData(arg_50_0)
								bakery_gamelogic_manager:createMainLoop()
								arg_47_0:updateBottomUI(false)
								arg_47_0:updateItemNum()
							end
						})
					end
				})
			elseif arg_48_0.result == 2 then
				LayerManager:pushInLayer("ActivityBakeryGameEndLayer", {
					result = "failed",
					gold = arg_48_0.gold,
					level = arg_48_0.level,
					callback = function()
						LayerManager:pushInLayer("ActivityBakeryHelpLayer", {
							activityId = arg_47_0.activityId,
							callback = function(arg_52_0)
								arg_47_0.levelinfo_bg:setVisible(false)
								arg_47_0.level_bg:setVisible(true)
								arg_47_0.level_label_1:setString(string.format("第%d关", arg_48_0.level))
								bakery_gamelogic_manager:initData()
								arg_47_0:registerGameUIEvent()
								bakery_gamelogic_manager:loadGameData(arg_52_0)
								bakery_gamelogic_manager:createMainLoop()
								arg_47_0:updateBottomUI(false)
								arg_47_0:updateItemNum()
							end
						})
					end
				})
			end

			arg_47_0:updateLevelInitGameUI()
		end)
	end)
	bakery_gamelogic_manager:registerGameEvent("PLAY_ORDER_FAIL_ANI", self, function(arg_53_0, arg_53_1)
		arg_53_0.orders[arg_53_1].ani_fail:setVisible(true)
		arg_53_0.orders[arg_53_1].ani_fail:setAnimation(0, "order_fail", false)
		arg_53_0.orders[arg_53_1].ani_fail:registerSpineEventHandler(function()
			arg_53_0.orders[arg_53_1].ani_fail:setVisible(false)
		end, SP_ANIMATION_COMPLETE)
	end)
	bakery_gamelogic_manager:registerGameEvent("PLAY_ORDER_SUCCESS_ANI", self, function(arg_55_0, arg_55_1)
		arg_55_0.orders[arg_55_1].ani_success:setVisible(true)
		arg_55_0.orders[arg_55_1].ani_success:setAnimation(0, "order_success", false)
		arg_55_0.orders[arg_55_1].ani_success:registerSpineEventHandler(function()
			arg_55_0.orders[arg_55_1].ani_success:setVisible(false)
		end, SP_ANIMATION_COMPLETE)
	end)
end

function ActivityBakeryLayer:updateOrders(arg_57_1)
	if not next(arg_57_1) then
		for iter_57_0, iter_57_1 in ipairs(self.orders) do
			iter_57_1:setVisible(false)
		end
	end

	for iter_57_2, iter_57_3 in ipairs(arg_57_1) do
		if not iter_57_3 or not next(iter_57_3) then
			self.orders[iter_57_2]:setVisible(false)
		else
			self.orders[iter_57_2]:setVisible(true)
			self.orders[iter_57_2].update(iter_57_3)
		end
	end
end

function ActivityBakeryLayer:updateCakeMechine(arg_58_1)
	for iter_58_0, iter_58_1 in ipairs(arg_58_1.ovensPool) do
		self.ovens[iter_58_0]:setVisible(true)

		if iter_58_1.cake then
			self.ovens[iter_58_0]:loadTexture(self.resPath .. "oven_on.png", var_0_0)

			if iter_58_1.is_burning then
				if not self.ovens[iter_58_0].ani_fail:isVisible() then
					self.ovens[iter_58_0].ani_fail:setVisible(true)
					self.ovens[iter_58_0].ani_fail:setAnimation(0, "oven_fail", true)
				end

				self.ovens[iter_58_0].ani_on:setVisible(false)
				self.ovens[iter_58_0].ani_fail:setVisible(true)
			else
				if not self.ovens[iter_58_0].ani_on:isVisible() then
					self.ovens[iter_58_0].ani_on:setVisible(true)
					self.ovens[iter_58_0].ani_on:setAnimation(0, "oven_on", true)
				end

				self.ovens[iter_58_0].ani_on:setVisible(true)
				self.ovens[iter_58_0].ani_fail:setVisible(false)
			end
		else
			self.ovens[iter_58_0].ani_on:setVisible(false)
			self.ovens[iter_58_0].ani_fail:setVisible(false)
			self.ovens[iter_58_0]:loadTexture(self.resPath .. "oven_off.png", var_0_0)
		end
	end

	for iter_58_2, iter_58_3 in ipairs(arg_58_1.trays) do
		self.trays[iter_58_2]:setVisible(true)
		self.trays[iter_58_2].update(iter_58_3)
	end

	for iter_58_4, iter_58_5 in ipairs(self.fruitpools) do
		iter_58_5.update(arg_58_1.fruitPool[iter_58_4])
	end

	for iter_58_6, iter_58_7 in ipairs(arg_58_1.choppingPool) do
		self.choppings[iter_58_6]:setVisible(true)
		self.choppings[iter_58_6].update(iter_58_7)
	end
end

function ActivityBakeryLayer:updateMikeTea(arg_59_1)
	if self.confdata.milktea_unlock > activity_manager:activity_get_bakery_cur_data(self.activityId).level then
		self.milkteaMechine:setVisible(false)
		self.pearl:setVisible(false)

		return
	else
		self.milkteaMechine:setVisible(true)
		self.pearl:setVisible(true)
	end

	if arg_59_1.working then
		self.milkteaMechine:loadTexture(self.resPath .. "milkteaMechine_on.png", var_0_0)

		if not self.milkteaMechine.ani:isVisible() then
			self.milkteaMechine.ani:setVisible(true)
			self.milkteaMechine.ani:setAnimation(0, "milktea_on", true)
		end
	else
		self.milkteaMechine:loadTexture(self.resPath .. "milkteaMechine_off.png", var_0_0)
		self.milkteaMechine.ani:setVisible(false)
	end

	for iter_59_0, iter_59_1 in ipairs(arg_59_1.milkteas) do
		self.milkteas[iter_59_0].update(iter_59_1)
	end
end

function ActivityBakeryLayer:updateTaroballs(arg_60_1)
	if self.confdata.taroballs_unlock > activity_manager:activity_get_bakery_cur_data(self.activityId).level then
		self.taroballsMechine:setVisible(false)
		self.excipient_base:setVisible(false)

		return
	else
		self.taroballsMechine:setVisible(true)
		self.excipient_base:setVisible(true)
	end

	if arg_60_1.working then
		if not self.taroballsMechine.ani:isVisible() then
			self.taroballsMechine.ani:setVisible(true)
			self.taroballsMechine.ani:setAnimation(0, "dessert_on", true)
		end
	else
		self.taroballsMechine.ani:setVisible(false)
	end

	for iter_60_0, iter_60_1 in ipairs(arg_60_1.taroballs) do
		self.taroballs[iter_60_0]:setVisible(true)
		self.taroballs[iter_60_0].update(iter_60_1)
	end
end

function ActivityBakeryLayer:updateUIProgress(arg_61_1)
	for iter_61_0, iter_61_1 in ipairs(self.orders) do
		if arg_61_1.orderdata[iter_61_0].time then
			iter_61_1.progressBar:setPercent((1 - arg_61_1.orderdata[iter_61_0].time / arg_61_1.max_wait_time) * 100)

			if (1 - arg_61_1.orderdata[iter_61_0].time / arg_61_1.max_wait_time) * 100 > 66 then
				iter_61_1.progressBar:loadProgressBarTexture(self.resPath .. "progress_on_1.png", var_0_0)
				iter_61_1.emoji:loadTexture(self.resPath .. "emoji_happy.png", var_0_0)
			elseif (1 - arg_61_1.orderdata[iter_61_0].time / arg_61_1.max_wait_time) * 100 > 33 then
				iter_61_1.progressBar:loadProgressBarTexture(self.resPath .. "progress_on_2.png", var_0_0)
				iter_61_1.emoji:loadTexture(self.resPath .. "emoji_common.png", var_0_0)
			else
				iter_61_1.progressBar:loadProgressBarTexture(self.resPath .. "progress_on_3.png", var_0_0)
				iter_61_1.emoji:loadTexture(self.resPath .. "emoji_angry.png", var_0_0)
			end
		end
	end

	self.level_gold_label:setString(arg_61_1.gold)
	self.target_gold_label:setString(arg_61_1.target_gold)

	if arg_61_1.level_time - arg_61_1.game_time < 0 then
		return
	end

	self.time_label:setString((string.format("%02d:%02d", math.floor((arg_61_1.level_time - arg_61_1.game_time) / 60), (arg_61_1.level_time - arg_61_1.game_time) % 60)))

	for iter_61_2, iter_61_3 in ipairs(arg_61_1.ovendata) do
		if iter_61_3.time and iter_61_3.cake then
			if iter_61_3.time <= arg_61_1.oventime then
				self.ovens[iter_61_2]:getChildByName("progress"):loadProgressBarTexture(self.resPath .. "progress_on_s.png", var_0_0)
			else
				self.ovens[iter_61_2]:getChildByName("progress"):loadProgressBarTexture(self.resPath .. "progress_on_red.png", var_0_0)
			end

			self.ovens[iter_61_2]:getChildByName("progress"):setPercent((iter_61_3.time <= arg_61_1.oventime or nil) and (100 * iter_61_3.time / arg_61_1.oventime or 100 * (iter_61_3.time - arg_61_1.oventime) / arg_61_1.burningtime))
			self.ovens[iter_61_2]:getChildByName("progress"):setVisible(true)
		else
			self.ovens[iter_61_2]:getChildByName("progress"):setVisible(false)
		end
	end

	for iter_61_4, iter_61_5 in ipairs(arg_61_1.choppingdata) do
		if iter_61_5.time and iter_61_5.fruit then
			self.choppings[iter_61_4]:getChildByName("progress"):setPercent(100 * iter_61_5.time / arg_61_1.choptime)
			self.choppings[iter_61_4]:getChildByName("progress"):setVisible(true)
		else
			self.choppings[iter_61_4]:getChildByName("progress"):setVisible(false)
		end
	end
end

function ActivityBakeryLayer:updateLevelInitGameUI()
	local var_62_0 = activity_manager:activity_get_bakery_cur_data(self.activityId)
	local activity_bakery_level_conf = require("data.activity_bakery_level_conf")
	local activity_bakery_device_data = require("data.activity_bakery_device_data")
	local var_62_3 = self.activityId * 100 + math.min(var_62_0.level, self.confdata.max_level)
	local var_62_4 = {
		target_gold = var_62_0.target_gold
	}

	var_62_4.max_ongoing_order_num = activity_bakery_level_conf[var_62_3].max_ongoing_order_num or 3
	var_62_4.refresh_order_time = activity_bakery_level_conf[var_62_3].refresh_order_time
	var_62_4.level_time = activity_bakery_level_conf[var_62_3].level_time
	var_62_4.max_wait_time = activity_bakery_level_conf[var_62_3].max_wait_time
	var_62_4.first_order_time = activity_bakery_level_conf[var_62_3].first_order_time or activity_bakery_level_conf[var_62_3].refresh_order_time
	var_62_4.no_order_refresh_time = activity_bakery_level_conf[var_62_3].no_order_refresh_time or activity_bakery_level_conf[var_62_3].refresh_order_time
	var_62_4.order_create = {
		cake_need_max = activity_bakery_level_conf[var_62_3].cake_need_max,
		cake_need_min = activity_bakery_level_conf[var_62_3].cake_need_min,
		milktea_need_max = activity_bakery_level_conf[var_62_3].milktea_need_max,
		milktea_need_min = activity_bakery_level_conf[var_62_3].milktea_need_min,
		taroballs_need_max = activity_bakery_level_conf[var_62_3].taroballs_need_max,
		taroballs_need_min = activity_bakery_level_conf[var_62_3].taroballs_need_min
	}
	var_62_4.oven_num = activity_bakery_device_data.oven_num["levelValue" .. (var_62_0.equipment_level.oven_num or 1)]
	var_62_4.tray_num = activity_bakery_device_data.tray_num["levelValue" .. (var_62_0.equipment_level.tray_num or 1)]
	var_62_4.chopping_num = activity_bakery_device_data.chopping_num["levelValue" .. (var_62_0.equipment_level.chopping_num or 1)]
	var_62_4.milktea_num = activity_bakery_device_data.milktea_num["levelValue" .. (var_62_0.equipment_level.milktea_num or 1)]
	var_62_4.taroballs_num = activity_bakery_device_data.taroballs_num["levelValue" .. (var_62_0.equipment_level.taroballs_num or 1)]
	var_62_4.oventime = activity_bakery_device_data.oventime["levelValue" .. (var_62_0.equipment_level.oventime or 1)]
	var_62_4.burningtime = activity_bakery_device_data.burningtime["levelValue" .. (var_62_0.equipment_level.burningtime or 1)]
	var_62_4.choptime = activity_bakery_device_data.choptime["levelValue" .. (var_62_0.equipment_level.choptime or 1)]
	var_62_4.milkteatime = activity_bakery_device_data.milkteatime["levelValue" .. (var_62_0.equipment_level.milkteatime or 1)]
	var_62_4.taroballstime = activity_bakery_device_data.taroballstime["levelValue" .. (var_62_0.equipment_level.taroballstime or 1)]
	var_62_4.fruitPoolNum = activity_bakery_device_data.fruitPoolNum["levelValue" .. (var_62_0.equipment_level.fruitPoolNum or 1)]

	local var_62_5 = {}

	var_62_5.cake_prize = activity_bakery_device_data.cake_prize["levelValue" .. (var_62_0.equipment_level.cake_prize or 1)]
	var_62_5.cream_prize = activity_bakery_device_data.cream_prize["levelValue" .. (var_62_0.equipment_level.cream_prize or 1)]
	var_62_5.fruit_prize_1 = activity_bakery_device_data.fruit_prize_1["levelValue" .. (var_62_0.equipment_level.fruit_prize_1 or 1)]
	var_62_5.fruit_prize_2 = activity_bakery_device_data.fruit_prize_2["levelValue" .. (var_62_0.equipment_level.fruit_prize_2 or 1)]
	var_62_5.fruit_prize_3 = activity_bakery_device_data.fruit_prize_3["levelValue" .. (var_62_0.equipment_level.fruit_prize_3 or 1)]
	var_62_5.pearl_prize = activity_bakery_device_data.pearl_prize["levelValue" .. (var_62_0.equipment_level.pearl_prize or 1)]
	var_62_5.milktea_prize = activity_bakery_device_data.milktea_prize["levelValue" .. (var_62_0.equipment_level.milktea_prize or 1)]
	var_62_5.taroballs_prize = activity_bakery_device_data.taroballs_prize["levelValue" .. (var_62_0.equipment_level.taroballs_prize or 1)]
	var_62_5.excipients_prize_1 = activity_bakery_device_data.excipients_prize_1["levelValue" .. (var_62_0.equipment_level.excipients_prize_1 or 1)]
	var_62_5.excipients_prize_2 = activity_bakery_device_data.excipients_prize_2["levelValue" .. (var_62_0.equipment_level.excipients_prize_2 or 1)]
	var_62_4.prize = var_62_5

	bakery_gamelogic_manager:loadGameData(var_62_4)
end

function ActivityBakeryLayer:updateItemNum()
	self.keyitem_label:setString(item_manager:getItemNumber(self.confdata.key_item))
end

function ActivityBakeryLayer:updateBottomUI(arg_64_1)
	self.btn_shop:setVisible(arg_64_1)
	self.btn_task:setVisible(arg_64_1)
	self.btn_level_up:setVisible(arg_64_1)
	self.gold_icon_bg:setVisible(arg_64_1)
	self.item_icon_bg:setVisible(arg_64_1)
	self.level_gold_bg:setVisible(not arg_64_1)
	self.target_gold_bg:setVisible(not arg_64_1)
end

function ActivityBakeryLayer:initDeBugBtn()
	local var_65_0 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_0)
	local var_65_1 = cc.Label:createWithTTF("进入DeBug场景", FONT_NAME, 22)

	var_65_1:setPosition(cc.p(var_65_0:getContentSize().width / 2, var_65_0:getContentSize().height / 2))
	var_65_0:addChild(var_65_1)
	var_65_0:setPosition(cc.p(320, 1200))
	self.bg:addChild(var_65_0, 99)
	var_65_0:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityBakeryDeBugLayer", {
			activityId = self.activityId
		})
	end)

	local var_65_2 = ccui.Button:create("public/button/public_button_red.png", nil, "public/button/public_button_red.png", var_0_0)
	local var_65_3 = cc.Label:createWithTTF("过关", FONT_NAME, 22)

	var_65_3:setPosition(cc.p(var_65_2:getContentSize().width / 2, var_65_2:getContentSize().height / 2))
	var_65_2:addChild(var_65_3)
	var_65_2:setPosition(cc.p(500, 1200))
	self.bg:addChild(var_65_2, 99)
	var_65_2:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:activity_bakery_pass_level(self.activityId, 20000, function(arg_68_0)
			if arg_68_0.result == 1 then
				local var_68_0 = activity_manager:activity_get_bakery_level_conf(self.activityId)

				self.gold_label:setString(arg_68_0.gold)
				self:initLevelInfoUI(arg_68_0, var_68_0 and var_68_0.dropid)
				global_ShowBlockWords("过关成功")
				bakery_gamelogic_manager:unloop()
				self:updateLevelInitGameUI()
			end
		end)
	end)
end
