PopSummerTSTaskLayer = class("PopSummerTSTaskLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")
local task_data = require("data.task_data")

function PopSummerTSTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSummerTSTaskLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSummerTSTaskLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.initparam = arg_3_1 or {}
	self.activityId = arg_3_1.activityId
	self._imagePath = "ActivityArt_722"

	self:initUI()
	self:registerActivityEventListener()

	self.usemodule = arg_3_1.usemodule or "activityGame"

	local var_3_0 = activity_manager:getActivityObj(self.activityId)

	function self.getTaskListCallback(arg_4_0, arg_4_1)
		if arg_4_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1.list) do
			iter_4_1.name = task_data[iter_4_1.taskid].name
			iter_4_1.task_des = task_data[iter_4_1.taskid].task_des
			iter_4_1.image = task_data[iter_4_1.taskid].image
			iter_4_1.drop = task_data[iter_4_1.taskid].drop
			iter_4_1.jump = task_data[iter_4_1.taskid].jump
			iter_4_1.order = task_data[iter_4_1.taskid].order

			if iter_4_1.status == 1 then
				iter_4_1.percent = -1
			end

			table.insert(self.taskList, iter_4_1)
		end

		table.sort(self.taskList, function(arg_5_0, arg_5_1)
			if arg_5_0.percent == arg_5_1.percent then
				return arg_5_0.order < arg_5_1.order
			else
				return arg_5_0.percent > arg_5_1.percent
			end
		end)
		self:updateTask()
	end

	if var_3_0 then
		var_3_0:getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopSummerTSTaskLayer")
		end
	end)
end

function PopSummerTSTaskLayer.registerActivityEventListener(arg_7_0)
	activity_manager:registerEventListener("PopSummerTSTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_8_0)
		arg_7_0.initparam = arg_8_0

		activity_manager:getActivityObj(arg_7_0.activityId):getActivityTaskList(nil, arg_7_0.getTaskListCallback, false, nil, arg_7_0.usemodule)
	end)
end

function PopSummerTSTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:playJoinInEffect()
end

function PopSummerTSTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)
end

function PopSummerTSTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create("mainScenebg/rewardbg.png")

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)
end

function PopSummerTSTaskLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(cc.size(600, 550))

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(30, 50)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return 486, 120
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			local var_14_2 = self:createTaskSprite(self.taskList[arg_14_1 + 1], arg_14_1 + 1)

			var_14_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_14_2:setPosition(cc.p(275, 65))
			var_14_0:addChild(var_14_2)
		else
			self:updateTaskSprite(var_14_0:getChildByTag(100), self.taskList[arg_14_1 + 1], arg_14_1 + 1)
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function PopSummerTSTaskLayer:createTaskSprite(arg_17_1, arg_17_2)
	local var_17_0 = ccui.ImageView:create(self._imagePath .. "/task_bottom.png", var_0_0)

	var_17_0:setTag(100)

	local var_17_1 = cc.Label:createWithTTF(arg_17_1.name, FONT_NAME, 24)

	var_17_1:setColor(cc.c3b(90, 22, 113))
	var_17_1:setAnchorPoint(cc.p(0, 0.5))
	var_17_1:setPosition(cc.p(15, 75))
	var_17_1:setName("title")
	var_17_0:addChild(var_17_1)

	local var_17_2 = cc.Label:createWithTTF(arg_17_1.task_des, FONT_NAME, 20)

	var_17_2:setColor(cc.c3b(89, 71, 90))
	var_17_2:setAnchorPoint(cc.p(0, 0.5))
	var_17_2:setPosition(cc.p(15, 40))
	var_17_2:setName("des")
	var_17_0:addChild(var_17_2)

	local var_17_3 = drop_manager:getDropMsg(arg_17_1.drop)

	print_lua_table(var_17_3)

	local var_17_4 = ItemSprite:createNewWithItemId(var_17_3.equips[1].dropid, var_17_3.equips[1].dropNum)

	var_17_0:addChild(var_17_4)
	var_17_4:setScale(0.35)
	var_17_4:setPosition(cc.p(300, 55))
	var_17_4:setName("sp")

	local var_17_5 = self._imagePath .. "/btn_goto.png"

	if arg_17_1.status >= 1 then
		var_17_5 = self._imagePath .. "/btn_got.png"
	elseif arg_17_1.percent >= 100 then
		var_17_5 = self._imagePath .. "/btn_get_reward.png"
	end

	local var_17_6 = ccui.Button:create(var_17_5, nil, var_17_5, var_0_0)

	var_17_6:setPosition(cc.p(430, 70))
	var_17_6:setName("btn")
	var_17_0:addChild(var_17_6)
	var_17_6:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_1.status >= 1 then
			return
		end

		if arg_17_1.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_17_1.taskid)
		else
			self:exit()
		end
	end)

	local var_17_7 = ccui.Slider:create()

	var_17_7:loadBarTexture(self._imagePath .. "/progress_bg.png", var_0_0)
	var_17_7:loadProgressBarTexture(self._imagePath .. "/progress_on.png", var_0_0)
	var_17_7:setPosition(cc.p(245, 10))
	var_17_7:setPercent(arg_17_1.percent)
	var_17_7:setName("progressBar")
	var_17_0:addChild(var_17_7)

	local var_17_9 = cc.Label:createWithTTF((arg_17_1.percent >= 0 or nil) and (arg_17_1.finished > arg_17_1.need and string.format("%s/%s", arg_17_1.need, arg_17_1.need) or string.format("%s/%s", arg_17_1.finished, arg_17_1.need)), FONT_NAME, 25)

	var_17_9:setAnchorPoint(cc.p(1, 0.5))
	var_17_9:setPosition(cc.p(485, 28))
	var_17_9:setName("percent")
	var_17_9:setVisible(arg_17_1.percent >= 0)
	var_17_9:setColor(cc.c3b(159, 49, 163))
	var_17_0:addChild(var_17_9)

	return var_17_0
