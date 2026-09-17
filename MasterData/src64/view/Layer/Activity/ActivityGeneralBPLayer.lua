ActivityGeneralBPLayer = class("ActivityGeneralBPLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local favorfile_data = require("data.favorfile_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local drop_data = require("data.drop_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_return_manager = require("controller.activity_return_manager")
local test_fight_manager = require("controller.test_fight_manager")
local Utility = require("common.Utility")
local TempWidget = require("view/Sprite/TempWidget")
local var_0_15 = config._DEBUG and 0 or 1
local var_0_16 = {
	"white",
	"green",
	"blue",
	"purple",
	"orange",
	"red"
}
local task_data = require("data.task_data")

function ActivityGeneralBPLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityGeneralBPLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityGeneralBPLayer:initStaticConfig()
	self.IS_GETTED = 1
	self.CAN_GET = 2
	self.UN_ACHIEVE = 3
	self.LEVEL_UNACHIEVE = 0
	self.UNRECEIVE = 1
	self.RECEIVE_ORDINARY = 2
	self.RECEIVE_ALL = 3
	self.QIOGN_B = 4
	self.LEVEL_CELL_HEIGHT = self:get_level_cell_height()
	self.TASK_CELL_HEIGHT = self:get_task_cell_height()
	self.btn_stat_img = {
		[self.IS_GETTED] = self.layerName .. "/btn_yiwancheng.png",
		[self.CAN_GET] = self.layerName .. "/btn_lingqujiangli.png",
		[self.UN_ACHIEVE] = self.layerName .. "/btn_qianwangwancheng.png"
	}
	self.SHOW_TYPE_LEVEL = 1
	self.SHOW_TYPE_TASK = 2
	self.curShowType = self.SHOW_TYPE_LEVEL
end

function ActivityGeneralBPLayer:init(arg_4_1)
	self.activityId = arg_4_1.activityId

	ErrorCodeManager:check({
		systemname = "ActivityGeneralBPLayer",
		id = self.activityId
	})

	self.layerName = activity_manager:getBPLayerName(self.activityId) or "Activity_bp_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.bg = ccui.ImageView:create((not cc.FileUtils:getInstance():isFileExist("mainScenebg/" .. self.layerName .. ".png") or nil) and "mainScenebg/Activity_airuier_BPBasic.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initStaticConfig()
	self:initBaseUI()
	self:initBottomList()
	self:initTimeLabel()
	self:fullScreen()
	self:updateAlert()
	self:registerActivityEventListener()
	activity_manager:getBattlePassLevelData(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
	hx_print("UI文件夹:" .. self.layerName, CONSOLE_COLOR_LIGHT_GOLD)
end

function ActivityGeneralBPLayer:get_level_cell_height()
	return ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode1"):getPositionY() - ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode2"):getPositionY()
end

function ActivityGeneralBPLayer:get_task_cell_height()
	return ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode1"):getPositionY() - ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode2"):getPositionY()
end

function ActivityGeneralBPLayer:initBaseUI()
	self.panelUp = self.rootLayer:getChildByName("panel_up")
	self.title = ccui.Helper:seekWidgetByName(self.panelUp, "title_detial")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.panelUp, "lbl_time")
	self.lblCurLevel = ccui.Helper:seekWidgetByName(self.panelUp, "cur_level")
	self.lblCurExp = ccui.Helper:seekWidgetByName(self.panelUp, "cur_exp")
	self.btnGoTo = ccui.Helper:seekWidgetByName(self.panelUp, "button_jump_to")
	self.progressBar = ccui.Helper:seekWidgetByName(self.panelUp, "ProgressBar_banner")
	self.BtnBuyPt = ccui.Helper:seekWidgetByName(self.panelUp, "Button_buy")
	self.switchBtnLevel = ccui.Helper:seekWidgetByName(self.panelUp, "switch_btn_level")
	self.switchBtnTask = ccui.Helper:seekWidgetByName(self.panelUp, "switch_btn_task")
	self.upup = ccui.Helper:seekWidgetByName(self.panelUp, "upup")
	self.lockIcon = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_suo")
	self.bigGiftPanel = self.rootLayer:getChildByName("big_gift_bg")
	self.bottomList = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bottom")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return")
	self.btnAllReward = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.btnJump = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_jump")
	self.panelLevel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_level")
	self.levelNode1 = ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode1")
	self.levelNode2 = ccui.Helper:seekWidgetByName(self.rootLayer, "levelnode2")
	self.panelTask = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_task")
	self.taskNode1 = ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode1")
	self.taskNode2 = ccui.Helper:seekWidgetByName(self.rootLayer, "tasknode2")

	self.switchBtnLevel:loadTextures(self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", var_0_15)
	self.switchBtnTask:loadTextures(self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", var_0_15)
	self.panelLevel:setVisible(false)
	self.panelTask:setVisible(false)
	self:initDynamicUI()
end

function ActivityGeneralBPLayer:updateBtnSignRedDot()
	if activity_return_manager:get_can_sign() then
		global_add_alert_tag(self.btn_sign, cc.p(85, 85))
	else
		global_remove_alert_tag(self.btn_sign)
	end
end

function ActivityGeneralBPLayer:initDynamicUI()
	local var_10_0 = activity_manager:getBPShowFurniture(self.activityId)

	self.furnitureBg = ccui.Helper:seekWidgetByName(self.rootLayer, "furniture_bg")

	if self.furnitureBg and var_10_0 then
		self.furnitureBg:setVisible(true)
		self.furnitureBg:getChildByName("furniture"):loadTexture(self.layerName .. "/" .. var_10_0 .. ".png", var_0_15)
	end
end

function ActivityGeneralBPLayer:initBottomList()
	self.btnReturn:setVisible(self.activityId ~= 136 and self.activityId ~= 255)
	self.btnReturn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btnAllReward:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			if not activity_manager:isHasRewardCanGet(self.activityId) then
				global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

				return
			end

			activity_manager:getBattlePassReward(self.activityId)
		else
			if not activity_manager:isHasCanCompleteTask(self.activityId) then
				global_ShowBlockWords(L_BATTLE_PASS.NOT_REWARD_CAN_GET)

				return
			end

			activity_manager:getBPTaskRewardOneKey(self.activityId)
		end
	end)
	self.btnJump:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopBpPreviewGiftLayer", {
			activityId = self.activityId,
			imagePath = self.layerName
		})
	end)
	self.title:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self.layerName
		})
	end)
end

function ActivityGeneralBPLayer:initTimeLabel()
	local var_16_0 = activity_manager:get_module_finishtime(self.activityId, "bp")

	if not var_16_0 then
		self.timeLabel:setVisible(false)

		return
	end

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(var_16_0) - time_check_manager:getCurTime(), function(arg_17_0)
		self.timeLabel:setString(L_LEFT_TIME_SPACE .. Global_format_time_str(arg_17_0))

		if arg_17_0 <= 0 and self.activityScheduler then
			self.timeLabel:setVisible(false)
			time_check_manager:removeUpdatePool(self.activityScheduler)

			self.activityScheduler = nil
		end
	end)))
end

function ActivityGeneralBPLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, function(arg_19_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			self:updateLevelView(arg_19_0.list, arg_19_0.listLen)
			self:updateShowBigGift()
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_20_0)
		self:updateHelpView()

		if arg_20_0 and self.curShowType == self.SHOW_TYPE_TASK then
			self:updateTaskView(arg_20_0.list, arg_20_0.listLen)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_21_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			activity_manager:getBattlePassLevelData(self.activityId)
		end
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_22_0)
		self:updateAlert()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_23_0)
		self:updateHelpView()

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			activity_manager:getBattlePassLevelData(self.activityId)
		end
	end), self)
end

