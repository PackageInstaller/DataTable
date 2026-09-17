CommonRouletteLayer = class("CommonRouletteLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.CommonSlotMachineSprite")

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local var_0_7 = "ActivityRoulette_731/"

function CommonRouletteLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CommonRouletteLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function CommonRouletteLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId or 731
	var_0_7 = "ActivityRoulette_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		"ActivityRoulette_" .. self.activityId
	})

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/routtle_bg.jpg")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and ("ActivityRoulette_" .. self.activityId .. ".json" or "ActivityRoulette_" .. self.activityId .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getRouletteInfo(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			activity_manager:releaseEventListenerByName(self._imagePath)
			activity_manager:updateActivityAlert("roulette", self.activityId, item_manager:getItemNumber((activity_manager:getRouletteNeedItem(self.activityId))) > 0)
			TextureManager:removeLayerTextures({
				"ActivityRoulette_" .. self.activityId
			})
		end
	end)
	activity_manager:get_commonroulette_special_drop(self.activityId, function()
		self:initChampionChosePanel()
	end)
	self:updateTaskAlert()
end

function CommonRouletteLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_7_0)
		self:updateCurrencyNum()
	end)
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ROULETTE_INFO_UPDATE, function(arg_8_0)
		self:updateTimeTitle()
		self:updateCurrencyNum()
	end)
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ROULETTE_LIMIT_BUY, function(arg_9_0)
		self:updateCurrencyNum()
	end)
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.GET_ACTIVITY_SHOP_ITEM, function(arg_10_0)
		self:updateCurrencyNum()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_11_0)
		self:updateCurrencyNum()
	end), self)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_12_0)
		self:updateTaskAlert()
	end)
end

function CommonRouletteLayer:initUI()
	self:initBottomList()
	self:initTitle()
	self:initSlotMachine()
	self:initCommonNewUI()
	self:playJoinEffect()
end

function CommonRouletteLayer:initBottomList()
	local var_14_0 = self.rootLayer:getChildByName("return_bg")

	self.btnReturn = var_14_0:getChildByName("btn_return")

	self.btnReturn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.slotMachineSprite.isplay then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.btnCost = var_14_0:getChildByName("btn_cost")
	self.btnadd = ccui.Helper:seekWidgetByName(var_14_0, "+")

	self.btnCost:setTouchEnabled(true)

	local function var_14_1(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0 = activity_manager:canBuyRouletteCurrency(self.activityId)

		if var_16_0 and var_16_0 < 0 then
			LayerManager:pushInLayer("PopActivityItemGainLayer", {
				activityId = self.activityId
			})

			return
		elseif var_16_0 then
			goto_complete_system({
				jump_to_system = var_16_0
			})

			return
		end

		LayerManager:pushInLayer("PopRouletteBuyLayer", {
			activityId = self.activityId
		})
	end

	self.btnadd:addTouchEventListener(var_14_1)
	self.btnCost:addTouchEventListener(var_14_1)

	self.lblHasNum = self.btnCost:getChildByName("lblHasNum")

	var_14_0:setPositionY(-GameDisplay.fix_y)

	self.btnTask = ccui.Helper:seekWidgetByName(self.rootLayer, "task")

	if self.btnTask then
		self.btnTask:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopRouletteTaskLayer", {
				activityId = self.activityId
			})
		end)
	end
end

local function var_0_8(arg_18_0)
	if arg_18_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_18_0 / 86400), math.floor(arg_18_0 % 86400 / 3600))
	elseif arg_18_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_18_0 / 3600), math.floor(arg_18_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[3], math.floor(arg_18_0 / 60), math.floor(arg_18_0 % 60))
	end
end

function CommonRouletteLayer:initTitle()
	local var_19_0 = self.rootLayer:getChildByName("img_title")

	var_19_0:setTouchEnabled(true)
	var_19_0:setPositionY(var_19_0:getPositionY() + GameDisplay.fix_y)
	var_19_0:addTouchEventListener(function(arg_20_0, arg_20_1)
		local var_20_0

		if arg_20_1 ~= ccui.TouchEventType.ended then
			do return end

			var_20_0 = {}
		end

		var_20_0.key = self.activityId == 731 and "commonRoulette" or "ActivityRouletteLayer_" .. self.activityId

		LayerManager:pushInLayer("PopActivityDetail", var_20_0)
	end)

	self.timeLbl = self.rootLayer:getChildByName("timeLbl")

	self.timeLbl:retain()
	self.timeLbl:setPositionY(self.timeLbl:getPositionY() + GameDisplay.fix_y)
