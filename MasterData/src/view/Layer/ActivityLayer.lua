ActivityLayer = class("ActivityLayer", function()
	return cc.Layer:create()
end)

require("config")

local network = require("network.network")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local parse_server = require("controller.parse_server")
local account_manager = require("controller.account_manager")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_13 = 4
local var_0_14 = "18000001"
local var_0_15 = "18000002"
local var_0_16 = "18000003"
local var_0_17 = "18000004"
local var_0_18 = "mainScenebg/normal_activity/recharge_bg.png"
local var_0_19 = "mainScenebg/normal_activity/first_bg.png"
local var_0_22

function ActivityLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLayer.new()

	var_2_0:initBg(arg_2_1.paneltype, arg_2_1.callback)

	return var_2_0
end

function ActivityLayer:init(arg_3_1, arg_3_2)
	var_0_22 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity.json" or "Activity.ExportJson")

	self:addChild(self.rootLayer, 2)

	local var_3_0 = cc.EventCustom:new("switchListButtons")

	var_3_0.bVisible = false
	var_3_0.bg = 2

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_3_0)
	LayerManager:createFullScreenMask(self, nil, function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, ccui.LayoutBackGroundColorType.none)

	local var_3_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "frame_detail")

	var_3_1:loadTexture(var_0_19)
	var_3_1:setTouchEnabled(true)

	self.dropitems = {}

	for iter_3_0 = 1, 6 do
		self.dropitems[iter_3_0] = ccui.Helper:seekWidgetByName(var_3_1, "equip_" .. iter_3_0)

		self.dropitems[iter_3_0]:setPosition(cc.p(self.dropitems[iter_3_0]:getPositionX() + 280, self.dropitems[iter_3_0]:getPositionY() + 260))
		self.dropitems[iter_3_0]:setOpacity(0)
		self.dropitems[iter_3_0]:setCascadeOpacityEnabled(false)
		self.dropitems[iter_3_0]:addTouchEventListener(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_5_0.id then
				return
			end

			self:showItemDetails(arg_5_0.id)
		end)
	end

	self.confirmButton = ccui.Helper:seekWidgetByName(var_3_1, "button_charge")

	self.confirmButton:setPositionX(self.confirmButton:getPositionX() + 180)
	self.confirmButton:getChildByName("label"):setPosition(cc.p(self.confirmButton:getContentSize().width / 2, self.confirmButton:getContentSize().height / 2 + 5))
	self.confirmButton:setPosition(cc.p(self.confirmButton:getPositionX() + 280, self.confirmButton:getPositionY() + 260))

	if arg_3_1 == var_0_10 then
		var_3_1:loadTexture(var_0_18)
		var_3_1:setPositionY(var_3_1:getPositionY() + 20)

		for iter_3_1 = 1, 6 do
			self.dropitems[iter_3_1]:setPositionY(self.dropitems[iter_3_1]:getPositionY() - 65)
			self.dropitems[iter_3_1]:setScale(0.5)

			if iter_3_1 == 1 then
				self.dropitems[iter_3_1]:setPositionX(self.dropitems[1]:getPositionX() + 40 + 12)
			elseif iter_3_1 >= 2 and iter_3_1 <= 3 then
				self.dropitems[iter_3_1]:setPositionX(self.dropitems[1]:getPositionX() + 95 * (iter_3_1 - 1))
			elseif iter_3_1 == 4 then
				self.dropitems[iter_3_1]:setPositionX(self.dropitems[4]:getPositionX() + 40 + 12)
			else
				self.dropitems[iter_3_1]:setPositionX(self.dropitems[4]:getPositionX() + 95 * (iter_3_1 - 4))
			end
		end

		self.confirmButton:setPositionY(self.confirmButton:getPositionY() - 65)
	end

	self.frameback = var_3_1

	global_window_open_action(var_3_1)
	self:hideItems()
	self:showPanel(arg_3_1)
	self:firstSwitchpanel(arg_3_1)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if arg_3_2 then
				arg_3_2()
			end

			TextureManager:unregisterTexture("ActivityLayer")

			var_0_22 = nil
		end
	end)
end

function ActivityLayer.firstSwitchpanel(arg_7_0, arg_7_1)
	for iter_7_0 = 1, 1 do
		network:rpc("get_activity_info", {
			panel = iter_7_0,
			channel = config.packagechannel
		}, function(arg_8_0)
			if not var_0_22 then
				return
			end

			if iter_7_0 == arg_7_1 then
				arg_7_0:initPanel(arg_7_1, arg_8_0.result)
			end
		end)
	end
end

