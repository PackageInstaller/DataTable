ActivityLevelLayer = class("LevelMapLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local activity_manager = require("controller.activity_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local patrol_manager = require("controller.patrol_manager")
local barrage_manager = require("controller.barrage_manager")
local array_manager = require("controller.array_manager")
local item_data = require("data.item_data")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local city_data = require("data.city_data")
local CityList = require("view.Sprite.CityList")
local var_0_15 = {
	LRTIP = 7,
	LOCKWORD = 4,
	BASIC = 6,
	CHAPTERS = 2,
	COVER = 3,
	CITYLIST = 5,
	MAP = 1
}
local var_0_16 = {
	NEW = "LevelMap/city_frame_new.png",
	SELECT = "LevelMap/city_frame_selected.png",
	NORMAL = "LevelMap/city_frame_normal.png"
}
local var_0_17 = "CityMap/title/"
local var_0_18 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}
local var_0_19 = {
	426,
	310,
	196,
	82
}
local var_0_21

function ActivityLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLevelLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLevelLayer.getInstance()
	return var_0_21
end

function ActivityLevelLayer:init(arg_4_1)
	var_0_21 = self
	self._playingani = false

	assert(arg_4_1, "must have init config")

	self.activityid = arg_4_1.activityid

	if arg_4_1.initcity then
		self.initcity = arg_4_1.initcity
		self.initdifficulty = level_manager:getDifficultByMode(arg_4_1.initcity)
	else
		local var_4_0 = RoleDefault:getInstance():getIntegerForKey("ActivityAdventureEnterMode", -1)

		if var_4_0 ~= -1 and levelmode_data[var_4_0] and city_data[levelmode_data[var_4_0].city] and city_data[levelmode_data[var_4_0].city].is_activity_city == self.activityid then
			self.initcity = level_manager:getCityByMode(var_4_0)
			self.initdifficulty = level_manager:getDifficultByMode(var_4_0)
		else
			self.initcity = level_manager:getMaxActivityCity(self.activityid)
			self.initdifficulty = level_manager:getUnlockedDifficultyInCity(self.initcity)
		end
	end

	patrol_manager:reset()
	self:initTimers()
	self:initBasicUILayer()
	self:initCityMapLayer()
	self:initChangeBnt()
	self:initActivity()
	self:playInitShowAni()
	self:fullScreen()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_21 = false
		elseif arg_5_0 == "enter" then
			KeyCodeManager:UpdateInitParamPool("ActivityLevelLayer", arg_4_1)
		end
	end)
end

function ActivityLevelLayer:initActivity()
	local var_6_0 = {
		[128] = function()
			local var_7_0 = ccui.Button:create("CityMap/activity/summer_buff_icon.png", nil, "CityMap/activity/summer_buff_icon.png")

			var_7_0:setAnchorPoint(cc.p(0, 0.5))
			var_7_0:setPosition(20, -GameDisplay.fix_y + 300)
			self.uilayer:addChild(var_7_0)
		end,
		[132] = function()
			if not levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon then
				return
			end

			local var_8_1 = ccui.Button:create("CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png", nil, "CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png")

			if not var_8_1 then
				return
			end

			var_8_1:setAnchorPoint(cc.p(0, 0.5))
			var_8_1:setPosition(20, -GameDisplay.fix_y + 300)
			var_8_1:setName("activity_icon")
			self.uilayer:addChild(var_8_1)
		end
	}

	setmetatable(var_6_0, {
		__index = function(arg_9_0, arg_9_1)
			if not levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon then
				return
			end

			local var_9_1 = ccui.Button:create("CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png", nil, "CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png")

			if not var_9_1 then
				return
			end

			var_9_1:setAnchorPoint(cc.p(0, 0.5))
			var_9_1:setPosition(20, -GameDisplay.fix_y + 300)
			var_9_1:setName("activity_icon")
			self.uilayer:addChild(var_9_1)
		end
	})

	if var_6_0[self.activityid] then
		var_6_0[self.activityid]()
	end
end

function ActivityLevelLayer:updateActivity()
	local var_10_0 = {
		[132] = function()
			if not levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon then
				return
			end

			local var_11_1 = self.uilayer:getChildByName("activity_icon")

			if not var_11_1 then
				return
			end

			var_11_1:loadTextures("CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png", nil, "CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png")
		end
	}

	setmetatable(var_10_0, {
		__index = function(arg_12_0, arg_12_1)
			if not levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon then
				return
			end

			local var_12_1 = self.uilayer:getChildByName("activity_icon")

			if not var_12_1 then
				return
			end

			var_12_1:loadTextures("CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png", nil, "CityMap/activity/" .. levelmode_data[level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)].up_icon .. ".png")
		end
	})

	if var_10_0[self.activityid] then
		var_10_0[self.activityid]()
	end
end

function ActivityLevelLayer:initChangeBnt()
	self.changeBnt = ccui.Helper:seekWidgetByName(self.uilayer, "Button_change")

	self.changeBnt:setVisible(false)
	self.changeBnt:loadTextures("LevelMap/goto_talk.png", nil, "LevelMap/goto_talk.png", var_0_0)
	self.changeBnt:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isPlayerPassLevel(UNLOCK_LEVELTALK) then
			global_ShowBlockWords(L_TALKLEVEL_LOCK)
		else
			LayerManager:switchShowLayer("LevelTalkMapLayer")
		end
	end)
end

function ActivityLevelLayer:fullScreen()
	self.panelDifficulty.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.panelDifficulty:getPositionY(), TRANSFORM_UNIT.PX)

	self.panelDifficulty:setPositionY(self.panelDifficulty.full_posY)

	self.cityTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.cityTitle:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityTitle:setPositionY(self.cityTitle.full_posY)

	self.btnReturn.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btnReturn:getPositionY(), TRANSFORM_UNIT.PX)

	self.btnReturn:setPositionY(self.btnReturn.full_posY)

	self.cityList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityList:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityList:setPositionY(self.cityList.full_posY)

	local var_15_0 = ccui.Helper:seekWidgetByName(self.uilayer, "city_panel_frame")

	var_15_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_15_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_15_0:setPositionY(var_15_0.full_posY)
	ccui.Helper:seekWidgetByName(self.uilayer, "Button_main"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.uilayer, "Button_branch"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.uilayer, "Button_special"):setVisible(false)
end

local function var_0_22(arg_16_0)
	if arg_16_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_16_0 / 3600), math.floor(arg_16_0 % 3600 / 60), arg_16_0 % 60)
	else
		return string.format("%02d:%02d", math.floor(arg_16_0 / 60), arg_16_0 % 60)
	end
end

function ActivityLevelLayer:initTimers()
	self.timers = {}

	self:scheduleUpdateWithPriorityLua(function(arg_18_0)
		for iter_18_0, iter_18_1 in pairs(self.timers) do
			local var_18_0 = patrol_manager:getPatrolInfo(iter_18_1.key)

			if var_18_0 then
				if var_18_0.time <= 0 then
					self.chapters[iter_18_1.index]:getChildByName("timer"):setVisible(false)
					self.chapters[iter_18_1.index]:getChildByName("completetag"):setVisible(true)
				else
					self.chapters[iter_18_1.index]:getChildByName("timer"):setVisible(true)
					self.chapters[iter_18_1.index]:getChildByName("timer"):setString(var_0_22(var_18_0.time))
				end
			else
				self.timers[iter_18_0] = nil

				self.chapters[iter_18_1.index]:getChildByName("timer"):setVisible(false)
			end
		end
	end, 0)
end

function ActivityLevelLayer.cleanAllTimers(arg_19_0)
	arg_19_0.timers = {}
end

function ActivityLevelLayer.changeTheCityList(arg_20_0, arg_20_1)
	return arg_20_1
end

function ActivityLevelLayer:initBasicUILayer()
	self:loadBasicUIAssets()

	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelMap.json" or "LevelMap.ExportJson")

	self:addChild(self.uilayer, var_0_15.BASIC)

	self.cityTitle = ccui.Helper:seekWidgetByName(self.uilayer, "title")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.uilayer, "btn_return")

	self.btnReturn:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		self:playExitAni()
	end)
	self:initPanelDifficulty()
	self:initCityList()
	self:initUIInfos()
