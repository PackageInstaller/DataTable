PopArtTaskLayer = class("PopArtTaskLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")

function PopArtTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopArtTaskLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopArtTaskLayer:init(arg_3_1)
	print("open poplayer : PopArtTaskLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.initparam = arg_3_1 or {}
	self.activityId = arg_3_1.activityId
	self._imagePath = "ActivityArt_" .. self.activityId

	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getArtTaskList(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopArtTaskLayer")
		end
	end)
end

function PopArtTaskLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopArtTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		arg_5_0.initparam = arg_6_0
		arg_5_0.taskList = arg_6_0.list

		arg_5_0:updateTask()
	end)
	activity_manager:registerEventListener("PopArtTaskLayer", activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_7_0)
		activity_manager:getArtTaskList(arg_5_0.activityId)
	end)
end

function PopArtTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:playJoinInEffect()
end

function PopArtTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self:exit()
	end)
end

function PopArtTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create(self._imagePath .. "/task_bg.png", var_0_0)

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)
end

function PopArtTaskLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(cc.size(580, 620))

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(30, 100)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return 486, 120
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_2 = self:createTaskSprite(self.taskList[arg_13_1 + 1], arg_13_1 + 1)

			var_13_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_13_2:setPosition(cc.p(275, 65))
			var_13_0:addChild(var_13_2)
		else
			self:updateTaskSprite(var_13_0:getChildByTag(100), self.taskList[arg_13_1 + 1], arg_13_1 + 1)
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function PopArtTaskLayer:createTaskSprite(arg_16_1, arg_16_2)
	local var_16_0 = ccui.ImageView:create(self._imagePath .. "/task_bottom.png", var_0_0)

	var_16_0:setTag(100)

	local var_16_1 = cc.Label:createWithTTF(arg_16_1.name, FONT_NAME, 24)

	var_16_1:setColor(cc.c3b(90, 70, 118))
	var_16_1:setAnchorPoint(cc.p(0, 0.5))
	var_16_1:setPosition(cc.p(15, 75))
	var_16_1:setName("title")
	var_16_0:addChild(var_16_1)

	local var_16_2 = cc.Label:createWithTTF(arg_16_1.task_des, FONT_NAME, 20)

	var_16_2:setColor(cc.c3b(90, 70, 118))
	var_16_2:setAnchorPoint(cc.p(0, 0.5))
	var_16_2:setPosition(cc.p(15, 40))
	var_16_2:setName("des")
	var_16_0:addChild(var_16_2)

	local var_16_3 = ccui.ImageView:create(self._imagePath .. "/task_reward.png", var_0_0)

	var_16_3:setPosition(cc.p(350, 55))
	var_16_3:setName("icon")
	var_16_0:addChild(var_16_3)

	local var_16_4 = cc.Label:createWithTTF("X" .. drop_manager:getAllDrops(arg_16_1.drop)[1].dropNum, FONT_NAME, 18)

	var_16_4:setPosition(cc.p(35, 12))
	var_16_4:setName("num")
	var_16_3:addChild(var_16_4)

	local var_16_5 = self._imagePath .. "/btn_goto.png"

	if arg_16_1.status >= 1 then
		var_16_5 = self._imagePath .. "/btn_got.png"
	elseif arg_16_1.percent >= 100 then
		var_16_5 = self._imagePath .. "/btn_get_reward.png"
	end

	local var_16_6 = ccui.Button:create(var_16_5, nil, var_16_5, var_0_0)

	var_16_6:setPosition(cc.p(410, 60))
	var_16_6:setName("btn")
	var_16_0:addChild(var_16_6)
	var_16_6:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_16_1.status >= 1 then
			return
		end

		if arg_16_1.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_16_1.taskid)
		else
			self:taskTumpTo(arg_16_1.jump)
		end
	end)

	local var_16_7 = ccui.Slider:create()

	var_16_7:loadBarTexture(self._imagePath .. "/progress_bg.png", var_0_0)
	var_16_7:loadProgressBarTexture(self._imagePath .. "/progress_on.png", var_0_0)
	var_16_7:setPosition(cc.p(245, 10))
	var_16_7:setPercent(arg_16_1.percent)
	var_16_7:setName("progressBar")
	var_16_0:addChild(var_16_7)

	local var_16_8 = cc.Label:createWithTTF(arg_16_1.percent .. "%", FONT_NAME, 25)

	var_16_8:setAnchorPoint(cc.p(1, 0.5))
	var_16_8:setPosition(cc.p(450, 28))
	var_16_8:setName("percent")
	var_16_8:setVisible(arg_16_1.percent >= 0)
	var_16_8:setColor(cc.c3b(255, 255, 255))
	var_16_0:addChild(var_16_8)

	return var_16_0
end

function PopArtTaskLayer:updateTaskSprite(arg_18_1, arg_18_2, arg_18_3)
	arg_18_1:setTag(100)
	arg_18_1:getChildByName("title"):setString(arg_18_2.name)

	local var_18_0 = drop_manager:getAllDrops(arg_18_2.drop)

	arg_18_1:getChildByName("des"):setString(arg_18_2.task_des)

	local var_18_1 = self._imagePath .. "/btn_goto.png"

	if arg_18_2.status >= 1 then
		var_18_1 = self._imagePath .. "/btn_got.png"
	elseif arg_18_2.percent >= 100 then
		var_18_1 = self._imagePath .. "/btn_get_reward.png"
	end

	arg_18_1:getChildByName("btn"):loadTextures(var_18_1, nil, var_18_1, var_0_0)
	arg_18_1:getChildByName("progressBar"):setPercent(arg_18_2.percent)
	arg_18_1:getChildByName("percent"):setString(arg_18_2.percent .. "%")
	arg_18_1:getChildByName("percent"):setVisible(arg_18_2.percent >= 0)
	arg_18_1:getChildByName("icon"):getChildByName("num"):setString("X" .. var_18_0[1].dropNum)
	arg_18_1:getChildByName("btn"):addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_18_2.status >= 1 then
			return
		end

		if arg_18_2.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_18_2.taskid)
		else
			self:taskTumpTo(arg_18_2.jump)
		end
	end)
end

function PopArtTaskLayer.taskTumpTo(arg_20_0, arg_20_1)
	if arg_20_1 then
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_20_1
		})
	end
end

function PopArtTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopArtTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopArtTaskLayer:initBg(arg_24_1)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_24_0:setOpacity(0)
	self:addChild(var_24_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_25_0)
		self:addChild(arg_25_0, -2)
		arg_25_0:setPositionY(arg_25_0:getPositionY() - GameDisplay.fix_y)

		local var_25_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_25_0:setAnchorPoint(cc.p(0, 0))
		var_25_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_25_0, -1)
		self:init(arg_24_1)
		var_24_0:setOpacity(102)
		var_24_0:setTouchEnabled(false)
	end)
end
