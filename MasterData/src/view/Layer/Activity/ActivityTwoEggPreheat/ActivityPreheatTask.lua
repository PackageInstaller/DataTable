ActivityPreheatTask = class("ActivityPreheatTask", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local task_manager = require("controller.task_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local task_data = require("data.task_data")
local image_data = require("data.image_data")
local activity_task_stage_data = require("data.activity_task_stage_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12
local var_0_13 = false
local var_0_14 = 0.3
local var_0_15 = 13
local var_0_16 = require("data.activity_conf_data")[13].stagenum

function ActivityPreheatTask.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityPreheatTask.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityPreheatTask:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityTask.json" or "ActivityTask.ExportJson")

	self:addChild(self.rootLayer)

	self.activity = activity_manager:getActivityObj(var_0_15)
	self.curStage = 1

	self:initUI()
	self:registerActivityEventListener()
	self:getActivityTaskList()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityPreheatTask")

			if self.taskPanel then
				self.taskPanel:release()
			end
		end
	end)
end

function ActivityPreheatTask:initUI()
	self:initTitleAndBG()
	self:initBottomList()
	self:initSwitchButtons()
end

function ActivityPreheatTask:initTitleAndBG()
	self.rootLayer:setBackGroundImage("mainScenebg/hocruxbg.jpg")

	local var_6_0 = TitleSprite:create("Activity_PointActivityLayer/title_activity_task.png", 2, "Activity_PointActivityLayer/top_bg.png")

	var_6_0:setPosition(0, 1080)
	var_6_0:setName("title_sprite")
	self.rootLayer:addChild(var_6_0, 25)

	local var_6_1 = ccui.ImageView:create("Activity_PointActivityLayer/new_nameBottom.png", var_0_11)

	var_6_1:setPosition(var_6_0:getBackGroundImageTextureSize().width / 2 + 200, var_6_0:getBackGroundImageTextureSize().height / 2)
	var_6_0:addChild(var_6_1, 99)

	local var_6_2 = ccui.ImageView:create("Activity_PointActivityLayer/9000003.png", var_0_11)

	var_6_2:setScale(0.4)
	var_6_2:setPosition(cc.p(var_6_1:getContentSize().width / 2 - 80, var_6_1:getContentSize().height / 2))
	var_6_1:addChild(var_6_2, 99)

	self.labelPt = cc.Label:createWithTTF("", FONT_NAME, 26)

	self.labelPt:setColor(cc.c3b(185, 225, 241))
	self.labelPt:setAnchorPoint(cc.p(0.5, 0.5))
	self.labelPt:setPosition(cc.p(var_6_1:getContentSize().width / 2, var_6_1:getContentSize().height / 2))
	var_6_1:addChild(self.labelPt, 99)
end

function ActivityPreheatTask:initBottomList()
	self.bottomlist = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc(global_basic_scene)
	end)

	self:addChild(self.bottomlist, 5)
end

function ActivityPreheatTask:initSwitchButtons()
	self.panel_tab = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_tab")
	self.taskPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "label_exp")

	self.panel_tab:removeAllItems()
	self.panel_tab:setContentSize(65, 1070)
	self.panel_tab:setItemsMargin(0)
	self.panel_tab:setVisible(true)
	self.taskPanel:retain()
	self.taskPanel:removeFromParent()

	self.buttons = {}

	for iter_9_0 = 1, var_0_16 do
		local var_9_0 = ccui.Button:create()

		var_9_0:setSwallowTouches(false)

		if iter_9_0 == self.curStage then
			var_9_0:loadTextures("public/button/selected_tab_top_on.png", "public/button/selected_tab_top_on.png", "", var_0_11)
		else
			var_9_0:loadTextures("public/button/selected_tab_mid.png", "public/button/selected_tab_mid.png", "", var_0_11)
		end

		var_9_0:setAnchorPoint(cc.p(0.5, 0.5))

		local var_9_1 = cc.Label:createWithTTF(activity_task_stage_data[var_0_15 .. "-" .. iter_9_0].name, FONT_BUTTON, 25)

		var_9_1:setName("text")
		var_9_1:setColor(cc.c3b(152, 156, 183))
		var_9_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_9_1:setPosition(var_9_0:getContentSize().width / 2 - 8, var_9_0:getContentSize().height / 2 + 10)
		var_9_0:addChild(var_9_1)

		self.buttons[iter_9_0] = var_9_0

		self.panel_tab:pushBackCustomItem(var_9_0)
		var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_10_0:getTouchBeganPosition().y - arg_10_0:getTouchEndPosition().y) > 50 then
				return
			end

			if var_0_13 then
				return
			end

			local var_10_0

			if iter_9_0 == self.curStage then
				do return end

				var_10_0 = time_check_manager:getCurTime()
			end

			if var_10_0 < global_get_time_by_date(activity_task_stage_data[var_0_15 .. "-" .. iter_9_0].starttime) then
				global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.UN_START)

				return
			elseif global_get_time_by_date(activity_task_stage_data[var_0_15 .. "-" .. iter_9_0].finishtime) < var_10_0 then
				global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.IS_END)

				return
			end

			self.curStage = iter_9_0

			self:updateSwitchButtonsUI()
			self:getActivityTaskList(iter_9_0)
		end)
	end
