LevelTalkMapLayer = class("LevelTalkMapLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local barrage_manager = require("controller.barrage_manager")
local patrol_manager = require("controller.patrol_manager")
local item_data = require("data.item_data")
local city_data = require("data.city_data")
local CityList = require("view.Sprite.CityList")
local var_0_11 = {
	LRTIP = 7,
	LOCKWORD = 4,
	BASIC = 6,
	CHAPTERS = 2,
	COVER = 3,
	CITYLIST = 5,
	MAP = 1
}
local var_0_12 = {
	NEW = "LevelMap/city_frame_new.png",
	SELECT = "LevelMap/city_frame_selected.png",
	NORMAL = "LevelMap/city_frame_normal.png"
}
local var_0_13 = "CityMap/title/"
local var_0_14 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}
local var_0_15 = {
	426,
	310,
	196,
	82
}
local var_0_16

function LevelTalkMapLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LevelTalkMapLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LevelTalkMapLayer.getInstance()
	return var_0_16
end

function LevelTalkMapLayer:init(arg_4_1)
	var_0_16 = self
	self._playingani = false

	if arg_4_1 then
		self.initcity = arg_4_1.initcity

		if not level_manager:isTalkCity(self.initcity) then
			self.initcity = 401
		end

		self.initdifficulty = arg_4_1.initdifficulty
	else
		self.initcity = 401

		if level_manager:isLevelModePass(city_data[self.initcity].difficulty1) and city_data[self.initcity + 1] then
			self.initcity = self.initcity + 1
		end
	end

	level_manager:getModesLockState(function()
		self:initBasicUILayer()
		self:initCityMapLayer()
		self:initChangeBnt()
		self:playInitShowAni()
		self:fullScreen()
	end)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_16 = false
		end
	end)
end

function LevelTalkMapLayer:initChangeBnt()
	self.changeBnt = ccui.Helper:seekWidgetByName(self.uilayer, "Button_change")

	self.changeBnt:loadTextures("LevelMap/goto_talk_off.png", "LevelMap/goto_talk_off.png", "LevelMap/goto_talk_off.png", var_0_0)
	self.changeBnt:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	self.branchBnt = ccui.Helper:seekWidgetByName(self.uilayer, "Button_branch")

	self.branchBnt:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapBoxLayer")
	end)

	self.mainBtn = ccui.Helper:seekWidgetByName(self.uilayer, "Button_main")

	self.mainBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("LevelMapLayer")
	end)

	self.specailBnt = ccui.Helper:seekWidgetByName(self.uilayer, "Button_special")

	self.specailBnt:loadTextures("LevelMap/btn_special_on.png", nil, "LevelMap/btn_special_on.png", var_0_0)
	self.specailBnt:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SpecialOperationLayer", {
			initcity = 51
		})
	end)
end

function LevelTalkMapLayer:fullScreen()
	self.panelDifficulty.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.panelDifficulty:getPositionY(), TRANSFORM_UNIT.PX)

	self.panelDifficulty:setPositionY(self.panelDifficulty.full_posY)

	self.cityTitle.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.cityTitle:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityTitle:setPositionY(self.cityTitle.full_posY)

	self.btnReturn.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.btnReturn:getPositionY(), TRANSFORM_UNIT.PX)

	self.btnReturn:setPositionY(self.btnReturn.full_posY)

	self.listview = ccui.Helper:seekWidgetByName(self.uilayer, "btn_listview")
	self.listview.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.listview:getPositionY(), TRANSFORM_UNIT.PX)

	self.listview:setPositionY(self.listview.full_posY)
	self.listview:refreshView()
	self.listview:jumpToRight()

	self.cityList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.cityList:getPositionY(), TRANSFORM_UNIT.PX)

	self.cityList:setPositionY(self.cityList.full_posY)

	local var_12_0 = ccui.Helper:seekWidgetByName(self.uilayer, "city_panel_frame")

	var_12_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_12_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_12_0:setPositionY(var_12_0.full_posY)
end

function LevelTalkMapLayer:initBasicUILayer()
	self.uilayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LevelMap.json" or "LevelMap.ExportJson")

	self:addChild(self.uilayer, var_0_11.BASIC)

	self.cityTitle = ccui.Helper:seekWidgetByName(self.uilayer, "title")
	self.btnReturn = ccui.Helper:seekWidgetByName(self.uilayer, "btn_return")

	self.btnReturn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
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

