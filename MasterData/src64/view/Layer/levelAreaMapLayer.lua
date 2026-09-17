levelAreaMapLayer = class("levelAreaMapLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local patrol_manager = require("controller.patrol_manager")
local barrage_manager = require("controller.barrage_manager")
local item_data = require("data.item_data")
local CityList = require("view.Sprite.CityList")
local var_0_10 = {
	LRTIP = 7,
	LOCKWORD = 4,
	BASIC = 6,
	CHAPTERS = 2,
	COVER = 3,
	CITYLIST = 5,
	MAP = 1
}
local var_0_11 = {
	NEW = "LevelMap/city_frame_new.png",
	SELECT = "LevelMap/city_frame_selected.png",
	NORMAL = "LevelMap/city_frame_normal.png"
}
local var_0_12 = "CityMap/title/"
local var_0_13 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}
local var_0_14 = {
	426,
	310,
	196,
	82
}
local var_0_16

function levelAreaMapLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = levelAreaMapLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function levelAreaMapLayer.getInstance()
	return var_0_16
end

function levelAreaMapLayer:init(arg_4_1)
	var_0_16 = self
	self._playingani = false

	if arg_4_1 then
		self.initcity = arg_4_1.initcity
		self.initdifficulty = arg_4_1.initdifficulty
		self.jumpselet = arg_4_1.jumpselet
	end

	patrol_manager:reset()
	self:initTimers()
	level_manager:getModesLockState(function()
		self:initBasicUILayer()
		self:initCityMapLayer()
		self:playInitShowAni()
		self:fullScreen()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_16 = false
		end
	end)
end

function levelAreaMapLayer:fullScreen()
	self.panelDifficulty.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.panelDifficulty:getPositionY(), TRANSFORM_UNIT.PX)

	self.panelDifficulty:setPositionY(self.panelDifficulty.full_posY)

	self.cityTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.cityTitle:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityTitle:setPositionY(self.cityTitle.full_posY)

	self.btnReturn.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btnReturn:getPositionY(), TRANSFORM_UNIT.PX)

	self.btnReturn:setPositionY(self.btnReturn.full_posY - 120)

	self.cityList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityList:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityList:setPositionY(self.cityList.full_posY)

	local var_7_0 = ccui.Helper:seekWidgetByName(self.uilayer, "city_panel_frame")

	var_7_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_7_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_7_0:setPositionY(var_7_0.full_posY)
end

local function var_0_17(arg_8_0)
	if arg_8_0 >= 3600 then
		return string.format("%02d:%02d:%02d", math.floor(arg_8_0 / 3600), math.floor(arg_8_0 % 3600 / 60), arg_8_0 % 60)
	else
		return string.format("%02d:%02d", math.floor(arg_8_0 / 60), arg_8_0 % 60)
	end
end

function levelAreaMapLayer:initTimers()
	self.timers = {}

	self:scheduleUpdateWithPriorityLua(function(arg_10_0)
		for iter_10_0, iter_10_1 in pairs(self.timers) do
			local var_10_0 = patrol_manager:getPatrolInfo(iter_10_1.key)

			if var_10_0 then
				if var_10_0.time <= 0 then
					self.chapters[iter_10_1.index]:getChildByName("timer"):setVisible(false)
					self.chapters[iter_10_1.index]:getChildByName("completetag"):setVisible(true)
				else
					self.chapters[iter_10_1.index]:getChildByName("timer"):setVisible(true)
					self.chapters[iter_10_1.index]:getChildByName("timer"):setString(var_0_17(var_10_0.time))
				end
			else
				self.timers[iter_10_0] = nil

				self.chapters[iter_10_1.index]:getChildByName("timer"):setVisible(false)
			end
		end
	end, 0)
end

function levelAreaMapLayer.cleanAllTimers(arg_11_0)
	arg_11_0.timers = {}
end

function levelAreaMapLayer:changeTheCityList(arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs((level_manager:getAreaList())) do
		table.insert(arg_12_1, iter_12_1)

		var_12_0[iter_12_0] = {
			areaid = level_manager:getAreaId(iter_12_1),
			cityid = iter_12_1
		}
	end

	if not self.initcity then
		return arg_12_1
	end

	local var_12_1

	if level_manager:isSubCity(self.initcity) then
		for iter_12_2, iter_12_3 in ipairs(var_12_0) do
			if iter_12_3.areaid == level_manager:getAreaId(self.initcity) then
				var_12_1 = iter_12_3.cityid
			end
		end
	end

	if var_12_1 then
		for iter_12_4, iter_12_5 in pairs(arg_12_1) do
			if iter_12_5 == var_12_1 then
				arg_12_1[iter_12_4] = self.initcity
			end
		end
	end

	return arg_12_1
end

function levelAreaMapLayer:initBasicUILayer()
	self:loadBasicUIAssets()

	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelMap.json" or "LevelMap.ExportJson")

	self:addChild(self.uilayer, var_0_10.BASIC)

	self.cityTitle = ccui.Helper:seekWidgetByName(self.uilayer, "title")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.uilayer, "btn_return")

	self.btnReturn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
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

function levelAreaMapLayer:initCityList()
	self.cityList = CityList:create()

	self:addChild(self.cityList, var_0_10.CITYLIST)
	self.cityList:setVisible(false)

	self.curcity = nil
	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local var_15_0 = self:changeTheCityList(level_manager:getCityList())

	local function var_15_1(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_16_0:getTouchBeganPosition().x - arg_16_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_16_0:getTag())

		for iter_16_0, iter_16_1 in ipairs(var_15_0) do
			self:updateCityBntTips(iter_16_1)
		end

		self:updateLeftRightTigEffect()
	end

	local function var_15_2(arg_17_0)
		local var_17_0 = ccui.Button:create(var_0_11.NORMAL, var_0_11.NORMAL, var_0_11.NORMAL, var_0_0)

		var_17_0:setName("city" .. arg_17_0)

		var_17_0.areaid = level_manager:getAreaId(arg_17_0)

		local var_17_1 = cc.Sprite:create("CityMap/MiniMap/" .. level_manager:getCityImg(arg_17_0) .. ".png")

		var_17_1:setPosition(cc.p(var_17_0:getContentSize().width / 2, var_17_0:getContentSize().height / 2))
		var_17_1:setName("minimap")
		var_17_0:addChild(var_17_1, -1)

		local var_17_2 = ccui.ImageView:create(var_0_11.SELECT, var_0_0)

		var_17_2:setPosition(cc.p(var_17_0:getContentSize().width / 2, var_17_0:getContentSize().height / 2))
		var_17_2:setName("frame")
		var_17_2:setVisible(false)
		var_17_0:addChild(var_17_2, 2)

		if not level_manager:isCityUnlocked(arg_17_0) then
			l2utils:shaderGrayDark(var_17_0:getVirtualRenderer())
			l2utils:shaderGrayDark(var_17_1)

			if not level_manager:isCityCanUnlock(arg_17_0) then
				l2utils:shaderNode(var_17_2:getVirtualRenderer())
			end
		else
			l2utils:shaderDarkNode(var_17_0:getVirtualRenderer())
			l2utils:shaderDarkNode(var_17_1)
		end

		var_17_0:addTouchEventListener(var_15_1)

		return var_17_0
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_3 = var_15_2(iter_15_1)

		self.cityList:pushInCity(var_15_3)

		self.cities[iter_15_1] = var_15_3
		self.index_to_city[var_15_3:getTag()] = iter_15_1
		self.city_to_index[iter_15_1] = var_15_3:getTag()
	end

	self.cityList:registerSelectCityHandler(function(arg_18_0)
		if self.curcity == self.index_to_city[arg_18_0] then
			return
		end

		self:updateCityOnUnSelect(self.curcity)

		self.curcity = self.index_to_city[arg_18_0]

		self:updateCityOnSelect(self.curcity)

		if self.cities[arg_18_0] and self.cities[arg_18_0].areaid then
			LayerManager:switchShowLayer((level_manager:getAreaJumpLayer(self.cities[arg_18_0].areaid)))

			return
		end

		self:playSelectCityAni()

		for iter_18_0, iter_18_1 in ipairs(var_15_0) do
			self:updateCityBntTips(iter_18_1)
		end

		self:updateLeftRightTigEffect()
	end)

	self.curcity = self.initcity or level_manager:getCurFightCity()

	self:updateCityOnSelect(self.curcity)
	self.cityList:jumpToIndex(self.city_to_index[self.curcity])

	for iter_15_2, iter_15_3 in ipairs(var_15_0) do
		self:updateCityBntTips(iter_15_3)
	end

	self:updateLeftRightTigEffect()
