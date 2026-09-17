PopCommunityWishLayer = class("PopCommunityWishLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")
require("view.Sprite.AvatarSprite")
require("view.Sprite.ConfirmDialogSprite")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local var_0_6
local var_0_7 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_9 = {
	[1] = "community_system/communityMainLayer/commity_wish_xybg.png",
	[2] = "community_system/communityMainLayer/commity_wish_hdxybg.png"
}
local var_0_10 = {
	COMMUNITY_WISH_SYSTEM.tips24,
	COMMUNITY_WISH_SYSTEM.tips25
}
local var_0_11 = {
	COMMUNITY_WISH_SYSTEM.tips26,
	COMMUNITY_WISH_SYSTEM.tips27
}
local var_0_12 = 640
local var_0_13 = 200
local var_0_14 = {
	cc.p(20, 0),
	cc.p(176, 0),
	cc.p(332, 0),
	(cc.p(488, 0))
}

local function var_0_15(arg_2_0)
	if not arg_2_0 then
		return
	end

	if arg_2_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_2_0 / 60))
	end
end

function PopCommunityWishLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopCommunityWishLayer.new()

	var_3_0:initBg(arg_3_1)

	return var_3_0
end

function PopCommunityWishLayer:init(arg_4_1)
	var_0_6 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityWishLayer.json" or "PopCommunityWishLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_db")
	self.rootpanel = ccui.Helper:seekWidgetByName(self.panel, "Image_1")
	self.surebtn = ccui.Helper:seekWidgetByName(self.panel, "sur_btn")
	self.timelabel = ccui.Helper:seekWidgetByName(self.panel, "Label_21")
	self.tips = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_72")
	self.tableview = ccui.Helper:seekWidgetByName(self.rootpanel, "tableviewlayer")
	self.imgnone = ccui.Helper:seekWidgetByName(self.rootpanel, "Image_none")
	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.lefttime = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_72_0")

	self.surebtn:setVisible(false)
	self.timelabel:setVisible(false)
	self.panel:setPositionY(136 + GameDisplay.fix_y)

	if arg_4_1 then
		self.wishtype = arg_4_1.wishtype or 1
	end

	if arg_4_1 then
		self.callback = arg_4_1.callback or nil
	end

	if arg_4_1 then
		self.surecallback = arg_4_1.surecallback or nil
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:createFullScreenMask(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.candeal and self.callback then
				self.callback()
			end

			if self.surecallback then
				self.surecallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_6 = nil

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function PopCommunityWishLayer:initUI()
	self.rootpanel:loadTexture(var_0_9[self.wishtype], var_0_7)
	self.tips:setString(var_0_10[self.wishtype])
	self.imgnone:getChildByName("Label_19"):getVirtualRenderer():setMaxLineWidth(350)
	self.imgnone:getChildByName("Label_19"):setString(var_0_11[self.wishtype])
	self:initTableLayer()
	self:updateActivityLefttimes()
	community_system_manager:get_family_wish_num(function(arg_9_0)
		if arg_9_0.result == 1 then
			self.surebtn:setVisible(true)
			self.timelabel:setVisible(true)
			self:initSureBtn()
			self:updateMytimes()
		end
	end)
end

function PopCommunityWishLayer:updateMytimes()
	local var_10_0 = community_system_manager:getMaxWishTimes(self.wishtype, 1)
	local var_10_1 = var_10_0 - community_system_manager:getWishTimes(self.wishtype, 1)

	if var_10_1 < 0 then
		var_10_1 = 0
	end

	self.timelabel:setString("")

	if self.panel:getChildByName("xy_at") then
		self.panel:getChildByName("xy_at"):removeFromParent()
	end

	local var_10_2 = "<p><span style=color: rgb(255,255,255);>%s</span><span style=color: rgb(255,210,0);>%d</span><span style=color: rgb(255,255,255);>/%d</span></p>"
	local var_10_3 = "<p></p>"
	local var_10_4 = RichTextPro:create()

	var_10_4:setSize(24)
	var_10_4:setLineSpace(0)

	if self.wishtype == 1 then
		var_10_4:setText(string.format(var_10_2, COMMUNITY_WISH_SYSTEM.tips2, var_10_1, var_10_0))
	else
		var_10_4:setText(string.format(var_10_2, COMMUNITY_WISH_SYSTEM.tips1, var_10_1, var_10_0))
	end

	var_10_4:setText(var_10_3, nil, true)
	var_10_4:setName("xy_at")
	var_10_4:setPosition(cc.p(230, 30))
	self.panel:addChild(var_10_4, 1000)
end

function PopCommunityWishLayer:updateActivityLefttimes()
	self.lefttime:setString("")

	if self.wishtype == 2 then
		local var_11_0, var_11_1 = community_system_manager:getActivityWishTime()

		if var_11_0 and var_11_1 then
			self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(var_11_1) - time_check_manager:getCurTime(), function(arg_12_0)
				self.lefttime:setString(L_TIME_TWO .. var_0_15(arg_12_0))

				if arg_12_0 <= 0 and self.activityScheduler then
					self.lefttime:setString(L_LAMIYA_CHAPTER.activity_end)
				end
			end)))
		end
	end
