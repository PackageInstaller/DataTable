PopCommonTaskLayer = class("PopCommonTaskLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local drop_manager = require("controller.drop_manager")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local item_data = require("data.item_data")
local var_0_7 = {
	fix_y = 0,
	taskviewSize = cc.size(600, 600),
	taskviewPos = cc.p(30, 50),
	taskspriteSize = {
		width = 486,
		height = 140
	},
	taskspriteSpPos = cc.p(240, 75),
	taskspriteBtnPos = cc.p(405, 70),
	taskspriteColor = cc.c3b(201, 209, 247),
	progressPos = cc.p(145, 20),
	percentPos = cc.p(335, 24)
}
local var_0_8 = {
	fix_y = 25,
	taskviewSize = cc.size(600, 640),
	taskviewPos = cc.p(30, 120),
	taskspriteSize = {
		width = 486,
		height = 180
	},
	taskspriteSpPos = cc.p(450, 102),
	taskspriteBtnPos = cc.p(450, 30),
	taskspriteColor = cc.c3b(126, 95, 74),
	progressPos = cc.p(160, 25),
	percentPos = cc.p(360, 30)
}

local function var_0_9(arg_2_0, arg_2_1)
	local var_2_0 = drop_manager:getDropMsg(arg_2_0)
	local var_2_1
	local var_2_2

	if var_2_0.gold ~= 0 then
		var_2_1 = "gold"
		var_2_2 = var_2_0.gold
	elseif var_2_0.diamond ~= 0 then
		var_2_1 = "diamond"
		var_2_2 = var_2_0.diamond
	elseif var_2_0.equips then
		for iter_2_0, iter_2_1 in pairs(var_2_0.equips) do
			var_2_1 = iter_2_1.dropid
			var_2_2 = iter_2_1.dropNum
		end
	end

	local var_2_4 = ccui.ImageView:create()

	if item_data[var_2_1].bag_item_type == kITEM_SKIN then
		var_2_4:loadTexture("roleimage/role1/" .. modelData[item_data[var_2_1].model].cute_role .. ".png")
		var_2_4:setScale(0.3)
	elseif item_data[var_2_1].bag_item_type == kITEM_HORCRUX then
		local var_2_5 = drop_manager:getAllDropsNotMerge(arg_2_0)[1].item_attr
		local var_2_6 = ccui.Layout:create()

		var_2_6:setName("starsPanel")
		var_2_6:setScale(1.75)
		var_2_6:setPositionY(58)
		var_2_6:setPositionX(200)
		var_2_4:addChild(var_2_6, 5)

		local var_2_7 = 0

		if var_2_5 then
			for iter_2_2, iter_2_3 in var_2_5:gmatch("([^&]+)=([^&]+)") do
				if iter_2_2 == "star" then
					var_2_7 = tonumber(iter_2_3)
				end
			end
		end

		for iter_2_4 = 1, var_2_7 do
			local var_2_8

			if config._DEBUG then
				var_2_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_2_8:setPosition(25, (iter_2_4 - 1) * 24 - 30)
			var_2_6:addChild(var_2_8)
		end

		var_2_4:loadTexture("equipment/" .. item_data[var_2_1].image_id .. ".png")
		var_2_4:setScale(0.3)
	elseif item_data[var_2_1].bag_item_type == kITEM_COMPONENT then
		var_2_4:removeFromParent()

		var_2_4 = nil
		var_2_4 = componentManager:create_component_icon(var_2_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_2_4:setScale(0.75)
	else
		var_2_4:loadTexture("equipment/" .. item_data[var_2_1].image_id .. ".png")
		var_2_4:setScale(0.75)
	end

	local var_2_9 = cc.Label:createWithTTF("", FONT_DES, 70)

	var_2_9:setString("x" .. var_2_2)
	var_2_9:setPosition(80, 0)
	var_2_9:setName("num")
	var_2_4:addChild(var_2_9)
	var_2_4:setTouchEnabled(arg_2_1)
	var_2_4:addTouchEventListener(function(arg_3_0, arg_3_1)
		if arg_3_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_2_1].bag_item_type == kITEM_HORCRUX then
			showHorcruxDetails(var_2_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_2_1
			})
		end
	end)

	return var_2_4, var_2_2
