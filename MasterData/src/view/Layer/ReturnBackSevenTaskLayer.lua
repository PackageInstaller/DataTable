ReturnBackSevenTaskLayer = class("ReturnBackSevenTaskLayer", function()
	return cc.Layer:create()
end)

local task_data = require("data.task_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local activity_task_index_data = require("data.activity_task_index_data")
local var_0_7 = config._DEBUG and 0 or 1
local activity_return_manager = require("controller.activity_return_manager")
local var_0_9 = "mainScenebg/task_img/"
local var_0_11 = 135
local var_0_12 = {
	{
		on = "ReturnBackSevenTaskLayer/day_first_on.png",
		off = "ReturnBackSevenTaskLayer/day_first.png"
	},
	{
		on = "ReturnBackSevenTaskLayer/day_second_on.png",
		off = "ReturnBackSevenTaskLayer/day_second.png"
	},
	{
		on = "ReturnBackSevenTaskLayer/day_third_on.png",
		off = "ReturnBackSevenTaskLayer/day_third.png"
	},
	{
		on = "ReturnBackSevenTaskLayer/day_fouth_on.png",
		off = "ReturnBackSevenTaskLayer/day_fouth.png"
	},
	{
		on = "ReturnBackSevenTaskLayer/day_fifth_on.png",
		off = "ReturnBackSevenTaskLayer/day_fifth.png"
	},
	{
		on = "ReturnBackSevenTaskLayer/day_six_on.png",
		off = "ReturnBackSevenTaskLayer/day_six.png"
	},
	{
		on = "ReturnBackSevenTaskLayer/day_seven_on.png",
		off = "ReturnBackSevenTaskLayer/day_seven.png"
	}
}
local var_0_13 = 1769002050

function ReturnBackSevenTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ReturnBackSevenTaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ReturnBackSevenTaskLayer:init(arg_3_1)
	local var_3_0 = config._DEBUG and "ReturnBackSevenTaskLayer.json" or "ReturnBackSevenTaskLayer.ExportJson"

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	self.imgBg = ccui.ImageView:create("mainScenebg/ActivityGameBackLayer.png")

	self.imgBg:setAnchorPoint(0, 0)
	self.imgBg:setPosition(0, -GameDisplay.fix_y)
	self.rootLayer:addChild(self.imgBg, -1)

	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(var_3_0)

	self.rootpanel:setPositionY(1.3 * GameDisplay.fix_y - 21)
	self.imgBg:addChild(self.rootpanel, 10)

	self.bottombg = ccui.ImageView:create("ReturnBackSevenTaskLayer/img_bottom.png", var_0_7)

	self.bottombg:setAnchorPoint(0, 0)
	self.bottombg:setPosition(0, 0)
	self.imgBg:addChild(self.bottombg, 999999)

	self.returnBtn = ccui.Button:create("ReturnBackSevenTaskLayer/btn_back.png", nil, "ReturnBackSevenTaskLayer/btn_back.png", var_0_7)

	self.returnBtn:setAnchorPoint(0, 0)
	self.returnBtn:setPosition(15, 15)
	self.bottombg:addChild(self.returnBtn)
	self.returnBtn:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self:initUI()
	self:registerActivityEventListener()
	self:switchPlotTaskClass(1)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.taskPanel then
				self.taskPanel:release()
			end

			activity_manager:releaseEventListenerByName("ReturnBackSevenTaskLayer")
		end
	end)
end

function ReturnBackSevenTaskLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("ReturnBackSevenTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_7_0)
		arg_6_0.taskList = arg_7_0.list
		arg_6_0.completeTask = arg_7_0.totaltask.finished
		arg_6_0.needCount = arg_7_0.totaltask.need
		arg_6_0.canComplete = not not (arg_6_0.completeTask and arg_6_0.needCount and arg_6_0.completeTask >= arg_6_0.needCount and arg_7_0.totaltask.status == 0)

		arg_6_0:updateTaskView()
		arg_6_0:updateProgress()
	end)
end