function ActivityGeneralBPLayer:updateHelpView()
	self.curLevel = activity_manager:getCurBattlePassLevel(self.activityId) or 0

	local var_24_0 = self.panelUp

	self.panelUp:setLocalZOrder(999)
	self.lblCurLevel:setString(self.curLevel - 1)

	if self.curLevel > activity_manager:getBPMaxLevel(self.activityId) then
		self.lblCurLevel:setString("Max")
	end

	self.curExp = activity_manager:getBattlePassExp(self.activityId, self.curLevel)

	local var_24_1, var_24_2 = activity_manager:getCurLevelProceed(self.activityId, self.curLevel)

	self.lblCurExp:setString(var_24_2)

	local var_24_3 = self.btnGoTo

	if activity_manager:isBattlePassSVIP(self.activityId) then
		var_24_3:loadTextures(self.layerName .. "/btn_yiquanbugoumai.png", self.layerName .. "/btn_yiquanbugoumai.png", self.layerName .. "/btn_yiquanbugoumai.png", var_0_15)
	elseif activity_manager:isBattlePassVIP(self.activityId) then
		var_24_3:loadTextures(self.layerName .. "/btn_shengji.png", self.layerName .. "/btn_shengji.png", self.layerName .. "/btn_shengji.png", var_0_15)
	else
		var_24_3:loadTextures(self.layerName .. "/btn_kaiqizhiyuan.png", self.layerName .. "/btn_kaiqizhiyuan.png", self.layerName .. "/btn_kaiqizhiyuan.png", var_0_15)
	end

	var_24_3:setSwallowTouches(true)
	var_24_3:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isBattlePassSVIP(self.activityId) then
			if self.curLevel >= activity_manager:getBPMaxLevel(self.activityId) then
				if not activity_manager:isBattlePassVIP(self.activityId) or not activity_manager:isBattlePassSVIP(self.activityId) then
					LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
						activityId = self.activityId,
						imagePath = self.layerName
					})

					return
				end

				global_ShowBlockWords(L_MAX_LEVLE)

				return
			end

			LayerManager:pushInLayer("PopBattlePassBuyLayer", {
				activityId = self.activityId,
				imagePath = self.layerName
			})
		else
			LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
				activityId = self.activityId,
				imagePath = self.layerName
			})
		end
	end)
	self.progressBar:setPercent(var_24_1)
	self.BtnBuyPt:setVisible(activity_manager:isBattlePassVIP(self.activityId))
	self.BtnBuyPt:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:isBattlePassVIP(self.activityId) then
			return
		end

		if self.curLevel >= activity_manager:getBPMaxLevel(self.activityId) then
			if not activity_manager:isBattlePassVIP(self.activityId) or not activity_manager:isBattlePassSVIP(self.activityId) then
				LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
					activityId = self.activityId,
					imagePath = self.layerName
				})

				return
			end

			global_ShowBlockWords(L_MAX_LEVLE)

			return
		end

		LayerManager:pushInLayer("PopBattlePassBuyLayer", {
			activityId = self.activityId,
			imagePath = self.layerName
		})
	end)

	local var_24_4 = var_24_0:getChildByName("switch_btn_level")
	local var_24_5 = var_24_0:getChildByName("switch_btn_task")

	var_24_4:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_LEVEL then
			return
		end

		var_24_4:loadTextures(self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", self.layerName .. "/switch_btn_jiangli_on.png", var_0_15)
		var_24_5:loadTextures(self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", self.layerName .. "/switch_btn_task_off.png", var_0_15)

		self.curShowType = self.SHOW_TYPE_LEVEL

		self:updateUIVisible(true)
		activity_manager:getBattlePassLevelData(self.activityId)
	end)
	var_24_5:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curShowType == self.SHOW_TYPE_TASK then
			return
		end

		var_24_4:loadTextures(self.layerName .. "/switch_btn_jiangli_off.png", self.layerName .. "/switch_btn_jiangli_off.png", self.layerName .. "/switch_btn_jiangli_off.png", var_0_15)
		var_24_5:loadTextures(self.layerName .. "/switch_btn_task_on.png", self.layerName .. "/switch_btn_task_on.png", self.layerName .. "/switch_btn_task_on.png", var_0_15)

		self.curShowType = self.SHOW_TYPE_TASK

		self:updateUIVisible(false)
		activity_manager:getActivityTask(self.activityId)
	end)

	if activity_manager:isBattlePassSVIP(self.activityId) then
		self.upup:setVisible(true)
	else
		self.upup:setVisible(true)
	end

	self.lockIcon:setVisible(not activity_manager:isBattlePassVIP(self.activityId))
	self.panelUp:setTouchEnabled(true)
	self.panelUp:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:getBattlePassLive2d(self.activityId) then
			self:showSoulGirlPop()
		end
	end)

	self.btnLevel = self.panelUp:getChildByName("btn_level")

	if self.btnLevel then
		self.btnLevel:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_manager:getItemNumber((activity_manager:getBpLevelInheritItem(self.activityId))) <= 0 then
				global_ShowBlockWords(L_BATTTLEPASS_ITEM_ZERO)

				return
			end

			LayerManager:pushInLayer("PopBattlePassBuyLayer", {
				showType = "inherit",
				activityId = self.activityId,
				imagePath = self.layerName
			})
		end)
	end
end

function ActivityGeneralBPLayer:updateUIVisible(arg_31_1)
	self.rootLayer:getChildByName("Panel_zi"):setVisible(arg_31_1)
	self.rootLayer:getChildByName("big_gift_bg"):setVisible(arg_31_1)
end