end

function ActivityLevelLayer:initCityList()
	self.cityList = CityList:create()

	self:addChild(self.cityList, var_0_15.CITYLIST)

	self.curcity = nil
	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local var_23_0 = self:changeTheCityList(level_manager:getActivityCityList(self.activityid))

	local function var_23_1(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_24_0:getTouchBeganPosition().x - arg_24_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_24_0:getTag())

		for iter_24_0, iter_24_1 in ipairs(var_23_0) do
			self:updateCityBntTips(iter_24_1)
		end

		self:updateLeftRightTigEffect()
	end

	local function var_23_2(arg_25_0)
		local var_25_0 = ccui.Button:create(var_0_16.NORMAL, var_0_16.NORMAL, var_0_16.NORMAL, var_0_0)

		var_25_0:setName("city" .. arg_25_0)

		local var_25_1 = cc.Sprite:create("CityMap/MiniMap/" .. level_manager:getCityImg(arg_25_0) .. ".png")

		var_25_1:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2))
		var_25_1:setName("minimap")
		var_25_0:addChild(var_25_1, -1)

		local var_25_2 = ccui.ImageView:create(var_0_16.SELECT, var_0_0)

		var_25_2:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_0:getContentSize().height / 2))
		var_25_2:setName("frame")
		var_25_2:setVisible(false)
		var_25_0:addChild(var_25_2, 2)

		if not level_manager:isCityUnlocked(arg_25_0) then
			l2utils:shaderGrayDark(var_25_0:getVirtualRenderer())
			l2utils:shaderGrayDark(var_25_1)

			if not level_manager:isCityCanUnlock(arg_25_0) then
				l2utils:shaderNode(var_25_2:getVirtualRenderer())
			end
		else
			l2utils:shaderDarkNode(var_25_0:getVirtualRenderer())
			l2utils:shaderDarkNode(var_25_1)
		end

		var_25_0:addTouchEventListener(var_23_1)

		return var_25_0
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_3 = var_23_2(iter_23_1)

		self.cityList:pushInCity(var_23_3)

		self.cities[iter_23_1] = var_23_3
		self.index_to_city[var_23_3:getTag()] = iter_23_1
		self.city_to_index[iter_23_1] = var_23_3:getTag()
	end

	self.cityList:registerSelectCityHandler(function(arg_26_0)
		if self.curcity == self.index_to_city[arg_26_0] then
			return
		end

		self:updateCityOnUnSelect(self.curcity)

		self.curcity = self.index_to_city[arg_26_0]

		self:updateCityOnSelect(self.curcity)
		self:playSelectCityAni()

		for iter_26_0, iter_26_1 in ipairs(var_23_0) do
			self:updateCityBntTips(iter_26_1)
		end

		self:updateLeftRightTigEffect()
	end)

	self.curcity = self.initcity

	self:updateCityOnSelect(self.curcity)
	self.cityList:jumpToIndex(self.city_to_index[self.curcity])

	for iter_23_2, iter_23_3 in ipairs(var_23_0) do
		self:updateCityBntTips(iter_23_3)
	end

	self:updateLeftRightTigEffect()
end

function ActivityLevelLayer:updateCityBntTips(arg_27_1)
	local var_27_0 = self.cities[arg_27_1]
	local var_27_1 = self.cities[arg_27_1]:getChildByName("frame")

	local function var_27_2()
		return self.city_to_index[arg_27_1] - self.city_to_index[self.curcity] == -1
	end

	local var_27_3 = 0
	local var_27_4 = 45
	local var_27_7 = 3
	local var_27_8 = self.cityList:getCityBtnDirection(arg_27_1)

	if level_manager:isCityCanUnlock(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("newtag") then
			var_27_1:loadTexture(var_0_16.NEW, var_0_0)
			var_27_1:setVisible(true)

			local var_27_9 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_27_9:setAnchorPoint(cc.p(0.5, 0))

			if var_27_2() then
				var_27_9:setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
			else
				var_27_9:setPosition(cc.p(150, 100))
			end

			var_27_9:setName("newtag")
			var_27_0:addChild(var_27_9)
		elseif var_27_2() then
			var_27_0:getChildByName("newtag"):setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
		else
			var_27_0:getChildByName("newtag"):setPosition(cc.p(150, 100))
		end
	elseif var_27_0:getChildByName("newtag") then
		var_27_0:removeChildByName("newtag")
	end

	if patrol_manager:isCityFinishedPatrol(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("reddot") then
			local var_27_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_27_10:setAnchorPoint(cc.p(1, 1))

			if var_27_2() then
				var_27_10:setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
			else
				var_27_10:setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
			end

			var_27_10:setName("reddot")
			var_27_0:addChild(var_27_10, 9)
		elseif var_27_2() then
			var_27_0:getChildByName("reddot"):setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
		else
			var_27_0:getChildByName("reddot"):setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
		end
	elseif var_27_0:getChildByName("reddot") then
		var_27_0:removeChildByName("reddot")
	end

	if level_manager:isCityNewDifficulty(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("newDifficultyTips") then
			local var_27_11 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_27_11:setAnchorPoint(cc.p(0.5, 0))

			if var_27_2() then
				var_27_11:setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
			else
				var_27_11:setPosition(cc.p(150, 100))
			end

			var_27_11:setName("newDifficultyTips")
			var_27_0:addChild(var_27_11)
		elseif var_27_2() then
			var_27_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150 - var_27_4, 100 + var_27_3))
		else
			var_27_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150, 100))
		end
	elseif var_27_0:getChildByName("newDifficultyTips") then
		var_27_0:removeChildByName("newDifficultyTips")
	end

	if level_manager:checkIsNewStarRewardInCity(arg_27_1) and var_27_8 == var_27_7 then
		if not var_27_0:getChildByName("newStarTips") then
			local var_27_12 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_27_12:setAnchorPoint(cc.p(1, 1))

			if var_27_2() then
				var_27_12:setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
			else
				var_27_12:setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
			end

			var_27_12:setName("newStarTips")
			var_27_0:addChild(var_27_12, 9)
		elseif var_27_2() then
			var_27_0:getChildByName("newStarTips"):setPosition(var_27_0:getContentSize().width - 10 - var_27_4, var_27_0:getContentSize().height + 18 + var_27_3)
		else
			var_27_0:getChildByName("newStarTips"):setPosition(var_27_0:getContentSize().width - 10, var_27_0:getContentSize().height + 18)
		end
	else
		local var_27_13
		local var_27_14

		if var_27_0:getChildByName("newStarTips") then
			var_27_0:removeChildByName("newStarTips")

			var_27_13 = var_27_8 == var_27_7
			var_27_14 = ipairs
		end
	end

	for iter_27_0, iter_27_1 in var_27_14({
		"newDifficultyTips",
		"reddot",
		"newPatrolTips",
		"newStarTips"
	}) do
		if var_27_0:getChildByName(iter_27_1) then
			var_27_0:getChildByName(iter_27_1):setVisible(var_27_13)

			var_27_13 = false
		end
	end
end