end

function levelAreaMapLayer:updateCityBntTips(arg_19_1)
	local var_19_0 = self.cities[arg_19_1]
	local var_19_1 = self.cities[arg_19_1]:getChildByName("frame")

	local function var_19_2()
		return self.city_to_index[arg_19_1] - self.city_to_index[self.curcity] == -1
	end

	local var_19_3 = 0
	local var_19_4 = 45
	local var_19_7 = 3
	local var_19_8 = self.cityList:getCityBtnDirection(arg_19_1)

	if level_manager:isCityCanUnlock(arg_19_1) and var_19_8 == var_19_7 then
		if not var_19_0:getChildByName("newtag") then
			var_19_1:loadTexture(var_0_11.NEW, var_0_0)
			var_19_1:setVisible(true)

			local var_19_9 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_19_9:setAnchorPoint(cc.p(0.5, 0))

			if var_19_2() then
				var_19_9:setPosition(cc.p(150 - var_19_4, 100 + var_19_3))
			else
				var_19_9:setPosition(cc.p(150, 100))
			end

			var_19_9:setName("newtag")
			var_19_0:addChild(var_19_9)
		elseif var_19_2() then
			var_19_0:getChildByName("newtag"):setPosition(cc.p(150 - var_19_4, 100 + var_19_3))
		else
			var_19_0:getChildByName("newtag"):setPosition(cc.p(150, 100))
		end
	elseif var_19_0:getChildByName("newtag") then
		var_19_0:removeChildByName("newtag")
	end

	if patrol_manager:isCityFinishedPatrol(arg_19_1) and var_19_8 == var_19_7 then
		if not var_19_0:getChildByName("reddot") then
			local var_19_10 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_19_10:setAnchorPoint(cc.p(1, 1))

			if var_19_2() then
				var_19_10:setPosition(var_19_0:getContentSize().width - 10 - var_19_4, var_19_0:getContentSize().height + 18 + var_19_3)
			else
				var_19_10:setPosition(var_19_0:getContentSize().width - 10, var_19_0:getContentSize().height + 18)
			end

			var_19_10:setName("reddot")
			var_19_0:addChild(var_19_10, 9)
		elseif var_19_2() then
			var_19_0:getChildByName("reddot"):setPosition(var_19_0:getContentSize().width - 10 - var_19_4, var_19_0:getContentSize().height + 18 + var_19_3)
		else
			var_19_0:getChildByName("reddot"):setPosition(var_19_0:getContentSize().width - 10, var_19_0:getContentSize().height + 18)
		end
	elseif var_19_0:getChildByName("reddot") then
		var_19_0:removeChildByName("reddot")
	end

	if level_manager:isCityNewDifficulty(arg_19_1) and var_19_8 == var_19_7 then
		if not var_19_0:getChildByName("newDifficultyTips") then
			local var_19_11 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_19_11:setAnchorPoint(cc.p(0.5, 0))

			if var_19_2() then
				var_19_11:setPosition(cc.p(150 - var_19_4, 100 + var_19_3))
			else
				var_19_11:setPosition(cc.p(150, 100))
			end

			var_19_11:setName("newDifficultyTips")
			var_19_0:addChild(var_19_11)
		elseif var_19_2() then
			var_19_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150 - var_19_4, 100 + var_19_3))
		else
			var_19_0:getChildByName("newDifficultyTips"):setPosition(cc.p(150, 100))
		end
	elseif var_19_0:getChildByName("newDifficultyTips") then
		var_19_0:removeChildByName("newDifficultyTips")
	end

	if level_manager:checkIsNewStarRewardInCity(arg_19_1) and var_19_8 == var_19_7 then
		if not var_19_0:getChildByName("newStarTips") then
			local var_19_12 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

			var_19_12:setAnchorPoint(cc.p(1, 1))

			if var_19_2() then
				var_19_12:setPosition(var_19_0:getContentSize().width - 10 - var_19_4, var_19_0:getContentSize().height + 18 + var_19_3)
			else
				var_19_12:setPosition(var_19_0:getContentSize().width - 10, var_19_0:getContentSize().height + 18)
			end

			var_19_12:setName("newStarTips")
			var_19_0:addChild(var_19_12, 9)
		elseif var_19_2() then
			var_19_0:getChildByName("newStarTips"):setPosition(var_19_0:getContentSize().width - 10 - var_19_4, var_19_0:getContentSize().height + 18 + var_19_3)
		else
			var_19_0:getChildByName("newStarTips"):setPosition(var_19_0:getContentSize().width - 10, var_19_0:getContentSize().height + 18)
		end
	else
		local var_19_13
		local var_19_14

		if var_19_0:getChildByName("newStarTips") then
			var_19_0:removeChildByName("newStarTips")

			var_19_13 = var_19_8 == var_19_7
			var_19_14 = ipairs
		end
	end

	for iter_19_0, iter_19_1 in var_19_14({
		"newDifficultyTips",
		"reddot",
		"newPatrolTips",
		"newStarTips"
	}) do
		if var_19_0:getChildByName(iter_19_1) then
			var_19_0:getChildByName(iter_19_1):setVisible(var_19_13)

			var_19_13 = false
		end
	end
end

