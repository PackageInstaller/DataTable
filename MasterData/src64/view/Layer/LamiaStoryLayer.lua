LamiaStoryLayer = class("LamiaStoryLayer", function()
	return cc.Layer:create()
end)

local activity_manager = require("controller.activity_manager")
local autopop_manager = require("controller.autopop_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local var_0_7 = config._DEBUG and 0 or 1
local var_0_9
local var_0_10 = 104
local var_0_11 = cc.size(328, 58)
local var_0_12 = {
	[1] = 614,
	[2] = 663
}
local var_0_14 = {
	297,
	519,
	272
}
local var_0_15 = {
	135,
	52,
	-136
}
local var_0_16 = {
	"Activity_lamia/btn_task.png",
	"Activity_lamia/btn_shop.png",
	"Activity_lamia/btn_share.png",
	"Activity_lamia/btn_kuozhao.png",
	"Activity_lamia/btn_story_1.png",
	"Activity_lamia/btn_story_2.png",
	"Activity_lamia/btn_trial.png"
}
local var_0_17 = {
	"Activity_lamia/btn_task_an.png",
	"Activity_lamia/btn_shop_an.png",
	"Activity_lamia/btn_share_an.png",
	"Activity_lamia/btn_kuozhao_an.png",
	"Activity_lamia/btn_story_1_an.png",
	"Activity_lamia/btn_story_2_an.png",
	"Activity_lamia/btn_trial_an.png"
}

function LamiaStoryLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LamiaStoryLayer.new()

	var_2_0:init(arg_2_1)
	activity_manager:fireEvent(activity_manager.activityEventId.POP_LAYER_OPEMED)

	return var_2_0
end

function LamiaStoryLayer.getInstance()
	return var_0_9
end

function LamiaStoryLayer.getLamiaStoryID(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs((require("data.city_area_data"))) do
		if iter_4_1.id == arg_4_1 then
			while iter_4_1["substory" .. 1] do
				var_4_0[1] = iter_4_1["substory" .. 1]
			end
		end
	end

	return var_4_0
end

function LamiaStoryLayer:init(arg_5_1)
	RoleDefault:getInstance():setBoolForKey("LamiaStoryLayer_first", true)

	var_0_9 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_lamia_enter.json" or "Activity_lamia_enter.ExportJson")

	self.rootLayer:setVisible(false)
	self:addChild(self.rootLayer)

	if arg_5_1 then
		self.areaid = arg_5_1.areaid or 1
	end

	self.modetype = level_manager:getAreaModeType(self.areaid)
	self.storylist = self:getLamiaStoryID(self.areaid)

	local var_5_0 = level_manager:getConversationId(self.areaid) and level_manager:getConversationId(self.areaid) or nil

	if not RoleDefault:getInstance():getBoolForKey("isFistEnterLamiaLayer") and var_5_0 then
		global_basic_scene:addChild(TalkLayer:create(var_5_0, nil, TALK_TYPE_TRAVEL, "", function()
			RoleDefault:getInstance():setBoolForKey("isFistEnterLamiaLayer", true)
			self.rootLayer:setVisible(true)
		end), ZORDER_TALKLAYER)
	else
		self.rootLayer:setVisible(true)
	end

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_title")
	self.modle_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_midel")
	self.panel_bottom = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bottom")
	self.btn_info = ccui.Helper:seekWidgetByName(self.title_panel, "btn_info")
	self.btn_info1 = ccui.Helper:seekWidgetByName(self.title_panel, "image_tile")
	self.btn_zhuxian1 = ccui.Helper:seekWidgetByName(self.modle_panel, "btn_zhuxian1")
	self.btn_zhuxian2 = ccui.Helper:seekWidgetByName(self.modle_panel, "btn_zhuxian2")
	self.btn_shilian = ccui.Helper:seekWidgetByName(self.modle_panel, "btn_shilian")
	self.btn_renwu = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_renwu")
	self.btn_heijie = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_heijie")
	self.btn_share = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_share")
	self.btn_twist = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_twist")
	self.btn_juqing = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_juqing")
	self.btn_back = ccui.Helper:seekWidgetByName(self.panel_bottom, "btn_back")
	self.buttons = {
		self.btn_zhuxian1,
		self.btn_zhuxian2,
		self.btn_shilian
	}
	self.end_buttons = {
		self.btn_renwu,
		self.btn_heijie,
		self.btn_share,
		self.btn_twist
	}

	self:registerTimeCheckEvent()
	self:palyAinEnterorOut(true)
	self:initUI()
	self:initBottomBtnList()
	self:fullScreen()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_9 = nil

			activity_manager:releaseEventListenerByName("LamiaStoryLayer")

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function LamiaStoryLayer:initUI()
	self:updateChapterProgress()
	self:updateTimeLable()
	self:updateBtnLable()
	self.btn_zhuxian1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityLevelBaseLayer", {
			initdifficulty = 1,
			activityid = 104,
			initcity = 10401
		})
	end)
	self.btn_shilian:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", self.modetype)
		LayerManager:switchShowLayer("ChapterAdvertureTower", {
			returnbacklayer = "LamiaStoryLayer",
			modetype = self.modetype
		})
	end)
	self.btn_renwu:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_11_0.lock then
			global_ShowBlockWords("活动已结束~")

			return
		end

		LayerManager:pushInLayer("Activity_Lamia_TaskLayer")
	end)
	self.btn_zhuxian2:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsTime(1) then
			LayerManager:switchShowLayer("ActivityLevelBaseLayer", {
				initdifficulty = 1,
				activityid = 104,
				initcity = 10405
			})
		end
	end)
	self.btn_back:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:palyAinEnterorOut(false, function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)
	self.btn_heijie:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_15_0.lock then
			global_ShowBlockWords("活动已结束~")

			return
		end

		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_15_0 = cc.EventCustom:new("switchShowLayer")

		var_15_0.layerName = "MarketLayer"
		var_15_0.initparam = {
			topImgPath = "MarketLayer/chapter8_heijie.png",
			returnLayer = "LamiaStoryLayer",
			singleMarket = {
				"1-10401",
				"1-10402",
				"1-10403",
				"1-10404",
				"1-10407"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_15_0)
	end)
	self.btn_share:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_16_0.lock then
			global_ShowBlockWords("活动已结束~")

			return
		end

		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0 = cc.EventCustom:new("switchShowLayer")

		var_16_0.layerName = "MarketLayer"
		var_16_0.initparam = {
			topImgPath = "MarketLayer/chapter8_title.png",
			returnLayer = "LamiaStoryLayer",
			singleMarket = {
				"1-10405",
				"1-10406"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_16_0)
	end)
	self.btn_twist:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_0.lock then
			global_ShowBlockWords("活动已结束~")

			return
		end

		local var_17_0 = cc.EventCustom:new("switchShowLayer")

		var_17_0.layerName = "TwisteggLayer"
		var_17_0.initparam = {
			initTwisType = 104,
			returnLayer = "LamiaStoryLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_17_0)
	end)
	self.btn_juqing:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SchoolCinemaLayer", {
			index = 5
		})
	end)