function ActivityLevelLayer:updateLeftRightTigEffect()
	local var_29_0 = self:changeTheCityList(level_manager:getCityList())

	local function var_29_1(arg_30_0)
		if level_manager:isCityCanUnlock(arg_30_0) then
			return true
		end

		if patrol_manager:isCityFinishedPatrol(arg_30_0) then
			return true
		end

		if patrol_manager:isCityNewPatrol(arg_30_0) then
			return true
		end

		if level_manager:isCityNewDifficulty(arg_30_0) then
			return true
		end

		if PlotManager.plot_layer_config["LevelMapLayer" .. arg_30_0] then
			return true
		end

		if level_manager:checkIsNewStarRewardInCity(arg_30_0) then
			return true
		end

		return false
	end

	local function var_29_2()
		local var_32_0 = false

		for iter_32_0, iter_32_1 in ipairs(var_29_0) do
			if self.cityList:getCityBtnDirection(iter_32_1) == 2 and var_29_1(iter_32_1) then
				var_32_0 = true

				break
			end
		end

		return var_32_0
	end

	if not self:getChildByName("left_tag") then
		local var_29_3 = ccui.ImageView:create("LevelMap/left_right_tag.png", var_0_0)

		var_29_3:setPosition(cc.p(18 - GameDisplay.fix_x, 128 - GameDisplay.fix_y))
		var_29_3:setName("left_tag")
		var_29_3:setVisible(false)
		self:addChild(var_29_3, var_0_15.LRTIP)
		var_29_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(18 - GameDisplay.fix_x + 10, 128 - GameDisplay.fix_y + 10)), cc.MoveTo:create(0.5, cc.p(18 - GameDisplay.fix_x, 128 - GameDisplay.fix_y)))))
	end

	if not self:getChildByName("right_tag") then
		local var_29_4 = ccui.ImageView:create("LevelMap/left_right_tag.png", var_0_0)

		var_29_4:setPosition(cc.p(GameDisplay.width - (18 - GameDisplay.fix_x), 128 - GameDisplay.fix_y))
		var_29_4:setScaleX(-1)
		var_29_4:setName("right_tag")
		var_29_4:setVisible(false)
		var_29_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(GameDisplay.width - (18 - GameDisplay.fix_x) - 10, 128 - GameDisplay.fix_y + 10)), cc.MoveTo:create(0.5, cc.p(GameDisplay.width - (18 - GameDisplay.fix_x), 128 - GameDisplay.fix_y)))))
		self:addChild(var_29_4, var_0_15.LRTIP)
	end

	if (function()
		local var_31_0 = false

		for iter_31_0, iter_31_1 in ipairs(var_29_0) do
			if self.cityList:getCityBtnDirection(iter_31_1) == 1 and var_29_1(iter_31_1) then
				var_31_0 = true

				break
			end
		end

		return var_31_0
	end)() then
		self:getChildByName("left_tag"):setVisible(true)
	else
		self:getChildByName("left_tag"):setVisible(false)
	end

	if var_29_2() then
		self:getChildByName("right_tag"):setVisible(true)
	else
		self:getChildByName("right_tag"):setVisible(false)
	end

	self:getChildByName("right_tag"):setVisible(false)
	self:getChildByName("left_tag"):setVisible(false)
end

function ActivityLevelLayer:getCityByID(arg_33_1)
	return self.cities[arg_33_1]
end

function ActivityLevelLayer:getCityByIndex(arg_34_1)
	return self.cities[self.index_to_city[arg_34_1]]
end

function ActivityLevelLayer:updateCityOnSelect(arg_35_1)
	local var_35_0 = self:getCityByID(arg_35_1)

	if level_manager:isCityUnlocked(arg_35_1) then
		l2utils:recoverShader(var_35_0:getVirtualRenderer())
		l2utils:recoverShader(var_35_0:getChildByName("minimap"))
	else
		l2utils:shaderNode(var_35_0:getVirtualRenderer())
		l2utils:shaderNode(var_35_0:getChildByName("minimap"))
	end

	var_35_0:getChildByName("frame"):setVisible(true)

	if not level_manager:isCityCanUnlock(arg_35_1) then
		var_35_0:getChildByName("frame"):loadTexture(var_0_16.SELECT, var_0_0)
	end

	self:playCityFrameBreath(arg_35_1)
end

function ActivityLevelLayer:updateCityOnUnSelect(arg_36_1)
	local var_36_0 = self:getCityByID(arg_36_1)

	if level_manager:isCityUnlocked(arg_36_1) then
		l2utils:shaderDarkNode(var_36_0:getVirtualRenderer())
		l2utils:shaderDarkNode(var_36_0:getChildByName("minimap"))
	else
		l2utils:shaderGrayDark(var_36_0:getVirtualRenderer())
		l2utils:shaderGrayDark(var_36_0:getChildByName("minimap"))
	end

	if not level_manager:isCityCanUnlock(arg_36_1) then
		var_36_0:getChildByName("frame"):setVisible(false)
	end

	self:stopCityFrameBreath(arg_36_1)
end

function ActivityLevelLayer:updateCityOnUnlock()
	local var_37_0 = self:getCityByID(self.curcity)

	l2utils:recoverShader(var_37_0:getVirtualRenderer())
	l2utils:recoverShader(var_37_0:getChildByName("minimap"))

	if var_37_0:getChildByName("newtag") then
		var_37_0:removeChildByName("newtag")
	end

	var_37_0:getChildByName("frame"):loadTexture(var_0_16.SELECT, var_0_0)
end

function ActivityLevelLayer.playCityFrameBreath(arg_38_0, arg_38_1)
	return
end

function ActivityLevelLayer.stopCityFrameBreath(arg_39_0, arg_39_1)
	return
end

function ActivityLevelLayer:initUIInfos()
	local var_40_0 = self.initdifficulty and level_manager:isCityDifficultyValid(self.curcity, self.initdifficulty) and self.initdifficulty or self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or level_manager:getUnlockedDifficultyInCity(self.curcity)

	if level_manager:isCityUnlocked(self.curcity) then
		self.curdifficuty = var_40_0
		self.finaldifficuty = var_40_0

		self.cityTitle:loadTexture(var_0_17 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = nil

		self.cityTitle:loadTexture(var_0_17 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	self.cityTitle:setTouchEnabled(true)
	self.cityTitle:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	self:updateDifficutyPanel()
	self:initStarRewardUI()
	self:initRankUI()
end

function ActivityLevelLayer:updateUIInfos()
	if level_manager:isCityUnlocked(self.curcity) then
		if self.finaldifficuty then
			local var_42_0 = level_manager:getCityDifficulties(self.curcity)
			local var_42_1

			for iter_42_0 = 1, 4 do
				if var_42_0[iter_42_0] and var_42_0[iter_42_0].stat then
					var_42_1 = iter_42_0
				end
			end

			self.curdifficuty = var_42_1 < self.finaldifficuty and var_42_1 or self.finaldifficuty
		else
			self.curdifficuty = self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or 1
			self.finaldifficuty = self.curdifficuty
		end

		self.cityTitle:loadTexture(var_0_17 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = nil

		self.cityTitle:loadTexture(var_0_17 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	self:updateDifficutyPanel()
	self:updateRankUI()
	self:updateStarRewardUI()
end

function ActivityLevelLayer:initPanelDifficulty()
	self.panelDifficulty = ccui.Helper:seekWidgetByName(self.uilayer, "panel_difficulty")

	for iter_43_0 = 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_43_0]):addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			if level_manager:isCityNewDifficulty(self.curcity, iter_43_0) then
				level_manager:unMarkModeNew(level_manager:getModeByDifficulty(self.curcity, iter_43_0))
				self:updateDifficutyTips(self.curcity, iter_43_0)
				self:updateCityBntTips(self.curcity)
			end

			if iter_43_0 == self.curdifficuty then
				return
			end

			if self._playingani then
				return
			end

			self:selectDifficulty(iter_43_0)
		end)
	end
end

function ActivityLevelLayer:selectDifficulty(arg_45_1)
	self.curdifficuty = arg_45_1
	self.finaldifficuty = arg_45_1

	self.cityTitle:loadTexture(var_0_17 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
	self:updateDifficutyPanel()
	self:updateRankUI()
	self:updateStarRewardUI()
	self:playSelectDifficultyAni()
end

function ActivityLevelLayer:updateDifficutyPanel()
	local var_46_0 = 0

	for iter_46_0, iter_46_1 in ipairs((level_manager:getCityDifficulties(self.curcity))) do
		if iter_46_1.stat then
			self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_0]):setVisible(true)

			local var_46_1

			if iter_46_0 == self.curdifficuty then
				var_46_1 = "LevelMap/btn_" .. var_0_18[iter_46_0] .. ".png"

				self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_0]):getVirtualRenderer():setOpacity(255)
			else
				var_46_1 = "LevelMap/btn_" .. var_0_18[iter_46_0] .. ".png"

				self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_0]):getVirtualRenderer():setOpacity(170)
			end

			self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_0]):loadTextures(var_46_1, nil, var_46_1, var_0_0)

			var_46_0 = var_46_0 + 1

			self:updateDifficutyTips(self.curcity, iter_46_0)
		else
			self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_0]):setVisible(false)
		end
	end

	for iter_46_2 = 1, var_46_0 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_2]):setPositionX(var_0_19[var_46_0 + 1 - iter_46_2])
		self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_2]):setVisible(true)
	end

	for iter_46_3 = var_46_0 + 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_18[iter_46_3]):setVisible(false)
	end

	if var_46_0 == 1 then
		self.panelDifficulty:getChildByName("btn_" .. var_0_18[var_46_0]):setVisible(false)
	end
