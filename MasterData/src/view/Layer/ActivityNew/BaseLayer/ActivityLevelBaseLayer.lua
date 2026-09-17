ActivityLevelBaseLayer = class("ActivityLevelBaseLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local array_manager = require("controller.array_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local patrol_manager = require("controller.patrol_manager")
local barrage_manager = require("controller.barrage_manager")
local item_data = require("data.item_data")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local CityList = require("view.Sprite.CityList")

require("view.Sprite.ChapterSpriteActivityLevel")

local var_0_13 = {
	LRTIP = 9,
	BASIC = 8,
	LOCKWORD = 5,
	BGFRAME = 2,
	MAPLAYER = 4,
	DIFFICULTYANI = 7,
	BOSSIMG = 3,
	MAP = 0,
	CITYLIST = 6,
	COVER = 1
}
local var_0_14 = {
	NEW = "",
	SELECT = "",
	NORMAL = ""
}
local var_0_15 = "Activities/activity"
local var_0_16 = "CityMap/MiniMap/"
local var_0_17 = "CityMap/Maps/"
local var_0_18 = "CityMap/title/"
local var_0_19 = {
	FREE = 1,
	FORBID = 2,
	LOCKING = 3
}
local var_0_20 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}
local var_0_21 = {
	330,
	215,
	100,
	-15
}
local var_0_22 = 280
local var_0_23 = "roleimage/role/"
local var_0_24 = "ActivityEnterMode"
local var_0_25 = "initcitytype"
local var_0_26 = "initcity"
local var_0_27 = "initdifficulty"
local var_0_28
local var_0_29

function ActivityLevelBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLevelBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLevelBaseLayer.getInstance()
	return var_0_28
end

function ActivityLevelBaseLayer:getExitParam()
	return {
		initcitytype = cloneconf(self.initcitytype),
		initcity = cloneconf(self.curcity),
		initdifficulty = cloneconf(self.curdifficuty)
	}
end

function ActivityLevelBaseLayer:init(arg_5_1)
	var_0_28 = self
	self._playingani = false

	print("initLevelMapLayer: ", dump(arg_5_1))

	if arg_5_1 and arg_5_1.initcity ~= nil then
		self.initcitytype = arg_5_1.activityid
		self.initcity = arg_5_1.initcity
		self.initdifficulty = arg_5_1.initdifficulty
	else
		self.initcitytype = arg_5_1.activityid

		local var_5_0 = RoleDefault:getInstance():getIntegerForKey(var_0_24 .. self.initcitytype, -1)

		if var_5_0 == -1 then
			self.initcity = level_manager:getMaxActivityCity(self.initcitytype)
			self.initdifficulty = level_manager:getUnlockedDifficultyInCity(self.initcity)
		else
			self.initcity = level_manager:getCityByMode(var_5_0)
			self.initdifficulty = level_manager:getDifficultByMode(var_5_0)
		end
	end

	self.initcitytype = self.initcitytype or var_0_29
	var_0_29 = self.initcitytype
	self.resourcePath = var_0_15 .. self.initcitytype .. "/levelmap/"
	self.initCityTypeSavePath = var_0_25 .. self.initcitytype
	self.initCitySavePath = var_0_26 .. self.initcitytype
	self.initDifficultySavePath = var_0_27 .. self.initcitytype
	self.difficutyPath = {
		self.resourcePath .. "img_easymode.png",
		self.resourcePath .. "img_hardmode.png",
		self.resourcePath .. "img_hellmode.png",
		self.resourcePath .. "img_nightmaremode.png"
	}

	level_manager:updateAdventureDetailInfo(self.initCityTypeSavePath, self.initcitytype)
	level_manager:updateAdventureDetailInfo(self.initCitySavePath, self.initcity)
	level_manager:updateAdventureDetailInfo(self.initDifficultySavePath, self.initdifficulty)
	patrol_manager:reset()
	self:initTimers()
	level_manager:getModesLockState(function()
		self:initUINode()
		self:initCityMapLayer()
		self:playInitShowAni()
		self:fullScreen()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "enter" then
			-- block empty
		elseif arg_7_0 == "exit" then
			var_0_28 = false

			TextureManager:removeLayerTextures({
				"Activities_activity" .. self.initcitytype .. "_levelmap"
			})
		end
	end)
end

function ActivityLevelBaseLayer:initUINode()
	TextureManager:loadLayerTextures({
		"Activities_activity" .. self.initcitytype .. "_levelmap"
	})

	local var_8_0 = level_manager:getActivityLevelMapJson(self.initcity)

	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (var_8_0 .. ".json" or var_8_0 .. ".ExportJson"))

	self:addChild(self.uilayer)

	self.bgNode = self.uilayer:getChildByName("bg")
	self.starReward = self.uilayer:getChildByName("btn_starReward")
	self.total_star_label = self.starReward:getChildByName("num")
	self.starRewardRedDot = self.starReward:getChildByName("redDot")
	self.btn_buff = self.uilayer:getChildByName("btn_buff")

	local var_8_1 = self.resourcePath .. "activityBuff" .. self.initcity .. ".png"

	if self.initcity == 83822 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") then
		var_8_1 = self.resourcePath .. "activityBuff" .. self.initcity .. "_replace.png"
	end

	if self.initcity == 86523 or self.initcity == 86524 then
		if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") then
			var_8_1 = self.resourcePath .. "activityBuff" .. self.initcity .. "_replace.png"
		end
	end

	self.btn_buff:loadTextures(var_8_1, var_8_1, var_8_1, var_0_0)
	self.total_star_label:setPositionX(self.total_star_label:getPositionX() - 15)

	self.cityTitle = ccui.Helper:seekWidgetByName(self.uilayer, "title")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.uilayer, "btn_return")
	self.panelDifficulty = self.uilayer:getChildByName("panel_difficulty")

	self.panelDifficulty:setPositionX(var_0_22)
	self.panelDifficulty:setVisible(#level_manager:getCityDifficulties(self.initcity) > 1)

	if self.initcitytype and self.initcitytype == 230 then
		self.cityTitle:setTouchEnabled(true)
		self.cityTitle:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityDetail", {
				key = "activity_level_base_layer_230"
			})
		end)
	end

	self.btnReturn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		self:playExitAni()
	end)
	self.btn_buff:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopUmaruScoreUpLayer", {
			curcity = self.curcity
		})
	end)

	for iter_8_0 = 1, #var_0_20 do
		local var_8_2 = self.panelDifficulty:getChildByName("btn_" .. var_0_20[iter_8_0])
		local var_8_3, var_8_4 = var_8_2:getPosition()

		var_8_2:setPositionY(60)
		var_8_2:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if level_manager:isCityNewDifficulty(self.curcity, iter_8_0) then
				level_manager:unMarkModeNew(level_manager:getModeByDifficulty(self.curcity, iter_8_0))
				self:updateDifficutyTips(self.curcity, iter_8_0)
				self:updateCityBntTips(self.curcity)
			end

			if iter_8_0 == self.curdifficuty then
				return
			end

			if self._playingani then
				return
			end

			self:selectDifficulty(iter_8_0)
		end)
	end

	self:initCityList()
	self:initUIInfos()
