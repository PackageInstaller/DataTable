ActivityPTBaseLayer = class("ActivityPTBaseLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local var_0_0
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local var_0_6 = require("controller.time_check_manager")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_conf_data = require("data.activity_conf_data")
local task_data = require("data.task_data")
local var_0_10 = config._DEBUG and 0 or 1

function ActivityPTBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityPTBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityPTBaseLayer:initStaticConfig()
	self.IS_GETTED = 1
	self.CAN_GET = 2
	self.UN_ACHIEVE = 3
	self.AWARD_NO = 0
	self.AWARD_YES = 1
	self.LEVEL_CELL_HEIGHT = 140
	self.TASK_CELL_HEIGHT = 180
	self.btn_stat_img = {
		[self.IS_GETTED] = self.layerName .. "/btn_is_getted.png",
		[self.CAN_GET] = self.layerName .. "/can_get.png",
		[self.UN_ACHIEVE] = self.layerName .. "/go_to_complete.png"
	}
	self.SHOW_TYPE_LEVEL = 1
	self.SHOW_TYPE_TASK = 2
	self.curShowType = self.SHOW_TYPE_LEVEL
	self.addPosY = self.addPosY or 0
	self.pointitemid = activity_conf_data[self.activityId].item1 or 123010001
	self.pointmaxnum = activity_conf_data[self.activityId].item_limit1 or 1000000
end

function ActivityPTBaseLayer:init(arg_4_1)
	self.activityId = arg_4_1.activityid or var_0_0
	self.layerName = "Activity_pt_" .. self.activityId
	self.activity = activity_manager:getActivityObj(self.activityId)

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)

	self.bg = ccui.ImageView:create((not cc.FileUtils:getInstance():isFileExist("mainScenebg/activity/branch" .. self.activityId .. "/" .. self.layerName .. ".png") or nil) and "mainScenebg/Activity_airuier_BPBasic.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)
	self:initStaticConfig()
	self:resetValues()
	self:initImageInJson()
	self:initBottomList()
	self:fullScreen()
	self:updateAlert()
	self:setUIPosition()
	self:switchModule()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_0 = self.activityId

			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})

			if self.activityScheduler then
				var_0_6:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
	hx_print("UI文件夹:" .. self.layerName, CONSOLE_COLOR_LIGHT_GOLD)
end

function ActivityPTBaseLayer:switchModule()
	if self.curShowType == self.SHOW_TYPE_LEVEL then
		self:getPTProceed(function(arg_7_0)
			self:updateHelpView()
			self:updateLevelView(arg_7_0.list, arg_7_0.listLen)
			self:updateAlert()
		end)
	else
		self:getPTTaskList(function(arg_8_0)
			self:updateHelpView()
			self:updateTaskView(arg_8_0.list, arg_8_0.listLen)
			self:updateAlert()
		end)
	end
end

local function var_0_11(arg_9_0)
	if arg_9_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_9_0 / 86400), math.floor(arg_9_0 % 86400 / 3600))
	elseif arg_9_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_9_0 / 3600), math.floor(arg_9_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[3], math.floor(arg_9_0 / 60), math.floor(arg_9_0 % 60))
	end
end

function ActivityPTBaseLayer.setUIPosition(arg_10_0)
	return
end

function ActivityPTBaseLayer.resetValues(arg_11_0)
	return
end

function ActivityPTBaseLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			name = "get_all_reward",
			word = "",
			handler = function(arg_14_0, arg_14_1)
				if arg_14_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.curShowType == self.SHOW_TYPE_LEVEL then
					if not activity_manager:isPTHasRewardCanGet(self.activityId) then
						global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

						return
					end

					self.global_touch_lock = true

					activity_manager:getPTProceedAward(self.activityId, nil, function()
						self.global_touch_lock = false

						self:switchModule()
					end)
				else
					if not activity_manager:isPTHasCanCompleteTask(self.activityId) then
						global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

						return
					end

					self.global_touch_lock = true

					activity_manager:getPTTaskRewardOneKey(self.activityId, function(arg_16_0)
						self.global_touch_lock = false

						if arg_16_0 == 1 then
							self:switchModule()
						end
					end)
				end
			end,
			texture = self.layerName .. "/get_all.png"
		}
	}, self.bottombgPath, self.bottomconf)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 2)

	local var_12_0 = self.rootLayer:getChildByName("panel_up")
	local var_12_1 = var_12_0:getChildByName("title_detial")

	var_12_1:setTouchEnabled(true)

	local function var_12_2(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end

	var_12_0:getChildByName("btn_detail"):addTouchEventListener(var_12_2)
	var_12_1:addTouchEventListener(var_12_2)

	local var_12_3 = var_12_0:getChildByName("lbl_time")

	var_12_3:setVisible(false)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TIME_UPDATE, function()
		return
	end)

	local var_12_4 = activity_manager:getActivityPTEndTime(self.activityId)

	if not var_12_4 then
		return
	end

	self.activityScheduler = var_0_6:addUpdatePool((var_0_6:createTimeCountDownHandler(var_12_4, function(arg_19_0)
		var_12_3:setString((var_0_11(arg_19_0)))
		var_12_3:setVisible(true)

		if arg_19_0 <= 0 and self.activityScheduler then
			LayerManager:switchShowLayer("MainLayer")
			var_0_6:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))

	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function()
		self:switchModule()
	end)
	activity_manager:get_subsystem_time(self.activityId)
end

function ActivityPTBaseLayer:initImageInJson()
	self.rootLayer:getChildByName("Panel_zi"):loadTexture(self.layerName .. "/Panel_zi.png", var_0_10)
	self.rootLayer:getChildByName("big_gift_bg"):loadTexture(self.layerName .. "/big_gift_bg.png", var_0_10)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_suo"):loadTexture(self.layerName .. "/Panel_suo.png", var_0_10)

	local var_21_0 = self.rootLayer:getChildByName("panel_up")

	var_21_0:loadTexture(self.layerName .. "/panel_up.png", var_0_10)
	var_21_0:getChildByName("button_jump_to"):loadTextures(self.layerName .. "/get_caps.png", nil, self.layerName .. "/get_caps.png", var_0_10)
	var_21_0:getChildByName("level_bg"):loadTexture(self.layerName .. "/LV.png", var_0_10)
	var_21_0:getChildByName("switch_btn_level"):loadTextures(self.layerName .. "/switch_btn_level_on.png", self.layerName .. "/switch_btn_level_on.png", self.layerName .. "/switch_btn_level_on.png", var_0_10)
	var_21_0:getChildByName("switch_btn_task"):loadTextures(self.layerName .. "/switch_btn_task.png", self.layerName .. "/switch_btn_task_on.png", self.layerName .. "/switch_btn_task.png", var_0_10)
	var_21_0:getChildByName("upup"):loadTexture(self.layerName .. "/20.png", var_0_10)
	var_21_0:getChildByName("title_detial"):loadTexture(self.layerName .. "/title_detial.png", var_0_10)
	var_21_0:getChildByName("btn_detail"):loadTextures(self.layerName .. "/dian_detail.png", nil, self.layerName .. "/dian_detail.png", var_0_10)
end