end

function LamiaStoryLayer.getLamiaChapterProgress(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return 0
	end

	local var_19_1 = 0
	local var_19_2 = 0
	local var_19_3 = {}
	local playermodel = require("model.playermodel")
	local levelmode_data = require("data.levelmode_data")

	for iter_19_0, iter_19_1 in pairs((require("data.city_data"))) do
		if iter_19_1.id == arg_19_1 then
			while iter_19_1["difficulty" .. 1] do
				for iter_19_2, iter_19_3 in pairs(levelmode_data) do
					if iter_19_3.mode == iter_19_1["difficulty" .. 1] then
						var_19_1 = var_19_1 + iter_19_3.totalchapter
						var_19_3[1] = iter_19_3.mode
					end
				end
			end
		end
	end

	if var_19_3 then
		for iter_19_4, iter_19_5 in pairs(var_19_3) do
			if playermodel.levelmode[iter_19_5] and playermodel.levelmode[iter_19_5].status then
				var_19_2 = var_19_2 + playermodel.levelmode[iter_19_5].status - 1
			end
		end
	end

	return (math.floor(var_19_2 / var_19_1 * 100))
end

function LamiaStoryLayer.getLamiaTowerProgress(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return 0
	end

	local var_20_0 = {}
	local var_20_1 = 0
	local var_20_2 = 0

	for iter_20_0, iter_20_1 in pairs((require("data.levelmode_data"))) do
		if iter_20_1.modetype == arg_20_1 then
			table.insert(var_20_0, iter_20_1.mode)
		end
	end

	if not next(var_20_0) then
		return 0
	end

	for iter_20_2, iter_20_3 in pairs(var_20_0) do
		var_20_1 = level_manager:getModeTotalChapter(iter_20_3) + var_20_1

		if playermodel.levelmode[iter_20_3] and playermodel.levelmode[iter_20_3].status then
			var_20_2 = var_20_2 + playermodel.levelmode[iter_20_3].status - 1
		end
	end

	return (math.floor(var_20_2 / var_20_1 * 100))
end

function LamiaStoryLayer:updateChapterProgress()
	if not self.areaid then
		return
	end

	local var_21_0 = {
		10401,
		10405
	}
	local var_21_1 = {}

	if var_21_0 and next(var_21_0) then
		for iter_21_0, iter_21_1 in ipairs(var_21_0) do
			var_21_1[iter_21_0] = self:getLamiaChapterProgress(iter_21_1)
		end
	end

	if next(var_21_1) then
		for iter_21_2 = 1, #var_21_1 do
			local var_21_2 = ccui.Helper:seekWidgetByName(self.buttons[iter_21_2], "Panel_cut")
			local var_21_3 = ccui.Helper:seekWidgetByName(self.buttons[iter_21_2], "pacent")

			var_21_2:setContentSize(cc.size(var_0_11.width * (var_21_1[iter_21_2] / 100), var_0_11.height))
			var_21_3:setString("" .. var_21_1[iter_21_2] .. "%")
		end
	else
		for iter_21_3 = 1, #var_21_1 do
			local var_21_4 = ccui.Helper:seekWidgetByName(self.buttons[iter_21_3], "Panel_cut")
			local var_21_5 = ccui.Helper:seekWidgetByName(self.buttons[iter_21_3], "pacent")

			var_21_4:setContentSize(cc.size(var_0_11.width * 0.5, var_0_11.height))
			var_21_5:setString("0%")
		end
	end

	local var_21_6 = ccui.Helper:seekWidgetByName(self.buttons[3], "Panel_cut")
	local var_21_7 = ccui.Helper:seekWidgetByName(self.buttons[3], "pacent")
	local var_21_8 = self:getLamiaTowerProgress(self.modetype)

	if var_21_8 then
		var_21_6:setContentSize(cc.size(var_0_11.width * (var_21_8 / 100), var_0_11.height))
		var_21_7:setString("" .. var_21_8 .. "%")
	else
		var_21_6:setContentSize(cc.size(0, var_0_11.height))
		var_21_7:setString("0%")
	end
end

function LamiaStoryLayer:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:palyAinEnterorOut(false, function()
			KeyCodeManager:onKeyReleasedCallFunc()

			if callback then
				callback()
			end
		end)
	end)

	self:addChild(self.bottomlist, 5)
	self.bottomlist:setVisible(false)
end

function LamiaStoryLayer:initBottomAddPanel()
	local var_25_0 = ccui.Layout:create()

	var_25_0:setPosition(cc.p(320, 30))
	var_25_0:setName("bottomAddPanel")

	self.bottomlayer = var_25_0

	self.bottomlist:addChild(var_25_0)
end

function LamiaStoryLayer:palyAinEnterorOut(arg_26_1, arg_26_2)
	if not arg_26_1 then
		for iter_26_0, iter_26_1 in pairs(self.buttons) do
			if iter_26_0 % 2 ~= 0 then
				iter_26_1:runAction(cc.MoveTo:create(0.5, cc.p(1500, iter_26_1:getPositionY())))
			else
				iter_26_1:runAction(cc.MoveTo:create(0.5, cc.p(-1500, iter_26_1:getPositionY())))
			end
		end

		self.title_panel:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.title_panel:getPositionY())))
		self.panel_bottom:runAction(cc.MoveTo:create(0.5, cc.p(-1500, self.panel_bottom:getPositionY())))

		if arg_26_2 then
			arg_26_2()
		end
	else
		for iter_26_2, iter_26_3 in pairs(self.buttons) do
			if iter_26_2 % 2 ~= 0 then
				iter_26_3:setPositionX(1500)
			else
				iter_26_3:setPositionX(-1500)
			end
		end

		for iter_26_4, iter_26_5 in pairs(self.buttons) do
			if iter_26_4 % 2 ~= 0 then
				iter_26_5:runAction(cc.MoveTo:create(0.5, cc.p(var_0_14[iter_26_4], iter_26_5:getPositionY())))
			else
				iter_26_5:runAction(cc.MoveTo:create(0.5, cc.p(var_0_14[iter_26_4], iter_26_5:getPositionY())))
			end
		end

		self.title_panel:setPositionX(1500)
		self.panel_bottom:setPositionX(-1500)
		self.title_panel:runAction(cc.MoveTo:create(0.5, cc.p(var_0_12[1], self.title_panel:getPositionY())))
		self.panel_bottom:runAction(cc.MoveTo:create(0.5, cc.p(var_0_12[2], self.panel_bottom:getPositionY())))
	end