function ActivityGeneralBPLayer:updateLevelView(arg_32_1, arg_32_2)
	if not self.curLevel or self.curLevel < 0 then
		return
	end

	if self.taskView then
		self.taskView:setVisible(false)
	end

	self.curExp = activity_manager:getBattlePassExp(self.activityId, self.curLevel)
	self.levelListLen = arg_32_2
	self.levelListData = arg_32_1 or {}

	if self.levelView then
		self.levelView:setVisible(true)
		self:updateShowingCells(self.levelView, self.levelListLen)

		return
	end

	local var_32_0 = self.panelLevel:getPositionY()
	local var_32_1 = self.panelLevel:getContentSize().height + GameDisplay.height - 1136

	print("通过json文件读取当前 奖励tableview 位置在：" .. var_32_0 - GameDisplay.fix_y .. " 高度：" .. var_32_1 .. " 格子宽度：" .. self.LEVEL_CELL_HEIGHT)
	print("奖励数量： " .. self.levelListLen)

	self.levelView = cc.TableView:create(cc.size(640, var_32_1))

	self.levelView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.levelView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.levelView:setAnchorPoint(cc.p(0, 0))
	self.levelView:setPosition(0, var_32_0 - GameDisplay.fix_y)
	self.levelView:setDelegate()
	self.rootLayer:addChild(self.levelView)
	self.levelView:registerScriptHandler(function(arg_34_0, arg_34_1)
		return 640, self.LEVEL_CELL_HEIGHT
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.levelView:registerScriptHandler(function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:dequeueCell()

		if not var_33_0 then
			var_33_0 = cc.TableViewCell:create()

			local var_33_2 = self:createLevelSprite(self.levelListData[arg_33_1 + 1])

			var_33_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_33_2:setPosition(cc.p(320, self.LEVEL_CELL_HEIGHT / 2))
			var_33_0:addChild(var_33_2)
			var_33_0:setLocalZOrder(999 - 10 * arg_33_1)
		else
			self:updateLevelSprite(var_33_0:getChildByTag(100), self.levelListData[arg_33_1 + 1])
			var_33_0:setLocalZOrder(999 - 10 * arg_33_1)
		end

		return var_33_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.levelView:registerScriptHandler(function(arg_35_0, arg_35_1)
		return self.levelListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.levelView:reloadData()
	self.levelView:scrollToIndex(self:getNeedJumpToIndex(), false)
end

function ActivityGeneralBPLayer:createLevelSprite(arg_36_1)
	local var_36_0 = self.levelNode1:clone()

	var_36_0:setName("sprite_bg")
	var_36_0:setTag(100)

	if type(arg_36_1.level) == "string" then
		var_36_0:setVisible(false)
	else
		var_36_0:setVisible(true)
	end

	local var_36_1 = var_36_0:getChildByName("level_bg")
	local var_36_2 = var_36_1:getChildByName("lv_num")
	local var_36_3 = var_36_0:getChildByName("Image_got_mask")

	if not arg_36_1.stat and arg_36_1.level == "?" and var_36_3 then
		var_36_3:setVisible(false)
	elseif var_36_3 then
		if arg_36_1.stat == self.RECEIVE_ALL then
			var_36_3:setVisible(true)
			var_36_3:loadTexture(self.layerName .. "/image_got_mask2.png", var_0_15)

			if type(arg_36_1.level) ~= "string" and arg_36_1.specialDrop then
				if activity_manager:getBattlePassDrop(self.activityId, arg_36_1.specialDrop)[2] then
					var_36_3:getChildByName("Image_hook1"):setVisible(true)
					var_36_3:getChildByName("Image_hook2"):setVisible(true)
					var_36_3:getChildByName("Image_hook3"):setVisible(true)
				else
					var_36_3:getChildByName("Image_hook1"):setVisible(true)
					var_36_3:getChildByName("Image_hook2"):setVisible(true)
					var_36_3:getChildByName("Image_hook3"):setVisible(false)
				end
			end
		elseif arg_36_1.stat >= self.RECEIVE_ORDINARY then
			var_36_3:setVisible(true)
			var_36_3:loadTexture(self.layerName .. "/image_got_mask1.png", var_0_15)
			var_36_3:getChildByName("Image_hook1"):setVisible(true)
			var_36_3:getChildByName("Image_hook2"):setVisible(false)
			var_36_3:getChildByName("Image_hook3"):setVisible(false)
		else
			var_36_3:setVisible(false)
			var_36_3:getChildByName("Image_hook1"):setVisible(false)
			var_36_3:getChildByName("Image_hook2"):setVisible(false)
			var_36_3:getChildByName("Image_hook3"):setVisible(false)
		end
	end

	var_36_2:setString(tostring(arg_36_1.level))

	if arg_36_1.stat ~= self.LEVEL_UNACHIEVE then
		if type(arg_36_1.level) == "number" and arg_36_1.level % 5 == 0 then
			var_36_1:loadTexture(self.layerName .. "/bg_biglv_yidadao.png", var_0_15)
		else
			var_36_1:loadTexture(self.layerName .. "/bg_smalllv_yidadao.png", var_0_15)
		end

		var_36_2:setColor(self.levelNode1:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	else
		if type(arg_36_1.level) == "number" and arg_36_1.level % 5 == 0 then
			var_36_1:loadTexture(self.layerName .. "/bg_biglv_weidadao.png", var_0_15)
		else
			var_36_1:loadTexture(self.layerName .. "/bg_smalllv_weidadao.png", var_0_15)
		end

		var_36_2:setColor(self.levelNode2:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	end

	local var_36_4 = var_36_0:getChildByName("progress_bg")
	local var_36_5 = var_36_4:getChildByName("ProgressBar_lv")

	if type(arg_36_1.level) == "string" or arg_36_1.level == activity_manager:getBattlePassMaxLevel(self.activityId) - 1 then
		var_36_4:setVisible(false)
	elseif arg_36_1.level + 1 < self.curLevel then
		var_36_4:setVisible(true)
		var_36_5:setPercent(100)
	elseif arg_36_1.level + 1 == self.curLevel then
		var_36_4:setVisible(true)
		var_36_5:setPercent((activity_manager:getCurLevelProceed(self.activityId, self.curLevel)))
	else
		var_36_4:setVisible(true)
		var_36_5:setPercent(0)
	end

	if type(arg_36_1.level) ~= "string" and arg_36_1.drop then
		local var_36_6 = activity_manager:getBattlePassDrop(self.activityId, arg_36_1.drop)
		local var_36_7 = var_36_6[1].dropid
		local var_36_8 = var_36_0:getChildByName("item1")
		local var_36_9 = var_36_8:getChildByName("lv_bg")
		local var_36_10 = var_36_8:getChildByName("icon")
		local var_36_11 = var_36_8:getChildByName("Image_gain")
		local var_36_12 = ItemNoBgSprite:create(var_36_6[1].dropid)

		var_36_12:setName("sp_icon")
		var_36_8:addChild(var_36_12, 0)
		var_36_8:loadTextures("public/box/weapon_bg_" .. var_0_16[item_data[var_36_7].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_36_7].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_36_7].equip_quality] .. ".png", var_0_15)
		var_36_9:getChildByName("Label_33"):setString("x" .. var_36_6[1].dropNum)

		if var_36_11 then
			var_36_11:setVisible(arg_36_1.stat >= self.RECEIVE_ORDINARY)
		end

		var_36_9:setVisible(item_data[var_36_7].bag_item_type ~= kITEM_SCULTURE)
		var_36_10:setVisible(false)
		var_36_12:setPosition(var_36_10:getPosition())
		var_36_12:setTouchEnabled(false)
		var_36_8:setTouchEnabled(true)
		var_36_8:setSwallowTouches(false)
		var_36_8:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_37_0:getTouchBeganPosition().y - arg_37_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_36_1.stat == self.LEVEL_UNACHIEVE then
				showItemDetails(var_36_7)

				return
			end

			if arg_36_1.stat == self.RECEIVE_ALL then
				return
			end

			if arg_36_1.stat == self.RECEIVE_ORDINARY and not activity_manager:isBattlePassVIP(self.activityId) then
				return
			end

			activity_manager:getBattlePassReward(self.activityId, arg_36_1.level)
		end)

		if item_data[var_36_7].bag_item_type == kITEM_HORCRUX then
			local var_36_13 = drop_data[arg_36_1.specialDrop] or {}
			local var_36_14 = "drop_extra1"

			if var_36_13.drop_extra1 and string.sub(var_36_13[var_36_14], 1, 5) == "star=" then
				local var_36_15 = tonumber(string.sub(var_36_13[var_36_14], 6, 6))

				if var_36_15 >= 1 and var_36_15 <= 7 then
					local var_36_16 = var_36_12:getChildByName("starLayout")

					if not var_36_16 then
						var_36_16 = self:createStarLayout(var_36_8)

						var_36_16:hide()
					end

					var_36_16:show()
					var_36_16:setStarLevel(var_36_15)
				end
			end
		else
			(var_36_12:getChildByName("starLayout") or self:createStarLayout(var_36_8)):hide()
		end
	end

	if type(arg_36_1.level) ~= "string" and arg_36_1.specialDrop then
		local var_36_17 = activity_manager:getBattlePassDrop(self.activityId, arg_36_1.specialDrop)

		for iter_36_0 = 1, 2 do
			local var_36_18 = var_36_0:getChildByName("item" .. iter_36_0 + 1)

			var_36_18:setVisible(true)

			if var_36_17[iter_36_0] then
				local var_36_19 = var_36_17[iter_36_0].dropid
				local var_36_20 = var_36_18:getChildByName("lv_bg")
				local var_36_21 = var_36_20:getChildByName("Label_33")
				local var_36_22 = var_36_18:getChildByName("icon")
				local var_36_23 = var_36_18:getChildByName("Image_gain")
				local var_36_24 = var_36_18:getChildByName("Image_lock")
				local var_36_25 = ItemNoBgSprite:create(var_36_17[iter_36_0].dropid)

				var_36_25:setName("sp_icon")
				var_36_18:addChild(var_36_25, 0)
				var_36_18:loadTextures("public/box/weapon_bg_" .. var_0_16[item_data[var_36_19].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_36_19].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_36_19].equip_quality] .. ".png", var_0_15)
				var_36_22:setVisible(false)
				var_36_21:setString("x" .. var_36_17[iter_36_0].dropNum)

				if var_36_23 then
					var_36_23:setVisible(arg_36_1.stat == self.RECEIVE_ALL)
				end

				var_36_24:setVisible(not activity_manager:isBattlePassVIP(self.activityId))
				var_36_20:setVisible(item_data[var_36_19].bag_item_type ~= kITEM_SCULTURE)
				var_36_25:setPosition(var_36_22:getPosition())
				var_36_25:setTouchEnabled(false)
				var_36_18:setTouchEnabled(true)
				var_36_18:setSwallowTouches(false)
				var_36_18:addTouchEventListener(function(arg_38_0, arg_38_1)
					if arg_38_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_38_0:getTouchBeganPosition().y - arg_38_0:getTouchEndPosition().y) > 50 then
						return
					end

					if not activity_manager:isBattlePassVIP(self.activityId) then
						LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
							activityId = self.activityId,
							imagePath = self.layerName
						})

						return
					end

					if arg_36_1.stat == self.LEVEL_UNACHIEVE then
						showItemDetails(var_36_19)

						return
					end

					if arg_36_1.stat == self.RECEIVE_ALL then
						return
					end

					if arg_36_1.stat == self.RECEIVE_ORDINARY and not activity_manager:isBattlePassVIP(self.activityId) then
						return
					end

					activity_manager:getBattlePassReward(self.activityId, arg_36_1.level)
				end)
				self:createStarLayout(var_36_18):hide()
			else
				var_36_18:setVisible(false)
			end
		end
	end

	return var_36_0
end