function ActivityPTBaseLayer:updateHelpView()
	self.curLevel = activity_manager:getPTProceedLevel(self.activityId) or 0

	local var_22_0 = item_manager:getItemNumber(self.pointitemid)
	local var_22_1 = self.rootLayer:getChildByName("panel_up")

	var_22_1:setLocalZOrder(999)

	local var_22_2 = var_22_1:getChildByName("level_bg")
	local var_22_3 = var_22_2:getChildByName("cur_level")

	var_22_3:setString(var_22_0 .. "/" .. self.pointmaxnum)

	local var_22_4 = var_22_3:getContentSize().width + 40

	var_22_4 = var_22_4 < 156 and 156 or var_22_4

	var_22_2:setContentSize(cc.size(var_22_4, var_22_2:getContentSize().height))
	var_22_3:setPosition(self.pointLabelPosX or var_22_4 / 2 - 5, var_22_2:getContentSize().height / 2)

	local var_22_5 = var_22_1:getChildByName("button_jump_to")

	var_22_5:setVisible(activity_manager:checkBtnBuyVisible(self.activityId .. "_buybtn_showtime"))
	var_22_5:loadTextures(self.layerName .. "/get_caps.png", self.layerName .. "/get_caps.png", self.layerName .. "/get_caps.png", var_0_10)
	var_22_5:setSwallowTouches(true)
	var_22_5:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_23_0

		if self.curLevel >= activity_manager:getPTProceedMaxLevel(self.activityId) then
			global_ShowBlockWords(L_MAX_LEVLE)

			do return end

			var_23_0 = {
				activityId = self.activityId,
				imagePath = self.layerName,
				layerName = self.layerName
			}
		end

		function var_23_0.exitCallback()
			self:switchModule()
		end

		LayerManager:pushInLayer("PopPTBuyLayer", var_23_0)
	end)

	if not self.progressBar then
		self.progressBar = ccui.Slider:create()

		self.progressBar:loadBarTexture(self.layerName .. "/progress_banner_bg.png", var_0_10)
		self.progressBar:loadProgressBarTexture(self.layerName .. "/progress_banner.png", var_0_10)
		self.progressBar:setPosition(self.progressBar_pos or cc.p(490, 74))
		self.progressBar:setPercent(var_22_0 / self.pointmaxnum * 100)
		var_22_1:addChild(self.progressBar)
	else
		self.progressBar:setPercent(var_22_0 / self.pointmaxnum * 100)
	end

	local var_22_6 = var_22_1:getChildByName("switch_btn_level")
	local var_22_7 = var_22_1:getChildByName("switch_btn_task")

	var_22_6:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			return
		end

		var_22_6:loadTextures(self.layerName .. "/switch_btn_level_on.png", nil, self.layerName .. "/switch_btn_level_on.png", var_0_10)
		var_22_7:loadTextures(self.layerName .. "/switch_btn_task.png", nil, self.layerName .. "/switch_btn_task.png", var_0_10)

		self.curShowType = self.SHOW_TYPE_LEVEL

		self:switchModule()
	end)
	var_22_7:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_TASK then
			return
		end

		var_22_6:loadTextures(self.layerName .. "/switch_btn_level.png", nil, self.layerName .. "/switch_btn_level.png", var_0_10)
		var_22_7:loadTextures(self.layerName .. "/switch_btn_task_on.png", nil, self.layerName .. "/switch_btn_task_on.png", var_0_10)

		self.curShowType = self.SHOW_TYPE_TASK

		self:switchModule()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "upup"):setLocalZOrder(1)
end