end

function CommonRouletteLayer:updateTimeTitle()
	if self.activityScheduler then
		time_check_manager:removeUpdatePool(self.activityScheduler)

		self.activityScheduler = nil
	end

	local var_21_0 = activity_manager:getCurphase(self.activityId)
	local var_21_1 = activity_manager:getRouletteEndTime(self.activityId)

	if not var_21_1 then
		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_21_1, function(arg_22_0)
		self.timeLbl:setString(L_ROULETTE_PHASE .. L_LEFT_TIME_SPACE .. var_0_8(arg_22_0))

		if arg_22_0 <= 0 and self.activityScheduler then
			self.timeLbl:setVisible(false)
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function CommonRouletteLayer:updateCurrencyNum()
	self.lblHasNum:setString(item_manager:getItemNumber((activity_manager:getRouletteNeedItem(self.activityId))))
end

function CommonRouletteLayer:initSlotMachine()
	local var_24_0, var_24_1 = activity_manager:getRouletteSize(self.activityId)

	self.slotMachineSprite = CommonSlotMachineSprite:create(var_24_0, var_24_1, self.activityId, self.rootLayer:getChildByName("slotMachineSprite"))

	self.slotMachineSprite.rootLayer:setPosition(0, self.slotMachineSprite.rootLayer:getPositionY() - 50)
	self.rootLayer:addChild(self.slotMachineSprite)
end

function CommonRouletteLayer:playJoinEffect()
	self.btnReturn:setPositionX(self.btnReturn:getPositionX() + 600)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.4, cc.p(-610, 0)), cc.MoveBy:create(0.05, cc.p(10, 0))))
	self.btnCost:setPositionX(self.btnCost:getPositionX() + 200)
	self.btnCost:runAction(cc.Sequence:create(cc.EaseExponentialIn:create(cc.MoveBy:create(0.3, cc.p(-200, 0)))))
end

function CommonRouletteLayer:playOutEffect(arg_26_1)
	self.isShowEffect = true

	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_26_1 then
			arg_26_1()
		end

		self.isShowEffect = nil
	end)))
	self.btnCost:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, -200))))
end

function CommonRouletteLayer:initCommonNewUI()
	local var_28_0 = self.rootLayer:getChildByName("img_title")

	var_28_0:setAnchorPoint(0, 1)
	var_28_0:setPosition(0, GameDisplay.height - GameDisplay.fix_y)

	self.task_btn = ccui.Button:create(var_0_7 .. "task_btn.png", nil, var_0_7 .. "task_btn.png", var_0_0)

	self.rootLayer:addChild(self.task_btn)
	self.task_btn:setAnchorPoint(1, 1)
	self.task_btn:setPosition(GameDisplay.width, GameDisplay.height - GameDisplay.fix_y)

	self.more_btn = ccui.Button:create(var_0_7 .. "more_btn.png", nil, var_0_7 .. "more_btn.png", var_0_0)

	self.rootLayer:addChild(self.more_btn)
	self.more_btn:setAnchorPoint(1, 1)
	self.more_btn:setPosition(GameDisplay.width, GameDisplay.height - 100 - GameDisplay.fix_y)

	self.exchange_btn = ccui.Button:create(var_0_7 .. "exchange_btn.png", nil, var_0_7 .. "exchange_btn.png", var_0_0)

	self.rootLayer:addChild(self.exchange_btn)
	self.exchange_btn:setAnchorPoint(0, 1)
	self.exchange_btn:setPosition(0, GameDisplay.height - 200 - GameDisplay.fix_y)

	self.champion_btn = ccui.Button:create(var_0_7 .. "champion_btn.png", nil, var_0_7 .. "champion_btn.png", var_0_0)

	self.rootLayer:addChild(self.champion_btn)
	self.champion_btn:setAnchorPoint(1, 1)
	self.champion_btn:setPosition(GameDisplay.width, GameDisplay.height - 200 - GameDisplay.fix_y)
	self.champion_btn:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:initChampionChosePanel()
	end)
	self.task_btn:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopCommonTaskLayer", {
			usemodule = "commonRoulette",
			activityId = self.activityId
		})
	end)
	self.more_btn:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_31_0 = activity_manager:canBuyRouletteCurrency(self.activityId)

		if var_31_0 and var_31_0 < 0 then
			LayerManager:pushInLayer("PopActivityItemGainLayer", {
				activityId = self.activityId
			})

			return
		elseif var_31_0 then
			goto_complete_system({
				jump_to_system = var_31_0
			})

			return
		end

		LayerManager:pushInLayer("PopRouletteBuyLayer", {
			activityId = self.activityId
		})
	end)
	self.exchange_btn:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_32_0(arg_33_0)
			local var_33_0 = {
				"1-" .. tonumber(arg_33_0) % 1500000
			}

			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = var_33_0,
				showType = var_33_0[1]
			})
		end

		local var_32_2 = self.activityId == 731 and "1573101" or activity_manager:getRouletteShopJump(self.activityId)

		hx_print(var_32_2)
		var_32_0(var_32_2)
	end)
