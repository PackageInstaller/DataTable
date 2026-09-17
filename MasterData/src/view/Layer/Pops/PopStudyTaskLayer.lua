PopStudyTaskLayer = class("PopStudyTaskLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local activity_calendar_data = require("data.activity_calendar_data")
local time_check_manager = require("controller.time_check_manager")
local activity_study_task_data = require("data.activity_study_task_data")
local activity_study_servant_data = require("data.activity_study_servant_data")
local servant_data = require("data.servant_data")
local playermodel = require("model.playermodel")
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 3
local var_0_11 = 4
local var_0_12 = 5
local var_0_13 = 6
local var_0_14 = 7
local var_0_15 = 8
local var_0_16 = 183

function PopStudyTaskLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopStudyTaskLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopStudyTaskLayer:init(arg_3_1)
	print("open poplayer : PopStudyTaskLayer")

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)

	self.initparam = arg_3_1 or {}
	self.taskList = arg_3_1.list

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopStudyTaskLayer")
		end
	end)
end

function PopStudyTaskLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopStudyTaskLayer", activity_manager.activityEventId.ACTIVITY_STUDY_SERVANT_UPDATE, function(arg_6_0)
		if arg_6_0.state == var_0_15 then
			LayerManager:removePopLayer(arg_5_0.__queueindex)

			return
		end

		arg_5_0.initparam = arg_6_0
		arg_5_0.taskList = arg_6_0.list

		arg_5_0.taksView:reloadData()
		arg_5_0:updateRewardBtn()
	end)
end

function PopStudyTaskLayer:initUI()
	self:initExitTouchEvent()
	self:initTitle()
	self:initTask()
	self:initRewardBtn()
	self:playJoinInEffect()
end

function PopStudyTaskLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)
		self:exit()
	end)
end

function PopStudyTaskLayer:initTitle()
	self.panelBg = ccui.ImageView:create("PopStudyTaskLayer/bg.png", var_0_0)

	self.panelBg:setTouchEnabled(true)
	self.panelBg:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 + 50))
	self.rootLayer:addChild(self.panelBg)

	local var_10_1 = ccui.ImageView:create((self.initparam.state >= var_0_12 or nil) and "PopStudyTaskLayer/title_1.png", var_0_0)

	var_10_1:setPosition(cc.p(170, 870))
	self.panelBg:addChild(var_10_1)
end

function PopStudyTaskLayer:initRewardBtn()
	self.btnStart = ccui.Button:create("PopStudyTaskLayer/btn_" .. self.initparam.state .. ".png")

	self.btnStart:loadTextures("PopStudyTaskLayer/btn_" .. self.initparam.state .. ".png", nil, "PopStudyTaskLayer/btn_" .. self.initparam.state .. ".png", var_0_0)
	self.btnStart:setPosition(300, -90)
	self.panelBg:addChild(self.btnStart)

	local var_11_0 = cc.Label:createWithTTF("", FONT_W5, 20)

	var_11_0:setName("lbl_lock")
	var_11_0:setVisible(false)
	var_11_0:setPosition(cc.p(18, -14))
	self.btnStart:addChild(var_11_0)

	local var_11_1 = ccui.Layout:create()

	var_11_1:setContentSize(cc.size(260, 30))
	var_11_1:setAnchorPoint(cc.p(0, 0))
	var_11_1:setName("task_panel")
	var_11_1:setVisible(false)
	var_11_1:setPosition(cc.p(40, 50))
	self.btnStart:addChild(var_11_1)

	for iter_11_0 = 1, 11 do
		local var_11_2 = ccui.ImageView:create("PopStudyTaskLayer/yuan.png", var_0_0)

		var_11_2:setPosition(cc.p(24 * iter_11_0 - 12, 14))
		var_11_2:setName("icon_" .. iter_11_0)
		var_11_1:addChild(var_11_2)

		local var_11_3 = ccui.ImageView:create("PopStudyTaskLayer/dui.png", var_0_0)

		var_11_3:setPosition(cc.p(24 * iter_11_0 - 12, 14))
		var_11_3:setName("dui_" .. iter_11_0)
		var_11_1:addChild(var_11_3)
	end

	self:updateRewardBtn()
end