function levelAreaMapLayer:updateLeftRightTigEffect()
	local var_21_0 = self:changeTheCityList(level_manager:getCityList())

	local function var_21_1(arg_22_0)
		if level_manager:isCityCanUnlock(arg_22_0) then
			return true
		end

		if patrol_manager:isCityFinishedPatrol(arg_22_0) then
			return true
		end

		if patrol_manager:isCityNewPatrol(arg_22_0) then
			return true
		end

		if level_manager:isCityNewDifficulty(arg_22_0) then
			return true
		end

		if PlotManager.plot_layer_config["levelAreaMapLayer" .. arg_22_0] then
			return true
		end

		if level_manager:checkIsNewStarRewardInCity(arg_22_0) then
			return true
		end

		return false
	end

	local function var_21_2()
		local var_24_0 = false

		for iter_24_0, iter_24_1 in ipairs(var_21_0) do
			if self.cityList:getCityBtnDirection(iter_24_1) == 2 and var_21_1(iter_24_1) then
				var_24_0 = true

				break
			end
		end

		return var_24_0
	end

	if not self:getChildByName("left_tag") then
		local var_21_3 = ccui.ImageView:create("LevelMap/left_right_tag.png", var_0_0)

		var_21_3:setPosition(cc.p(18 - GameDisplay.fix_x, 128 - GameDisplay.fix_y))
		var_21_3:setName("left_tag")
		var_21_3:setVisible(false)
		self:addChild(var_21_3, var_0_10.LRTIP)
		var_21_3:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(18 - GameDisplay.fix_x + 10, 128 - GameDisplay.fix_y + 10)), cc.MoveTo:create(0.5, cc.p(18 - GameDisplay.fix_x, 128 - GameDisplay.fix_y)))))
	end

	if not self:getChildByName("right_tag") then
		local var_21_4 = ccui.ImageView:create("LevelMap/left_right_tag.png", var_0_0)

		var_21_4:setPosition(cc.p(GameDisplay.width - (18 - GameDisplay.fix_x), 128 - GameDisplay.fix_y))
		var_21_4:setScaleX(-1)
		var_21_4:setName("right_tag")
		var_21_4:setVisible(false)
		var_21_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(GameDisplay.width - (18 - GameDisplay.fix_x) - 10, 128 - GameDisplay.fix_y + 10)), cc.MoveTo:create(0.5, cc.p(GameDisplay.width - (18 - GameDisplay.fix_x), 128 - GameDisplay.fix_y)))))
		self:addChild(var_21_4, var_0_10.LRTIP)
	end

	if (function()
		local var_23_0 = false

		for iter_23_0, iter_23_1 in ipairs(var_21_0) do
			if self.cityList:getCityBtnDirection(iter_23_1) == 1 and var_21_1(iter_23_1) then
				var_23_0 = true

				break
			end
		end

		return var_23_0
	end)() then
		-- block empty
	else
		self:getChildByName("left_tag"):setVisible(false)
	end

	if var_21_2() then
		self:getChildByName("right_tag"):setVisible(true)
	else
		self:getChildByName("right_tag"):setVisible(false)
	end
end

function levelAreaMapLayer:getCityByID(arg_25_1)
	return self.cities[arg_25_1]
end

function levelAreaMapLayer:getCityByIndex(arg_26_1)
	return self.cities[self.index_to_city[arg_26_1]]
end

function levelAreaMapLayer:updateCityOnSelect(arg_27_1)
	local var_27_0 = self:getCityByID(arg_27_1)

	if level_manager:isCityUnlocked(arg_27_1) then
		l2utils:recoverShader(var_27_0:getVirtualRenderer())
		l2utils:recoverShader(var_27_0:getChildByName("minimap"))
	else
		l2utils:shaderNode(var_27_0:getVirtualRenderer())
		l2utils:shaderNode(var_27_0:getChildByName("minimap"))
	end

	var_27_0:getChildByName("frame"):setVisible(true)

	if not level_manager:isCityCanUnlock(arg_27_1) then
		var_27_0:getChildByName("frame"):loadTexture(var_0_11.SELECT, var_0_0)
	end

	self:playCityFrameBreath(arg_27_1)
end

function levelAreaMapLayer:updateCityOnUnSelect(arg_28_1)
	local var_28_0 = self:getCityByID(arg_28_1)

	if level_manager:isCityUnlocked(arg_28_1) then
		l2utils:shaderDarkNode(var_28_0:getVirtualRenderer())
		l2utils:shaderDarkNode(var_28_0:getChildByName("minimap"))
	else
		l2utils:shaderGrayDark(var_28_0:getVirtualRenderer())
		l2utils:shaderGrayDark(var_28_0:getChildByName("minimap"))
	end

	if not level_manager:isCityCanUnlock(arg_28_1) then
		var_28_0:getChildByName("frame"):setVisible(false)
	end

	self:stopCityFrameBreath(arg_28_1)
end

function levelAreaMapLayer:updateCityOnUnlock()
	local var_29_0 = self:getCityByID(self.curcity)

	l2utils:recoverShader(var_29_0:getVirtualRenderer())
	l2utils:recoverShader(var_29_0:getChildByName("minimap"))

	if var_29_0:getChildByName("newtag") then
		var_29_0:removeChildByName("newtag")
	end

	var_29_0:getChildByName("frame"):loadTexture(var_0_11.SELECT, var_0_0)
end

function levelAreaMapLayer.playCityFrameBreath(arg_30_0, arg_30_1)
	return
end

function levelAreaMapLayer.stopCityFrameBreath(arg_31_0, arg_31_1)
	return
end

function levelAreaMapLayer:initUIInfos()
	local var_32_0 = self.initdifficulty and level_manager:isCityDifficultyValid(self.curcity, self.initdifficulty) and self.initdifficulty or self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or level_manager:getUnlockedDifficultyInCity(self.curcity)

	if level_manager:isCityUnlocked(self.curcity) then
		self.curdifficuty = var_32_0
		self.finaldifficuty = var_32_0

		self.cityTitle:loadTexture(var_0_12 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = nil

		self.cityTitle:loadTexture(var_0_12 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	self:updateDifficutyPanel()
	self:initStarRewardUI()
	self:initRankUI()
end

function levelAreaMapLayer:updateUIInfos()
	if level_manager:isCityUnlocked(self.curcity) then
		if self.finaldifficuty then
			local var_33_0 = level_manager:getCityDifficulties(self.curcity)
			local var_33_1

			for iter_33_0 = 1, 4 do
				if var_33_0[iter_33_0] and var_33_0[iter_33_0].stat then
					var_33_1 = iter_33_0
				end
			end

			self.curdifficuty = var_33_1 < self.finaldifficuty and var_33_1 or self.finaldifficuty
		else
			self.curdifficuty = self.curcity == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or 1
			self.finaldifficuty = self.curdifficuty
		end

		self.cityTitle:loadTexture(var_0_12 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = nil

		self.cityTitle:loadTexture(var_0_12 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	self:updateDifficutyPanel()
	self:updateRankUI()
	self:updateStarRewardUI()
end

function levelAreaMapLayer:initPanelDifficulty()
	self.panelDifficulty = ccui.Helper:seekWidgetByName(self.uilayer, "panel_difficulty")

	for iter_34_0 = 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_34_0]):addTouchEventListener(function(arg_35_0, arg_35_1)
			if arg_35_1 ~= ccui.TouchEventType.ended then
				return
			end

			if level_manager:isCityNewDifficulty(self.curcity, iter_34_0) then
				level_manager:unMarkModeNew(level_manager:getModeByDifficulty(self.curcity, iter_34_0))
				self:updateDifficutyTips(self.curcity, iter_34_0)
				self:updateCityBntTips(self.curcity)
			end

			if iter_34_0 == self.curdifficuty then
				return
			end

			if self._playingani then
				return
			end

			self:selectDifficulty(iter_34_0)
		end)
	end
end

function levelAreaMapLayer:selectDifficulty(arg_36_1)
	self.curdifficuty = arg_36_1
	self.finaldifficuty = arg_36_1

	self.cityTitle:loadTexture(var_0_12 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
	self:updateDifficutyPanel()
	self:updateRankUI()
	self:updateStarRewardUI()
	self:playSelectDifficultyAni()
end

function levelAreaMapLayer:updateDifficutyPanel()
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in ipairs((level_manager:getCityDifficulties(self.curcity))) do
		if iter_37_1.stat then
			self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_0]):setVisible(true)

			local var_37_1

			if iter_37_0 == self.curdifficuty then
				var_37_1 = "LevelMap/btn_" .. var_0_13[iter_37_0] .. ".png"

				self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_0]):getVirtualRenderer():setOpacity(255)
			else
				var_37_1 = "LevelMap/btn_" .. var_0_13[iter_37_0] .. ".png"

				self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_0]):getVirtualRenderer():setOpacity(170)
			end

			self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_0]):loadTextures(var_37_1, nil, var_37_1, var_0_0)

			var_37_0 = var_37_0 + 1

			self:updateDifficutyTips(self.curcity, iter_37_0)
		else
			self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_0]):setVisible(false)
		end
	end

	for iter_37_2 = 1, var_37_0 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_2]):setPositionX(var_0_14[var_37_0 + 1 - iter_37_2])
		self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_2]):setVisible(true)
	end

	for iter_37_3 = var_37_0 + 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_13[iter_37_3]):setVisible(false)
	end

	if var_37_0 == 1 then
		self.panelDifficulty:getChildByName("btn_" .. var_0_13[var_37_0]):setVisible(false)
	end