function ActivityPTBaseLayer:updateLevelView(arg_27_1, arg_27_2)
	if not self.curLevel or self.curLevel < 0 then
		return
	end

	if self.taskView then
		self.taskView:setVisible(false)
	end

	self.levelListLen = arg_27_2
	self.levelListData = arg_27_1 or {}

	if self.levelView then
		self.levelView:setVisible(true)
		self:updateShowingCells(self.levelView, self.levelListLen)

		return
	end

	local var_27_0 = self.bottomList:getPositionY() + 65

	self.levelView = cc.TableView:create(cc.size(640, 690 + GameDisplay.height - 1136))

	self.levelView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.levelView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.levelView:setAnchorPoint(cc.p(0, 0))
	self.levelView:setPosition(0, var_27_0)
	self.levelView:setDelegate()
	self.rootLayer:addChild(self.levelView)
	self.levelView:registerScriptHandler(function(arg_29_0, arg_29_1)
		return 640, self.LEVEL_CELL_HEIGHT
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.levelView:registerScriptHandler(function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_0:dequeueCell()

		if not var_28_0 then
			var_28_0 = cc.TableViewCell:create()

			if arg_28_1 ~= self.levelListLen then
				local var_28_2 = self:createLevelSprite(self.levelListData[arg_28_1 + 1])

				var_28_2:setAnchorPoint(cc.p(0.5, 0.5))
				var_28_2:setPosition(cc.p(320, self.LEVEL_CELL_HEIGHT / 2))
				var_28_0:addChild(var_28_2)
			end

			var_28_0:setLocalZOrder(999 - 10 * arg_28_1)
		else
			local var_28_3 = var_28_0:getChildByTag(100)

			if arg_28_1 == self.levelListLen then
				var_28_3:setVisible(false)
			else
				var_28_3:setVisible(true)
				self:updateLevelSprite(var_28_3, self.levelListData[arg_28_1 + 1])
				var_28_0:setLocalZOrder(999 - 10 * arg_28_1)
			end
		end

		return var_28_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.levelView:registerScriptHandler(function(arg_30_0, arg_30_1)
		return self.levelListLen + 1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.levelView:reloadData()
	self.levelView:scrollToIndex(self:getNeedJumpToIndex(), false)
end

function ActivityPTBaseLayer:createLevelSprite(arg_31_1)
	local var_31_0 = ccui.ImageView:create(self.layerName .. "/pt_bg.png", var_0_10)

	var_31_0:setName("sprite_bg")
	var_31_0:setTag(100)

	if type(arg_31_1.level) == "string" then
		var_31_0:setVisible(false)
	else
		var_31_0:setVisible(true)
	end

	local var_31_1 = ccui.ImageView:create(self.layerName .. (self:checkPointEnough(arg_31_1) and "/level_bg_l.png" or "/level_bg_b.png"), var_0_10)

	var_31_1:setPosition(cc.p(63, self.LEVEL_CELL_HEIGHT / 2))
	var_31_1:setName("cur_level_bg_b")
	var_31_0:addChild(var_31_1, 100)

	local var_31_2 = cc.Label:createWithTTF(tostring(arg_31_1.limitpoint), FONT_NAME, global_change_fontsize_by_length(arg_31_1.limitpoint, 26, 3, 8))

	var_31_2:setName("cur_level_lbl")
	var_31_2:setColor(self:checkPointEnough(arg_31_1) and cc.c3b(255, 255, 255) or cc.c3b(217, 223, 240))
	var_31_2:setPosition(cc.p(var_31_1:getContentSize().width / 2, var_31_1:getContentSize().height / 2 - 10))
	var_31_1:addChild(var_31_2)

	local var_31_3 = ccui.Slider:create()

	var_31_3:setAnchorPoint(cc.p(0, 0.5))
	var_31_3:setRotation(90)
	var_31_3:setName("progress_bar")
	var_31_3:loadBarTexture(self.layerName .. "/progress_acr_bg.png", var_0_10)
	var_31_3:loadProgressBarTexture(self.layerName .. "/progress_acr.png", var_0_10)
	var_31_3:setPosition(cc.p(var_31_1:getPositionX(), var_31_1:getPositionY() - var_31_1:getContentSize().height / 2 + 8))
	var_31_0:addChild(var_31_3, 50)

	if arg_31_1.level == activity_manager:getPTProceedMaxLevel(self.activityId) then
		var_31_3:setVisible(false)
	elseif arg_31_1.level < self.curLevel then
		var_31_3:setPercent(100)
	elseif arg_31_1.level == self.curLevel then
		var_31_3:setPercent((self:getCurLevelProceedPrecent(self.curLevel)))
	else
		var_31_3:setPercent(0)
	end

	if type(arg_31_1.level) ~= "string" and arg_31_1.drop then
		local var_31_4 = ccui.Layout:create()

		var_31_4:setPosition(cc.p(124, self.LEVEL_CELL_HEIGHT / 2))
		var_31_4:setName("drop_node")
		var_31_0:addChild(var_31_4)

		for iter_31_0, iter_31_1 in pairs((activity_manager:getPTDrop(arg_31_1.drop))) do
			local var_31_5 = ItemPurchaseSprite:createPurchaseItem(iter_31_1.dropid, iter_31_1.dropNum)

			var_31_5:setScale(0.6)
			var_31_5:setTouchEnabled(true)
			var_31_5:setOpacity(arg_31_1.stat == self.AWARD_YES and 180 or 255)
			var_31_5:setSwallowTouches(false)
			var_31_5:getChildByName("wordBg"):loadTexture(self.layerName .. "/num_bg.png", var_0_10)
			var_31_5:getChildByName("wordBg"):setScale(1.6)
			var_31_5:getChildByName("numLabel"):setColor(cc.p(78, 65, 138))
			var_31_5:addTouchEventListener(function(arg_32_0, arg_32_1)
				if arg_32_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_32_0:getTouchBeganPosition().y - arg_32_0:getTouchEndPosition().y) > 50 then
					return
				end

				if type(iter_31_1.dropid) == "string" then
					return
				end

				LayerManager:pushInLayer("PopItemLayer", {
					itemid = iter_31_1.dropid
				})
			end)
			var_31_5:setPosition(cc.p(92 + (iter_31_0 - 1) * 150, 0))
			var_31_4:addChild(var_31_5)

			local var_31_6 = ccui.ImageView:create(self.layerName .. "/sp_mark.png", var_0_10)

			var_31_6:setVisible(arg_31_1.stat == self.AWARD_YES)
			var_31_6:setPosition(var_31_5:getPositionX(), var_31_5:getPositionY())
			var_31_6:setName("pt_mark")
			var_31_4:addChild(var_31_6, 999)
		end
	end

	local var_31_8 = ccui.Button:create(self.layerName .. (arg_31_1.stat == self.AWARD_YES and "/progress_btn3.png" or self:checkPointEnough(arg_31_1) and "/progress_btn.png" or "/progress_btn2.png"), nil, self.layerName .. "/progress_btn.png", var_0_10)

	var_31_8:setPosition(526, self.LEVEL_CELL_HEIGHT / 2)
	var_31_8:setName("sureBtn")
	var_31_0:addChild(var_31_8)
	var_31_8:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_33_0:getTouchBeganPosition().y - arg_33_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self.global_touch_lock then
			return
		end

		if arg_31_1.stat == self.AWARD_YES then
			return
		end

		self:getPTProceedAward(arg_31_1.level)
	end)

	if type(arg_31_1.level) == "string" then
		var_31_0:setVisible(false)
	else
		var_31_0:setVisible(true)
	end

	return var_31_0
end

function ActivityPTBaseLayer:updateLevelSprite(arg_34_1, arg_34_2)
	if type(arg_34_2.level) == "string" then
		arg_34_1:setVisible(false)
	else
		arg_34_1:setVisible(true)
	end

	arg_34_1:setTag(100)

	local var_34_0 = arg_34_1:getChildByName("cur_level_bg_b")

	var_34_0:loadTexture(self.layerName .. (self:checkPointEnough(arg_34_2) and "/level_bg_l.png" or "/level_bg_b.png"), var_0_10)

	local var_34_1 = var_34_0:getChildByName("cur_level_lbl")

	var_34_1:setColor(self:checkPointEnough(arg_34_2) and cc.c3b(255, 255, 255) or cc.c3b(217, 223, 240))
	var_34_1:setString(tostring(arg_34_2.limitpoint))

	local var_34_2 = var_34_1:getTTFConfig()

	var_34_2.fontSize = global_change_fontsize_by_length(arg_34_2.limitpoint, 26, 3, 8)

	var_34_1:setTTFConfig(var_34_2)
	var_34_1:setPosition(cc.p(var_34_0:getContentSize().width / 2, var_34_0:getContentSize().height / 2 - 10))

	local var_34_3 = arg_34_1:getChildByName("progress_bar")

	if arg_34_2.level == activity_manager:getPTProceedMaxLevel(self.activityId) then
		var_34_3:setVisible(false)
	elseif arg_34_2.level < self.curLevel then
		var_34_3:setVisible(true)
		var_34_3:setPercent(100)
	elseif arg_34_2.level == self.curLevel then
		var_34_3:setVisible(true)
		var_34_3:setPercent((self:getCurLevelProceedPrecent(self.curLevel)))
	else
		var_34_3:setVisible(true)
		var_34_3:setPercent(0)
	end

	local var_34_4 = arg_34_1:getChildByName("drop_node")

	if var_34_4 then
		var_34_4:removeFromParent()
	end

	if type(arg_34_2.level) ~= "string" and arg_34_2.drop then
		local var_34_5 = ccui.Layout:create()

		var_34_5:setPosition(cc.p(124, self.LEVEL_CELL_HEIGHT / 2))
		var_34_5:setName("drop_node")
		arg_34_1:addChild(var_34_5)

		for iter_34_0, iter_34_1 in pairs((activity_manager:getPTDrop(arg_34_2.drop))) do
			local var_34_6 = ItemPurchaseSprite:createPurchaseItem(iter_34_1.dropid, iter_34_1.dropNum)

			var_34_6:setScale(0.6)
			var_34_6:setOpacity(arg_34_2.stat == self.AWARD_YES and 180 or 255)
			var_34_6:setTouchEnabled(true)
			var_34_6:setSwallowTouches(false)
			var_34_6:getChildByName("wordBg"):loadTexture(self.layerName .. "/num_bg.png", var_0_10)
			var_34_6:getChildByName("wordBg"):setScale(1.6)
			var_34_6:getChildByName("numLabel"):setColor(cc.p(78, 65, 138))
			var_34_6:addTouchEventListener(function(arg_35_0, arg_35_1)
				if arg_35_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_35_0:getTouchBeganPosition().y - arg_35_0:getTouchEndPosition().y) > 50 then
					return
				end

				if type(iter_34_1.dropid) == "string" then
					return
				end

				LayerManager:pushInLayer("PopItemLayer", {
					itemid = iter_34_1.dropid
				})
			end)
			var_34_6:setPosition(cc.p(92 + (iter_34_0 - 1) * 150, 0))
			var_34_5:addChild(var_34_6)

			local var_34_7 = ccui.ImageView:create(self.layerName .. "/sp_mark.png", var_0_10)

			var_34_7:setVisible(arg_34_2.stat == self.AWARD_YES)
			var_34_7:setPosition(var_34_6:getPositionX(), var_34_6:getPositionY())
			var_34_7:setName("pt_mark")
			var_34_5:addChild(var_34_7, 999)
		end
	end

	local var_34_9 = arg_34_1:getChildByName("sureBtn")

	var_34_9:loadTextures(self.layerName .. nil, nil, self.layerName .. (arg_34_2.stat == self.AWARD_YES and "/progress_btn3.png" or self:checkPointEnough(arg_34_2) and "/progress_btn.png" or "/progress_btn2.png"), var_0_10)
	var_34_9:setPosition(526, self.LEVEL_CELL_HEIGHT / 2)
	var_34_9:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_36_0:getTouchBeganPosition().y - arg_36_0:getTouchEndPosition().y) > 50 then
			return
		end

		if self.global_touch_lock then
			return
		end

		if arg_34_2.stat == self.AWARD_YES then
			return
		end

		self:getPTProceedAward(arg_34_2.level)
	end)