end

function PopCommunityWishLayer:initSureBtn()
	self.surebtn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.candeal = false

		if math.abs(arg_14_0:getTouchBeganPosition().y - arg_14_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not self.data or not next(self.data) then
			global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips28)

			return
		elseif not self.data[self.selectindex] then
			if self.wishtype == 1 then
				global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips29)
			else
				global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips30)
			end

			return
		else
			local var_14_0 = {
				headImage = "community_system/joinCommunityLayer/tips_xyqr.png",
				layerType = "CommunityMainLayer"
			}

			function var_14_0.surecallback()
				community_system_manager:make_wish_to_member(self.data[self.selectindex].id, self.wishtype, 1, function(arg_16_0)
					if arg_16_0.result == 1 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips31)
						self:updateMytimes()

						self.candeal = true

						local var_16_0 = community_system_manager:getMaxWishTimes(self.wishtype, 1)
						local var_16_1 = community_system_manager:getWishTimes(self.wishtype, 1)

						if var_16_0 and var_16_1 and var_16_0 <= var_16_1 then
							self:exit()
						end
					elseif arg_16_0.result == 2 then
						global_ShowBlockWords(COMMUNITY_CHAT_SYSTEM.tips2)
					elseif arg_16_0.result == 3 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips10)
					elseif arg_16_0.result == 4 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips32)
					elseif arg_16_0.result == 5 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips33)
					elseif arg_16_0.result == 6 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips34)
					elseif arg_16_0.result == 7 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips35)
						self:exit()
					elseif arg_16_0.result == 8 then
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips36)
						self:exit()
					else
						global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips10)
					end
				end)
			end

			function var_14_0.cancelcallback()
				return
			end

			global_basic_scene:addChild(ConfirmDialogSprite:create("", string.format(COMMUNITY_WISH_SYSTEM.tips37, self.data[self.selectindex].wish_num, item_data[self.data[self.selectindex].item_id].name or ""), var_14_0), 999)
		end
	end)
end

function PopCommunityWishLayer:initTableLayer()
	self.data = community_system_manager:getMyWishData(self.wishtype)

	if not self.data or not next(self.data) then
		return self.imgnone:setVisible(true)
	end

	self.imgnone:setVisible(false)

	if self.tableview:getChildByName("tableviewwish") then
		self.tableview:removeAllChildren()

		self.tableviewwish = nil
	end

	local var_18_0 = cc.TableView:create(cc.size(self.tableview:getContentSize().width, self.tableview:getContentSize().height))

	var_18_0:setPosition(0, 0)
	var_18_0:setDelegate()
	var_18_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_18_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_18_0:setName("tableviewwish")
	self.tableview:addChild(var_18_0, 99)

	self.tableviewwish = var_18_0

	self:initWishTableView()
end

function PopCommunityWishLayer:createNode()
	return (self.items:clone())
end

function PopCommunityWishLayer:updateTableViewPanel()
	if not self.tableviewwish or not self.data then
		return
	end

	local var_20_0, var_20_1 = GetTableViewShowCellIdx(self.tableviewwish, {
		cellsize = cc.size(var_0_12, var_0_13),
		maxcount = self:getCurDataListLen()
	})

	for iter_20_0 = var_20_0, var_20_1 do
		self.tableviewwish:updateCellAtIndex(iter_20_0)
	end
