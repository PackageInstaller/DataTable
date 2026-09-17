ExpeditionTaskLayer = class("ExpeditionTaskLayer", function()
	return cc.Layer:create()
end)

local var_0_0
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local expedition_manager = require("controller.expedition_manager")
local var_0_6 = config._DEBUG and 0 or 1

function ExpeditionTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ExpeditionTaskLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

local function var_0_7(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ccui.ImageView:create(arg_3_0, var_0_6)

	if arg_3_2 then
		var_3_0:setContentSize(arg_3_2)
		var_3_0:ignoreContentAdaptWithSize(false)
	end

	local var_3_1 = cc.Label:createWithTTF(arg_3_1, "fonts/name.ttf", 20)

	var_3_1:setColor(cc.c3b(171, 239, 58))
	var_3_1:setAnchorPoint(cc.p(0, 0.5))
	var_3_1:setPosition(var_3_0:getContentSize().width, var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_1)

	local var_3_2 = ccui.Layout:create()

	var_3_2:setContentSize(cc.size(var_3_0:getContentSize().width + var_3_1:getContentSize().width, var_3_0:getContentSize().height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(0, 0)
	var_3_2:setTouchEnabled(false)
	var_3_2:addChild(var_3_0)

	return var_3_2
end

local function var_0_8(arg_4_0, arg_4_1)
	local var_4_0 = cc.Label:createWithTTF(arg_4_0, "fonts/name.ttf", 20)

	var_4_0:setColor(cc.c3b(198, 216, 223))
	var_4_0:setAnchorPoint(cc.p(0, 0))
	var_4_0:setPosition(0, 0)

	local var_4_1 = cc.Label:createWithTTF(arg_4_1, "fonts/name.ttf", 20)

	var_4_1:setColor(cc.c3b(171, 239, 58))
	var_4_1:setAnchorPoint(cc.p(0, 0))
	var_4_1:setPosition(var_4_0:getContentSize().width, 0)

	local var_4_2 = ccui.Layout:create()

	var_4_2:setContentSize(cc.size(var_4_0:getContentSize().width + var_4_1:getContentSize().width, var_4_0:getContentSize().height))
	var_4_2:addChild(var_4_0)
	var_4_2:addChild(var_4_1)
	var_4_2:setTouchEnabled(false)

	return var_4_2
end

function ExpeditionTaskLayer:init(arg_5_1)
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	var_0_0 = self
	self.msg = arg_5_1

	if self.msg.returnLayer then
		self.returnLayer = self.msg.returnLayer or "ThreeVsThreeLayer"
	end

	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_0 = nil
		end
	end)
end

function ExpeditionTaskLayer:initUI()
	self:initTitleAndBg()
	self:initBottomList()
end

function ExpeditionTaskLayer:initTitleAndBg()
	self.titleSprite = TitleSprite:create("Activity_PointActivityLayer/title_activity_task.png", 2)

	self.titleSprite:setPosition(0, 1136 + GameDisplay.fix_y * 2 - self.titleSprite:getContentSize().height)
	self.titleSprite:setName("title_sprite")
	self.rootLayer:addChild(self.titleSprite, 25)
end

function ExpeditionTaskLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 1000)
end

function ExpeditionTaskLayer.updateUI(arg_11_0)
	expedition_manager:get_player_expedition_task(function(arg_12_0)
		if not var_0_0 then
			return
		end

		arg_11_0.taskData = arg_12_0

		arg_11_0:updateTaskList()
	end)
end

function ExpeditionTaskLayer:updateTaskList()
	if not self.taskData or not next(self.taskData) then
		return
	end

	if self.taskList then
		self:updateShowingCells(self.taskList, #self.taskData)

		return
	end

	local var_13_0 = 1010 + GameDisplay.height - 1136

	self.taskList = cc.TableView:create(cc.size(640, 1010 + GameDisplay.height - 1136))

	self.taskList:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskList:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskList:setAnchorPoint(cc.p(0, 0))
	self.taskList:setPosition(0, self.bottomList:getPositionY() + 72)
	self.taskList:setDelegate()
	self.rootLayer:addChild(self.taskList)
	self.taskList:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			local var_14_2 = self:createTaskSprite(self.taskData[arg_14_1 + 1])

			var_14_2:setAnchorPoint(cc.p(0, 0))
			var_14_2:setPosition(cc.p(45, 0))
			var_14_0:addChild(var_14_2)

			if arg_14_1 < math.ceil(var_13_0 / 150) then
				var_14_2:setOpacity(0)
				var_14_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_14_1), cc.FadeIn:create(0.1)))
			else
				var_14_2:setOpacity(255)
			end
		else
			local var_14_3 = var_14_0:getChildByTag(100)

			var_14_3:setOpacity(255)
			self:updateTaskSprite(var_14_3, self.taskData[arg_14_1 + 1])
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskList:registerScriptHandler(function(arg_15_0, arg_15_1)
		return 569, 150
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskList:registerScriptHandler(function(arg_16_0, arg_16_1)
		return #self.taskData
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taskList:reloadData()
end

function ExpeditionTaskLayer.createTaskSprite(arg_17_0, arg_17_1)
	local var_17_0 = ccui.ImageView:create("Activity_PointActivityLayer/task_bg.png", var_0_6)
	local var_17_1 = ccui.Slider:create()

	var_17_1:loadProgressBarTexture("Activity_PointActivityLayer/progress_bar.png", var_0_6)
	var_17_1:loadBarTexture("Activity_PointActivityLayer/progress_bar_bg.png", var_0_6)
	var_17_1:setPosition(cc.p(272, 132))
	var_17_1:setPercent(arg_17_1.percent or 0)
	var_17_1:setName("slider")
	var_17_0:addChild(var_17_1)

	local var_17_2 = cc.Label:createWithTTF((arg_17_1.percent or 0) .. "%", FONT_NAME, 24)

	var_17_2:setPosition(cc.p(520, 118))
	var_17_2:setName("lbl_percent")
	var_17_2:setColor(cc.c3b(161, 226, 58))
	var_17_2:setVisible(arg_17_1.percent ~= nil)
	var_17_0:addChild(var_17_2)

	local var_17_3 = ccui.ImageView:create("Activity_PointActivityLayer/frame_activity_task.png", var_0_6)

	var_17_3:setPosition(cc.p(60, 70))
	var_17_0:addChild(var_17_3)

	local var_17_4 = cc.Label:createWithTTF(arg_17_1.taskid - 20210000, FONT_NAME, 48)

	var_17_4:setPosition(cc.p(58, 70))
	var_17_4:setColor(cc.c3b(185, 225, 241))
	var_17_4:setName("num")
	var_17_4:setVisible(false)
	var_17_0:addChild(var_17_4)

	local var_17_5 = ccui.ImageView:create("equipment/10100002.png")

	var_17_5:setPosition(cc.p(60, 70))
	var_17_5:loadTexture("mainScenebg/task_img/" .. task_data[arg_17_1.taskid].image .. ".png")
	var_17_5:setName("taskImg")
	var_17_0:addChild(var_17_5)

	local var_17_6 = cc.Label:createWithTTF("x" .. drop_manager:getAllDrops(task_data[arg_17_1.taskid].drop)[1].dropNum, FONT_NAME, 18)

	var_17_6:setPosition(cc.p(60, 18))
	var_17_6:setColor(cc.c3b(161, 226, 58))
	var_17_6:setName("lbl_drop_num")
	var_17_6:setAnchorPoint(cc.p(0, 0.5))
	var_17_6:setVisible(false)
	var_17_0:addChild(var_17_6)

	local var_17_7 = var_17_0:getChildByName("reward_list")

	if var_17_7 == nil then
		var_17_7 = ccui.ListView:create()

		var_17_7:setDirection(ccui.ListViewDirection.horizontal)
		var_17_7:setAnchorPoint(cc.p(0, 0))
		var_17_7:setPosition(120, -30)
		var_17_7:setContentSize(cc.size(350, 130))
		var_17_7:setName("reward_list")
		var_17_7:setScale(0.8)
		var_17_7:setTouchEnabled(false)
		var_17_0:addChild(var_17_7)
	end

	var_17_7:setItemsMargin(10)
	var_17_7:removeAllItems()

	local var_17_8 = drop_manager:getDropMsg(task_data[arg_17_1.taskid].drop)

	if var_17_8.diamond and var_17_8.diamond > 0 then
		var_17_7:pushBackCustomItem(var_0_7(IMAGE_DIAMOND, "X" .. var_17_8.diamond))
	end

	if var_17_8.gold and var_17_8.gold > 0 then
		var_17_7:pushBackCustomItem(var_0_7(IMAGE_GOLD, "X" .. var_17_8.gold, cc.size(43, 30)))
	end

	if var_17_8.equips then
		for iter_17_0, iter_17_1 in pairs(var_17_8.equips) do
			assert(item_data[iter_17_1.dropid], "itemid: " .. iter_17_1.dropid .. " is nil")
			var_17_7:pushBackCustomItem(var_0_8(item_data[iter_17_1.dropid].name, "X" .. iter_17_1.dropNum))
		end
	end

	local var_17_9 = cc.Label:createWithTTF(task_data[arg_17_1.taskid].name, FONT_NAME, 28)

	var_17_9:setPosition(cc.p(140, 100))
	var_17_9:setName("lbl_title")
	var_17_9:setAnchorPoint(0, 0.5)
	var_17_0:addChild(var_17_9)

	local var_17_10 = cc.Label:createWithTTF(task_data[arg_17_1.taskid].task_des, FONT_NAME, 22)

	var_17_10:setName("lbl_des")
	var_17_10:setAnchorPoint(0, 0.5)
	var_17_10:setColor(cc.c3b(167, 170, 203))
	var_17_10:setPosition(cc.p(140, 68))
	var_17_0:addChild(var_17_10)

	local var_17_11 = "Activity_PointActivityLayer/goto_button.png"

	if arg_17_1.status >= 1 then
		var_17_11 = "Activity_PointActivityLayer/button_accelerate.png"
	elseif arg_17_1.percent >= 100 then
		var_17_11 = "Activity_PointActivityLayer/receive_button.png"
	end

	local var_17_12 = ccui.Button:create(var_17_11, nil, var_17_11, var_0_6)

	var_17_12:setName("btn_get")
	var_17_12:setPosition(cc.p(450, 60))
	var_17_0:addChild(var_17_12)
	var_17_12:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_1.status >= 1 then
			return
		end

		if arg_17_1.percent >= 100 then
			expedition_manager:get_task_reward(arg_17_1.taskid, function()
				if not var_0_0 then
					return
				end

				arg_17_0:updateUI()
			end)
		else
			arg_17_0:jumpToExpeditionSystem()
		end
	end)
	var_17_0:setTag(100)

	return var_17_0
end

function ExpeditionTaskLayer.updateTaskSprite(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1:setTag(100)
	arg_20_1:getChildByName("slider"):setPercent(arg_20_2.percent or 0)
	arg_20_1:getChildByName("lbl_percent"):setString((arg_20_2.percent or 0) .. "%")
	arg_20_1:getChildByName("num"):setString(arg_20_2.taskid - 20210000)
	arg_20_1:getChildByName("lbl_title"):setString(task_data[arg_20_2.taskid].name)
	arg_20_1:getChildByName("lbl_title"):setPositionY(100)
	arg_20_1:getChildByName("lbl_des"):setString(task_data[arg_20_2.taskid].task_des)
	arg_20_1:getChildByName("lbl_des"):setPositionY(68)
	arg_20_1:getChildByName("lbl_percent"):setVisible(arg_20_2.percent ~= nil)
	arg_20_1:getChildByName("taskImg"):loadTexture("mainScenebg/task_img/" .. task_data[arg_20_2.taskid].image .. ".png")
	arg_20_1:getChildByName("lbl_drop_num"):setString("x" .. drop_manager:getAllDrops(task_data[arg_20_2.taskid].drop)[1].dropNum)
	arg_20_1:getChildByName("lbl_drop_num"):setVisible(false)

	local var_20_0 = arg_20_1:getChildByName("reward_list")

	if var_20_0 == nil then
		var_20_0 = ccui.ListView:create()

		var_20_0:setTouchEnabled(false)
		var_20_0:setDirection(ccui.ListViewDirection.horizontal)
		var_20_0:setAnchorPoint(cc.p(0, 0))
		var_20_0:setPosition(120, -30)
		var_20_0:setContentSize(cc.size(350, 130))
		var_20_0:setName("reward_list")
		var_20_0:setScale(0.8)
		arg_20_1:addChild(var_20_0)
	end

	var_20_0:setItemsMargin(10)
	var_20_0:removeAllItems()

	local var_20_1 = drop_manager:getDropMsg(task_data[arg_20_2.taskid].drop)

	if var_20_1.diamond and var_20_1.diamond > 0 then
		var_20_0:pushBackCustomItem(var_0_7(IMAGE_DIAMOND, "X" .. var_20_1.diamond))
	end

	if var_20_1.gold and var_20_1.gold > 0 then
		var_20_0:pushBackCustomItem(var_0_7(IMAGE_GOLD, "X" .. var_20_1.gold, cc.size(43, 30)))
	end

	if var_20_1.equips then
		for iter_20_0, iter_20_1 in pairs(var_20_1.equips) do
			assert(item_data[iter_20_1.dropid], "itemid: " .. iter_20_1.dropid .. " is nil")
			var_20_0:pushBackCustomItem(var_0_8(item_data[iter_20_1.dropid].name, "X" .. iter_20_1.dropNum))
		end
	end

	local var_20_2 = "Activity_PointActivityLayer/goto_button.png"

	if arg_20_2.status >= 1 then
		var_20_2 = "Activity_PointActivityLayer/button_accelerate.png"
	elseif arg_20_2.percent >= 100 then
		var_20_2 = "Activity_PointActivityLayer/receive_button.png"
	end

	local var_20_3 = arg_20_1:getChildByName("btn_get")

	var_20_3:loadTextures(var_20_2, nil, var_20_2, var_0_6)
	var_20_3:setPositionY(60)
	var_20_3:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_20_2.status >= 1 then
			return
		end

		if arg_20_2.percent >= 100 then
			expedition_manager:get_task_reward(arg_20_2.taskid, function()
				if not var_0_0 then
					return
				end

				arg_20_0:updateUI()
			end)
		else
			arg_20_0:jumpToExpeditionSystem()
		end
	end)
end

function ExpeditionTaskLayer.updateShowingCells(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0, var_23_1 = GetTableViewShowCellIdx(arg_23_1, {
		maxcount = math.ceil(arg_23_2),
		cellsize = cc.size(640, 150)
	})

	for iter_23_0 = var_23_0, var_23_1 do
		arg_23_1:updateCellAtIndex(iter_23_0)
	end
end

function ExpeditionTaskLayer.jumpToExpeditionSystem(arg_24_0)
	local var_24_0 = expedition_manager:getExpeditionParam()
	local var_24_1 = {}

	var_24_1.jump_to_system = var_24_0.jumpid or 118
	var_24_1.config = {
		isNeedCheckEvent = false,
		inittype = var_24_0.inittype,
		jumpToFlipCallback = var_24_0.jumpToFlipCallback,
		jumpid = var_24_0.jumpid
	}

	goto_complete_system(var_24_1)
end