end

function PopCommonTaskLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = PopCommonTaskLayer.new()

	var_4_0:initBg(arg_4_1)

	return var_4_0
end

function PopCommonTaskLayer:init(arg_5_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.initparam = arg_5_1 or {}
	self.activityId = arg_5_1.activityId

	if arg_5_1.usemodule == "commonFlop" then
		self._imagePath = self.activityId == 730 and "CommonFlopLayer" or "Activities/activity" .. self.activityId .. "/flop"
		self.ui_conf = var_0_7
	elseif arg_5_1.usemodule == "commonRoulette" then
		if self.activityId then
			self._imagePath = "ActivityRoulette_" .. self.activityId or "ActivityRoulette_731"
		end

		self.ui_conf = var_0_7
	elseif arg_5_1.usemodule == "airplane_daily" then
		self._imagePath = "CommonTaskAirPlane"
		self.ui_conf = var_0_8
	end

	self:initUI()
	self:registerActivityEventListener()

	self.usemodule = arg_5_1.usemodule or "commonFlop"

	local var_5_0 = activity_manager:getActivityObj(self.activityId)

	function self.getTaskListCallback(arg_6_0, arg_6_1)
		if tolua.isnull(self) then
			return
		end

		if arg_6_0 ~= 1 then
			return
		end

		self.taskList = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1.list) do
			iter_6_1.name = task_data[iter_6_1.taskid].name
			iter_6_1.task_des = task_data[iter_6_1.taskid].task_des
			iter_6_1.image = task_data[iter_6_1.taskid].image
			iter_6_1.drop = task_data[iter_6_1.taskid].drop
			iter_6_1.jump = task_data[iter_6_1.taskid].jump
			iter_6_1.order = task_data[iter_6_1.taskid].order

			if iter_6_1.status == 1 then
				iter_6_1.percent = -1
			end

			table.insert(self.taskList, iter_6_1)
		end

		table.sort(self.taskList, function(arg_7_0, arg_7_1)
			if arg_7_0.percent == arg_7_1.percent then
				return arg_7_0.order < arg_7_1.order
			else
				return arg_7_0.percent > arg_7_1.percent
			end
		end)
		self:updateTask()
		activity_manager:update_alert(self.activityId, self.usemodule, self.taskList)
	end

	if var_5_0 then
		var_5_0:getActivityTaskList(nil, self.getTaskListCallback, false, nil, self.usemodule)
	end

	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopCommonTaskLayer")
		end
	end)
end

function PopCommonTaskLayer.registerActivityEventListener(arg_9_0)
	activity_manager:registerEventListener("PopCommonTaskLayer", activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_10_0)
		arg_9_0.initparam = arg_10_0

		activity_manager:getActivityObj(arg_9_0.activityId):getActivityTaskList(nil, arg_9_0.getTaskListCallback, false, nil, arg_9_0.usemodule)
	end)
end

function PopCommonTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:playJoinInEffect()
end

function PopCommonTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		self:exit()
	end)
end

function PopCommonTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create(self._imagePath .. "/task_bg.png", var_0_0)

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)
end

function PopCommonTaskLayer:updateTask()
	if self.taksView then
		self.taksView:reloadData()

		return
	end

	self.taksView = cc.TableView:create(self.ui_conf.taskviewSize)

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(self.ui_conf.taskviewPos)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return self.ui_conf.taskspriteSize.width, self.ui_conf.taskspriteSize.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_16_0, arg_16_1)
		local var_16_0 = arg_16_0:dequeueCell()

		if not var_16_0 then
			var_16_0 = cc.TableViewCell:create()

			local var_16_2 = self:createTaskSprite(self.taskList[arg_16_1 + 1], arg_16_1 + 1)

			var_16_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_16_2:setPosition(cc.p(275, 65))
			var_16_0:addChild(var_16_2)
		else
			self:updateTaskSprite(var_16_0:getChildByTag(100), self.taskList[arg_16_1 + 1], arg_16_1 + 1)
		end

		return var_16_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_18_0, arg_18_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