end

function ActivityLevelBaseLayer:fullScreen()
	self.uilayer:setPosition(cc.p(0, -GameDisplay.fix_y))

	self.panelDifficulty.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.panelDifficulty:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.panelDifficulty:setPositionY(self.panelDifficulty.full_posY)

	self.cityTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.cityTitle:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cityTitle:setPositionY(self.cityTitle.full_posY)

	self.starReward.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.starReward:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.starReward:setPositionY(self.starReward.full_posY)

	self.btnReturn.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btnReturn:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btnReturn:setPositionY(self.btnReturn.full_posY)

	self.cityList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityList:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cityList:setPositionY(self.cityList.full_posY)

	self.cityListMask.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityListMask:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.cityListMask:setPositionY(self.cityListMask.full_posY)

	self.chapterTV.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.chapterTV:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.chapterTV:setPositionY(self.chapterTV.full_posY)

	local var_13_0 = ccui.Helper:seekWidgetByName(self.uilayer, "di")

	var_13_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_13_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_13_0:setPositionY(var_13_0.full_posY)
	self.bgNode:setPositionY(GameDisplay.height / 2)
end

local function var_0_30(arg_14_0)
	if arg_14_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_14_0 / 3600), math.floor(arg_14_0 % 3600 / 60), arg_14_0 % 60)
	else
		return string.format("%02d:%02d", math.floor(arg_14_0 / 60), arg_14_0 % 60)
	end
end

function ActivityLevelBaseLayer:initTimers()
	self.timers = {}

	local var_15_0 = 1

	self:scheduleUpdateWithPriorityLua(function(arg_16_0)
		var_15_0 = var_15_0 + arg_16_0

		if var_15_0 > 1 then
			local var_16_0

			for iter_16_0, iter_16_1 in pairs(self.timers) do
				var_16_0 = patrol_manager:getPatrolInfo(iter_16_1.key)

				if var_16_0 then
					-- block empty
				else
					self.timers[iter_16_0] = nil
				end
			end

			if var_16_0 then
				self.updatePatrolTime = true

				self:updateShowingCells()

				self.updatePatrolTime = false
			end

			var_15_0 = var_15_0 - 1
		end
	end, 1)
end

function ActivityLevelBaseLayer.cleanAllTimers(arg_17_0)
	arg_17_0.timers = {}
end

function ActivityLevelBaseLayer.changeTheCityList(arg_18_0, arg_18_1)
	return arg_18_1
end

function ActivityLevelBaseLayer:initCityList()
	self.cityList = CityList:create()
	self.cityListMask = CityList:create()

	self.cityListMask:setPosition(cc.p(112, 64))
	self.cityListMask:setTouchEnabled(true)
	self.uilayer:addChild(self.cityListMask, 1)
	self.cityList:setPosition(cc.p(112, 64))
	self.uilayer:addChild(self.cityList, 1)

	self.curcity = nil
	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local var_19_0 = self:changeTheCityList(level_manager:getActivityCityListById(self.initcitytype))

	local function var_19_1(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_20_0:getTouchBeganPosition().x - arg_20_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_20_0:getTag())

		for iter_20_0, iter_20_1 in ipairs(var_19_0) do
			self:updateCityBntTips(iter_20_1)
		end
	end

	local function var_19_2(arg_21_0)
		local var_21_0 = var_0_16 .. "country" .. arg_21_0 .. ".png"

		if arg_21_0 == 83822 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") then
			var_21_0 = var_0_16 .. "country" .. arg_21_0 .. "_replace.png"
		end

		if arg_21_0 == 86523 or arg_21_0 == 86524 then
			if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") then
				var_21_0 = var_0_16 .. "country" .. arg_21_0 .. "_replace.png"
			end
		end

		local var_21_1 = ccui.Button:create(var_21_0, nil, var_21_0)

		var_21_1:setName("city" .. arg_21_0)

		var_21_1.areaid = arg_21_0 % self.initcitytype

		local var_21_2 = cc.Sprite:create(var_0_16 .. level_manager:getCityImg(arg_21_0) .. ".png")

		var_21_2:setPosition(cc.p(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height / 2))
		var_21_2:setName("minimap")
		var_21_2:setVisible(false)
		var_21_1:addChild(var_21_2, -1)

		local var_21_3 = ccui.ImageView:create(var_0_14.SELECT, var_0_0)

		var_21_3:setPosition(cc.p(var_21_1:getContentSize().width / 2, var_21_1:getContentSize().height / 2))
		var_21_3:setName("frame")
		var_21_3:setVisible(false)
		var_21_1:addChild(var_21_3, 2)

		if not level_manager:isCityUnlocked(arg_21_0) then
			l2utils:shaderGrayDark(var_21_1:getVirtualRenderer())
			l2utils:shaderGrayDark(var_21_2)

			if not level_manager:isCityCanUnlock(arg_21_0) then
				l2utils:shaderNode(var_21_3:getVirtualRenderer())
			end
		else
			l2utils:shaderDarkNode(var_21_1:getVirtualRenderer())
			l2utils:shaderDarkNode(var_21_2)
		end

		var_21_1:addTouchEventListener(var_19_1)

		return var_21_1
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_3 = var_19_2(iter_19_1)

		self.cityList:pushInCity(var_19_3)

		self.cities[iter_19_1] = var_19_3
		self.index_to_city[var_19_3:getTag()] = iter_19_1
		self.city_to_index[iter_19_1] = var_19_3:getTag()
	end

	if #var_19_0 <= 1 then
		self.cityList:setVisible(false)
	else
		self.cityList:setVisible(true)
	end

	self.cityList:registerSelectCityHandler(function(arg_22_0)
		if self.curcity == self.index_to_city[arg_22_0] then
			return
		end

		self:updateCityOnUnSelect(self.curcity)

		self.curcity = self.index_to_city[arg_22_0]

		level_manager:updateAdventureDetailInfo(self.initCitySavePath, self.curcity)
		self:updateMapJsonInfo()
		self:updateCityOnSelect(self.curcity)
		self:playSelectCityAni()

		for iter_22_0, iter_22_1 in ipairs(var_19_0) do
			self:updateCityBntTips(iter_22_1)
		end
	end)

	self.curcity = self.initcity

	self:updateBtnBuffStatus()
	level_manager:updateAdventureDetailInfo(self.initCitySavePath, self.curcity)
	self:updateMapJsonInfo()
	print("self.curmapjsonchapternum", self.curmapjsonchapternum)
	self:updateCityOnSelect(self.curcity)
	self.cityTitle:loadTexture(var_0_18 .. "country" .. self.curcity .. "_" .. self.initdifficulty .. ".png")
	self.cityList:jumpToIndex(self.city_to_index[self.curcity])

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		self:updateCityBntTips(iter_19_3)
	end
end

