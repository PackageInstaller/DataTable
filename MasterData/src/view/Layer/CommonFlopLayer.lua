CommonFlopLayer = class("CommonFlopLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSpriteCommonFlop")

local activity_manager = require("controller.activity_manager")
local component_manager = require("controller.component_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = "CommonFlopLayer/"
local armature_manager = require("controller.armature_manager")

require("view.Layer.CommonFlopJsonLayer")

local var_0_8 = 66
local var_0_9 = 620
local var_0_10 = 540
local var_0_11 = 100

local function var_0_12(arg_2_0)
	local var_2_0 = -1
	local var_2_1 = require("data.horcrux_data")[arg_2_0].horcruxt

	for iter_2_0, iter_2_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_2_0 == iter_2_1.item_id then
			var_2_0 = iter_2_0

			break
		end
	end

	if var_2_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_2_0,
		itemid = arg_2_0
	})
end

local function var_0_13(arg_3_0)
	local var_3_0 = {
		"1-" .. tonumber(arg_3_0) % 1500000
	}

	LayerManager:switchShowLayer("MarketLayer", {
		singleMarket = var_3_0,
		showType = var_3_0[1]
	})
end

function CommonFlopLayer.create(arg_4_0, arg_4_1)
	if arg_4_1.activityId > 762 then
		return CommonFlopJsonLayer:create(arg_4_1)
	end

	local var_4_0 = CommonFlopLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function CommonFlopLayer:init(arg_5_1)
	self.activityId = arg_5_1.activityId or 730
	self.layerName = "CommonFlipLayer_" .. self.activityId
	var_0_6 = self.activityId == 730 and "CommonFlopLayer/" or "Activities/activity" .. self.activityId .. "/flop/"

	if self.activityId ~= 730 then
		TextureManager:loadLayerTextures({
			"Activities_activity" .. self.activityId .. "_flop"
		})
	end

	self:initUI()
	self:initTouchEvent()
	self:registerEventListener()
	activity_manager:test11(self.activityId)
	activity_manager:getActivityCommonFlopConf(self.activityId, function(arg_6_0)
		if not arg_6_0.nowChampionData or not next(arg_6_0.nowChampionData) then
			self:initChampionChosePanel()
			global_ShowBlockWords("可以自选三个大奖哦~")
		end
	end)
	self:updateTaskAlert()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			local var_7_0, var_7_1, var_7_2 = activity_manager:getFlopTicket(self.activityId)

			activity_manager:updateActivityAlert("flop", self.activityId, var_7_0 <= var_7_1)

			if self.activityId ~= 730 then
				TextureManager:removeLayerTextures({
					"Activities_activity" .. self.activityId .. "_flop"
				})
			end
		end
	end)
end

