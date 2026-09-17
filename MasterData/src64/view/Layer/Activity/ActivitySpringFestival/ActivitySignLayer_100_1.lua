ActivitySignLayer_100_1 = class("ActivitySignLayer_100_1", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local var_0_5
local var_0_6 = config._DEBUG and 0 or 1

function ActivitySignLayer_100_1.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivitySignLayer_100_1.new()

	require("controller.texture_manager"):loadPopLayerTextures({
		"Activity_Spring_Festival_Activity_Sign"
	})
	var_2_0:init(arg_2_1)
	var_2_0:setName("ActivitySignLayer_100_1")

	return var_2_0
end

function ActivitySignLayer_100_1:init(arg_3_1)
	print("initparams =111 ", dump(arg_3_1))

	var_0_5 = true
	self.signTime = arg_3_1.signTime

	if self.signTime >= 7 and arg_3_1.isAutoPop then
		LayerManager:removePopLayer(self.__queueindex)

		return
	end

	self.signData = arg_3_1.signData
	self.signTag = arg_3_1.signTag
	self.callback = arg_3_1.callback
	self.activityId = arg_3_1.activityId
	self.otherData = arg_3_1.otherData
	self.auto = arg_3_1.auto
	self.activitySingCallback = arg_3_1.activitySingCallback
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_Sping_Sign.json" or "Activity_Sping_Sign.ExportJson")

	self:addChild(self.rootLayer)

	self.sign_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "sign_bg")
	self.awards_list = ccui.Helper:seekWidgetByName(self.rootLayer, "awards_list")
	self.button_next = ccui.Helper:seekWidgetByName(self.rootLayer, "button_next")
	self.button_last = ccui.Helper:seekWidgetByName(self.rootLayer, "button_last")
	self.button_sure = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")
	self.panel_item = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_item")
	self.label_sure = ccui.Helper:seekWidgetByName(self.rootLayer, "label_sure")
	self.image_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "image_bg")

	self.panel_item:setVisible(false)
	self.button_next:setVisible(false)
	self.button_last:setVisible(false)
	self.image_bg:setTouchEnabled(true)
	self.label_sure:setString(L_ACTIVITY_SIGN_BTN)

	local var_3_0 = 0

	for iter_3_0, iter_3_1 in pairs((require("data.activity_sign_data"))) do
		if iter_3_1.sign_id == "2-3" then
			var_3_0 = var_3_0 + 1
		end
	end

	if var_3_0 <= self.signTime then
		self.label_sure:setString(L_ACTIVITY_SIGN_END)
		self.button_sure:setBright(false)
		self.button_sure:loadTextures("public/button/public_button_white_long.png", nil, "public/button/public_button_white_long.png", var_0_6)
	elseif self:isCheckSignIn() then
		if self.signTag then
			self.button_sure:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_6)
			self.label_sure:setString(L_ACTIVITY_SIGN_FINISH)
			self.button_sure:setPressedActionEnabled(true)
			self.button_sure:setBright(false)
		else
			self.label_sure:setString(L_ACTIVITY_SIGN_BTN)
			self.button_sure:loadTextures("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_6)
		end
	end

	self:createSignBg()
	self:createLimitTime()
	self:createAwards()
	self:getAwards()
	self:registerActivityEventListener()
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exitCallback()
	end)
	self.button_sure:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.signTime > var_3_0 then
			global_ShowBlockWords(L_ACTIVITY_SIGN_CLOSE, nil, nil, 2)

			return
		end

		self.activitySingCallback(function(arg_6_0)
			if arg_6_0 == 1 then
				self:activitySign()
				AnalyticManager.signSpringFestival({
					count = self.signTime
				})
				activity_manager:updateActivityAlert("sign", self.activityId, false)
				activity_manager:fireEvent(activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT)
				self.label_sure:setString(L_ACTIVITY_SIGN_FINISH)
				self.button_sure:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_6)

				if self.signTime == var_3_0 then
					self.label_sure:setString(L_ACTIVITY_SIGN_END)
					self.button_sure:loadTextures("public/button/public_button_white_long.png", nil, "public/button/public_button_white_long.png", var_0_6)
				end

				self.button_sure:setBright(false)
			end
		end)
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivitySignLayer_100_1")

			if self.callback then
				self.callback()
			end

			var_0_5 = nil
		end
	end)
	self:fullScreen(self.rootLayer)
end