end

function ActivityPreheatTask:updateSwitchButtonsUI()
	for iter_11_0 = 1, var_0_16 do
		if iter_11_0 == self.curStage then
			self.buttons[iter_11_0]:loadTextures("public/button/selected_tab_top_on.png", "public/button/selected_tab_top_on.png", nil, var_0_11)
		else
			self.buttons[iter_11_0]:loadTextures("public/button/selected_tab_mid.png", "public/button/selected_tab_mid.png", nil, var_0_11)
		end
	end
end

function ActivityPreheatTask:updateMyPointNum()
	self.labelPt:setString((item_manager:getItemNumber(9000003)))
end

function ActivityPreheatTask.registerActivityEventListener(arg_13_0)
	activity_manager:registerEventListener("ActivityPreheatTask", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_14_0)
		arg_13_0:updateTaskList(arg_14_0.data, #arg_14_0.data)

		arg_13_0.listLen = #arg_14_0.data

		arg_13_0:updateMyPointNum()
	end)
	activity_manager:registerEventListener("ActivityPreheatTask", activity_manager.activityEventId.ACTIVITY_GET_REWARD_CHANGED, function(arg_15_0)
		global_gain(arg_15_0.data)
		arg_13_0:getActivityTaskList()
	end)
end

function ActivityPreheatTask:getActivityTaskList(arg_16_1)
	self.activity:getActivityTaskList(self.curStage, function(arg_17_0, arg_17_1)
		local var_17_0 = {}

		if arg_17_0 == 0 then
			global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.ERROR)
		elseif arg_17_0 == 1 then
			for iter_17_0, iter_17_1 in pairs(arg_17_1.list) do
				task_data[iter_17_1.taskid].status = iter_17_1.status
				task_data[iter_17_1.taskid].taskid = iter_17_1.taskid
				task_data[iter_17_1.taskid].percent = iter_17_1.percent
				task_data[iter_17_1.taskid].finished = iter_17_1.finished

				table.insert(var_17_0, task_data[iter_17_1.taskid])
			end
		elseif arg_17_0 == 2 then
			global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.IS_END)
		elseif arg_17_0 == 3 then
			global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.UN_START)
		elseif arg_17_0 == 4 then
			global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.UN_START)
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			data = var_17_0
		})

		var_0_13 = false
	end, false)

	var_0_13 = true
end