function LevelTalkMapLayer:initCityList()
	self.cityList = CityList:create()

	self:addChild(self.cityList, var_0_11.CITYLIST)

	self.curcity = nil
	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local function var_16_0(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_17_0:getTouchBeganPosition().x - arg_17_0:getTouchEndPosition().x) >= 25 then
			return
		end

		if self._playingani then
			return
		end

		self.cityList:scrollToIndexManual(arg_17_0:getTag())
		self:updateLeftRightTigEffect()
	end

	local function var_16_1(arg_18_0)
		local var_18_0 = ccui.Button:create(var_0_12.NORMAL, var_0_12.NORMAL, var_0_12.NORMAL, var_0_0)

		var_18_0:setName("city" .. arg_18_0)

		local var_18_1 = cc.Sprite:create("CityMap/MiniMap/" .. level_manager:getCityImg(arg_18_0) .. ".png")

		var_18_1:setPosition(cc.p(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2))
		var_18_1:setName("minimap")
		var_18_0:addChild(var_18_1, -1)

		local var_18_2 = ccui.ImageView:create(var_0_12.SELECT, var_0_0)

		var_18_2:setPosition(cc.p(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2))
		var_18_2:setName("frame")
		var_18_2:setVisible(false)
		var_18_0:addChild(var_18_2, 2)

		if not level_manager:isCityUnlocked(arg_18_0) then
			l2utils:shaderGrayDark(var_18_0:getVirtualRenderer())
			l2utils:shaderGrayDark(var_18_1)

			if not level_manager:isCityCanUnlock(arg_18_0) then
				l2utils:shaderNode(var_18_2:getVirtualRenderer())
			end
		else
			l2utils:shaderDarkNode(var_18_0:getVirtualRenderer())
			l2utils:shaderDarkNode(var_18_1)
		end

		var_18_0:addTouchEventListener(var_16_0)

		return var_18_0
	end

	for iter_16_0, iter_16_1 in ipairs((level_manager:getTalkCityList())) do
		local var_16_2 = var_16_1(iter_16_1)

		self.cityList:pushInCity(var_16_2)

		self.cities[iter_16_1] = var_16_2
		self.index_to_city[var_16_2:getTag()] = iter_16_1
		self.city_to_index[iter_16_1] = var_16_2:getTag()
	end

	self.cityList:registerSelectCityHandler(function(arg_19_0)
		if self.curcity == self.index_to_city[arg_19_0] then
			return
		end

		self:updateCityOnUnSelect(self.curcity)

		self.curcity = self.index_to_city[arg_19_0]

		self:updateCityOnSelect(self.curcity)
		self:playSelectCityAni()
		self:updateLeftRightTigEffect()
	end)

	self.curcity = self.initcity or level_manager:getCurTalkCity()

	self:updateCityOnSelect(self.curcity)
	self.cityList:jumpToIndex(self.city_to_index[self.curcity])
	self:updateLeftRightTigEffect()
end

function LevelTalkMapLayer.updateLeftRightTigEffect(arg_20_0)
	local var_20_0 = level_manager:getTalkCityList()

	local function var_20_1(arg_21_0)
		if level_manager:isCityCanUnlock(arg_21_0) then
			return true
		end

		if patrol_manager:isCityFinishedPatrol(arg_21_0) then
			return true
		end

		if patrol_manager:isCityNewPatrol(arg_21_0) then
			return true
		end

		if level_manager:isCityNewDifficulty(arg_21_0) then
			return true
		end

		if PlotManager.plot_layer_config["LevelMapLayer" .. arg_21_0] then
			return true
		end

		return false
	end
end

function LevelTalkMapLayer:getCityByID(arg_24_1)
	return self.cities[arg_24_1]
end

function LevelTalkMapLayer:getCityByIndex(arg_25_1)
	return self.cities[self.index_to_city[arg_25_1]]
end

function LevelTalkMapLayer:updateCityOnSelect(arg_26_1)
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
		var_26_0:getChildByName("frame"):loadTexture(var_0_12.SELECT, var_0_0)
	end
end

function LevelTalkMapLayer:updateCityOnUnSelect(arg_27_1)
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
end

function LevelTalkMapLayer:updateCityOnUnlock()
	local var_28_0 = self:getCityByID(self.curcity)

	l2utils:recoverShader(var_28_0:getVirtualRenderer())
	l2utils:recoverShader(var_28_0:getChildByName("minimap"))
	var_28_0:getChildByName("frame"):loadTexture(var_0_12.SELECT, var_0_0)
end

