ActivityLevel_173 = class("ActivityLevel_173", function()
	return cc.Layer:create()
end)

local var_0_4 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local levelmode_data = require("data.levelmode_data")
local activity_main_conf = require("data.activity_modules.activity_main_conf")

function ActivityLevel_173.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLevel_173.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLevel_173:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityLevel_173.json" or "ActivityLevel_173.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_level_info(173)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityLevel_173")
		end
	end)
end

function ActivityLevel_173.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityLevel_173", activity_manager.activityEventId.ACTIVITY_LEVEL_INFO_UPDATE, function(arg_6_0)
		arg_5_0:upDateUI(arg_6_0)
	end)
end

function ActivityLevel_173:initUI()
	self:initBtnReturn()
	self:initTitle()
	self:initPanelBook()
	self:initPanelBuff()
end

function ActivityLevel_173:initBtnReturn()
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

	self.lblFightNum = self.returnPanel:getChildByName("nbl_num")

	local var_8_0 = ccui.ImageView:create("public/button/add8_new.png", var_0_4)

	var_8_0:setPosition(cc.p(610, 40))
	var_8_0:setScale(0.65)
	self.returnPanel:addChild(var_8_0)
	var_8_0:setTouchEnabled(true)
	var_8_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		local var_10_1
		local var_10_0

		if arg_10_1 ~= ccui.TouchEventType.ended then
			do return end

			var_10_0 = {
				surecallback = function()
					activity_manager:add_activity_level_time(173)
				end
			}
			var_10_1 = {
				titleNewImage = "public/title/title_exchange.png",
				button = L_BUTTON_TEXT.Sure
			}
		end

		var_10_1.des = string.format(L_ACTIVITY_ADV_2, (activity_manager:get_activity_level_buy_time_cost(173)))
		var_10_0.labels = var_10_1

		LayerManager:pushInLayer("PopDoLayer", var_10_0)
	end)
end

function ActivityLevel_173:initTitle()
	self.btnDetail = self.rootLayer:getChildByName("title")

	self.btnDetail:setTouchEnabled(true)
	self.btnDetail:setPositionY(self.btnDetail:getPositionY() + GameDisplay.fix_y)
	self.btnDetail:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityLevel_173"
		})
	end)
end

function ActivityLevel_173:initPanelBook()
	local var_14_0 = self.rootLayer:getChildByName("panel_book")

	self.lblCurLevel = var_14_0:getChildByName("lbl_level")
	self.lblCurExp = var_14_0:getChildByName("lbl_exp")
	self.lblCurReward = var_14_0:getChildByName("lbl_reward")
	self.progressBar = ccui.Slider:create()

	self.progressBar:loadBarTexture("ActivityLevel_173/progress_acr_bg.png", var_0_4)
	self.progressBar:loadProgressBarTexture("ActivityLevel_173/progress_acr.png", var_0_4)
	self.progressBar:setPosition(cc.p(151, 15))
	var_14_0:addChild(self.progressBar)
	var_14_0:setPositionY(var_14_0:getPositionY() - GameDisplay.fix_y)
	var_14_0:setTouchEnabled(true)
	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_15_0 = 173
		local var_15_1 = {}

		assert(activity_main_conf[173], "activityMainConf 没填 " .. 173)
		assert(activity_main_conf[var_15_0].into_shop2, "activityMainConf " .. var_15_0 .. " 没填into_shop")

		if string.find(activity_main_conf[var_15_0].into_shop2, ",") then
			for iter_15_0, iter_15_1 in pairs(split(activity_main_conf[var_15_0].into_shop2, ",")) do
				table.insert(var_15_1, "1-" .. tonumber(iter_15_1) % 1500000)
			end
		end

		local var_15_2

		do
			var_15_1[1] = "1-" .. tonumber(activity_main_conf[var_15_0].into_shop2) % 1500000
			var_15_2 = {
				singleMarket = var_15_1
			}
		end

		var_15_2.showType = var_15_1[1]

		LayerManager:switchShowLayer("MarketLayer", var_15_2)
	end)
end

function ActivityLevel_173:initPanelBuff()
	local var_16_0 = self.rootLayer:getChildByName("buff")

	var_16_0:setPositionY(var_16_0:getPositionY() + GameDisplay.fix_y)

	self.buff1 = var_16_0:getChildByName("buff_1")
	self.buff2 = var_16_0:getChildByName("buff_2")

	self.buff1:setString(L_ACTIVITY_LEVEL_BUFF)
	self.buff2:setString("")
	var_16_0:setTouchEnabled(true)
	var_16_0:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSubScoreUpLayer", {
			activityid = 173,
			uplist = {
				{
					servantid = 27620
				},
				{
					servantid = 27720
				},
				{
					servantid = 27820
				}
			}
		})
	end)
end

function ActivityLevel_173:upDateUI(arg_18_1)
	self.lblFightNum:setString(L_ACTIVITY_LEVEL_NUM .. arg_18_1.less_fight .. "/6")
	self.lblFightNum:setFontSize(26)

	local var_18_0, var_18_1, var_18_2 = activity_manager:get_cur_activity_technology(173)

	self.lblCurLevel:setString(var_18_0)
	self.lblCurExp:setString(var_18_1)
	self.lblCurReward:setString(string.format("+%s/h", arg_18_1.reward_num))
	self.progressBar:setPercent(var_18_2)

	for iter_18_0 = 1, 7 do
		local var_18_3 = self.rootLayer:getChildByName("Button_" .. iter_18_0)
		local var_18_4 = var_18_3:getChildByName("level")

		if iter_18_0 > arg_18_1.cur_level then
			var_18_3:loadTextures("ActivityLevel_173/level_lock.png", nil, "ActivityLevel_173/level_lock.png", var_0_4)
			var_18_4:setColor(cc.c3b(64, 65, 67))
		else
			var_18_3:loadTextures("ActivityLevel_173/level.png", nil, "ActivityLevel_173/level.png", var_0_4)
			var_18_4:setColor(cc.c3b(90, 108, 246))
		end

		var_18_3:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_18_1.less_fight <= 0 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[3])

				return
			end

			if iter_18_0 > arg_18_1.cur_level then
				return
			end

			local var_19_0 = {
				data = levelmode_data[arg_18_1.cur_mode],
				times = arg_18_1.less_fight,
				showlevel = iter_18_0,
				show_time = iter_18_0 == arg_18_1.cur_level
			}

			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 1730)
			LayerManager:pushInLayer("AdventureNewDetailLayer", var_19_0)
		end)
	end

	if arg_18_1.levelup then
		require("controller.l2utils"):numberlabelRandomAction(self.lblCurLevel, var_18_0, 1, "linear", 10)
	end
end
