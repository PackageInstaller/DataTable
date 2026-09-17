SchoolOrderLayer = class("SchoolOrderLayer", function()
	return cc.Layer:create()
end)

local var_0_1 = 166
local var_0_2 = 4
local var_0_3 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local order_manager = require("controller.order_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")

local function var_0_11(arg_2_0)
	return string.format("%02d:%02d:%02d", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60), math.floor(arg_2_0 % 60))
end

local function var_0_12(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.needlist) do
		if iter_3_1.neednum > item_manager:getItemNumber(iter_3_1.needitem) then
			return false
		end
	end

	return true
end

function SchoolOrderLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = SchoolOrderLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function SchoolOrderLayer:init(arg_5_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolOrderLayer.json" or "SchoolOrderLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerEventListener()
	order_manager:get_order_info()
	order_manager:set_new_order()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName("SchoolOrderLayer")
			alert_manager:unregister_alert(ALERT_ORDER_NEW)

			if self.orderList and self.orderList[1] and not var_0_12(self.orderList[1]) then
				alert_manager:unregister_alert(ALERT_ORDER)
			end

			if self.scheduler then
				time_check_manager:removeUpdatePool(self.scheduler)
			end
		end
	end)
end

local function var_0_13(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		if iter_7_1.id > 0 then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function SchoolOrderLayer.registerEventListener(arg_8_0)
	activity_manager:registerEventListener("SchoolOrderLayer", activity_manager.activityEventId.SCHOOL_ORDER_INFO_UPDATE, function(arg_9_0)
		arg_8_0.orderList = arg_9_0.orderlist
		arg_8_0.lastTime = tonumber(arg_9_0.lasttime)

		arg_8_0:updateTableView()

		local var_9_0 = math.min(#arg_8_0.orderList, 10)

		if #arg_8_0.orderList <= 10 then
			var_9_0 = var_0_13(arg_8_0.orderList)
		end

		arg_8_0.getNum:setString(L_ORDER_REFSH_COUNT .. math.max(#arg_8_0.orderList - 10, 0) .. "/10")
		arg_8_0.orderNum:setString(L_ORDER_COUNT .. var_9_0 .. "/10")
	end)
end

function SchoolOrderLayer:initUI()
	self:initBottomList()
	self:initBanner()
end

function SchoolOrderLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.bottomList:setName("bottomlist")
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.rootLayer:addChild(self.bottomList, 2)
end

function SchoolOrderLayer:initBanner()
	local var_13_0 = self.rootLayer:getChildByName("banner")

	var_13_0:setAnchorPoint(cc.p(0.5, 1))
	var_13_0:setPositionY(GameDisplay.height - GameDisplay.fix_y)

	local var_13_1 = var_13_0:getChildByName("title")

	var_13_1:setTouchEnabled(false)
	var_13_1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "school_order"
		})
	end)
	var_13_0:getChildByName("desc_bg"):getChildByName("desc"):setString(L_ORDER_DESC)

	local var_13_2 = var_13_0:getChildByName("num_bg")

	self.orderNum = var_13_2:getChildByName("order_num")
	self.getNum = var_13_2:getChildByName("get_num")

	self.orderNum:setString(L_ORDER_COUNT)
	self.getNum:setString(L_ORDER_REFSH_COUNT)
end

function SchoolOrderLayer:updateTableView()
	if self.orderView then
		self.orderView:reloadData()

		return
	end

	local var_15_0 = self.bottomList:getPositionY() + 70

	self.orderView = cc.TableView:create(cc.size(640, 725 + GameDisplay.height - 1136))

	self.orderView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.orderView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.orderView:setAnchorPoint(cc.p(0, 0))
	self.orderView:setPosition(0, var_15_0)
	self.orderView:setDelegate()
	self.rootLayer:addChild(self.orderView)
	self.orderView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return 640, var_0_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.orderView:registerScriptHandler(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:dequeueCell()
		local var_16_1 = self.orderList[arg_16_1 + 1]
		local var_16_2

		if not var_16_0 then
			var_16_0 = cc.TableViewCell:create()
			var_16_2 = self:createOrderSprite(var_16_1, arg_16_1 + 1)

			var_16_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_16_2:setPosition(cc.p(320, var_0_1 / 2))
			var_16_0:addChild(var_16_2)
		else
			var_16_2 = var_16_0:getChildByName("order_sprite")

			self:updateOrderSprite(var_16_2, var_16_1, arg_16_1 + 1)
		end

		if var_16_1.new then
			var_16_1.new = false

			self:playOrderAddEffect(var_16_2)
		end

		return var_16_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.orderView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return math.min(#self.orderList, order_manager:getMaxShowNum())
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.orderView:reloadData()
end

function SchoolOrderLayer:createOrderSprite(arg_19_1, arg_19_2)
	local var_19_0 = ccui.ImageView:create(arg_19_1.id > 0 and "SchoolOrderLayer/order_bg_1.png" or "SchoolOrderLayer/order_bg_2.png", var_0_3)

	var_19_0:setName("order_sprite")

	local var_19_1 = ccui.Layout:create()

	var_19_1:setContentSize(cc.size(616, 150))
	var_19_1:setAnchorPoint(cc.p(0, 0))
	var_19_1:setPosition(0, 0)
	var_19_1:setName("order_panel")
	var_19_0:addChild(var_19_1)

	local var_19_2 = ccui.ImageView:create("SchoolOrderLayer/level_" .. arg_19_1.quality .. ".png", var_0_3)

	var_19_2:setName("quality_img")
	var_19_2:setPosition(cc.p(25, 75))
	var_19_1:addChild(var_19_2)

	for iter_19_0 = 1, var_0_2 do
		local var_19_3 = self:createItemSp(arg_19_1.needlist[iter_19_0])

		var_19_3:setPosition(cc.p(100 * iter_19_0, 80))
		var_19_3:setName("item_sp_" .. iter_19_0)
		var_19_1:addChild(var_19_3)
	end

	local var_19_4 = var_0_12(arg_19_1) and "SchoolOrderLayer/bg_get.png" or "SchoolOrderLayer/bg_undone.png"
	local var_19_5 = ccui.Button:create(var_19_4, var_19_4, var_19_4, var_0_3)

	var_19_5:setPosition(cc.p(530, 75))
	var_19_5:setName("btn_get")
	var_19_1:addChild(var_19_5)

	local var_19_6 = drop_manager:getDropMsg(arg_19_1.dropid)
	local var_19_7

	if var_19_6.equips[1] then
		var_19_7 = var_19_6.equips[1].dropNum or nil

		local var_19_8

		if var_19_6.equips[1] then
			var_19_8 = var_19_6.equips[1].dropid or nil
		end
	end

	local var_19_9 = "equipment/" .. item_data[var_19_8].image_id .. ".png"

	if var_19_6.gold then
		var_19_7 = var_19_6.gold
		var_19_9 = "equipment/1000001.png"
	end

	local var_19_10 = ccui.ImageView:create(var_19_9)

	var_19_10:setPosition(cc.p(83, 75))
	var_19_10:setName("drop_img")
	var_19_5:addChild(var_19_10)
	var_19_5:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_0_12(arg_19_1) then
			return
		end

		self:playOrderchangeEffect(var_19_0, function()
			order_manager:get_order_reward_by_index(arg_19_1.index)
		end)
	end)

	local var_19_11 = cc.Label:createWithTTF("x" .. global_trans_number(var_19_7), FONT_DES, 22)

	var_19_11:setAnchorPoint(cc.p(0, 0))
	var_19_11:setPosition(cc.p(3, 0))
	var_19_11:setColor(cc.c3b(239, 242, 253))
	var_19_11:setName("drop_num_lbl")
	var_19_5:addChild(var_19_11)

	local var_19_12 = ccui.Button:create("SchoolOrderLayer/btn_delete.png", nil, "SchoolOrderLayer/btn_delete.png", var_0_3)

	var_19_12:setPosition(cc.p(157, 132))
	var_19_12:setName("btn_delete")
	var_19_5:addChild(var_19_12)
	var_19_12:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_ORDRE_DELETE_DES.TITLE,
				des = L_ORDRE_DELETE_DES.DES,
				button = L_BATTLEPASS_BUY.button
			},
			surecallback = function()
				self:playOrderchangeEffect(var_19_0, function()
					order_manager:delete_order_by_index(arg_19_1.index)
				end)
			end
		})
	end)

	local var_19_13 = ccui.Layout:create()

	var_19_13:setContentSize(cc.size(616, 150))
	var_19_13:setAnchorPoint(cc.p(0, 0))
	var_19_13:setPosition(0, 0)
	var_19_13:setName("wait_panel")
	var_19_0:addChild(var_19_13)

	local var_19_14 = ccui.Button:create("SchoolOrderLayer/btn_receive.png", nil, "SchoolOrderLayer/btn_receive.png", var_0_3)

	var_19_14:setPosition(cc.p(310, 25))
	var_19_14:setName("refsh_btn")
	var_19_13:addChild(var_19_14)
	var_19_14:addTouchEventListener(function(arg_25_0, arg_25_1)
		local var_25_1
		local var_25_0

		if arg_25_1 ~= ccui.TouchEventType.ended then
			do return end

			var_25_0 = {
				cost = 1,
				costtype = 6821329
			}
			var_25_1 = {
				title = L_ORDRE_REFSH_DES.TITLE
			}
		end

		var_25_1.des = string.format(L_ORDRE_REFSH_DES.DES, item_data[order_manager:getRefshItemId()].name)
		var_25_1.button = L_BATTLEPASS_BUY.button
		var_25_0.labels = var_25_1
		var_25_0.own = item_manager:getItemNumber(6821329)

		function var_25_0.surecallback()
			order_manager:refsh_order_right_now()
		end

		LayerManager:pushInLayer("PopDoLayer", var_25_0)
	end)

	local var_19_15 = cc.Label:createWithTTF("", FONT_DES, 46)

	var_19_15:setColor(cc.c3b(239, 242, 253))
	var_19_15:setPosition(cc.p(310, 90))
	var_19_15:setName("time_label")
	var_19_13:addChild(var_19_15)

	self.timeLabel = arg_19_1.id < 0 and var_19_15 or self.timeLabel

	var_19_13:setVisible(arg_19_1.id < 0)
	var_19_1:setVisible(arg_19_1.id > 0)

	return var_19_0