end

function ActivityPTBaseLayer:getNeedJumpToIndex()
	local var_37_0, var_37_1 = GetTableViewShowCellIdx(self.levelView, {
		maxcount = math.ceil(self.levelListLen),
		cellsize = cc.size(640, self.LEVEL_CELL_HEIGHT)
	})

	return (self.curLevel + (var_37_1 - var_37_0 - 2) > self.levelListLen or nil) and self.levelListLen
end

function ActivityPTBaseLayer:updateTaskView(arg_38_1, arg_38_2)
	if self.levelView then
		self.levelView:setVisible(false)
	end

	self.taskListData = arg_38_1
	self.taskListLen = arg_38_2

	if self.taskView then
		self.taskView:setVisible(true)
		self:updateShowingCells(self.taskView, self.taskListLen)

		return
	end

	local var_38_0 = self.bottomList:getPositionY() + 65
	local var_38_1 = (690 + GameDisplay.height - 1136) / self.LEVEL_CELL_HEIGHT

	self.taskView = cc.TableView:create(cc.size(640, 690 + GameDisplay.height - 1136))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(0, var_38_0)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView)
	self.taskView:registerScriptHandler(function(arg_40_0, arg_40_1)
		return 640, self.LEVEL_CELL_HEIGHT
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_39_0, arg_39_1)
		local var_39_0 = arg_39_0:dequeueCell()

		if not var_39_0 then
			var_39_0 = cc.TableViewCell:create()

			local var_39_2 = self:createTaskSprite(self.taskListData[arg_39_1 + 1])

			var_39_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_39_2:setPosition(cc.p(320, self.LEVEL_CELL_HEIGHT / 2))
			var_39_0:addChild(var_39_2)
			var_39_0:setLocalZOrder(999 - 10 * arg_39_1)

			if arg_39_1 < var_38_1 then
				var_39_2:setOpacity(0)
				var_39_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_39_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_39_3 = var_39_0:getChildByTag(100)

			self:updateTaskSprite(var_39_3, self.taskListData[arg_39_1 + 1])
			var_39_0:setLocalZOrder(999 - 10 * arg_39_1)

			if self.showEffect and arg_39_1 < var_38_1 then
				var_39_3:setOpacity(0)
				var_39_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_39_1), cc.FadeIn:create(0.1)))
			elseif var_39_3:getOpacity() < 255 then
				var_39_3:setOpacity(255)
			end
		end

		return var_39_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_41_0, arg_41_1)
		return self.taskListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.taskView:reloadData()