function LevelTalkMapLayer:initUIInfos()
	local var_29_0 = self.initdifficulty and level_manager:isCityDifficultyValid(self.curcity, self.initdifficulty) and self.initdifficulty or self.curcity == level_manager:getCurTalkCity() and level_manager:getCurTalkLevelDifficulty() or level_manager:getUnlockedDifficultyInCity(self.curcity)

	if level_manager:isCityUnlocked(self.curcity) then
		self.curdifficuty = var_29_0
		self.finaldifficuty = var_29_0

		self.cityTitle:loadTexture(var_0_13 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = 1

		self.cityTitle:loadTexture(var_0_13 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	self:updateDifficutyPanel()
end

function LevelTalkMapLayer:updateUIInfos()
	if level_manager:isCityUnlocked(self.curcity) then
		if self.finaldifficuty then
			local var_30_0 = level_manager:getCityDifficulties(self.curcity)
			local var_30_1

			for iter_30_0 = 1, 3 do
				if var_30_0[iter_30_0] and var_30_0[iter_30_0].stat then
					var_30_1 = iter_30_0
				end
			end

			self.curdifficuty = var_30_1 < self.finaldifficuty and var_30_1 or self.finaldifficuty
		else
			self.curdifficuty = self.curcity == level_manager:getCurTalkCity() and level_manager:getCurTalkLevelDifficulty() or 1
			self.finaldifficuty = self.curdifficuty
		end

		self.cityTitle:loadTexture(var_0_13 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
		l2utils:recoverShader(self.cityTitle:getVirtualRenderer())
	else
		self.curdifficuty = 1

		self.cityTitle:loadTexture(var_0_13 .. level_manager:getCityImg(self.curcity) .. "_1.png")
		l2utils:shaderGrayDark(self.cityTitle:getVirtualRenderer())
	end

	self:updateDifficutyPanel()
end

function LevelTalkMapLayer:initPanelDifficulty()
	self.panelDifficulty = ccui.Helper:seekWidgetByName(self.uilayer, "panel_difficulty")

	for iter_31_0 = 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_31_0]):addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			if level_manager:isCityNewDifficulty(self.curcity, iter_31_0) then
				level_manager:unMarkModeNew(level_manager:getModeByDifficulty(self.curcity, iter_31_0))
				self:updateDifficutyTips(self.curcity, iter_31_0)
			end

			if iter_31_0 == self.curdifficuty then
				return
			end

			if self._playingani then
				return
			end

			self:selectDifficulty(iter_31_0)
		end)
	end
end

function LevelTalkMapLayer:selectDifficulty(arg_33_1)
	self.curdifficuty = arg_33_1
	self.finaldifficuty = arg_33_1

	self.cityTitle:loadTexture(var_0_13 .. level_manager:getCityImg(self.curcity) .. "_" .. self.curdifficuty .. ".png")
	self:updateDifficutyPanel()
	self:playSelectDifficultyAni()
end

function LevelTalkMapLayer:updateDifficutyPanel()
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs((level_manager:getCityDifficulties(self.curcity))) do
		if iter_34_1.stat then
			self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_0]):setVisible(true)

			local var_34_1

			if iter_34_0 == self.curdifficuty then
				var_34_1 = "LevelMap/btn_" .. var_0_14[iter_34_0] .. ".png"

				self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_0]):getVirtualRenderer():setOpacity(255)
			else
				var_34_1 = "LevelMap/btn_" .. var_0_14[iter_34_0] .. ".png"

				self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_0]):getVirtualRenderer():setOpacity(170)
			end

			self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_0]):loadTextures(var_34_1, nil, var_34_1, var_0_0)

			var_34_0 = var_34_0 + 1

			self:updateDifficutyTips(self.curcity, iter_34_0)
		else
			self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_0]):setVisible(false)
		end
	end

	for iter_34_2 = 1, var_34_0 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_2]):setPositionX(var_0_15[var_34_0 + 1 - iter_34_2])
		self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_2]):setVisible(true)
	end

	for iter_34_3 = var_34_0 + 1, 4 do
		self.panelDifficulty:getChildByName("btn_" .. var_0_14[iter_34_3]):setVisible(false)
	end

	if var_34_0 == 1 then
		self.panelDifficulty:getChildByName("btn_" .. var_0_14[var_34_0]):setVisible(false)
	end
end

function LevelTalkMapLayer:updateDifficutyTips(arg_35_1, arg_35_2)
	local var_35_0 = self.panelDifficulty:getChildByName("btn_" .. var_0_14[arg_35_2])
	local var_35_1 = {}

	if level_manager:isCityNewDifficulty(arg_35_1, arg_35_2) then
		if not var_35_0:getChildByName("newDifficultyTips") then
			local var_35_2 = ccui.ImageView:create("LevelMap/img_tagnew.png", var_0_0)

			var_35_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_35_2:setPosition(cc.p(var_35_0:getContentSize().width - 20, var_35_0:getContentSize().height))
			var_35_2:setName("newDifficultyTips")
			var_35_0:addChild(var_35_2)
		else
			var_35_0:getChildByName("newDifficultyTips"):setVisible(true)
		end

		var_35_1.newDifficultyTips = true
	elseif var_35_0:getChildByName("newDifficultyTips") then
		var_35_0:getChildByName("newDifficultyTips"):setVisible(false)
	end

	if self.curdifficuty ~= arg_35_2 then
		for iter_35_0, iter_35_1 in ipairs({
			"newDifficultyTips",
			"reddot",
			"newPatrolTips"
		}) do
			if var_35_0:getChildByName(iter_35_1) and var_35_1[iter_35_1] then
				var_35_0:getChildByName(iter_35_1):setVisible(true)
			end
		end
	end
end