end

function SchoolOrderLayer:updateOrderSprite(arg_27_1, arg_27_2, arg_27_3)
	arg_27_1:loadTexture(arg_27_2.id > 0 and "SchoolOrderLayer/order_bg_1.png" or "SchoolOrderLayer/order_bg_2.png", var_0_3)
	arg_27_1:setOpacity(255)

	local var_27_0 = arg_27_1:getChildByName("order_panel")
	local var_27_1 = arg_27_1:getChildByName("wait_panel")

	var_27_0:getChildByName("quality_img"):loadTexture("SchoolOrderLayer/level_" .. arg_27_2.quality .. ".png", var_0_3)

	for iter_27_0 = 1, var_0_2 do
		self:updateItemSp(var_27_0:getChildByName("item_sp_" .. iter_27_0), arg_27_2.needlist[iter_27_0])
	end

	local var_27_2 = var_0_12(arg_27_2) and "SchoolOrderLayer/bg_get.png" or "SchoolOrderLayer/bg_undone.png"
	local var_27_3 = var_27_0:getChildByName("btn_get")
	local var_27_4 = drop_manager:getDropMsg(arg_27_2.dropid)
	local var_27_5

	if var_27_4.equips[1] then
		var_27_5 = var_27_4.equips[1].dropNum or nil

		local var_27_6

		if var_27_4.equips[1] then
			var_27_6 = var_27_4.equips[1].dropid or nil
		end
	end

	local var_27_7 = "equipment/" .. item_data[var_27_6].image_id .. ".png"

	if var_27_4.gold then
		var_27_5 = var_27_4.gold
		var_27_7 = "equipment/1000001.png"
	end

	var_27_3:getChildByName("drop_img"):loadTexture(var_27_7)
	var_27_3:loadTextures(var_27_2, var_27_2, var_27_2, var_0_3)
	var_27_3:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_0_12(arg_27_2) then
			return
		end

		self:playOrderchangeEffect(arg_27_1, function()
			order_manager:get_order_reward_by_index(arg_27_2.index)
		end)
	end)
	var_27_3:getChildByName("drop_num_lbl"):setString("x" .. global_trans_number(var_27_5))
	var_27_3:getChildByName("btn_delete"):addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopDoLayer", {
			labels = {
				title = L_ORDRE_DELETE_DES.TITLE,
				des = L_ORDRE_DELETE_DES.DES,
				button = L_BATTLEPASS_BUY.button
			},
			surecallback = function()
				self:playOrderchangeEffect(arg_27_1, function()
					order_manager:delete_order_by_index(arg_27_2.index)
				end)
			end
		})
	end)
	var_27_1:getChildByName("refsh_btn"):addTouchEventListener(function(arg_33_0, arg_33_1)
		local var_33_1
		local var_33_0

		if arg_33_1 ~= ccui.TouchEventType.ended then
			do return end

			var_33_0 = {
				cost = 1,
				costtype = 6821329
			}
			var_33_1 = {
				title = L_ORDRE_REFSH_DES.TITLE
			}
		end

		var_33_1.des = string.format(L_ORDRE_REFSH_DES.DES, item_data[order_manager:getRefshItemId()].name)
		var_33_1.button = L_BATTLEPASS_BUY.button
		var_33_0.labels = var_33_1
		var_33_0.own = item_manager:getItemNumber(6821329)

		function var_33_0.surecallback()
			order_manager:refsh_order_right_now()
		end

		LayerManager:pushInLayer("PopDoLayer", var_33_0)
	end)

	self.timeLabel = arg_27_2.id < 0 and var_27_1:getChildByName("time_label") or self.timeLabel

	var_27_1:setVisible(arg_27_2.id < 0)
	var_27_0:setVisible(arg_27_2.id > 0)