function ActivityLevelBaseLayer:updateBtnBuffStatus()
	local var_23_0 = self.btn_buff:getChildByName("buffDisable")

	if var_23_0 == nil then
		var_23_0 = ccui.Layout:create()

		var_23_0:setTouchEnabled(true)
		var_23_0:setName("buffDisable")
		self.btn_buff:addChild(var_23_0)
		var_23_0:setContentSize(self.btn_buff:getContentSize())
	end

	var_23_0:setVisible(level_manager:isDisableBuff(self.curcity or self.initcity))
end

function ActivityLevelBaseLayer:updateCityBntTips(arg_24_1)
	local var_24_0 = self.cities[arg_24_1]
	local var_24_1 = self.cities[arg_24_1]:getChildByName("frame")

	local function var_24_2()
		return self.city_to_index[arg_24_1] - self.city_to_index[self.curcity] == -1
	end

	local var_24_3 = 0
	local var_24_4 = 45
	local var_24_7 = 3
	local var_24_8 = self.cityList:getCityBtnDirection(arg_24_1)

	if level_manager:isCityCanUnlock(arg_24_1) and var_24_8 == var_24_7 then
		if not var_24_0:getChildByName("newtag") then
			var_24_1:loadTexture(var_0_14.NEW, var_0_0)
			var_24_1:setVisible(true)

			local var_24_9 = ccui.ImageView:create(self.resourcePath .. "img_tagnew.png", var_0_0)

			var_24_9:setAnchorPoint(cc.p(0.5, 0))

			if var_24_2() then
				var_24_9:setPosition(cc.p(150 - var_24_4, 100 + var_24_3))
			else
				var_24_9:setPosition(cc.p(150, 100))
			end

			var_24_9:setName("newtag")
			var_24_0:addChild(var_24_9)
		elseif var_24_2() then
			var_24_0:getChildByName("newtag"):setPosition(cc.p(150 - var_24_4, 100 + var_24_3))
		else
			var_24_0:getChildByName("newtag"):setPosition(cc.p(150, 100))
		end
	elseif var_24_0:getChildByName("newtag") then
		var_24_0:removeChildByName("newtag")
	end

	if patrol_manager:isCityFinishedPatrol(arg_24_1) and var_24_8 == var_24_7 then
		if not var_24_0:getChildByName("reddot") then
			local var_24_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_24_10:setAnchorPoint(cc.p(1, 1))

			if var_24_2() then
				var_24_10:setPosition(var_24_0:getContentSize().width - 10 - var_24_4, var_24_0:getContentSize().height + 18 + var_24_3)
			else
				var_24_10:setPosition(var_24_0:getContentSize().width - 10, var_24_0:getContentSize().height + 18)
			end

			var_24_10:setName("reddot")
			var_24_0:addChild(var_24_10, 9)
		elseif var_24_2() then
			var_24_0:getChildByName("reddot"):setPosition(var_24_0:getContentSize().width - 10 - var_24_4, var_24_0:getContentSize().height + 18 + var_24_3)
		else
			var_24_0:getChildByName("reddot"):setPosition(var_24_0:getContentSize().width - 10, var_24_0:getContentSize().height + 18)
		end
	elseif var_24_0:getChildByName("reddot") then
		var_24_0:removeChildByName("reddot")
	end

	if level_manager:isCityNewDifficulty(arg_24_1) and var_24_8 == var_24_7 then
		if not var_24_0:getChildByName("newDifficultyTips") then
			local var_24_11 = ccui.ImageView:create(self.resourcePath .. "img_tagnew.png", var_0_0)

			var_24_11:setAnchorPoint(cc.p(0.5, 0))

			if var_24_2() then
				var_24_11:setPosition(cc.p(150 - var_24_4, 100 + var_24_3))
			else
				var_24_11:setPosition(cc.p(150, 100))
			end

			var_24_11:setName("newDifficultyTips")
			var_24_0:addChild(var_24_11)
		elseif var_24_2() then
			var_24_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150 - var_24_4, 100 + var_24_3))
		else
			var_24_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150, 100))
		end
	elseif var_24_0:getChildByName("newDifficultyTips") then
		var_24_0:removeChildByName("newDifficultyTips")
	end

	if level_manager:checkIsNewStarRewardInCity(arg_24_1) and var_24_8 == var_24_7 then
		if not var_24_0:getChildByName("newStarTips") then
			local var_24_12 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_24_12:setAnchorPoint(cc.p(1, 1))

			if var_24_2() then
				var_24_12:setPosition(var_24_0:getContentSize().width - 10 - var_24_4, var_24_0:getContentSize().height + 18 + var_24_3)
			else
				var_24_12:setPosition(var_24_0:getContentSize().width - 10, var_24_0:getContentSize().height + 18)
			end

			var_24_12:setName("newStarTips")
			var_24_0:addChild(var_24_12, 9)
		elseif var_24_2() then
			var_24_0:getChildByName("newStarTips"):setPosition(var_24_0:getContentSize().width - 10 - var_24_4, var_24_0:getContentSize().height + 18 + var_24_3)
		else
			var_24_0:getChildByName("newStarTips"):setPosition(var_24_0:getContentSize().width - 10, var_24_0:getContentSize().height + 18)
		end
	else
		local var_24_13
		local var_24_14

		if var_24_0:getChildByName("newStarTips") then
			var_24_0:removeChildByName("newStarTips")

			var_24_13 = var_24_8 == var_24_7
			var_24_14 = ipairs
		end
	end

	for iter_24_0, iter_24_1 in var_24_14({
		"newDifficultyTips",
		"reddot",
		"newPatrolTips",
		"newStarTips"
	}) do
		if var_24_0:getChildByName(iter_24_1) then
			var_24_0:getChildByName(iter_24_1):setVisible(var_24_13)

			var_24_13 = false
		end
	end
end

function ActivityLevelBaseLayer:getCityByID(arg_26_1)
	return self.cities[arg_26_1]
end

function ActivityLevelBaseLayer:getCityByIndex(arg_27_1)
	return self.cities[self.index_to_city[arg_27_1]]
end

function ActivityLevelBaseLayer:updateCityOnSelect(arg_28_1)
	print(arg_28_1)

	local var_28_0 = self:getCityByID(arg_28_1)

	if level_manager:isCityUnlocked(arg_28_1) then
		l2utils:recoverShader(var_28_0:getVirtualRenderer())
		l2utils:recoverShader(var_28_0:getChildByName("minimap"))
	else
		l2utils:shaderNode(var_28_0:getVirtualRenderer())
		l2utils:shaderNode(var_28_0:getChildByName("minimap"))
	end

	var_28_0:getChildByName("frame"):setVisible(true)

	if not level_manager:isCityCanUnlock(arg_28_1) then
		var_28_0:getChildByName("frame"):loadTexture(var_0_14.SELECT, var_0_0)
	end

	self:playCityFrameBreath(arg_28_1)
end