function LevelTalkMapLayer:initCityMapLayer()
	local var_36_0 = self.initcity or level_manager:getCurTalkCity()
	local var_36_1 = self.initdifficulty and level_manager:isCityDifficultyValid(var_36_0, self.initdifficulty) and self.initdifficulty or var_36_0 == level_manager:getCurTalkCity() and level_manager:getCurTalkLevelDifficulty() or level_manager:getUnlockedDifficultyInCity(var_36_0)
	local var_36_2 = level_manager:getModeByDifficulty(var_36_0, var_36_1)

	self.maplayer = ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(var_36_0) .. ".json")

	self:addChild(self.maplayer, var_0_11.MAP)
	self.maplayer:getChildByName("bgframe"):setScaleY(GameDisplay.height / self.maplayer:getChildByName("bgframe"):getContentSize().height)

	local var_36_3 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_36_3:setFlippedX(true)
	var_36_3:setFlippedY(true)
	var_36_3:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_36_3, 1)

	if level_manager:isCityUnlocked(var_36_0) then
		if config._DEBUG then
			self.cover = cc.Sprite:create("LevelMap/cover_" .. var_0_14[var_36_1] .. ".png") or cc.Sprite:createWithSpriteFrameName("LevelMap/cover_" .. var_0_14[var_36_1] .. ".png")
		end

		self.cover:setAnchorPoint(cc.p(0.5, 0))
		self.cover:setPosition(cc.p(320, -GameDisplay.fix_y))
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
		self.cover:setName("colorcover")
		self.maplayer:addChild(self.cover, 1)
	end

	self:initCityMapChapters()

	for iter_36_0 = 1, math.min(level_manager:getModeTotalChapter(var_36_2), 10) do
		local var_36_4 = self.maplayer:getChildByName("area_" .. iter_36_0)

		self:updateChapters(iter_36_0)

		if level_manager:isChapterModeUnlocked(var_36_2, iter_36_0) then
			var_36_4:setVisible(true)
			var_36_4:loadTexture("Maps/" .. var_0_14[var_36_1] .. "point.png")
		else
			var_36_4:setVisible(false)
		end
	end

	self:initMapLockWord()
	self:updateMapLockWord(var_36_0)
end

function LevelTalkMapLayer:initMapLockWord()
	self.mapLockWord = ccui.Layout:create()

	self.mapLockWord:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.mapLockWord:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapLockWord:setPosition(320, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.mapLockWord:setTouchEnabled(true)
	self.mapLockWord:setVisible(false)
	self:addChild(self.mapLockWord, var_0_11.LOCKWORD)

	local var_37_0 = ccui.ImageView:create("LevelMap/cover_locked.png", var_0_0)

	var_37_0:setScale9Enabled(true)
	var_37_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_37_0:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_37_0)

	local var_37_1 = ccui.ImageView:create("LevelMap/wordbg.png", var_0_0)

	var_37_1:setName("mapLockWordBg")
	var_37_1:setPosition(cc.p(320, GameDisplay.height / 2))
	self.mapLockWord:addChild(var_37_1)

	local var_37_2 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_37_2:setAnchorPoint(cc.p(1, 0.5))
	var_37_2:setPosition(cc.p(640, GameDisplay.height / 2))
	var_37_2:setName("lockui1")
	self.mapLockWord:addChild(var_37_2)

	local var_37_3 = ccui.ImageView:create("LevelMap/ui_lock.png", var_0_0)

	var_37_3:setAnchorPoint(cc.p(0, 0.5))
	var_37_3:setPosition(cc.p(0, GameDisplay.height / 2))
	var_37_3:setFlippedY(true)
	var_37_3:setFlippedX(true)
	var_37_3:setName("lockui2")
	self.mapLockWord:addChild(var_37_3)

	local var_37_4 = cc.Label:createWithTTF(L_COMMON_WARNING.Locking, "fonts/name.ttf", 50)

	var_37_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_37_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_37_4:setName("word")
	self.mapLockWord:addChild(var_37_4)
	self.mapLockWord:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		if not level_manager:isCityCanUnlock(self.curcity) then
			return
		end

		local function var_38_0()
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
				self:playUnlockAni(var_38_0)
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
			end
		})
	end)
end