end

function SchoolOrderLayer.createItemSp(arg_35_0, arg_35_1)
	local var_35_0

	if arg_35_1 then
		var_35_0 = arg_35_1.needitem or nil

		local var_35_1

		if arg_35_1 then
			var_35_1 = WEAPON_BG_QUALITY_PATH[item_data[var_35_0].equip_quality] or "SchoolOrderLayer/frame_material.png"
		end
	end

	local var_35_2 = ccui.Button:create(var_35_1, var_35_1, var_35_1, var_0_3)
	local var_35_3 = var_35_0 and 0.5 or 0.8

	var_35_2:setScale(var_35_0 and 0.5 or 0.8)
	var_35_2:setSwallowTouches(false)

	local var_35_4 = ccui.ImageView:create("equipment/" .. item_data[var_35_0].image_id .. ".png")

	var_35_2:addChild(var_35_4)
	var_35_4:setName("icon")
	var_35_4:setVisible(var_35_0 ~= nil)
	var_35_4:setPosition(cc.p(var_35_2:getContentSize().width / 2, var_35_2:getContentSize().height / 2))

	local var_35_5 = ccui.ImageView:create("SchoolOrderLayer/iconbg.png", var_0_3)

	var_35_5:setPosition(cc.p(var_35_2:getContentSize().width / 2, -30))
	var_35_5:setName("num_bg")
	var_35_5:setVisible(var_35_0 ~= nil)
	var_35_5:setScale(1 / var_35_3)
	var_35_2:addChild(var_35_5)

	local var_35_7 = cc.Label:createWithTTF((var_35_0 or nil) and item_manager:getItemNumber(var_35_0) .. "/" .. arg_35_1.neednum, FONT_DES, 18)

	var_35_7:setPosition(cc.p(45, 11))
	var_35_7:setName("lbl_num")
	var_35_5:addChild(var_35_7)

	if arg_35_1 and item_manager:getItemNumber(var_35_0) >= arg_35_1.neednum then
		var_35_7:setColor(cc.c3b(4, 220, 96))
	else
		var_35_7:setColor(cc.c3b(255, 63, 81))
	end

	var_35_2:setTouchEnabled(true)
	var_35_2:addTouchEventListener(function(arg_36_0, arg_36_1)
		if math.abs(arg_36_0:getTouchBeganPosition().y - arg_36_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_35_0 then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			item = var_35_0
		})
	end)

	return var_35_2
