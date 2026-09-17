ActivityPassLevelTaskTemplateLayer = class("ActivityPassLevelTaskTemplateLayer", function()
	return PopBaseLayer:create()
end)

local item_data = require("data.item_data")
local task_data = require("data.task_data")
local activity_passlevel_uiconfig_data = require("data.activity_task.uiconfig.activity_passlevel_uiconfig_data")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local var_0_6 = {}

local function var_0_7(arg_2_0, arg_2_1)
	local var_2_0 = {
		pos = function(self, arg_3_1)
			self:setPosition(arg_3_1)
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
		font_size = function(self, arg_10_1)
			self:setFontSize(arg_10_1)
		end,
		textareasize = function(self, arg_11_1)
			self:setTextAreaSize(arg_11_1)
		end
	}

	assert(arg_2_1, arg_2_0:getName())

	for iter_2_0, iter_2_1 in pairs(arg_2_1) do
		if var_2_0[iter_2_0] then
			var_2_0[iter_2_0](arg_2_0, iter_2_1)
		end

		arg_2_0[iter_2_0] = iter_2_1
	end
end

function ActivityPassLevelTaskTemplateLayer:getPath(arg_12_1)
	local var_12_0

	if not var_0_6[self.activityPath .. arg_12_1] then
		var_12_0 = cc.FileUtils:getInstance():isFileExist(self.activityPath .. arg_12_1) and self.activityPath .. arg_12_1 or self.templatePath .. arg_12_1
		var_0_6[self.activityPath .. arg_12_1] = var_12_0
	else
		var_12_0 = var_0_6[self.activityPath .. arg_12_1]
	end

	return var_12_0
end

function ActivityPassLevelTaskTemplateLayer:getUiConf(arg_13_1)
	local var_13_0 = activity_passlevel_uiconfig_data[self.activityid] and (activity_passlevel_uiconfig_data[self.activityid][arg_13_1] or activity_passlevel_uiconfig_data.template[arg_13_1]) or activity_passlevel_uiconfig_data.template[arg_13_1]

	if not var_13_0 then
		print(string.format("data.activity_task.uiconfig.activity_passlevel_uiconfig_data %s is nil", arg_13_1))
	end

	return var_13_0
end

function ActivityPassLevelTaskTemplateLayer.create(arg_14_0, arg_14_1)
	local var_14_0 = ActivityPassLevelTaskTemplateLayer.new()

	var_14_0:initBg(arg_14_1)

	return var_14_0
end

function ActivityPassLevelTaskTemplateLayer:init(arg_15_1)
	self.initconfig = arg_15_1
	self.templatePath = "activitiesRes/activitytemplate/passleveltask/"
	self.activityPath = "activitiesRes/activity" .. arg_15_1.activityid .. "/passleveltask/"
	self.exitcallback = arg_15_1.exitcallback
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(cc.size(640, GameDisplay.height))
	self.rootpanel:setTouchEnabled(false)
	self.rootLayer:addChild(self.rootpanel, 10)

	local var_15_0 = ccui.Layout:create()

	var_15_0:setContentSize(cc.size(640, GameDisplay.height))
	var_15_0:setTouchEnabled(true)
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_15_0:setPositionY(-GameDisplay.fix_y)
	self.rootLayer:addChild(var_15_0)
	var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_0:isBright() then
			return
		end

		arg_16_0:setBright(false)
		self.hideActions.moveFadeOut(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.moveFadeIn(self)
	self:initData()
	self:initUI()
	self:updateData(function(...)
		self:updateUI()
	end)
	self:_test()
end

function ActivityPassLevelTaskTemplateLayer:initData(...)
	self.activityid = self.initconfig.activityid
	self.usemodule = "pass_level"
end

function ActivityPassLevelTaskTemplateLayer:updateData(arg_20_1)
	activity_manager:getActivityTaskList(self.activityid, nil, function(arg_21_0, arg_21_1)
		self.tasklist = arg_21_1.list

		table.sort(self.tasklist, function(arg_22_0, arg_22_1)
			return task_data[arg_22_0.taskid].order < task_data[arg_22_1.taskid].order
		end)
		self:updateAlert()

		if arg_20_1 then
			arg_20_1()
		end
	end, false, nil, self.usemodule)
end

function ActivityPassLevelTaskTemplateLayer:updateAlert()
	activity_manager:update_alert(self.activityid, self.usemodule, self.tasklist)
end

function ActivityPassLevelTaskTemplateLayer:initUI(...)
	self.bg = ccui.ImageView:create(self:getPath("img_bg.png"))

	self.bg:setTouchEnabled(true)
	var_0_7(self.bg, self:getUiConf("bg"))
	self.rootpanel:addChild(self.bg)

	self.close = ccui.Button:create(self:getPath("btn_close.png"), nil, nil)

	var_0_7(self.close, self:getUiConf("btn_close"))
	self.rootpanel:addChild(self.close)
	self.close:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_25_0:isBright() then
			return
		end

		arg_25_0:setBright(false)
		self:exit()
	end)