function ReturnBackSevenTaskLayer:initUI()
	self.bg = ccui.Helper:seekWidgetByName(self.rootpanel, "Image_bg")

	self.bg:loadTexture("ReturnBackSevenTaskLayer/bg_new.png", var_0_7)

	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "Image_18")

	self.award_finish = ccui.ImageView:create("ReturnBackSevenTaskLayer/award_finish.png", var_0_7)

	self.award_finish:setPositionY(var_8_0:getPositionY() + 65)
	self.award_finish:setAnchorPoint(0, 0.5)
	var_8_0:getParent():addChild(self.award_finish, 222222)
	var_8_0:setVisible(false)

	self.noviceBg = ccui.ImageView:create("ReturnBackSevenTaskLayer/noviceBg.png", var_0_7)

	self.bg:addChild(self.noviceBg)
	self.noviceBg:setPosition(100, 1050)

	self.rewardBg = ccui.ImageView:create("ReturnBackSevenTaskLayer/reward_bg.png", var_0_7)

	self.bg:addChild(self.rewardBg)
	self.rewardBg:setAnchorPoint(0, 0)
	self.rewardBg:setPosition(10, 900)

	local var_8_1 = ccui.ImageView:create("ReturnBackSevenTaskLayer/task_progress_bg.png", var_0_7)

	var_8_1:setPosition(cc.p(300, 15))
	self.rewardBg:addChild(var_8_1)

	self.progressBg = var_8_1

	local var_8_2 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("ReturnBackSevenTaskLayer/task_progress.png") or cc.Sprite:createWithSpriteFrameName("ReturnBackSevenTaskLayer/task_progress_bg.png")))

	var_8_2:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_8_2:setMidpoint(cc.p(0, 0.5))
	var_8_2:setBarChangeRate(cc.p(1, 0))
	var_8_2:setPercentage(100)
	var_8_2:setPosition(cc.p(300, 15))
	var_8_2:setName("progress")
	self.rewardBg:addChild(var_8_2)

	self.progress = var_8_2
	self.completeTask = self.completeTask or 0
	self.needCount = self.needCount or 0
	self.progressLable = cc.Label:createWithTTF(self.completeTask .. "/" .. self.needCount, FONT_NAME, 18)

	self.progressLable:setPosition(300, 5)
	self.progress:addChild(self.progressLable)

	local var_8_3 = ccui.Button:create("ReturnBackSevenTaskLayer/icon.png", nil, "ReturnBackSevenTaskLayer/icon.png", var_0_7)

	var_8_3:setPosition(self.rewardBg:getContentSize().width - 48, self.rewardBg:getContentSize().height / 2)
	self.rewardBg:addChild(var_8_3)
	var_8_3:setLocalZOrder(999)
	var_8_3:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.canComplete then
			self:confirmAwards(var_0_13, arg_9_0)
		else
			showItemDetails(drop_manager:getDropMsg(task_data[var_0_13].drop).equips[1].dropid)
		end
	end)

	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootpanel, "label_exp")

	self.taskPanel:retain()

	local var_8_4 = ccui.Button:create("ReturnBackSevenTaskLayer/button_gray.png", nil, "ReturnBackSevenTaskLayer/button_gray.png", var_0_7)

	var_8_4:setPosition(cc.p(self.taskPanel:getChildByName("button_goto"):getPositionX(), self.taskPanel:getChildByName("button_goto"):getPositionY()))
	var_8_4:setName("button_gray")
	self.taskPanel:addChild(var_8_4)
	self.taskPanel:removeFromParent()

	local var_8_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_touch")
	local var_8_6 = ccui.ImageView:create("ReturnBackSevenTaskLayer/banner.png", var_0_7)

	var_8_6:setAnchorPoint(0, 0)
	var_8_6:setScaleY(1.17)
	var_8_5:setVisible(true)
	var_8_5:addChild(var_8_6)
	self:createSwitchBtnList()
	self:fullScreen()
end

function ReturnBackSevenTaskLayer:updateProgress()
	self.progressLable:setString((self.completeTask and self.needCount or nil) and (self.completeTask .. "/" .. self.needCount or "已完成"))
	self.progress:setPercentage((self.completeTask and self.needCount or nil) and (self.completeTask / self.needCount * 100 or 100))

	if not self.taskLabel then
		self.taskLabel = cc.Label:createWithTTF(string.format(L_NOVICELAYER[2], self.needCount), FONT_NAME, 24)

		self.rewardBg:addChild(self.taskLabel)
		self.taskLabel:setPosition(self.rewardBg:getContentSize().width / 2, self.rewardBg:getContentSize().height - 25)
	else
		self.taskLabel:setString(string.format(L_NOVICELAYER[2], self.needCount))
	end