local var_0_17 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function PopStudyTaskLayer:updateRewardBtn()
	local var_12_0 = self.initparam

	self.btnStart:loadTextures("PopStudyTaskLayer/btn_" .. self.initparam.state .. ".png", nil, "PopStudyTaskLayer/btn_" .. self.initparam.state .. ".png", var_0_0)

	local var_12_1 = self.btnStart:getChildByName("task_panel")
	local var_12_2 = self.btnStart:getChildByName("lbl_lock")

	if self.initparam.state == var_0_8 then
		var_12_2:setVisible(true)
		var_12_2:setPosition(cc.p(170, 26))
		var_12_2:setString(L_ACTIVITY_STUDY_2 .. (activity_study_servant_data[self.initparam.servantid].name or ""))
		var_12_1:setVisible(false)
	elseif self.initparam.state == var_0_9 then
		var_12_2:setVisible(true)
		var_12_2:setPosition(cc.p(160, 58))
		var_12_2:setString(L_ACTIVITY_STUDY_1 .. (activity_study_servant_data[self.initparam.servantid].name or ""))
		var_12_1:setVisible(false)
	elseif self.initparam.state == var_0_10 or self.initparam.state == var_0_13 then
		var_12_2:setVisible(false)
		var_12_1:setVisible(true)

		for iter_12_0 = 1, 11 do
			local var_12_3 = var_12_1:getChildByName("icon_" .. iter_12_0)
			local var_12_4 = var_12_1:getChildByName("dui_" .. iter_12_0)

			if self.initparam.list[iter_12_0] then
				var_12_3:setVisible(true)
				var_12_4:setVisible(bit.band(self.initparam.finish, var_0_17[iter_12_0]) ~= 0)
			else
				var_12_3:setVisible(false)
				var_12_4:setVisible(false)
			end
		end
	else
		var_12_2:setVisible(false)
		var_12_1:setVisible(false)
	end

	self.btnStart:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_12_0.state == var_0_8 then
			goto_complete_system({
				jump_to_system = activity_study_servant_data[var_12_0.servantid].jump
			})
		elseif var_12_0.state == var_0_9 then
			activity_manager:change_activity_study(var_0_16, var_12_0.servantid)
		elseif var_12_0.state == var_0_10 then
			-- block empty
		elseif var_12_0.state == var_0_11 then
			activity_manager:finish_activity_study(var_0_16)
		elseif var_12_0.state == var_0_12 then
			activity_manager:change_activity_study(var_0_16, var_12_0.servantid)
		elseif var_12_0.state == var_0_13 then
			-- block empty
		elseif var_12_0.state == var_0_14 then
			activity_manager:finish_activity_study(var_0_16)
		elseif var_12_0.state == var_0_15 then
			global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[var_0_15])
		end
	end)
end