end

function levelAreaMapLayer:updateDifficutyTips(arg_38_1, arg_38_2)
	local var_38_0 = self.panelDifficulty:getChildByName("btn_" .. var_0_13[arg_38_2])
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
			local var_38_3 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

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
		for iter_38_0, iter_38_1 in ipairs({
			"newDifficultyTips",
			"reddot",
			"newPatrolTips"
		}) do
			if var_38_0:getChildByName(iter_38_1) and var_38_1[iter_38_1] then
				var_38_0:getChildByName(iter_38_1):setVisible(true)
			end
		end
	end
end

function levelAreaMapLayer:initCityMapLayer()
	local var_39_0 = self.initcity or level_manager:getCurFightCity()
	local var_39_1 = self.initdifficulty and level_manager:isCityDifficultyValid(var_39_0, self.initdifficulty) and self.initdifficulty or var_39_0 == level_manager:getCurFightCity() and level_manager:getCurFightDifficulty() or level_manager:getUnlockedDifficultyInCity(var_39_0)
	local var_39_2 = level_manager:getModeByDifficulty(var_39_0, var_39_1)

	self.maplayer = ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(var_39_0) .. ".json")

	self:addChild(self.maplayer, var_0_10.MAP)
	self.maplayer:getChildByName("bgframe"):setScaleY(GameDisplay.height / self.maplayer:getChildByName("bgframe"):getContentSize().height)

	local var_39_3 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_39_3:setFlippedX(true)
	var_39_3:setFlippedY(true)
	var_39_3:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_39_3, 1)

	if level_manager:isCityUnlocked(var_39_0) then
		if config._DEBUG then
			self.cover = cc.Sprite:create("LevelMap/cover_" .. var_0_13[var_39_1] .. ".png") or cc.Sprite:createWithSpriteFrameName("LevelMap/cover_" .. var_0_13[var_39_1] .. ".png")
		end

		self.cover:setAnchorPoint(cc.p(0.5, 0))
		self.cover:setPosition(cc.p(320, -GameDisplay.fix_y))
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
		self.cover:setName("colorcover")
		self.maplayer:addChild(self.cover, 1)
	end

	self:initCityMapChapters()
	self:initSpecialChapter()

	for iter_39_0 = 1, math.min(level_manager:getModeTotalChapter(var_39_2), 10) do
		local var_39_4 = self.maplayer:getChildByName("area_" .. iter_39_0)

		self:updateChapters(iter_39_0)

		if level_manager:isChapterModeUnlocked(var_39_2, iter_39_0) then
			var_39_4:setVisible(true)
			var_39_4:loadTexture("Maps/" .. var_0_13[var_39_1] .. "point.png")
		else
			var_39_4:setVisible(false)
		end
	end

	self:updateSpecialChapter()
	self:initMapLockWord()
	self:updateMapLockWord(var_39_0)
end

function levelAreaMapLayer:initMapLockWord()
	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self:addChild(self.mapLockWord, var_0_10.LOCKWORD)

	local var_40_0 = ccui.ImageView:create("LevelMap/cover_locked.png", var_0_0)

	var_40_0:setScale9Enabled(true)
	var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_40_0:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_40_0)

	local var_40_1 = ccui.ImageView:create("LevelMap/wordbg.png", var_0_0)

	var_40_1:setName("mapLockWordBg")
	var_40_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_40_1)

	local var_40_2 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_40_2:setAnchorPoint(cc.p(1, 0.5))
	var_40_2:setPosition(cc.p(640, GameDisplay.height / 2))
	var_40_2:setName("lockui1")
	self.mapLockWord:addChild(var_40_2)

	local var_40_3 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_40_3:setAnchorPoint(cc.p(0, 0.5))
	var_40_3:setPosition(cc.p(0, GameDisplay.height / 2))
	var_40_3:setFlippedY(true)
	var_40_3:setFlippedX(true)
	var_40_3:setName("lockui2")
	self.mapLockWord:addChild(var_40_3)

	local var_40_4 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_40_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_40_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_40_4:setName("word")
	self.mapLockWord:addChild(var_40_4)
	self.mapLockWord:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		if not level_manager:isCityCanUnlock(self.curcity) then
			return
		end

		local function var_41_0()
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
				self:playUnlockAni(var_41_0)
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
			end
		})
	end)
end