function ActivityLayer.showPanel(arg_9_0, arg_9_1)
	network:rpc("get_activity_info", {
		panel = arg_9_1,
		channel = config.packagechannel
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			arg_9_0:initPanel(arg_9_1, 1)
		elseif arg_10_0.result == 2 then
			arg_9_0:initPanel(arg_9_1, 2)
		elseif arg_10_0.result == 3 then
			arg_9_0:initPanel(arg_9_1, 3)
		elseif arg_10_0.result == 4 then
			arg_9_0:initPanel(arg_9_1, 4)
		elseif arg_10_0.result == 5 then
			l2Log("get account info fail")
			arg_9_0:initPanel(arg_9_1, 2)
		elseif arg_10_0.result == 0 then
			l2Log("get account info fail")
		end
	end)
end

function ActivityLayer:hideItems()
	for iter_11_0 = 1, 6 do
		self.dropitems[iter_11_0]:setVisible(false)
	end

	self.confirmButton:setVisible(false)
end

function ActivityLayer:showItems(arg_12_1)
	for iter_12_0 = 1, self.awardsNum do
		self.dropitems[iter_12_0]:setVisible(true)
	end

	if arg_12_1 then
		self.confirmButton:setVisible(true)
	end
end

function ActivityLayer:initPanel(arg_13_1, arg_13_2)
	if arg_13_1 == var_0_10 then
		self:initRechargePanel(arg_13_2)
	elseif arg_13_1 == var_0_11 then
		self:initAccountPanel(arg_13_2)
	elseif arg_13_1 == var_0_12 then
		self:initPhonePanel(arg_13_2)
	elseif arg_13_1 == var_0_13 then
		self:initFirstOpenPanel(arg_13_2)
	end
end

function ActivityLayer:initRechargePanel(arg_14_1)
	local var_14_0 = {}

	while drop_data[var_0_14]["drop_id" .. 1] do
		table.insert(var_14_0, {
			dropid = drop_data[var_0_14]["drop_id" .. 1],
			dropNum = drop_data[var_0_14]["drop_num" .. 1],
			itemattr = drop_data[var_0_14]["drop_extra" .. 1]
		})
	end

	if drop_data[var_0_14].diamond then
		table.insert(var_14_0, {
			diamond = drop_data[var_0_14].diamond
		})
	end

	for iter_14_0 = 1, #var_14_0 do
		if self.dropitems[iter_14_0].sp then
			self.dropitems[iter_14_0].sp:removeFromParent()

			self.dropitems[iter_14_0].sp = nil
		end

		if var_14_0[iter_14_0].diamond then
			local var_14_2 = ItemSprite:createNewWithItemId("diamond", var_14_0[iter_14_0].diamond)

			var_14_2:setPosition(cc.p(self.dropitems[iter_14_0]:getContentSize().width / 2, self.dropitems[iter_14_0]:getContentSize().height / 2))
			self.dropitems[iter_14_0]:addChild(var_14_2)

			self.dropitems[iter_14_0].sp = var_14_2
		else
			local var_14_3 = ItemSprite:createNewWithItemId(var_14_0[iter_14_0].dropid, var_14_0[iter_14_0].dropNum, nil, nil, var_14_0[iter_14_0].itemattr)

			var_14_3:setPosition(cc.p(self.dropitems[iter_14_0]:getContentSize().width / 2, self.dropitems[iter_14_0]:getContentSize().height / 2))
			self.dropitems[iter_14_0]:addChild(var_14_3)

			self.dropitems[iter_14_0].sp = var_14_3
			self.dropitems[iter_14_0].id = var_14_0[iter_14_0].dropid
		end
	end

	self.awardsNum = #var_14_0

	if arg_14_1 == 1 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.UnGet)
		self.confirmButton:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", config._DEBUG and 0 or 1)
		self.confirmButton:setPressedActionEnabled(true)
		self.confirmButton:setBright(true)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:getActivityDrops(var_0_10)
			self.confirmButton:setTouchEnabled(false)
		end)
	elseif arg_14_1 == 2 then
		self.confirmButton:getChildByName("label"):setString("")
		self.confirmButton:loadTextures("mainScenebg/activity/common/chongzhi.png", "mainScenebg/activity/common/chongzhi.png", "mainScenebg/activity/common/chongzhi.png")
		self.confirmButton:setBright(true)
		self.confirmButton:setPressedActionEnabled(true)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_16_0 = cc.EventCustom:new("switchListButtons")

			var_16_0.bVisible = true
			var_16_0.bg = 1

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_16_0)

			local var_16_1 = cc.EventCustom:new("switchShowLayer")

			var_16_1.layerName = "SupermarketLayer"

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_16_1)
		end)
	elseif arg_14_1 == 3 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Got)
		self.confirmButton:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", config._DEBUG and 0 or 1)
		self.confirmButton:setBright(false)
		self.confirmButton:setTouchEnabled(false)
	end

	self:showItems(true)
end