function ActivityLevelBaseLayer:updateCityOnUnSelect(arg_29_1)
	local var_29_0 = self:getCityByID(arg_29_1)

	if level_manager:isCityUnlocked(arg_29_1) then
		l2utils:shaderDarkNode(var_29_0:getVirtualRenderer())
		l2utils:shaderDarkNode(var_29_0:getChildByName("minimap"))
	else
		l2utils:shaderGrayDark(var_29_0:getVirtualRenderer())
		l2utils:shaderGrayDark(var_29_0:getChildByName("minimap"))
	end

	if not level_manager:isCityCanUnlock(arg_29_1) then
		var_29_0:getChildByName("frame"):setVisible(false)
	end

	self:stopCityFrameBreath(arg_29_1)
end

function ActivityLevelBaseLayer:updateCityOnUnlock()
	local var_30_0 = self:getCityByID(self.curcity)

	l2utils:recoverShader(var_30_0:getVirtualRenderer())
	l2utils:recoverShader(var_30_0:getChildByName("minimap"))

	if var_30_0:getChildByName("newtag") then
		var_30_0:removeChildByName("newtag")
	end

	var_30_0:getChildByName("frame"):loadTexture(var_0_14.SELECT, var_0_0)
end

function ActivityLevelBaseLayer.playCityFrameBreath(arg_31_0, arg_31_1)
	return
end

function ActivityLevelBaseLayer.stopCityFrameBreath(arg_32_0, arg_32_1)
	return
end

function ActivityLevelBaseLayer:initUIInfos()
	local var_33_0 = self.initdifficulty and level_manager:isOnlyCityDifficultyValid(self.curcity, self.initdifficulty) and self.initdifficulty or 1

	self.curdifficuty = var_33_0
	self.finaldifficuty = var_33_0

	level_manager:updateAdventureDetailInfo(self.initDifficultySavePath, self.curdifficuty)
	self:updateDifficutyPanel()
	self:initStarRewardUI()
end

function ActivityLevelBaseLayer:updateUIInfos()
	if level_manager:isCityUnlocked(self.curcity) then
		if self.finaldifficuty then
			local var_34_0 = level_manager:getCityDifficulties(self.curcity)
			local var_34_1 = 1

			for iter_34_0 = 1, 4 do
				if var_34_0[iter_34_0] and var_34_0[iter_34_0].stat then
					var_34_1 = iter_34_0
				end
			end

			self.curdifficuty = var_34_1 < self.finaldifficuty and var_34_1 or self.finaldifficuty
		else
			self.curdifficuty = self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or 1
			self.finaldifficuty = self.curdifficuty
		end
	else
		self.curdifficuty = 1
	end

	level_manager:updateAdventureDetailInfo(self.initDifficultySavePath, self.curdifficuty)
	self:updateDifficutyPanel()
	self:updateStarRewardUI()

	local var_34_2 = self.resourcePath .. "activityBuff" .. self.curcity .. ".png"

	if self.curcity == 83822 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") then
		var_34_2 = self.resourcePath .. "activityBuff" .. self.curcity .. "_replace.png"
	end

	if self.curcity == 86523 or self.curcity == 86524 then
		if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") then
			var_34_2 = self.resourcePath .. "activityBuff" .. self.curcity .. "_replace.png"
		end
	end

	self.btn_buff:loadTextures(var_34_2, var_34_2, var_34_2, var_0_0)
end

function ActivityLevelBaseLayer.initPanelDifficulty(arg_35_0)
	return
end

function ActivityLevelBaseLayer:selectDifficulty(arg_36_1)
	self.curdifficuty = arg_36_1
	self.finaldifficuty = arg_36_1

	level_manager:updateAdventureDetailInfo(self.initDifficultySavePath, self.curdifficuty)
	self:updateDifficutyPanel()
	self:updateStarRewardUI()
	self:playSelectDifficultyAni()
end

function ActivityLevelBaseLayer:updateDifficutyPanel()
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in ipairs((level_manager:getCityDifficulties(self.curcity))) do
		local var_37_1 = self.panelDifficulty:getChildByName("btn_" .. var_0_20[iter_37_0])

		var_37_1:setVisible(true)

		local var_37_2 = iter_37_0 == self.curdifficuty and self.resourcePath .. "btn_" .. var_0_20[iter_37_0] .. ".png" or self.resourcePath .. "btn_" .. var_0_20[iter_37_0] .. "_off.png"

		var_37_1:loadTextures(var_37_2, nil, var_37_2, var_0_0)

		var_37_0 = var_37_0 + 1

		self:updateDifficutyTips(self.curcity, iter_37_0)
	end

	for iter_37_2 = 1, var_37_0 do
		local var_37_3 = self.panelDifficulty:getChildByName("btn_" .. var_0_20[iter_37_2])
		local var_37_4, var_37_5 = var_37_3:getPosition()

		var_37_3:setVisible(true)
		var_37_3:setPositionX(var_0_21[var_37_0 + 1 - iter_37_2])
	end

	for iter_37_3 = var_37_0 + 1, 4 do
		-- block empty
	end

	if var_37_0 == 1 then
		-- block empty
	end
end

function ActivityLevelBaseLayer:updateDifficutyTips(arg_38_1, arg_38_2)
	local var_38_0 = self.panelDifficulty:getChildByName("btn_" .. var_0_20[arg_38_2])
	local var_38_1 = {}

	if patrol_manager:isCityFinishedPatrol(arg_38_1, arg_38_2) then
		if not var_38_0:getChildByName("reddot") then
			local var_38_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_38_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_38_2:setPosition(var_38_0:getContentSize().width, var_38_0:getContentSize().height)
			var_38_2:setName("reddot")
			var_38_0:addChild(var_38_2)
		else
			var_38_0:getChildByName("reddot"):setVisible(true)
		end

		if self.curdifficuty == arg_38_2 then
			var_38_0:getChildByName("reddot"):setVisible(false)
		end

		var_38_1.reddot = true
	elseif var_38_0:getChildByName("reddot") then
		var_38_0:getChildByName("reddot"):setVisible(false)
	end

	if level_manager:isCityNewDifficulty(arg_38_1, arg_38_2) then
		if not var_38_0:getChildByName("newDifficultyTips") then
			local var_38_3 = ccui.ImageView:create(self.resourcePath .. "img_tagnew.png", var_0_0)

			var_38_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_38_3:setPosition(cc.p(var_38_0:getContentSize().width - 20, var_38_0:getContentSize().height))
			var_38_3:setName("newDifficultyTips")
			var_38_0:addChild(var_38_3)
		else
			var_38_0:getChildByName("newDifficultyTips"):setVisible(true)
		end

		var_38_1.newDifficultyTips = true
	elseif var_38_0:getChildByName("newDifficultyTips") then
		var_38_0:getChildByName("newDifficultyTips"):setVisible(false)
	end

	if self.curdifficuty ~= arg_38_2 then
		local var_38_4 = true

		for iter_38_0, iter_38_1 in ipairs({
			"newDifficultyTips",
			"reddot",
			"newPatrolTips"
		}) do
			if var_38_0:getChildByName(iter_38_1) and var_38_1[iter_38_1] then
				var_38_0:getChildByName(iter_38_1):setVisible(var_38_4)

				var_38_4 = false
			end
		end
	end
end

