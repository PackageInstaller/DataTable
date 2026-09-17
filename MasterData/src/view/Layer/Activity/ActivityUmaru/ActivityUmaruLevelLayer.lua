ActivityUmaruLevelLayer = class("ActivityUmaruLevelLayer", function()
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

require("view.Sprite.ChapterSpriteUmaru")

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
local var_0_15 = {
	[13704] = "CityMap/MiniMap/country13704.png",
	[13707] = "CityMap/MiniMap/country13707.png",
	[13710] = "CityMap/MiniMap/country13710.png",
	[13701] = "CityMap/MiniMap/country13701.png",
	[13713] = "CityMap/MiniMap/country13713.png"
}
local var_0_16 = {
	[13704] = "CityMap/Maps/Map_umaru_2.png",
	[13707] = "CityMap/Maps/Map_umaru_3.png",
	[13710] = "CityMap/Maps/Map_umaru_4.png",
	[13701] = "CityMap/Maps/Map_umaru_1.png",
	[13713] = "CityMap/Maps/Map_umaru_5.png"
}
local var_0_17 = {
	FREE = 1,
	FORBID = 2,
	LOCKING = 3
}
local var_0_19 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}
local var_0_20 = {
	325,
	225,
	125,
	25
}
local var_0_21 = 13713
local var_0_23

function ActivityUmaruLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityUmaruLevelLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityUmaruLevelLayer.getInstance()
	return var_0_23
end

function ActivityUmaruLevelLayer:getExitParam()
	return {
		initcitytype = cloneconf(self.initcitytype),
		initcity = cloneconf(self.curcity),
		initdifficulty = cloneconf(self.curdifficuty)
	}
end

function ActivityUmaruLevelLayer:init(arg_5_1)
	var_0_23 = self
	self._playingani = false

	if arg_5_1 then
		self.initcitytype = arg_5_1.initcitytype
		self.initcity = arg_5_1.initcity
		self.initdifficulty = arg_5_1.initdifficulty
	else
		self.initcitytype = 137

		local var_5_0 = RoleDefault:getInstance():getIntegerForKey("ActivityUmaruEnterMode", -1)

		if var_5_0 == -1 then
			self.initcity = level_manager:getMaxActivityCity(self.initcitytype)
			self.initdifficulty = level_manager:getUnlockedDifficultyInCity(self.initcity)
		else
			self.initcity = level_manager:getCityByMode(var_5_0)
			self.initdifficulty = level_manager:getDifficultByMode(var_5_0)
		end
	end

	if self.initcity >= 13713 then
		self.initdifficulty = 1
	end

	level_manager:updateAdventureDetailInfo("initcitytype", self.initcitytype)
	level_manager:updateAdventureDetailInfo("initcity", self.initcity)
	level_manager:updateAdventureDetailInfo("initdifficulty", self.initdifficulty)
	patrol_manager:reset()
	self:initTimers()
	level_manager:getModesLockState(function()
		self:initUINode()
		self:initCityMapLayer()
		self:playInitShowAni()
		self:fullScreen()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_23 = false
		end
	end)
end

function ActivityUmaruLevelLayer:initUINode()
	self:loadBasicUIAssets()

	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelMapUmaru.json" or "LevelMapUmaru.ExportJson")

	self:addChild(self.uilayer)

	self.bgNode = self.uilayer:getChildByName("bg")
	self.starReward = self.uilayer:getChildByName("btn_starReward")
	self.total_star_label = self.starReward:getChildByName("num")
	self.starRewardRedDot = self.starReward:getChildByName("redDot")
	self.btn_buff = self.uilayer:getChildByName("btn_buff")
	self.cityTitle = ccui.Helper:seekWidgetByName(self.uilayer, "title")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.uilayer, "btn_return")
	self.panelDifficulty = self.uilayer:getChildByName("panel_difficulty")

	self.panelDifficulty:setPositionX(295)
	self.btnReturn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		self:playExitAni()
	end)
	self.btn_buff:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopUmaruScoreUpLayer", {
			curcity = self.curcity
		})
	end)

	for iter_8_0 = 1, #var_0_19 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_19[iter_8_0]):addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			if level_manager:isCityNewDifficulty(self.curcity, iter_8_0) then
				level_manager:unMarkModeNew(level_manager:getModeByDifficulty(self.curcity, iter_8_0))
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

function ActivityUmaruLevelLayer:fullScreen()
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

	local var_12_0 = ccui.Helper:seekWidgetByName(self.uilayer, "di")

	var_12_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_12_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_12_0:setPositionY(var_12_0.full_posY)
	self.bgNode:setPositionY(GameDisplay.height / 2)
end

local function var_0_24(arg_13_0)
	if arg_13_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_13_0 / 3600), math.floor(arg_13_0 % 3600 / 60), arg_13_0 % 60)
	else
		return string.format("%02d:%02d", math.floor(arg_13_0 / 60), arg_13_0 % 60)
	end
end

function ActivityUmaruLevelLayer:initTimers()
	self.timers = {}

	local var_14_0 = 1

	self:scheduleUpdateWithPriorityLua(function(arg_15_0)
		var_14_0 = var_14_0 + arg_15_0

		if var_14_0 > 1 then
			local var_15_0

			for iter_15_0, iter_15_1 in pairs(self.timers) do
				var_15_0 = patrol_manager:getPatrolInfo(iter_15_1.key)

				if var_15_0 then
					-- block empty
				else
					self.timers[iter_15_0] = nil
				end
			end

			if var_15_0 then
				self.updatePatrolTime = true

				self:updateShowingCells()

				self.updatePatrolTime = false
			end

			var_14_0 = var_14_0 - 1
		end
	end, 1)
end

function ActivityUmaruLevelLayer.cleanAllTimers(arg_16_0)
	arg_16_0.timers = {}
end

function ActivityUmaruLevelLayer.changeTheCityList(arg_17_0, arg_17_1)
	return arg_17_1
end

