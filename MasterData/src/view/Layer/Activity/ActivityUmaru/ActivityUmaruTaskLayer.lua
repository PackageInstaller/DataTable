ActivityUmaruTaskLayer = class("ActivityUmaruTaskLayer", function()
	return cc.Layer:create()
end)

local task_data = require("data.task_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local activity_umaru_BP_task_index_data = require("data.activity_umaru_BP_task_index_data")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_10 = 180

function ActivityUmaruTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityUmaruTaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityUmaruTaskLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TaskLayer.json" or "TaskLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.id = 154

	self:initUI()
	self:registerActivityEventListener()
	self:switchPlotTaskClass(1)
	self:getActivityTaskListBecauseOfAlert()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if self.taskPanel then
				self.taskPanel:release()
			end

			activity_manager:releaseEventListenerByName("ActivityUmaruTaskLayer")
		end
	end)
end

function ActivityUmaruTaskLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityUmaruTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		arg_5_0:updateTaskView()
		arg_5_0:updateTaskBtnAlert()
	end)
end

function ActivityUmaruTaskLayer:initUI()
	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "label_exp")

	self.taskPanel:retain()

	local var_7_0 = ccui.Button:create("ActivityUmaruTaskLayer/button_gray.png", nil, "ActivityUmaruTaskLayer/button_gray.png", var_0_7)

	var_7_0:setPosition(cc.p(self.taskPanel:getChildByName("button_goto"):getPositionX(), self.taskPanel:getChildByName("button_goto"):getPositionY()))
	var_7_0:setName("button_gray")
	self.taskPanel:addChild(var_7_0)
	self.taskPanel:removeFromParent()

	self.titleSprite = TitleSprite:create("TaskLayer/title.png", 2, "TaskLayer/top_bg.png")

	self.rootLayer:addChild(self.titleSprite)

	self.bottomList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.rootLayer:addChild(self.bottomList, 5)

	self.completeLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "complete_label")

	self.completeLabel:setVisible(false)

	self.diamondPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_diamond")

	self.diamondPanel:setVisible(false)
	self:createSwitchBtnList()
	self:fullScreen()
end

function ActivityUmaruTaskLayer:createSwitchBtnList()
	self.classBnts = {}
	self.btnsByStage = {}
	self.dropListView = ccui.ListView:create()

	self.dropListView:setDirection(ccui.ListViewDirection.vertical)
	self.dropListView:setItemsMargin(6)
	self.dropListView:setAnchorPoint(cc.p(0, 0))
	self.dropListView:setPosition(0, 80)
	self.dropListView:setContentSize(cc.size(100, 990 + GameDisplay.height - 1136))
	self.rootLayer:addChild(self.dropListView, 4)
end

function ActivityUmaruTaskLayer:switchPlotTaskClass(arg_10_1)
	arg_10_1 = arg_10_1 or self.curClassType

	if self.curClassType == arg_10_1 then
		return
	end

	for iter_10_0, iter_10_1 in pairs(self.classBnts) do
		iter_10_1:setBright(iter_10_0 ~= arg_10_1)
	end

	self.curClassType = arg_10_1
	global_button_lock = true

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		global_button_lock = false
	end)))
	self:getActivityTaskByStage()
end

function ActivityUmaruTaskLayer:updateTaskView()
	if not self.taskList then
		return
	end

	if self.taskView then
		self.taskView:reloadData()

		return
	end

	local var_12_0 = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 70, TRANSFORM_UNIT.PX)

	self.taskView = cc.TableView:create(cc.size(589, 1000 + GameDisplay.height - 1136))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(80, var_12_0)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView, 5)
	self.taskView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return 640, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			local var_14_1 = self:createTaskInfoPanel(self.taskList[arg_14_1 + 1], arg_14_1)

			var_14_1:setName("taskinfo")
			var_14_1:setPosition(cc.p(0, 25))
			var_14_0:addChild(var_14_1)
		else
			var_14_0:getChildByName("taskinfo"):updateTaskInfo(self.taskList[arg_14_1 + 1])
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskView:reloadData()
end