end

function ActivityLevelLayer:updateDifficutyTips(arg_47_1, arg_47_2)
	local var_47_0 = self.panelDifficulty:getChildByName("btn_" .. var_0_18[arg_47_2])
	local var_47_1 = {}

	if patrol_manager:isCityFinishedPatrol(arg_47_1, arg_47_2) then
		if not var_47_0:getChildByName("reddot") then
			local var_47_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_47_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_47_2:setPosition(var_47_0:getContentSize().width, var_47_0:getContentSize().height)
			var_47_2:setName("reddot")
			var_47_0:addChild(var_47_2)
		else
			var_47_0:getChildByName("reddot"):setVisible(true)
		end

		if self.curdifficuty == arg_47_2 then
			var_47_0:getChildByName("reddot"):setVisible(false)
		end

		var_47_1.reddot = true
	elseif var_47_0:getChildByName("reddot") then
		var_47_0:getChildByName("reddot"):setVisible(false)
	end

	if level_manager:isCityNewDifficulty(arg_47_1, arg_47_2) then
		if not var_47_0:getChildByName("newDifficultyTips") then
			local var_47_3 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_47_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_47_3:setPosition(cc.p(var_47_0:getContentSize().width - 20, var_47_0:getContentSize().height))
			var_47_3:setName("newDifficultyTips")
			var_47_0:addChild(var_47_3)
		else
			var_47_0:getChildByName("newDifficultyTips"):setVisible(true)
		end

		var_47_1.newDifficultyTips = true
	elseif var_47_0:getChildByName("newDifficultyTips") then
		var_47_0:getChildByName("newDifficultyTips"):setVisible(false)
	end

	if self.curdifficuty ~= arg_47_2 then
		for iter_47_0, iter_47_1 in ipairs({
			"newDifficultyTips",
			"reddot",
			"newPatrolTips"
		}) do
			if var_47_0:getChildByName(iter_47_1) and var_47_1[iter_47_1] then
				var_47_0:getChildByName(iter_47_1):setVisible(true)
			end
		end
	end
end

function ActivityLevelLayer:initCityMapLayer()
	local var_48_0 = self.initcity or level_manager:getCurFightCity()
	local var_48_1 = self.initdifficulty and level_manager:isCityDifficultyValid(var_48_0, self.initdifficulty) and self.initdifficulty or var_48_0 == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or level_manager:getUnlockedDifficultyInCity(var_48_0)
	local var_48_2 = level_manager:getModeByDifficulty(var_48_0, var_48_1)

	self.maplayer = ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(var_48_0) .. ".json")

	self:addChild(self.maplayer, var_0_15.MAP)
	self.maplayer:getChildByName("bgframe"):setScaleY(GameDisplay.height / self.maplayer:getChildByName("bgframe"):getContentSize().height)
	self.maplayer:getChildByName("bgframe"):setVisible(false)

	local var_48_3 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_48_3:setFlippedX(true)
	var_48_3:setFlippedY(true)
	var_48_3:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_48_3, 1)

	if level_manager:isCityUnlocked(var_48_0) then
		if config._DEBUG then
			self.cover = cc.Sprite:create("LevelMap/cover_" .. var_0_18[var_48_1] .. ".png") or cc.Sprite:createWithSpriteFrameName("LevelMap/cover_" .. var_0_18[var_48_1] .. ".png")
		end

		self.cover:setVisible(false)
		self.cover:setAnchorPoint(cc.p(0.5, 0))
		self.cover:setPosition(cc.p(320, -GameDisplay.fix_y))
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
		self.cover:setName("colorcover")
		self.maplayer:addChild(self.cover, 1)
	end

	self:initCityMapChapters()
	self:initSpecialChapter()

	for iter_48_0 = 1, math.min(level_manager:getModeTotalChapter(var_48_2), 10) do
		local var_48_4 = self.maplayer:getChildByName("area_" .. iter_48_0)

		self:updateChapters(iter_48_0)

		if level_manager:isChapterModeUnlocked(var_48_2, iter_48_0) then
			var_48_4:setVisible(true)
			var_48_4:loadTexture("Maps/" .. var_0_18[var_48_1] .. "point.png")
		else
			var_48_4:setVisible(false)
		end
	end

	self:updateSpecialChapter()
	self:updateActivity()
	self:initMapLockWord()
	self:updateMapLockWord(var_48_0)
end

function ActivityLevelLayer:initMapLockWord()
	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self:addChild(self.mapLockWord, var_0_15.LOCKWORD)

	local var_49_0 = ccui.ImageView:create("LevelMap/cover_locked.png", var_0_0)

	var_49_0:setScale9Enabled(true)
	var_49_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_49_0:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_49_0)

	local var_49_1 = ccui.ImageView:create("LevelMap/wordbg.png", var_0_0)

	var_49_1:setName("mapLockWordBg")
	var_49_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_49_1)

	local var_49_2 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_49_2:setAnchorPoint(cc.p(1, 0.5))
	var_49_2:setPosition(cc.p(640, GameDisplay.height / 2))
	var_49_2:setName("lockui1")
	self.mapLockWord:addChild(var_49_2)

	local var_49_3 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_49_3:setAnchorPoint(cc.p(0, 0.5))
	var_49_3:setPosition(cc.p(0, GameDisplay.height / 2))
	var_49_3:setFlippedY(true)
	var_49_3:setFlippedX(true)
	var_49_3:setName("lockui2")
	self.mapLockWord:addChild(var_49_3)

	local var_49_4 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_49_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_49_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_49_4:setName("word")
	self.mapLockWord:addChild(var_49_4)
	self.mapLockWord:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		if not level_manager:isCityCanUnlock(self.curcity) then
			return
		end

		local function var_50_0()
			self.cityList:setScrollEnabled(true)
		end

		LayerManager:pushInLayer("PopCityUnlockLayer", {
			city = self.curcity,
			successcallback = function()
				self.cityList:setScrollEnabled(false)
				self:updateCityOnUnlock()
				self:playUnlockAni(var_50_0)
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
			end
		})
	end)
end