function ActivityUmaruLevelLayer:initCityList()
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

	local var_18_0 = self:changeTheCityList(level_manager:getActivityCityListById(self.initcitytype))

	local function var_18_1(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_19_0:getTouchBeganPosition().x - arg_19_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_19_0:getTag())

		for iter_19_0, iter_19_1 in ipairs(var_18_0) do
			self:updateCityBntTips(iter_19_1)
		end
	end

	local function var_18_2(arg_20_0)
		local var_20_0 = ccui.Button:create(var_0_15[arg_20_0], nil, var_0_15[arg_20_0])

		var_20_0:setName("city" .. arg_20_0)

		var_20_0.areaid = arg_20_0 % self.initcitytype

		local var_20_1 = cc.Sprite:create("CityMap/MiniMap/" .. level_manager:getCityImg(arg_20_0) .. ".png")

		var_20_1:setPosition(cc.p(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2))
		var_20_1:setName("minimap")
		var_20_1:setVisible(false)
		var_20_0:addChild(var_20_1, -1)

		local var_20_2 = ccui.ImageView:create(var_0_14.SELECT, var_0_0)

		var_20_2:setPosition(cc.p(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2))
		var_20_2:setName("frame")
		var_20_2:setVisible(false)
		var_20_0:addChild(var_20_2, 2)

		if not level_manager:isCityUnlocked(arg_20_0) then
			l2utils:shaderGrayDark(var_20_0:getVirtualRenderer())
			l2utils:shaderGrayDark(var_20_1)

			if not level_manager:isCityCanUnlock(arg_20_0) then
				l2utils:shaderNode(var_20_2:getVirtualRenderer())
			end
		else
			l2utils:shaderDarkNode(var_20_0:getVirtualRenderer())
			l2utils:shaderDarkNode(var_20_1)
		end

		var_20_0:addTouchEventListener(var_18_1)

		return var_20_0
	end

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_3 = var_18_2(iter_18_1)

		self.cityList:pushInCity(var_18_3)

		self.cities[iter_18_1] = var_18_3
		self.index_to_city[var_18_3:getTag()] = iter_18_1
		self.city_to_index[iter_18_1] = var_18_3:getTag()
	end

	self.cityList:registerSelectCityHandler(function(arg_21_0)
		if self.curcity == self.index_to_city[arg_21_0] then
			return
		end

		self:updateCityOnUnSelect(self.curcity)

		self.curcity = self.index_to_city[arg_21_0]

		level_manager:updateAdventureDetailInfo("initcity", self.curcity)
		self:updateMapJsonInfo()
		self:updateCityOnSelect(self.curcity)
		self:playSelectCityAni()

		for iter_21_0, iter_21_1 in ipairs(var_18_0) do
			self:updateCityBntTips(iter_21_1)
		end
	end)

	self.curcity = self.initcity

	level_manager:updateAdventureDetailInfo("initcity", self.curcity)
	self:updateMapJsonInfo()
	print("self.curmapjsonchapternum", self.curmapjsonchapternum)
	self:updateCityOnSelect(self.curcity)
	self.cityList:jumpToIndex(self.city_to_index[self.curcity])

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		self:updateCityBntTips(iter_18_3)
	end
end

function ActivityUmaruLevelLayer:updateCityBntTips(arg_22_1)
	local var_22_0 = self.cities[arg_22_1]
	local var_22_1 = self.cities[arg_22_1]:getChildByName("frame")

	local function var_22_2()
		return self.city_to_index[arg_22_1] - self.city_to_index[self.curcity] == -1
	end

	local var_22_3 = 0
	local var_22_4 = 45
	local var_22_7 = 3
	local var_22_8 = self.cityList:getCityBtnDirection(arg_22_1)

	if level_manager:isCityCanUnlock(arg_22_1) and var_22_8 == var_22_7 then
		if not var_22_0:getChildByName("newtag") then
			var_22_1:loadTexture(var_0_14.NEW, var_0_0)
			var_22_1:setVisible(true)

			local var_22_9 = ccui.ImageView:create("LevelMapUmaru/img_tagnew.png", var_0_0)

			var_22_9:setAnchorPoint(cc.p(0.5, 0))

			if var_22_2() then
				var_22_9:setPosition(cc.p(150 - var_22_4, 100 + var_22_3))
			else
				var_22_9:setPosition(cc.p(150, 100))
			end

			var_22_9:setName("newtag")
			var_22_0:addChild(var_22_9)
		elseif var_22_2() then
			var_22_0:getChildByName("newtag"):setPosition(cc.p(150 - var_22_4, 100 + var_22_3))
		else
			var_22_0:getChildByName("newtag"):setPosition(cc.p(150, 100))
		end
	elseif var_22_0:getChildByName("newtag") then
		var_22_0:removeChildByName("newtag")
	end

	if patrol_manager:isCityFinishedPatrol(arg_22_1) and var_22_8 == var_22_7 then
		if not var_22_0:getChildByName("reddot") then
			local var_22_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_22_10:setAnchorPoint(cc.p(1, 1))

			if var_22_2() then
				var_22_10:setPosition(var_22_0:getContentSize().width - 10 - var_22_4, var_22_0:getContentSize().height + 18 + var_22_3)
			else
				var_22_10:setPosition(var_22_0:getContentSize().width - 10, var_22_0:getContentSize().height + 18)
			end

			var_22_10:setName("reddot")
			var_22_0:addChild(var_22_10, 9)
		elseif var_22_2() then
			var_22_0:getChildByName("reddot"):setPosition(var_22_0:getContentSize().width - 10 - var_22_4, var_22_0:getContentSize().height + 18 + var_22_3)
		else
			var_22_0:getChildByName("reddot"):setPosition(var_22_0:getContentSize().width - 10, var_22_0:getContentSize().height + 18)
		end
	elseif var_22_0:getChildByName("reddot") then
		var_22_0:removeChildByName("reddot")
	end

	if level_manager:isCityNewDifficulty(arg_22_1) and var_22_8 == var_22_7 then
		if not var_22_0:getChildByName("newDifficultyTips") then
			local var_22_11 = ccui.ImageView:create("LevelMapUmaru/img_tagnew.png", var_0_0)

			var_22_11:setAnchorPoint(cc.p(0.5, 0))

			if var_22_2() then
				var_22_11:setPosition(cc.p(150 - var_22_4, 100 + var_22_3))
			else
				var_22_11:setPosition(cc.p(150, 100))
			end

			var_22_11:setName("newDifficultyTips")
			var_22_0:addChild(var_22_11)
		elseif var_22_2() then
			var_22_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150 - var_22_4, 100 + var_22_3))
		else
			var_22_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150, 100))
		end
	elseif var_22_0:getChildByName("newDifficultyTips") then
		var_22_0:removeChildByName("newDifficultyTips")
	end

	if level_manager:checkIsNewStarRewardInCity(arg_22_1) and var_22_8 == var_22_7 then
		if not var_22_0:getChildByName("newStarTips") then
			local var_22_12 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_22_12:setAnchorPoint(cc.p(1, 1))

			if var_22_2() then
				var_22_12:setPosition(var_22_0:getContentSize().width - 10 - var_22_4, var_22_0:getContentSize().height + 18 + var_22_3)
			else
				var_22_12:setPosition(var_22_0:getContentSize().width - 10, var_22_0:getContentSize().height + 18)
			end

			var_22_12:setName("newStarTips")
			var_22_0:addChild(var_22_12, 9)
		elseif var_22_2() then
			var_22_0:getChildByName("newStarTips"):setPosition(var_22_0:getContentSize().width - 10 - var_22_4, var_22_0:getContentSize().height + 18 + var_22_3)
		else
			var_22_0:getChildByName("newStarTips"):setPosition(var_22_0:getContentSize().width - 10, var_22_0:getContentSize().height + 18)
		end
	else
		local var_22_14
		local var_22_13

		if var_22_0:getChildByName("newStarTips") then
			var_22_0:removeChildByName("newStarTips")

			var_22_13 = var_22_8 == var_22_7
			var_22_14 = ipairs
		end
	end

	for iter_22_0, iter_22_1 in var_22_14({
		"newDifficultyTips",
		"reddot",
		"newPatrolTips",
		"newStarTips"
	}) do
		if var_22_0:getChildByName(iter_22_1) then
			var_22_0:getChildByName(iter_22_1):setVisible(var_22_13)

			var_22_13 = false
		end
	end