end

function ActivityPTBaseLayer:createTaskSprite(arg_43_1)
	local var_43_0 = ccui.ImageView:create(self.layerName .. "/task_bg_light.png", var_0_10)

	var_43_0:setName("sprite_bg")
	var_43_0:setTag(100)

	local var_43_1 = ccui.ImageView:create(self.layerName .. "/level_icon.png", var_0_10)

	var_43_1:setScale(0.48)
	var_43_1:setPosition(cc.p(80, var_43_0:getContentSize().height / 2 - 5))
	var_43_0:addChild(var_43_1)

	local var_43_2 = cc.Label:createWithTTF("X" .. activity_manager:getPTDrop(arg_43_1.drop)[1].dropNum, FONT_DES, 21)

	var_43_2:setName("pt_num")
	var_43_2:setColor(cc.c3b(0, 0, 0))
	var_43_2:setPosition(cc.p(140, 30))
	var_43_0:addChild(var_43_2)

	local var_43_3 = cc.Label:createWithTTF(arg_43_1.name, FONT_DES, 24)

	var_43_3:setName("name_lbl")
	var_43_3:setMaxLineWidth(450)
	var_43_3:setColor(cc.c3b(0, 0, 0))
	var_43_3:setAnchorPoint(0, 0.5)
	var_43_3:setPosition(cc.p(150, 78))
	var_43_0:addChild(var_43_3)

	local var_43_4 = ccui.Button:create()

	var_43_4:setAnchorPoint(cc.p(1, 0.5))

	if arg_43_1.status >= 1 then
		var_43_4:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_10)
	elseif arg_43_1.percent >= 100 then
		var_43_4:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_10)
	else
		var_43_4:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_10)
	end

	var_43_4:setPosition(cc.p(var_43_0:getContentSize().width - 20, var_43_0:getContentSize().height / 2))
	var_43_4:setName("get_reward_btn")
	var_43_0:addChild(var_43_4)
	var_43_4:addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_43_1.status >= 1 then
			return
		end

		if arg_43_1.percent >= 100 then
			self.global_touch_lock = true

			activity_manager:getPTTaskReward(self.activityId, arg_43_1.taskid, function(arg_45_0)
				self.global_touch_lock = false

				if arg_45_0 == 1 then
					self:switchModule()
				end
			end)
		else
			self:taskTumpTo(arg_43_1.jump)
		end
	end)

	local var_43_5 = ccui.Slider:create()

	var_43_5:setAnchorPoint(cc.p(0, 0.5))
	var_43_5:setName("progress_bar")
	var_43_5:loadBarTexture(self.layerName .. "/task_percent_bg.png", var_0_10)
	var_43_5:loadProgressBarTexture(self.layerName .. "/task_percent.png", var_0_10)
	var_43_5:setPosition(cc.p(180, 24))
	var_43_0:addChild(var_43_5)

	local var_43_7 = arg_43_1.status == 1 and 100 or arg_43_1.percent

	var_43_5:setPercent(arg_43_1.status == 1 and 100 or arg_43_1.percent)

	local var_43_8 = cc.Label:createWithTTF(var_43_7 .. "%", FONT_DES, 20)

	var_43_8:setName("percent_lbl")
	var_43_8:setColor(cc.c3b(0, 0, 0))
	var_43_8:setPosition(cc.p(458, 28))
	var_43_0:addChild(var_43_8)

	return var_43_0