end

function LamiaStoryLayer.dealString(arg_27_0, arg_27_1)
	local var_27_0 = os.date("*t", math.floor((global_get_time_by_date(arg_27_1))))

	return "" .. var_27_0.year .. "年" .. var_27_0.month .. "月" .. var_27_0.day .. "日"
end

function LamiaStoryLayer.getLamiaBtnTime(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs((require("data.city_area_data"))) do
		if iter_28_1.id == arg_28_1 then
			while iter_28_1["startime" .. 1] do
				var_28_0[1] = iter_28_1["startime" .. 1]
			end
		end
	end

	return var_28_0[arg_28_2]
end

function LamiaStoryLayer:checkIsTime(arg_29_1, arg_29_2)
	if not arg_29_1 then
		global_ShowBlockWords("活动暂未开放哦，敬请期待~")

		return false
	end

	local var_29_0 = self:getLamiaBtnTime(self.areaid, arg_29_1)

	if time_check_manager:getCurTime() < global_get_time_by_date(var_29_0) then
		if not arg_29_2 then
			global_ShowBlockWords("将于" .. self:dealString(var_29_0) .. "开启")
		end

		return false
	else
		return true
	end
end

function LamiaStoryLayer:fullScreen()
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.title_panel:setPositionY(self.title_panel:getPositionY() + GameDisplay.fix_y)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
	self.buttons[1]:setPositionY(var_0_15[1] + GameDisplay.fix_y / 2)
	self.buttons[2]:setPositionY(var_0_15[2] + GameDisplay.fix_y / 2)
	self.buttons[3]:setPositionY(var_0_15[3] + GameDisplay.fix_y / 2)
end

local function var_0_18(arg_31_0)
	if arg_31_0 >= 86400 then
		return string.format("%02d天%02d小时", math.floor(arg_31_0 / 86400), math.floor(arg_31_0 % 86400 / 3600))
	elseif arg_31_0 >= 3600 then
		return string.format("%02d小时%02d分钟", math.floor(arg_31_0 / 3600), math.floor(arg_31_0 % 3600 / 60))
	else
		return string.format("%02d分钟%02d秒", math.floor(arg_31_0 / 60), math.floor(arg_31_0 % 60))
	end
end

function LamiaStoryLayer.get_task_endtime(arg_32_0)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs((require("data.city_area_data"))) do
		if iter_32_1.id == 1 then
			while iter_32_1["endtime" .. 1] do
				var_32_0[1] = iter_32_1["endtime" .. 1]
			end
		end
	end

	return var_32_0
end

function LamiaStoryLayer:updateBtnLable()
	local var_33_0 = time_check_manager:getCurTime()

	if global_get_time_by_date(activity_conf_data[var_0_10].finishtime) - var_33_0 <= 0 then
		for iter_33_0, iter_33_1 in ipairs(self.end_buttons) do
			iter_33_1:loadTextures(var_0_17[iter_33_0], nil, var_0_17[iter_33_0], var_0_7)

			iter_33_1.lock = true
		end
	else
		for iter_33_2, iter_33_3 in ipairs(self.end_buttons) do
			iter_33_3:loadTextures(var_0_16[iter_33_2], nil, var_0_16[iter_33_2], var_0_7)

			iter_33_3.lock = false
		end
	end

	local var_33_1 = self:get_task_endtime()

	if var_33_1 and var_33_1[1] and var_33_0 > global_get_time_by_date(var_33_1[1]) then
		self.end_buttons[1]:loadTextures(var_0_17[1], nil, var_0_17[1], var_0_7)

		self.end_buttons[1].lock = true
	end

	if self:checkIsTime(1, true) then
		self.buttons[2]:loadTextures(var_0_16[6], nil, var_0_16[6], var_0_7)
		self.buttons[2]:getChildByName("Panel_cut"):setVisible(true)
		self.buttons[2]:getChildByName("pacent"):setVisible(true)
	else
		self.buttons[2]:loadTextures(var_0_17[6], nil, var_0_17[6], var_0_7)
		self.buttons[2]:getChildByName("Panel_cut"):setVisible(false)
		self.buttons[2]:getChildByName("pacent"):setVisible(false)
	end

	if self:checkIsTime(2, true) then
		if var_33_1 and var_33_1[2] then
			if var_33_0 < global_get_time_by_date(var_33_1[2]) then
				self.buttons[3]:loadTextures(var_0_16[7], nil, var_0_16[7], var_0_7)
				self.buttons[3]:getChildByName("Panel_cut"):setVisible(true)
				self.buttons[3]:getChildByName("pacent"):setVisible(true)
			else
				self.buttons[3]:loadTextures(var_0_17[7], nil, var_0_17[7], var_0_7)
				self.buttons[3]:getChildByName("Panel_cut"):setVisible(false)
				self.buttons[3]:getChildByName("pacent"):setVisible(false)
			end
		else
			self.buttons[3]:loadTextures(var_0_16[7], nil, var_0_16[7], var_0_7)
			self.buttons[3]:getChildByName("Panel_cut"):setVisible(true)
			self.buttons[3]:getChildByName("pacent"):setVisible(true)
		end
	end
end

function LamiaStoryLayer:updateTimeLable()
	local var_34_0 = self.title_panel:getChildByName("label_time")

	self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(global_get_time_by_date(activity_conf_data[var_0_10].finishtime) - time_check_manager:getCurTime(), function(arg_35_0)
		var_34_0:setString("灾难倒计时:" .. var_0_18(arg_35_0))
	end)))
end

function LamiaStoryLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_37_0)
		if arg_37_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:updateBtnLable()
			end)
		end
	end), self)
end