function levelAreaMapLayer:initCityMapChapters()
	self.chapterlayer = cc.Layer:create()

	self:addChild(self.chapterlayer, var_0_10.CHAPTERS)

	local function var_45_0(arg_46_0, arg_46_1)
		if arg_46_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		local var_46_0 = self.curcity
		local var_46_1 = self.curdifficuty
		local var_46_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
		local var_46_3 = arg_46_0:getTag()
		local var_46_4 = false

		if not level_manager:isChapterModeUnlocked(var_46_2, var_46_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Forbid)
			audio_manager:playeffectMusicTest("sound/invalid")

			var_46_4 = true
		end

		if not level_manager:isChapterModeValid(var_46_2, var_46_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Locking)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		local var_46_5 = patrol_manager:getPatrolInfo(var_46_2 .. "-" .. var_46_3)

		if var_46_5 then
			LayerManager:pushInLayer("PatrolPopLayer", {
				mode = var_46_2,
				chapter = var_46_3,
				time = var_46_5.time,
				arrayid = var_46_5.array,
				callback = function()
					self:updateChapters(var_46_3)
					self:updateCityBntTips(var_46_0, var_46_1)
					self:updateDifficutyTips(var_46_0, var_46_1)
				end
			})
		else
			local var_46_6 = {
				islock = var_46_4,
				mode = var_46_2,
				chapter = var_46_3
			}

			function var_46_6.patrolCallback()
				self:updateChapters(var_46_3)
				self:updateCityBntTips(var_46_0, var_46_1)
				self:updateDifficutyTips(var_46_0, var_46_1)
			end

			LayerManager:pushInLayer("PopChaptersPreviewLayer", var_46_6)
		end
	end

	self.chapters = setmetatable({}, {
		__index = function(arg_49_0, arg_49_1)
			assert(type(arg_49_1) == "number", "Need Number for Chapters Index")

			local var_49_0 = ccui.Button:create("LevelMap/level1_easy.png", "LevelMap/level1_easy.png", "LevelMap/level1_easy.png", var_0_0)

			var_49_0:setName("chapter" .. arg_49_1)
			var_49_0:setPressedActionEnabled(true)
			var_49_0:setAnchorPoint(cc.p(0.5, 0))
			var_49_0:setTag(arg_49_1)
			self.chapterlayer:addChild(var_49_0)

			local var_49_1 = cc.Label:createWithTTF("", "fonts/name.ttf", 27)

			var_49_1:setAnchorPoint(cc.p(1, 0.5))
			var_49_1:setPosition(cc.p(var_49_0:getContentSize().width / 2 + 60, var_49_0:getContentSize().height / 2 + 15))
			var_49_1:setName("name")
			var_49_0:addChild(var_49_1)

			local var_49_2 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_0)

			var_49_2:setPosition(cc.p(var_49_0:getContentSize().width / 2 + 120, var_49_0:getContentSize().height / 2 + 25))
			var_49_2:setName("drop")
			var_49_0:addChild(var_49_2)

			local var_49_3 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_0)

			var_49_3:setPosition(cc.p(var_49_2:getContentSize().width / 2, var_49_2:getContentSize().height / 2))
			var_49_3:setName("dropimg")
			var_49_2:addChild(var_49_3)

			local var_49_4 = ccui.ImageView:create("public/box/1.png", var_0_0)

			var_49_4:setVisible(false)
			var_49_4:setTag(arg_49_1)
			var_49_4:setScale(var_49_3:getContentSize().width / var_49_4:getContentSize().width)
			var_49_4:setPosition(cc.p(var_49_0:getContentSize().width / 2 + 120, var_49_0:getContentSize().height / 2 + 25))
			var_49_4:setName("item")
			var_49_0:addChild(var_49_4)
			var_49_4:setTouchEnabled(true)

			local var_49_5 = ccui.ImageView:create("equipment/1000000.png")

			var_49_5:setScale(var_49_4:getContentSize().width / var_49_5:getContentSize().width)
			var_49_5:setPosition(var_49_4:getContentSize().width / 2, var_49_4:getContentSize().height / 2)
			var_49_5:setName("icon")
			var_49_4:addChild(var_49_5)

			local var_49_6 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_0)

			var_49_6:setAnchorPoint(cc.p(0.5, 0))
			var_49_6:setPosition(cc.p(var_49_0:getContentSize().width / 2, var_49_0:getContentSize().height + 15))
			var_49_6:setVisible(false)
			var_49_6:setName("curtag")
			var_49_0:addChild(var_49_6)

			local var_49_7 = ccui.ImageView:create("LevelMap/img_tag_can_patrol.png", var_0_0)

			var_49_7:setAnchorPoint(cc.p(0, 0))
			var_49_7:setPosition(cc.p(35, 80))
			var_49_7:setVisible(false)
			var_49_7:setName("newtag")
			var_49_0:addChild(var_49_7)

			local var_49_8 = ccui.ImageView:create("LevelMap/img_tagcomplete.png", var_0_0)

			var_49_8:setAnchorPoint(cc.p(0, 0))
			var_49_8:setPosition(cc.p(35, 80))
			var_49_8:setVisible(false)
			var_49_8:setName("completetag")
			var_49_0:addChild(var_49_8)

			local var_49_9 = cc.Label:createWithTTF("00:00", "fonts/number.ttf", 25)

			var_49_9:setAnchorPoint(cc.p(0, 0))
			var_49_9:setPosition(cc.p(42, 88))
			var_49_9:setName("timer")
			var_49_0:addChild(var_49_9)

			for iter_49_0 = 1, LEVEL_STARS_NUM do
				local var_49_10 = ccui.ImageView:create("LevelMap/star_gray.png", var_0_0)

				var_49_10:setName("star" .. iter_49_0)
				var_49_10:setPosition(126 + (iter_49_0 - (LEVEL_STARS_NUM + 1) / 2) * 20, 80)
				var_49_0:addChild(var_49_10)
			end

			var_49_0:addTouchEventListener(var_45_0)
			var_49_4:addTouchEventListener(var_45_0)

			arg_49_0[arg_49_1] = var_49_0

			return var_49_0
		end
	})
end

function levelAreaMapLayer:updateCityMapLayer(arg_50_1)
	local var_50_0 = self.curdifficuty or 1
	local var_50_1 = level_manager:getModeByDifficulty(self.curcity, var_50_0)

	self.maplayer:runAction(cc.Sequence:create(cc.Hide:create(), cc.RemoveSelf:create()))

	self.maplayer = ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(self.curcity) .. ".json")

	self:addChild(self.maplayer, var_0_10.MAP)
	self.maplayer:getChildByName("bgframe"):setScaleY(GameDisplay.height / self.maplayer:getChildByName("bgframe"):getContentSize().height)

	local var_50_2 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_50_2:setFlippedX(true)
	var_50_2:setFlippedY(true)
	var_50_2:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_50_2, 1)

	local var_50_3

	if level_manager:isCityUnlocked(self.curcity) then
		if config._DEBUG then
			self.cover = cc.Sprite:create("LevelMap/cover_" .. var_0_13[var_50_0] .. ".png") or cc.Sprite:createWithSpriteFrameName("LevelMap/cover_" .. var_0_13[var_50_0] .. ".png")
		end

		self.cover:setAnchorPoint(cc.p(0.5, 0))
		self.cover:setPosition(cc.p(320, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)))
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
		self.cover:setName("colorcover")
		self.maplayer:addChild(self.cover, 1)

		var_50_3 = {}
	end

	for iter_50_0 = 1, math.min(level_manager:getModeTotalChapter(var_50_1), 10) do
		local var_50_4 = self.maplayer:getChildByName("area_" .. iter_50_0)

		self:updateChapters(iter_50_0)

		var_50_3[iter_50_0] = true

		if level_manager:isCityUnlocked(self.curcity) and level_manager:isChapterModeUnlocked(var_50_1, iter_50_0) then
			var_50_4:setVisible(true)
			var_50_4:loadTexture("Maps/" .. var_0_13[var_50_0] .. "point.png")
		else
			var_50_4:setVisible(false)
		end
	end

	self:updateSpecialChapter()

	for iter_50_1, iter_50_2 in pairs(self.chapters) do
		if not var_50_3[iter_50_1] then
			local var_50_5 = rawget(self.chapters, iter_50_1)

			if var_50_5 then
				var_50_5:setVisible(false)
			end
		end
	end

	if not arg_50_1 then
		self:updateMapLockWord(self.curcity)
	end
end