end

function ReturnBackSevenTaskLayer:createSwitchBtnList()
	self.classBnts = {}
	self.btnsByStage = {}
	self.dropListView = ccui.ListView:create()

	self.dropListView:setDirection(ccui.ListViewDirection.horizontal)
	self.dropListView:setItemsMargin(2)
	self.dropListView:setAnchorPoint(cc.p(0, 0))
	self.dropListView:setPosition(200, 1070)
	self.dropListView:setContentSize(cc.size(640, 88))
	self.rootpanel:addChild(self.dropListView, 11111)

	for iter_12_0 = 1, 7 do
		local var_12_0 = ccui.Button:create(var_0_12[iter_12_0].off, var_0_12[iter_12_0].on, var_0_12[iter_12_0].on, var_0_7)

		var_12_0:setAnchorPoint(cc.p(0, 0))
		var_12_0:setName("classBnt" .. iter_12_0)
		self.dropListView:pushBackCustomItem(var_12_0)

		self.classBnts[iter_12_0] = var_12_0

		var_12_0:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:switchPlotTaskClass(iter_12_0)
		end)
	end
end

function ReturnBackSevenTaskLayer:switchPlotTaskClass(arg_14_1)
	arg_14_1 = arg_14_1 or self.curClassType

	if self.curClassType == arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in pairs(self.classBnts) do
		iter_14_1:setBright(iter_14_0 ~= arg_14_1)
	end

	self.curClassType = arg_14_1

	activity_return_manager:get_returnback_sevenday_task(arg_14_1)
end

function ReturnBackSevenTaskLayer:updateTaskView()
	if not self.taskList then
		return
	end

	if self.taskView then
		self.taskView:reloadData()

		return
	end

	self.taskView = cc.TableView:create(cc.size(589, 850))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(196, 114)
	self.taskView:setDelegate()
	self.rootpanel:addChild(self.taskView, 5000)
	self.taskView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return 640, var_0_11
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_0:dequeueCell()

		if not var_17_0 then
			var_17_0 = cc.TableViewCell:create()

			var_17_0:setName("cell_" .. arg_17_1)

			local var_17_1 = self:createTaskInfoPanel(self.taskList[arg_17_1 + 1], arg_17_1)

			var_17_1:setName("taskinfo")
			var_17_1:setPosition(cc.p(0, 25))
			var_17_0:addChild(var_17_1)
		else
			var_17_0:getChildByName("taskinfo"):updateTaskInfo(self.taskList[arg_17_1 + 1])
		end

		return var_17_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskView:reloadData()
end