end

function CommonRouletteLayer:updateChampionIcon(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = drop_manager:getDropMsg(arg_34_2)
	local var_34_1
	local var_34_2

	if var_34_0.gold ~= 0 then
		var_34_1 = "gold"
		var_34_2 = var_34_0.gold
	elseif var_34_0.diamond ~= 0 then
		var_34_1 = "diamond"
		var_34_2 = var_34_0.diamond
	elseif var_34_0.equips then
		for iter_34_0, iter_34_1 in pairs(var_34_0.equips) do
			var_34_1 = iter_34_1.dropid
			var_34_2 = iter_34_1.dropNum
		end
	end

	arg_34_1 = arg_34_1 or ccui.ImageView:create(var_0_7 .. "championIconBg.png", var_0_0)

	if item_data[var_34_1].bag_item_type == kITEM_SKIN then
		arg_34_1:loadTexture("roleimage/role1/" .. model_data[item_data[var_34_1].model].cute_role .. ".png")
		arg_34_1:setScale(0.3)
	elseif item_data[var_34_1].bag_item_type == kITEM_HORCRUX then
		local var_34_4 = drop_manager:getAllDropsNotMerge(arg_34_2)[1].item_attr
		local var_34_5 = ccui.Layout:create()

		var_34_5:setName("starsPanel")
		var_34_5:setScale(1.75)
		var_34_5:setPositionY(58)
		var_34_5:setPositionX(200)
		arg_34_1:addChild(var_34_5, 5)

		local var_34_6 = 0

		if var_34_4 then
			for iter_34_2, iter_34_3 in var_34_4:gmatch("([^&]+)=([^&]+)") do
				if iter_34_2 == "star" then
					var_34_6 = tonumber(iter_34_3)
				end
			end
		end

		for iter_34_4 = 1, math.min(5, var_34_6) do
			local var_34_7

			if config._DEBUG then
				var_34_7 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_34_7:setPosition(15, (iter_34_4 - 1) * 24 - 15)
			var_34_5:addChild(var_34_7)
			var_34_7:setName("star_" .. iter_34_4)
		end

		for iter_34_5 = 1, var_34_6 - 5 do
			local var_34_8 = var_34_5:getChildByName("star_" .. 6 - iter_34_5)
			local var_34_9 = 15
			local var_34_10 = (6 - iter_34_5 - 1) * 24 - 15
			local var_34_11

			if config._DEBUG then
				var_34_11 = cc.Sprite:create("public/currency/pink_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/pink_star.png")
			end

			var_34_11:setPosition(var_34_9, var_34_10)
			var_34_5:addChild(var_34_11)
			var_34_11:setName("star_" .. 6 - iter_34_5)
			var_34_8:removeFromParent()
		end

		arg_34_1:loadTexture("equipment/" .. item_data[var_34_1].image_id .. ".png")
		arg_34_1:setScale(0.45)
	elseif item_data[var_34_1].bag_item_type == kITEM_COMPONENT then
		arg_34_1:removeFromParent()

		arg_34_1 = nil
		arg_34_1 = componentManager:create_component_icon(var_34_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		arg_34_1:setScale(0.75)
	else
		arg_34_1:loadTexture("equipment/" .. item_data[var_34_1].image_id .. ".png")
		arg_34_1:setScale(0.75)
	end

	arg_34_1:setTouchEnabled(arg_34_3)
	arg_34_1:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_34_1].bag_item_type == kITEM_HORCRUX then
			showHorcruxDetails(var_34_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_34_1
			})
		end
	end)

	return arg_34_1, var_34_2, item_data[var_34_1].bag_item_type
end

