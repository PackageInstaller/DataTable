PopCommunityDonationLayer = class("PopCommunityDonationLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local drop_data = require("data.drop_data")
local item_manager = require("controller.item_manager")
local family_donate_data = require("data.family_donate_data")
local var_0_10 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_12 = {
	{
		tips = "community_system/communityMainLayer/donation_card_di_green.png",
		buy = "community_system/communityMainLayer/donation_buy_green.png",
		bg = "community_system/communityMainLayer/donation_card_3.png",
		color = cc.c3b(171, 242, 255)
	},
	{
		tips = "community_system/communityMainLayer/donation_money_purple.png",
		buy = "community_system/communityMainLayer/donation_buy_purple.png",
		bg = "community_system/communityMainLayer/donation_card_1.png",
		color = cc.c3b(248, 203, 255)
	},
	{
		tips = "community_system/communityMainLayer/donation_card_di_yellow.png",
		buy = "community_system/communityMainLayer/donation_buy_yellow.png",
		bg = "community_system/communityMainLayer/donation_card_2.png",
		color = cc.c3b(255, 253, 205)
	}
}

function PopCommunityDonationLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityDonationLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityDonationLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityDonationLayer.json" or "PopCommunityDonationLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_28")
	self.emeybg = ccui.Helper:seekWidgetByName(self.rootLayer, "img_money")
	self.emeylabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_42")
	self.tipslable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_30")

	self.tipslable:setString(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips1)
	self.tipslable:setFontSize(22)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.surecallback then
				self.surecallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if arg_3_1 then
		self.surecallback = arg_3_1.surecallback or nil
	end

	self.donationtime = community_system_manager:getDonationDaliyStatus()
	self.commitymoney = community_system_manager:getCommunityMoney() or 0

	community_system_manager:get_family_contribute_info(function(arg_6_0)
		if arg_6_0.result == 1 then
			self.dailytime = arg_6_0.list

			self:initUI()
			global_window_open_action(self.rootpanel)
		end
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityDonationLayer.dealWiththeData(arg_8_0, arg_8_1)
	return
end

function PopCommunityDonationLayer:updateCommunityMoney()
	self.emeylabel:setString(global_trans_number(self.commitymoney))
end

function PopCommunityDonationLayer.createTableView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = cc.TableView:create(arg_10_1)

	;(nil):setName(arg_10_2)
	var_10_0:setDelegate()
	var_10_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_10_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_10_0
end

function PopCommunityDonationLayer:initUI()
	self.data = family_donate_data

	self:updateCommunityMoney()
	self.listview:removeAllChildren()
	self.listview:setClippingEnabled(true)
	self.listview:setItemsMargin(0)

	self.topnodes = {}

	for iter_11_0, iter_11_1 in ipairs(self.data) do
		local var_11_0 = self.items:clone()

		self:updateNode(var_11_0, iter_11_1)
		table.insert(self.topnodes, var_11_0)
		self.listview:pushBackCustomItem(var_11_0)
	end
end

function PopCommunityDonationLayer.createCostIcon(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = ccui.ImageView:create(({
		[1500001] = "public/currency/1500001_1.png",
		[SHOP_CURRENCY_GOLD] = "community_system/communityMainLayer/gold.png",
		[SHOP_CURRENCY_DIAMOND] = "public/currency/UI_battleEnd_diamond.png",
		[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
		[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
		[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png"
	})[tonumber(arg_12_2.cost_item)], var_0_10)

	var_12_0:setPosition(cc.p(arg_12_1:getContentSize().width / 2, arg_12_1:getContentSize().height / 2))
	arg_12_1:addChild(var_12_0)

	local var_12_1 = cc.Label:createWithTTF("" .. global_trans_number(arg_12_2.cost_num), FONT_NAME, 18)

	var_12_1:setColor(cc.c3b(0, 0, 0))
	var_12_1:setAnchorPoint(cc.p(0, 0.5))
	var_12_1:setPosition(var_12_0:getPositionX() + var_12_0:getContentSize().width / 2 + 3, var_12_0:getPositionY())
	arg_12_1:addChild(var_12_1)
end

function PopCommunityDonationLayer:updateNode(arg_13_1, arg_13_2)
	local var_13_0 = ccui.Helper:seekWidgetByName(arg_13_1, "Label_23")
	local var_13_1 = ccui.Helper:seekWidgetByName(arg_13_1, "junzeng_btn")
	local var_13_2 = ccui.Helper:seekWidgetByName(arg_13_1, "Image_24")
	local var_13_3 = ccui.Helper:seekWidgetByName(arg_13_1, "Image_26")

	if arg_13_1:getChildByName("daily_times") then
		arg_13_1:getChildByName("daily_times"):removeFromParent()
	end

	self:createDalilyTime(arg_13_1, arg_13_2.id)
	var_13_0:setString(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips2 .. global_trans_number(arg_13_2.family_money))
	var_13_1:loadTextures(var_0_12[arg_13_2.id].bg, var_0_12[arg_13_2.id].bg, var_0_12[arg_13_2.id].bg, var_0_10)

	var_13_1.data = arg_13_2

	var_13_2:loadTexture(var_0_12[arg_13_2.id].tips, var_0_10)
	var_13_3:loadTexture(var_0_12[arg_13_2.id].buy, var_0_10)
	var_13_0:setColor(var_0_12[arg_13_2.id].color)
	self:createCostIcon(var_13_3, arg_13_2)

	local var_13_4 = self.donationtime[arg_13_2.id]
	local var_13_5 = community_system_manager:getDonationMaxNum(arg_13_2.id)

	ccui.Helper:seekWidgetByName(var_13_2, "Label_25"):setString(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips3)
	ccui.Helper:seekWidgetByName(var_13_3, "Label_27"):setString("")

	if arg_13_1:getChildByName("jz_at") then
		arg_13_1:getChildByName("jz_at"):removeFromParent()
	end

	local var_13_6 = string.format("<p><span style=color: rgb(255,255,255);>%s</span><span style=color: rgb(255,255,255);>%d</span><span style=color: rgb(255,255,255);>/%d</span></p>", COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips4, var_13_5 - self.donationtime[arg_13_2.id], var_13_5)
	local var_13_7 = RichTextPro:create()

	var_13_7:setSize(22)
	var_13_7:setLineSpace(0)
	var_13_7:setText(var_13_6, nil, true)
	var_13_7:setName("jz_at")
	var_13_7:setPosition(cc.p(40, 26))
	arg_13_1:addChild(var_13_7)
	self:updateAwardImage(var_13_2, arg_13_2.reward)
	var_13_1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_14_0()
			community_system_manager:make_family_contribute(arg_13_2.id, function(arg_16_0)
				if arg_16_0.result == 1 then
					if self.callback then
						self.callback()
					end

					self.commitymoney = self.commitymoney + arg_13_2.family_money
					self.donationtime[arg_13_2.id] = self.donationtime[arg_13_2.id] + 1

					self:updateDalilyTime(arg_13_2.id)
					self:updateNode(arg_13_1, arg_14_0.data)
					community_system_manager:updateDonationDaliyStatus(arg_13_2.id)
					community_system_manager:updateCommunityMoney(arg_13_2.family_money)

					if self.callback then
						self.callback()
					end

					self:updateCommunityMoney()
				elseif arg_16_0.result == 2 then
					global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips10)
				elseif arg_16_0.result == 3 then
					global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips11)
				elseif arg_16_0.result == 11 then
					global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips5)
				elseif arg_16_0.result == 12 then
					global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips6)
				elseif arg_16_0.result == 13 then
					global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips13)
				end
			end)
		end

		if var_13_4 < var_13_5 then
			if not self:isjumpToBuyLayer(arg_13_2.cost_item, arg_13_2.cost_num) then
				(function()
					global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips10, global_trans_number(arg_13_2.cost_num), ((function(arg_20_0)
						if arg_20_0 == 0 then
							return COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips7
						elseif arg_20_0 == 1 then
							return COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips8
						elseif arg_20_0 == 2 then
							return COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips9
						else
							return ""
						end
					end)(arg_13_2.cost_item))), {
						headImage = "community_system/joinCommunityLayer/tips_juanzeng.png",
						layerType = "CommunityMainLayer",
						assgin = 2,
						surecallback = var_14_0,
						cancelcallback = function()
							return
						end
					}), 999)
				end)()
			end
		else
			global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips6)
		end
	end)