end

function ActivityPTBaseLayer:updateTaskSprite(arg_46_1, arg_46_2)
	arg_46_1:getChildByName("pt_num"):setString("X" .. activity_manager:getPTDrop(arg_46_2.drop)[1].dropNum)
	arg_46_1:getChildByName("name_lbl"):setString(arg_46_2.name)

	local var_46_0 = arg_46_1:getChildByName("get_reward_btn")

	if arg_46_2.status >= 1 then
		var_46_0:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_10)
	elseif arg_46_2.percent >= 100 then
		var_46_0:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_10)
	else
		var_46_0:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_10)
	end

	var_46_0:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_46_2.status >= 1 then
			return
		end

		if arg_46_2.percent >= 100 then
			self.global_touch_lock = true

			activity_manager:getPTTaskReward(self.activityId, arg_46_2.taskid, function(arg_48_0)
				self.global_touch_lock = false

				if arg_48_0 == 1 then
					self:switchModule()
				end
			end)
		else
			self:taskTumpTo(arg_46_2.jump)
		end
	end)

	local var_46_2 = arg_46_2.status == 1 and 100 or arg_46_2.percent

	arg_46_1:getChildByName("progress_bar"):setPercent(arg_46_2.status == 1 and 100 or arg_46_2.percent)
	arg_46_1:getChildByName("percent_lbl"):setString(var_46_2 .. "%")
end