function ActivityLayer:initAccountPanel(arg_17_1)
	local var_17_0 = {}

	while drop_data[var_0_15]["drop_id" .. 1] do
		table.insert(var_17_0, {
			dropid = drop_data[var_0_15]["drop_id" .. 1],
			dropNum = drop_data[var_0_15]["drop_num" .. 1],
			itemattr = drop_data[var_0_15]["drop_extra" .. 1]
		})
	end

	for iter_17_0 = 1, #var_17_0 do
		if self.dropitems[iter_17_0].sp then
			self.dropitems[iter_17_0].sp:removeFromParent()

			self.dropitems[iter_17_0].sp = nil
		end

		local var_17_2 = ItemSprite:createNewWithItemId(var_17_0[iter_17_0].dropid, var_17_0[iter_17_0].dropNum, nil, nil, var_17_0[iter_17_0].itemattr)

		var_17_2:setPosition(cc.p(self.dropitems[iter_17_0]:getContentSize().width / 2, self.dropitems[iter_17_0]:getContentSize().height / 2))
		self.dropitems[iter_17_0]:addChild(var_17_2)

		self.dropitems[iter_17_0].sp = var_17_2
	end

	if arg_17_1 == 1 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.UnGet)
		self.confirmButton:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:getActivityDrops(var_0_11)
			self.confirmButton:setTouchEnabled(false)
		end)
	elseif arg_17_1 == 2 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Regisit)
		self.confirmButton:loadTextures("public/button/public_button_normal.png", nil, "public/button/public_button_normal_on.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			require("view.Layer.AccountbindingLayer")
			self:addChild(AccountbindingLayer:create(function()
				self:hideItems()
				self:showPanel(var_0_11)
			end), 2)
		end)
	elseif arg_17_1 == 3 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Got)
		self.confirmButton:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(false)
	end

	self:showItems(true)
end

function ActivityLayer:initPhonePanel(arg_21_1)
	local var_21_0 = {}

	while drop_data[var_0_16]["drop_id" .. 1] do
		table.insert(var_21_0, {
			dropid = drop_data[var_0_16]["drop_id" .. 1],
			dropNum = drop_data[var_0_16]["drop_num" .. 1],
			itemattr = drop_data[var_0_16]["drop_extra" .. 1]
		})
	end

	for iter_21_0 = 1, #var_21_0 do
		if self.dropitems[iter_21_0].sp then
			self.dropitems[iter_21_0].sp:removeFromParent()

			self.dropitems[iter_21_0].sp = nil
		end

		local var_21_2 = ItemSprite:createNewWithItemId(var_21_0[iter_21_0].dropid, var_21_0[iter_21_0].dropNum, nil, nil, var_21_0[iter_21_0].itemattr)

		var_21_2:setPosition(cc.p(self.dropitems[iter_21_0]:getContentSize().width / 2, self.dropitems[iter_21_0]:getContentSize().height / 2))
		self.dropitems[iter_21_0]:addChild(var_21_2)

		self.dropitems[iter_21_0].sp = var_21_2
	end

	if arg_21_1 == 1 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.UnGet)
		self.confirmButton:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:getActivityDrops(var_0_12)
			self.confirmButton:setTouchEnabled(false)
		end)
	elseif arg_21_1 == 2 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Bind)
		self.confirmButton:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if account_manager.accountInfo.registerstatus then
				require("view.Layer.BindphoneLayer")
				self:addChild(BindphoneLayer:create(function()
					self:hideItems()
					self:showPanel(var_0_12)
				end), 2)
			else
				global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Regist_Warning[1], RISE_WORDS_WARNING)
			end
		end)
	elseif arg_21_1 == 3 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Got)
		self.confirmButton:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(false)
	elseif arg_21_1 == 4 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Bind)
		self.confirmButton:loadTextures("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_LOGIN_REGIST_WARNING.Regist_Warning[1], RISE_WORDS_WARNING)
		end)
	end

	self:showItems(true)
end