end

function ActivityUmaruLevelLayer:getCityByID(arg_24_1)
	return self.cities[arg_24_1]
end

function ActivityUmaruLevelLayer:getCityByIndex(arg_25_1)
	return self.cities[self.index_to_city[arg_25_1]]
end

function ActivityUmaruLevelLayer:updateCityOnSelect(arg_26_1)
	local var_26_0 = self:getCityByID(arg_26_1)

	if level_manager:isCityUnlocked(arg_26_1) then
		l2utils:recoverShader(var_26_0:getVirtualRenderer())
		l2utils:recoverShader(var_26_0:getChildByName("minimap"))
	else
		l2utils:shaderNode(var_26_0:getVirtualRenderer())
		l2utils:shaderNode(var_26_0:getChildByName("minimap"))
	end

	var_26_0:getChildByName("frame"):setVisible(true)

	if not level_manager:isCityCanUnlock(arg_26_1) then
		var_26_0:getChildByName("frame"):loadTexture(var_0_14.SELECT, var_0_0)
	end

	self:playCityFrameBreath(arg_26_1)
end

function ActivityUmaruLevelLayer:updateCityOnUnSelect(arg_27_1)
	local var_27_0 = self:getCityByID(arg_27_1)

	if level_manager:isCityUnlocked(arg_27_1) then
		l2utils:shaderDarkNode(var_27_0:getVirtualRenderer())
		l2utils:shaderDarkNode(var_27_0:getChildByName("minimap"))
	else
		l2utils:shaderGrayDark(var_27_0:getVirtualRenderer())
		l2utils:shaderGrayDark(var_27_0:getChildByName("minimap"))
	end

	if not level_manager:isCityCanUnlock(arg_27_1) then
		var_27_0:getChildByName("frame"):setVisible(false)
	end

	self:stopCityFrameBreath(arg_27_1)
end

function ActivityUmaruLevelLayer:updateCityOnUnlock()
	local var_28_0 = self:getCityByID(self.curcity)

	l2utils:recoverShader(var_28_0:getVirtualRenderer())
	l2utils:recoverShader(var_28_0:getChildByName("minimap"))

	if var_28_0:getChildByName("newtag") then
		var_28_0:removeChildByName("newtag")
	end

	var_28_0:getChildByName("frame"):loadTexture(var_0_14.SELECT, var_0_0)
end

function ActivityUmaruLevelLayer.playCityFrameBreath(arg_29_0, arg_29_1)
	return
end

function ActivityUmaruLevelLayer.stopCityFrameBreath(arg_30_0, arg_30_1)
	return
end

function ActivityUmaruLevelLayer:initUIInfos()
	local var_31_0 = self.initdifficulty and level_manager:isOnlyCityDifficultyValid(self.curcity, self.initdifficulty) and self.initdifficulty or 1

	self.curdifficuty = var_31_0
	self.finaldifficuty = var_31_0

	level_manager:updateAdventureDetailInfo("initdifficulty", self.curdifficuty)
	self:updateDifficutyPanel()
	self:initStarRewardUI()
end

function ActivityUmaruLevelLayer:updateUIInfos()
	if level_manager:isCityUnlocked(self.curcity) then
		if self.finaldifficuty then
			local var_32_0 = level_manager:getCityDifficulties(self.curcity)
			local var_32_1 = 1

			for iter_32_0 = 1, 4 do
				if var_32_0[iter_32_0] and var_32_0[iter_32_0].stat then
					var_32_1 = iter_32_0
				end
			end

			self.curdifficuty = var_32_1 < self.finaldifficuty and var_32_1 or self.finaldifficuty
		else
			self.curdifficuty = self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or 1
			self.finaldifficuty = self.curdifficuty
		end
	else
		self.curdifficuty = 1
	end

	level_manager:updateAdventureDetailInfo("initdifficulty", self.curdifficuty)
	self:updateDifficutyPanel()
	self:updateStarRewardUI()