end

function ActivityPassLevelTaskTemplateLayer:updateUI(...)
	self:updateShowingCells()
end

function ActivityPassLevelTaskTemplateLayer:createSp(...)
	local var_27_0 = ccui.Layout:create()

	var_0_7(var_27_0, self:getUiConf("cell"))
	var_27_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)

	local var_27_1 = ccui.ImageView:create(self:getPath("btn_cellbg.png"))

	var_27_1:setPositionX(var_27_0:getContentSize().width / 2)
	var_27_1:setPositionY(var_27_0:getContentSize().height / 2)
	var_27_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_27_1:setName("btn_cellbg")
	var_27_0:addChild(var_27_1)

	local var_27_2 = ccui.Layout:create()

	var_27_2:setTouchEnabled(false)
	var_27_2:setContentSize(self:getUiConf("cell_mask").size)
	var_27_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_27_2:setPosition(cc.p(var_27_0:getContentSize().width / 2, var_27_0:getContentSize().height / 2))
	var_27_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_27_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_27_2:setBackGroundColorOpacity(85)
	var_27_2:setName("cell_mask")
	var_27_0:addChild(var_27_2, self:getUiConf("cell_mask").zorder)

	local var_27_3 = ItemPurchaseSprite:createPurchaseItem()

	var_27_3:setName("item_sp")
	var_0_7(var_27_3, self:getUiConf("item_sp"))
	var_27_3:setInfoTouchEvent(true)
	var_27_3:setSwallowTouches(false)
	var_27_0:addChild(var_27_3)

	local var_27_4 = ccui.Text:create("", self:getUiConf("text_task_name").font_name or FONT_NAME, self:getUiConf("text_task_name").font_size)

	var_27_4:setName("text_task_name")
	var_0_7(var_27_4, self:getUiConf("text_task_name"))
	var_27_0:addChild(var_27_4)

	local var_27_5 = ccui.Text:create("", self:getUiConf("text_task_des").font_name or FONT_DES, self:getUiConf("text_task_des").font_size)

	var_27_5:setName("text_task_des")
	var_0_7(var_27_5, self:getUiConf("text_task_des"))
	var_27_0:addChild(var_27_5)

	local var_27_6 = ccui.Button:create(self:getPath("btn_got.png"))

	var_27_6:setName("btn_get_award")
	var_27_6:setSwallowTouches(false)
	var_0_7(var_27_6, self:getUiConf("btn_get_award"))
	var_27_0:addChild(var_27_6, self:getUiConf("btn_get_award").zorder)
	var_27_6:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_28_0:getTouchBeganPosition().y - arg_28_0:getTouchEndPosition().y) > 50 then
			return
		end

		if not arg_28_0:isBright() then
			return
		end

		arg_28_0:setBright(false)
		self:getAward(arg_28_0.id, function()
			arg_28_0:setBright(true)
		end)
	end)

	function var_27_0:update(arg_30_1)
		self.id = arg_30_1

		local var_30_0 = self.tasklist[arg_30_1]
		local var_30_1 = task_data[self.tasklist[arg_30_1].taskid].drop
		local var_30_2 = self.tasklist[arg_30_1].status

		self:getChildByName("btn_get_award").id = arg_30_1

		self:getChildByName("text_task_name"):setString(task_data[self.tasklist[arg_30_1].taskid].name)
		self:getChildByName("text_task_des"):setString(task_data[self.tasklist[arg_30_1].taskid].task_des)
		self:getChildByName("cell_mask"):setVisible(false)
		;(function(...)
			local var_31_0 = drop_manager:getDropMsg(var_30_1)
			local var_31_1 = {}

			if var_31_0.diamond > 0 then
				table.insert(var_31_1, {
					itemid = "diamond",
					num = var_31_0.diamond,
					name = L_DIAMOND
				})
			end

			if var_31_0.gold > 0 then
				table.insert(var_31_1, {
					itemid = "gold",
					num = var_31_0.gold,
					name = L_GOLD
				})
			end

			local var_31_2 = {}

			for iter_31_0, iter_31_1 in pairs(var_31_0.equips) do
				table.insert(var_31_2, {
					itemid = iter_31_1.dropid,
					num = iter_31_1.dropNum,
					name = item_data[iter_31_1.dropid].name
				})
			end

			for iter_31_2, iter_31_3 in pairs(var_31_2) do
				table.insert(var_31_1, iter_31_3)
			end

			self:getChildByName("item_sp"):updatePurchaseItemByItemid(var_31_1[1].itemid, var_31_1[1].num)
		end)()
		;(function(...)
			if var_30_0 and var_30_0.percent and var_30_0.percent < 100 then
				ccui.Helper:seekWidgetByName(self, "btn_get_award"):loadTextures(self:getPath("btn_goto.png"), self:getPath("btn_goto.png"), self:getPath("btn_goto.png"))
			end

			if var_30_0 and var_30_0.percent and var_30_0.percent == 100 then
				ccui.Helper:seekWidgetByName(self, "btn_get_award"):loadTextures(self:getPath("btn_get_award.png"), self:getPath("btn_get_award.png"), self:getPath("btn_get_award.png"))
			end

			if var_30_2 == 1 then
				ccui.Helper:seekWidgetByName(self, "btn_get_award"):loadTextures(self:getPath("btn_got.png"), self:getPath("btn_got.png"), self:getPath("btn_got.png"))
				self:getChildByName("cell_mask"):setVisible(true)
			end
		end)()
	end

	return var_27_0