end

function PopCommunityWishLayer:getCurDataListLen()
	local var_21_0 = math.ceil(#self.data / 4)

	if var_21_0 < 3 then
		var_21_0 = 3
	end

	return var_21_0
end

function PopCommunityWishLayer:initWishTableView()
	self.tableviewwish:registerScriptHandler(function(arg_24_0, arg_24_1)
		return var_0_12, var_0_13
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableviewwish:registerScriptHandler(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:dequeueCell()

		if not var_23_0 then
			var_23_0 = cc.TableViewCell:create()

			for iter_23_0 = 1, 4 do
				local var_23_1 = self:createNode()

				self:updateItems(var_23_1, 4 * arg_23_1 + iter_23_0, iter_23_0)

				if self.selectindex == 4 * arg_23_1 + iter_23_0 then
					var_23_1:getChildByName("seclet"):setVisible(true)
				else
					var_23_1:getChildByName("seclet"):setVisible(false)
				end

				var_23_0:addChild(var_23_1)
			end
		else
			local var_23_2 = 4

			for iter_23_1 = 1, 4 do
				local var_23_3 = var_23_0:getChildByName("sp_" .. iter_23_1)

				self:updateItems(var_23_3, var_23_2 * arg_23_1 + iter_23_1, iter_23_1)

				if self.selectindex == var_23_2 * arg_23_1 + iter_23_1 then
					var_23_3:getChildByName("seclet"):setVisible(true)
				else
					var_23_3:getChildByName("seclet"):setVisible(false)
				end
			end
		end

		return var_23_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableviewwish:registerScriptHandler(function(arg_25_0, arg_25_1)
		return self:getCurDataListLen()
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableviewwish:reloadData()
end

function PopCommunityWishLayer:updateItems(arg_26_1, arg_26_2, arg_26_3)
	if not arg_26_1 or not arg_26_2 then
		return
	end

	arg_26_1:setName("sp_" .. arg_26_3)
	arg_26_1:setPosition(var_0_14[arg_26_3])

	arg_26_1:getChildByName("Button_12").selectindex = arg_26_2

	arg_26_1:getChildByName("Button_12"):setSwallowTouches(false)

	local var_26_0 = arg_26_1:getChildByName("bg")
	local var_26_2
	local var_26_3
	local var_26_4
	local var_26_5

	if self.data[arg_26_2] then
		var_26_5 = self.data[arg_26_2].item_id or nil
	end

	arg_26_1:getChildByName("Label_23"):setString("")

	if var_26_0:getChildByName("awarditem") then
		var_26_0:getChildByName("awarditem"):removeFromParent()
	end

	if var_26_5 then
		var_26_2 = type(var_26_5) == "string" and ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", nil, var_0_7) or ccui.Button:create("public/box/new_item_bg" .. item_data[var_26_5].equip_quality .. ".png", "public/box/new_item_bg" .. item_data[var_26_5].equip_quality .. ".png", nil, var_0_7)

		var_26_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_2:setTouchEnabled(false)
		var_26_2:setSwallowTouches(false)
		var_26_2:setPosition(cc.p(var_26_0:getContentSize().width / 2, var_26_0:getContentSize().height / 2))
		var_26_2:setName("awarditem")
		var_26_0:setCascadeOpacityEnabled(false)
		var_26_0:addChild(var_26_2, 1)

		var_26_2.selectindex = arg_26_2

		if item_data[var_26_5].bag_item_type == kITEM_SCULTURE then
			var_26_4 = AvatarSprite:create(var_26_5)
		elseif item_data[var_26_5].bag_item_type == kITEM_MEDAL then
			var_26_4 = ItemSprite:create_medal_icon(var_26_5)
		elseif item_data[var_26_5].bag_item_type == kITEM_COMPONENT then
			var_26_4 = componentManager:create_component_icon(var_26_5, nil, nil)
		elseif item_data[var_26_5].bag_item_type == KITEM_SPRING_FESTIVAL_WORD then
			var_26_4 = ItemSprite:create_word_collect_icon(var_26_5)
		elseif item_data[var_26_5].image_id then
			var_26_3 = "equipment/" .. item_data[var_26_5].image_id .. ".png"
		end

		var_26_4 = var_26_4 or ccui.ImageView:create(var_26_3)

		var_26_4:setPosition(cc.p(var_26_2:getContentSize().width / 2, var_26_2:getContentSize().height / 2 + 24))
		var_26_4:setName("ItemSprite")
		var_26_4:setScale(140 / math.min(var_26_4:getContentSize().width, var_26_4:getContentSize().height))
		var_26_2:addChild(var_26_4)

		var_26_2.itemid = var_26_5
		arg_26_1:getChildByName("Button_12").itemid = var_26_5

		arg_26_1:setVisible(true)
		arg_26_1:getChildByName("mask"):setTouchEnabled(false)

		if self.data[arg_26_2].ownstatus == 2 then
			arg_26_1:getChildByName("mask"):setVisible(true)
		else
			arg_26_1:getChildByName("mask"):setVisible(false)
		end

		arg_26_1:getChildByName("Button_12"):addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 == ccui.TouchEventType.began then
				arg_27_0:runAction(cc.Sequence:create(cc.DelayTime:create(1.2), cc.CallFunc:create(function()
					self:showItemDeatil(arg_27_0)
				end)))
			elseif arg_27_1 == ccui.TouchEventType.canceled then
				arg_27_0:stopAllActions()
			elseif arg_27_1 == ccui.TouchEventType.ended then
				arg_27_0:stopAllActions()

				if math.abs(arg_27_0:getTouchBeganPosition().y - arg_27_0:getTouchEndPosition().y) > 50 then
					return
				end

				if not arg_26_1:getChildByName("mask"):isVisible() then
					self.selectindex = arg_27_0.selectindex

					self:updateTableViewPanel()
				else
					global_ShowBlockWords(COMMUNITY_WISH_SYSTEM.tips42)
				end
			end
		end)

		if not arg_26_1:getChildByName("mask"):isVisible() then
			arg_26_1:getChildByName("Label_23"):setString("x" .. (item_manager:getItemNumber(self.data[arg_26_2].item_id) or 0))
		else
			arg_26_1:getChildByName("Label_23"):setString(item_data[self.data[arg_26_2].item_id].name or "")
		end
	else
		arg_26_1:setVisible(false)
	end
end

function PopCommunityWishLayer:showItemDeatil(arg_29_1)
	if type(arg_29_1.itemid) == "string" then
		return
	end

	local var_29_0 = item_data[arg_29_1.itemid].bag_item_type

	if item_data[arg_29_1.itemid].bag_item_type == kITEM_HORCRUX then
		local var_29_1 = -1
		local var_29_2 = require("data.item_data")[arg_29_1.itemid].horcruxtype

		for iter_29_0, iter_29_1 in pairs((require("data.photofile_HelpGirl_data"))) do
			if arg_29_1.itemid == iter_29_1.item_id then
				var_29_1 = iter_29_0

				break
			end
		end

		if var_29_1 == -1 then
			print("did not find id")

			return
		end

		LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
			id = var_29_1,
			itemid = arg_29_1.itemid
		})
	elseif var_29_0 == kITEM_HERO then
		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[arg_29_1.itemid].servant
		})
	elseif not self:getChildByName("OTHER_LAYER") then
		local var_29_3 = PopLayer:Item({
			hideGainButton = true,
			itemid = arg_29_1.itemid
		})
	end
end

function PopCommunityWishLayer:initBg(arg_30_1)
	local var_30_0 = ccui.Layout:create()

	var_30_0:setTouchEnabled(true)
	var_30_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_30_0:setAnchorPoint(cc.p(0, 0))
	var_30_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_30_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_30_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_30_0:setOpacity(0)
	var_30_0:setCascadeOpacityEnabled(false)
	self:addChild(var_30_0, -1)

	local var_30_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_30_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_30_1:setPositionX(var_30_0:getContentSize().width / 2)
	var_30_1:setPositionY(var_30_0:getContentSize().height / 2)
	var_30_0:addChild(var_30_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_31_0)
		self:addChild(arg_31_0, -2)
		arg_31_0:setPositionY(arg_31_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_30_1)
		var_30_0:setOpacity(102)
		var_30_0:setTouchEnabled(false)
	end)
end

function PopCommunityWishLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.candeal and self.callback then
			self.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