function ActivityPreheatTask:updateTaskList(arg_18_1, arg_18_2)
	if self.taskList then
		self.taskList:removeFromParent()
	end

	if not arg_18_1 or not next(arg_18_1) or arg_18_2 < 1 then
		return
	end

	local var_18_0 = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.fix_y + self.bottomlist:getContentSize().height, TRANSFORM_UNIT.PX)

	self.taskList = cc.TableView:create(cc.size(589, 1010 + GameDisplay.height - 1136))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(32, var_18_0)
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)
	self.taskList:registerScriptHandler(function(arg_19_0, arg_19_1)
		return 569, 150
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if not var_20_0 then
			var_20_0 = cc.TableViewCell:create()

			local var_20_1 = self:createTaskInfoPanel(arg_18_1[arg_20_1 + 1])

			var_20_1:setName("taskinfo")
			var_20_1:setPosition(cc.p(30, 0))

			if arg_20_0.withaction and arg_20_1 < 7 then
				var_20_1:setOpacity(0)
				var_20_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_20_1), cc.FadeIn:create(0.1)))
			end

			var_20_0:addChild(var_20_1)
		else
			var_20_0:getChildByName("taskinfo"):updateTaskInfo(arg_18_1[arg_20_1 + 1])

			if arg_20_0.withaction and arg_20_1 < 7 then
				var_20_0:getChildByName("taskinfo"):setOpacity(0)
				var_20_0:getChildByName("taskinfo"):runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_20_1), cc.FadeIn:create(0.1)))
			end
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:registerScriptHandler(function(arg_21_0, arg_21_1)
		return arg_18_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:reloadData()
end

function ActivityPreheatTask:createTaskInfoPanel(arg_22_1)
	local var_22_0 = self.taskPanel:clone()

	function var_22_0:updateTaskInfo(arg_23_1)
		if arg_23_1.status == 1 then
			self:updateFinishedTask(arg_23_1)
		else
			self.index = arg_23_1.index
			self.delayTime = var_0_14 / 2 * ((arg_23_1.index - 1) % 7)

			self:updateTriggeredTask(arg_23_1)
		end
	end

	function var_22_0:updateBasicTask(arg_24_1)
		local var_24_2 = drop_manager:getDropMsg(arg_24_1.drop)

		if var_24_2.equips then
			for iter_24_0, iter_24_1 in pairs(var_24_2.equips) do
				self:getChildByName("button_goto"):getChildByName("label_pt"):setString("X" .. iter_24_1.dropNum)
			end
		end

		self:getChildByName("button_done"):setTouchEnabled(false)
		self:getChildByName("task_id"):setString(arg_24_1.order)
		self:getChildByName("name"):setString(arg_24_1.name)
		self:getChildByName("name"):setPositionX(140)
		self:getChildByName("des"):setString(arg_24_1.task_des)
		self:getChildByName("des"):setPositionX(140)

		local var_24_3 = self:getChildByName("button_goto")

		var_24_3:setPositionX(470)
		var_24_3:getChildByName("Image_18"):setPositionX(-340)
		var_24_3:getChildByName("label_pt"):setPositionX(-315)

		local var_24_4 = self:getChildByName("progress_bg"):getChildByName("progress_bar")

		var_24_4:setVisible(true)
		var_24_4:setPercent(arg_24_1.percent)
		var_24_4:getChildByName("percentage"):setString(arg_24_1.percent .. "%")
		var_24_4:getChildByName("percentage"):setPositionX(560)

		if arg_24_1.percent == 0 or arg_24_1.percent == 100 then
			var_24_4:setVisible(false)
		end

		ccui.Helper:seekWidgetByName(self, "Image_18"):loadTexture("Activity_PointActivityLayer/9000003.png", var_0_11)
		ccui.Helper:seekWidgetByName(self, "button_done"):setPositionX(480)
	end

	function var_22_0:updateFinishedTask(arg_25_1)
		task_data[arg_25_1.taskid].percent = 100

		self:updateBasicTask(task_data[arg_25_1.taskid])
		self:getChildByName("button_goto"):setVisible(false)
		self:getChildByName("button_done"):setVisible(true)
	end

	function var_22_0:updateTriggeredTask(arg_26_1)
		local var_26_0 = tonumber(arg_26_1.taskid)
		local var_26_2 = task_data[var_26_0]

		if next(task_data[var_26_0]) == nil then
			print("curData is nil, curtask = ", var_26_0)
		end

		task_data[var_26_0].percent = arg_26_1.percent

		self:updateBasicTask(task_data[var_26_0])

		if arg_26_1.percent < 100 then
			self:getChildByName("button_done"):setVisible(false)
			self:getChildByName("button_goto"):setVisible(true)
			self:getChildByName("button_goto"):addTouchEventListener(function(arg_27_0, arg_27_1)
				if arg_27_1 ~= ccui.TouchEventType.ended then
					return
				end

				if var_26_2.jump == 130 then
					LayerManager:pushInLayer("SignLayerNew")
				elseif var_26_2.jump == 111 then
					require("controller.sign_manager"):createMidasLayer((self:updateShowingCells()))
				elseif var_26_2.jump == 220 then
					LayerManager:pushInLayer("FightResultLayerNew", {
						createItemType = "itemid"
					}, {
						exitCallback = self:updateShowingCells()
					})
				else
					var_0_12 = self.curStage

					require("controller.goto_system_manager")

					local var_27_1 = {
						jump_to_system = var_26_2.jump
					}

					var_27_1.config = system_jump_config[SYSTEMID[var_26_2.jump]] and system_jump_config[SYSTEMID[var_26_2.jump]].config

					if var_27_1.config and var_27_1.config.exitCallbackType == "function" then
						function var_27_1.config.exitCallback()
							LayerManager:switchReturnLayer("ActivityPreheatTask")
						end
					end

					goto_complete_system(var_27_1)
				end
			end)
			self:getChildByName("button_goto"):loadTextures("Activity_PointActivityLayer/goto_button.png", nil, "Activity_PointActivityLayer/goto_button.png", var_0_11)
		else
			self:getChildByName("button_goto"):setVisible(true)
			self:getChildByName("button_done"):setVisible(false)
			self:getChildByName("button_goto"):addTouchEventListener(function(arg_29_0, arg_29_1)
				if arg_29_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.activity:getTaskReward(arg_26_1.taskid, function(arg_30_0, arg_30_1)
					if arg_30_0 ~= 1 then
						global_ShowBlockWords(L_ACTIVITY_TWOEGG_PT.UN_COMPLETE)

						return
					end

					activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_GET_REWARD_CHANGED, {
						data = arg_30_1
					})
				end)
			end)
			self:getChildByName("button_goto"):loadTextures("Activity_PointActivityLayer/receive_button.png", nil, "Activity_PointActivityLayer/receive_button.png", var_0_11)
		end
	end

	var_22_0:updateTaskInfo(arg_22_1)

	return var_22_0
end

function ActivityPreheatTask.updateShowingCells(arg_31_0)
	return function()
		arg_31_0:getActivityTaskList()

		local var_32_0, var_32_1 = GetTableViewShowCellIdx(arg_31_0.taskList, {
			cellsize = cc.size(569, 150),
			maxcount = arg_31_0.listLen
		})

		for iter_32_0 = var_32_0, var_32_1 do
			arg_31_0.taskList:updateCellAtIndex(iter_32_0)
		end
	end
end

function ActivityPreheatTask:fullScreen(arg_33_1)
	arg_33_1:setContentSize((GameDisplay.getScreenSize()))
	arg_33_1:setPositionY(arg_33_1:getPositionY() - GameDisplay.fix_y)
	arg_33_1:getChildByName("title_sprite"):setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.bottomlist:setPositionY(self.bottomlist:getPositionY() - GameDisplay.fix_y)
end
