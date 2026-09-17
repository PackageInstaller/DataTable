ActivityDailyLevelLayer = class("ActivityDailyLevelLayer", function()
	return cc.Layer:create()
end)

local var_0_4 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local levelmode_data = require("data.levelmode_data")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local item_manager = require("controller.item_manager")

function ActivityDailyLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityDailyLevelLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityDailyLevelLayer:init(arg_3_1)
	if arg_3_1 then
		self.activityId = arg_3_1.activityid or -1
	end

	TextureManager:loadLayerTextures({
		"ActivityLevel_" .. self.activityId
	})

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/dailyLevel.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and ("ActivityLevel_" .. self.activityId .. ".json" or "ActivityLevel_" .. self.activityId .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_level_info(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityDailyLevelLayer")
		end
	end)
end

function ActivityDailyLevelLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityDailyLevelLayer", activity_manager.activityEventId.ACTIVITY_LEVEL_INFO_UPDATE, function(arg_6_0)
		arg_5_0:upDateUI(arg_6_0)
	end)
end

function ActivityDailyLevelLayer:initUI()
	self:initBtnReturn()
	self:initTitle()
	self:initPanelBook()
	self:initPanelBuff()
end

function ActivityDailyLevelLayer:initBtnReturn()
	self.returnPanel = self.rootLayer:getChildByName("return_bg")
	self.btnReturn = self.returnPanel:getChildByName("btn_return")

	self.btnReturn:setAnchorPoint(cc.p(0.5, 0))
	self.btnReturn:setPositionY(-GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.returnPanel:setPositionY(self.returnPanel:getPositionY() - GameDisplay.fix_y)
	self.btnReturn:setPositionY(0)

	self.lblFightNum = self.returnPanel:getChildByName("lbl_num")

	local var_8_0 = ccui.ImageView:create("public/button/add8_new.png", var_0_4)

	var_8_0:setPosition(cc.p(610, 40))

	if self.activityId == 230 then
		var_8_0:setPosition(cc.p(620, 32))
	end

	var_8_0:setScale(0.65)
	self.returnPanel:addChild(var_8_0)
	var_8_0:setTouchEnabled(true)
	var_8_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showBuyTimePop()
	end)
end

function ActivityDailyLevelLayer:initTitle()
	self.btnDetail = self.rootLayer:getChildByName("title")

	self.btnDetail:setTouchEnabled(true)
	self.btnDetail:setPositionY(self.btnDetail:getPositionY() + GameDisplay.fix_y)
	self.btnDetail:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityLevel_" .. self.activityId
		})
	end)
end

function ActivityDailyLevelLayer:initPanelBook()
	local var_13_0 = self.rootLayer:getChildByName("panel_book")

	self.lblCurnum = var_13_0:getChildByName("lbl_num")

	var_13_0:setTouchEnabled(true)
	var_13_0:setPositionY(var_13_0:getPositionY() - GameDisplay.fix_y)
	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityMultiPtLayer", {
			activityId = self.activityId
		})
	end)
end

function ActivityDailyLevelLayer:initPanelBuff()
	local var_15_0 = self.rootLayer:getChildByName("buff")

	var_15_0:setPositionY(var_15_0:getPositionY() + GameDisplay.fix_y)

	self.buff1 = var_15_0:getChildByName("buff_1")
	self.buff2 = var_15_0:getChildByName("buff_2")

	self.buff1:setString(L_ACTIVITY_LEVEL_BUFF)
	self.buff2:setString("")
	var_15_0:setTouchEnabled(true)
end

function ActivityDailyLevelLayer:upDateUI(arg_16_1)
	self.lblFightNum:setString(L_ACTIVITY_LEVEL_NUM .. arg_16_1.less_fight .. "/3")
	self.lblFightNum:setFontSize(26)

	local var_16_0, var_16_1, var_16_2 = activity_manager:get_cur_activity_technology(self.activityId)

	self.lblCurnum:setString(item_manager:getItemNumber((activity_manager:getDailyLevelItem(self.activityId))))

	for iter_16_0 = 1, 7 do
		local var_16_3 = self.rootLayer:getChildByName("Button_" .. iter_16_0)
		local var_16_4 = var_16_3:getChildByName("level")

		if iter_16_0 > arg_16_1.cur_level then
			var_16_3:loadTextures("ActivityLevel_" .. self.activityId .. "/level_lock.png", nil, "ActivityLevel_" .. self.activityId .. "/level_lock.png", var_0_4)
		elseif iter_16_0 == arg_16_1.cur_level then
			var_16_3:loadTextures("ActivityLevel_" .. self.activityId .. "/level_unlock.png", nil, "ActivityLevel_" .. self.activityId .. "/level_unlock.png", var_0_4)
		else
			var_16_3:loadTextures("ActivityLevel_" .. self.activityId .. "/level.png", nil, "ActivityLevel_" .. self.activityId .. "/level.png", var_0_4)
		end

		var_16_3:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_16_0 > arg_16_1.cur_level then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[7])

				return
			end

			local var_17_0 = {
				canSweep = true,
				show_time = true,
				activityId = self.activityId,
				data = levelmode_data[arg_16_1.cur_mode],
				times = arg_16_1.less_fight,
				showlevel = iter_16_0,
				showBuyTimeFunc = function()
					self:showBuyTimePop()
				end,
				sweepBtnFunc = function(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
					LayerManager:pushInLayer("PopDoLayer", {
						surecallback = function()
							activity_manager:sweep_activity_daily_level(self.activityId, arg_19_0, arg_19_1, arg_19_2, arg_19_3)
						end,
						labels = {
							titleNewImage = "public/title/title_operation_comfirm.png",
							des = "将消耗一次挑战次数对该关卡进行扫荡, 确认以当前阵容进行扫荡吗?",
							button = L_BUTTON_TEXT.Sure
						}
					})
				end
			}

			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.activityId * 10)
			LayerManager:pushInLayer("AdventureNewDetailLayer", var_17_0)
		end)
	end

	if arg_16_1.levelup then
		require("controller.l2utils"):numberlabelRandomAction(self.lblCurLevel, var_16_0, 1, "linear", 10)
	end

	self.rootLayer:getChildByName("buff"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSubScoreUpLayer", {
			activityid = self.activityId,
			uplist = activity_manager:getDailyLevelServant(self.activityId)
		})
	end)
end

function ActivityDailyLevelLayer:showBuyTimePop()
	LayerManager:pushInLayer("PopDoLayer", {
		surecallback = function()
			LayerManager:removePopLayer()
			activity_manager:add_activity_level_time(self.activityId)
		end,
		labels = {
			titleNewImage = "public/title/title_exchange.png",
			button = L_BUTTON_TEXT.Sure,
			des = string.format(L_ACTIVITY_ADV_2, (activity_manager:get_activity_level_buy_time_cost(self.activityId)))
		}
	})
end