local function var_0_11(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ccui.ImageView:create(arg_16_0, var_0_7)

	if arg_16_2 then
		var_16_0:setContentSize(arg_16_2)
		var_16_0:ignoreContentAdaptWithSize(false)
	end

	local var_16_1 = cc.Label:createWithTTF(arg_16_1, "fonts/new1.ttf", 20)

	var_16_1:setColor(cc.c3b(171, 239, 58))
	var_16_1:setAnchorPoint(cc.p(0, 0.5))
	var_16_1:setPosition(var_16_0:getContentSize().width, var_16_0:getContentSize().height / 2)
	var_16_0:addChild(var_16_1)

	local var_16_2 = ccui.Layout:create()

	var_16_2:setContentSize(cc.size(var_16_0:getContentSize().width + var_16_1:getContentSize().width, var_16_0:getContentSize().height))
	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(0, 0)
	var_16_2:addChild(var_16_0)

	return var_16_2
end

local function var_0_12(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = cc.Label:createWithTTF(arg_17_0 .. " X" .. arg_17_1, "fonts/new1.ttf", 20)

	var_17_0:setColor(cc.c3b(171, 239, 58))
	var_17_0:setAnchorPoint(cc.p(0, 0.5))
	var_17_0:setPosition(0, arg_17_2.height / 2)

	local var_17_1 = ccui.Layout:create()

	var_17_1:setContentSize(cc.size(arg_17_2.width, arg_17_2.height))
	var_17_1:addChild(var_17_0)

	return var_17_1
end

function ActivityUmaruTaskLayer:createTaskInfoPanel(arg_18_1, arg_18_2)
	local var_18_0 = self.taskPanel:clone()

	var_18_0:getChildByName("des"):setContentSize(cc.size(200, 100))

	var_18_0.index = arg_18_2

	var_18_0:getChildByName("button_goto"):setName("button_goto_" .. var_18_0.index)

	function var_18_0:updateTaskInfo(arg_19_1)
		if arg_19_1.percent then
			self:updateTriggeredTask(arg_19_1)
		else
			self:updateFinishedTask(arg_19_1)
		end
	end

	function var_18_0:updateFinishedTask(arg_20_1)
		local var_20_0 = task_data[arg_20_1.taskid]

		if task_data[arg_20_1.taskid] and var_20_0.medal_id then
			local var_20_3 = self:getChildByName("medal")

			if not var_20_3 then
				var_20_3 = createMedal()

				var_20_3:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_20_3:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_20_3)
			end

			var_20_3:setVisible(true)

			local var_20_4 = item_data[tonumber(var_20_0.medal_id)]

			var_20_3:setTexture((item_data[itemid].bg or nil) and ("equipment/" .. var_20_4.bg .. ".png" or medal_frame[var_20_4.equip_quality]))
			var_20_3:setString(var_20_4.name)
			var_20_3:enableOutline(medal_colors[var_20_4.equip_quality], 1)
			var_20_3:enableShadow(medal_colors[var_20_4.equip_quality], cc.size(0, 0))
		elseif self:getChildByName("medal") then
			self:getChildByName("medal"):removeFromParent()
		end

		if self:getChildByName("item_sp") then
			self:getChildByName("item_sp"):removeFromParent()
		end

		local var_20_7 = drop_manager:getDropMsg(var_20_0.drop)

		if not next(var_20_7.equips) and var_20_7.diamond > 0 then
			var_20_7.equips[1] = {
				dropid = "diamond"
			}
		end

		local var_20_8 = ItemPurchaseSprite:createPurchaseItem(var_20_7.equips[1].dropid)
		local var_20_9 = self:getChildByName("Image_task")

		var_20_8:setName("item_sp")
		var_20_8:setScale(0.5)
		var_20_8:setPosition(cc.p(var_20_9:getPositionX(), var_20_9:getPositionY()))
		self:addChild(var_20_8)
		var_20_8:setTouchEnabled(true)
		var_20_8:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_20_7.equips[1].dropid)
		end)
		self:getChildByName("name"):setString(var_20_0.name)
		self:getChildByName("des"):setString(var_20_0.task_des)
		self:getChildByName("Image_task"):setVisible(false)
		self:getChildByName("button_goto_" .. self.index):setVisible(false)
		self:getChildByName("button_getAwards"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
		self:getChildByName("ProgressBar"):setVisible(false)
		self:getChildByName("button_gray"):setVisible(false)
		self:updateAwardList(var_20_0.drop)
	end

	function var_18_0:updateTriggeredTask(arg_22_1)
		if arg_22_1.medal_id then
			local var_22_1 = self:getChildByName("medal")

			if not var_22_1 then
				var_22_1 = createMedal()

				var_22_1:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_22_1:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_22_1)
			end

			local var_22_2 = item_data[tonumber(arg_22_1.medal_id)]

			var_22_1:setVisible(true)
			var_22_1:setString(var_22_2.name)
			var_22_1:enableOutline(medal_colors[var_22_2.equip_quality], 1)
			var_22_1:enableShadow(medal_colors[var_22_2.equip_quality], cc.size(0, 0))

			if item_data[itemid].bg then
				-- block empty
			end
		elseif self:getChildByName("medal") then
			self:getChildByName("medal"):removeFromParent()
		end

		if self:getChildByName("item_sp") then
			self:getChildByName("item_sp"):removeFromParent()
		end

		local var_22_4 = drop_manager:getDropMsg(arg_22_1.drop)

		if not next(var_22_4.equips) and var_22_4.diamond > 0 then
			var_22_4.equips[1] = {
				dropid = "diamond"
			}
		end

		local var_22_5 = ItemPurchaseSprite:createPurchaseItem(var_22_4.equips[1].dropid)
		local var_22_6 = self:getChildByName("Image_task")

		var_22_5:setName("item_sp")
		var_22_5:setScale(0.5)
		var_22_5:setPosition(cc.p(var_22_6:getPositionX(), var_22_6:getPositionY()))
		self:addChild(var_22_5)
		var_22_5:setTouchEnabled(true)
		var_22_5:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_22_4.equips[1].dropid)
		end)
		self:getChildByName("name"):setString(arg_22_1.name)
		self:getChildByName("des"):setString(arg_22_1.des)
		self:getChildByName("button_done"):setVisible(false)
		self:getChildByName("Image_task"):setVisible(false)
		self:getChildByName("ProgressBar"):setVisible(true)

		if arg_22_1.isLock then
			self:getChildByName("button_gray"):setVisible(true)
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("ProgressBar"):setPercent(arg_22_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_22_1.percent .. "%")
		elseif arg_22_1.percent and arg_22_1.percent < 100 then
			self:getChildByName("button_goto_" .. self.index):setVisible(true)
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("ProgressBar"):setPercent(arg_22_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_22_1.percent .. "%")
			self:getChildByName("button_goto_" .. self.index):addTouchEventListener(function(arg_24_0, arg_24_1)
				if arg_24_1 ~= ccui.TouchEventType.ended then
					return
				end

				print("taskinfo.jump = ", arg_22_1.jump)

				if arg_22_1.jump == 130 then
					LayerManager:pushInLayer("SignLayerNew", {
						callback = function()
							if topPlotListInstance then
								self:useMidasAfterUpdate()
							end

							self:getActivityTaskByStage()
						end
					})
				elseif arg_22_1.jump == 111 then
					require("controller.sign_manager"):createMidasLayer(function()
						if topPlotListInstance then
							self:useMidasAfterUpdate()
						end

						self:getActivityTaskByStage()
					end)
				elseif arg_22_1.jump == 220 then
					LayerManager:pushInLayer("FightResultLayerNew", {
						createItemType = "itemid",
						items = playermodel.dropcache,
						surecallback = function()
							if FightLayer and FightLayer.getInstance() then
								ccui.Helper:seekWidgetByName(FightLayer.getInstance().rootLayer, "dropcache"):checkPlayerDropCache()
								AnalyticManager.collectDropcache()
							end
						end,
						cancelcallback = function()
							return
						end
					}, {
						exitCallback = function()
							if topPlotListInstance then
								self:useMidasAfterUpdate()
							end

							self:getActivityTaskByStage()
						end
					})
				elseif arg_22_1.jump then
					require("controller.goto_system_manager")

					local var_24_0 = {
						jump_to_system = arg_22_1.jump
					}

					var_24_0.config = system_jump_config[SYSTEMID[arg_22_1.jump]] and system_jump_config[SYSTEMID[arg_22_1.jump]].config

					if var_24_0.config then
						if var_24_0.config.exitCallbackType == "function" then
							var_24_0.config.exitCallback = nil
						elseif var_24_0.config.exitCallbackType == "string" then
							var_24_0.config = "MainLayer"
						end
					end

					goto_complete_system(var_24_0)
				end
			end)
			self:getChildByName("button_getAwards"):setVisible(false)
		else
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(arg_22_1.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(arg_22_1.percent .. "%")
			self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_30_0, arg_30_1)
				if arg_30_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_30_0:isBright() then
					return
				end

				if global_button_lock then
					return
				end

				arg_30_0:setBright(false)

				global_button_lock = true

				self:confirmAwards(arg_22_1.taskid, arg_30_0)
			end)
		end

		self:updateAwardList(arg_22_1.drop)
	end

	function var_18_0:updateAwardList(arg_31_1)
		local var_31_0 = self:getChildByName("reward_list")
		local var_31_1 = drop_manager:getDropMsg(arg_31_1)

		var_31_0:setItemsMargin(10)
		var_31_0:removeAllItems()

		if var_31_1.diamond and var_31_1.diamond > 0 then
			var_31_0:pushBackCustomItem(var_0_11(IMAGE_DIAMOND, "X" .. var_31_1.diamond))
		end

		if var_31_1.gold and var_31_1.gold > 0 then
			var_31_0:pushBackCustomItem(var_0_11(IMAGE_GOLD, "X" .. var_31_1.gold, cc.size(43, 30)))
		end

		if var_31_1.equips[1] and var_31_1.equips[1].dropid and var_31_1.equips[1].dropid == 199000001 then
			var_31_0:pushBackCustomItem(var_0_11(IMAGE_JINGYAN, "X" .. var_31_1.equips[1].dropNum, cc.size(50, 35)))
		elseif var_31_1.equips[1] and var_31_1.equips[1].dropid then
			var_31_0:pushBackCustomItem(var_0_12(item_data[var_31_1.equips[1].dropid].name, var_31_1.equips[1].dropNum, cc.size(50, 35)))
		end

		var_31_0:setPositionX(38)

		if var_31_1.equips then
			for iter_31_0, iter_31_1 in pairs(var_31_1.equips) do
				assert(item_data[iter_31_1.dropid], "itemid: " .. iter_31_1.dropid .. " is nil")
			end
		end
	end

	var_18_0:updateTaskInfo(arg_18_1)

	return var_18_0