function PopCommonTaskLayer:createTaskSprite(arg_19_1, arg_19_2)
	local var_19_0 = ccui.ImageView:create(self._imagePath .. "/task_bottom.png", var_0_0)

	var_19_0:setTag(100)

	local var_19_1 = cc.Label:createWithTTF(arg_19_1.name, FONT_NAME, 24)

	var_19_1:setColor(self.ui_conf.taskspriteColor)
	var_19_1:setAnchorPoint(cc.p(0, 0.5))
	var_19_1:setPosition(cc.p(15, 95 + self.ui_conf.fix_y))
	var_19_1:setName("title")
	var_19_0:addChild(var_19_1)

	local var_19_2 = cc.Label:createWithTTF(arg_19_1.task_des, FONT_NAME, 20)

	var_19_2:setColor(self.ui_conf.taskspriteColor)
	var_19_2:setAnchorPoint(cc.p(0, 0.5))
	var_19_2:setPosition(cc.p(15, 60 + self.ui_conf.fix_y))
	var_19_2:setName("des")
	var_19_0:addChild(var_19_2)

	local var_19_3 = ccui.ImageView:create(self._imagePath .. "/task_reward_bg.png", var_0_0)

	var_19_0:addChild(var_19_3)
	var_19_3:setPosition(self.ui_conf.taskspriteSpPos)
	var_19_3:setName("icon_bg")

	local var_19_4 = drop_manager:getDropMsg(arg_19_1.drop)
	local var_19_5 = var_0_9(arg_19_1.drop, true)

	var_19_3:addChild(var_19_5)
	var_19_5:setScale(0.3)
	var_19_5:setName("sp")
	var_19_5:setPosition(cc.p(30, 40))

	local var_19_6 = self._imagePath .. "/btn_goto.png"

	if arg_19_1.status >= 1 then
		var_19_6 = self._imagePath .. "/btn_got.png"
	elseif arg_19_1.percent >= 100 then
		var_19_6 = self._imagePath .. "/btn_get_reward.png"
	end

	local var_19_7 = ccui.Button:create(var_19_6, nil, var_19_6, var_0_0)

	var_19_7:setPosition(self.ui_conf.taskspriteBtnPos)
	var_19_7:setName("btn")
	var_19_0:addChild(var_19_7)
	var_19_7:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_19_1.status >= 1 then
			return
		end

		if arg_19_1.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_19_1.taskid)
		else
			self:taskTumpTo(arg_19_1.jump)
		end
	end)

	local var_19_8 = ccui.Slider:create()

	var_19_8:loadBarTexture(self._imagePath .. "/progress_bg.png", var_0_0)
	var_19_8:loadProgressBarTexture(self._imagePath .. "/progress_on.png", var_0_0)
	var_19_8:setPosition(self.ui_conf.progressPos)
	var_19_8:setPercent(arg_19_1.percent)
	var_19_8:setName("progressBar")

	if arg_19_1.status == 1 then
		var_19_8:setPercent(100)
	end

	var_19_0:addChild(var_19_8)

	local var_19_10 = cc.Label:createWithTTF((arg_19_1.percent >= 0 or nil) and (arg_19_1.finished > arg_19_1.need and string.format("%s/%s", arg_19_1.need, arg_19_1.need) or string.format("%s/%s", arg_19_1.finished, arg_19_1.need)), FONT_NAME, 20)

	var_19_10:setAnchorPoint(cc.p(1, 0.5))
	var_19_10:setPosition(self.ui_conf.percentPos)
	var_19_10:setName("percent")
	var_19_10:setVisible(arg_19_1.percent >= 0)
	var_19_10:setColor(self.ui_conf.taskspriteColor)
	var_19_0:addChild(var_19_10)

	if self._imagePath == "CommonTaskAirPlane" then
		local var_19_11 = ccui.ImageView:create(self._imagePath .. "/label_bg.png", var_0_0)

		var_19_11:setAnchorPoint(0, 0)
		var_19_3:addChild(var_19_11)

		local var_19_12 = var_19_5:getChildByName("num")

		var_19_12:setPosition(60, -40)
		var_19_12:setScale(0.6)
	end

	return var_19_0