function LevelTalkMapLayer:initCityMapChapters()
	self.chapterlayer = cc.Layer:create()

	self:addChild(self.chapterlayer, var_0_11.CHAPTERS)

	local function var_42_0(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._playingani then
			return
		end

		local var_43_0 = self.curcity
		local var_43_1 = self.curdifficuty
		local var_43_2 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
		local var_43_3 = arg_43_0:getTag()

		if not level_manager:isChapterModeUnlocked(var_43_2, var_43_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Forbid)
			audio_manager:playeffectMusicTest("sound/invalid")

			return
		end

		local var_43_4

		if not level_manager:isChapterModeValid(var_43_2, var_43_3) then
			global_ShowBlockWords(L_MAP_CITY_CHAPTERS.Locking)
			audio_manager:playeffectMusicTest("sound/invalid")

			do return end

			var_43_4 = {
				mode = var_43_2,
				chapter = var_43_3
			}
		end

		function var_43_4.patrolCallback()
			self:updateChapters(var_43_3)
			self:updateDifficutyTips(var_43_0, var_43_1)
		end

		LayerManager:pushInLayer("PopTalkPreviewLayer", var_43_4)
	end

	self.chapters = setmetatable({}, {
		__index = function(arg_45_0, arg_45_1)
			assert(type(arg_45_1) == "number", "Need Number for Chapters Index")

			local var_45_0 = ccui.Button:create("LevelMap/level_talk_1_lock.png", "LevelMap/level_talk_1_lock.png", "LevelMap/level_talk_1_lock.png", var_0_0)

			var_45_0:setName("chapter" .. arg_45_1)
			var_45_0:setPressedActionEnabled(true)
			var_45_0:setAnchorPoint(cc.p(0.5, 0))
			var_45_0:setTag(arg_45_1)
			self.chapterlayer:addChild(var_45_0)

			local var_45_1 = ccui.ImageView:create("roleimage/role/wuji/1.png")

			var_45_1:setScale(0.4)
			var_45_1:setAnchorPoint(cc.p(0.5, 0))
			var_45_1:setPosition(cc.p(20, -9))
			var_45_1:setName("headimage")
			var_45_0:addChild(var_45_1)

			local var_45_2 = cc.Label:createWithTTF("", "fonts/name.ttf", 22)

			var_45_2:setAnchorPoint(cc.p(1, 0.5))
			var_45_2:setPosition(cc.p(var_45_0:getContentSize().width / 2 + 60, var_45_0:getContentSize().height / 2 + 15))
			var_45_2:setName("name")
			var_45_0:addChild(var_45_2)

			local var_45_3 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_0)

			var_45_3:setPosition(cc.p(var_45_0:getContentSize().width / 2 + 120, var_45_0:getContentSize().height / 2 + 25))
			var_45_3:setName("drop")
			var_45_0:addChild(var_45_3)

			local var_45_4 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_0)

			var_45_4:setPosition(cc.p(var_45_3:getContentSize().width / 2, var_45_3:getContentSize().height / 2))
			var_45_4:setName("dropimg")
			var_45_3:addChild(var_45_4)

			local var_45_5 = ccui.ImageView:create("public/box/1.png", var_0_0)

			var_45_5:setVisible(false)
			var_45_5:setTag(arg_45_1)
			var_45_5:setScale(var_45_4:getContentSize().width / var_45_5:getContentSize().width)
			var_45_5:setPosition(cc.p(var_45_0:getContentSize().width / 2 + 120, var_45_0:getContentSize().height / 2 + 25))
			var_45_5:setName("item")
			var_45_0:addChild(var_45_5)
			var_45_5:setTouchEnabled(true)

			local var_45_6 = ccui.ImageView:create("equipment/1000000.png")

			var_45_6:setScale(var_45_5:getContentSize().width / var_45_6:getContentSize().width)
			var_45_6:setPosition(var_45_5:getContentSize().width / 2, var_45_5:getContentSize().height / 2)
			var_45_6:setName("icon")
			var_45_5:addChild(var_45_6)

			local var_45_7 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_0)

			var_45_7:setAnchorPoint(cc.p(0.5, 0))
			var_45_7:setPosition(cc.p(var_45_0:getContentSize().width / 2, var_45_0:getContentSize().height + 15))
			var_45_7:setVisible(false)
			var_45_7:setName("curtag")
			var_45_0:addChild(var_45_7)
			var_45_0:addTouchEventListener(var_42_0)
			var_45_5:addTouchEventListener(var_42_0)

			arg_45_0[arg_45_1] = var_45_0

			return var_45_0
		end
	})
end