end

function ActivityUmaruTaskLayer:updateShowingCells()
	local var_32_0, var_32_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(#self.taskList),
		cellsize = cc.size(640, var_0_10)
	})

	for iter_32_0 = var_32_0, var_32_1 do
		self.taskView:updateCellAtIndex(iter_32_0)
	end
end

function ActivityUmaruTaskLayer:fullScreen()
	self.titleSprite:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.dropListView:setPositionY(self.bottomList:getPositionY() + 60)
end

function ActivityUmaruTaskLayer.checkTaskIsLock(arg_34_0, arg_34_1)
	local var_34_0 = activity_umaru_BP_task_index_data[arg_34_1.index].stage
	local var_34_1

	if activity_umaru_BP_task_index_data[arg_34_1.index].stage == 7 then
		do return false end

		var_34_1 = os.date("*t", playermodel.create_time)
	end

	return time_check_manager:getCurTime() < os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_34_1.year,
		month = var_34_1.month,
		day = var_34_1.day
	}) + 86400 * (var_34_0 - 2)
end

function ActivityUmaruTaskLayer:getActivityTaskByStage()
	local var_35_0 = activity_manager:getActivityObj(self.id)

	if var_35_0 then
		var_35_0:getActivityTaskList(nil, function(arg_36_0, arg_36_1)
			if arg_36_0 ~= 1 then
				return
			end

			for iter_36_0, iter_36_1 in pairs(arg_36_1.list) do
				arg_36_1.list[iter_36_0].des = task_data[iter_36_1.taskid].task_des
				arg_36_1.list[iter_36_0].img = task_data[iter_36_1.taskid].image
				arg_36_1.list[iter_36_0].drop = task_data[iter_36_1.taskid].drop
				arg_36_1.list[iter_36_0].order = task_data[iter_36_1.taskid].order
				arg_36_1.list[iter_36_0].name = task_data[iter_36_1.taskid].name
				arg_36_1.list[iter_36_0].jump = task_data[iter_36_1.taskid].jump
			end

			self.taskList = arg_36_1.list

			table.sort(self.taskList, function(arg_37_0, arg_37_1)
				if not arg_37_0.percent then
					return false
				end

				if not arg_37_1.percent then
					return true
				end

				if arg_37_0.percent == arg_37_1.percent then
					return arg_37_0.order < arg_37_1.order
				else
					return arg_37_0.percent > arg_37_1.percent
				end
			end)
			activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE)
		end, false, nil, "nmsl")
	end