function ReturnBackSevenTaskLayer:createTaskInfoPanel(arg_21_1, arg_21_2)
	local var_21_0 = self.taskPanel:clone()

	var_21_0:getChildByName("des"):setContentSize(cc.size(200, 100))

	var_21_0.index = arg_21_2

	var_21_0:getChildByName("button_goto"):setName("button_goto_" .. arg_21_2)

	function var_21_0:updateTaskInfo(arg_22_1)
		self.taskinfo = arg_22_1

		if arg_22_1.percent ~= -1 then
			self:updateTriggeredTask()
		else
			self:updateFinishedTask()
		end
	end

	function var_21_0:updateFinishedTask()
		local var_23_0 = task_data[self.taskinfo.taskid]

		if task_data[self.taskinfo.taskid] and var_23_0.medal_id then
			local var_23_3 = self:getChildByName("medal")

			if not var_23_3 then
				var_23_3 = createMedal()

				var_23_3:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_23_3:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_23_3)
			end

			var_23_3:setVisible(true)

			local var_23_4 = item_data[tonumber(var_23_0.medal_id)]

			var_23_3:setTexture((item_data[itemid].bg or nil) and ("equipment/" .. var_23_4.bg .. ".png" or medal_frame[var_23_4.equip_quality]))
			var_23_3:setString(var_23_4.name)
			var_23_3:enableOutline(medal_colors[var_23_4.equip_quality], 1)
			var_23_3:enableShadow(medal_colors[var_23_4.equip_quality], cc.size(0, 0))
		elseif self:getChildByName("medal") then
			self:getChildByName("medal"):removeFromParent()
		end

		if self:getChildByName("item_sp") then
			self:getChildByName("item_sp"):removeFromParent()
		end

		local var_23_9 = drop_manager:getDropMsg(var_23_0.drop)

		if not next(var_23_9.equips) and var_23_9.diamond > 0 then
			var_23_9.equips[1] = {
				dropid = "diamond"
			}
		end

		local var_23_10 = ItemPurchaseSprite:createPurchaseItem(var_23_9.equips[1].dropid)
		local var_23_11 = self:getChildByName("Image_task")

		var_23_10:setName("item_sp")
		var_23_10:setScale(0.5)
		var_23_10:setPosition(cc.p(var_23_11:getPositionX(), var_23_11:getPositionY()))
		self:addChild(var_23_10)
		var_23_10:setTouchEnabled(true)
		var_23_10:addTouchEventListener(function(arg_24_0, arg_24_1)
			if arg_24_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_23_9.equips[1].dropid)
		end)
		self:getChildByName("name"):setString(var_23_0.name)
		self:getChildByName("des"):setString(var_23_0.task_des)
		self:getChildByName("Image_task"):setVisible(false)
		self:getChildByName("button_goto_" .. self.index):setVisible(false)
		self:getChildByName("button_getAwards"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
		self:getChildByName("ProgressBar"):setVisible(false)
		self:getChildByName("button_gray"):setVisible(false)
		self:getChildByName("bar_bg"):setVisible(false)
		self:updateAwardList(var_23_0.drop)
	end

	function var_21_0:updateTriggeredTask()
		local var_25_0 = self.taskinfo

		if self.taskinfo.medal_id then
			local var_25_2 = self:getChildByName("medal")

			if not var_25_2 then
				var_25_2 = createMedal()

				var_25_2:setPositionX(self:getChildByName("Image_task"):getPositionX() + 5)
				var_25_2:setPositionY(self:getChildByName("Image_task"):getPositionY() - 5)
				self:addChild(var_25_2)
			end

			local var_25_3 = item_data[tonumber(self.taskinfo.medal_id)]

			var_25_2:setVisible(true)
			var_25_2:setString(var_25_3.name)
			var_25_2:enableOutline(medal_colors[var_25_3.equip_quality], 1)
			var_25_2:enableShadow(medal_colors[var_25_3.equip_quality], cc.size(0, 0))

			if item_data[itemid].bg then
				-- block empty
			end
		elseif self:getChildByName("medal") then
			self:getChildByName("medal"):removeFromParent()
		end

		if self:getChildByName("item_sp") then
			self:getChildByName("item_sp"):removeFromParent()
		end

		local var_25_7 = drop_manager:getDropMsg(self.taskinfo.drop)

		if not next(var_25_7.equips) and var_25_7.diamond > 0 then
			var_25_7.equips[1] = {
				dropid = "diamond"
			}
		end

		local var_25_8 = ItemPurchaseSprite:createPurchaseItem(var_25_7.equips[1].dropid)
		local var_25_9 = self:getChildByName("Image_task")

		var_25_8:setName("item_sp")
		var_25_8:setScale(0.5)
		var_25_8:setPosition(cc.p(var_25_9:getPositionX(), var_25_9:getPositionY()))
		self:addChild(var_25_8)
		var_25_8:setTouchEnabled(true)
		var_25_8:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_25_7.equips[1].dropid)
		end)
		self:getChildByName("name"):setString(self.taskinfo.name)
		self:getChildByName("des"):setString(self.taskinfo.des)
		self:getChildByName("button_done"):setVisible(false)
		self:getChildByName("Image_task"):setVisible(false)
		self:getChildByName("ProgressBar"):setVisible(true)
		self:getChildByName("bar_bg"):setVisible(true)

		if self.taskinfo.isLock then
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(false)
			self:getChildByName("ProgressBar"):setPercent(self.taskinfo.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(self.taskinfo.percent .. "%")

			if self.taskinfo.percent and self.taskinfo.percent == 100 then
				self:getChildByName("button_gray"):setVisible(true)
			else
				self:getChildByName("button_goto_" .. self.index):setVisible(true)
			end
		elseif self.taskinfo.percent and self.taskinfo.percent < 100 then
			self:getChildByName("button_goto_" .. self.index):setVisible(true)
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("ProgressBar"):setPercent(self.taskinfo.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(self.taskinfo.percent .. "%")
			self:getChildByName("button_getAwards"):setVisible(false)
		else
			self:getChildByName("button_gray"):setVisible(false)
			self:getChildByName("button_goto_" .. self.index):setVisible(false)
			self:getChildByName("button_getAwards"):setVisible(true)
			self:getChildByName("ProgressBar"):setPercent(self.taskinfo.percent)
			self:getChildByName("ProgressBar"):getChildByName("Label_percent"):setString(self.taskinfo.percent .. "%")
			self:getChildByName("button_getAwards"):addTouchEventListener(function(arg_27_0, arg_27_1)
				if arg_27_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_27_0:isBright() then
					return
				end

				arg_27_0:setBright(false)
				self:confirmAwards(var_25_0.taskid, arg_27_0)
			end)
		end

		self:getChildByName("button_goto_" .. self.index):addTouchEventListener(function(arg_28_0, arg_28_1)
			if arg_28_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_25_0 = arg_28_0:getParent().taskinfo

			print(dump(var_25_0))
			print("taskinfo.jump = ", var_25_0.jump)

			if var_25_0.jump == 130 then
				LayerManager:pushInLayer("SignLayerNew", {
					callback = function()
						if topPlotListInstance then
							self:useMidasAfterUpdate()
						end

						self:getActivityTaskByStage()
					end
				})
			elseif var_25_0.jump == 111 then
				require("controller.sign_manager"):createMidasLayer(function()
					if topPlotListInstance then
						self:useMidasAfterUpdate()
					end

					self:getActivityTaskByStage()
				end)
			elseif var_25_0.jump == 220 then
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
			elseif var_25_0.jump then
				require("controller.goto_system_manager")

				local var_28_0 = {
					jump_to_system = var_25_0.jump
				}

				var_28_0.config = system_jump_config[SYSTEMID[var_25_0.jump]] and system_jump_config[SYSTEMID[var_25_0.jump]].config

				if var_28_0.config then
					if var_28_0.config.exitCallbackType == "function" then
						var_28_0.config.exitCallback = nil
					elseif var_28_0.config.exitCallbackType == "string" then
						var_28_0.config = "MainLayer"
					end
				end

				goto_complete_system(var_28_0)
			end
		end)
		self:updateAwardList(self.taskinfo.drop)
	end

	function var_21_0:updateAwardList(arg_34_1)
		local var_34_0 = self:getChildByName("Label_name")
		local var_34_1 = drop_manager:getDropMsg(arg_34_1)

		if var_34_1.equips[1] and var_34_1.equips[1].dropid then
			var_34_0:setString(item_data[var_34_1.equips[1].dropid].name .. ((var_34_1.equips[1].dropNum > 1 or nil) and "x" .. var_34_1.equips[1].dropNum))
			var_34_0:setScaleX(var_34_0:getContentSize().width > 106 and 106 / var_34_0:getContentSize().width or 1)
		end
	end

	var_21_0:updateTaskInfo(arg_21_1)

	return var_21_0
end

function ReturnBackSevenTaskLayer:updateShowingCells()
	local var_35_0, var_35_1 = GetTableViewShowCellIdx(self.taskView, {
		maxcount = math.ceil(#self.taskList),
		cellsize = cc.size(640, var_0_11)
	})

	for iter_35_0 = var_35_0, var_35_1 do
		self.taskView:updateCellAtIndex(iter_35_0)
	end
end

function ReturnBackSevenTaskLayer.fullScreen(arg_36_0)
	return
end

function ReturnBackSevenTaskLayer.checkTaskIsLock(arg_37_0, arg_37_1)
	local var_37_0 = activity_task_index_data[arg_37_1.index].stage
	local var_37_1

	if activity_task_index_data[arg_37_1.index].stage == 7 then
		do return false end

		var_37_1 = os.date("*t", playermodel.create_time)
	end

	return time_check_manager:getCurTime() < os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_37_1.year,
		month = var_37_1.month,
		day = var_37_1.day
	}) + 86400 * (var_37_0 - 2)
end

function ReturnBackSevenTaskLayer.confirmAwards(arg_38_0, arg_38_1, arg_38_2)
	activity_return_manager:get_returnback_sevenday_task_reward(arg_38_1, function(arg_39_0, arg_39_1)
		print_lua_table(arg_39_1)
		arg_38_2:setBright(true)

		if arg_39_0 ~= 1 then
			return
		end

		global_gain(arg_39_1)
		activity_return_manager:get_returnback_sevenday_task(arg_38_0.curClassType)
	end)
end