function ActivityLevelLayer:initCityMapChapters()
	self.chapterlayer = cc.Layer:create()

	self:addChild(self.chapterlayer, var_0_15.CHAPTERS)

	local function var_53_0(arg_54_0, arg_54_1)
		if arg_54_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		local var_54_0 = self.curcity
		local var_54_1 = self.curdifficuty
		local var_54_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
		local var_54_3 = arg_54_0:getTag()

		if not level_manager:isChapterModeUnlocked(var_54_2, var_54_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Forbid)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		if not level_manager:isChapterModeValid(var_54_2, var_54_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Locking)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		if patrol_manager:getPatrolInfo(var_54_2 .. "-" .. var_54_3) then
			LayerManager:pushInLayer("PatrolPopLayer", {
				inittype = 2,
				mode = var_54_2,
				chapter = var_54_3,
				callback = function()
					self:updateChapters(var_54_3)
					self:updateCityBntTips(var_54_0, var_54_1)
					self:updateDifficutyTips(var_54_0, var_54_1)
				end
			})
		else
			local var_54_6, var_54_7 = level_manager:isModeValid(var_54_2)

			if not var_54_6 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(level_manager:getModeUnlockMsg(var_54_2, var_54_7))

				return
			end

			local function var_54_8(arg_56_0)
				if arg_56_0 == 1 then
					AnalyticManager.click_bosstower()
					LayerManager:switchShowLayer("FightLayer", {
						is_hide_topcost = true,
						is_hide_listbutton = true
					})
					FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
				else
					if arg_56_0 == 2 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[2])
					elseif arg_56_0 == 3 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[3])
					elseif arg_56_0 == 4 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[4])
					elseif arg_56_0 == 5 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[5])
					elseif arg_56_0 == 6 then
						audio_manager:playeffectMusicTest("sound/invalid")

						if chapter_data["" .. var_54_2 .. "-" .. var_54_3] and chapter_data["" .. var_54_2 .. "-" .. var_54_3].boss_combat then
							global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_54_2 .. "-" .. var_54_3].boss_combat .. L_ADVENTURE_WARNING[7])
						end
					end

					GuideListener.showAllGuidesWithFullScreen(true)
				end
			end

			local function var_54_9(arg_57_0)
				local function var_57_0()
					GuideListener.showAllGuidesWithFullScreen(false)
					array_manager:resetHangupArray(arg_57_0)
					RoleDefault:getInstance():setIntegerForKey("activityarray", arg_57_0)
					RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_57_0)
					RoleDefault:getInstance():setIntegerForKey("ActivityAdventureEnterMode", var_54_2)
					RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", levelmode_data[var_54_2].modetype)
					level_manager:switchToAdventureMode(var_54_2, var_54_3, var_54_8, arg_57_0)
				end

				if chapter_data[var_54_2 .. "-" .. var_54_3].classification and var_54_3 >= playermodel.levelmode[var_54_2].status then
					global_basic_scene:addChild(TalkLayer:create(chapter_data[var_54_2 .. "-" .. var_54_3].classification, nil, TALK_TYPE_BEFORE_BOSS, "", var_57_0, 1), ZORDER_TALKLAYER)
				else
					var_57_0()
				end
			end

			local var_54_10 = RoleDefault:getInstance():getIntegerForKey("activityarray", 1)

			LayerManager:pushInLayer("LevelDetailLayer", {
				fight_type = "ADVENTURE",
				level = 1,
				mode = var_54_2,
				chapter = var_54_3,
				callback = function()
					return
				end,
				adventuresurecallback = function()
					require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", {
						initindex = var_54_10,
						mode = var_54_2,
						configcallback = var_54_9,
						adventure5callback = callback
					})
				end,
				initindex = var_54_10
			})
		end
	end

	self.chapters = setmetatable({}, {
		__index = function(arg_61_0, arg_61_1)
			assert(type(arg_61_1) == "number", "Need Number for Chapters Index")

			local var_61_0 = ccui.Button:create("LevelMap/level1_easy.png", "LevelMap/level1_easy.png", "LevelMap/level1_easy.png", var_0_0)

			var_61_0:setName("chapter" .. arg_61_1)
			var_61_0:setPressedActionEnabled(true)
			var_61_0:setAnchorPoint(cc.p(0.5, 0))
			var_61_0:setTag(arg_61_1)
			self.chapterlayer:addChild(var_61_0)

			local var_61_1 = cc.Label:createWithTTF("", "fonts/name.ttf", 27)

			var_61_1:setAnchorPoint(cc.p(1, 0.5))
			var_61_1:setPosition(cc.p(var_61_0:getContentSize().width / 2 + 60, var_61_0:getContentSize().height / 2 + 15))
			var_61_1:setName("name")
			var_61_0:addChild(var_61_1)

			local var_61_2 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_0)

			var_61_2:setPosition(cc.p(var_61_0:getContentSize().width / 2 + 120, var_61_0:getContentSize().height / 2 + 25))
			var_61_2:setName("drop")
			var_61_0:addChild(var_61_2)

			local var_61_3 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_0)

			var_61_3:setPosition(cc.p(var_61_2:getContentSize().width / 2, var_61_2:getContentSize().height / 2))
			var_61_3:setName("dropimg")
			var_61_2:addChild(var_61_3)

			local var_61_4 = ccui.ImageView:create("public/box/1.png", var_0_0)

			var_61_4:setVisible(false)
			var_61_4:setTag(arg_61_1)
			var_61_4:setScale(var_61_3:getContentSize().width / var_61_4:getContentSize().width)
			var_61_4:setPosition(cc.p(var_61_0:getContentSize().width / 2 + 120, var_61_0:getContentSize().height / 2 + 25))
			var_61_4:setName("item")
			var_61_0:addChild(var_61_4)
			var_61_4:setTouchEnabled(true)

			local var_61_5 = ccui.ImageView:create("equipment/1000000.png")

			var_61_5:setScale(var_61_4:getContentSize().width / var_61_5:getContentSize().width)
			var_61_5:setPosition(var_61_4:getContentSize().width / 2, var_61_4:getContentSize().height / 2)
			var_61_5:setName("icon")
			var_61_4:addChild(var_61_5)

			local var_61_6 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_0)

			var_61_6:setAnchorPoint(cc.p(0.5, 0))
			var_61_6:setPosition(cc.p(var_61_0:getContentSize().width / 2, var_61_0:getContentSize().height + 15))
			var_61_6:setVisible(false)
			var_61_6:setName("curtag")
			var_61_0:addChild(var_61_6)

			local var_61_7 = ccui.ImageView:create("LevelMap/img_tag_can_patrol.png", var_0_0)

			var_61_7:setAnchorPoint(cc.p(0, 0))
			var_61_7:setPosition(cc.p(35, 80))
			var_61_7:setVisible(false)
			var_61_7:setName("newtag")
			var_61_0:addChild(var_61_7)

			local var_61_8 = ccui.ImageView:create("LevelMap/img_tagcomplete.png", var_0_0)

			var_61_8:setAnchorPoint(cc.p(0, 0))
			var_61_8:setPosition(cc.p(35, 80))
			var_61_8:setVisible(false)
			var_61_8:setName("completetag")
			var_61_0:addChild(var_61_8)

			local var_61_9 = cc.Label:createWithTTF("00:00", "fonts/number.ttf", 25)

			var_61_9:setAnchorPoint(cc.p(0, 0))
			var_61_9:setPosition(cc.p(42, 88))
			var_61_9:setName("timer")
			var_61_0:addChild(var_61_9)

			for iter_61_0 = 1, LEVEL_STARS_NUM do
				local var_61_10 = ccui.ImageView:create("LevelMap/star_gray.png", var_0_0)

				var_61_10:setName("star" .. iter_61_0)
				var_61_10:setPosition(126 + (iter_61_0 - (LEVEL_STARS_NUM + 1) / 2) * 20, 80)
				var_61_0:addChild(var_61_10)
			end

			var_61_0:addTouchEventListener(var_53_0)
			var_61_4:addTouchEventListener(var_53_0)

			arg_61_0[arg_61_1] = var_61_0

			return var_61_0
		end
	})
end