function ActivityGeneralBPLayer:updateLevelSprite(arg_39_1, arg_39_2)
	if type(arg_39_2.level) == "string" then
		arg_39_1:setVisible(false)
	else
		arg_39_1:setVisible(true)
	end

	arg_39_1:setTag(100)

	local var_39_0 = arg_39_1:getChildByName("level_bg")
	local var_39_1 = var_39_0:getChildByName("lv_num")

	var_39_1:setString(tostring(arg_39_2.level))

	local var_39_2 = arg_39_1:getChildByName("Image_got_mask")

	if not arg_39_2.stat and arg_39_2.level == "?" and var_39_2 then
		var_39_2:setVisible(false)
	elseif var_39_2 then
		if arg_39_2.stat == self.RECEIVE_ALL then
			var_39_2:setVisible(true)
			var_39_2:loadTexture(self.layerName .. "/image_got_mask2.png", var_0_15)

			if type(arg_39_2.level) ~= "string" and arg_39_2.specialDrop then
				if activity_manager:getBattlePassDrop(self.activityId, arg_39_2.specialDrop)[2] then
					var_39_2:getChildByName("Image_hook1"):setVisible(true)
					var_39_2:getChildByName("Image_hook2"):setVisible(true)
					var_39_2:getChildByName("Image_hook3"):setVisible(true)
				else
					var_39_2:getChildByName("Image_hook1"):setVisible(true)
					var_39_2:getChildByName("Image_hook2"):setVisible(true)
					var_39_2:getChildByName("Image_hook3"):setVisible(false)
				end
			end
		elseif arg_39_2.stat >= self.RECEIVE_ORDINARY then
			var_39_2:setVisible(true)
			var_39_2:loadTexture(self.layerName .. "/image_got_mask1.png", var_0_15)
			var_39_2:getChildByName("Image_hook1"):setVisible(true)
			var_39_2:getChildByName("Image_hook2"):setVisible(false)
			var_39_2:getChildByName("Image_hook3"):setVisible(false)
		else
			var_39_2:setVisible(false)
			var_39_2:getChildByName("Image_hook1"):setVisible(false)
			var_39_2:getChildByName("Image_hook2"):setVisible(false)
			var_39_2:getChildByName("Image_hook3"):setVisible(false)
		end
	end

	if arg_39_2.stat ~= self.LEVEL_UNACHIEVE then
		if type(arg_39_2.level) == "number" and arg_39_2.level % 5 == 0 then
			var_39_0:loadTexture(self.layerName .. "/bg_biglv_yidadao.png", var_0_15)
		else
			var_39_0:loadTexture(self.layerName .. "/bg_smalllv_yidadao.png", var_0_15)
		end

		var_39_1:setColor(self.levelNode1:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	else
		if type(arg_39_2.level) == "number" and arg_39_2.level % 5 == 0 then
			var_39_0:loadTexture(self.layerName .. "/bg_biglv_weidadao.png", var_0_15)
		else
			var_39_0:loadTexture(self.layerName .. "/bg_smalllv_weidadao.png", var_0_15)
		end

		var_39_1:setColor(self.levelNode2:getChildByName("level_bg"):getChildByName("lv_num"):getColor())
	end

	local var_39_3 = arg_39_1:getChildByName("progress_bg")
	local var_39_4 = var_39_3:getChildByName("ProgressBar_lv")

	if type(arg_39_2.level) == "string" or arg_39_2.level == activity_manager:getBattlePassMaxLevel(self.activityId) - 1 then
		var_39_3:setVisible(false)
	elseif arg_39_2.level + 1 < self.curLevel then
		var_39_3:setVisible(true)
		var_39_4:setPercent(100)
	elseif arg_39_2.level + 1 == self.curLevel then
		var_39_3:setVisible(true)
		var_39_4:setPercent((activity_manager:getCurLevelProceed(self.activityId, self.curLevel)))
	else
		var_39_3:setVisible(true)
		var_39_4:setPercent(0)
	end

	if type(arg_39_2.level) ~= "string" and arg_39_2.drop then
		local var_39_5 = activity_manager:getBattlePassDrop(self.activityId, arg_39_2.drop)
		local var_39_6 = var_39_5[1].dropid
		local var_39_7 = arg_39_1:getChildByName("item1")
		local var_39_8 = var_39_7:getChildByName("lv_bg")
		local var_39_9 = var_39_7:getChildByName("icon")
		local var_39_10 = var_39_7:getChildByName("Image_gain")
		local var_39_11 = var_39_7:getChildByName("sp_icon")

		var_39_8:getChildByName("Label_33"):setString("x" .. var_39_5[1].dropNum)

		if var_39_10 then
			var_39_10:setVisible(arg_39_2.stat >= self.RECEIVE_ORDINARY)
		end

		var_39_8:setVisible(item_data[var_39_6].bag_item_type ~= kITEM_SCULTURE)
		var_39_9:setVisible(false)

		if not var_39_11 then
			var_39_11 = ItemNoBgSprite:create(var_39_6)

			var_39_11:setName("sp_icon")
			var_39_7:addChild(var_39_11, 0)
		end

		var_39_11:updateIcon(var_39_6)
		var_39_11:setPosition(var_39_9:getPosition())
		var_39_11:setTouchEnabled(false)
		var_39_7:loadTextures("public/box/weapon_bg_" .. var_0_16[item_data[var_39_6].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_39_6].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_39_6].equip_quality] .. ".png", var_0_15)
		var_39_7:setTouchEnabled(true)
		var_39_7:setSwallowTouches(false)
		var_39_7:addTouchEventListener(function(arg_40_0, arg_40_1)
			if arg_40_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_40_0:getTouchBeganPosition().y - arg_40_0:getTouchEndPosition().y) > 50 then
				return
			end

			if arg_39_2.stat == self.LEVEL_UNACHIEVE then
				showItemDetails(var_39_6)

				return
			end

			if arg_39_2.stat == self.RECEIVE_ALL then
				return
			end

			if arg_39_2.stat == self.RECEIVE_ORDINARY and not activity_manager:isBattlePassVIP(self.activityId) then
				return
			end

			activity_manager:getBattlePassReward(self.activityId, arg_39_2.level)
		end)

		if item_data[var_39_6].bag_item_type == kITEM_HORCRUX then
			local var_39_12 = drop_data[arg_39_2.specialDrop] or {}
			local var_39_13 = "drop_extra1"

			if var_39_12.drop_extra1 and string.sub(var_39_12[var_39_13], 1, 5) == "star=" then
				local var_39_14 = tonumber(string.sub(var_39_12[var_39_13], 6, 6))

				if var_39_14 >= 1 and var_39_14 <= 7 then
					local var_39_15 = var_39_11:getChildByName("starLayout")

					if not var_39_15 then
						var_39_15 = self:createStarLayout(var_39_7)

						var_39_15:hide()
					end

					var_39_15:show()
					var_39_15:setStarLevel(var_39_14)
				end
			end
		else
			(var_39_11:getChildByName("starLayout") or self:createStarLayout(var_39_7)):hide()
		end
	end

	if type(arg_39_2.level) ~= "string" and arg_39_2.specialDrop then
		local var_39_16 = activity_manager:getBattlePassDrop(self.activityId, arg_39_2.specialDrop)

		for iter_39_0 = 1, 2 do
			local var_39_17 = arg_39_1:getChildByName("item" .. iter_39_0 + 1)

			var_39_17:setVisible(true)

			if var_39_16[iter_39_0] then
				local var_39_18 = var_39_16[iter_39_0].dropid
				local var_39_19 = var_39_17:getChildByName("lv_bg")
				local var_39_20 = var_39_19:getChildByName("Label_33")
				local var_39_21 = var_39_17:getChildByName("icon")
				local var_39_22 = var_39_17:getChildByName("Image_gain")
				local var_39_23 = var_39_17:getChildByName("Image_lock")
				local var_39_24 = var_39_17:getChildByName("sp_icon")

				if not var_39_24 then
					var_39_24 = ItemNoBgSprite:create(var_39_18)

					var_39_24:setName("sp_icon")
					var_39_17:addChild(var_39_24, 0)
				end

				var_39_17:loadTextures("public/box/weapon_bg_" .. var_0_16[item_data[var_39_18].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_39_18].equip_quality] .. ".png", "public/box/weapon_bg_" .. var_0_16[item_data[var_39_18].equip_quality] .. ".png", var_0_15)
				var_39_20:setString("x" .. var_39_16[iter_39_0].dropNum)

				if var_39_22 then
					var_39_22:setVisible(arg_39_2.stat == self.RECEIVE_ALL)
				end

				var_39_23:setVisible(not activity_manager:isBattlePassVIP(self.activityId))
				var_39_19:setVisible(item_data[var_39_18].bag_item_type ~= kITEM_SCULTURE)
				var_39_21:setVisible(false)
				var_39_24:updateIcon(var_39_18)
				var_39_24:setPosition(var_39_21:getPosition())
				var_39_24:setTouchEnabled(false)
				var_39_17:setTouchEnabled(true)
				var_39_17:setSwallowTouches(false)
				var_39_17:addTouchEventListener(function(arg_41_0, arg_41_1)
					if arg_41_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_41_0:getTouchBeganPosition().y - arg_41_0:getTouchEndPosition().y) > 50 then
						return
					end

					if not activity_manager:isBattlePassVIP(self.activityId) then
						LayerManager:pushInLayer(activity_manager:getBuyVipJumpTo(self.activityId), {
							activityId = self.activityId,
							imagePath = self.layerName
						})

						return
					end

					if arg_39_2.stat == self.LEVEL_UNACHIEVE then
						showItemDetails(var_39_18)

						return
					end

					if arg_39_2.stat == self.RECEIVE_ALL then
						return
					end

					if arg_39_2.stat == self.RECEIVE_ORDINARY and not activity_manager:isBattlePassVIP(self.activityId) then
						return
					end

					activity_manager:getBattlePassReward(self.activityId, arg_39_2.level)
				end)

				if item_data[var_39_18].bag_item_type == kITEM_HORCRUX then
					local var_39_25 = drop_data[arg_39_2.specialDrop] or {}
					local var_39_26 = "drop_extra" .. iter_39_0

					if var_39_25["drop_extra" .. iter_39_0] and string.sub(var_39_25[var_39_26], 1, 5) == "star=" then
						local var_39_27 = tonumber(string.sub(var_39_25[var_39_26], 6, 6))

						if var_39_27 >= 1 and var_39_27 <= 7 then
							local var_39_28 = var_39_24:getChildByName("starLayout")

							if not var_39_28 then
								var_39_28 = self:createStarLayout(var_39_17)

								var_39_28:hide()
							end

							var_39_28:show()
							var_39_28:setStarLevel(var_39_27)
						end
					end
				else
					(var_39_24:getChildByName("starLayout") or self:createStarLayout(var_39_17)):hide()
				end
			else
				var_39_17:setVisible(false)
			end
		end
	end