function levelAreaMapLayer:updateMapLockWord(arg_51_1)
	if level_manager:isCityUnlocked(arg_51_1) then
		self.mapLockWord:setVisible(false)

		return
	end

	self.mapLockWord:setVisible(true)

	if level_manager:isCityCanUnlock(arg_51_1) then
		self.mapLockWord:getChildByName("word"):setString(L_MAP_CITY_CHAPTERS.Can_Unlock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
	else
		self.mapLockWord:getChildByName("word"):setString(L_COMMON_WARNING.Locking)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_lock.png", var_0_0)
	end
end

function levelAreaMapLayer:updateCityMapOnSelectDifficulty()
	local var_52_0 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
	local var_52_1

	if self.maplayer:getChildByName("colorcover") then
		if config._DEBUG then
			self.cover:setTexture("LevelMap/cover_" .. var_0_13[self.curdifficuty] .. ".png")
		else
			self.cover:setSpriteFrame("LevelMap/cover_" .. var_0_13[self.curdifficuty] .. ".png")
		end

		self.cover:setScaleX(640 / self.cover:getContentSize().width)

		var_52_1 = {}
	end

	for iter_52_0 = 1, math.min(level_manager:getModeTotalChapter(var_52_0), 10) do
		local var_52_2 = self.maplayer:getChildByName("area_" .. iter_52_0)

		self:updateChapters(iter_52_0)

		var_52_1[iter_52_0] = true

		if level_manager:isChapterModeUnlocked(var_52_0, iter_52_0) then
			var_52_2:setVisible(true)
			var_52_2:loadTexture("Maps/" .. var_0_13[self.curdifficuty] .. "point.png")
		else
			var_52_2:setVisible(false)
		end
	end

	self:updateSpecialChapter()

	for iter_52_1, iter_52_2 in pairs(self.chapters) do
		if not var_52_1[iter_52_1] then
			local var_52_3 = rawget(self.chapters, iter_52_1)

			if var_52_3 then
				var_52_3:setVisible(false)
			end
		end
	end
end

function levelAreaMapLayer:updateChapters(arg_53_1)
	local var_53_0 = self.curdifficuty or 1

	self.chapters[arg_53_1]:setVisible(true)

	local var_53_1 = level_manager:getModeByDifficulty(self.curcity, var_53_0)
	local var_53_2 = arg_53_1
	local var_53_3, var_53_4 = self.maplayer:getChildByName("area_" .. arg_53_1):getPosition()

	self.chapters[arg_53_1]:setPosition(cc.p(var_53_3, var_53_4 - 20))

	local var_53_5 = level_manager:getChapterStrongholdLv(var_53_1, arg_53_1)
	local var_53_6 = not level_manager:isLevelModeUnlocked(var_53_1) and "LevelMap/level" .. var_53_5 .. "_lock.png" or level_manager:isChapterModeUnlocked(var_53_1, var_53_2) and "LevelMap/level" .. var_53_5 .. "_" .. var_0_13[var_53_0] .. ".png" or "LevelMap/level" .. var_53_5 .. "_lock.png"

	self.chapters[arg_53_1]:loadTextures(var_53_6, var_53_6, var_53_6, var_0_0)

	if var_53_5 == 1 then
		local var_53_7 = self.chapters[arg_53_1]:getChildByName("name"):getTTFConfig()

		var_53_7.fontSize = 27

		self.chapters[arg_53_1]:getChildByName("name"):setTTFConfig(var_53_7)
		self.chapters[arg_53_1]:getChildByName("name"):setString(level_manager:getChapterName(var_53_1, var_53_2))
		self.chapters[arg_53_1]:getChildByName("name"):setPosition(cc.p(self.chapters[arg_53_1]:getContentSize().width / 2 + 56, self.chapters[arg_53_1]:getContentSize().height / 2 + 15))
		self.chapters[arg_53_1]:getChildByName("drop"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("curtag"):setPosition(cc.p(self.chapters[arg_53_1]:getContentSize().width / 2, self.chapters[arg_53_1]:getContentSize().height))
		self.chapters[arg_53_1]:getChildByName("newtag"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("completetag"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("timer"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("item"):setVisible(false)
	else
		local var_53_8 = self.chapters[arg_53_1]:getChildByName("name"):getTTFConfig()

		var_53_8.fontSize = 30

		self.chapters[arg_53_1]:getChildByName("name"):setTTFConfig(var_53_8)
		self.chapters[arg_53_1]:getChildByName("name"):setString(level_manager:getChapterName(var_53_1, var_53_2))
		self.chapters[arg_53_1]:getChildByName("name"):setPosition(cc.p(self.chapters[arg_53_1]:getContentSize().width / 2 + 73, self.chapters[arg_53_1]:getContentSize().height / 2 - 5))
		self.chapters[arg_53_1]:getChildByName("drop"):setVisible(true)
		self.chapters[arg_53_1]:getChildByName("item"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("newtag"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("completetag"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("timer"):setVisible(false)
		self.chapters[arg_53_1]:getChildByName("curtag"):setPosition(cc.p(self.chapters[arg_53_1]:getContentSize().width / 2 + 25, self.chapters[arg_53_1]:getContentSize().height - 20))

		if level_manager:isChapterModeUnlocked(var_53_1, var_53_2) then
			local var_53_9 = level_manager:getChapterStrongholdDrop(var_53_1, var_53_2)

			if var_53_9 then
				self.chapters[arg_53_1]:getChildByName("drop"):setVisible(false)
				self.chapters[arg_53_1]:getChildByName("item"):setVisible(true)

				local var_53_10 = self.chapters[arg_53_1]:getChildByName("item")
				local var_53_11 = var_53_10:getChildByName("icon")

				var_53_10:loadTexture("public/box/" .. item_data[var_53_9].equip_quality .. ".png", var_0_0)
				var_53_11:loadTexture("equipment/" .. item_data[var_53_9].image_id .. ".png")
				var_53_11:setScale(var_53_10:getContentSize().width / var_53_11:getContentSize().width)
			else
				self.chapters[arg_53_1]:getChildByName("drop"):setVisible(true)
			end

			local function var_53_12()
				patrol_manager:isModeCanPatrol(var_53_1, var_53_2, function(arg_55_0)
					if arg_55_0 and levelAreaMapLayer.getInstance() then
						self.chapters[arg_53_1]:getChildByName("newtag"):setVisible(true)
					end
				end)
			end

			if self.timers[var_53_1 .. "-" .. arg_53_1] then
				local var_53_13 = patrol_manager:getPatrolInfo(self.timers[var_53_1 .. "-" .. arg_53_1].key)

				if var_53_13 and var_53_13.time > 0 then
					self.chapters[arg_53_1]:getChildByName("timer"):setVisible(true)
				else
					self.chapters[arg_53_1]:getChildByName("timer"):setVisible(false)

					self.timers[var_53_1 .. "-" .. arg_53_1] = nil

					var_53_12()
				end
			else
				local var_53_14 = var_53_1 .. "-" .. var_53_2
				local var_53_15 = patrol_manager:getPatrolState(var_53_1 .. "-" .. var_53_2)

				if var_53_15 == 3 then
					self.timers[var_53_14] = {
						index = arg_53_1,
						key = var_53_14
					}

					self.chapters[arg_53_1]:getChildByName("timer"):setVisible(true)
				elseif var_53_15 == 2 then
					self.chapters[arg_53_1]:getChildByName("timer"):setVisible(false)
					self.chapters[arg_53_1]:getChildByName("completetag"):setVisible(true)
				else
					self.chapters[arg_53_1]:getChildByName("timer"):setVisible(false)
					var_53_12()
				end
			end
		end
	end

	local var_53_16 = level_manager:getChapterStarsState(var_53_1, var_53_2)

	for iter_53_0 = 1, LEVEL_STARS_NUM do
		local var_53_17 = self.chapters[arg_53_1]:getChildByName("star" .. iter_53_0)

		if var_53_5 == 1 then
			pos_x, pos_y = 90 + (iter_53_0 - (LEVEL_STARS_NUM + 1) / 2) * 20, 75

			var_53_17:setScale(0.83)
		else
			pos_x, pos_y = 110 + (iter_53_0 - (LEVEL_STARS_NUM + 1) / 2) * 25, 82

			var_53_17:setScale(1)
		end

		var_53_17:setPosition(pos_x, pos_y)

		if var_53_16[iter_53_0] then
			var_53_17:loadTexture("LevelMap/star_icon.png", var_0_0)
		else
			var_53_17:loadTexture("LevelMap/star_gray.png", var_0_0)
		end
	end

	self.chapters[arg_53_1]:getChildByName("curtag"):setVisible(var_53_1 == playermodel.curMode and var_53_2 == level_manager:getCurChapter(var_53_1))
end

function levelAreaMapLayer:playSelectCityAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_10.COVER)

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

function levelAreaMapLayer:playShowCityAni()
	if not self.anicover then
		self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), GameDisplay.width, GameDisplay.height)

		self.anicover:setPosition(0, -GameDisplay.fix_y)
		self:addChild(self.anicover, var_0_10.COVER)
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

function levelAreaMapLayer:playInitShowAni()
	self.chapterlayer:setVisible(false)
	self.maplayer:setVisible(false)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_10.COVER)

	self._playingani = true

	self.chapterlayer:setPosition(cc.p(0, 20))
	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self.chapterlayer:setVisible(true)
		self.maplayer:setVisible(true)
		self:playShowCityAni()
	end)))
end

local var_0_18 = {
	"LevelMap/img_easymode.png",
	"LevelMap/img_hardmode.png",
	"LevelMap/img_hellmode.png",
	"LevelMap/img_nightmaremode.png"
}

function levelAreaMapLayer:playSelectDifficultyAni()
	local var_62_0 = cc.Layer:create()

	self:addChild(var_62_0, var_0_10.COVER)

	local var_62_1

	if config._DEBUG then
		var_62_1 = cc.Scale9Sprite:create("LevelMap/colorcover" .. self.curdifficuty .. ".png") or cc.Scale9Sprite:createWithSpriteFrameName("LevelMap/colorcover" .. self.curdifficuty .. ".png")
	end

	var_62_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_62_1:setPreferredSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_62_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_62_1:setPosition(cc.p(320, 568))
	var_62_1:setOpacity(0)
	var_62_0:addChild(var_62_1)

	local var_62_2

	if config._DEBUG then
		var_62_2 = cc.Sprite:create("LevelMap/img_switchmodebg.png") or cc.Sprite:createWithSpriteFrameName("LevelMap/img_switchmodebg.png")
	end

	var_62_2:setPosition(cc.p(320, 568))
	var_62_0:addChild(var_62_2)

	local var_62_3

	if config._DEBUG then
		var_62_3 = cc.Sprite:create(var_0_18[self.curdifficuty]) or cc.Sprite:createWithSpriteFrameName(var_0_18[self.curdifficuty])
	end

	var_62_3:setPosition(cc.p(320, 568))
	var_62_0:addChild(var_62_3)

	self._playingani = true

	self:removeGuidesOnLayer()
	var_62_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	var_62_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.2)))
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