function ActivityLevelBaseLayer:initCityMapLayer()
	local var_39_0 = self.initcity or level_manager:getCurFightCity()
	local var_39_2 = level_manager:getModeByDifficulty(var_39_0, self.initdifficulty and level_manager:isOnlyCityDifficultyValid(var_39_0, self.initdifficulty) and self.initdifficulty or 1)
	local var_39_3 = level_manager:getCityConf(var_39_0)

	self.bgNode:loadTexture(var_0_17 .. "Map_" .. var_39_0 .. ".png")

	if var_39_0 == 83822 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") then
		self.bgNode:loadTexture(var_0_17 .. "Map_" .. var_39_0 .. "_replace.png")
	end

	if var_39_0 == 86523 or var_39_0 == 86524 then
		if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") then
			self.bgNode:loadTexture(var_0_17 .. "Map_" .. var_39_0 .. "_replace.png")
		end
	end

	self.maplayer = ccui.Layout:create()

	self.maplayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.maplayer:setAnchorPoint(cc.p(0, 0))
	self.maplayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.maplayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.maplayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.uilayer:addChild(self.maplayer)
	self:initCityTableView()
	self:updateShowingCells()
	self:scrollTableView()
end

local var_0_31 = 660
local var_0_32 = 1136 + GameDisplay.fix_y * 2 - 320 + 140
local var_0_33 = -14
local var_0_34 = 82
local var_0_35 = 660
local var_0_36 = 745
local var_0_37 = 100 * (GameDisplay.fix_y / 174) + 100
local var_0_38 = 100 * (GameDisplay.fix_y / 174) + 100