function ActivityPTBaseLayer.taskTumpTo(arg_49_0, arg_49_1)
	if arg_49_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				arg_49_0:switchModule()
			end
		})
	elseif arg_49_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			arg_49_0:switchModule()
		end)
	elseif arg_49_1 == 220 then
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
				arg_49_0:switchModule()
			end
		})
	elseif arg_49_1 == 300 then
		LayerManager:pushInLayer("EquipLayer", {
			exitCallback = function()
				arg_49_0:switchModule()
			end
		})
	elseif arg_49_1 then
		require("controller.goto_system_manager")

		local var_49_0 = {
			jump_to_system = arg_49_1
		}

		var_49_0.config = system_jump_config[SYSTEMID[arg_49_1]] and system_jump_config[SYSTEMID[arg_49_1]].config

		if var_49_0.config then
			if var_49_0.config.exitCallbackType == "function" then
				var_49_0.config.exitCallback = nil
			elseif var_49_0.config.exitCallbackType == "string" then
				var_49_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_49_0)
	end
end

function ActivityPTBaseLayer:updateShowingCells(arg_56_1, arg_56_2)
	local var_56_0, var_56_1 = GetTableViewShowCellIdx(arg_56_1, {
		maxcount = math.ceil(arg_56_2),
		cellsize = cc.size(640, self.LEVEL_CELL_HEIGHT)
	})

	for iter_56_0 = var_56_0, var_56_1 do
		arg_56_1:updateCellAtIndex(iter_56_0)
	end
end

function ActivityPTBaseLayer:fullScreen()
	local var_57_0 = self.rootLayer:getChildByName("panel_up")

	var_57_0:setAnchorPoint(cc.p(0.5, 1))
	var_57_0:setPositionY(GameDisplay.getUiScreenSize().height - GameDisplay.fix_y)
	self.rootLayer:getChildByName("Panel_zi"):setPositionY(GameDisplay.getUiScreenSize().height - 410 - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)

	local var_57_1 = self.rootLayer:getChildByName("big_gift_bg")

	var_57_1:setPositionY(self.bottomList:getPositionY() + 130)
	var_57_1:setLocalZOrder(50)
	self.bottomList:setLocalZOrder(51)
end

function ActivityPTBaseLayer:updateAlert()
	local var_58_0 = self.rootLayer:getChildByName("panel_up")
	local var_58_1 = var_58_0:getChildByName("switch_btn_level")
	local var_58_2 = var_58_0:getChildByName("switch_btn_task")
	local var_58_3 = {
		x = 330,
		y = 70
	}

	if activity_manager:getAlertStatus(self.activityId, "pt_proceed") then
		global_add_alert_tag(var_58_1, var_58_3)
	else
		global_remove_alert_tag(var_58_1)
	end

	if activity_manager:getAlertStatus(self.activityId, "pt") then
		global_add_alert_tag(var_58_2, var_58_3)
	else
		global_remove_alert_tag(var_58_2)
	end
end

function ActivityPTBaseLayer:getPTProceed(arg_59_1)
	self.global_touch_lock = true

	activity_manager:getPTProceed(self.activityId, function(arg_60_0)
		arg_59_1(arg_60_0)

		self.global_touch_lock = false
	end)
end

function ActivityPTBaseLayer:getPTTaskList(arg_61_1)
	self.global_touch_lock = true

	activity_manager:getPTTaskList(self.activityId, function(arg_62_0)
		arg_61_1(arg_62_0)

		self.global_touch_lock = false
	end)
end

function ActivityPTBaseLayer:getPTProceedAward(arg_63_1)
	self.global_touch_lock = true

	activity_manager:getPTProceedAward(self.activityId, arg_63_1, function(arg_64_0)
		self.global_touch_lock = false

		if arg_64_0 == 1 then
			self:switchModule()
		end
	end)
end

function ActivityPTBaseLayer:checkPointEnough(arg_65_1)
	return item_manager:getItemNumber(self.pointitemid) >= arg_65_1.limitpoint
end

function ActivityPTBaseLayer:getCurLevelProceedPrecent(arg_66_1)
	if not activity_proceed_data[self.activityId .. "-" .. arg_66_1 + 1] then
		return 100
	end

	return item_manager:getItemNumber(self.pointitemid) / activity_proceed_data[self.activityId .. "-" .. arg_66_1 + 1].num1 * 100
end