end

function SchoolOrderLayer.updateItemSp(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0

	if arg_37_2 then
		var_37_0 = arg_37_2.needitem or nil

		local var_37_1

		if arg_37_2 then
			var_37_1 = WEAPON_BG_QUALITY_PATH[item_data[var_37_0].equip_quality] or "SchoolOrderLayer/frame_material.png"
		end
	end

	arg_37_1:loadTextures(var_37_1, var_37_1, var_37_1, var_0_3)

	local var_37_2 = var_37_0 and 0.5 or 0.8

	arg_37_1:setScale(var_37_0 and 0.5 or 0.8)

	local var_37_3 = "equipment/" .. item_data[var_37_0].image_id .. ".png"
	local var_37_4 = arg_37_1:getChildByName("icon")

	var_37_4:setVisible(var_37_0 ~= nil)
	var_37_4:loadTexture(var_37_3)
	var_37_4:setPosition(cc.p(arg_37_1:getContentSize().width / 2, arg_37_1:getContentSize().height / 2))

	local var_37_5 = arg_37_1:getChildByName("num_bg")

	var_37_5:setVisible(var_37_0 ~= nil)
	var_37_5:setPosition(cc.p(arg_37_1:getContentSize().width / 2, -30))
	var_37_5:setScale(1 / var_37_2)

	local var_37_6 = ""

	if var_37_0 then
		var_37_6 = item_manager:getItemNumber(var_37_0) .. "/" .. arg_37_2.neednum
	end

	local var_37_7 = var_37_5:getChildByName("lbl_num")

	var_37_7:setString(var_37_6)

	if arg_37_2 and item_manager:getItemNumber(var_37_0) >= arg_37_2.neednum then
		var_37_7:setColor(cc.c3b(4, 220, 96))
	else
		var_37_7:setColor(cc.c3b(255, 63, 81))
	end

	arg_37_1:addTouchEventListener(function(arg_38_0, arg_38_1)
		if math.abs(arg_38_0:getTouchBeganPosition().y - arg_38_0:getTouchEndPosition().y) > 50 then
			return
		end

		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_37_0 then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			item = var_37_0
		})
	end)