function ActivityLevelBaseLayer:initCityTableView()
	local function var_40_0(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		local var_41_0 = self.curcity
		local var_41_1 = self.curdifficuty
		local var_41_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
		local var_41_3 = arg_41_0.chapter
		local var_41_4 = var_0_19.FREE

		if not level_manager:isChapterModeUnlocked(var_41_2, arg_41_0.chapter) then
			var_41_4 = var_0_19.FORBID
		elseif not level_manager:isChapterModeValid(var_41_2, var_41_3) then
			var_41_4 = var_0_19.LOCKING
		end

		for iter_41_0 = 1, level_manager:getModeTotalChapter(var_41_2) do
			local var_41_5 = self.chapterTV:cellAtIndex(iter_41_0 - 1)

			if var_41_5 then
				for iter_41_1 = 1, self.curmapjsonchapternum do
					local var_41_6 = var_41_5:getChildByName("sp_" .. iter_41_1)
					local var_41_7 = var_41_6:getChildByName("curtag")
					local var_41_8 = var_41_6:getChildByName("biling")

					if var_41_6.chapter == var_41_3 then
						var_41_7:setVisible(true)
						var_41_8:setVisible(true)
					else
						var_41_7:setVisible(false)
						var_41_8:setVisible(false)
					end
				end
			end
		end

		if patrol_manager:getPatrolInfo(var_41_2 .. "-" .. var_41_3) then
			LayerManager:pushInLayer("PatrolPopLayer", {
				inittype = 2,
				mode = var_41_2,
				chapter = var_41_3,
				callback = function()
					self:updateShowingCells()
					self:updateCityBntTips(var_41_0, var_41_1)
					self:updateDifficutyTips(var_41_0, var_41_1)
				end
			})
		else
			local function var_41_9(arg_43_0)
				print(arg_43_0)

				if arg_43_0 == 1 then
					AnalyticManager.click_bosstower()
					LayerManager:switchShowLayer("FightLayer", {
						is_hide_topcost = true,
						is_hide_listbutton = true
					})
					FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
				else
					if arg_43_0 == 2 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[2])
					elseif arg_43_0 == 3 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(level_manager:getModeUnlockMsg(var_41_2, 3))
					elseif arg_43_0 == 4 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[4])
					elseif arg_43_0 == 5 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[5])
					elseif arg_43_0 == 6 then
						audio_manager:playeffectMusicTest("sound/invalid")

						if chapter_data["" .. var_41_2 .. "-" .. var_41_3] and chapter_data["" .. var_41_2 .. "-" .. var_41_3].boss_combat then
							global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_41_2 .. "-" .. var_41_3].boss_combat .. L_ADVENTURE_WARNING[7])
						end
					end

					GuideListener.showAllGuidesWithFullScreen(true)
				end
			end

			local function var_41_10(arg_44_0)
				local function var_44_0()
					GuideListener.showAllGuidesWithFullScreen(false)
					array_manager:resetHangupArray(arg_44_0)
					RoleDefault:getInstance():setIntegerForKey("activityarray", arg_44_0)
					RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_44_0)
					RoleDefault:getInstance():setIntegerForKey(var_0_24 .. (self.initcitytype or var_0_29), var_41_2)
					RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", levelmode_data[var_41_2].modetype)
					level_manager:switchToAdventureMode(var_41_2, var_41_3, var_41_9, arg_44_0)
				end

				if chapter_data[var_41_2 .. "-" .. var_41_3].classification and var_41_3 >= playermodel.levelmode[var_41_2].status then
					global_basic_scene:addChild(TalkLayer:create(chapter_data[var_41_2 .. "-" .. var_41_3].classification, nil, TALK_TYPE_BEFORE_BOSS, "", var_44_0, 1), ZORDER_TALKLAYER)
				else
					var_44_0()
				end
			end

			local var_41_11 = RoleDefault:getInstance():getIntegerForKey("activityarray", 1)
			local var_41_12 = chapter_data[var_41_2 .. "-" .. var_41_3].classification
			local var_41_13 = false
			local var_41_14

			if chapter_data[var_41_2 .. "-" .. var_41_3].classification and var_41_3 < playermodel.levelmode[var_41_2].status then
				var_41_13 = true
				var_41_14 = {
					fight_type = "ADVENTURE",
					isUmaru = true,
					level = 1,
					mode = var_41_2,
					chapter = var_41_3,
					callback = function()
						return
					end,
					adventuresurecallback = function()
						require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", {
							initindex = var_41_11,
							mode = var_41_2,
							configcallback = var_41_10,
							exitcallback = callback
						})
					end,
					initindex = var_41_11,
					curChapterStatus = var_41_4,
					can_reload_talklayer = var_41_13
				}
			end

			function var_41_14.reload_talklayer_func()
				global_basic_scene:addChild(TalkLayer:create(var_41_12, nil, TALK_TYPE_BEFORE_BOSS, "", function()
					return
				end, 1), ZORDER_TALKLAYER)
			end

			LayerManager:pushInLayer("LevelDetailLayer", var_41_14)
		end
	end

	local function var_40_1(arg_50_0, arg_50_1)
		if level_manager:isChapterModeUnlocked(arg_50_0, arg_50_1) then
			if self.timers[arg_50_0 .. "-" .. arg_50_1] then
				local var_50_0 = patrol_manager:getPatrolInfo(self.timers[arg_50_0 .. "-" .. arg_50_1].key)

				if var_50_0 and var_50_0.time > 0 then
					-- block empty
				else
					self.timers[arg_50_0 .. "-" .. arg_50_1] = nil
				end
			else
				local var_50_1 = arg_50_0 .. "-" .. arg_50_1

				if patrol_manager:getPatrolState(arg_50_0 .. "-" .. arg_50_1) == 3 then
					self.timers[var_50_1] = {
						index = index,
						key = var_50_1
					}
				end
			end
		end
	end

	self.chapterTV = cc.TableView:create(cc.size(var_0_31, var_0_32))

	self.chapterTV:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.chapterTV:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	self.chapterTV:setPosition(cc.p(var_0_33, var_0_34))
	self.chapterTV:setDelegate()
	self.maplayer:addChild(self.chapterTV, 2)
	self.chapterTV:registerScriptHandler(function(arg_51_0, arg_51_1)
		if arg_51_1 == 0 then
			return var_0_35, self.levelmapcellheight + var_0_37
		elseif arg_51_1 + 1 == math.ceil(self.chapterTV.totalChapters / self.curmapjsonchapternum) then
			return var_0_35, self.levelmapcellheight + var_0_38
		else
			return var_0_35, self.levelmapcellheight
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.chapterTV:registerScriptHandler(function(arg_52_0, arg_52_1)
		local var_52_0 = arg_52_0:dequeueCell()

		if not var_52_0 then
			var_52_0 = cc.TableViewCell:create()

			var_52_0:setName("cell_" .. arg_52_1)
		end

		;(function(...)
			for iter_53_0 = 1, self.curmapjsonchapternum do
				if not var_52_0:getChildByName("sp_" .. iter_53_0) then
					local var_53_0 = ChapterSpriteActivityLevel:create({
						initcitytype = self.initcitytype
					})

					var_53_0:_setSwallowTouches(false)
					var_53_0:setName("sp_" .. iter_53_0)
					var_52_0:addChild(var_53_0, 10)
					var_53_0:_addTouchEventListener(var_40_0)
				else
					local var_53_1 = var_52_0:getChildByName("sp_" .. iter_53_0)
					local var_53_2 = var_53_1:getChildByName("biling")
					local var_53_3 = var_53_1:getChildByName("curtag")

					var_53_2:setVisible(false)
					var_53_3:setVisible(false)
				end
			end
		end)()

		local var_52_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
		local var_52_3 = level_manager:getModeTotalChapter(var_52_2)
		local var_52_4 = 0

		if arg_52_1 == 0 then
			var_52_4 = var_0_37
		end

		if arg_52_1 == math.ceil(var_52_3 / self.curmapjsonchapternum) then
			var_52_4 = -var_0_38
		end

		if math.ceil(var_52_3 / self.curmapjsonchapternum) == 1 then
			var_52_4 = 0
		end

		if arg_52_1 + 1 <= math.ceil(var_52_3 / self.curmapjsonchapternum) then
			var_52_0:setVisible(true)
			;(function(...)
				if not var_52_0:getChildByName("map") then
					local var_54_0 = self:getMapObj()

					var_54_0:setName("map")

					var_54_0.city = self.curcity

					var_52_0:addChild(var_54_0)
				end

				if var_52_0:getChildByName("map").city ~= self.curcity then
					var_52_0:getChildByName("map"):removeFromParent()

					local var_54_1 = self:getMapObj()

					var_54_1:setName("map")

					var_54_1.city = self.curcity

					var_52_0:addChild(var_54_1)
				end

				local var_54_2 = var_52_0:getChildByName("map")
				local var_54_3 = var_54_2:getChildByName("route")
				local var_54_4 = var_54_2:getChildByName("area_1")
				local var_54_5 = var_54_2:getChildByName("area_2")
				local var_54_6 = var_54_2:getChildByName("line_above")
				local var_54_7 = var_54_2:getChildByName("line_under")

				var_54_2:setPositionY((self.levelmapcellheight - 1136) / 2 + var_52_4)
			end)()

			local var_52_5 = var_52_0:getChildByName("map")

			if var_52_5:getChildByName("line_under") then
				var_52_5:getChildByName("line_under"):setVisible(arg_52_1 ~= 0)
			end

			if var_52_5:getChildByName("line_above") then
				var_52_5:getChildByName("line_above"):setVisible(arg_52_1 + 1 ~= math.ceil(var_52_3 / self.curmapjsonchapternum))
			end

			local var_52_6 = 1

			while var_52_0:getChildByName("sp_" .. var_52_6) do
				var_52_0:getChildByName("sp_" .. var_52_6):setVisible(false)

				var_52_6 = var_52_6 + 1
			end

			local var_52_7 = 1

			while var_52_5:getChildByName("area_" .. var_52_7) do
				var_52_5:getChildByName("area_" .. var_52_7):setVisible(false)

				var_52_7 = var_52_7 + 1
			end

			for iter_52_0 = 1, self.curmapjsonchapternum do
				local var_52_8 = var_52_0:getChildByName("sp_" .. iter_52_0)

				if var_52_3 >= arg_52_1 * self.curmapjsonchapternum + iter_52_0 and var_52_5:getChildByName("area_" .. iter_52_0) then
					var_52_8:setVisible(true)

					local var_52_9 = {
						timer = self.timers[var_52_2 .. "-" .. arg_52_1 * self.curmapjsonchapternum + iter_52_0],
						chapter = arg_52_1 * self.curmapjsonchapternum + iter_52_0,
						curcity = self.curcity
					}

					var_52_9.curdifficuty = self.curdifficuty or 1
					var_52_8.chapter = arg_52_1 * self.curmapjsonchapternum + iter_52_0

					var_52_8:update(var_52_9)

					local var_52_10 = var_52_5:getChildByName("area_" .. iter_52_0):getPositionX()

					if level_manager:getChapterStrongholdLv(var_52_2, arg_52_1 * self.curmapjsonchapternum + iter_52_0) ~= 1 and (arg_52_1 * self.curmapjsonchapternum + iter_52_0) % 2 == 1 then
						var_52_10 = var_52_10 - 33
					end

					var_52_8:setPosition(cc.p(var_52_10, var_52_5:getChildByName("area_" .. iter_52_0):getPositionY() + (self.levelmapcellheight - 1136) / 2 + var_52_4))
					var_40_1(var_52_2, arg_52_1 * self.curmapjsonchapternum + iter_52_0)

					local var_52_11 = patrol_manager:getPatrolInfo(var_52_2 .. "-" .. arg_52_1 * self.curmapjsonchapternum + iter_52_0)

					if var_52_11 then
						var_52_8:updateTimer(var_0_30(var_52_11.time))
					end
				end
			end
		else
			var_52_0:setVisible(false)
		end

		return var_52_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.chapterTV:registerScriptHandler(function(arg_55_0, arg_55_1)
		self.chapterTV.totalChapters = level_manager:getModeTotalChapter((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

		return math.ceil(self.chapterTV.totalChapters / self.curmapjsonchapternum)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.chapterTV:reloadData()
end

function ActivityLevelBaseLayer:getMapObj()
	return (ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(self.curcity) .. ".json"))
end

function ActivityLevelBaseLayer:updateMapJsonInfo(...)
	local var_57_0 = self:getMapObj()
	local var_57_1 = 10
	local var_57_2 = 0

	while var_57_0:getChildByName("area_" .. var_57_2 + 1) do
		var_57_2 = var_57_2 + 1
		var_57_1 = var_57_2
	end

	self.curmapjsonchapternum = var_57_1

	if ccui.Helper:seekWidgetByName(var_57_0, "Panel_cell_size") then
		self.levelmapcellheight = ccui.Helper:seekWidgetByName(var_57_0, "Panel_cell_size"):getContentSize().height or var_0_36
	end
end

function ActivityLevelBaseLayer:updateShowingCells()
	local var_58_0 = {
		cellsize = cc.size(var_0_35, self.levelmapcellheight)
	}
	local var_58_1 = level_manager:getModeTotalChapter((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

	if var_58_1 ~= self.chapterTV.totalChapters then
		var_58_0.maxcount = math.ceil(math.max(var_58_1, self.chapterTV.totalChapters) / self.curmapjsonchapternum)
		self.chapterTV.totalChapters = math.max(self.chapterTV.totalChapters, var_58_1)
	else
		var_58_0.maxcount = math.ceil(var_58_1 / self.curmapjsonchapternum)
	end

	local var_58_2, var_58_3 = GetTableViewShowCellIdx(self.chapterTV, var_58_0)

	for iter_58_0 = var_58_2, var_58_3 do
		self.chapterTV:updateCellAtIndex(iter_58_0)
	end

	self.chapterTV.totalChapters = var_58_1

	if not self.updatePatrolTime then
		self:scrollTableView()
	end
end

function ActivityLevelBaseLayer:scrollTableView()
	local var_59_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
	local var_59_2 = level_manager:getModeTotalChapter(var_59_1)
	local var_59_5 = math.max(0, (math.min(level_manager:getCurChapter(var_59_1) <= 4 and 0 or (level_manager:getCurChapter(var_59_1) - 4) / var_59_2 * 100 - var_0_32 / self.levelmapcellheight / 2, 100)))

	self.chapterTV:scrollToPercent((math.ceil(var_59_2 / self.curmapjsonchapternum) == 1 or nil) and 0, nil, false)
end

function ActivityLevelBaseLayer:initMapLockWord()
	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, GameDisplay.height / 2)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self.uilayer:addChild(self.mapLockWord)

	local var_60_0 = ccui.ImageView:create(self.resourcePath .. "cover_locked.png", var_0_0)

	var_60_0:setScale9Enabled(true)
	var_60_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_60_0:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_60_0)

	local var_60_1 = ccui.ImageView:create(self.resourcePath .. "wordbg.png", var_0_0)

	var_60_1:setName("mapLockWordBg")
	var_60_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_60_1)

	local var_60_2 = ccui.ImageView:create(self.resourcePath .. "ui_lock.png", var_0_0)

	var_60_2:setAnchorPoint(cc.p(1, 0.5))
	var_60_2:setPosition(cc.p(640, GameDisplay.height / 2))
	var_60_2:setName("lockui1")
	self.mapLockWord:addChild(var_60_2)

	local var_60_3 = ccui.ImageView:create(self.resourcePath .. "ui_lock.png", var_0_0)

	var_60_3:setAnchorPoint(cc.p(0, 0.5))
	var_60_3:setPosition(cc.p(0, GameDisplay.height / 2))
	var_60_3:setFlippedY(true)
	var_60_3:setFlippedX(true)
	var_60_3:setName("lockui2")
	self.mapLockWord:addChild(var_60_3)

	local var_60_4 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_60_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_60_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_60_4:setName("word")
	self.mapLockWord:addChild(var_60_4)
	self.mapLockWord:addTouchEventListener(function(arg_61_0, arg_61_1)
		if arg_61_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		if not level_manager:isCityCanUnlock(self.curcity) then
			return
		end

		local function var_61_0()
			LayerManager:switchShowLayer("FightLayer")
			FightManager.openFightOnChangeChapter(function()
				GuideListener.triggerGuide(TRIGGER_UNLOCKCHAPTER)
			end)
		end

		LayerManager:pushInLayer("PopCityUnlockLayer", {
			city = self.curcity,
			successcallback = function()
				FightManager.closeFightOnChangeChapter()
				self.cityList:setScrollEnabled(false)
				LayerManager:getPlotObj():clean_all()
				self:updateCityOnUnlock()
				self:playUnlockAni(var_61_0)
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
			end
		})
	end)
end

function ActivityLevelBaseLayer:updateCityMapLayer(arg_65_1)
	local var_65_0 = self.curdifficuty or 1
	local var_65_1 = level_manager:getModeByDifficulty(self.curcity, var_65_0)
	local var_65_2 = level_manager:getCityConf(self.curcity)
	local var_65_3 = level_manager:getModeTotalChapter(var_65_1)

	self.bgNode:loadTexture(var_0_17 .. "Map_" .. self.curcity .. ".png")
	self.cityTitle:loadTexture(var_0_18 .. "country" .. self.curcity .. "_" .. var_65_0 .. ".png")

	if self.curcity == 83822 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") then
		self.bgNode:loadTexture(var_0_17 .. "Map_" .. self.curcity .. "_replace.png")
	end

	if self.curcity == 86523 or self.curcity == 86524 then
		if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") then
			self.bgNode:loadTexture(var_0_17 .. "Map_" .. self.curcity .. "_replace.png")
		end
	end

	for iter_65_0 = 1, var_65_3 do
		if level_manager:isChapterModeUnlocked(var_65_1, iter_65_0) then
			if self.timers[var_65_1 .. "-" .. iter_65_0] then
				local var_65_4 = patrol_manager:getPatrolInfo(self.timers[var_65_1 .. "-" .. iter_65_0].key)

				if not var_65_4 or var_65_4.time <= 0 then
					self.timers[var_65_1 .. "-" .. iter_65_0] = nil
				end
			else
				local var_65_5 = var_65_1 .. "-" .. iter_65_0
				local var_65_6 = patrol_manager:getPatrolState(var_65_1 .. "-" .. iter_65_0)

				if var_65_6 == 3 then
					self.timers[var_65_5] = {
						index = iter_65_0,
						key = var_65_5
					}
				elseif var_65_6 == 2 then
					-- block empty
				end
			end
		end
	end

	self.chapterTV:reloadData()
	self:scrollTableView()
end

function ActivityLevelBaseLayer:updateMapLockWord(arg_66_1)
	if level_manager:isCityUnlocked(arg_66_1) then
		self.mapLockWord:setVisible(false)

		return
	end

	self.mapLockWord:setVisible(true)

	if not level_manager:checkUnlockTime(arg_66_1) then
		self.mapLockWord:getChildByName("word"):setString(os.date("%m-%d %H:%M", level_manager:getCityUnlockTime(arg_66_1)) .. L_COMMON_WARNING.Time_Lock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture(self.resourcePath .. "ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture(self.resourcePath .. "ui_lock.png", var_0_0)
	elseif level_manager:isCityCanUnlock(arg_66_1) then
		self.mapLockWord:getChildByName("word"):setString(L_MAP_CITY_CHAPTERS.Can_Unlock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture(self.resourcePath .. "ui_canlock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture(self.resourcePath .. "ui_canlock.png", var_0_0)
	else
		self.mapLockWord:getChildByName("word"):setString(L_COMMON_WARNING.Locking)
		self.mapLockWord:getChildByName("lockui1"):loadTexture(self.resourcePath .. "ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture(self.resourcePath .. "ui_lock.png", var_0_0)
	end
end

function ActivityLevelBaseLayer:updateCityMapOnSelectDifficulty()
	local var_67_0 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)

	self.chapterTV:reloadData()
	self:scrollTableView()
end

function ActivityLevelBaseLayer:playSelectCityAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_13.COVER)

	self._playingani = true

	self:removeGuidesOnLayer()
	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateUIInfos()
		self:updateCityMapLayer()
		self:playShowCityAni()
	end)))
end

function ActivityLevelBaseLayer:playShowCityAni()
	if not self.anicover then
		self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), GameDisplay.width, GameDisplay.height)

		self.anicover:setPosition(0, -GameDisplay.fix_y)
		self:addChild(self.anicover, var_0_13.COVER)
	end

	self.anicover:runAction(cc.Sequence:create(cc.FadeOut:create(0.4), cc.RemoveSelf:create()))

	self.anicover = nil

	self.maplayer:setPosition(cc.p(0, 8))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, -8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function ActivityLevelBaseLayer:playInitShowAni()
	self.maplayer:setVisible(false)
	self.uilayer:setVisible(false)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_13.COVER)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.maplayer:setVisible(true)
		self.uilayer:setVisible(true)
		self:playShowCityAni()
	end)))
