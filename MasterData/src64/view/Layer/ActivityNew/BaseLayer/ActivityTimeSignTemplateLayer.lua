ActivityTimeSignTemplateLayer = class("ActivityTimeSignTemplateLayer", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local audio_manager = require("controller.audio_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local activity_timesign_uiconfig_data = require("data.activity_timesign.uiconfig.activity_timesign_uiconfig_data")

require("view.Sprite.ConfirmDialogSprite")
require("view.Sprite.ItemSprite")

local var_0_9 = 0
local var_0_10 = 0
local var_0_11 = 1
local var_0_12

local function var_0_13(arg_2_0, arg_2_1)
	local var_2_0 = {
		pos = function(self, arg_3_1)
			if arg_3_1[2] then
				self:setPositionX(arg_3_1[1].x)
				self:setPositionY(arg_3_1[1].y + arg_3_1[2] * GameDisplay.fix_y)
			else
				self:setPosition(arg_3_1)
			end
		end,
		visible = function(self, arg_4_1)
			self:setVisible(arg_4_1)
		end,
		size = function(self, arg_5_1)
			self:setContentSize(arg_5_1)
		end,
		anchorpoint = function(self, arg_6_1)
			self:setAnchorPoint(arg_6_1)
		end,
		color = function(self, arg_7_1)
			self:setColor(arg_7_1)
		end,
		zorder = function(self, arg_8_1)
			self:setLocalZOrder(arg_8_1)
		end,
		scale = function(self, arg_9_1)
			self:setScale(arg_9_1)
		end,
		opacity = function(self, arg_10_1)
			self:setOpacity(arg_10_1)
		end,
		setSwallow = function(self, arg_11_1)
			self:setSwallowTouches(arg_11_1)
		end
	}

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		if var_2_0[iter_2_0] then
			var_2_0[iter_2_0](arg_2_0, iter_2_1)
		end

		arg_2_0[iter_2_0] = iter_2_1
	end
end

function ActivityTimeSignTemplateLayer:createCell()
	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(false)
	var_12_0:setContentSize(self.useConf.cell_clone.size)
	var_12_0:setAnchorPoint(cc.p(0, 0))
	var_12_0:setPosition(self.useConf.cell_clone.pos)
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_12_0:setVisible(true)
	var_12_0:setPosition(self.useConf.cell_clone.pos)

	for iter_12_0, iter_12_1 in pairs(self.useConf.cell_clone.child) do
		local var_12_1 = self:createNode(iter_12_0, iter_12_1)

		var_0_13(var_12_1, iter_12_1)
		var_12_0:addChild(var_12_1)
	end

	while ccui.Helper:seekWidgetByName(var_12_0, "btn_small_mask_" .. 1) do
		ccui.Helper:seekWidgetByName(var_12_0, "btn_small_mask_" .. 1):addTouchEventListener(self:getTouchHandel("btn_small_mask"))
		ccui.Helper:seekWidgetByName(var_12_0, "btn_small_mask_" .. 1):setTouchEnabled(true)
	end

	return var_12_0
end

function ActivityTimeSignTemplateLayer.createItemSprite(arg_13_0, arg_13_1)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setTouchEnabled(false)
	var_13_0:setContentSize(cc.size(100, 100))
	var_13_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_0:setPosition(arg_13_1.pos)
	var_13_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_13_0:setPosition(arg_13_1.pos)

	function var_13_0:update(arg_14_1, arg_14_2)
		self:getChildByName("itemsmallsprite"):updateSignItemByItemid(arg_14_1, arg_14_2)
	end

	function var_13_0:setInfoTouchEvent(arg_15_1)
		self:getChildByName("itemsmallsprite"):setInfoTouchEvent(arg_15_1)
	end

	local var_13_1 = ItemSpriteSign:createSignItem()

	var_13_1:setInfoTouchEvent(true)
	var_13_1:setSwallowTouches(false)
	var_13_1:setName("itemsmallsprite")
	var_13_1:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_1:setPositionY(var_13_0:getContentSize().height / 2)
	var_13_1:setItemUIConf({
		labelColor = cc.c3b(255, 255, 255)
	})
	var_13_0:addChild(var_13_1)

	return var_13_0
end

function ActivityTimeSignTemplateLayer:createTableviewSp(...)
	local var_16_0 = self:createCell()

	function var_16_0.update(arg_17_0, arg_17_1)
		local var_17_0 = time_check_manager:getCurTime()
		local var_17_1 = os.date("%Y-%m-%d", var_17_0)
		local var_17_2 = self.signlist[arg_17_1]
		local var_17_3 = parse_time(self.signlist[arg_17_1].sign_date .. " 00:00:00")

		ccui.Helper:seekWidgetByName(arg_17_0, "img_postcard"):loadTexture(self.signlist[arg_17_1].path)
		ccui.Helper:seekWidgetByName(arg_17_0, "text_titletime"):setString(string.format(L_DATE_TEXT, var_17_3.month, var_17_3.day) .. L_TIMESIGN_FREE_SERVICE)

		local var_17_5 = var_17_1 == var_17_2.sign_date and "cur" or var_17_1 > var_17_2.sign_date and "gone" or "will"

		if (var_17_1 == var_17_2.sign_date and "cur" or var_17_1 > var_17_2.sign_date and "gone" or "will") == "cur" then
			ccui.Helper:seekWidgetByName(arg_17_0, "img_big_mask"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_17_0, "text_lock"):setVisible(false)
		elseif var_17_5 == "gone" then
			ccui.Helper:seekWidgetByName(arg_17_0, "img_big_mask"):setVisible(false)
			ccui.Helper:seekWidgetByName(arg_17_0, "text_lock"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(arg_17_0, "img_big_mask"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "img_big_mask"):loadTexture(self:getPath(ccui.Helper:seekWidgetByName(arg_17_0, "img_big_mask").will_path))
			ccui.Helper:seekWidgetByName(arg_17_0, "text_lock"):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "text_lock"):setString((function()
				local var_18_5 = os.time(parse_time(var_17_2.sign_date .. " 00:00:00")) - time_check_manager:getCurTime()

				if var_18_5 < 0 then
					return "-1"
				end

				local var_18_6 = math.floor(var_18_5 / 24 / 3600)
				local var_18_7 = math.floor((var_18_5 - var_18_6 * 24 * 3600) / 3600)
				local var_18_8 = math.floor((var_18_5 - var_18_6 * 24 * 3600 - var_18_7 * 3600) / 60)

				return L_TIMESIGN_OPEN .. (var_18_6 ~= 0 and string.format(L_TIME_TEXT[1], var_18_6, var_18_7) or var_18_7 ~= 0 and string.format(L_TIME_TEXT[2], var_18_7, var_18_8) or string.format(L_TIME_TEXT[3], var_18_8))
			end)())
		end

		for iter_17_0, iter_17_1 in pairs(var_17_2.times) do
			ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0).id = tonumber(string.split(var_17_2.id, "-")[2])
			ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0).index = iter_17_1.index

			ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(true)
			ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):loadTexture(self:getPath(ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0).get_path))
			ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(true)

			if var_17_5 == "gone" then
				ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setInfoTouchEvent(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(false)

				if iter_17_1.status == var_0_11 then
					ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(false)
				else
					ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0):setVisible(true)
					ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setVisible(true)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(true)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):loadTexture(self:getPath(ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0).supplement_path))

					local var_17_6 = drop_manager:getDropMsg(iter_17_1.dropid)
					local var_17_7
					local var_17_8

					if var_17_6.diamond > 0 then
						var_17_7 = "diamond"
						var_17_8 = var_17_6.diamond
					end

					if var_17_6.gold > 0 then
						var_17_7 = "gold"
						var_17_8 = var_17_6.gold
					end

					if next(var_17_6.equips) then
						var_17_7 = var_17_6.equips[1].dropid
						var_17_8 = var_17_6.equips[1].dropNum
					end

					ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):update(var_17_7, var_17_8)
					ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(false)
				end
			elseif var_17_5 == "cur" then
				if iter_17_1.status == var_0_11 then
					ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(false)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(false)
				else
					local var_17_9 = drop_manager:getDropMsg(iter_17_1.dropid)
					local var_17_10
					local var_17_11

					if var_17_9.diamond > 0 then
						var_17_10 = "diamond"
						var_17_11 = var_17_9.diamond
					end

					if var_17_9.gold > 0 then
						var_17_10 = "gold"
						var_17_11 = var_17_9.gold
					end

					if next(var_17_9.equips) then
						var_17_10 = var_17_9.equips[1].dropid
						var_17_11 = var_17_9.equips[1].dropNum
					end

					ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):update(var_17_10, var_17_11)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(true)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):loadTexture(self:getPath(ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0).get_path))

					local var_17_12 = parse_time(var_17_2.sign_date .. " " .. string.split(iter_17_1.effective_time, ",")[1])
					local var_17_13 = parse_time(var_17_2.sign_date .. " " .. string.split(iter_17_1.effective_time, ",")[2])

					ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setString(string.format("%02d", var_17_12.hour) .. ":" .. string.format("%02d", var_17_12.min) .. "-" .. string.format("%02d", var_17_13.hour) .. ":" .. string.format("%02d", var_17_13.min))
					ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(true)
					ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(true)

					if var_17_0 > os.time(var_17_13) then
						ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):loadTexture(self:getPath(ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0).supplement_path))
						ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setInfoTouchEvent(false)
						ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(false)
						ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(false)
						ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(false)
					elseif var_17_0 >= os.time(var_17_12) and var_17_0 <= os.time(var_17_13) then
						ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):loadTexture(self:getPath(ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0).get_path))
						ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setInfoTouchEvent(false)
						ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(false)
					else
						ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(false)
						ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setInfoTouchEvent(true)
						ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(true)
					end
				end
			else
				ccui.Helper:seekWidgetByName(arg_17_0, "btn_small_mask_" .. iter_17_0):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "text_effective_time_" .. iter_17_0):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "img_effective_bg_" .. iter_17_0):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "img_tag_" .. iter_17_0):setVisible(false)
				ccui.Helper:seekWidgetByName(arg_17_0, "itemsmallsprite_" .. iter_17_0):setInfoTouchEvent(true)
				ccui.Helper:seekWidgetByName(arg_17_0, "img_item_mask_" .. iter_17_0):setVisible(false)
			end
		end
	end

	return var_16_0