function ActivitySignLayer_100_1:isCheckSignIn()
	local var_8_0 = false

	if not self.signData or self.signData == "0" then
		return var_8_0
	else
		local var_8_1 = string_split(self.signData, "-")
		local var_8_2 = os.date("*t", math.floor((time_check_manager:getCurTime())))

		var_8_0 = tonumber(var_8_1[1]) == var_8_2.year and tonumber(var_8_1[2]) == var_8_2.month and tonumber(var_8_1[3]) == var_8_2.day
	end

	print("flag", var_8_0)

	return var_8_0
end

local function var_0_7(arg_9_0)
	local var_9_0

	if config._DEBUG then
		var_9_0 = cc.Sprite:create("Activity_Spring_Festival/Activity_Sign/item_bg.png") or cc.Sprite:createWithSpriteFrameName("Activity_Spring_Festival/Activity_Sign/item_bg.png")
	end

	var_9_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_0:setScale(arg_9_0:getContentSize().width * 0.95 / var_9_0:getContentSize().width)
	var_9_0:setPosition(cc.p(arg_9_0:getContentSize().width / 2, arg_9_0:getContentSize().height / 2 + 20))
	arg_9_0:addChild(var_9_0)
end

function ActivitySignLayer_100_1:createSignBg()
	self.sign_bg:loadTexture("mainScenebg/activity/" .. self.otherData.path .. "/sign_bg.png")
	self.sign_bg:setPosition(cc.p(280, 495))
end

function ActivitySignLayer_100_1:createLimitTime()
	local var_11_0 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_11_0:setAnchorPoint(cc.p(1, 0))
	var_11_0:setPosition(cc.p(540, 766))
	var_11_0:setColor(cc.c3b(143, 174, 189))
	self.image_bg:addChild(var_11_0)

	local var_11_1 = math.ceil((global_get_time_by_date(self.otherData.endTime) - os.time()) / 86400)

	if var_11_1 >= 0 then
		var_11_0:setString(string.format(L_ACTIVITY_REST_TIME, var_11_1))
	else
		var_11_0:setString(L_ACTIVITY_END)
	end

	var_11_0:setVisible(false)
end

function ActivitySignLayer_100_1.registerActivityEventListener(arg_12_0)
	activity_manager:registerEventListener("ActivitySignLayer_100_1", activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_13_0)
		arg_12_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			arg_12_0:exitCallback()
		end)))
	end)
end

function ActivitySignLayer_100_1:createAwards()
	local var_15_0 = self.panel_item:getContentSize().width + 10
	local var_15_2 = 1

	while self.otherData.drops[var_15_2] do
		local var_15_3 = self.panel_item:clone()

		var_15_3:setVisible(true)
		var_15_3:setAnchorPoint(cc.p(0, 0.5))
		var_15_3:setPosition(cc.p(0 + (var_15_2 - 1) * var_15_0, 80))
		var_15_3:setName("award" .. var_15_2)
		ccui.Helper:seekWidgetByName(var_15_3, "Label_day"):setString("第" .. L_NUMBER_TEXT[var_15_2] .. "天")
		self.awards_list:addChild(var_15_3)

		local var_15_4
		local var_15_5

		if drop_data[self.otherData.drops[var_15_2]].drop_id1 then
			var_15_5 = drop_data[self.otherData.drops[var_15_2]].drop_num1
			var_15_4 = drop_data[self.otherData.drops[var_15_2]].drop_id1
		elseif drop_data[self.otherData.drops[var_15_2]].diamond then
			var_15_5 = drop_data[self.otherData.drops[var_15_2]].diamond
			var_15_4 = "diamond"
		elseif drop_data[self.otherData.drops[var_15_2]].gold then
			var_15_5 = drop_data[self.otherData.drops[var_15_2]].gold
			var_15_4 = "gold"
		end

		local var_15_6 = ItemSprite:createSignNewWithItemId(var_15_4, var_15_5, nil, nil, nil, 1)

		var_15_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_6:setPosition(cc.p(var_15_3:getContentSize().width / 2, var_15_3:getContentSize().height / 2 + 20))
		var_15_3:addChild(var_15_6)
		var_15_6:setScale(0.65)

		var_15_3.itemid = var_15_4

		if var_15_4 ~= "gold" and var_15_4 ~= "diamond" then
			var_15_3.item_type = "item"
		end

		var_15_3:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showAwardsDetails(arg_16_0.itemid, arg_16_0.item_type)
		end)

		var_15_2 = var_15_2 + 1
	end

	if var_15_2 - 1 > 4 then
		self.awards_list:setInnerContainerSize(cc.size(var_15_0 * (var_15_2 - 1) + 10, 160))
	else
		self.awards_list:setInnerContainerSize(cc.size(500, 160))
	end

	local var_15_7 = self.awards_list:getContentSize().width
	local var_15_8 = self.awards_list:getInnerContainerSize().width