end

function ActivityUmaruTaskLayer:confirmAwards(arg_38_1, arg_38_2)
	local var_38_0 = activity_manager:getActivityObj(self.id)

	if var_38_0 then
		var_38_0:getTaskReward(arg_38_1, function(arg_39_0, arg_39_1)
			arg_38_2:setBright(true)

			global_button_lock = nil

			if arg_39_0 ~= 1 then
				return
			end

			global_gain(arg_39_1)
			self:getActivityTaskByStage()
		end)
	end
end

local function var_0_13(arg_40_0)
	return require("data.activity_umaru_BP_task_index_data")[require("data.task_data")[arg_40_0].index].stage
end

local function var_0_14(arg_41_0)
	local var_41_0

	if arg_41_0 == 7 then
		do return false end

		var_41_0 = os.date("*t", playermodel.create_time)
	end

	return time_check_manager:getCurTime() < os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_41_0.year,
		month = var_41_0.month,
		day = var_41_0.day
	}) + 86400 * (arg_41_0 - 2)
end

function ActivityUmaruTaskLayer:getActivityTaskListBecauseOfAlert()
	local var_42_0 = activity_manager:getActivityObj(self.id)

	if var_42_0 then
		var_42_0:getActivityTaskList(nil, function(arg_43_0, arg_43_1)
			for iter_43_0, iter_43_1 in pairs(arg_43_1.list) do
				local var_43_0 = var_0_13(iter_43_1.taskid)

				if var_43_0 and var_43_0 > 1 and not var_0_14(var_43_0) and iter_43_1.status == 0 and iter_43_1.percent >= 100 then
					global_add_alert_tag(self.btnsByStage[var_43_0], {
						x = 62,
						y = 180
					})
				end
			end
		end, false, nil, "nmsl")
	end
end

function ActivityUmaruTaskLayer.updateTaskBtnAlert(arg_44_0)
	return
end