end

function ActivityGeneralBPLayer:getNeedJumpToIndex()
	local var_42_0, var_42_1 = GetTableViewShowCellIdx(self.levelView, {
		maxcount = math.ceil(self.levelListLen),
		cellsize = cc.size(640, self.LEVEL_CELL_HEIGHT)
	})

	return (self.curLevel + (var_42_1 - var_42_0 - 2) > self.levelListLen or nil) and self.levelListLen
end

function ActivityGeneralBPLayer:updateTaskView(arg_43_1, arg_43_2)
	if self.levelView then
		self.levelView:setVisible(false)
	end

	self.taskListData = {}

	for iter_43_0, iter_43_1 in pairs(activity_manager:getActivityTaskData(self.activityId) or {}) do
		if task_data[iter_43_1.taskid] and task_data[iter_43_1.taskid].starttime and time_check_manager:getCurTime() < global_get_time_by_date(task_data[iter_43_1.taskid].starttime) then
			-- block empty
		else
			table.insert(self.taskListData, iter_43_1)
		end
	end

	self.taskListLen = #self.taskListData

	if self.taskView then
		self.taskView:setVisible(true)
		self:updateShowingCells(self.taskView, self.taskListLen)

		return
	end

	local var_43_0 = self.panelTask:getPositionY()
	local var_43_1 = self.panelTask:getContentSize().height + GameDisplay.height - 1136

	print("通过json文件读取当前 任务tableview 位置在：" .. var_43_0 - GameDisplay.fix_y .. " 高度：" .. var_43_1 .. " 格子宽度：" .. self.LEVEL_CELL_HEIGHT)
	print("任务数量： " .. self.taskListLen)

	self.taskView = cc.TableView:create(cc.size(640, var_43_1))

	self.taskView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.taskView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.taskView:setAnchorPoint(cc.p(0, 0))
	self.taskView:setPosition(0, var_43_0 - GameDisplay.fix_y)
	self.taskView:setDelegate()
	self.rootLayer:addChild(self.taskView)
	self.taskView:registerScriptHandler(function(arg_45_0, arg_45_1)
		return 640, self.LEVEL_CELL_HEIGHT
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.taskView:registerScriptHandler(function(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0:dequeueCell()

		if not var_44_0 then
			var_44_0 = cc.TableViewCell:create()

			local var_44_2 = self:createTaskSprite(self.taskListData[arg_44_1 + 1])

			var_44_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_44_2:setPosition(cc.p(320, self.LEVEL_CELL_HEIGHT / 2))
			var_44_0:addChild(var_44_2)
			var_44_0:setLocalZOrder(999 - 10 * arg_44_1)

			if arg_44_1 < 7 then
				var_44_2:setOpacity(0)
				var_44_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_44_1), cc.FadeIn:create(0.1)))
			end
		else
			local var_44_3 = var_44_0:getChildByTag(100)

			self:updateTaskSprite(var_44_3, self.taskListData[arg_44_1 + 1])
			var_44_0:setLocalZOrder(999 - 10 * arg_44_1)

			if self.showEffect and arg_44_1 < 7 then
				var_44_3:setOpacity(0)
				var_44_3:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_44_1), cc.FadeIn:create(0.1)))
			elseif var_44_3:getOpacity() < 255 then
				var_44_3:setOpacity(255)
			end
		end

		return var_44_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.taskView:registerScriptHandler(function(arg_46_0, arg_46_1)
		return self.taskListLen
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.showEffect = false
	end)))
	self.taskView:reloadData()
end

function ActivityGeneralBPLayer:createTaskSprite(arg_48_1)
	local var_48_0 = self.taskNode1:clone()

	var_48_0:setName("sprite_bg")
	var_48_0:setTag(100)
	var_48_0:setVisible(true)
	var_48_0:getChildByName("task_img"):loadTexture(self.layerName .. "/icon_bpdianshu.png", var_0_15)
	var_48_0:getChildByName("pt_num"):setString("X" .. activity_manager:getBattlePassDrop(self.activityId, arg_48_1.drop)[1].dropNum)
	var_48_0:getChildByName("name_lbl"):setString(arg_48_1.name)

	local var_48_1 = var_48_0:getChildByName("get_reward_btn")

	if arg_48_1.status >= 1 then
		var_48_1:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_15)
	elseif arg_48_1.percent >= 100 then
		var_48_1:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_15)
	else
		var_48_1:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_15)
	end

	var_48_1:addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_48_1.status >= 1 then
			return
		end

		if arg_48_1.percent >= 100 then
			activity_manager:getBPTaskReward(self.activityId, arg_48_1.taskid)
		else
			self:taskTumpTo(arg_48_1.jump)
		end
	end)

	local var_48_2 = var_48_0:getChildByName("progress_bg")
	local var_48_3 = var_48_2:getChildByName("ProgressBar_43")
	local var_48_4 = var_48_2:getChildByName("percent_lbl")

	var_48_3:setPercent(arg_48_1.status == 1 and 100 or arg_48_1.percent >= 0 and arg_48_1.percent or 100)

	if arg_48_1.finished and arg_48_1.need ~= 0 then
		if arg_48_1.finished < arg_48_1.need then
			var_48_4:setString(arg_48_1.finished .. "/" .. arg_48_1.need)
		else
			var_48_4:setString(arg_48_1.need .. "/" .. arg_48_1.need)
		end
	elseif arg_48_1.status == 1 then
		var_48_4:setString("100%")
	else
		var_48_4:setString(arg_48_1.percent .. "%")
	end

	return var_48_0
end

function ActivityGeneralBPLayer:updateTaskSprite(arg_50_1, arg_50_2)
	arg_50_1:getChildByName("pt_num"):setString("X" .. activity_manager:getBattlePassDrop(self.activityId, arg_50_2.drop)[1].dropNum)
	arg_50_1:getChildByName("name_lbl"):setString(arg_50_2.name)

	local var_50_0 = arg_50_1:getChildByName("get_reward_btn")

	if arg_50_2.status >= 1 then
		var_50_0:loadTextures(self.btn_stat_img[self.IS_GETTED], nil, self.btn_stat_img[self.IS_GETTED], var_0_15)
	elseif arg_50_2.percent >= 100 then
		var_50_0:loadTextures(self.btn_stat_img[self.CAN_GET], nil, self.btn_stat_img[self.CAN_GET], var_0_15)
	else
		var_50_0:loadTextures(self.btn_stat_img[self.UN_ACHIEVE], nil, self.btn_stat_img[self.UN_ACHIEVE], var_0_15)
	end

	var_50_0:addTouchEventListener(function(arg_51_0, arg_51_1)
		if arg_51_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_50_2.status >= 1 then
			return
		end

		if arg_50_2.percent >= 100 then
			activity_manager:getBPTaskReward(self.activityId, arg_50_2.taskid)
		else
			self:taskTumpTo(arg_50_2.jump)
		end
	end)
	arg_50_1:getChildByName("progress_bg"):getChildByName("ProgressBar_43"):setPercent(arg_50_2.status == 1 and 100 or arg_50_2.percent >= 0 and arg_50_2.percent or 100)

	local var_50_2 = arg_50_1:getChildByName("progress_bg"):getChildByName("percent_lbl")

	if arg_50_2.finished and arg_50_2.need ~= 0 then
		if arg_50_2.finished < arg_50_2.need then
			var_50_2:setString(arg_50_2.finished .. "/" .. arg_50_2.need)
		else
			var_50_2:setString(arg_50_2.need .. "/" .. arg_50_2.need)
		end
	elseif arg_50_2.status == 1 then
		var_50_2:setString("100%")
	else
		var_50_2:setString(arg_50_2.percent .. "%")
	end
end