end

function ActivityPassLevelTaskTemplateLayer:updateShowingCells(...)
	if not self.tableView then
		self:createTableview()
	end

	local var_33_0, var_33_1 = GetTableViewShowCellIdx(self.tableView, {
		cellsize = self:getUiConf("cell").size,
		maxcount = #self.tasklist
	})

	for iter_33_0 = var_33_0, var_33_1 do
		self.tableView:updateCellAtIndex(iter_33_0)
	end
end

function ActivityPassLevelTaskTemplateLayer:createTableview(...)
	self.tableView = cc.TableView:create(self:getUiConf("tableView").size)

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(self:getUiConf("tableView").pos)
	self.tableView:setDelegate()
	self.rootpanel:addChild(self.tableView, self:getUiConf("tableView").zorder)
	self.tableView:registerScriptHandler(function(arg_36_0, arg_36_1)
		local var_36_0 = self:getUiConf("cell").size

		return var_36_0.width, var_36_0.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_35_0, arg_35_1)
		local var_35_0 = arg_35_0:dequeueCell() or cc.TableViewCell:create()

		if not var_35_0:getChildByName("sp") then
			local var_35_1 = self:createSp()

			var_35_1:setName("sp")
			var_35_1:setAnchorPoint(cc.p(0, 0))
			var_35_1:setPosition(cc.p(0, self:getUiConf("cell_row_space") / 2))
			var_35_0:addChild(var_35_1)
		end

		var_35_0:getChildByName("sp"):update(arg_35_1 + 1)

		return var_35_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_37_0, arg_37_1)
		return #self.tasklist
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function ActivityPassLevelTaskTemplateLayer:getAward(arg_38_1, arg_38_2)
	if self.tasklist[arg_38_1].status == 1 then
		global_ShowBlockWords("已领取")

		if arg_38_2 then
			arg_38_2()
		end

		return
	end

	activity_manager:getTaskReward(self.activityid, self.tasklist[arg_38_1].taskid, function(arg_39_0, arg_39_1)
		if arg_39_0 == 1 then
			global_gain(arg_39_1)
			self:updateData(function(...)
				self:updateUI()

				if arg_38_2 then
					arg_38_2()
				end
			end)
		elseif arg_39_0 == 3 then
			goto_complete_system({
				jump_to_system = task_data[self.tasklist[1].taskid].jump
			})

			if arg_38_2 then
				arg_38_2()
			end
		end
	end)
end

function ActivityPassLevelTaskTemplateLayer:initBg(arg_41_1)
	local var_41_0 = ccui.Layout:create()

	var_41_0:setTouchEnabled(false)
	var_41_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_41_0:setAnchorPoint(cc.p(0, 0))
	var_41_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_41_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_41_0:setOpacity(0)
	self:addChild(var_41_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_42_0)
		self:addChild(arg_42_0, -2)
		arg_42_0:setPositionY(arg_42_0:getPositionY() - GameDisplay.fix_y)

		local var_42_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_42_0:setAnchorPoint(cc.p(0, 0))
		var_42_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_42_0, -1)
		self:init(arg_41_1)
		var_41_0:setOpacity(102)
		var_41_0:setTouchEnabled(false)
	end)
end

function ActivityPassLevelTaskTemplateLayer:exit(...)
	self.hideActions.moveFadeOut(self, function()
		if self.exitcallback and MainLayer and MainLayer.getInstance() then
			self.exitcallback(0)

			self.exitcallback = nil
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function ActivityPassLevelTaskTemplateLayer._test(arg_45_0, ...)
	if config._DEBUG then
		-- block empty
	end
end

return ActivityPassLevelTaskTemplateLayer