function levelAreaMapLayer:playExitAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_10.COVER)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.chapterlayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 20)))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		local var_66_0 = level_manager:getAreaJumpLayer(level_manager:getAreaId(self.initcity))

		LayerManager:switchShowLayer(var_66_0 and var_66_0 or "FightLayer")
	end)))
end

function levelAreaMapLayer:playUnlockAni(arg_67_1)
	self._playingani = true

	audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/jiesuotexiao.ExportJson")
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/dianwei.ExportJson")
	self.mapLockWord:getChildByName("word"):setVisible(false)
	self.mapLockWord:getChildByName("lockui1"):setVisible(false)
	self.mapLockWord:getChildByName("lockui2"):setVisible(false)
	self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(false)

	local var_67_0 = ccs.Armature:create("jiesuotexiao")

	var_67_0:setPosition(cc.p(320, 568))
	self:addChild(var_67_0, 10)
	var_67_0:getAnimation():play("Animation1")
	var_67_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self:updateUIInfos()
		self:updateCityMapLayer(true)
	end)))
	var_67_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_67_1 = ccs.Armature:create("dianwei")

	var_67_1:setPosition(cc.p(self.chapters[1]:getPositionX(), self.chapters[1]:getPositionY() + 84))
	var_67_1:setVisible(false)
	self:addChild(var_67_1, 10)
	var_67_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8333333333333335), cc.Show:create(), cc.CallFunc:create(function()
		var_67_1:getAnimation():play("Animation1")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if arg_67_1 then
			arg_67_1()
		end
	end), cc.RemoveSelf:create()))
end

function levelAreaMapLayer:playUnlockCityTalk()
	local var_72_0 = level_manager:getUnlockCityTalk(self.curcity)

	if not var_72_0 then
		return
	end

	global_basic_scene:addChild(TalkLayer:create(var_72_0, nil, talktype, "", TALK_TYPE_BEFORE_BOSS, 1), ZORDER_TALKLAYER)
end

function levelAreaMapLayer.loadBasicUIAssets(arg_73_0)
	return
end

function levelAreaMapLayer.unloadBasicUIAssets(arg_75_0)
	return
end

function levelAreaMapLayer.removeGuidesOnLayer(arg_76_0)
	if LayerManager:getCurrentLayerName() ~= "levelAreaMapLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function levelAreaMapLayer.updateGuidesOnLayer(arg_77_0)
	if LayerManager:getCurrentLayerName() ~= "levelAreaMapLayer" then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function levelAreaMapLayer:refreshGuidesOnLevelMap()
	if LayerManager:getCurrentLayerName() ~= "levelAreaMapLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function levelAreaMapLayer:getCurCity()
	return self.curcity
end