end

function ActivityUmaruLevelLayer.initPanelDifficulty(arg_33_0)
	return
end

function ActivityUmaruLevelLayer:selectDifficulty(arg_34_1)
	if self.curcity >= 13713 then
		arg_34_1 = 1
	end

	self.curdifficuty = arg_34_1
	self.finaldifficuty = arg_34_1

	level_manager:updateAdventureDetailInfo("initdifficulty", self.curdifficuty)
	self:updateDifficutyPanel()
	self:updateStarRewardUI()
	self:playSelectDifficultyAni()
end

function ActivityUmaruLevelLayer:updateDifficutyPanel()
	if self.curcity >= var_0_21 then
		self.panelDifficulty:setVisible(false)
	end

	local var_35_0

	do
		self.panelDifficulty:setVisible(true)

		var_35_0 = 0
	end

	for iter_35_0, iter_35_1 in ipairs((level_manager:getCityDifficulties(self.curcity))) do
		local var_35_1 = self.panelDifficulty:getChildByName("btn_" .. var_0_19[iter_35_0])

		var_35_1:setVisible(true)

		local var_35_2 = iter_35_0 == self.curdifficuty and "LevelMapUmaru/btn_" .. var_0_19[iter_35_0] .. ".png" or "LevelMapUmaru/btn_" .. var_0_19[iter_35_0] .. "_off.png"

		var_35_1:loadTextures(var_35_2, nil, var_35_2, var_0_0)

		var_35_0 = var_35_0 + 1
	end

	for iter_35_2 = 1, var_35_0 do
		local var_35_3 = self.panelDifficulty:getChildByName("btn_" .. var_0_19[iter_35_2])
		local var_35_4, var_35_5 = var_35_3:getPosition()

		var_35_3:setVisible(true)
		var_35_3:setPositionX(var_0_20[var_35_0 + 1 - iter_35_2])
	end

	for iter_35_3 = var_35_0 + 1, 4 do
		-- block empty
	end

	if var_35_0 == 1 then
		-- block empty
	end
end

function ActivityUmaruLevelLayer:updateDifficutyTips(arg_36_1, arg_36_2)
	local var_36_0 = self.panelDifficulty:getChildByName("btn_" .. var_0_19[arg_36_2])
	local var_36_1 = {}

	if patrol_manager:isCityFinishedPatrol(arg_36_1, arg_36_2) then
		if not var_36_0:getChildByName("reddot") then
			local var_36_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_36_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_36_2:setPosition(var_36_0:getContentSize().width, var_36_0:getContentSize().height)
			var_36_2:setName("reddot")
			var_36_0:addChild(var_36_2)
		else
			var_36_0:getChildByName("reddot"):setVisible(true)
		end

		if self.curdifficuty == arg_36_2 then
			var_36_0:getChildByName("reddot"):setVisible(false)
		end

		var_36_1.reddot = true
	elseif var_36_0:getChildByName("reddot") then
		var_36_0:getChildByName("reddot"):setVisible(false)
	end

	if level_manager:isCityNewDifficulty(arg_36_1, arg_36_2) then
		if not var_36_0:getChildByName("newDifficultyTips") then
			local var_36_3 = ccui.ImageView:create("LevelMapUmaru/img_tagnew.png", var_0_0)

			var_36_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_36_3:setPosition(cc.p(var_36_0:getContentSize().width - 20, var_36_0:getContentSize().height))
			var_36_3:setName("newDifficultyTips")
			var_36_0:addChild(var_36_3)
		else
			var_36_0:getChildByName("newDifficultyTips"):setVisible(true)
		end

		var_36_1.newDifficultyTips = true
	elseif var_36_0:getChildByName("newDifficultyTips") then
		var_36_0:getChildByName("newDifficultyTips"):setVisible(false)
	end

	if self.curdifficuty ~= arg_36_2 then
		for iter_36_0, iter_36_1 in ipairs({
			"newDifficultyTips",
			"reddot",
			"newPatrolTips"
		}) do
			if var_36_0:getChildByName(iter_36_1) and var_36_1[iter_36_1] then
				var_36_0:getChildByName(iter_36_1):setVisible(true)
			end
		end
	end
end

function ActivityUmaruLevelLayer:initCityMapLayer()
	local var_37_0 = self.initcity or level_manager:getCurFightCity()
	local var_37_2 = level_manager:getModeByDifficulty(var_37_0, self.initdifficulty and level_manager:isOnlyCityDifficultyValid(var_37_0, self.initdifficulty) and self.initdifficulty or 1)
	local var_37_3 = level_manager:getCityConf(var_37_0)

	self.bgNode:loadTexture(var_0_16[var_37_0])

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

local var_0_25 = 660
local var_0_26 = 1136 + GameDisplay.fix_y * 2 - 320
local var_0_27 = -14
local var_0_28 = 180
local var_0_29 = 660
local var_0_30 = 745
local var_0_31 = 100 * (GameDisplay.fix_y / 174) + 100
local var_0_32 = 100 * (GameDisplay.fix_y / 174) + 100