function CommonRouletteLayer:initChampionChosePanel()
	if not self.championLayer then
		local var_36_0 = ccui.Layout:create()

		var_36_0:setContentSize(cc.size(640, 1600))
		var_36_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_36_0:setCascadeOpacityEnabled(false)
		var_36_0:setBackGroundColorOpacity(182)
		var_36_0:setAnchorPoint(0.5, 0.5)
		var_36_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_36_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_36_0:setTouchEnabled(true)
		var_36_0:setLocalZOrder(1000)
		var_36_0:setVisible(true)
		self.rootLayer:addChild(var_36_0)

		self.championLayer = var_36_0

		local var_36_1 = ccui.ImageView:create(var_0_7 .. "champion_choose_bg.png", var_0_0)

		var_36_1:setPosition(320, 900)
		var_36_0:addChild(var_36_1)

		local var_36_2 = {
			110,
			240,
			370,
			500
		}

		for iter_36_0, iter_36_1 in ipairs(var_36_2) do
			local var_36_3 = ccui.ImageView:create(var_0_7 .. "championIconBg.png", var_0_0)

			var_36_3:setTouchEnabled(true)
			var_36_3:setPosition(var_36_2[iter_36_0], 165)
			var_36_1:addChild(var_36_3)

			local var_36_4 = ccui.ImageView:create(var_0_7 .. "add.png", var_0_0)

			var_36_4:setPosition(52, 60)
			var_36_4:setScale(1.5)
			var_36_3:addChild(var_36_4)
			var_36_3:setName("myChampion_" .. iter_36_0)
			var_36_3:addTouchEventListener(function(arg_37_0, arg_37_1)
				if arg_37_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:removeChampionItem(iter_36_0)
			end)
		end

		local var_36_5 = ccui.Button:create(var_0_7 .. "cancel_btn.png", nil, var_0_7 .. "cancel_btn.png", var_0_0)

		var_36_5:setPosition(180, 60)
		var_36_1:addChild(var_36_5)
		var_36_5:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_36_0:setVisible(false)
		end)

		local var_36_6 = ccui.Button:create(var_0_7 .. "sure_btn.png", nil, var_0_7 .. "sure_btn.png", var_0_0)

		var_36_6:setPosition(420, 60)
		var_36_1:addChild(var_36_6)
		var_36_6:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:setChampionItems(self.championItems)
		end)

		self.myChoseBg = var_36_1

		local var_36_7 = ccui.ImageView:create(var_0_7 .. "jiange.png", var_0_0)

		var_36_7:setPosition(320, 640)
		var_36_0:addChild(var_36_7)

		self.championItemsPanel = ccui.ImageView:create(var_0_7 .. "can_choose_bg.png", var_0_0)

		self.championItemsPanel:setPosition(320, 400)
		var_36_0:addChild(self.championItemsPanel)

		local var_36_8 = ccui.ListView:create()

		var_36_8:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_36_8:setBounceEnabled(true)
		var_36_8:setContentSize(550, 330)
		var_36_8:setPosition(310, 190)
		var_36_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_36_8:setItemsMargin(0.1)
		self.championItemsPanel:addChild(var_36_8)

		self.championsLayout = ccui.Layout:create()

		self.championsLayout:setContentSize(550, 200)
		var_36_8:pushBackCustomItem(self.championsLayout)
	end

	self.championLayer:setVisible(true)

	self.championItems = clone(activity_manager:getCommonRouletteSpecailDrop(self.activityId)) or {}

	self:updateMyChoseBg(self.championItems)
	self:updateChampionChosePanel()
end