function CommonFlopLayer:initUI()
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	self.bg = ccui.ImageView:create(var_0_6 .. "bg.png", var_0_5)

	self.rootLayer:addChild(self.bg)
	self.bg:setAnchorPoint(0, 1)
	self.bg:setPosition(0, GameDisplay.height)

	local var_8_0 = ccui.Button:create(var_0_6 .. "title.png", nil, var_0_6 .. "title.png", var_0_5)

	self.rootLayer:addChild(var_8_0)
	var_8_0:setAnchorPoint(0, 1)
	var_8_0:setPosition(0, GameDisplay.height + 50 - GameDisplay.fix_y * 0.8)
	var_8_0:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "commonFlop"
		})
	end)

	self.task_btn = ccui.Button:create(var_0_6 .. "task_btn.png", nil, var_0_6 .. "task_btn.png", var_0_5)

	self.rootLayer:addChild(self.task_btn)
	self.task_btn:setAnchorPoint(1, 1)
	self.task_btn:setPosition(GameDisplay.width, GameDisplay.height - GameDisplay.fix_y * 0.8)

	self.more_btn = ccui.Button:create(var_0_6 .. "more_btn.png", nil, var_0_6 .. "more_btn.png", var_0_5)

	self.rootLayer:addChild(self.more_btn)
	self.more_btn:setAnchorPoint(1, 1)
	self.more_btn:setPosition(GameDisplay.width, GameDisplay.height - 100 - GameDisplay.fix_y * 0.8)

	self.exchange_btn = ccui.Button:create(var_0_6 .. "exchange_btn.png", nil, var_0_6 .. "exchange_btn.png", var_0_5)

	self.rootLayer:addChild(self.exchange_btn)
	self.exchange_btn:setAnchorPoint(0, 1)
	self.exchange_btn:setPosition(0, GameDisplay.height - 200 - GameDisplay.fix_y * 0.8)

	self.champion_btn = ccui.Button:create(var_0_6 .. "champion_btn.png", nil, var_0_6 .. "champion_btn.png", var_0_5)

	self.rootLayer:addChild(self.champion_btn)
	self.champion_btn:setAnchorPoint(1, 1)
	self.champion_btn:setPosition(GameDisplay.width, GameDisplay.height - 200 - GameDisplay.fix_y * 0.8)

	self.championsPanel = ccui.ImageView:create(var_0_6 .. "championsPanel_bg.png", var_0_5)

	self.rootLayer:addChild(self.championsPanel)
	self.championsPanel:setAnchorPoint(0.5, 1)
	self.championsPanel:setPosition(GameDisplay.width / 2, GameDisplay.height - 200 - GameDisplay.fix_y * 0.8)

	local var_8_1 = {
		80,
		160,
		240
	}

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = ccui.Button:create(var_0_6 .. "champion_bg.png", nil, var_0_6 .. "champion_bg.png", var_0_5)

		var_8_2:setPosition(var_8_1[iter_8_0], 45)
		self.championsPanel:addChild(var_8_2)
		var_8_2:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:initChampionChosePanel()
		end)
		var_8_2:setName("champion_" .. iter_8_0)

		local var_8_3 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

		var_8_3:setPosition(33, 33)
		var_8_2:addChild(var_8_3)
	end

	self.drawPanel = ccui.ImageView:create(var_0_6 .. "drawPanel_bg.png", var_0_5)

	self.rootLayer:addChild(self.drawPanel)
	self.drawPanel:setAnchorPoint(0.5, 1)
	self.drawPanel:setPosition(GameDisplay.width / 2, GameDisplay.height - 300 - GameDisplay.fix_y * 0.8)

	self.next_btn = ccui.Button:create(var_0_6 .. "next_btn_on.png", nil, var_0_6 .. "next_btn_off.png", var_0_5)

	self.rootLayer:addChild(self.next_btn)
	self.next_btn:setAnchorPoint(0.5, 1)
	self.next_btn:setPosition(GameDisplay.width / 2, GameDisplay.height - 1030 - GameDisplay.fix_y * 0.8)

	self.return_btn = ccui.Button:create(var_0_6 .. "return_btn.png", nil, var_0_6 .. "return_btn.png", var_0_5)

	self.rootLayer:addChild(self.return_btn)
	self.return_btn:setAnchorPoint(0, 0)
	self.return_btn:setPosition(0, 10)

	self.currencyBg = ccui.ImageView:create(var_0_6 .. "currencyBg.png", var_0_5)

	self.rootLayer:addChild(self.currencyBg)
	self.currencyBg:setAnchorPoint(0, 0)
	self.currencyBg:setPosition(430, 0)

	self.addBtn = ccui.Button:create(var_0_6 .. "add.png", nil, var_0_6 .. "add.png", var_0_5)

	self.currencyBg:addChild(self.addBtn)
	self.addBtn:setAnchorPoint(0, 0)
	self.addBtn:setPosition(133, 20)

	self.cardTbl = {}

	for iter_8_2 = 1, 6 do
		for iter_8_3 = 1, 6 do
			local var_8_4 = ItemSpriteCommonFlop:create(self.activityId, 6 * (iter_8_2 - 1) + iter_8_3)

			var_8_4:setPositionX(var_0_8 + (var_0_10 - var_0_8) / 5 * (iter_8_3 - 1))
			var_8_4:setPositionY(var_0_9 + (var_0_11 - var_0_9) / 5 * (iter_8_2 - 1))
			table.insert(self.cardTbl, var_8_4)
			self.drawPanel:addChild(var_8_4)
		end
	end

	self.turnsLabel = cc.Label:createWithTTF("", FONT_DES, 30)

	self.turnsLabel:setPosition(320, GameDisplay.height - 160 - GameDisplay.fix_y * 0.8)
	self.rootLayer:addChild(self.turnsLabel)

	if self.activityId == 758 then
		self.turnsLabel:setColor(cc.c3b(0, 0, 0))
	end

	local var_8_5, var_8_6, var_8_7 = activity_manager:getFlopTicket(self.activityId)

	self.ticketNumLabel = cc.Label:createWithTTF("", FONT_DES, 24)

	self.ticketNumLabel:setPosition(100, 43)
	self.currencyBg:addChild(self.ticketNumLabel)

	if self.activityId == 758 then
		self.ticketNumLabel:setColor(cc.c3b(0, 0, 0))
	end

	local var_8_8 = activity_manager:getCommonFlopPoint(self.activityId)