function ActivityUmaruLevelLayer:initCityTableView()
	local function var_38_0(arg_39_0, arg_39_1)
		if arg_39_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		local var_39_0 = self.curcity
		local var_39_1 = self.curdifficuty
		local var_39_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
		local var_39_3 = arg_39_0.chapter
		local var_39_4 = var_0_17.FREE

		if not level_manager:isChapterModeUnlocked(var_39_2, arg_39_0.chapter) then
			var_39_4 = var_0_17.FORBID
		elseif not level_manager:isChapterModeValid(var_39_2, var_39_3) then
			var_39_4 = var_0_17.LOCKING
		end

		for iter_39_0 = 1, level_manager:getModeTotalChapter(var_39_2) do
			local var_39_5 = self.chapterTV:cellAtIndex(iter_39_0 - 1)

			if var_39_5 then
				for iter_39_1 = 1, self.curmapjsonchapternum do
					local var_39_6 = var_39_5:getChildByName("sp_" .. iter_39_1)
					local var_39_7 = var_39_6:getChildByName("curtag")
					local var_39_8 = var_39_6:getChildByName("biling")

					if var_39_6.chapter == var_39_3 then
						var_39_7:setVisible(true)
						var_39_8:setVisible(true)
					else
						var_39_7:setVisible(false)
						var_39_8:setVisible(false)
					end
				end
			end
		end

		if patrol_manager:getPatrolInfo(var_39_2 .. "-" .. var_39_3) then
			LayerManager:pushInLayer("PatrolPopLayer", {
				inittype = 2,
				mode = var_39_2,
				chapter = var_39_3,
				callback = function()
					self:updateShowingCells()
					self:updateCityBntTips(var_39_0, var_39_1)
				end
			})
		else
			local function var_39_9(arg_41_0)
				if arg_41_0 == 1 then
					AnalyticManager.click_bosstower()
					LayerManager:switchShowLayer("FightLayer", {
						is_hide_topcost = true,
						is_hide_listbutton = true
					})
					FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
				else
					if arg_41_0 == 2 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[2])
					elseif arg_41_0 == 3 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[3])
					elseif arg_41_0 == 4 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[4])
					elseif arg_41_0 == 5 then
						audio_manager:playeffectMusicTest("sound/invalid")
						global_ShowBlockWords(L_ADVENTURE_WARNING[5])
					elseif arg_41_0 == 6 then
						audio_manager:playeffectMusicTest("sound/invalid")

						if chapter_data["" .. var_39_2 .. "-" .. var_39_3] and chapter_data["" .. var_39_2 .. "-" .. var_39_3].boss_combat then
							global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapter_data["" .. var_39_2 .. "-" .. var_39_3].boss_combat .. L_ADVENTURE_WARNING[7])
						end
					end

					GuideListener.showAllGuidesWithFullScreen(true)
				end
			end

			local function var_39_10(arg_42_0)
				local function var_42_0()
					GuideListener.showAllGuidesWithFullScreen(false)
					array_manager:resetHangupArray(arg_42_0)
					RoleDefault:getInstance():setIntegerForKey("activityarray", arg_42_0)
					RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_42_0)
					RoleDefault:getInstance():setIntegerForKey("ActivityUmaruEnterMode", var_39_2)
					RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", levelmode_data[var_39_2].modetype)
					level_manager:switchToAdventureMode(var_39_2, var_39_3, var_39_9, arg_42_0)
				end

				if chapter_data[var_39_2 .. "-" .. var_39_3].classification and var_39_3 >= playermodel.levelmode[var_39_2].status then
					global_basic_scene:addChild(TalkLayer:create(chapter_data[var_39_2 .. "-" .. var_39_3].classification, nil, TALK_TYPE_BEFORE_BOSS, "", var_42_0, 1), ZORDER_TALKLAYER)
				else
					var_42_0()
				end
			end

			local var_39_11 = RoleDefault:getInstance():getIntegerForKey("activityarray", 1)

			LayerManager:pushInLayer("LevelDetailLayer", {
				fight_type = "ADVENTURE",
				isUmaru = true,
				level = 1,
				mode = var_39_2,
				chapter = var_39_3,
				callback = function()
					return
				end,
				adventuresurecallback = function()
					require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", {
						initindex = var_39_11,
						mode = var_39_2,
						configtype = CONFIG_TYPE_ADVENTURE,
						configcallback = var_39_10,
						exitcallback = callback
					})
				end,
				initindex = var_39_11,
				curChapterStatus = var_39_4
			})
		end
	end

	local function var_38_1(arg_46_0, arg_46_1)
		if level_manager:isChapterModeUnlocked(arg_46_0, arg_46_1) then
			if self.timers[arg_46_0 .. "-" .. arg_46_1] then
				local var_46_0 = patrol_manager:getPatrolInfo(self.timers[arg_46_0 .. "-" .. arg_46_1].key)

				if var_46_0 and var_46_0.time > 0 then
					-- block empty
				else
					self.timers[arg_46_0 .. "-" .. arg_46_1] = nil
				end
			else
				local var_46_1 = arg_46_0 .. "-" .. arg_46_1

				if patrol_manager:getPatrolState(arg_46_0 .. "-" .. arg_46_1) == 3 then
					self.timers[var_46_1] = {
						index = index,
						key = var_46_1
					}
				end
			end
		end
	end

	self.chapterTV = cc.TableView:create(cc.size(var_0_25, var_0_26))

	self.chapterTV:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.chapterTV:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
	self.chapterTV:setPosition(cc.p(var_0_27, var_0_28))
	self.chapterTV:setDelegate()
	self.maplayer:addChild(self.chapterTV, 2)
	self.chapterTV:registerScriptHandler(function(arg_47_0, arg_47_1)
		if arg_47_1 == 0 then
			return var_0_29, self.levelmapcellheight + var_0_31
		elseif arg_47_1 + 1 == math.ceil(self.chapterTV.totalChapters / self.curmapjsonchapternum) then
			return var_0_29, self.levelmapcellheight + var_0_32
		else
			return var_0_29, self.levelmapcellheight
		end
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.chapterTV:registerScriptHandler(function(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_0:dequeueCell()

		if not var_48_0 then
			var_48_0 = cc.TableViewCell:create()

			var_48_0:setName("cell_" .. arg_48_1)
		end

		;(function(...)
			for iter_49_0 = 1, self.curmapjsonchapternum do
				if not var_48_0:getChildByName("sp_" .. iter_49_0) then
					local var_49_0 = ChapterSpriteUmaru:create({
						curcity = self.curcity
					})

					var_49_0:_setSwallowTouches(false)
					var_49_0:setName("sp_" .. iter_49_0)
					var_48_0:addChild(var_49_0, 10)
					var_49_0:_addTouchEventListener(var_38_0)
				else
					local var_49_1 = var_48_0:getChildByName("sp_" .. iter_49_0)
					local var_49_2 = var_49_1:getChildByName("biling")
					local var_49_3 = var_49_1:getChildByName("curtag")

					var_49_2:setVisible(false)
					var_49_3:setVisible(false)
				end
			end
		end)()

		local var_48_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
		local var_48_3 = level_manager:getModeTotalChapter(var_48_2)
		local var_48_4 = 0

		if arg_48_1 == 0 then
			var_48_4 = var_0_31
		end

		if arg_48_1 == math.ceil(var_48_3 / self.curmapjsonchapternum) then
			var_48_4 = -var_0_32
		end

		if math.ceil(var_48_3 / self.curmapjsonchapternum) == 1 then
			var_48_4 = 0
		end

		if arg_48_1 + 1 <= math.ceil(var_48_3 / self.curmapjsonchapternum) then
			var_48_0:setVisible(true)
			;(function(...)
				if not var_48_0:getChildByName("map") then
					local var_50_0 = self:getMapObj()

					var_50_0:setName("map")

					var_50_0.city = self.curcity

					var_48_0:addChild(var_50_0)
				end

				if var_48_0:getChildByName("map").city ~= self.curcity then
					var_48_0:getChildByName("map"):removeFromParent()

					local var_50_1 = self:getMapObj()

					var_50_1:setName("map")

					var_50_1.city = self.curcity

					var_48_0:addChild(var_50_1)
				end

				local var_50_2 = var_48_0:getChildByName("map")
				local var_50_3 = var_50_2:getChildByName("area_1")

				var_50_2:setPositionY((self.levelmapcellheight - 1136) / 2 + var_48_4)
				var_50_2:getChildByName("route"):setPositionX(363)
				var_50_2:getChildByName("area_2"):setPositionX(456)
				var_50_2:getChildByName("line_above"):setPositionX(419)
				var_50_2:getChildByName("line_under"):setPositionX(496)
			end)()

			local var_48_5 = var_48_0:getChildByName("map")

			if var_48_5:getChildByName("line_under") then
				var_48_5:getChildByName("line_under"):setVisible(arg_48_1 ~= 0)
			end

			if var_48_5:getChildByName("line_above") then
				var_48_5:getChildByName("line_above"):setVisible(arg_48_1 + 1 ~= math.ceil(var_48_3 / self.curmapjsonchapternum))
			end

			local var_48_6 = 1

			while var_48_0:getChildByName("sp_" .. var_48_6) do
				var_48_0:getChildByName("sp_" .. var_48_6):setVisible(false)

				var_48_6 = var_48_6 + 1
			end

			local var_48_7 = 1

			while var_48_5:getChildByName("area_" .. var_48_7) do
				var_48_5:getChildByName("area_" .. var_48_7):setVisible(false)

				var_48_7 = var_48_7 + 1
			end

			for iter_48_0 = 1, self.curmapjsonchapternum do
				local var_48_8 = var_48_0:getChildByName("sp_" .. iter_48_0)

				if var_48_3 >= arg_48_1 * self.curmapjsonchapternum + iter_48_0 and var_48_5:getChildByName("area_" .. iter_48_0) then
					var_48_8:setVisible(true)

					local var_48_9 = {
						timer = self.timers[var_48_2 .. "-" .. arg_48_1 * self.curmapjsonchapternum + iter_48_0],
						chapter = arg_48_1 * self.curmapjsonchapternum + iter_48_0,
						curcity = self.curcity
					}

					var_48_9.curdifficuty = self.curdifficuty or 1
					var_48_8.chapter = arg_48_1 * self.curmapjsonchapternum + iter_48_0

					var_48_8:update(var_48_9)

					local var_48_10 = var_48_5:getChildByName("area_" .. iter_48_0):getPositionX()

					if level_manager:getChapterStrongholdLv(var_48_2, arg_48_1 * self.curmapjsonchapternum + iter_48_0) ~= 1 and (arg_48_1 * self.curmapjsonchapternum + iter_48_0) % 2 == 1 then
						var_48_10 = var_48_10 - 33
					end

					var_48_8:setPosition(cc.p(var_48_10, var_48_5:getChildByName("area_" .. iter_48_0):getPositionY() + (self.levelmapcellheight - 1136) / 2 + var_48_4 - 35))
					var_38_1(var_48_2, arg_48_1 * self.curmapjsonchapternum + iter_48_0)

					local var_48_11 = patrol_manager:getPatrolInfo(var_48_2 .. "-" .. arg_48_1 * self.curmapjsonchapternum + iter_48_0)

					if var_48_11 then
						var_48_8:updateTimer(var_0_24(var_48_11.time))
					end
				end
			end
		else
			var_48_0:setVisible(false)
		end

		return var_48_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.chapterTV:registerScriptHandler(function(arg_51_0, arg_51_1)
		self.chapterTV.totalChapters = level_manager:getModeTotalChapter((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

		return math.ceil(self.chapterTV.totalChapters / self.curmapjsonchapternum)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.chapterTV:reloadData()
end

function ActivityUmaruLevelLayer:getMapObj()
	return (ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(self.curcity) .. ".json"))
end

function ActivityUmaruLevelLayer:updateMapJsonInfo(...)
	local var_53_0 = self:getMapObj()
	local var_53_1 = 10
	local var_53_2 = 0

	while var_53_0:getChildByName("area_" .. var_53_2 + 1) do
		var_53_2 = var_53_2 + 1
		var_53_1 = var_53_2
	end

	self.curmapjsonchapternum = var_53_1

	if ccui.Helper:seekWidgetByName(var_53_0, "Panel_cell_size") then
		self.levelmapcellheight = ccui.Helper:seekWidgetByName(var_53_0, "Panel_cell_size"):getContentSize().height or var_0_30
	end
end

function ActivityUmaruLevelLayer:updateShowingCells()
	local var_54_0 = {
		cellsize = cc.size(var_0_29, self.levelmapcellheight)
	}
	local var_54_1 = level_manager:getModeTotalChapter((level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)))

	if var_54_1 ~= self.chapterTV.totalChapters then
		var_54_0.maxcount = math.ceil(math.max(var_54_1, self.chapterTV.totalChapters) / self.curmapjsonchapternum)
		self.chapterTV.totalChapters = math.max(self.chapterTV.totalChapters, var_54_1)
	else
		var_54_0.maxcount = math.ceil(var_54_1 / self.curmapjsonchapternum)
	end

	local var_54_2, var_54_3 = GetTableViewShowCellIdx(self.chapterTV, var_54_0)

	for iter_54_0 = var_54_2, var_54_3 do
		self.chapterTV:updateCellAtIndex(iter_54_0)
	end

	self.chapterTV.totalChapters = var_54_1

	if not self.updatePatrolTime then
		self:scrollTableView()
	end
end

function ActivityUmaruLevelLayer:scrollTableView()
	local var_55_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
	local var_55_2 = level_manager:getModeTotalChapter(var_55_1)
	local var_55_5 = math.max(0, (math.min(level_manager:getCurChapter(var_55_1) <= 4 and 0 or (level_manager:getCurChapter(var_55_1) - 4) / var_55_2 * 100 - var_0_26 / self.levelmapcellheight / 2, 100)))

	self.chapterTV:scrollToPercent((math.ceil(var_55_2 / self.curmapjsonchapternum) == 1 or nil) and 0, nil, false)
end

function ActivityUmaruLevelLayer:initMapLockWord()
	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, GameDisplay.height / 2)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self.uilayer:addChild(self.mapLockWord)

	local var_56_0 = ccui.ImageView:create("LevelMapUmaru/cover_locked.png", var_0_0)

	var_56_0:setScale9Enabled(true)
	var_56_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_56_0:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_56_0)

	local var_56_1 = ccui.ImageView:create("LevelMapUmaru/wordbg.png", var_0_0)

	var_56_1:setName("mapLockWordBg")
	var_56_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_56_1)

	local var_56_2 = ccui.ImageView:create("LevelMapUmaru/ui_lock.png", var_0_0)

	var_56_2:setAnchorPoint(cc.p(1, 0.5))
	var_56_2:setPosition(cc.p(640, GameDisplay.height / 2))
	var_56_2:setName("lockui1")
	self.mapLockWord:addChild(var_56_2)

	local var_56_3 = ccui.ImageView:create("LevelMapUmaru/ui_lock.png", var_0_0)

	var_56_3:setAnchorPoint(cc.p(0, 0.5))
	var_56_3:setPosition(cc.p(0, GameDisplay.height / 2))
	var_56_3:setFlippedY(true)
	var_56_3:setFlippedX(true)
	var_56_3:setName("lockui2")
	self.mapLockWord:addChild(var_56_3)

	local var_56_4 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_56_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_56_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_56_4:setName("word")
	self.mapLockWord:addChild(var_56_4)
	self.mapLockWord:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		if not level_manager:isCityCanUnlock(self.curcity) then
			return
		end

		local function var_57_0()
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
				self:playUnlockAni(var_57_0)
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
			end
		})
	end)