function CommonRouletteLayer:updateChampionChosePanel()
	self.championsLayout:removeAllChildren()

	local var_40_0 = activity_manager:getCommonSpecialDropids(self.activityId)
	local var_40_1 = (math.ceil(#var_40_0 / 4) + 1) * 130

	self.championsLayout:setContentSize(550, var_40_1)

	for iter_40_0 = 1, #var_40_0 do
		local var_40_2 = ccui.ImageView:create(var_0_7 .. "championIconBg.png", var_0_0)

		var_40_2:setTouchEnabled(true)
		var_40_2:setPosition((iter_40_0 - 1) % 4 * 130 + 75, var_40_1 - math.ceil(iter_40_0 / 4) * 130 + 70)
		self.championsLayout:addChild(var_40_2)

		local var_40_3, var_40_4, var_40_5 = self:updateChampionIcon(nil, var_40_0[iter_40_0])

		var_40_3:setPosition(50, 62)

		if var_40_5 == kITEM_SKIN then
			var_40_3:setPosition(45, 75)
		end

		var_40_3:setScale(var_40_3:getScale() * 0.8)
		var_40_2:addChild(var_40_3)

		local var_40_6 = ccui.ImageView:create(var_0_7 .. "label_bg.png", var_0_0)

		var_40_6:setAnchorPoint(0, 0)
		var_40_2:addChild(var_40_6)

		local var_40_7 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_40_7:setString("x" .. var_40_4)
		var_40_7:setPosition(50, 12)
		var_40_6:addChild(var_40_7)
		var_40_2:addTouchEventListener(function(arg_41_0, arg_41_1)
			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self:checkIsChosed(iter_40_0) then
				global_ShowBlockWords(L_COMMONROULETTE_TEXT[1])

				return
			end

			self:choseChampionItem(iter_40_0)
		end)
	end
end

function CommonRouletteLayer:choseChampionItem(arg_42_1)
	for iter_42_0 = 1, 4 do
		if not self.championItems[iter_42_0] then
			self.championItems[iter_42_0] = arg_42_1

			self:updateMyChoseBg(self.championItems)

			return
		elseif self.championItems[iter_42_0] == 0 then
			self.championItems[iter_42_0] = arg_42_1

			self:updateMyChoseBg(self.championItems)

			return
		end
	end

	global_ShowBlockWords(L_COMMONROULETTE_TEXT[2])
end

function CommonRouletteLayer:updateMyChoseBg(arg_43_1)
	for iter_43_0 = 1, 4 do
		local var_43_0 = self.myChoseBg:getChildByName("myChampion_" .. iter_43_0)

		if not arg_43_1[iter_43_0] or arg_43_1[iter_43_0] == 0 then
			var_43_0:removeAllChildren()

			local var_43_1 = ccui.ImageView:create(var_0_7 .. "add.png", var_0_0)

			var_43_1:setPosition(52, 60)
			var_43_1:setScale(1.5)
			var_43_0:addChild(var_43_1)
		else
			var_43_0:removeAllChildren()

			local var_43_2, var_43_3, var_43_4 = self:updateChampionIcon(nil, (activity_manager:getCommonDropById(self.activityId, arg_43_1[iter_43_0])))

			var_43_2:setPosition(50, 62)

			if var_43_4 == kITEM_SKIN then
				var_43_2:setPosition(45, 75)
			end

			var_43_2:setScale(var_43_2:getScale() * 0.8)
			var_43_0:addChild(var_43_2)

			local var_43_5 = ccui.ImageView:create(var_0_7 .. "label_bg.png", var_0_0)

			var_43_5:setAnchorPoint(0, 0)
			var_43_0:addChild(var_43_5)

			local var_43_6 = cc.Label:createWithTTF("", FONT_DES, 20)

			var_43_6:setString("x" .. var_43_3)
			var_43_6:setPosition(50, 12)
			var_43_5:addChild(var_43_6)
		end
	end
end

function CommonRouletteLayer:checkIsChosed(arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(self.championItems) do
		if iter_44_1 == arg_44_1 then
			return true
		end
	end

	return false
end

function CommonRouletteLayer:removeChampionItem(arg_45_1)
	if not self.championItems[arg_45_1] or self.championItems[arg_45_1] == 0 then
		global_ShowBlockWords(L_COMMONROULETTE_TEXT[3])

		return
	end

	self.championItems[arg_45_1] = 0

	self:updateMyChoseBg(self.championItems)
end

function CommonRouletteLayer:setChampionItems(arg_46_1)
	local var_46_0 = {}

	for iter_46_0 = 1, 4 do
		if not arg_46_1[iter_46_0] or arg_46_1[iter_46_0] == 0 then
			global_ShowBlockWords(L_COMMONROULETTE_TEXT[4])

			return
		else
			table.insert(var_46_0, arg_46_1[iter_46_0])
		end
	end

	activity_manager:set_commonroulette_special_drop(self.activityId, var_46_0, function()
		self.championLayer:setVisible(false)
	end)
end

function CommonRouletteLayer:updateTaskAlert()
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
				activity_manager:updateActivityAlert("commonRoulette", self.activityId, true)

				return
			end
		end

		global_remove_alert_tag(self.task_btn)
		activity_manager:updateActivityAlert("commonRoulette", self.activityId, false)
	end, false, nil, "commonRoulette")
end