function ActivityLayer:initFirstOpenPanel(arg_26_1)
	local var_26_0 = {}
	local var_26_1 = 1

	while drop_data[var_0_17]["drop_id" .. var_26_1] do
		table.insert(var_26_0, {
			dropid = drop_data[var_0_17]["drop_id" .. var_26_1],
			dropNum = drop_data[var_0_17]["drop_num" .. var_26_1],
			itemattr = drop_data[var_0_17]["drop_extra" .. var_26_1]
		})

		var_26_1 = var_26_1 + 1
	end

	if drop_data[var_0_17].diamond then
		table.insert(var_26_0, 1, {
			diamond = drop_data[var_0_17].diamond
		})
	end

	for iter_26_0 = 1, #var_26_0 do
		if self.dropitems[iter_26_0].sp then
			self.dropitems[iter_26_0].sp:removeFromParent()

			self.dropitems[iter_26_0].sp = nil
		end

		if var_26_0[iter_26_0].diamond then
			local var_26_2 = ItemSprite:createNewWithItemId("diamond", var_26_0[iter_26_0].diamond)

			var_26_2:setPosition(cc.p(self.dropitems[iter_26_0]:getContentSize().width / 2, self.dropitems[iter_26_0]:getContentSize().height / 2))
			self.dropitems[iter_26_0]:addChild(var_26_2)

			self.dropitems[iter_26_0].sp = var_26_2
		else
			local var_26_3 = ItemSprite:createNewWithItemId(var_26_0[iter_26_0].dropid, var_26_0[iter_26_0].dropNum, nil, nil, var_26_0[iter_26_0].itemattr)

			var_26_3:setPosition(cc.p(self.dropitems[iter_26_0]:getContentSize().width / 2, self.dropitems[iter_26_0]:getContentSize().height / 2))
			self.dropitems[iter_26_0]:addChild(var_26_3)

			self.dropitems[iter_26_0].sp = var_26_3
			self.dropitems[iter_26_0].id = var_26_0[iter_26_0].dropid
		end
	end

	self.awardsNum = #var_26_0

	for iter_26_1 = #var_26_0 + 1, 6 do
		self.dropitems[var_26_1]:setVisible(false)
	end

	if arg_26_1 == 1 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.UnGet)
		self.confirmButton:loadTextures("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", config._DEBUG and 0 or 1)
		self.confirmButton:setBright(true)
		self.confirmButton:setTouchEnabled(true)
		self.confirmButton:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:getActivityDrops(var_0_13)
			self.confirmButton:setTouchEnabled(false)
		end)
	elseif arg_26_1 == 3 then
		self.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Got)
		self.confirmButton:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", config._DEBUG and 0 or 1)
		self.confirmButton:setTouchEnabled(false)
	end

	self:showItems(true)
end

function ActivityLayer.getActivityDrops(arg_28_0, arg_28_1)
	network:rpc("get_activity_drop", {
		panel = arg_28_1
	}, function(arg_29_0)
		if arg_29_0.result == 1 then
			arg_28_0.confirmButton:getChildByName("label"):setString(L_BUTTON_TEXT.Got)
			arg_28_0.confirmButton:loadTextures("public/button/public_button_gray.png", nil, "public/button/public_button_gray.png", config._DEBUG and 0 or 1)
			arg_28_0.confirmButton:setTouchEnabled(false)

			if arg_28_1 == var_0_13 then
				playermodel.haveopenaward = true
			elseif arg_28_1 == var_0_10 then
				playermodel.haverechargeaward = true
			end

			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_GET_REWARD_CHANGED)
			global_gain(arg_29_0)
		else
			arg_28_0.confirmButton:setTouchEnabled(true)
			l2Log("get activity drop fail")
		end
	end)
end

function ActivityLayer.showItemDetails(arg_30_0, arg_30_1)
	if "item" == "item" then
		if item_data[arg_30_1].bag_item_type == kITEM_HORCRUX then
			local var_30_1 = -1
			local var_30_2 = require("data.horcrux_data")[arg_30_1].horcruxtype

			for iter_30_0, iter_30_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_30_1 == iter_30_1.item_id then
					var_30_1 = iter_30_0

					break
				end
			end

			if var_30_1 == -1 then
				print("did not find id")

				return
			end

			require("view.Layer.DetailsofHelpGirlLayer")
			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_30_1,
				itemid = arg_30_1,
				callback = callback
			})

			return
		elseif item_data[arg_30_1].bag_item_type == kITEM_HERO then
			require("view.Layer.EquipLayer")
			LayerManager:pushInLayer("SoulsLayer", {
				showButtonList = true,
				layertype = "DropDetailsLayer",
				showtype = 6,
				cursoul = item_data[arg_30_1].servant,
				exitCallback = callback
			})
		elseif not global_basic_scene:getChildByName("OTHER_LAYER") then
			local var_30_3 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_30_1
			})
		end
	elseif "item" == "gold" then
		-- block empty
	elseif "item" == "diamond" then
		-- block empty
	end
end

function ActivityLayer:initBg(arg_31_1, arg_31_2)
	local var_31_0 = ccui.Layout:create()

	var_31_0:setTouchEnabled(true)
	var_31_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_31_0:setAnchorPoint(cc.p(0, 0))
	var_31_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_31_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_31_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_31_0:setOpacity(0)
	self:addChild(var_31_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_32_0)
		self:addChild(arg_32_0, -2)
		arg_32_0:setPositionY(arg_32_0:getPositionY() - GameDisplay.fix_y)

		local var_32_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_32_0:setAnchorPoint(cc.p(0, 0))
		var_32_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_32_0, -1)
		self:init(arg_31_1, arg_31_2)
		var_31_0:setOpacity(102)
		var_31_0:setTouchEnabled(false)
	end)
end