end

function PopCommunityDonationLayer:createDalilyTime(arg_21_1, arg_21_2)
	if not arg_21_1 or not self.dailytime or not arg_21_2 then
		return
	end

	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(self.dailytime) do
		if iter_21_1.id == arg_21_2 then
			var_21_0 = iter_21_1.count

			break
		end
	end

	local var_21_1 = cc.Label:createWithTTF(":", "fonts/name.ttf", 20)

	var_21_1:setName("daily_times")
	var_21_1:setPosition(cc.p(arg_21_1:getContentSize().width / 2, arg_21_1:getChildByName("Image_26"):getPositionY() + arg_21_1:getChildByName("Image_26"):getContentSize().height / 2 + 20))
	arg_21_1:addChild(var_21_1)

	local var_21_2 = community_system_manager:getMaxMember()

	if var_21_2 ~= "" then
		var_21_1:setString(string.format(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips12, var_21_2 - var_21_0))
	end
end

function PopCommunityDonationLayer:updateDalilyTime(arg_22_1)
	if not self.dailytime or not arg_22_1 then
		return
	end

	for iter_22_0, iter_22_1 in pairs(self.dailytime) do
		if iter_22_1.id == arg_22_1 then
			iter_22_1.count = iter_22_1.count + 1

			break
		end
	end