end

function ActivityUmaruLevelLayer:updateCityMapLayer(arg_61_1)
	local var_61_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)
	local var_61_2 = level_manager:getCityConf(self.curcity)

	self.bgNode:loadTexture(var_0_16[self.curcity])

	for iter_61_0 = 1, level_manager:getModeTotalChapter(var_61_1) do
		if level_manager:isChapterModeUnlocked(var_61_1, iter_61_0) then
			if self.timers[var_61_1 .. "-" .. iter_61_0] then
				local var_61_3 = patrol_manager:getPatrolInfo(self.timers[var_61_1 .. "-" .. iter_61_0].key)

				if not var_61_3 or var_61_3.time <= 0 then
					self.timers[var_61_1 .. "-" .. iter_61_0] = nil
				end
			else
				local var_61_4 = var_61_1 .. "-" .. iter_61_0
				local var_61_5 = patrol_manager:getPatrolState(var_61_1 .. "-" .. iter_61_0)

				if var_61_5 == 3 then
					self.timers[var_61_4] = {
						index = iter_61_0,
						key = var_61_4
					}
				elseif var_61_5 == 2 then
					-- block empty
				end
			end
		end
	end

	self.chapterTV:reloadData()
	self:scrollTableView()
end

function ActivityUmaruLevelLayer:updateMapLockWord(arg_62_1)
	if level_manager:isCityUnlocked(arg_62_1) then
		self.mapLockWord:setVisible(false)

		return
	end

	self.mapLockWord:setVisible(true)

	if not level_manager:checkUnlockTime(arg_62_1) then
		self.mapLockWord:getChildByName("word"):setString(os.date("%m-%d %H:%M", level_manager:getCityUnlockTime(arg_62_1)) .. L_COMMON_WARNING.Time_Lock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMapUmaru/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMapUmaru/ui_lock.png", var_0_0)
	elseif level_manager:isCityCanUnlock(arg_62_1) then
		self.mapLockWord:getChildByName("word"):setString(L_MAP_CITY_CHAPTERS.Can_Unlock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMapUmaru/ui_canlock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMapUmaru/ui_canlock.png", var_0_0)
	else
		self.mapLockWord:getChildByName("word"):setString(L_COMMON_WARNING.Locking)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMapUmaru/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMapUmaru/ui_lock.png", var_0_0)
	end
end

function ActivityUmaruLevelLayer:updateCityMapOnSelectDifficulty()
	local var_63_0 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)

	self.chapterTV:reloadData()
	self:scrollTableView()
end

function ActivityUmaruLevelLayer:playSelectCityAni()
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

function ActivityUmaruLevelLayer:playShowCityAni()
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

function ActivityUmaruLevelLayer:playInitShowAni()
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

local var_0_33 = {
	"LevelMapUmaru/img_easymode.png",
	"LevelMapUmaru/img_hardmode.png",
	"LevelMapUmaru/img_hellmode.png",
	"LevelMapUmaru/img_nightmaremode.png"
}

function ActivityUmaruLevelLayer:playSelectDifficultyAni()
	local var_70_0 = cc.Layer:create()

	self:addChild(var_70_0, var_0_13.DIFFICULTYANI)

	local var_70_1 = cc.Layer:create()

	var_70_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	self:addChild(var_70_1, var_0_13.DIFFICULTYANI)

	local var_70_2

	if config._DEBUG then
		var_70_2 = cc.Sprite:create("LevelMapUmaru/img_switchmodebg.png") or cc.Sprite:createWithSpriteFrameName("LevelMapUmaru/img_switchmodebg.png")
	end

	var_70_2:setPosition(cc.p(320, 568))
	var_70_1:addChild(var_70_2)

	local var_70_3

	if config._DEBUG then
		var_70_3 = cc.Sprite:create(var_0_33[self.curdifficuty]) or cc.Sprite:createWithSpriteFrameName(var_0_33[self.curdifficuty])
	end

	var_70_3:setPosition(cc.p(320, 568))
	var_70_1:addChild(var_70_3)

	self._playingani = true

	self:removeGuidesOnLayer()
	var_70_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:cleanAllTimers()
		self:updateCityMapOnSelectDifficulty()
	end)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function ActivityUmaruLevelLayer:playExitAni()
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