function ActivityLevelLayer:updateCityMapLayer(arg_62_1)
	local var_62_0 = self.curdifficuty or 1
	local var_62_1 = level_manager:getModeByDifficulty(self.curcity, var_62_0)

	self.maplayer:runAction(cc.Sequence:create(cc.Hide:create(), cc.RemoveSelf:create()))

	self.maplayer = ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(self.curcity) .. ".json")

	self:addChild(self.maplayer, var_0_15.MAP)
	self.maplayer:getChildByName("bgframe"):setScaleY(GameDisplay.height / self.maplayer:getChildByName("bgframe"):getContentSize().height)

	local var_62_2 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_62_2:setFlippedX(true)
	var_62_2:setFlippedY(true)
	var_62_2:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_62_2, 1)

	local var_62_3

	if level_manager:isCityUnlocked(self.curcity) then
		if config._DEBUG then
			self.cover = cc.Sprite:create("LevelMap/cover_" .. var_0_18[var_62_0] .. ".png") or cc.Sprite:createWithSpriteFrameName("LevelMap/cover_" .. var_0_18[var_62_0] .. ".png")
		end

		self.cover:setVisible(false)
		self.cover:setAnchorPoint(cc.p(0.5, 0))
		self.cover:setPosition(cc.p(320, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)))
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
		self.cover:setName("colorcover")
		self.maplayer:addChild(self.cover, 1)

		var_62_3 = {}
	end

	for iter_62_0 = 1, math.min(level_manager:getModeTotalChapter(var_62_1), 10) do
		local var_62_4 = self.maplayer:getChildByName("area_" .. iter_62_0)

		self:updateChapters(iter_62_0)

		var_62_3[iter_62_0] = true

		if level_manager:isCityUnlocked(self.curcity) and level_manager:isChapterModeUnlocked(var_62_1, iter_62_0) then
			var_62_4:setVisible(true)
			var_62_4:loadTexture("Maps/" .. var_0_18[var_62_0] .. "point.png")
		else
			var_62_4:setVisible(false)
		end
	end

	self:updateSpecialChapter()
	self:updateActivity()

	for iter_62_1, iter_62_2 in pairs(self.chapters) do
		if not var_62_3[iter_62_1] then
			local var_62_5 = rawget(self.chapters, iter_62_1)

			if var_62_5 then
				var_62_5:setVisible(false)
			end
		end
	end

	if not arg_62_1 then
		self:updateMapLockWord(self.curcity)
	end
end

function ActivityLevelLayer:updateMapLockWord(arg_63_1)
	if level_manager:isCityUnlocked(arg_63_1) then
		self.mapLockWord:setVisible(false)

		return
	end

	self.mapLockWord:setVisible(true)

	if level_manager:isCityLockedByTime(arg_63_1) then
		self.mapLockWord:getChildByName("word"):setString(os.date("%m-%d %H:%M", level_manager:getCityUnlockTime(arg_63_1)) .. L_COMMON_WARNING.Time_Lock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_lock.png", var_0_0)
	elseif level_manager:isCityCanUnlock(arg_63_1) then
		self.mapLockWord:getChildByName("word"):setString(L_MAP_CITY_CHAPTERS.Can_Unlock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
	else
		self.mapLockWord:getChildByName("word"):setString(L_COMMON_WARNING.Locking)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_lock.png", var_0_0)
	end
end

function ActivityLevelLayer:updateCityMapOnSelectDifficulty()
	local var_64_0 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
	local var_64_1

	if self.maplayer:getChildByName("colorcover") then
		if config._DEBUG then
			self.cover:setTexture("LevelMap/cover_" .. var_0_18[self.curdifficuty] .. ".png")
		else
			self.cover:setSpriteFrame("LevelMap/cover_" .. var_0_18[self.curdifficuty] .. ".png")
		end

		self.cover:setScaleX(640 / self.cover:getContentSize().width)

		var_64_1 = {}
	end

	for iter_64_0 = 1, math.min(level_manager:getModeTotalChapter(var_64_0), 10) do
		local var_64_2 = self.maplayer:getChildByName("area_" .. iter_64_0)

		self:updateChapters(iter_64_0)

		var_64_1[iter_64_0] = true

		if level_manager:isChapterModeUnlocked(var_64_0, iter_64_0) then
			var_64_2:setVisible(true)
			var_64_2:loadTexture("Maps/" .. var_0_18[self.curdifficuty] .. "point.png")
		else
			var_64_2:setVisible(false)
		end
	end

	self:updateSpecialChapter()
	self:updateActivity()

	for iter_64_1, iter_64_2 in pairs(self.chapters) do
		if not var_64_1[iter_64_1] then
			local var_64_3 = rawget(self.chapters, iter_64_1)

			if var_64_3 then
				var_64_3:setVisible(false)
			end
		end
	end
end

function ActivityLevelLayer:updateChapters(arg_65_1)
	local var_65_0 = self.curdifficuty or 1

	self.chapters[arg_65_1]:setVisible(true)

	local var_65_1 = level_manager:getModeByDifficulty(self.curcity, var_65_0)
	local var_65_2 = arg_65_1
	local var_65_3, var_65_4 = self.maplayer:getChildByName("area_" .. arg_65_1):getPosition()

	self.chapters[arg_65_1]:setPosition(cc.p(var_65_3, var_65_4 - 20))

	local var_65_5 = level_manager:getChapterStrongholdLv(var_65_1, arg_65_1)
	local var_65_6 = not level_manager:isLevelModeUnlocked(var_65_1) and "LevelMap/level" .. var_65_5 .. "_lock.png" or level_manager:isChapterModeUnlocked(var_65_1, var_65_2) and "LevelMap/level" .. var_65_5 .. "_" .. var_0_18[var_65_0] .. ".png" or "LevelMap/level" .. var_65_5 .. "_lock.png"

	self.chapters[arg_65_1]:loadTextures(var_65_6, var_65_6, var_65_6, var_0_0)

	if var_65_5 == 1 then
		local var_65_7 = self.chapters[arg_65_1]:getChildByName("name"):getTTFConfig()

		var_65_7.fontSize = 27

		self.chapters[arg_65_1]:getChildByName("name"):setTTFConfig(var_65_7)
		self.chapters[arg_65_1]:getChildByName("name"):setString(level_manager:getChapterName(var_65_1, var_65_2))
		self.chapters[arg_65_1]:getChildByName("name"):setPosition(cc.p(self.chapters[arg_65_1]:getContentSize().width / 2 + 56, self.chapters[arg_65_1]:getContentSize().height / 2 + 15))
		self.chapters[arg_65_1]:getChildByName("drop"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("curtag"):setPosition(cc.p(self.chapters[arg_65_1]:getContentSize().width / 2, self.chapters[arg_65_1]:getContentSize().height))
		self.chapters[arg_65_1]:getChildByName("newtag"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("completetag"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("timer"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("item"):setVisible(false)
	else
		local var_65_8 = self.chapters[arg_65_1]:getChildByName("name"):getTTFConfig()

		var_65_8.fontSize = 30

		self.chapters[arg_65_1]:getChildByName("name"):setTTFConfig(var_65_8)
		self.chapters[arg_65_1]:getChildByName("name"):setString(level_manager:getChapterName(var_65_1, var_65_2))
		self.chapters[arg_65_1]:getChildByName("name"):setPosition(cc.p(self.chapters[arg_65_1]:getContentSize().width / 2 + 73, self.chapters[arg_65_1]:getContentSize().height / 2 - 5))
		self.chapters[arg_65_1]:getChildByName("drop"):setVisible(true)
		self.chapters[arg_65_1]:getChildByName("item"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("newtag"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("completetag"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("timer"):setVisible(false)
		self.chapters[arg_65_1]:getChildByName("curtag"):setPosition(cc.p(self.chapters[arg_65_1]:getContentSize().width / 2 + 25, self.chapters[arg_65_1]:getContentSize().height - 20))

		if level_manager:isChapterModeUnlocked(var_65_1, var_65_2) then
			local var_65_9 = level_manager:getChapterStrongholdDrop(var_65_1, var_65_2)

			if var_65_9 then
				self.chapters[arg_65_1]:getChildByName("drop"):setVisible(false)
				self.chapters[arg_65_1]:getChildByName("item"):setVisible(true)

				local var_65_10 = self.chapters[arg_65_1]:getChildByName("item")
				local var_65_11 = var_65_10:getChildByName("icon")

				var_65_10:loadTexture("public/box/" .. item_data[var_65_9].equip_quality .. ".png", var_0_0)
				var_65_11:loadTexture("equipment/" .. item_data[var_65_9].image_id .. ".png")
				var_65_11:setScale(var_65_10:getContentSize().width / var_65_11:getContentSize().width)
			else
				self.chapters[arg_65_1]:getChildByName("drop"):setVisible(true)
			end

			local function var_65_12()
				patrol_manager:isModeCanPatrol(var_65_1, var_65_2, function(arg_67_0)
					if arg_67_0 and ActivityLevelLayer.getInstance() then
						self.chapters[arg_65_1]:getChildByName("newtag"):setVisible(true)
					end
				end)
			end

			if self.timers[var_65_1 .. "-" .. arg_65_1] then
				local var_65_13 = patrol_manager:getPatrolInfo(self.timers[var_65_1 .. "-" .. arg_65_1].key)

				if var_65_13 and var_65_13.time > 0 then
					self.chapters[arg_65_1]:getChildByName("timer"):setVisible(true)
				else
					self.chapters[arg_65_1]:getChildByName("timer"):setVisible(false)

					self.timers[var_65_1 .. "-" .. arg_65_1] = nil

					var_65_12()
				end
			else
				local var_65_14 = var_65_1 .. "-" .. var_65_2
				local var_65_15 = patrol_manager:getPatrolState(var_65_1 .. "-" .. var_65_2)

				if var_65_15 == 3 then
					self.timers[var_65_14] = {
						index = arg_65_1,
						key = var_65_14
					}

					self.chapters[arg_65_1]:getChildByName("timer"):setVisible(true)
				elseif var_65_15 == 2 then
					self.chapters[arg_65_1]:getChildByName("timer"):setVisible(false)
					self.chapters[arg_65_1]:getChildByName("completetag"):setVisible(true)
				else
					self.chapters[arg_65_1]:getChildByName("timer"):setVisible(false)
					var_65_12()
				end
			end
		end
	end

	local var_65_16 = level_manager:getChapterStarsState(var_65_1, var_65_2)

	for iter_65_0 = 1, LEVEL_STARS_NUM do
		local var_65_17 = self.chapters[arg_65_1]:getChildByName("star" .. iter_65_0)

		if var_65_5 == 1 then
			pos_x, pos_y = 90 + (iter_65_0 - (LEVEL_STARS_NUM + 1) / 2) * 20, 75

			var_65_17:setScale(0.83)
		else
			pos_x, pos_y = 110 + (iter_65_0 - (LEVEL_STARS_NUM + 1) / 2) * 25, 82

			var_65_17:setScale(1)
		end

		var_65_17:setPosition(pos_x, pos_y)

		if var_65_16[iter_65_0] then
			var_65_17:loadTexture("LevelMap/star_icon.png", var_0_0)
		else
			var_65_17:loadTexture("LevelMap/star_gray.png", var_0_0)
		end
	end

	self.chapters[arg_65_1]:getChildByName("curtag"):setVisible(var_65_1 == playermodel.curMode and var_65_2 == level_manager:getCurChapter(var_65_1))
end

function ActivityLevelLayer:playSelectCityAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_15.COVER)

	self._playingani = true

	self:removeGuidesOnLayer()
	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.chapterlayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 20)))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateUIInfos()
		self:updateCityMapLayer()
		self:playShowCityAni()
	end)))
end

function ActivityLevelLayer:playShowCityAni()
	if not self.anicover then
		self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), GameDisplay.width, GameDisplay.height)

		self.anicover:setPosition(0, -GameDisplay.fix_y)
		self:addChild(self.anicover, var_0_15.COVER)
	end

	self.anicover:runAction(cc.Sequence:create(cc.FadeOut:create(0.4), cc.RemoveSelf:create()))

	self.anicover = nil

	self.chapterlayer:runAction(cc.MoveBy:create(0.4, cc.p(0, -20)))
	self.maplayer:setPosition(cc.p(0, 8))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, -8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function ActivityLevelLayer:playInitShowAni()
	self.chapterlayer:setVisible(false)
	self.maplayer:setVisible(false)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_15.COVER)

	self._playingani = true

	self.chapterlayer:setPosition(cc.p(0, 20))
	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.chapterlayer:setVisible(true)
		self.maplayer:setVisible(true)
		self:playShowCityAni()
	end)))