end

function ActivityTimeSignTemplateLayer.createTableView(arg_19_0, arg_19_1)
	local var_19_0 = ccui.Layout:create()

	var_19_0:setTouchEnabled(true)

	var_19_0._setContentSize = var_19_0.setContentSize

	function var_19_0:setContentSize(arg_20_1)
		self:_setContentSize(arg_20_1)
		self:getChildByName("tableview"):setContentSize(arg_20_1)
	end

	var_19_0._setPosition = var_19_0.setPosition

	function var_19_0:setPosition(arg_21_1)
		self:_setPosition(arg_21_1)
	end

	function var_19_0:reloadData()
		self:getChildByName("tableview"):reloadData()
	end

	function var_19_0:scrollToPercent(arg_23_1, arg_23_2, arg_23_3)
		self:getChildByName("tableview"):scrollToPercent(arg_23_1, arg_23_2, arg_23_3)
	end

	function var_19_0:updateShowingCells()
		local var_24_0 = {}

		if arg_19_0.signlist then
			var_24_0.maxcount = #arg_19_0.signlist or 0
		end

		var_24_0.cellsize = arg_19_0.useConf.cell_clone.size

		local var_24_1, var_24_2 = GetTableViewShowCellIdx(self:getChildByName("tableview"), var_24_0)

		for iter_24_0 = var_24_1, var_24_2 do
			self:getChildByName("tableview"):updateCellAtIndex(iter_24_0)
		end
	end

	var_19_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

	local var_19_1 = cc.TableView:create(arg_19_1.size)

	var_19_1:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_19_1:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_19_1:setPosition(cc.p(0, 0))
	var_19_1:setDelegate()
	var_19_1:setName("tableview")
	var_19_0:addChild(var_19_1)
	var_19_1:registerScriptHandler(function(arg_26_0, arg_26_1)
		return arg_19_0.useConf.cell_clone.size.width, arg_19_0.useConf.cell_clone.size.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_19_1:registerScriptHandler(function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:dequeueCell() or cc.TableViewCell:create()

		if not var_25_0:getChildByName("sp") then
			local var_25_1 = arg_19_0:createTableviewSp()

			var_25_1:setName("sp")
			var_25_0:addChild(var_25_1)
		end

		var_25_0:getChildByName("sp"):update(arg_25_1 + 1)

		return var_25_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_19_1:registerScriptHandler(function(arg_27_0, arg_27_1)
		return (arg_19_0.signlist or nil) and (#arg_19_0.signlist or 0)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

	return var_19_0
end

function ActivityTimeSignTemplateLayer.createNode(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	for iter_28_0, iter_28_1 in pairs({
		img = function(...)
			return ccui.ImageView:create(arg_28_0:getPath(arg_28_2.path), var_0_9)
		end,
		text = function(...)
			return ccui.Text:create("nodename", arg_28_2.font or FONT_DES, arg_28_2.fontsize or 20)
		end,
		btn = function(...)
			return ccui.Button:create(arg_28_0:getPath(arg_28_2.path), arg_28_0:getPath(arg_28_2.path_on or arg_28_2.path), arg_28_0:getPath(arg_28_2.path), var_0_9)
		end,
		itemsmallsprite = function(...)
			return arg_28_0:createItemSprite(arg_28_2)
		end,
		tableview = function(...)
			return arg_28_0:createTableView(arg_28_2)
		end
	}) do
		if string.find(arg_28_1, iter_28_0) then
			var_28_0 = iter_28_1()
		end
	end

	if not var_28_0 then
		print(arg_28_1 .. "没有找对对应的预定义类型")

		var_28_0 = cc.Node:create()
	end

	var_28_0:setName(arg_28_1)

	return var_28_0
end

local var_0_14 = {}

function ActivityTimeSignTemplateLayer.create(arg_34_0, arg_34_1)
	local var_34_0 = ActivityTimeSignTemplateLayer.new(arg_34_1)

	var_34_0:initBg(arg_34_1)

	return var_34_0
end

function ActivityTimeSignTemplateLayer:initUIConfData()
	self.id = self.initParam.activityid
	self.templateuipath = "activitiesRes/activitytemplate/timesign/"
	self.activityuipath = "activitiesRes/activity" .. self.id .. "/timesign/"
end

function ActivityTimeSignTemplateLayer:getPath(arg_36_1)
	local var_36_0

	if not var_0_14[arg_36_1] then
		var_36_0 = cc.FileUtils:getInstance():isFileExist(self.activityuipath .. arg_36_1) and self.activityuipath .. arg_36_1 or self.templateuipath .. arg_36_1
		var_0_14[arg_36_1] = var_36_0
	else
		var_36_0 = var_0_14[arg_36_1]
	end

	return var_36_0
end

function ActivityTimeSignTemplateLayer:init(arg_37_1)
	self.initParam = arg_37_1

	self:initUIConfData()
	self:initData()
	self:initUI()
	self:updateData(function(...)
		ccui.Helper:seekWidgetByName(self.rootLayer, "tableview"):reloadData()
		self:updateUI()
		self:scrollTableView()
	end)
	self:playInEffect()
	self:registerScriptHandler(function(arg_39_0)
		if arg_39_0 == "exit" then
			if arg_37_1.exitcallback then
				arg_37_1.exitcallback()
			end

			if self.timekey then
				time_check_manager:removeUpdatePool(self.timekey)
			end

			var_0_12 = nil
		end
	end)

	var_0_12 = self
end

function ActivityTimeSignTemplateLayer.initData(arg_40_0)
	return
end

function ActivityTimeSignTemplateLayer:updateData(arg_41_1)
	activity_manager:get_activity_timesign(self.id, function(arg_42_0)
		if not var_0_12 then
			return
		end

		self.signlist = arg_42_0.signlist

		if arg_41_1 then
			arg_41_1()
		end
	end)
end

function ActivityTimeSignTemplateLayer:initUI(...)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playOutEffect()
	end)
	self:addChild(self.rootLayer, -1)
	self:addUI()
	self:registerTouchEvent()

	local var_43_0 = parse_time(activity_manager:get_module_starttime(self.id, "timesign"))
	local var_43_1 = parse_time(activity_manager:get_module_finishtime(self.id, "timesign"))

	self.text_time:setString(string.format(L_TIMESIGN_TIME, var_43_0.month, var_43_0.day, var_43_1.month, var_43_1.day))

	local var_43_2 = ccui.Layout:create()

	var_43_2:setTouchEnabled(true)
	var_43_2:setContentSize(cc.size(self.img_bg:getContentSize().width, 200))
	var_43_2:setPositionX(self.img_bg:getPositionX() - self.img_bg:getContentSize().width / 2)
	var_43_2:setPositionY(self.img_bg:getPositionY() - self.img_bg:getContentSize().height / 2 - var_43_2:getContentSize().height)
	var_43_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_43_2:setTouchEnabled(true)
	var_43_2:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playOutEffect()
	end)
	self.rootLayer:addChild(var_43_2, 100)
end

function ActivityTimeSignTemplateLayer:updateUI(...)
	ccui.Helper:seekWidgetByName(self.rootLayer, "tableview"):updateShowingCells()
end

function ActivityTimeSignTemplateLayer:addUI(...)
	local var_47_0 = {}

	;(function(...)
		for iter_48_0, iter_48_1 in pairs(activity_timesign_uiconfig_data.template) do
			var_47_0 = var_47_0 or {}

			for iter_48_2, iter_48_3 in pairs(iter_48_1) do
				var_47_0[iter_48_0] = var_47_0[iter_48_0] or {}
				var_47_0[iter_48_0][iter_48_2] = activity_timesign_uiconfig_data[self.id] and activity_timesign_uiconfig_data[self.id][iter_48_0] and activity_timesign_uiconfig_data[self.id][iter_48_0][iter_48_2] and activity_timesign_uiconfig_data[self.id][iter_48_0][iter_48_2] or iter_48_3
			end
		end

		self.useConf = var_47_0
	end)()

	for iter_47_0, iter_47_1 in pairs(var_47_0) do
		if iter_47_0 ~= "cell_clone" then
			local var_47_1 = self:createNode(iter_47_0, iter_47_1)

			if var_47_1 then
				var_0_13(var_47_1, iter_47_1)

				self[iter_47_0] = var_47_1

				self.rootLayer:addChild(self[iter_47_0])
			else
				print("not find register create function:", iter_47_0)
			end
		end
	end
end

function ActivityTimeSignTemplateLayer:registerTouchEvent()
	for iter_49_0, iter_49_1 in pairs(self.useConf) do
		local var_49_0 = self:getTouchHandel(iter_49_0)

		if var_49_0 then
			ccui.Helper:seekWidgetByName(self.rootLayer, iter_49_0):addTouchEventListener(var_49_0)
		end
	end
end

function ActivityTimeSignTemplateLayer.getTouchHandel(arg_50_0, arg_50_1)
	if not string.find(arg_50_1, "btn") then
		return
	end

	local var_50_0 = {
		btn_small_mask = function(self, arg_51_1)
			if arg_51_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(self:getTouchBeganPosition().y - self:getTouchEndPosition().y) > 50 then
				return
			end

			local var_51_0 = time_check_manager:getCurTime()
			local var_51_1 = os.date("%Y-%m-%d", var_51_0)
			local var_51_2 = arg_50_0.signlist[self.id]
			local var_51_3 = self.id
			local var_51_4 = self.index

			if var_51_0 < os.time(parse_time(arg_50_0.signlist[self.id].sign_date .. " " .. string.split(arg_50_0.signlist[self.id].times[self.index].effective_time, ",")[1])) then
				global_ShowBlockWords(L_SIGN_WARNING[3])

				return
			end

			if arg_50_0.signlist[self.id].times[self.index].status == var_0_10 and var_51_0 > os.time(parse_time(arg_50_0.signlist[self.id].sign_date .. " " .. string.split(arg_50_0.signlist[self.id].times[self.index].effective_time, ",")[2])) and arg_50_0.signlist[self.id].cansupplement == 1 and arg_50_0.signlist[self.id].supplementcurrency == 0 and arg_50_0.signlist[self.id].times[self.index].supplementcost > 0 then
				local var_51_5 = ConfirmDialogSprite:create(L_SOULS_CONFIRM_DIALOG[1], string.format(L_TIMESIGN_SUPPLEMENT, arg_50_0.signlist[self.id].times[self.index].supplementcost), {
					layerType = "HorcruxInfoLayerNew",
					surecallback = function(...)
						if playermodel.diamond < var_51_2.times[self.index].supplementcost then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 1
							})
						else
							arg_50_0:do_timesign(var_51_3, var_51_4)
						end
					end
				})

				var_51_5:setPositionY(var_51_5:getPositionY() - GameDisplay.fix_y)
				arg_50_0:addChild(var_51_5, 10)
			else
				arg_50_0:do_timesign(self.id, self.index)
			end
		end,
		btn_return = function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:removePopLayer()
		end,
		null = function(arg_54_0, arg_54_1)
			if arg_54_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("该组件未注册有效点击事件")
		end
	}

	return var_50_0[arg_50_1] or var_50_0.null
end

function ActivityTimeSignTemplateLayer:do_timesign(arg_55_1, arg_55_2)
	if self.waitnet then
		return
	end

	self.waitnet = true

	activity_manager:do_timesign(self.id, arg_55_1, arg_55_2, function(arg_56_0)
		if not var_0_12 then
			return
		end

		if arg_56_0.result == 1 then
			self.signlist = arg_56_0.signlist

			self:updateUI()
		end

		self.waitnet = false
	end)
end

function ActivityTimeSignTemplateLayer.scrollTableView(arg_57_0)
	return
end

function ActivityTimeSignTemplateLayer:playInEffect(...)
	self.rootLayer:setOpacity(0)
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - 100)
	self.rootLayer:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.1, cc.p(0, 100)), cc.FadeIn:create(0.1)), cc.CallFunc:create(function(...)
		if callback then
			callback()
		end
	end)))
end

function ActivityTimeSignTemplateLayer:playOutEffect(...)
	self.rootLayer:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.1, cc.p(0, -100)), cc.FadeOut:create(0.1)), cc.CallFunc:create(function(...)
		LayerManager:removePopLayer()
	end)))
end

function ActivityTimeSignTemplateLayer:initBg(arg_62_1)
	local var_62_0 = ccui.Layout:create()

	var_62_0:setTouchEnabled(true)
	var_62_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_62_0:setAnchorPoint(cc.p(0, 0))
	var_62_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_62_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_62_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_62_0:setOpacity(0)
	self:addChild(var_62_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_63_0)
		self:addChild(arg_63_0, -2)
		arg_63_0:setPositionY(arg_63_0:getPositionY() - GameDisplay.fix_y)

		local var_63_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_63_0:setAnchorPoint(cc.p(0, 0))
		var_63_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_63_0, -1)
		self:init(arg_62_1)
		var_62_0:setOpacity(102)
		var_62_0:setTouchEnabled(false)
	end)
end

return ActivityTimeSignTemplateLayer