function ActivityGeneralBPLayer:updateShowBigGift()
	self.bigGiftPanel:setTouchEnabled(true)

	if self.curLevel >= #self.levelListData then
		self.bigGiftPanel:setVisible(false)

		return
	end

	for iter_52_0 = 1, 3 do
		self.bigGiftPanel:getChildByName("Image_item" .. iter_52_0):setVisible(false)
	end

	local var_52_0 = activity_manager:getBattlePassMaxLevel(self.activityId)
	local var_52_1 = math.floor((self.curLevel - 1) / 10) * 10 + 10

	if var_52_0 < var_52_1 then
		var_52_1 = var_52_0
	end

	local var_52_2 = self.bigGiftPanel:getChildByName("lblLevel")

	if var_52_2 then
		var_52_2:setString(var_52_1)
	end

	local var_52_3 = self.levelListData[var_52_1]
	local var_52_4 = self.bigGiftPanel:getChildByName("drop_node")

	if var_52_4 then
		var_52_4:removeFromParent()
	end

	if type(var_52_3.level) ~= "string" and var_52_3.drop then
		local var_52_5 = ccui.Layout:create()

		var_52_5:setPosition(cc.p(0, 0))
		var_52_5:setAnchorPoint(cc.p(0, 0))
		var_52_5:setName("drop_node")
		self.bigGiftPanel:addChild(var_52_5)

		for iter_52_1, iter_52_2 in pairs((activity_manager:getBattlePassDrop(self.activityId, var_52_3.drop))) do
			local var_52_6 = ItemPurchaseSprite:createPurchaseItem(iter_52_2.dropid, iter_52_2.dropNum)

			var_52_6:setScale(0.6)
			var_52_6:setTouchEnabled(true)
			var_52_6:setSwallowTouches(false)
			var_52_6:setPositionX(self.bigGiftPanel:getChildByName("Image_item1"):getPositionX())
			var_52_6:setPositionY(self.bigGiftPanel:getChildByName("Image_item1"):getPositionY())
			var_52_6:addTouchEventListener(function(arg_53_0, arg_53_1)
				if arg_53_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_52_2.dropid)
			end)
			var_52_5:addChild(var_52_6)
		end
	end

	local var_52_8 = self.bigGiftPanel:getChildByName("special_drop_node")

	if var_52_8 then
		var_52_8:removeFromParent()
	end

	if type(var_52_3.level) ~= "string" and var_52_3.specialDrop then
		local var_52_9 = ccui.Layout:create()

		var_52_9:setPosition(cc.p(0, 0))
		var_52_9:setAnchorPoint(cc.p(0, 0))
		var_52_9:setName("special_drop_node")
		self.bigGiftPanel:addChild(var_52_9)

		for iter_52_3, iter_52_4 in pairs((activity_manager:getBattlePassDrop(self.activityId, var_52_3.specialDrop))) do
			local var_52_10 = ItemPurchaseSprite:createPurchaseItem(iter_52_4.dropid, iter_52_4.dropNum)

			var_52_10:setScale(0.6)
			var_52_10:setTouchEnabled(true)
			var_52_10:setSwallowTouches(false)
			var_52_10:setPositionX(self.bigGiftPanel:getChildByName("Image_item" .. iter_52_3 + 1):getPositionX())
			var_52_10:setPositionY(self.bigGiftPanel:getChildByName("Image_item" .. iter_52_3 + 1):getPositionY())
			var_52_9:addChild(var_52_10)
			var_52_10:addTouchEventListener(function(arg_54_0, arg_54_1)
				if arg_54_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_52_4.dropid)
			end)
		end
	end
end

function ActivityGeneralBPLayer.taskTumpTo(arg_55_0, arg_55_1)
	if arg_55_1 == 130 then
		LayerManager:pushInLayer("SignLayerNew", {
			callback = function()
				activity_manager:getActivityTask(arg_55_0.activityId)
			end
		})
	elseif arg_55_1 == 111 then
		require("controller.sign_manager"):createMidasLayer(function()
			activity_manager:getActivityTask(arg_55_0.activityId)
		end)
	elseif arg_55_1 == 220 then
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
				activity_manager:getActivityTask(arg_55_0.activityId)
			end
		})
	elseif arg_55_1 == 300 then
		LayerManager:pushInLayer("EquipLayer", {
			exitCallback = function()
				activity_manager:getActivityTask(arg_55_0.activityId)
			end
		})
	elseif arg_55_1 then
		require("controller.goto_system_manager")

		local var_55_0 = {
			jump_to_system = arg_55_1
		}

		var_55_0.config = system_jump_config[SYSTEMID[arg_55_1]] and system_jump_config[SYSTEMID[arg_55_1]].config

		if var_55_0.config then
			if var_55_0.config.exitCallbackType == "function" then
				var_55_0.config.exitCallback = nil
			elseif var_55_0.config.exitCallbackType == "string" then
				var_55_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_55_0)
	end
end

function ActivityGeneralBPLayer:updateShowingCells(arg_62_1, arg_62_2)
	local var_62_0, var_62_1 = GetTableViewShowCellIdx(arg_62_1, {
		maxcount = math.ceil(arg_62_2),
		cellsize = cc.size(640, self.LEVEL_CELL_HEIGHT)
	})

	for iter_62_0 = var_62_0, var_62_1 do
		arg_62_1:updateCellAtIndex(iter_62_0)
	end
end

function ActivityGeneralBPLayer:fullScreen()
	local var_63_0 = self.rootLayer:getChildByName("panel_up")

	var_63_0:setAnchorPoint(cc.p(0.5, 1))
	var_63_0:setPositionY(GameDisplay.getUiScreenSize().height - GameDisplay.fix_y)

	local var_63_1 = self.rootLayer:getChildByName("Panel_zi")

	var_63_1:setPositionY(GameDisplay.getUiScreenSize().height - 402 - GameDisplay.fix_y)

	local var_63_2 = self.rootLayer:getChildByName("Image_bottom")

	var_63_2:setPositionY(var_63_2:getPositionY() - GameDisplay.fix_y)

	local var_63_3 = self.rootLayer:getChildByName("big_gift_bg")

	var_63_3:setPositionY(var_63_3:getPositionY() - GameDisplay.fix_y)
	var_63_0:setLocalZOrder(51)
	var_63_1:setLocalZOrder(51)
	var_63_3:setLocalZOrder(50)
	var_63_2:setLocalZOrder(51)

	if self.btn_sign then
		self.btn_sign:setPositionY(self.btn_sign:getPositionY() + GameDisplay.fix_y)
	end
end

function ActivityGeneralBPLayer:updateAlert()
	local var_64_0 = self.rootLayer:getChildByName("panel_up")
	local var_64_1 = var_64_0:getChildByName("switch_btn_level")
	local var_64_2 = var_64_0:getChildByName("switch_btn_task")
	local var_64_3 = {
		x = 335,
		y = 70
	}

	if activity_manager:getAlertStatus(self.activityId, "bp_proceed") then
		global_add_alert_tag(var_64_1, var_64_3)
	else
		global_remove_alert_tag(var_64_1)
	end

	if activity_manager:getAlertStatus(self.activityId, (activity_manager:getActivityBPTaskUseModule(self.activityId))) then
		global_add_alert_tag(var_64_2, var_64_3)
	else
		global_remove_alert_tag(var_64_2)
	end
end

local var_0_18 = {}