function LevelTalkMapLayer:updateCityMapLayer(arg_46_1)
	local var_46_0 = self.curdifficuty or 1
	local var_46_1 = level_manager:getModeByDifficulty(self.curcity, var_46_0)

	self.maplayer:runAction(cc.Sequence:create(cc.Hide:create(), cc.RemoveSelf:create()))

	self.maplayer = ccs.GUIReader:getInstance():widgetFromJsonFile(level_manager:getCityConf(self.curcity) .. ".json")

	self:addChild(self.maplayer, var_0_11.MAP)
	self.maplayer:getChildByName("bgframe"):setScaleY(GameDisplay.height / self.maplayer:getChildByName("bgframe"):getContentSize().height)

	local var_46_2 = ccui.ImageView:create("LevelMap/img_word.png", var_0_0)

	var_46_2:setFlippedX(true)
	var_46_2:setFlippedY(true)
	var_46_2:setPosition(cc.p(535, 145))
	self.maplayer:addChild(var_46_2, 1)

	local var_46_3

	if level_manager:isCityUnlocked(self.curcity) then
		if config._DEBUG then
			self.cover = cc.Sprite:create("LevelMap/cover_" .. var_0_14[var_46_0] .. ".png") or cc.Sprite:createWithSpriteFrameName("LevelMap/cover_" .. var_0_14[var_46_0] .. ".png")
		end

		self.cover:setAnchorPoint(cc.p(0.5, 0))
		self.cover:setPosition(cc.p(320, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)))
		self.cover:setScaleX(640 / self.cover:getContentSize().width)
		self.cover:setName("colorcover")
		self.maplayer:addChild(self.cover, 1)

		var_46_3 = {}
	end

	for iter_46_0 = 1, math.min(level_manager:getModeTotalChapter(var_46_1), 10) do
		local var_46_4 = self.maplayer:getChildByName("area_" .. iter_46_0)

		self:updateChapters(iter_46_0)

		var_46_3[iter_46_0] = true

		if level_manager:isCityUnlocked(self.curcity) and level_manager:isChapterModeUnlocked(var_46_1, iter_46_0) then
			var_46_4:setVisible(true)
			var_46_4:loadTexture("Maps/" .. var_0_14[var_46_0] .. "point.png")
		else
			var_46_4:setVisible(false)
		end
	end

	for iter_46_1, iter_46_2 in pairs(self.chapters) do
		if not var_46_3[iter_46_1] then
			local var_46_5 = rawget(self.chapters, iter_46_1)

			if var_46_5 then
				var_46_5:setVisible(false)
			end
		end
	end

	if not arg_46_1 then
		self:updateMapLockWord(self.curcity)
	end
end

function LevelTalkMapLayer:updateMapLockWord(arg_47_1)
	if level_manager:isCityUnlocked(arg_47_1) then
		self.mapLockWord:setVisible(false)

		return
	end

	self.mapLockWord:setVisible(true)

	if level_manager:isCityCanUnlock(arg_47_1) then
		self.mapLockWord:getChildByName("word"):setString(L_MAP_CITY_CHAPTERS.Can_Unlock)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_canlock.png", var_0_0)
	else
		self.mapLockWord:getChildByName("word"):setString(L_COMMON_WARNING.Locking)
		self.mapLockWord:getChildByName("lockui1"):loadTexture("LevelMap/ui_lock.png", var_0_0)
		self.mapLockWord:getChildByName("lockui2"):loadTexture("LevelMap/ui_lock.png", var_0_0)
	end
end

function LevelTalkMapLayer:updateCityMapOnSelectDifficulty()
	local var_48_0 = level_manager:getModeByDifficulty(self.curcity, self.curdifficuty)
	local var_48_1

	if self.maplayer:getChildByName("colorcover") then
		if config._DEBUG then
			self.cover:setTexture("LevelMap/cover_" .. var_0_14[self.curdifficuty] .. ".png")
		else
			self.cover:setSpriteFrame("LevelMap/cover_" .. var_0_14[self.curdifficuty] .. ".png")
		end

		self.cover:setScaleX(640 / self.cover:getContentSize().width)

		var_48_1 = {}
	end

	for iter_48_0 = 1, math.min(level_manager:getModeTotalChapter(var_48_0), 10) do
		local var_48_2 = self.maplayer:getChildByName("area_" .. iter_48_0)

		self:updateChapters(iter_48_0)

		var_48_1[iter_48_0] = true

		if level_manager:isChapterModeUnlocked(var_48_0, iter_48_0) then
			var_48_2:setVisible(true)
			var_48_2:loadTexture("Maps/" .. var_0_14[self.curdifficuty] .. "point.png")
		else
			var_48_2:setVisible(false)
		end
	end

	for iter_48_1, iter_48_2 in pairs(self.chapters) do
		if not var_48_1[iter_48_1] then
			local var_48_3 = rawget(self.chapters, iter_48_1)

			if var_48_3 then
				var_48_3:setVisible(false)
			end
		end
	end
end