end

function PopCommonTaskLayer:updateTaskSprite(arg_21_1, arg_21_2, arg_21_3)
	arg_21_1:setTag(100)
	arg_21_1:getChildByName("title"):setString(arg_21_2.task_des)

	local var_21_0 = drop_manager:getAllDrops(arg_21_2.drop)

	arg_21_1:getChildByName("des"):setString(arg_21_2.task_des)

	local var_21_1 = self._imagePath .. "/btn_goto.png"

	if arg_21_2.status >= 1 then
		var_21_1 = self._imagePath .. "/btn_got.png"
	elseif arg_21_2.percent >= 100 then
		var_21_1 = self._imagePath .. "/btn_get_reward.png"
	end

	arg_21_1:getChildByName("btn"):loadTextures(var_21_1, nil, var_21_1, var_0_0)
	arg_21_1:getChildByName("progressBar"):setPercent(arg_21_2.percent)

	if arg_21_2.status == 1 then
		arg_21_1:getChildByName("progressBar"):setPercent(100)
	end

	if arg_21_2.percent >= 0 then
		arg_21_1:getChildByName("percent"):setString(arg_21_2.finished > arg_21_2.need and string.format("%s/%s", arg_21_2.need, arg_21_2.need) or string.format("%s/%s", arg_21_2.finished, arg_21_2.need))
	end

	arg_21_1:getChildByName("percent"):setVisible(arg_21_2.percent >= 0)
	arg_21_1:getChildByName("btn"):addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_21_2.status >= 1 then
			return
		end

		if arg_21_2.percent >= 100 then
			activity_manager:getArtTaskReward(self.activityId, arg_21_2.taskid)
		else
			self:taskTumpTo(arg_21_2.jump)
		end
	end)

	local var_21_3 = drop_manager:getDropMsg(arg_21_2.drop)

	arg_21_1:getChildByName("icon_bg"):removeAllChildren()

	local var_21_4 = var_0_9(arg_21_2.drop, true)

	arg_21_1:getChildByName("icon_bg"):addChild(var_21_4)
	var_21_4:setScale(0.3)
	var_21_4:setPosition(cc.p(30, 40))
	var_21_4:setName("sp")

	if self._imagePath == "CommonTaskAirPlane" then
		local var_21_5 = ccui.ImageView:create(self._imagePath .. "/label_bg.png", var_0_0)

		var_21_5:setAnchorPoint(0, 0)
		arg_21_1:getChildByName("icon_bg"):addChild(var_21_5)

		local var_21_6 = var_21_4:getChildByName("num")

		var_21_6:setPosition(60, -40)
		var_21_6:setScale(0.6)
	end
end

function PopCommonTaskLayer.taskTumpTo(arg_23_0, arg_23_1)
	if arg_23_1 then
		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_23_1
		})
	end
end

function PopCommonTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopCommonTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopCommonTaskLayer:initBg(arg_27_1)
	local var_27_0 = ccui.Layout:create()

	var_27_0:setTouchEnabled(true)
	var_27_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_27_0:setAnchorPoint(cc.p(0, 0))
	var_27_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_27_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_27_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_27_0:setOpacity(0)
	self:addChild(var_27_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_28_0)
		self:addChild(arg_28_0, -2)
		arg_28_0:setPositionY(arg_28_0:getPositionY() - GameDisplay.fix_y)

		local var_28_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_28_0:setAnchorPoint(cc.p(0, 0))
		var_28_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_28_0, -1)
		self:init(arg_27_1)
		var_27_0:setOpacity(102)
		var_27_0:setTouchEnabled(false)
	end)
end