end

function SchoolOrderLayer:resigerTimeCountDownHandler()
	if self.scheduler then
		time_check_manager:removeUpdatePool(self.scheduler)

		self.scheduler = nil
	end

	if #self.orderList <= 10 and self.lastTime and self.lastTime > time_check_manager:getCurTime() then
		self.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(self.lastTime - time_check_manager:getCurTime(), function(arg_40_0)
			if self.timeLabel then
				self.timeLabel:setString((var_0_11(arg_40_0)))
			end

			if arg_40_0 <= 0 and self.scheduler then
				order_manager:get_order_info()
				time_check_manager:removeUpdatePool(self.scheduler)

				self.scheduler = nil
			end
		end)))
	end
end

function SchoolOrderLayer.playOrderchangeEffect(arg_41_0, arg_41_1, arg_41_2)
	arg_41_1:runAction(cc.Sequence:create(cc.FadeOut:create(0.4), cc.CallFunc:create(arg_41_2)))
end

function SchoolOrderLayer.playOrderAddEffect(arg_42_0, arg_42_1)
	local function var_42_0(arg_43_0, arg_43_1)
		return cc.Sequence:create(cc.EaseOut:create(cc.FadeOut:create(0.4), 0.4 * 0.7), cc.EaseIn:create(cc.FadeIn:create(0.4), 0.4 * 0.7))
	end

	arg_42_1:runAction(cc.Sequence:create(var_42_0(), var_42_0()))
end