end

function CommonFlopLayer:updateUI()
	self:updateTurns()
	self:updateBottom()
end

function CommonFlopLayer:updateTurns()
	self.turnsLabel:setString(string.format(L_FLOP_TURNS_NOW, activity_manager:getCommonFlopTurns(self.activityId), (activity_manager:getCommonFlopLimitTurns(self.activityId))))
end

function CommonFlopLayer:updateBottom()
	local var_13_0, var_13_1, var_13_2 = activity_manager:getFlopTicket(self.activityId)
	local var_13_3 = activity_manager:getCommonFlopPoint(self.activityId)

	self.ticketNumLabel:setString(var_13_1)

	local var_13_4 = activity_manager:canreset(self.activityId) and "next_btn_on.png" or "next_btn_off.png"

	self.next_btn:loadTextures(var_0_6 .. var_13_4, nil, var_0_6 .. var_13_4, var_0_5)
end

function CommonFlopLayer:initTouchEvent()
	self.return_btn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.champion_btn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("CommonFlopDropDetailsLayer", {
			activityId = self.activityId
		})
	end)
	self.next_btn:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:goCommonNextTurn(self.activityId)
	end)
	self.more_btn:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.activityId, 1)
	end)
	self.task_btn:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCommonTaskLayer", {
			usemodule = "commonFlop",
			activityId = self.activityId
		})
	end)
	self.exchange_btn:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.activityId == 730 then
			var_0_13("1573001")
		else
			var_0_13(activity_manager:getFlopShopJump(self.activityId))
		end
	end)
	self.addBtn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:getFlopLimitBag(self.activityId, 1)
	end)
end

function CommonFlopLayer:registerEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_23_0)
		self:updateUI()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CONF_UPDATE, function(arg_24_0)
		print("activityManager.activityEventId.ACTIVITY_COMMONFLOP_CONF_UPDATE")
		self:updateUI()

		if arg_24_0.is_reset then
			self:showGoNextTurnAni()
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COMMONFLOP_SET_RESULT, function(arg_25_0)
		self:updateUI()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_COMMONFLOP_CHAMPIONS_UPDATE, function(arg_26_0)
		self:updateChampionsPanel(arg_26_0)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_27_0)
		self:updateUI()
	end), self)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_28_0)
		self:updateTaskAlert()
	end)
end

function CommonFlopLayer:initChampionChosePanel()
	if not self.championLayer then
		local var_29_0 = ccui.Layout:create()

		var_29_0:setContentSize(cc.size(640, 1600))
		var_29_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_29_0:setCascadeOpacityEnabled(false)
		var_29_0:setBackGroundColorOpacity(182)
		var_29_0:setAnchorPoint(0.5, 0.5)
		var_29_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_29_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_29_0:setTouchEnabled(true)
		var_29_0:setLocalZOrder(1000)
		var_29_0:setVisible(true)
		self.rootLayer:addChild(var_29_0)

		self.championLayer = var_29_0

		local var_29_1 = ccui.ImageView:create(var_0_6 .. "champion_choose_bg.png", var_0_5)

		var_29_1:setPosition(320, 900)
		var_29_0:addChild(var_29_1)

		local var_29_2 = {
			150,
			300,
			450
		}

		for iter_29_0, iter_29_1 in ipairs(var_29_2) do
			local var_29_3 = ccui.ImageView:create(var_0_6 .. "championIconBg.png", var_0_5)

			var_29_3:setTouchEnabled(true)
			var_29_3:setPosition(var_29_2[iter_29_0], 165)
			var_29_1:addChild(var_29_3)

			local var_29_4 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

			var_29_4:setPosition(52, 60)
			var_29_4:setScale(1.5)
			var_29_3:addChild(var_29_4)
			var_29_3:setName("myChampion_" .. iter_29_0)
			var_29_3:addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:removeChampionItem(iter_29_0)
			end)
		end

		local var_29_5 = ccui.Button:create(var_0_6 .. "cancel_btn.png", nil, var_0_6 .. "cancel_btn.png", var_0_5)

		var_29_5:setPosition(180, 60)
		var_29_1:addChild(var_29_5)
		var_29_5:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_29_0:setVisible(false)
		end)

		local var_29_6 = ccui.Button:create(var_0_6 .. "sure_btn.png", nil, var_0_6 .. "sure_btn.png", var_0_5)

		var_29_6:setPosition(420, 60)
		var_29_1:addChild(var_29_6)
		var_29_6:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:setChampionItems(self.championItems)
		end)

		self.myChoseBg = var_29_1

		local var_29_7 = ccui.ImageView:create(var_0_6 .. "jiange.png", var_0_5)

		var_29_7:setPosition(320, 640)
		var_29_0:addChild(var_29_7)

		self.championItemsPanel = ccui.ImageView:create(var_0_6 .. "can_choose_bg.png", var_0_5)

		self.championItemsPanel:setPosition(320, 400)
		var_29_0:addChild(self.championItemsPanel)

		local var_29_8 = ccui.ListView:create()

		var_29_8:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_29_8:setBounceEnabled(true)
		var_29_8:setContentSize(550, 330)
		var_29_8:setPosition(310, 190)
		var_29_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_29_8:setItemsMargin(0.1)
		self.championItemsPanel:addChild(var_29_8)

		self.championsLayout = ccui.Layout:create()

		self.championsLayout:setContentSize(550, 200)
		var_29_8:pushBackCustomItem(self.championsLayout)
	end

	self.championLayer:setVisible(true)

	self.championItems = clone(activity_manager:getChampionItems(self.activityId))

	self:updateMyChoseBg(self.championItems)
	self:updateChampionChosePanel()