end

function ActivitySignLayer_100_1:getAwards()
	local function var_19_0(arg_20_0)
		local var_20_0

		if config._DEBUG then
			var_20_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
		end

		var_20_0:setScale(0.7)
		var_20_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_20_0:setPosition(cc.p(arg_20_0:getContentSize().width * 3 / 4 - 10, arg_20_0:getContentSize().height / 4))
		arg_20_0:addChild(var_20_0, 10)
		var_0_7(arg_20_0)
	end

	local var_19_1 = self.awards_list:getContentSize().width
	local var_19_2 = self.awards_list:getInnerContainerSize().width

	if self.signTime >= 4 then
		(function()
			local var_21_0 = self.awards_list:getInnerContainer()
			local var_21_1 = math.abs((var_21_0:getPositionX()))
			local var_21_2 = (var_21_0 + (0.9 + 0.28 * (self.signTime - 2.8)) * var_19_1) / var_19_2

			if (var_21_0 + (0.9 + 0.28 * (self.signTime - 2.8)) * var_19_1) / var_19_2 > 1 then
				var_21_2 = 1
			end

			if var_21_2 >= 0 and var_21_2 <= 1 then
				self.awards_list:scrollToPercentHorizontal(var_21_2 * 100, 0.2, false)
			end
		end)()
	end

	while 1 <= self.signTime do
		var_19_0((self.awards_list:getChildByName("award" .. 1)))
	end
end

function ActivitySignLayer_100_1:activitySign()
	if self.signTag == true then
		local var_22_0 = self.awards_list:getChildByName("award" .. self.signTime + 1)

		;(function(arg_23_0)
			local var_23_0

			if config._DEBUG then
				var_23_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
			end

			var_23_0:setScale(3.5)
			var_23_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_23_0:setPosition(cc.p(arg_23_0:getContentSize().width * 3 / 4 - 10, arg_23_0:getContentSize().height / 4))
			var_23_0:setName("success")
			arg_23_0:addChild(var_23_0, 10)
			var_0_7(arg_23_0)
			var_23_0:runAction(cc.ScaleTo:create(0.5, 0.7))
		end)(var_22_0)

		if var_22_0.itemid ~= "gold" and var_22_0.itemid ~= "diamond" and item_data[var_22_0.itemid].bag_item_type == kITEM_HERO then
			require("view.Layer.GetRoleAnimationLayer")
			cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_22_0.itemid), 999)
		end
	end
end

function ActivitySignLayer_100_1:exitCallback()
	LayerManager:removePopLayer(self.__queueindex)
end

function ActivitySignLayer_100_1:showAwardsDetails(arg_25_1, arg_25_2)
	if arg_25_2 == "item" then
		if item_data[arg_25_1].bag_item_type == kITEM_HORCRUX then
			local var_25_0 = -1
			local var_25_1 = require("data.horcrux_data")[arg_25_1].horcruxtype

			for iter_25_0, iter_25_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_25_1 == iter_25_1.item_id then
					var_25_0 = iter_25_0

					break
				end
			end

			if var_25_0 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_25_0,
				itemid = arg_25_1,
				callback = callback
			})
		elseif item_data[arg_25_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showListButton = true,
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_25_1].servant
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_25_2 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_25_1
			})
		end
	elseif arg_25_2 == "gold" then
		-- block empty
	elseif arg_25_2 == "diamond" then
		-- block empty
	end
end

function ActivitySignLayer_100_1.fullScreen(arg_26_0, arg_26_1)
	arg_26_1:setContentSize((GameDisplay.getScreenSize()))
	arg_26_1:setPositionY(arg_26_1:getPositionY() - GameDisplay.fix_y)
	arg_26_1:getChildByName("image_bg"):setPositionY(arg_26_1:getChildByName("image_bg"):getPositionY() + GameDisplay.fix_y)
	arg_26_1:getChildByName("button_sure"):setPositionY(arg_26_1:getChildByName("button_sure"):getPositionY() + GameDisplay.fix_y)
end

function ActivitySignLayer_100_1:exit()
	self:exitCallback()
end