end

function PopSummerTSTaskLayer:updateTaskSprite(arg_19_1, arg_19_2, arg_19_3)
	arg_19_1:setTag(100)
	arg_19_1:getChildByName("title"):setString(arg_19_2.name)

	local var_19_0 = drop_manager:getAllDrops(arg_19_2.drop)

	arg_19_1:getChildByName("des"):setString(arg_19_2.task_des)

	local var_19_1 = self._imagePath .. "/btn_goto.png"

	if arg_19_2.status >= 1 then
		var_19_1 = self._imagePath .. "/btn_got.png"
	elseif arg_19_2.percent >= 100 then
		var_19_1 = self._imagePath .. "/btn_get_reward.png"
	end

	arg_19_1:getChildByName("btn"):loadTextures(var_19_1, nil, var_19_1, var_0_0)
	arg_19_1:getChildByName("progressBar"):setPercent(arg_19_2.percent)

	if arg_19_2.percent >= 0 then
		arg_19_1:getChildByName("percent"):setString(arg_19_2.finished > arg_19_2.need and string.format("%s/%s", arg_19_2.need, arg_19_2.need) or string.format("%s/%s", arg_19_2.finished, arg_19_2.need))
	end

	arg_19_1:getChildByName("percent"):setVisible(arg_19_2.percent >= 0)
	arg_19_1:getChildByName("btn"):addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_19_2.status >= 1 then
			return
		end

		if arg_19_2.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_19_2.taskid)
		else
			self:exit()
		end
	end)

	local var_19_3 = drop_manager:getDropMsg(arg_19_2.drop)

	arg_19_1:removeChild("sp")

	local var_19_4 = ItemSprite:createNewWithItemId(var_19_3.equips[1].dropid, var_19_3.equips[1].dropNum)

	arg_19_1:addChild(var_19_4)
	var_19_4:setScale(0.35)
	var_19_4:setPosition(cc.p(300, 55))
	var_19_4:setName("sp")
end

function PopSummerTSTaskLayer.taskTumpTo(arg_21_0, arg_21_1)
	return
end

function PopSummerTSTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopSummerTSTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSummerTSTaskLayer:initBg(arg_25_1)
	local var_25_0 = ccui.Layout:create()

	var_25_0:setTouchEnabled(true)
	var_25_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_25_0:setAnchorPoint(cc.p(0, 0))
	var_25_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_25_0:setOpacity(0)
	self:addChild(var_25_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_26_0)
		self:addChild(arg_26_0, -2)
		arg_26_0:setPositionY(arg_26_0:getPositionY() - GameDisplay.fix_y)

		local var_26_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_26_0:setAnchorPoint(cc.p(0, 0))
		var_26_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_26_0, -1)
		self:init(arg_25_1)
		var_25_0:setOpacity(102)
		var_25_0:setTouchEnabled(false)
	end)
end