end

function CommonFlopLayer:updateChampionsPanel(arg_33_1)
	for iter_33_0 = 1, 3 do
		local var_33_0 = self.championsPanel:getChildByName("champion_" .. iter_33_0)

		if not arg_33_1[iter_33_0] or arg_33_1[iter_33_0].id == 0 then
			var_33_0:removeAllChildren()

			local var_33_1 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

			var_33_1:setPosition(33, 33)
			var_33_0:addChild(var_33_1)
		else
			var_33_0:removeAllChildren()

			local var_33_2, var_33_3 = self:updateChampionIcon(nil, arg_33_1[iter_33_0].dropid)

			var_33_2:setPosition(33, 33)
			var_33_2:setScale(var_33_2:getScale() * 0.6)
			var_33_0:addChild(var_33_2)

			local var_33_4 = cc.Label:createWithTTF("", FONT_DES, 16)

			var_33_4:setString("x" .. var_33_3)
			var_33_4:setPosition(47, 12)
			var_33_0:addChild(var_33_4)
		end
	end
end

function CommonFlopLayer:updateMyChoseBg(arg_34_1)
	for iter_34_0 = 1, 3 do
		local var_34_0 = self.myChoseBg:getChildByName("myChampion_" .. iter_34_0)

		if not arg_34_1[iter_34_0] or arg_34_1[iter_34_0].id == 0 then
			var_34_0:removeAllChildren()

			local var_34_1 = ccui.ImageView:create(var_0_6 .. "add.png", var_0_5)

			var_34_1:setPosition(52, 60)
			var_34_1:setScale(1.5)
			var_34_0:addChild(var_34_1)
		else
			var_34_0:removeAllChildren()

			local var_34_2, var_34_3 = self:updateChampionIcon(nil, activity_manager:getChampionConf(self.activityId)["champion_" .. arg_34_1[iter_34_0].id])

			var_34_2:setPosition(50, 62)
			var_34_2:setScale(var_34_2:getScale() * 0.8)
			var_34_0:addChild(var_34_2)

			local var_34_4 = ccui.ImageView:create(var_0_6 .. "label_bg.png", var_0_5)

			var_34_4:setAnchorPoint(0, 0)
			var_34_0:addChild(var_34_4)

			local var_34_5 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_34_5:setString("x" .. var_34_3)
			var_34_5:setPosition(50, 12)
			var_34_4:addChild(var_34_5)

			if arg_34_1[iter_34_0].order ~= 0 then
				local var_34_6 = armature_manager:createAndPlayArmature("flop")

				var_34_6:setPositionX(var_34_0:getContentSize().width / 2)
				var_34_6:setPositionY(var_34_0:getContentSize().height / 2)
				var_34_0:addChild(var_34_6, 2)
			end
		end
	end
end