end

local var_0_23 = {
	"LevelMap/img_easymode.png",
	"LevelMap/img_hardmode.png",
	"LevelMap/img_hellmode.png",
	"LevelMap/img_nightmaremode.png"
}

function ActivityLevelLayer:playSelectDifficultyAni()
	local var_74_0 = cc.Layer:create()

	self:addChild(var_74_0, var_0_15.COVER)

	local var_74_1

	if config._DEBUG then
		var_74_1 = cc.Scale9Sprite:create("LevelMap/colorcover" .. self.curdifficuty .. ".png") or cc.Scale9Sprite:createWithSpriteFrameName("LevelMap/colorcover" .. self.curdifficuty .. ".png")
	end

	var_74_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_74_1:setPreferredSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_74_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_74_1:setPosition(cc.p(320, 568))
	var_74_1:setOpacity(0)
	var_74_0:addChild(var_74_1)

	local var_74_2

	if config._DEBUG then
		var_74_2 = cc.Sprite:create("LevelMap/img_switchmodebg.png") or cc.Sprite:createWithSpriteFrameName("LevelMap/img_switchmodebg.png")
	end

	var_74_2:setPosition(cc.p(320, 568))
	var_74_0:addChild(var_74_2)

	local var_74_3

	if config._DEBUG then
		var_74_3 = cc.Sprite:create(var_0_23[self.curdifficuty]) or cc.Sprite:createWithSpriteFrameName(var_0_23[self.curdifficuty])
	end

	var_74_3:setPosition(cc.p(320, 568))
	var_74_0:addChild(var_74_3)

	self._playingani = true

	self:removeGuidesOnLayer()
	var_74_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	var_74_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.2)))
	self.chapterlayer:runAction(cc.Sequence:create(cc.MoveBy:create(0.3, cc.p(0, 20)), cc.MoveBy:create(0.2, cc.p(0, -20))))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateCityMapOnSelectDifficulty()
	end)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function ActivityLevelLayer:playExitAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_15.COVER)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.chapterlayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 20)))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)))
end

function ActivityLevelLayer:playUnlockAni(arg_79_1)
	self._playingani = true

	audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/jiesuotexiao.ExportJson")
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/dianwei.ExportJson")
	self.mapLockWord:getChildByName("word"):setVisible(false)
	self.mapLockWord:getChildByName("lockui1"):setVisible(false)
	self.mapLockWord:getChildByName("lockui2"):setVisible(false)
	self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(false)

	local var_79_0 = ccs.Armature:create("jiesuotexiao")

	var_79_0:setPosition(cc.p(320, 568))
	self:addChild(var_79_0, 10)
	var_79_0:getAnimation():play("Animation1")
	var_79_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self:updateUIInfos()
		self:updateCityMapLayer(true)

		self._playingani = false
	end)))
	var_79_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_79_1 = ccs.Armature:create("dianwei")

	var_79_1:setPosition(cc.p(self.chapters[1]:getPositionX(), self.chapters[1]:getPositionY() + 84))
	var_79_1:setVisible(false)
	self:addChild(var_79_1, 10)
	var_79_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8333333333333335), cc.Show:create(), cc.CallFunc:create(function()
		var_79_1:getAnimation():play("Animation1")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if arg_79_1 then
			arg_79_1()
		end
	end), cc.RemoveSelf:create()))
end

function ActivityLevelLayer:playUnlockCityTalk()
	local var_84_0 = level_manager:getUnlockCityTalk(self.curcity)

	if not var_84_0 then
		return
	end

	global_basic_scene:addChild(TalkLayer:create(var_84_0, nil, talktype, "", TALK_TYPE_BEFORE_BOSS, 1), ZORDER_TALKLAYER)
end

function ActivityLevelLayer.loadBasicUIAssets(arg_85_0)
	return
end

function ActivityLevelLayer.unloadBasicUIAssets(arg_87_0)
	return
end

function ActivityLevelLayer.removeGuidesOnLayer(arg_88_0)
	if LayerManager:getCurrentLayerName() ~= "ActivityLevelLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function ActivityLevelLayer.updateGuidesOnLayer(arg_89_0)
	if LayerManager:getCurrentLayerName() ~= "ActivityLevelLayer" then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function ActivityLevelLayer:refreshGuidesOnLevelMap()
	if LayerManager:getCurrentLayerName() ~= "ActivityLevelLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function ActivityLevelLayer:getCurCity()
	return self.curcity