function ActivityGeneralBPLayer:showSoulGirlPop(arg_65_1, arg_65_2)
	arg_65_1 = arg_65_1 or {}

	local var_65_0 = activity_manager:getBattlePassLive2d(self.activityId) or "15330"

	LayerManager:switchShowLayer("SkinShowPopLayer", {
		modelId = var_65_0
	})

	do return end

	local var_65_1 = ccs.GUIReader:getInstance()
	local var_65_2 = var_65_1:widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_65_3 = ccui.Helper:seekWidgetByName(var_65_2, "Panel_26")

	var_65_3.setLocalZOrder(var_65_1, 1)
	self:addChild(var_65_2)

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_65_2, "Image_back")

	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_65_4 = ccui.Helper:seekWidgetByName(var_65_2, "Button_return")

	if model_data[var_65_0].background and model_data[var_65_0].background == "dark" then
		var_65_4:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_15)
	else
		var_65_4:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_15)
	end

	var_65_4:setLocalZOrder(2)

	local function var_65_5(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showgirlLayer:resetCurTalkConfig()
		var_65_2:runAction(cc.RemoveSelf:create())

		var_65_2 = nil
	end

	var_65_4:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_65_4:setTouchEnabled(true)
		var_65_4:addTouchEventListener(var_65_5)
	end)))

	local var_65_6 = ccui.Helper:seekWidgetByName(var_65_2, "Panel_cute_role")
	local var_65_7 = ccui.Helper:seekWidgetByName(var_65_2, "Image_cute_role")

	var_65_7:loadTexture("roleimage/role1/" .. model_data[var_65_0].cute_role .. ".png")
	var_65_7:setPosition(cc.p(var_65_6:getContentSize().width / 2, var_65_6:getContentSize().height / 2 + 30))
	var_65_7:setScale(0.4)
	var_65_7:setVisible(false)

	local var_65_8 = ccui.Helper:seekWidgetByName(var_65_2, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_65_9 = ccui.Helper:seekWidgetByName(var_65_2, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_65_2, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_65_2, "Panel_up"):setLocalZOrder(3)

	L2ActorSprite = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_65_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_65_0].spine_model .. ".atlas", (model_data[var_65_0].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_65_0].clothes_model .. ".atlas" or nil))

	L2ActorSprite:setScale(model_data[var_65_0].modelscale / 1.3 * 0.4, model_data[var_65_0].modelscale / 1.3 * 0.4)
	L2ActorSprite:setContentSize(cc.size(100, 200))
	L2ActorSprite:setPosition(cc.p(var_65_6:getContentSize().width / 2, var_65_6:getContentSize().height / 2 - 60))
	var_65_6:addChild(L2ActorSprite, 99)
	L2ActorSprite:playAni(nil, "idle", true)
	var_65_6:addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_68_0 = math.random(2, 5)

		local function var_68_1()
			L2ActorSprite:playAni(nil, "idle", true)
		end

		if var_68_0 == 2 then
			L2ActorSprite:playAni(var_68_1, "run", false)
		elseif var_68_0 == 3 then
			L2ActorSprite:playAni(var_68_1, "yule", false)
		elseif var_68_0 == 4 then
			L2ActorSprite:playAni(var_68_1, "chihe", false)
		else
			L2ActorSprite:playAni(var_68_1, "fadai", false)
		end
	end)

	local var_65_10 = ccui.Helper:seekWidgetByName(var_65_2, "Label_name")
	local var_65_11 = ccui.Helper:seekWidgetByName(var_65_2, "Image_cv")

	var_65_11:loadTexture("public/panelbg/cv_bg.png", var_0_15)

	if favorfile_data[3][model_data[var_65_0].photofile_model] then
		var_65_11:setVisible(favorfile_data[3][model_data[var_65_0].photofile_model] ~= L_CV_UNSURE)

		local var_65_12 = cc.Label:createWithTTF("声优/" .. favorfile_data[3][model_data[var_65_0].photofile_model], FONT_DES, 28)

		var_65_12:setPosition(cc.p(var_65_11:getContentSize().width / 2, var_65_11:getContentSize().height / 2 - 3))
		var_65_11:addChild(var_65_12)
	else
		var_65_11:setVisible(false)
	end

	var_65_10:setFontSize(global_change_fontsize_by_length(model_data[var_65_0].name, 40, 4, 6))
	var_65_10:setString(model_data[var_65_0].name)
	var_65_10:setLocalZOrder(9999)

	local var_65_13 = ccui.Helper:seekWidgetByName(var_65_2, "Label_name_bottom")
	local var_65_14 = ccui.Helper:seekWidgetByName(var_65_2, "Label_name_top")

	var_65_13:setString(model_data[var_65_0].main_name)
	var_65_14:setString(model_data[var_65_0].main_name)

	if model_data[var_65_0].background and model_data[var_65_0].background == "bright" then
		var_65_13:setColor(cc.c3b(40, 125, 205))
		var_65_14:setColor(cc.c3b(0, 255, 246))
	end

	local var_65_15 = ccui.Helper:seekWidgetByName(var_65_2, "Image_type")
	local var_65_16

	if model_data[var_65_0].live2d then
		var_65_16 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_65_0].rolespine then
		var_65_16 = "MarketLayer/skin_type_spine.png"
	else
		var_65_15:setVisible(false)
	end

	var_65_15:loadTextures(var_65_16, nil, var_65_16, var_0_15)

	local var_65_17 = ccui.Helper:seekWidgetByName(var_65_2, "Image_cost_bottom")

	var_65_17:loadTexture("MarketLayer/cost_bottom_bright.png", var_0_15)
	var_65_17:setVisible(false)

	local var_65_18 = ccui.Helper:seekWidgetByName(var_65_2, "Image_name")

	var_65_18:loadTexture("MarketLayer/skin_name_bottom_bright.png", var_0_15)
	var_65_18:setPositionY(var_65_18:getPositionY() + GameDisplay.height - 300)

	local var_65_19 = ccui.Helper:seekWidgetByName(var_65_2, "Button_buy")

	var_65_19:loadTextures("MarketLayer/buy_btn_bright.png", nil, "MarketLayer/buy_btn_bright.png", var_0_15)

	local var_65_20 = TempWidget:CreateTempImg("MarketLayer/apply_btn.png", var_65_19:getParent())

	var_65_20:align(cc.p(var_65_19:getAnchorPoint()), var_65_19:getPositionX(), var_65_19:getPositionY() + 120)
	var_65_20:setName("applyBtn")
	var_65_20:_addEvent(function()
		if self._isShowFightModel then
			test_fight_manager:changePlayerArrayByIndes(1, major_factor_data[model_data[var_65_0].major].servant, servant_data[major_factor_data[model_data[var_65_0].major].servant].modelid)
		else
			test_fight_manager:changePlayerArrayByIndes(1, major_factor_data[model_data[var_65_0].major].servant, var_65_0)
		end
	end)

	local var_65_21 = TempWidget:CreateTempBtn("MarketLayer/fight_stand_get_btn.png", var_65_19:getParent())

	var_65_21:align(cc.p(var_65_19:getAnchorPoint()), var_65_19:getPositionX(), var_65_19:getPositionY())
	var_65_21:setName("fightStandGetBtn")
	var_65_21:_addEvent(function()
		for iter_71_0, iter_71_1 in ipairs((Utility:parseDataByElement(item_data[servant_data[major_factor_data[model_data[var_65_0].major].servant].itemid], {
			{
				index = "targetlayer",
				name = "roleJump"
			},
			{
				index = "targetlayer_starttime",
				name = "startTime",
				hyphen = "_"
			},
			{
				index = "targetlayer_finishtime",
				name = "endTime",
				hyphen = "_"
			}
		}))) do
			if tonumber(iter_71_1.roleJump) and Utility:isTimeRangeValid(iter_71_1.startTime, iter_71_1.endTime) or tonumber(iter_71_1.roleJump) and not iter_71_1.startTime and not iter_71_1.endTime then
				Utility:executeLayerJump({
					systemid = tonumber(iter_71_1.roleJump)
				})

				return
			end
		end

		global_ShowBlockWords("暂时没有获取该角色的途径")
	end)

	local var_65_22 = ccui.Layout:create()

	var_65_22:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_65_22:setAnchorPoint(cc.p(0.5, 0.5))
	var_65_22:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_65_22:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_65_22:setBackGroundColor(cc.c3b(0, 0, 0))
	var_65_22:setBackGroundColorOpacity(0)
	var_65_3:addChild(var_65_22, 2)

	local function var_65_24(arg_72_0, arg_72_1)
		if arg_65_1.have_bought_num == 1 then
			return true
		end

		if var_0_18[playermodel.playerid][var_65_0] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 and arg_65_1.have_bought_num ~= 1 then
			return true
		elseif var_0_18[playermodel.playerid][var_65_0] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_18[playermodel.playerid][var_65_0] = var_0_18[playermodel.playerid][var_65_0] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end

	local function var_65_25(arg_73_0, arg_73_1)
		return false
	end

	local var_65_26 = cc.EventListenerTouchOneByOne:create()

	var_65_26:setSwallowTouches(false)
	var_65_26:registerScriptHandler(var_65_24, cc.Handler.EVENT_TOUCH_BEGAN)
	var_65_26:registerScriptHandler(var_65_25, cc.Handler.EVENT_TOUCH_ENDED)
	var_65_22:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_65_26, var_65_22)
	var_65_19:setVisible(false)

	if arg_65_1.have_bought_num == 1 then
		var_65_19:setVisible(false)
		var_65_17:setVisible(false)
	end

	local var_65_27 = ccui.Helper:seekWidgetByName(var_65_2, "Image_costType_new")
	local var_65_28 = ccui.Helper:seekWidgetByName(var_65_2, "Label_cost_num_new")

	self.showSoulGirlScenePanel:setVisible(true)
	var_65_27:setVisible(false)
	var_65_28:setVisible(false)
	ccui.Helper:seekWidgetByName(var_65_2, "Panel_old_cost"):setVisible(false)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_65_0, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_18[playermodel.playerid] then
		var_0_18[playermodel.playerid] = {}
		var_0_18[playermodel.playerid][var_65_0] = var_0_18[playermodel.playerid][var_65_0] or 0
	else
		var_0_18[playermodel.playerid][var_65_0] = var_0_18[playermodel.playerid][var_65_0] or 0
	end

	self.showgirlLayer:setTalkEnabled(var_0_18[playermodel.playerid][var_65_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_18[playermodel.playerid][var_65_0] = var_0_18[playermodel.playerid][var_65_0] + 1

		self.showgirlLayer:setTalkEnabled(var_0_18[playermodel.playerid][var_65_0] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_65_3:addChild(self.showgirlLayer, 1)

	if model_data[var_65_0].backgroundid then
		var_65_3:addChild(BackGroundLayer:create(model_data[var_65_0].backgroundid, (model_data[var_65_0].is_own_full_screen_background == 1 or nil) and 2), 0)
	end

	self:initBattleStandLayout(var_65_2, var_65_0)
end

function ActivityGeneralBPLayer:initBattleStandLayout(arg_75_1, arg_75_2)
	self._isShowFightModel = false

	local var_75_0 = TempWidget:CreateTempLayout(arg_75_1)

	var_75_0:setLocalZOrder(5)
	var_75_0:setContentSize(cc.size(250, 300))
	var_75_0:align(cc.p(1, 0), arg_75_1:getContentSize().width / 2 + 70, -GameDisplay.fix_y)

	var_75_0._curPos = cc.p(var_75_0:size().w, var_75_0:size().h / 2)
	var_75_0._nextPos = cc.p(var_75_0:size().w - 150, var_75_0:size().h / 2)
	var_75_0._isAction = false
	self._battleStandLayout = var_75_0

	local var_75_1
	local var_75_2
	local var_75_3 = 0.8
	local var_75_4 = 0.3
	local var_75_5 = {
		var_75_0._curPos,
		cc.p(var_75_0._curPos.x - 150 / 2, var_75_0._curPos.y + 80),
		var_75_0._nextPos
	}
	local var_75_6 = {
		var_75_0._nextPos,
		cc.p(var_75_0._nextPos.x + 150 / 2, var_75_0._nextPos.y - 80),
		var_75_0._curPos
	}

	local function var_75_7()
		var_75_0._isAction = true
		self._isShowFightModel = not self._isShowFightModel

		if self.showgirlLayer then
			if self.showgirlLayer:getChildByName("roleimage") then
				self.showgirlLayer:getChildByName("roleimage")._talksp = nil
			end

			if self._isShowFightModel then
				self.showgirlLayer:update(tostring(servant_data[major_factor_data[model_data[arg_75_2].major].servant].modelid))
			else
				self.showgirlLayer:update(tostring(arg_75_2))
			end

			if self.showgirlLayer:getChildByName("roleimage") then
				self.showgirlLayer:getChildByName("roleimage")._talksp = nil
			end
		end

		local var_76_0 = ccui.Helper:seekWidgetByName(arg_75_1, "Label_name_bottom")
		local var_76_1 = ccui.Helper:seekWidgetByName(arg_75_1, "Label_name_top")
		local var_76_2 = ccui.Helper:seekWidgetByName(arg_75_1, "Button_buy")
		local var_76_3 = ccui.Helper:seekWidgetByName(arg_75_1, "Image_cost_bottom")

		if self._isShowFightModel then
			var_76_2:setVisible(false)
			var_76_3:setVisible(false)

			local var_76_4 = global_get_servant_skin(major_factor_data[model_data[arg_75_2].major].servant)

			var_76_0:setString(model_data[var_76_4].main_name)
			var_76_1:setString(model_data[var_76_4].main_name)
		else
			var_76_2:setVisible(true)
			var_76_3:setVisible(true)
			var_76_0:setString(model_data[arg_75_2].main_name)
			var_76_1:setString(model_data[arg_75_2].main_name)
		end

		local var_76_5 = false
		local var_76_6 = false
		local var_76_7
		local var_76_8
		local var_76_9
		local var_76_10

		if var_75_1._state == 0 then
			var_76_7 = var_75_1
			var_76_8 = var_75_2
			var_76_9 = var_75_0._topBg1
			var_76_10 = var_75_0._topBg2
		else
			var_76_7 = var_75_2
			var_76_8 = var_75_1
			var_76_9 = var_75_0._topBg2
			var_76_10 = var_75_0._topBg1
		end

		var_76_8:setLocalZOrder(var_76_7:getLocalZOrder() + 1)
		var_76_7:stopAllActions()
		var_76_7:runAction(cc.Sequence:create(cc.Spawn:create(cc.BezierTo:create(var_75_4, var_75_5), cc.ScaleTo:create(var_75_4, var_75_3)), cc.CallFunc:create(function()
			var_76_5 = true
			var_76_7._state = 1

			var_76_9:loadTextureEx("MarketLayer/stand_next_bg.png")

			if var_76_5 and var_76_6 then
				var_75_0._isAction = false
			end
		end)))
		var_76_8:stopAllActions()
		var_76_8:runAction(cc.Sequence:create(cc.Spawn:create(cc.BezierTo:create(var_75_4, var_75_6), cc.ScaleTo:create(var_75_4, 1)), cc.CallFunc:create(function()
			var_76_6 = true
			var_76_8._state = 0

			var_76_10:loadTextureEx("MarketLayer/stand_cur_bg.png")

			if var_76_5 and var_76_6 then
				var_75_0._isAction = false
			end
		end)))
	end

	var_75_1 = TempWidget:CreateTempImg("MarketLayer/stand_bg.png", var_75_0)
	var_75_1._state = 0

	var_75_1:align(cc.p(1, 0.5), var_75_0._curPos)
	var_75_1:_addEvent(function()
		if not var_75_0._isAction then
			var_75_7()
		end
	end)

	var_75_0._standImg1 = var_75_1

	local var_75_8 = TempWidget:CreateTempImg("", var_75_1)

	var_75_8:center()

	var_75_0._roleImage1 = var_75_8

	local var_75_9 = TempWidget:CreateTempImg("MarketLayer/stand_cur_bg.png", var_75_1)

	;(nil):setLocalZOrder(5)
	;(nil):center()

	var_75_0._topBg1 = nil

	local var_75_10 = TempWidget:CreateTempLabel("", FONT_NAME, 19, var_75_1)

	var_75_10:align(cc.p(0.5, 0), var_75_1:size().w / 2, 15)
	var_75_10:setLocalZOrder((nil):getLocalZOrder() + 1)

	var_75_0._name1 = var_75_10
	var_75_2 = TempWidget:CreateTempImg("MarketLayer/stand_bg.png", var_75_0)
	var_75_2._state = 1

	var_75_2:setScale(0.8)
	var_75_2:align(cc.p(1, 0.5), var_75_0._nextPos)
	var_75_2:_addEvent(function()
		if not var_75_0._isAction then
			var_75_7()
		end
	end)

	var_75_0._standImg2 = var_75_2

	local var_75_11 = TempWidget:CreateTempImg("", var_75_2)

	var_75_11:center()

	var_75_0._roleImage2 = var_75_11

	local var_75_12 = TempWidget:CreateTempImg("MarketLayer/stand_next_bg.png", var_75_2)

	;(nil):setLocalZOrder(5)
	;(nil):center()

	var_75_0._topBg2 = nil

	local var_75_13 = TempWidget:CreateTempLabel("", FONT_NAME, 19, var_75_2)

	var_75_13:align(cc.p(0.5, 0), var_75_1:size().w / 2, 15)
	var_75_13:setLocalZOrder((nil):getLocalZOrder() + 1)

	var_75_0._name2 = var_75_13

	self:updateBattleStandLayout(arg_75_2)
end

function ActivityGeneralBPLayer:updateBattleStandLayout(arg_81_1)
	self._battleStandLayout._roleImage1:loadTextureEx("roleimage/role/shop_image/" .. model_data[tostring(arg_81_1)].role_image .. ".png")
	self._battleStandLayout._roleImage1:setScaleX((self._battleStandLayout._standImg1:size().w - 13) / self._battleStandLayout._roleImage1:size().w)
	self._battleStandLayout._roleImage1:setScaleY((self._battleStandLayout._standImg1:size().h - 13) / self._battleStandLayout._roleImage1:size().h)
	self._battleStandLayout._name1:setString(model_data[arg_81_1].main_name)
	self._battleStandLayout._roleImage2:loadTextureEx("roleimage/role/shop_image/" .. model_data[tostring(servant_data[major_factor_data[model_data[arg_81_1].major].servant].modelid)].role_image .. ".png")
	self._battleStandLayout._roleImage2:setScaleX((self._battleStandLayout._standImg2:size().w - 13) / self._battleStandLayout._roleImage2:size().w)
	self._battleStandLayout._roleImage2:setScaleY((self._battleStandLayout._standImg2:size().h - 13) / self._battleStandLayout._roleImage2:size().h)
	self._battleStandLayout._name2:setString(model_data[servant_data[major_factor_data[model_data[arg_81_1].major].servant].modelid].main_name)
end

function ActivityGeneralBPLayer.createStarLayout(arg_82_0, arg_82_1)
	local var_82_0 = TempWidget:CreateTempLayout()

	var_82_0:setContentSize(cc.size(40, 30 * 5))
	var_82_0:setName("satrLayout")

	for iter_82_0 = 1, 5 do
		local var_82_1 = TempWidget:CreateTempImg("public/currency/weapon_star.png", var_82_0)

		var_82_1:align(cc.p(0.5, 1), var_82_0:size().w / 2, var_82_0:size().h - (iter_82_0 - 1) * 30)
		var_82_1:setName("star" .. iter_82_0)
	end

	function var_82_0:setStarLevel(arg_83_1)
		for iter_83_0 = 1, 5 do
			local var_83_0 = self:getChildByName("star" .. iter_83_0)

			var_83_0:setVisible(iter_83_0 <= arg_83_1)

			if iter_83_0 == 1 or iter_83_0 == 2 then
				if arg_83_1 - iter_83_0 >= 5 then
					var_83_0:loadTextureEx("public/currency/pink_star.png")
				else
					var_83_0:loadTextureEx("public/currency/weapon_star.png")
				end
			end
		end
	end

	if arg_82_1 then
		arg_82_1:addChild(var_82_0)
		var_82_0:align(cc.p(1, 0.5), arg_82_1:getContentSize().width + 20, arg_82_1:getContentSize().height / 2)
	end

	return var_82_0
end