function CommonFlopLayer:updateChampionChosePanel()
	self.championsLayout:removeAllChildren()

	local var_35_0 = activity_manager:getChampionConf(self.activityId)
	local var_35_1 = (math.ceil(var_35_0.champions_num / 4) + 1) * 130

	self.championsLayout:setContentSize(550, var_35_1)

	for iter_35_0 = 1, var_35_0.champions_num do
		local var_35_2 = ccui.ImageView:create(var_0_6 .. "championIconBg.png", var_0_5)

		var_35_2:setTouchEnabled(true)
		var_35_2:setPosition((iter_35_0 - 1) % 4 * 130 + 75, var_35_1 - math.ceil(iter_35_0 / 4) * 130 + 70)
		self.championsLayout:addChild(var_35_2)

		local var_35_3, var_35_4 = self:updateChampionIcon(nil, var_35_0["champion_" .. iter_35_0])

		var_35_3:setPosition(50, 62)
		var_35_3:setScale(var_35_3:getScale() * 0.8)
		var_35_2:addChild(var_35_3)

		local var_35_5 = ccui.ImageView:create(var_0_6 .. "label_bg.png", var_0_5)

		var_35_5:setAnchorPoint(0, 0)
		var_35_2:addChild(var_35_5)

		local var_35_6 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_35_6:setString("x" .. var_35_4)
		var_35_6:setPosition(50, 12)
		var_35_5:addChild(var_35_6)
		var_35_2:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self:checkIsChosed(iter_35_0) then
				global_ShowBlockWords(L_COMMONFLOP_TEXT[5])

				return
			end

			self:choseChampionItem(iter_35_0)
		end)
	end
end

function CommonFlopLayer:updateChampionIcon(arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = drop_manager:getDropMsg(arg_37_2)
	local var_37_1
	local var_37_2

	if var_37_0.gold ~= 0 then
		var_37_1 = "gold"
		var_37_2 = var_37_0.gold
	elseif var_37_0.diamond ~= 0 then
		var_37_1 = "diamond"
		var_37_2 = var_37_0.diamond
	elseif var_37_0.equips then
		for iter_37_0, iter_37_1 in pairs(var_37_0.equips) do
			var_37_1 = iter_37_1.dropid
			var_37_2 = iter_37_1.dropNum
		end
	end

	arg_37_1 = arg_37_1 or ccui.ImageView:create(var_0_6 .. "championIconBg.png", var_0_5)

	if item_data[var_37_1].bag_item_type == kITEM_SKIN then
		arg_37_1:loadTexture("roleimage/role1/" .. model_data[item_data[var_37_1].model].cute_role .. ".png")
		arg_37_1:setScale(0.3)
	elseif item_data[var_37_1].bag_item_type == kITEM_HORCRUX then
		local var_37_4 = drop_manager:getAllDropsNotMerge(arg_37_2)[1].item_attr
		local var_37_5 = ccui.Layout:create()

		var_37_5:setName("starsPanel")
		var_37_5:setScale(1.75)
		var_37_5:setPositionY(58)
		var_37_5:setPositionX(200)
		arg_37_1:addChild(var_37_5, 5)

		local var_37_6 = 0

		if var_37_4 then
			for iter_37_2, iter_37_3 in var_37_4:gmatch("([^&]+)=([^&]+)") do
				if iter_37_2 == "star" then
					var_37_6 = tonumber(iter_37_3)
				end
			end
		end

		for iter_37_4 = 1, var_37_6 do
			local var_37_7

			if config._DEBUG then
				var_37_7 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_37_7:setPosition(25, (iter_37_4 - 1) * 24 - 30)
			var_37_5:addChild(var_37_7)
		end

		arg_37_1:loadTexture("equipment/" .. item_data[var_37_1].image_id .. ".png")
		arg_37_1:setScale(0.3)
	elseif item_data[var_37_1].bag_item_type == kITEM_COMPONENT then
		arg_37_1:removeFromParent()

		arg_37_1 = nil
		arg_37_1 = component_manager:create_component_icon(var_37_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		arg_37_1:setScale(0.75)
	else
		arg_37_1:loadTexture("equipment/" .. item_data[var_37_1].image_id .. ".png")
		arg_37_1:setScale(0.75)
	end

	arg_37_1:setTouchEnabled(arg_37_3)
	arg_37_1:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_37_1].bag_item_type == kITEM_HORCRUX then
			var_0_12(var_37_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_37_1
			})
		end
	end)

	return arg_37_1, var_37_2
end