end

function PopCommunityDonationLayer:updateAwardImage(arg_23_1, arg_23_2)
	if not arg_23_1 or not arg_23_2 then
		return
	end

	local var_23_0 = 1

	while arg_23_1:getChildByName("awarditem_" .. var_23_0) do
		arg_23_1:getChildByName("awarditem_" .. var_23_0):removeFromParent()

		var_23_0 = var_23_0 + 1
	end

	local var_23_1 = self:getDropData(arg_23_2)
	local var_23_2 = {}

	if var_23_1.items and next(var_23_1.items) then
		for iter_23_0, iter_23_1 in ipairs(var_23_1.items) do
			table.insert(var_23_2, {
				itemid = iter_23_1.itemid,
				itemnum = iter_23_1.num
			})
		end
	elseif var_23_1.diamond and var_23_1.diamond > 0 then
		table.insert(var_23_2, {
			itemid = "diamond",
			itemnum = var_23_1.diamond
		})
	elseif var_23_1.gold then
		nowitem = "gold"
		itemnum = var_23_1.gold

		table.insert(var_23_2, {
			itemid = "gold",
			itemnum = var_23_1.gold
		})
	end

	for iter_23_2, iter_23_3 in ipairs(var_23_2) do
		local var_23_4
		local var_23_5 = iter_23_3.itemid
		local var_23_6 = iter_23_3.itemnum

		if iter_23_3.itemid and var_23_6 then
			var_23_4 = type(var_23_5) == "string" and ccui.Button:create("public/box/box_activity_recharge_1.png", "public/box/box_activity_recharge_1.png", nil, var_0_10) or ccui.Button:create("public/box/box_activity_recharge_" .. item_data[var_23_5].equip_quality .. ".png", "public/box/box_activity_recharge_" .. item_data[var_23_5].equip_quality .. ".png", nil, var_0_10)

			var_23_4:setAnchorPoint(cc.p(0.5, 0.5))
			var_23_4:setPosition(cc.p(0, 0))
			var_23_4:setTouchEnabled(true)
			var_23_4:setSwallowTouches(true)

			if #var_23_2 == 2 then
				if iter_23_2 == 1 then
					var_23_4:setPosition(cc.p(var_23_4:getContentSize().width / 2 + 10, -73))
				else
					var_23_4:setPosition(cc.p(var_23_4:getContentSize().width / 2 + 10 + 12 + var_23_4:getContentSize().width, -73))
				end
			else
				var_23_4:setPosition(cc.p(var_23_4:getContentSize().width / 2 + 60, -73))
			end

			var_23_4:setName("awarditem_" .. var_23_0)
			arg_23_1:addChild(var_23_4, 2)
			var_23_4:setScale9Enabled(true)
			var_23_4:setContentSize(cc.size(100, 100))

			local var_23_7 = ccui.ImageView:create("public/box/rechage_itemsprite_num_bg.png", var_0_10)

			var_23_7:setAnchorPoint(cc.p(0, 0))
			var_23_7:setPosition(cc.p(var_23_4:getContentSize().width - var_23_7:getContentSize().width, 0))
			var_23_4:addChild(var_23_7)

			local var_23_8 = cc.Label:createWithTTF("x" .. var_23_6, "fonts/name.ttf", 22)

			var_23_7:addChild(var_23_8)
			var_23_8:setAnchorPoint(cc.p(1, 0.5))
			var_23_8:setPosition(cc.p(var_23_7:getContentSize().width - 2, var_23_7:getContentSize().height / 2))

			local var_23_9
			local var_23_10

			if var_23_5 == "gold" then
				var_23_9 = "equipment/1000001.png"
			elseif var_23_5 == "diamond" then
				var_23_9 = "equipment/1000000.png"
			elseif item_data[var_23_5].bag_item_type == kITEM_MEDAL then
				var_23_10 = ItemSprite:create_medal_icon(var_23_5)
			elseif item_data[var_23_5].bag_item_type == kITEM_COMPONENT then
				var_23_10 = componentManager:create_component_icon(var_23_5, nil, nil)
			elseif item_data[var_23_5].image_id then
				var_23_9 = "equipment/" .. item_data[var_23_5].image_id .. ".png"
			end

			var_23_10 = var_23_10 or ccui.ImageView:create(var_23_9)

			var_23_10:setPosition(cc.p(var_23_4:getContentSize().width / 2, var_23_4:getContentSize().height / 2 + 3))
			var_23_10:setName("ItemSprite")
			var_23_10:setScale(92 / math.min(var_23_10:getContentSize().width, var_23_10:getContentSize().height))
			var_23_4:addChild(var_23_10)

			var_23_4.step = index
			var_23_4.itemid = var_23_5

			var_23_4:addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:showItemDeatil(arg_24_0)
			end)
		end
	end