function ActivityUmaruLevelLayer:playUnlockAni(arg_75_1)
	self._playingani = true

	audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/jiesuotexiao.ExportJson")
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/dianwei.ExportJson")
	self.mapLockWord:getChildByName("word"):setVisible(false)
	self.mapLockWord:getChildByName("lockui1"):setVisible(false)
	self.mapLockWord:getChildByName("lockui2"):setVisible(false)
	self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(false)

	local var_75_0 = ccs.Armature:create("jiesuotexiao")

	var_75_0:setPosition(cc.p(320, 568))
	self:addChild(var_75_0, 10)
	var_75_0:getAnimation():play("Animation1")
	var_75_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self:updateUIInfos()
		self:updateCityMapLayer(true)
	end)))
	var_75_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_75_1 = ccs.Armature:create("dianwei")

	var_75_1:setPosition(cc.p(320, 568 + GameDisplay.fix_y))
	var_75_1:setVisible(false)
	self:addChild(var_75_1, 10)
	var_75_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8333333333333335), cc.Show:create(), cc.CallFunc:create(function()
		var_75_1:getAnimation():play("Animation1")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if arg_75_1 then
			arg_75_1()
		end
	end), cc.RemoveSelf:create()))
end

function ActivityUmaruLevelLayer:playUnlockCityTalk()
	local var_80_0 = level_manager:getUnlockCityTalk(self.curcity)

	if not var_80_0 then
		return
	end

	global_basic_scene:addChild(TalkLayer:create(var_80_0, nil, talktype, "", TALK_TYPE_BEFORE_BOSS, 1), ZORDER_TALKLAYER)