function PopStudyTaskLayer:initTask()
	self.taksView = cc.TableView:create(cc.size(580, 820))

	self.taksView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taksView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taksView:setAnchorPoint(cc.p(0, 0))
	self.taksView:setPosition(-10, 10)
	self.taksView:setDelegate()
	self.panelBg:addChild(self.taksView)
	self.taksView:registerScriptHandler(function(arg_16_0, arg_16_1)
		return 563, 130
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taksView:registerScriptHandler(function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:dequeueCell()

		if not var_15_0 then
			var_15_0 = cc.TableViewCell:create()

			local var_15_2 = self:createTaskSprite(self.taskList[arg_15_1 + 1], arg_15_1 + 1)

			var_15_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_15_2:setPosition(cc.p(310, 60))
			var_15_0:addChild(var_15_2)
		else
			self:updateTaskSprite(var_15_0:getChildByTag(100), self.taskList[arg_15_1 + 1], arg_15_1 + 1)
		end

		return var_15_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taksView:registerScriptHandler(function(arg_17_0, arg_17_1)
		return #self.taskList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.taksView:reloadData()
end

local var_0_18 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function PopStudyTaskLayer:createTaskSprite(arg_18_1, arg_18_2)
	local var_18_0 = ccui.ImageView:create("PopStudyTaskLayer/task_bg.png", var_0_0)

	var_18_0:setTag(100)

	local var_18_1 = bit.band(self.initparam.finish, var_0_18[activity_study_task_data[arg_18_1.taskid].index]) ~= 0
	local var_18_2 = ccui.ImageView:create("PopStudyTaskLayer/title_doing.png", var_0_0)

	if var_18_1 then
		var_18_2:loadTexture("PopStudyTaskLayer/title_complete.png", var_0_0)
	end

	var_18_2:setPosition(cc.p(270, 100))
	var_18_2:setName("title")
	var_18_0:addChild(var_18_2)

	local var_18_3 = cc.Label:createWithTTF(activity_study_task_data[arg_18_1.taskid].name, FONT_NAME, 24)

	var_18_3:setAnchorPoint(cc.p(0, 0.5))
	var_18_3:setPosition(cc.p(20, 70))
	var_18_3:setName("lblDes_1")
	var_18_3:setColor(cc.c3b(0, 0, 0))
	var_18_0:addChild(var_18_3)

	local var_18_4 = cc.Label:createWithTTF(global_trans_number(activity_study_task_data[arg_18_1.taskid].show_num or activity_study_task_data[arg_18_1.taskid].needs_num), FONT_NAME, 24)

	var_18_4:setAnchorPoint(cc.p(0, 0.5))
	var_18_4:setPosition(cc.p(20 + var_18_3:getContentSize().width + 5, 70))
	var_18_4:setName("lblDes_2")
	var_18_4:setColor(cc.c3b(255, 86, 63))
	var_18_0:addChild(var_18_4)

	local var_18_5 = cc.Label:createWithTTF(activity_study_task_data[arg_18_1.taskid].task_des or "", FONT_NAME, 24)

	var_18_5:setAnchorPoint(cc.p(0, 0.5))
	var_18_5:setPosition(cc.p(20 + var_18_3:getContentSize().width + var_18_4:getContentSize().width + 10, 70))
	var_18_5:setName("lblDes_3")
	var_18_5:setColor(cc.c3b(0, 0, 0))
	var_18_0:addChild(var_18_5)

	local var_18_7 = cc.Label:createWithTTF((not activity_study_task_data[arg_18_1.taskid].show_num or nil) and string.format("(%s/%s)", global_trans_number(arg_18_1.finished), global_trans_number(activity_study_task_data[arg_18_1.taskid].needs_num)), FONT_NAME, 24)

	var_18_7:setAnchorPoint(cc.p(0, 0.5))
	var_18_7:setPosition(cc.p(20, 25))
	var_18_7:setName("lblDes_4")
	var_18_7:setColor(cc.c3b(0, 0, 0))
	var_18_0:addChild(var_18_7)

	local var_18_8 = ccui.ImageView:create("PopStudyTaskLayer/line.png", var_0_0)

	var_18_8:setPosition(cc.p(280, 2))
	var_18_0:addChild(var_18_8)

	local var_18_9 = ccui.Button:create("PopStudyTaskLayer/btn_goto.png", nil, "PopStudyTaskLayer/btn_goto.png", var_0_0)

	if var_18_1 then
		var_18_9:loadTextures("PopStudyTaskLayer/btn_complete.png", nil, "PopStudyTaskLayer/btn_complete.png", var_0_0)
	elseif not arg_18_1.percent or arg_18_1.percent >= 100 then
		var_18_9:loadTextures("PopStudyTaskLayer/btn_get.png", nil, "PopStudyTaskLayer/btn_get.png", var_0_0)
	end

	var_18_9:setName("btn")
	var_18_9:setPosition(cc.p(460, 60))
	var_18_0:addChild(var_18_9)
	var_18_9:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_18_1 then
			return
		end

		if arg_18_1.percent and arg_18_1.percent < 100 then
			if not activity_study_task_data[arg_18_1.taskid].jump then
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = activity_study_task_data[arg_18_1.taskid].needs_target
				})

				return
			end

			self:taskTumpTo(activity_study_task_data[arg_18_1.taskid].jump)

			return
		end

		activity_manager:do_activity_study(var_0_16, self.initparam.servantid, arg_18_1.taskid)
	end)

	return var_18_0
end