end

function PopCommunityDonationLayer:showItemDeatil(arg_25_1)
	if type(arg_25_1.itemid) == "string" then
		return
	end

	local var_25_0 = item_data[arg_25_1.itemid].bag_item_type

	if item_data[arg_25_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_25_1 = -1
		local var_25_2 = require("data.item_data")[arg_25_1.itemid].horcruxtype

		for iter_25_0, iter_25_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_25_1.itemid == iter_25_1.item_id then
				var_25_1 = iter_25_0

				break
			end
		end

		if var_25_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_25_1,
			itemid = arg_25_1.itemid
		})
	elseif var_25_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_25_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_25_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_25_1.itemid
		})
	end
end

function PopCommunityDonationLayer.getDropData(arg_26_0, arg_26_1)
	local var_26_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_26_1 = drop_data[arg_26_1] or {}

	if var_26_1.gold then
		var_26_0.gold = var_26_0.gold + var_26_1.gold
	end

	if var_26_1.diamond then
		var_26_0.diamond = var_26_0.diamond + var_26_1.diamond
	end

	local var_26_2 = 1

	if var_26_1["drop_id" .. 1] then
		local var_26_3 = 1

		while var_26_1["drop_id" .. var_26_3] do
			var_26_0.items[var_26_2] = {
				itemid = var_26_1["drop_id" .. var_26_3],
				num = var_26_1["drop_num" .. var_26_3],
				rate = var_26_1["drop_rate" .. var_26_3]
			}
			var_26_3 = var_26_3 + 1
			var_26_2 = var_26_2 + 1
		end
	end

	if var_26_1["dropmodel_id" .. 1] then
		local var_26_4 = 1

		while var_26_1["dropmodel_id" .. var_26_4] do
			if drop_data[var_26_1["dropmodel_id" .. var_26_4]].gold then
				var_26_0.gold = var_26_0.gold + drop_data[var_26_1["dropmodel_id" .. var_26_4]].gold
			end

			if drop_data[var_26_1["dropmodel_id" .. var_26_4]].diamond then
				var_26_0.diamond = var_26_0.diamond + drop_data[var_26_1["dropmodel_id" .. var_26_4]].diamond
			end

			if drop_data[var_26_1["dropmodel_id" .. var_26_4]]["drop_id" .. 1] then
				local var_26_5 = 1

				while drop_data[var_26_1["dropmodel_id" .. var_26_4]]["drop_id" .. var_26_5] do
					var_26_0.items[var_26_2] = {
						itemid = drop_data[var_26_1["dropmodel_id" .. var_26_4]]["drop_id" .. var_26_5],
						num = drop_data[var_26_1["dropmodel_id" .. var_26_4]]["drop_num" .. var_26_5]
					}
					var_26_5 = var_26_5 + 1
					var_26_2 = var_26_2 + 1
				end
			end

			if drop_data[var_26_1["dropmodel_id" .. var_26_4]]["rd_drop_id" .. 1] then
				local var_26_6 = 1

				while drop_data[var_26_1["dropmodel_id" .. var_26_4]]["rd_drop_id" .. var_26_6] do
					var_26_0.items[var_26_2] = {
						itemid = drop_data[var_26_1["dropmodel_id" .. var_26_4]]["rd_drop_id" .. var_26_6],
						num = drop_data[var_26_1["dropmodel_id" .. var_26_4]]["rd_drop_num" .. var_26_6]
					}
					var_26_6 = var_26_6 + 1
					var_26_2 = var_26_2 + 1
				end
			end

			var_26_4 = var_26_4 + 1
		end
	end

	if var_26_1["rd_drop_id" .. 1] then
		local var_26_7 = 1

		while var_26_1["rd_drop_id" .. var_26_7] do
			var_26_0.items[var_26_2] = {
				itemid = var_26_1["rd_drop_id" .. var_26_7],
				num = var_26_1["rd_drop_num" .. var_26_7]
			}
			var_26_7 = var_26_7 + 1
			var_26_2 = var_26_2 + 1
		end
	end

	if var_26_1["rd_dropmodel_id" .. 1] then
		local var_26_8 = 1

		while var_26_1["rd_dropmodel_id" .. var_26_8] do
			if drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]].gold then
				var_26_0.gold = var_26_0.gold + drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]].gold
			end

			if drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]].diamond then
				var_26_0.diamond = var_26_0.diamond + drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]].diamond
			end

			if drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["drop_id" .. 1] then
				local var_26_9 = 1

				while drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["drop_id" .. var_26_9] do
					var_26_0.items[var_26_2] = {
						itemid = drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["drop_id" .. var_26_9],
						num = drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["drop_num" .. var_26_9]
					}
					var_26_9 = var_26_9 + 1
					var_26_2 = var_26_2 + 1
				end
			end

			if drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["rd_drop_id" .. 1] then
				local var_26_10 = 1

				while drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["rd_drop_id" .. var_26_10] do
					var_26_0.items[var_26_2] = {
						itemid = drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["rd_drop_id" .. var_26_10],
						num = drop_data[var_26_1["rd_dropmodel_id" .. var_26_8]]["rd_drop_num" .. var_26_10]
					}
					var_26_10 = var_26_10 + 1
					var_26_2 = var_26_2 + 1
				end
			end

			var_26_8 = var_26_8 + 1
		end
	end

	return var_26_0