end

function ActivityUmaruLevelLayer.loadBasicUIAssets(arg_81_0)
	return
end

function ActivityUmaruLevelLayer.unloadBasicUIAssets(arg_83_0)
	return
end

function ActivityUmaruLevelLayer.removeGuidesOnLayer(arg_84_0)
	if LayerManager:getCurrentLayerName() ~= "ActivityUmaruLevelLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function ActivityUmaruLevelLayer.updateGuidesOnLayer(arg_85_0)
	if LayerManager:getCurrentLayerName() ~= "ActivityUmaruLevelLayer" then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function ActivityUmaruLevelLayer:refreshGuidesOnLevelMap()
	if LayerManager:getCurrentLayerName() ~= "ActivityUmaruLevelLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function ActivityUmaruLevelLayer:getCurCity()
	return self.curcity
end

function ActivityUmaruLevelLayer:initStarRewardUI()
	local var_88_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_88_1) .. "/" .. level_manager:getModeTotalChapter(var_88_1) * 3)
	self.starReward:addTouchEventListener(function(arg_89_0, arg_89_1)
		if arg_89_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			cityType = self.initcitytype,
			mode = var_88_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_88_1) then
		self.starRewardRedDot:setVisible(true)
	else
		self.starRewardRedDot:setVisible(false)
	end
end

function ActivityUmaruLevelLayer:updateStarRewardUI()
	local var_91_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_91_1) .. "/" .. level_manager:getModeTotalChapter(var_91_1) * 3)
	self.starReward:addTouchEventListener(function(arg_92_0, arg_92_1)
		if arg_92_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			cityType = self.initcitytype,
			mode = var_91_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_91_1) then
		self.starRewardRedDot:setVisible(true)
	else
		self.starRewardRedDot:setVisible(false)
	end
end

function ActivityUmaruLevelLayer:updateBossImg()
	local var_94_0 = self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or 1

	if not self.bossimg then
		self.bossimg = ccui.ImageView:create("GUI/image.png", var_0_0)

		self:addChild(self.bossimg, var_0_13.BOSSIMG)

		local var_94_1 = ccui.Layout:create()

		var_94_1:setTouchEnabled(true)
		var_94_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_94_1:setAnchorPoint(cc.p(0, 0))
		var_94_1:setPosition(cc.p(0, -GameDisplay.fix_y))
		var_94_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_94_1:setBackGroundColor(cc.c3b(0, 0, 0))
		self:addChild(var_94_1, -10)
	end

	local var_94_2, var_94_3, var_94_4, var_94_5, var_94_6, var_94_7, var_94_8, var_94_9 = level_manager:get_mode_bossimg((level_manager:getModeByDifficulty(self.curcity, var_94_0)))

	self.bossimg:loadTexture("roleimage/role/" .. var_94_2 .. ".png")
	self.bossimg:setPositionX(tonumber(string.split(var_94_3, ",")[1]) + tonumber(string.split(var_94_4, ",")[1]))
	self.bossimg:setPositionY(tonumber(string.split(var_94_3, ",")[2]) + tonumber(string.split(var_94_4, ",")[2]) + GameDisplay.fix_y)
	self.bossimg:setScale(var_94_5)
end