function PopStudyTaskLayer:updateTaskSprite(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = bit.band(self.initparam.finish, var_0_18[activity_study_task_data[arg_20_2.taskid].index]) ~= 0

	arg_20_1:setTag(100)

	local var_20_1 = arg_20_1:getChildByName("title")

	if var_20_0 then
		var_20_1:loadTexture("PopStudyTaskLayer/title_complete.png", var_0_0)
	else
		var_20_1:loadTexture("PopStudyTaskLayer/title_doing.png", var_0_0)
	end

	local var_20_2 = arg_20_1:getChildByName("lblDes_1")

	var_20_2:setString(activity_study_task_data[arg_20_2.taskid].name)

	local var_20_3 = activity_study_task_data[arg_20_2.taskid].show_num or activity_study_task_data[arg_20_2.taskid].needs_num
	local var_20_4 = arg_20_1:getChildByName("lblDes_2")

	var_20_4:setString(global_trans_number(var_20_3))
	var_20_4:setPosition(cc.p(20 + var_20_2:getContentSize().width + 5, 70))

	local var_20_5 = arg_20_1:getChildByName("lblDes_3")

	var_20_5:setString(activity_study_task_data[arg_20_2.taskid].task_des or "")
	var_20_5:setPosition(cc.p(20 + var_20_2:getContentSize().width + var_20_4:getContentSize().width + 10, 70))

	local var_20_6 = ""

	if not activity_study_task_data[arg_20_2.taskid].show_num then
		var_20_6 = string.format("(%s/%s)", global_trans_number(arg_20_2.finished), global_trans_number(activity_study_task_data[arg_20_2.taskid].needs_num))
	end

	local var_20_7 = arg_20_1:getChildByName("lblDes_4")

	var_20_7:setString(var_20_6)
	var_20_7:setPosition(cc.p(20, 25))

	local var_20_8 = arg_20_1:getChildByName("btn")

	if var_20_0 then
		var_20_8:loadTextures("PopStudyTaskLayer/btn_complete.png", nil, "PopStudyTaskLayer/btn_complete.png", var_0_0)
	elseif not arg_20_2.percent or arg_20_2.percent >= 100 then
		var_20_8:loadTextures("PopStudyTaskLayer/btn_get.png", nil, "PopStudyTaskLayer/btn_get.png", var_0_0)
	else
		var_20_8:loadTextures("PopStudyTaskLayer/btn_goto.png", nil, "PopStudyTaskLayer/btn_goto.png", var_0_0)
	end

	var_20_8:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_20_0 then
			return
		end

		if arg_20_2.percent and arg_20_2.percent < 100 then
			if not activity_study_task_data[arg_20_2.taskid].jump then
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = activity_study_task_data[arg_20_2.taskid].needs_target
				})

				return
			end

			self:taskTumpTo(activity_study_task_data[arg_20_2.taskid].jump)

			return
		end

		activity_manager:do_activity_study(var_0_16, self.initparam.servantid, arg_20_2.taskid)
	end)
end

function PopStudyTaskLayer.taskTumpTo(arg_22_0, arg_22_1)
	if arg_22_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				activity_manager:get_activity_study_servant_info(var_0_16, arg_22_0.initparam.servantid)
			end
		})
	elseif arg_22_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			activity_manager:get_activity_study_servant_info(var_0_16, arg_22_0.initparam.servantid)
		end)
	elseif arg_22_1 == 220 then
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
				activity_manager:get_activity_study_servant_info(var_0_16, arg_22_0.initparam and arg_22_0.initparam.servantid)
			end
		})
	elseif arg_22_1 == 300 then
		LayerManager:pushInLayer("EquipLayer", {
			exitCallback = function()
				activity_manager:get_activity_study_servant_info(var_0_16, arg_22_0.initparam.servantid)
			end
		})
	elseif arg_22_1 then
		require("controller.goto_system_manager")

		local var_22_0 = {
			jump_to_system = arg_22_1
		}

		var_22_0.config = system_jump_config[SYSTEMID[arg_22_1]] and system_jump_config[SYSTEMID[arg_22_1]].config

		if var_22_0.config then
			if var_22_0.config.exitCallbackType == "function" then
				var_22_0.config.exitCallback = nil
			elseif var_22_0.config.exitCallbackType == "string" then
				var_22_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_22_0)
	end
end

function PopStudyTaskLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopStudyTaskLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopStudyTaskLayer:initBg(arg_32_1)
	local var_32_0 = ccui.Layout:create()

	var_32_0:setTouchEnabled(true)
	var_32_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_32_0:setAnchorPoint(cc.p(0, 0))
	var_32_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_32_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_32_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_32_0:setOpacity(0)
	self:addChild(var_32_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_33_0)
		self:addChild(arg_33_0, -2)
		arg_33_0:setPositionY(arg_33_0:getPositionY() - GameDisplay.fix_y)

		local var_33_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_33_0:setAnchorPoint(cc.p(0, 0))
		var_33_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_33_0, -1)
		self:init(arg_32_1)
		var_32_0:setOpacity(102)
		var_32_0:setTouchEnabled(false)
	end)
end