end

function ActivityLevelBaseLayer:playSelectDifficultyAni()
	local var_74_0 = cc.Layer:create()

	self:addChild(var_74_0, var_0_13.DIFFICULTYANI)

	local var_74_1 = cc.Layer:create()

	var_74_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	self:addChild(var_74_1, var_0_13.DIFFICULTYANI)

	local var_74_2

	if config._DEBUG then
		var_74_2 = cc.Sprite:create(self.resourcePath .. "img_switchmodebg.png") or cc.Sprite:createWithSpriteFrameName(self.resourcePath .. "img_switchmodebg.png")
	end

	var_74_2:setPosition(cc.p(320, 568))
	var_74_1:addChild(var_74_2)

	local var_74_3

	if config._DEBUG then
		var_74_3 = cc.Sprite:create(self.difficutyPath[self.curdifficuty]) or cc.Sprite:createWithSpriteFrameName(self.difficutyPath[self.curdifficuty])
	end

	var_74_3:setPosition(cc.p(320, 568))
	var_74_1:addChild(var_74_3)
	self.cityTitle:loadTexture(var_0_18 .. "country" .. self.curcity .. "_" .. self.curdifficuty .. ".png")

	self._playingani = true

	self:removeGuidesOnLayer()
	var_74_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateCityMapOnSelectDifficulty()
	end)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function ActivityLevelBaseLayer:playExitAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, 10)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)))