end

function ActivityLevelLayer:initSpecialChapter()
	local var_92_0 = ccui.Button:create("LevelMap/level_sp.png", "LevelMap/level_sp.png", "LevelMap/level_sp.png", var_0_0)

	var_92_0:setVisible(false)
	var_92_0:setName("chapter_sp")
	var_92_0:setPressedActionEnabled(true)
	var_92_0:setAnchorPoint(cc.p(0.5, 0))
	self.chapterlayer:addChild(var_92_0)

	local var_92_1 = cc.Label:createWithTTF(L_SPECIAL_ACTION, "fonts/name.ttf", 27)

	var_92_1:setAnchorPoint(cc.p(0.5, 0))
	var_92_1:setPosition(cc.p(var_92_0:getContentSize().width / 2, var_92_0:getContentSize().height / 2 - 10))
	var_92_1:setName("name")
	var_92_0:addChild(var_92_1)

	local var_92_2 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_0)

	var_92_2:setVisible(false)
	var_92_2:setPosition(cc.p(var_92_0:getContentSize().width / 2 + 120, var_92_0:getContentSize().height / 2 + 25))
	var_92_2:setName("drop")
	var_92_0:addChild(var_92_2)

	local var_92_3 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_0)

	var_92_3:setPosition(cc.p(var_92_2:getContentSize().width / 2, var_92_2:getContentSize().height / 2))
	var_92_3:setName("dropimg")
	var_92_2:addChild(var_92_3)

	local var_92_4 = ccui.ImageView:create("public/box/1.png", var_0_0)

	var_92_4:setVisible(false)
	var_92_4:setScale(var_92_3:getContentSize().width / var_92_4:getContentSize().width)
	var_92_4:setPosition(cc.p(var_92_0:getContentSize().width / 2 + 120, var_92_0:getContentSize().height / 2 + 25))
	var_92_4:setName("item")
	var_92_0:addChild(var_92_4)
	var_92_4:setTouchEnabled(true)

	local var_92_5 = ccui.ImageView:create("equipment/1000000.png")

	var_92_5:setScale(var_92_4:getContentSize().width / var_92_5:getContentSize().width)
	var_92_5:setPosition(var_92_4:getContentSize().width / 2, var_92_4:getContentSize().height / 2)
	var_92_5:setName("icon")
	var_92_4:addChild(var_92_5)

	local var_92_6 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_0)

	var_92_6:setAnchorPoint(cc.p(0.5, 0))
	var_92_6:setPosition(cc.p(var_92_0:getContentSize().width / 2, var_92_0:getContentSize().height + 15))
	var_92_6:setVisible(false)
	var_92_6:setName("curtag")
	var_92_0:addChild(var_92_6)

	local var_92_7 = ccui.ImageView:create("LevelMap/img_tag_can_patrol.png", var_0_0)

	var_92_7:setAnchorPoint(cc.p(0, 0))
	var_92_7:setPosition(cc.p(35, 80))
	var_92_7:setVisible(false)
	var_92_7:setName("newtag")
	var_92_0:addChild(var_92_7)

	local var_92_8 = ccui.ImageView:create("LevelMap/img_tagcomplete.png", var_0_0)

	var_92_8:setAnchorPoint(cc.p(0, 0))
	var_92_8:setPosition(cc.p(35, 80))
	var_92_8:setVisible(false)
	var_92_8:setName("completetag")
	var_92_0:addChild(var_92_8)

	local var_92_9 = cc.Label:createWithTTF("00:00", "fonts/number.ttf", 25)

	var_92_9:setVisible(false)
	var_92_9:setAnchorPoint(cc.p(0, 0))
	var_92_9:setPosition(cc.p(42, 88))
	var_92_9:setName("timer")
	var_92_0:addChild(var_92_9)

	local function var_92_10(arg_93_0, arg_93_1)
		if arg_93_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("::::")
	end

	var_92_0:addTouchEventListener(var_92_10)
	var_92_4:addTouchEventListener(var_92_10)

	self.spchapter = var_92_0
end

function ActivityLevelLayer:updateSpecialChapter()
	local var_94_0 = self.maplayer:getChildByName("area_sp")

	if var_94_0 then
		local var_94_1, var_94_2 = var_94_0:getPosition()

		self.spchapter:setPosition(cc.p(var_94_1 - 7, var_94_2 - 10))
		var_94_0:setVisible(false)
	else
		self.spchapter:setPosition(320, 400)
	end

	self.spchapter.mark_bg = var_94_0

	self.spchapter:setVisible(false)

	if self.spchapter:getChildByName("plotCloneUI") then
		self.spchapter:getChildByName("plotCloneUI"):setVisible(false)
	end

	LayerManager:getPlotObj():levelmapUpdataPlotShow("ActivityLevelLayer" .. self.curcity)
end

function ActivityLevelLayer:initRankUI()
	self.rankBnt = ccui.Button:create("LevelMap/rank_bnt.png", nil, "LevelMap/rank_bnt.png", var_0_0)

	self.rankBnt:setAnchorPoint(cc.p(0, 1))
	self.rankBnt:setPosition(6, GameDisplay.height - GameDisplay.fix_y - self.cityTitle:getContentSize().height - self.starReward:getContentSize().height)
	self.rankBnt:setVisible(self.curdifficuty == 4)
	self.uilayer:addChild(self.rankBnt)
	self.rankBnt:addTouchEventListener(function(arg_96_0, arg_96_1)
		if arg_96_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curdifficuty ~= 4 then
			return
		end

		local var_96_0 = {}

		var_96_0.mode = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 4)

		LayerManager:pushInLayer("LevelRankListLayer", var_96_0)
	end)
end

function ActivityLevelLayer:updateRankUI()
	if self.curdifficuty == 4 then
		self.rankBnt:setVisible(true)
	else
		self.rankBnt:setVisible(false)
	end
end

function ActivityLevelLayer:initStarRewardUI()
	self.starReward = ccui.Button:create("LevelMap/star_reward.png", nil, "LevelMap/star_reward.png", var_0_0)

	self.starReward:setAnchorPoint(cc.p(0, 1))
	self.starReward:setPosition(6, GameDisplay.height - GameDisplay.fix_y - self.cityTitle:getContentSize().height + 30)
	self.uilayer:addChild(self.starReward)

	local var_98_0 = ccui.ImageView:create("LevelMap/star_icon.png", var_0_0)

	var_98_0:setPosition(65, 48)
	self.starReward:addChild(var_98_0)

	local var_98_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label = cc.Label:createWithTTF(level_manager:getModeTotalStars(var_98_1) .. "/" .. level_manager:getModeTotalChapter(var_98_1) * 3, FONT_NAME, 14)

	self.total_star_label:setAnchorPoint(cc.p(0, 0.5))
	self.total_star_label:setPosition(80, 48)
	self.starReward:addChild(self.total_star_label)

	local var_98_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_98_2:setName("reddot")
	var_98_2:setPosition(5, self.starReward:getContentSize().height - 40)
	var_98_2:setVisible(false)
	self.starReward:addChild(var_98_2)
	self.starReward:addTouchEventListener(function(arg_99_0, arg_99_1)
		if arg_99_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			mode = var_98_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_98_1) then
		self.starReward:getChildByName("reddot"):setVisible(true)
	else
		self.starReward:getChildByName("reddot"):setVisible(false)
	end
end

function ActivityLevelLayer:updateStarRewardUI()
	local var_101_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_101_1) .. "/" .. level_manager:getModeTotalChapter(var_101_1) * 3)
	self.starReward:addTouchEventListener(function(arg_102_0, arg_102_1)
		if arg_102_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			mode = var_101_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_101_1) then
		self.starReward:getChildByName("reddot"):setVisible(true)
	else
		self.starReward:getChildByName("reddot"):setVisible(false)
	end
end