function LevelTalkMapLayer:updateChapters(arg_49_1)
	local var_49_0 = self.curdifficuty or 1

	self.chapters[arg_49_1]:setVisible(true)

	local var_49_1 = level_manager:getModeByDifficulty(self.curcity, var_49_0)
	local var_49_2 = arg_49_1
	local var_49_3, var_49_4 = self.maplayer:getChildByName("area_" .. arg_49_1):getPosition()

	self.chapters[arg_49_1]:setPosition(cc.p(var_49_3 - 8, var_49_4 + 5))
	self.chapters[arg_49_1]:getChildByName("headimage"):loadTexture("roleimage/role/wuji/" .. level_manager:getChapterPassHeadImage(var_49_1, var_49_2) .. ".png")

	local var_49_5 = level_manager:getChapterStrongholdLv(var_49_1, arg_49_1)
	local var_49_6

	if not level_manager:isLevelModeUnlocked(var_49_1) then
		var_49_6 = "LevelMap/level_talk_" .. var_49_5 .. "_lock.png"

		self.chapters[arg_49_1]:getChildByName("headimage"):loadTexture("roleimage/role/wuji/" .. level_manager:getChapterHeadImage(var_49_1, var_49_2) .. ".png")
	elseif level_manager:isChapterModeUnlocked(var_49_1, var_49_2) then
		var_49_6 = "LevelMap/level_talk_" .. var_49_5 .. "_" .. var_0_14[var_49_0] .. ".png"
	else
		var_49_6 = "LevelMap/level_talk_" .. var_49_5 .. "_lock.png"

		self.chapters[arg_49_1]:getChildByName("headimage"):loadTexture("roleimage/role/wuji/" .. level_manager:getChapterHeadImage(var_49_1, var_49_2) .. ".png")
	end

	self.chapters[arg_49_1]:loadTextures(var_49_6, var_49_6, var_49_6, var_0_0)

	if var_49_5 == 1 then
		local var_49_7 = self.chapters[arg_49_1]:getChildByName("name"):getTTFConfig()

		var_49_7.fontSize = 22

		self.chapters[arg_49_1]:getChildByName("name"):setTTFConfig(var_49_7)
		self.chapters[arg_49_1]:getChildByName("name"):setString(level_manager:getChapterName(var_49_1, var_49_2))
		self.chapters[arg_49_1]:getChildByName("name"):setPosition(cc.p(self.chapters[arg_49_1]:getContentSize().width / 2 + 60, self.chapters[arg_49_1]:getContentSize().height / 2 + 2))
		self.chapters[arg_49_1]:getChildByName("drop"):setVisible(false)
		self.chapters[arg_49_1]:getChildByName("curtag"):setPosition(cc.p(self.chapters[arg_49_1]:getContentSize().width / 2, self.chapters[arg_49_1]:getContentSize().height))
		self.chapters[arg_49_1]:getChildByName("item"):setVisible(false)
	else
		local var_49_8 = self.chapters[arg_49_1]:getChildByName("name"):getTTFConfig()

		var_49_8.fontSize = 30

		self.chapters[arg_49_1]:getChildByName("name"):setTTFConfig(var_49_8)
		self.chapters[arg_49_1]:getChildByName("name"):setString(level_manager:getChapterName(var_49_1, var_49_2))
		self.chapters[arg_49_1]:getChildByName("name"):setPosition(cc.p(self.chapters[arg_49_1]:getContentSize().width / 2 + 73, self.chapters[arg_49_1]:getContentSize().height / 2 - 5))
		self.chapters[arg_49_1]:getChildByName("drop"):setVisible(true)
		self.chapters[arg_49_1]:getChildByName("item"):setVisible(false)
		self.chapters[arg_49_1]:getChildByName("curtag"):setPosition(cc.p(self.chapters[arg_49_1]:getContentSize().width / 2 + 25, self.chapters[arg_49_1]:getContentSize().height - 20))

		if level_manager:isChapterModeUnlocked(var_49_1, var_49_2) then
			local var_49_9 = level_manager:getChapterStrongholdDrop(var_49_1, var_49_2)

			if var_49_9 then
				self.chapters[arg_49_1]:getChildByName("drop"):setVisible(false)
				self.chapters[arg_49_1]:getChildByName("item"):setVisible(true)

				local var_49_10 = self.chapters[arg_49_1]:getChildByName("item")
				local var_49_11 = var_49_10:getChildByName("icon")

				var_49_10:loadTexture("public/box/" .. item_data[var_49_9].equip_quality .. ".png", var_0_0)
				var_49_11:loadTexture("equipment/" .. item_data[var_49_9].image_id .. ".png")
				var_49_11:setScale(var_49_10:getContentSize().width / var_49_11:getContentSize().width)
			else
				self.chapters[arg_49_1]:getChildByName("drop"):setVisible(true)
			end
		end
	end

	self.chapters[arg_49_1]:getChildByName("curtag"):setVisible(var_49_1 == playermodel.curMode and var_49_2 == level_manager:getCurChapter(var_49_1))
end

function LevelTalkMapLayer:playSelectCityAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_11.COVER)

	self._playingani = true

	self:removeGuidesOnLayer()
	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.chapterlayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 20)))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self:updateUIInfos()
		self:updateCityMapLayer()
		self:playShowCityAni()
	end)))
end

function LevelTalkMapLayer:playShowCityAni()
	if not self.anicover then
		self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), GameDisplay.width, GameDisplay.height)

		self.anicover:setPosition(0, -GameDisplay.fix_y)
		self:addChild(self.anicover, var_0_11.COVER)
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

function LevelTalkMapLayer:playInitShowAni()
	self.chapterlayer:setVisible(false)
	self.maplayer:setVisible(false)

	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_11.COVER)

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