function CommonFlopLayer:checkIsChosed(arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(self.championItems) do
		if iter_39_1.id == arg_39_1 then
			return true
		end
	end

	return false
end

function CommonFlopLayer:choseChampionItem(arg_40_1)
	for iter_40_0 = 1, 3 do
		if not self.championItems[iter_40_0] then
			self.championItems[iter_40_0] = {}
			self.championItems[iter_40_0].id = arg_40_1
			self.championItems[iter_40_0].order = 0

			self:updateMyChoseBg(self.championItems)

			return
		elseif self.championItems[iter_40_0].id == 0 and self.championItems[iter_40_0].order == 0 then
			self.championItems[iter_40_0].id = arg_40_1

			self:updateMyChoseBg(self.championItems)

			return
		end
	end

	global_ShowBlockWords(L_COMMONFLOP_TEXT[1])
end

function CommonFlopLayer:removeChampionItem(arg_41_1)
	if not self.championItems[arg_41_1] or self.championItems[arg_41_1].id == 0 then
		global_ShowBlockWords(L_COMMONFLOP_TEXT[2])

		return
	end

	if self.championItems[arg_41_1].order ~= 0 then
		global_ShowBlockWords(L_COMMONFLOP_TEXT[3])

		return
	end

	self.championItems[arg_41_1].id = 0

	self:updateMyChoseBg(self.championItems)
end

function CommonFlopLayer:setChampionItems(arg_42_1)
	local var_42_0 = {}

	for iter_42_0 = 1, 3 do
		if not arg_42_1[iter_42_0] or arg_42_1[iter_42_0].id == 0 then
			global_ShowBlockWords(L_COMMONFLOP_TEXT[4])

			return
		else
			table.insert(var_42_0, arg_42_1[iter_42_0].id)
		end
	end

	activity_manager:setCommonFlopChampionItems(self.activityId, var_42_0, function()
		global_ShowBlockWords(L_COMMONFLOP_TEXT[6])
		self.championLayer:setVisible(false)
	end)
end

function CommonFlopLayer:showGoNextTurnAni()
	local var_44_0 = activity_manager:getFlopMatrixConf(self.activityId)
	local var_44_1 = (self.cardTbl[1]:getPositionX() + self.cardTbl[var_44_0 * var_44_0]:getPositionX()) / 2
	local var_44_2 = (self.cardTbl[1]:getPositionY() + self.cardTbl[var_44_0 * var_44_0]:getPositionY()) / 2

	print(var_44_0, var_0_8, var_0_9, var_0_10, var_0_11, var_44_1, var_44_2)
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		for iter_45_0, iter_45_1 in pairs(self.cardTbl) do
			iter_45_1:runAction(cc.EaseBackIn:create(cc.MoveTo:create(0.2, cc.p(var_44_1, var_44_2))))
		end
	end), cc.DelayTime:create(0.25), cc.CallFunc:create(function()
		for iter_46_0 = 1, var_44_0 do
			for iter_46_1 = 1, var_44_0 do
				self.cardTbl[var_44_0 * (iter_46_0 - 1) + iter_46_1]:runAction(cc.EaseBackIn:create(cc.MoveTo:create(0.02 * (var_44_0 * (iter_46_0 - 1) + iter_46_1), cc.p(var_0_8 + (var_0_10 - var_0_8) / (var_44_0 - 1) * (iter_46_1 - 1), var_0_9 + (var_0_11 - var_0_9) / (var_44_0 - 1) * (iter_46_0 - 1)))))
			end
		end
	end), cc.DelayTime:create(0.7), cc.CallFunc:create(function()
		if not self.championLayer or not self.championLayer:isVisible() then
			self:initChampionChosePanel()
			global_ShowBlockWords("可以自选三个大奖哦~")
		end
	end)))
end

function CommonFlopLayer:updateTaskAlert()
	local var_48_0 = {
		x = 25,
		y = 90
	}

	activity_manager:getActivityObj(self.activityId):getActivityTaskList(nil, function(arg_49_0, arg_49_1)
		if arg_49_0 ~= 1 then
			return
		end

		for iter_49_0, iter_49_1 in pairs(arg_49_1.list) do
			if iter_49_1.status == 0 and iter_49_1.percent >= 100 then
				global_add_alert_tag(self.task_btn, var_48_0)
				activity_manager:updateActivityAlert("commonFlop", self.activityId, true)

				return
			end
		end

		global_remove_alert_tag(self.task_btn)
		activity_manager:updateActivityAlert("commonFlop", self.activityId, false)
	end, false, nil, "commonFlop")
end