function levelAreaMapLayer:initSpecialChapter()
	local var_80_0 = ccui.Button:create("LevelMap/level_sp.png", "LevelMap/level_sp.png", "LevelMap/level_sp.png", var_0_0)

	var_80_0:setVisible(false)
	var_80_0:setName("chapter_sp")
	var_80_0:setPressedActionEnabled(true)
	var_80_0:setAnchorPoint(cc.p(0.5, 0))
	self.chapterlayer:addChild(var_80_0)

	local var_80_1 = cc.Label:createWithTTF(L_SPECIAL_ACTION, "fonts/name.ttf", 27)

	var_80_1:setAnchorPoint(cc.p(0.5, 0))
	var_80_1:setPosition(cc.p(var_80_0:getContentSize().width / 2, var_80_0:getContentSize().height / 2 - 10))
	var_80_1:setName("name")
	var_80_0:addChild(var_80_1)

	local var_80_2 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_0)

	var_80_2:setVisible(false)
	var_80_2:setPosition(cc.p(var_80_0:getContentSize().width / 2 + 120, var_80_0:getContentSize().height / 2 + 25))
	var_80_2:setName("drop")
	var_80_0:addChild(var_80_2)

	local var_80_3 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_0)

	var_80_3:setPosition(cc.p(var_80_2:getContentSize().width / 2, var_80_2:getContentSize().height / 2))
	var_80_3:setName("dropimg")
	var_80_2:addChild(var_80_3)

	local var_80_4 = ccui.ImageView:create("public/box/1.png", var_0_0)

	var_80_4:setVisible(false)
	var_80_4:setScale(var_80_3:getContentSize().width / var_80_4:getContentSize().width)
	var_80_4:setPosition(cc.p(var_80_0:getContentSize().width / 2 + 120, var_80_0:getContentSize().height / 2 + 25))
	var_80_4:setName("item")
	var_80_0:addChild(var_80_4)
	var_80_4:setTouchEnabled(true)

	local var_80_5 = ccui.ImageView:create("equipment/1000000.png")

	var_80_5:setScale(var_80_4:getContentSize().width / var_80_5:getContentSize().width)
	var_80_5:setPosition(var_80_4:getContentSize().width / 2, var_80_4:getContentSize().height / 2)
	var_80_5:setName("icon")
	var_80_4:addChild(var_80_5)

	local var_80_6 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_0)

	var_80_6:setAnchorPoint(cc.p(0.5, 0))
	var_80_6:setPosition(cc.p(var_80_0:getContentSize().width / 2, var_80_0:getContentSize().height + 15))
	var_80_6:setVisible(false)
	var_80_6:setName("curtag")
	var_80_0:addChild(var_80_6)

	local var_80_7 = ccui.ImageView:create("LevelMap/img_tag_can_patrol.png", var_0_0)

	var_80_7:setAnchorPoint(cc.p(0, 0))
	var_80_7:setPosition(cc.p(35, 80))
	var_80_7:setVisible(false)
	var_80_7:setName("newtag")
	var_80_0:addChild(var_80_7)

	local var_80_8 = ccui.ImageView:create("LevelMap/img_tagcomplete.png", var_0_0)

	var_80_8:setAnchorPoint(cc.p(0, 0))
	var_80_8:setPosition(cc.p(35, 80))
	var_80_8:setVisible(false)
	var_80_8:setName("completetag")
	var_80_0:addChild(var_80_8)

	local var_80_9 = cc.Label:createWithTTF("00:00", "fonts/number.ttf", 25)

	var_80_9:setVisible(false)
	var_80_9:setAnchorPoint(cc.p(0, 0))
	var_80_9:setPosition(cc.p(42, 88))
	var_80_9:setName("timer")
	var_80_0:addChild(var_80_9)

	local function var_80_10(arg_81_0, arg_81_1)
		if arg_81_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("::::")
	end

	var_80_0:addTouchEventListener(var_80_10)
	var_80_4:addTouchEventListener(var_80_10)

	self.spchapter = var_80_0
end

function levelAreaMapLayer:updateSpecialChapter()
	local var_82_0 = self.maplayer:getChildByName("area_sp")

	if var_82_0 then
		local var_82_1, var_82_2 = var_82_0:getPosition()

		self.spchapter:setPosition(cc.p(var_82_1 - 7, var_82_2 - 10))
		var_82_0:setVisible(false)
	else
		self.spchapter:setPosition(320, 400)
	end

	self.spchapter.mark_bg = var_82_0

	self.spchapter:setVisible(false)

	if self.spchapter:getChildByName("plotCloneUI") then
		self.spchapter:getChildByName("plotCloneUI"):setVisible(false)
	end

	LayerManager:getPlotObj():levelmapUpdataPlotShow("levelAreaMapLayer" .. self.curcity)
end

function levelAreaMapLayer:initRankUI()
	self.rankBnt = ccui.Button:create("LevelMap/rank_bnt.png", nil, "LevelMap/rank_bnt.png", var_0_0)

	self.rankBnt:setAnchorPoint(cc.p(0, 1))
	self.rankBnt:setPosition(6, GameDisplay.height - GameDisplay.fix_y - self.cityTitle:getContentSize().height - self.starReward:getContentSize().height)
	self.rankBnt:setVisible(self.curdifficuty == 4)
	self.uilayer:addChild(self.rankBnt)
	self.rankBnt:addTouchEventListener(function(arg_84_0, arg_84_1)
		if arg_84_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curdifficuty ~= 4 then
			return
		end

		local var_84_0 = {}

		var_84_0.mode = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 4)

		LayerManager:pushInLayer("LevelRankListLayer", var_84_0)
	end)
end

function levelAreaMapLayer:updateRankUI()
	if self.curdifficuty == 4 then
		self.rankBnt:setVisible(true)
	else
		self.rankBnt:setVisible(false)
	end
end

function levelAreaMapLayer:initStarRewardUI()
	self.starReward = ccui.Button:create("LevelMap/star_reward.png", nil, "LevelMap/star_reward.png", var_0_0)

	self.starReward:setAnchorPoint(cc.p(0, 1))
	self.starReward:setPosition(6, GameDisplay.height - GameDisplay.fix_y - self.cityTitle:getContentSize().height + 30)
	self.uilayer:addChild(self.starReward)

	local var_86_0 = ccui.ImageView:create("LevelMap/star_icon.png", var_0_0)

	var_86_0:setPosition(65, 48)
	self.starReward:addChild(var_86_0)

	local var_86_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label = cc.Label:createWithTTF(level_manager:getModeTotalStars(var_86_1) .. "/" .. level_manager:getModeTotalChapter(var_86_1) * 3, FONT_NAME, 14)

	self.total_star_label:setAnchorPoint(cc.p(0, 0.5))
	self.total_star_label:setPosition(80, 48)
	self.starReward:addChild(self.total_star_label)

	local var_86_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_86_2:setName("reddot")
	var_86_2:setPosition(5, self.starReward:getContentSize().height - 40)
	var_86_2:setVisible(false)
	self.starReward:addChild(var_86_2)
	self.starReward:addTouchEventListener(function(arg_87_0, arg_87_1)
		if arg_87_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			mode = var_86_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_86_1) then
		self.starReward:getChildByName("reddot"):setVisible(true)
	else
		self.starReward:getChildByName("reddot"):setVisible(false)
	end
end

function levelAreaMapLayer:updateStarRewardUI()
	local var_89_1 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty or 1)

	self.total_star_label:setString(level_manager:getModeTotalStars(var_89_1) .. "/" .. level_manager:getModeTotalChapter(var_89_1) * 3)
	self.starReward:addTouchEventListener(function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStarRewardLayer", {
			mode = var_89_1,
			updateCallback = function()
				self:updateStarRewardUI()
				self:updateCityBntTips(self.curcity, self.curdifficuty or 1)
			end
		})
	end)

	if level_manager:checkIsNewStarReward(var_89_1) then
		self.starReward:getChildByName("reddot"):setVisible(true)
	else
		self.starReward:getChildByName("reddot"):setVisible(false)
	end
end