end

function PopCommunityDonationLayer.isjumpToBuyLayer(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {
		[SHOP_CURRENCY_GOLD] = function()
			return playermodel.gold
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			return playermodel.diamond
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			return playermodel.honor
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			return playermodel.explorecoin
		end,
		[SHOP_CURRENCY_RMB] = function()
			return 0
		end
	}

	setmetatable(var_27_0, {
		__index = function(arg_33_0, arg_33_1)
			return function()
				return item_manager:getItemNumber(arg_33_1)
			end
		end
	})

	local var_27_1 = {
		[SHOP_CURRENCY_GOLD] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[SHOP_CURRENCY_DIAMOND] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		[SHOP_CURRENCY_HORNOR] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		[SHOP_CURRENCY_EXPLORECOIN] = function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end
	}

	setmetatable(var_27_1, {
		__index = function(arg_39_0, arg_39_1)
			return function()
				global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_39_1].name))
				audioManager:playeffectMusicTest("sound/invalid")
			end
		end
	})

	if var_27_0[arg_27_1] and arg_27_2 <= var_27_0[arg_27_1]() then
		return false
	else
		if var_27_1[arg_27_1] then
			var_27_1[arg_27_1]()
		end

		return true
	end
end

function PopCommunityDonationLayer:initBg(arg_41_1)
	local var_41_0 = ccui.Layout:create()

	var_41_0:setTouchEnabled(true)
	var_41_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_41_0:setAnchorPoint(cc.p(0, 0))
	var_41_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_41_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_41_0:setOpacity(0)
	var_41_0:setCascadeOpacityEnabled(false)
	self:addChild(var_41_0, -1)

	local var_41_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_41_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_41_1:setPositionX(var_41_0:getContentSize().width / 2)
	var_41_1:setPositionY(var_41_0:getContentSize().height / 2)
	var_41_0:addChild(var_41_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_42_0)
		self:addChild(arg_42_0, -2)
		arg_42_0:setPositionY(arg_42_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_41_1)
		var_41_0:setOpacity(102)
		var_41_0:setTouchEnabled(false)
	end)
end

function PopCommunityDonationLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