function LevelTalkMapLayer:playSelectDifficultyAni()
	local var_56_0 = cc.Layer:create()

	self:addChild(var_56_0, var_0_11.COVER)

	local var_56_1

	if config._DEBUG then
		var_56_1 = cc.Scale9Sprite:create("LevelMap/colorcover" .. self.curdifficuty .. ".png") or cc.Scale9Sprite:createWithSpriteFrameName("LevelMap/colorcover" .. self.curdifficuty .. ".png")
	end

	var_56_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_56_1:setPreferredSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_56_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_56_1:setPosition(cc.p(320, 568))
	var_56_1:setOpacity(0)
	var_56_0:addChild(var_56_1)

	local var_56_2

	if config._DEBUG then
		var_56_2 = cc.Sprite:create("LevelMap/img_switchmodebg.png") or cc.Sprite:createWithSpriteFrameName("LevelMap/img_switchmodebg.png")
	end

	var_56_2:setPosition(cc.p(320, 568))
	var_56_0:addChild(var_56_2)

	local var_56_3

	if config._DEBUG then
		var_56_3 = cc.Sprite:create(var_0_18[self.curdifficuty]) or cc.Sprite:createWithSpriteFrameName(var_0_18[self.curdifficuty])
	end

	var_56_3:setPosition(cc.p(320, 568))
	var_56_0:addChild(var_56_3)

	self._playingani = true

	self:removeGuidesOnLayer()
	var_56_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.RemoveSelf:create()))
	var_56_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.2), cc.FadeOut:create(0.2)))
	self.chapterlayer:runAction(cc.Sequence:create(cc.MoveBy:create(0.3, cc.p(0, 20)), cc.MoveBy:create(0.2, cc.p(0, -20))))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		self:updateCityMapOnSelectDifficulty()
	end)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
		self._playingani = false

		self:updateGuidesOnLayer()
	end)))
end

function LevelTalkMapLayer:playExitAni()
	self.anicover = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	self.anicover:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.anicover, var_0_11.COVER)

	self._playingani = true

	self.anicover:runAction(cc.Sequence:create(cc.FadeIn:create(0.4), cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
	self.chapterlayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 20)))
	self.maplayer:runAction(cc.MoveBy:create(0.4, cc.p(0, 8)))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)))
end

function LevelTalkMapLayer:playUnlockAni(arg_61_1)
	self._playingani = true

	audio_manager:playeffectMusic(DORM_UNLOCK_ROOM)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/jiesuotexiao.ExportJson")
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("mapeffect/dianwei.ExportJson")
	self.mapLockWord:getChildByName("word"):setVisible(false)
	self.mapLockWord:getChildByName("lockui1"):setVisible(false)
	self.mapLockWord:getChildByName("lockui2"):setVisible(false)
	self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(false)

	local var_61_0 = ccs.Armature:create("jiesuotexiao")

	var_61_0:setPosition(cc.p(320, 568))
	self:addChild(var_61_0, 10)
	var_61_0:getAnimation():play("Animation1")
	var_61_0:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self:updateUIInfos()
		self:updateCityMapLayer(true)
	end)))
	var_61_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.6666666666666665), cc.CallFunc:create(function()
		self.mapLockWord:setVisible(false)
		self.mapLockWord:getChildByName("word"):setVisible(true)
		self.mapLockWord:getChildByName("lockui1"):setVisible(true)
		self.mapLockWord:getChildByName("lockui2"):setVisible(true)
		self.mapLockWord:getChildByName("mapLockWordBg"):setVisible(true)
	end), cc.RemoveSelf:create()))

	local var_61_1 = ccs.Armature:create("dianwei")

	var_61_1:setPosition(cc.p(self.chapters[1]:getPositionX(), self.chapters[1]:getPositionY() + 84))
	var_61_1:setVisible(false)
	self:addChild(var_61_1, 10)
	var_61_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8333333333333335), cc.Show:create(), cc.CallFunc:create(function()
		var_61_1:getAnimation():play("Animation1")
	end), cc.DelayTime:create(1), cc.CallFunc:create(function()
		if arg_61_1 then
			arg_61_1()
		end
	end), cc.RemoveSelf:create()))
end

function LevelTalkMapLayer:playUnlockCityTalk()
	local var_66_0 = level_manager:getUnlockCityTalk(self.curcity)

	if not var_66_0 then
		return
	end

	global_basic_scene:addChild(TalkLayer:create(var_66_0, nil, talktype, "", TALK_TYPE_BEFORE_BOSS, 1), ZORDER_TALKLAYER)
end

function LevelTalkMapLayer.removeGuidesOnLayer(arg_67_0)
	if LayerManager:getCurrentLayerName() ~= "LevelTalkMapLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function LevelTalkMapLayer.updateGuidesOnLayer(arg_68_0)
	if LayerManager:getCurrentLayerName() ~= "LevelTalkMapLayer" then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function LevelTalkMapLayer:refreshGuidesOnLevelMap()
	if LayerManager:getCurrentLayerName() ~= "LevelTalkMapLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function LevelTalkMapLayer:getCurCity()
	return self.curcity
end