end

function ActivityLevelBaseLayer:playUnlockAni(arg_79_1)
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
	end)))
	var_79_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_79_1 = ccs.Armature:create("dianwei")

	var_79_1:setPosition(cc.p(320, 568 + GameDisplay.fix_y))
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

function ActivityLevelBaseLayer:playUnlockCityTalk()
	local var_84_0 = level_manager:getUnlockCityTalk(self.curcity)

	if not var_84_0 then
		return
	end

	global_basic_scene:addChild(TalkLayer:create(var_84_0, nil, talktype, "", TALK_TYPE_BEFORE_BOSS, 1), ZORDER_TALKLAYER)
end

function ActivityLevelBaseLayer.removeGuidesOnLayer(arg_85_0)
	if LayerManager:getCurrentLayerName() ~= "ActivityLevelBaseLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function ActivityLevelBaseLayer.updateGuidesOnLayer(arg_86_0)
	if LayerManager:getCurrentLayerName() ~= "ActivityLevelBaseLayer" then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function ActivityLevelBaseLayer:refreshGuidesOnLevelMap()
	if LayerManager:getCurrentLayerName() ~= "ActivityLevelBaseLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function ActivityLevelBaseLayer:getCurCity()
	return self.curcity
end

function ActivityLevelBaseLayer:initStarRewardUI()
	local var_89_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_89_1) .. "/" .. level_manager:getModeTotalChapter(var_89_1) * 3)
	self.starReward:addTouchEventListener(function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			cityType = self.initcitytype,
			mode = var_89_1,
			updateCallback = function()
				if ActivityLevelBaseLayer.getInstance() then
					ActivityLevelBaseLayer.getInstance():updateStarRewardUI()
					ActivityLevelBaseLayer.getInstance():updateCityBntTips(self.curcity, self.curdifficuty or 1)
				end
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_89_1) then
		self.starRewardRedDot:setVisible(true)
	else
		self.starRewardRedDot:setVisible(false)
	end
end

function ActivityLevelBaseLayer:updateStarRewardUI()
	local var_92_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_92_1) .. "/" .. level_manager:getModeTotalChapter(var_92_1) * 3)
	self.starReward:addTouchEventListener(function(arg_93_0, arg_93_1)
		if arg_93_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			cityType = self.initcitytype,
			mode = var_92_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_92_1) then
		self.starRewardRedDot:setVisible(true)
	else
		self.starRewardRedDot:setVisible(false)
	end
end

function ActivityLevelBaseLayer:updateBossImg()
	local var_95_0 = self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or 1

	if not self.bossimg then
		self.bossimg = ccui.ImageView:create("GUI/image.png", var_0_0)

		self:addChild(self.bossimg, var_0_13.BOSSIMG)

		local var_95_1 = ccui.Layout:create()

		var_95_1:setTouchEnabled(true)
		var_95_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_95_1:setAnchorPoint(cc.p(0, 0))
		var_95_1:setPosition(cc.p(0, -GameDisplay.fix_y))
		var_95_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_95_1:setBackGroundColor(cc.c3b(0, 0, 0))
		self:addChild(var_95_1, -10)
	end

	local var_95_2, var_95_3, var_95_4, var_95_5, var_95_6, var_95_7, var_95_8, var_95_9 = level_manager:get_mode_bossimg((level_manager:getModeByDifficulty(self.curcity, var_95_0)))

	self.bossimg:loadTexture(var_0_23 .. var_95_2 .. ".png", var_0_0)
	self.bossimg:setPositionX(tonumber(string.split(var_95_3, ",")[1]) + tonumber(string.split(var_95_4, ",")[1]))
	self.bossimg:setPositionY(tonumber(string.split(var_95_3, ",")[2]) + tonumber(string.split(var_95_4, ",")[2]) + GameDisplay.fix_y)
	self.bossimg:setScale(var_95_5)
end
