local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local patrol_manager = require("controller.patrol_manager")
local photo_manager = require("controller.photo_manager")
local school_cinema_manager = require("controller.school_cinema_manager")
local TempWidget = require("view.Sprite.TempWidget")
local item_data = require("data.item_data")
local var_0_7 = config._DEBUG and 0 or 1

ChapterSprite = class("ChapterSprite", function()
	return ccui.Button:create("LevelMap/level1_easy.png", "LevelMap/level1_easy.png", "LevelMap/level1_easy.png", var_0_7)
end)

function ChapterSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = ChapterSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ChapterSprite:init(arg_3_1)
	self._plotViewBtnOffsetY = 0
	self._plotViewBtnOffsetX = 0

	self:setPressedActionEnabled(true)
	self:setAnchorPoint(cc.p(0.5, 0))

	local var_3_0 = cc.Label:createWithTTF("", "fonts/name.ttf", 27)

	var_3_0:setAnchorPoint(cc.p(1, 0.5))
	var_3_0:setPosition(cc.p(self:getContentSize().width / 2 + 60, self:getContentSize().height / 2 + 15))
	var_3_0:setName("name")
	self:addChild(var_3_0)

	local var_3_1 = ccui.ImageView:create("LevelMap/frame_drop.png", var_0_7)

	var_3_1:setPosition(cc.p(self:getContentSize().width / 2 + 120, self:getContentSize().height / 2 + 25))
	var_3_1:setName("drop")
	self:addChild(var_3_1)

	local var_3_2 = ccui.ImageView:create("LevelMap/img_unknow_drop.png", var_0_7)

	var_3_2:setPosition(cc.p(var_3_1:getContentSize().width / 2, var_3_1:getContentSize().height / 2))
	var_3_2:setName("dropimg")
	var_3_1:addChild(var_3_2)

	local var_3_3 = ccui.Button:create("public/box/1.png", "public/box/1.png", "public/box/1.png", var_0_7)

	var_3_3:setVisible(false)
	var_3_3:setScale(var_3_2:getContentSize().width / var_3_3:getContentSize().width)
	var_3_3:setPosition(cc.p(self:getContentSize().width / 2 + 120, self:getContentSize().height / 2 + 25))
	var_3_3:setName("item")
	self:addChild(var_3_3)

	local var_3_4 = ccui.Button:create("equipment/1000000.png", "equipment/1000000.png", "equipment/1000000.png")

	var_3_4:setScale(var_3_3:getContentSize().width / var_3_4:getContentSize().width)
	var_3_4:setPosition(var_3_3:getContentSize().width / 2, var_3_3:getContentSize().height / 2)
	var_3_4:setName("icon")
	var_3_3:addChild(var_3_4)

	local var_3_5 = ccui.ImageView:create("LevelMap/img_curtag.png", var_0_7)

	var_3_5:setAnchorPoint(cc.p(0.5, 0))
	var_3_5:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height + 15))
	var_3_5:setVisible(false)
	var_3_5:setName("curtag")
	self:addChild(var_3_5)

	function var_3_5.runFadeAction(...)
		var_3_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(2, 255), cc.FadeTo:create(2, 128))))
	end

	local var_3_6 = ccui.ImageView:create("LevelMap/img_tag_can_patrol.png", var_0_7)

	var_3_6:setAnchorPoint(cc.p(0, 0))
	var_3_6:setPosition(cc.p(35, 80))
	var_3_6:setVisible(false)
	var_3_6:setName("newtag")
	self:addChild(var_3_6)

	local var_3_7 = ccui.ImageView:create("LevelMap/img_tagcomplete.png", var_0_7)

	var_3_7:setAnchorPoint(cc.p(0, 0))
	var_3_7:setPosition(cc.p(35, 80))
	var_3_7:setVisible(false)
	var_3_7:setName("completetag")
	self:addChild(var_3_7)

	local var_3_8 = cc.Label:createWithTTF("00:00", FONT_DES, 25)

	var_3_8:setAnchorPoint(cc.p(0, 0))
	var_3_8:setPosition(cc.p(42, 88))
	var_3_8:setName("timer")
	self:addChild(var_3_8)

	for iter_3_0 = 1, LEVEL_STARS_NUM do
		local var_3_9 = ccui.ImageView:create("LevelMap/star_gray.png", var_0_7)

		var_3_9:setName("star" .. iter_3_0)
		var_3_9:setPosition(126 + (iter_3_0 - (LEVEL_STARS_NUM + 1) / 2) * 20, 80)
		self:addChild(var_3_9)
	end
end

function ChapterSprite:_setSwallowTouches(arg_5_1)
	self:setSwallowTouches(arg_5_1)
	ccui.Helper:seekWidgetByName(self, "item"):setSwallowTouches(arg_5_1)
end

function ChapterSprite:_addTouchEventListener(arg_6_1)
	self:addTouchEventListener(arg_6_1)
	self:getChildByName("item"):getChildByName("icon"):addTouchEventListener(arg_6_1)
end

local var_0_8 = {
	"easy",
	"hard",
	"hell",
	"nightmare"
}

function ChapterSprite:update(arg_7_1)
	local var_7_0 = arg_7_1.curdifficuty or 1
	local var_7_1 = arg_7_1.chapter
	local var_7_2 = level_manager:getModeByDifficulty(arg_7_1.curcity, var_7_0)
	local var_7_3 = level_manager:getChapterStrongholdLv(var_7_2, arg_7_1.chapter)

	if var_7_3 ~= 1 and var_7_1 % 2 == 1 then
		var_7_3 = 3
	end

	local var_7_4 = not level_manager:isLevelModeUnlocked(var_7_2) and "LevelMap/level" .. var_7_3 .. "_lock.png" or level_manager:isChapterModeUnlocked(var_7_2, var_7_1) and "LevelMap/level" .. var_7_3 .. "_" .. var_0_8[var_7_0] .. ".png" or "LevelMap/level" .. var_7_3 .. "_lock.png"
	local var_7_5 = photo_manager:checkHaveDataByModeAndChapter(var_7_2, var_7_1)

	if var_7_0 ~= 1 then
		var_7_5 = false
	end

	if var_7_5 then
		local var_7_6 = var_7_3

		if var_7_3 == 1 then
			var_7_6 = 5
			self._plotViewBtnOffsetY = 28
			self._plotViewBtnOffsetX = 2
		elseif var_7_3 == 2 then
			var_7_6 = 4
			self._plotViewBtnOffsetY = 39
			self._plotViewBtnOffsetX = -2
		elseif var_7_3 == 3 then
			self._plotViewBtnOffsetY = 49
			self._plotViewBtnOffsetX = -26
			var_7_6 = 6
		end

		var_7_4 = not level_manager:isLevelModeUnlocked(var_7_2) and "LevelMap/level" .. var_7_6 .. "_lock.png" or level_manager:isChapterModeUnlocked(var_7_2, var_7_1) and "LevelMap/level" .. var_7_6 .. "_" .. var_0_8[var_7_0] .. ".png" or "LevelMap/level" .. var_7_6 .. "_lock.png"
	else
		self._plotViewBtnOffsetY = 0
		self._plotViewBtnOffsetX = 0
	end

	self:loadTextures(var_7_4, var_7_4, var_7_4, var_0_7)

	if var_7_3 == 1 then
		local var_7_7 = self:getChildByName("name"):getTTFConfig()

		var_7_7.fontSize = 27

		self:getChildByName("name"):setTTFConfig(var_7_7)
		self:getChildByName("name"):setString(level_manager:getChapterName(var_7_2, var_7_1))
		self:getChildByName("name"):setPosition(cc.p(self:getContentSize().width / 2 + 56, self:getContentSize().height / 2 + 15))
		self:getChildByName("drop"):setVisible(false)
		self:getChildByName("curtag"):setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height))
		self:getChildByName("newtag"):setVisible(false)
		self:getChildByName("completetag"):setVisible(false)
		self:getChildByName("timer"):setVisible(false)
		self:getChildByName("item"):setVisible(false)
	else
		if var_7_3 == 2 then
			self:getChildByName("name"):setPosition(cc.p(self:getContentSize().width / 2 + 73, self:getContentSize().height / 2 - 5))
			self:getChildByName("curtag"):setPosition(cc.p(self:getContentSize().width / 2 + 25, self:getContentSize().height - 20))
			self:getChildByName("item"):setPositionX(self:getContentSize().width / 2 + 110)
		else
			self:getChildByName("name"):setPosition(cc.p(self:getContentSize().width / 2 + 45, self:getContentSize().height / 2 - 5))
			self:getChildByName("curtag"):setPosition(cc.p(self:getContentSize().width / 2 + 25, self:getContentSize().height - 20))
			self:getChildByName("item"):setPositionX(self:getContentSize().width / 2 + 86)
		end

		if var_7_5 then
			if var_7_3 == 2 then
				self:getChildByName("name"):setPosition(cc.p(self:getContentSize().width / 2 + 35, self:getContentSize().height / 2 - 5))
				self:getChildByName("drop"):setPosition(cc.p(self:getContentSize().width / 2 + 77, self:getContentSize().height / 2 + 5))
				self:getChildByName("item"):setPosition(cc.p(self:getContentSize().width / 2 + 77, self:getContentSize().height / 2 + 5))
				self:getChildByName("completetag"):setPosition(cc.p(60, self:getContentSize().height - 30))
				self:getChildByName("timer"):setPosition(cc.p(62, 98))
			elseif var_7_3 == 3 then
				self:getChildByName("name"):setPosition(cc.p(self:getContentSize().width / 2 + 50, self:getContentSize().height / 2 - 11))
				self:getChildByName("drop"):setPosition(cc.p(self:getContentSize().width / 2 + 102, self:getContentSize().height / 2 - 4))
				self:getChildByName("item"):setPosition(cc.p(self:getContentSize().width / 2 + 102, self:getContentSize().height / 2 - 4))
				self:getChildByName("completetag"):setPosition(cc.p(60, self:getContentSize().height - 30))
				self:getChildByName("timer"):setPosition(cc.p(62, 88))
			end
		else
			self:getChildByName("timer"):setPosition(cc.p(42, 88))
		end

		local var_7_8 = self:getChildByName("name"):getTTFConfig()

		var_7_8.fontSize = 30

		self:getChildByName("name"):setTTFConfig(var_7_8)
		self:getChildByName("name"):setString(level_manager:getChapterName(var_7_2, var_7_1))
		self:getChildByName("drop"):setVisible(true)
		self:getChildByName("item"):setVisible(false)
		self:getChildByName("newtag"):setVisible(false)
		self:getChildByName("completetag"):setVisible(false)
		self:getChildByName("timer"):setVisible(false)

		if level_manager:isChapterModeUnlocked(var_7_2, var_7_1) then
			local var_7_9 = level_manager:getChapterStrongholdDrop(var_7_2, var_7_1)

			if var_7_9 then
				self:getChildByName("drop"):setVisible(false)
				self:getChildByName("item"):setVisible(true)

				local var_7_10 = self:getChildByName("item")
				local var_7_11 = var_7_10:getChildByName("icon")
				local var_7_12 = item_data[var_7_9].equip_quality or 1
				local var_7_13 = item_data[var_7_9].image_id or 100

				var_7_10:loadTextures("public/box/" .. var_7_12 .. ".png", "public/box/" .. var_7_12 .. ".png", "public/box/" .. var_7_12 .. ".png", var_0_7)
				var_7_11:loadTextures("equipment/" .. var_7_13 .. ".png", "equipment/" .. var_7_13 .. ".png", "equipment/" .. var_7_13 .. ".png")
				var_7_11:setScale(var_7_10:getContentSize().width / var_7_11:getContentSize().width)
			else
				self:getChildByName("drop"):setVisible(true)
			end

			;(function()
				if arg_7_1.timer then
					local var_8_0 = patrol_manager:getPatrolInfo(arg_7_1.timer.key)

					if var_8_0 and var_8_0.time > 0 then
						self:getChildByName("timer"):setVisible(true)
					else
						self:getChildByName("timer"):setVisible(false)
					end
				else
					local var_8_1 = patrol_manager:getPatrolState(var_7_2 .. "-" .. var_7_1)

					if var_8_1 == 3 then
						self:getChildByName("timer"):setVisible(true)
					elseif var_8_1 == 2 then
						self:getChildByName("timer"):setVisible(false)
						self:getChildByName("completetag"):setVisible(true)
					else
						self:getChildByName("timer"):setVisible(false)
					end
				end
			end)()
		end
	end

	local var_7_14 = level_manager:getChapterStarsState(var_7_2, var_7_1)

	for iter_7_0 = 1, LEVEL_STARS_NUM do
		local var_7_15 = self:getChildByName("star" .. iter_7_0)

		if var_7_3 == 1 then
			pos_x, pos_y = 90 + (iter_7_0 - (LEVEL_STARS_NUM + 1) / 2) * 20, 75

			var_7_15:setScale(0.83)
		else
			pos_x, pos_y = 110 + (iter_7_0 - (LEVEL_STARS_NUM + 1) / 2) * 25, 82

			var_7_15:setScale(1)
		end

		var_7_15:setPosition(pos_x, pos_y)

		if var_7_5 then
			if var_7_3 == 2 then
				var_7_15:setPosition(pos_x + 2, pos_y)
			elseif var_7_3 == 3 then
				var_7_15:setPosition(pos_x + 1, pos_y - 8)
			end
		end

		if var_7_14[iter_7_0] then
			var_7_15:loadTexture("LevelMap/star_icon.png", var_0_7)
		else
			var_7_15:loadTexture("LevelMap/star_gray.png", var_0_7)
		end
	end

	self:getChildByName("curtag"):setVisible(var_7_2 == playermodel.curMode and var_7_1 == level_manager:getCurChapter(var_7_2))

	if var_7_2 == playermodel.curMode and var_7_1 == level_manager:getCurChapter(var_7_2) then
		self:getChildByName("curtag").runFadeAction()
	else
		self:getChildByName("curtag"):stopAllActions()
		self:getChildByName("curtag"):setOpacity(255)
	end

	self:getChildByName("item"):getChildByName("icon").chapter = self.chapter

	self:updatePlotViewBtn(arg_7_1, var_7_3)
end

function ChapterSprite:updateTimer(arg_9_1)
	self:getChildByName("timer"):setString(arg_9_1)
end

function ChapterSprite:updatePlotViewBtn(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1.curcity
	local var_10_1 = arg_10_1.curdifficuty or 1
	local var_10_2 = arg_10_1.chapter
	local var_10_3 = level_manager:getModeByDifficulty(arg_10_1.curcity, var_10_1)

	self:removeChildByName("plotViewBtn")

	if photo_manager:checkHaveDataByModeAndChapter(var_10_3, var_10_2) and var_10_1 == 1 and not self:getChildByName("plotViewBtn") then
		local var_10_4
		local var_10_5 = 0
		local var_10_6 = arg_10_2

		if arg_10_2 == 1 then
			var_10_6 = 5
			var_10_5 = -10
		elseif arg_10_2 == 2 then
			var_10_6 = 4
			var_10_5 = -20
		elseif arg_10_2 == 3 then
			var_10_6 = 6
			var_10_5 = -30
		end

		var_10_4 = not level_manager:isLevelModeUnlocked(var_10_3) and "LevelMap/look" .. var_10_6 .. "_lock.png" or level_manager:isChapterModeUnlocked(var_10_3, var_10_2) and "LevelMap/look" .. var_10_6 .. "_" .. var_0_8[var_10_1] .. ".png" or "LevelMap/look" .. var_10_6 .. "_lock.png"

		if not level_manager:isPlayerPassLevel(var_10_3 .. "-" .. var_10_2) then
			var_10_4 = "LevelMap/look" .. var_10_6 .. "_lock.png"
		end

		local var_10_7 = level_manager:isChapterModeUnlocked(var_10_3, var_10_2)
		local var_10_8 = TempWidget:CreateTempBtn(var_10_4, self)

		var_10_8:setName("plotViewBtn")

		var_10_8.chapter = var_10_2

		var_10_8:align(cc.p(0, 0), 0, var_10_5)
		var_10_8:_addEvent(function(arg_11_0)
			school_cinema_manager:init(function()
				local var_12_0 = level_manager:getModeByDifficulty(var_10_0, var_10_1)

				if not level_manager:isPlayerPassLevel(var_12_0 .. "-" .. arg_11_0.chapter) then
					global_ShowBlockWords("剧情未解锁")

					return
				end

				local var_12_1 = school_cinema_manager:getCinemaInfo(3)
				local var_12_3
				local var_12_4

				for iter_12_0, iter_12_1 in pairs(var_12_1) do
					if type(iter_12_1) == "table" then
						local var_12_5 = false

						for iter_12_2 = #iter_12_1.list, 1, -1 do
							local var_12_6 = string.split(iter_12_1.list[iter_12_2].id, "#")

							if tostring(var_12_0) == var_12_6[1] and tostring(arg_11_0.chapter) == string.split(var_12_6[2], "-")[1] then
								var_12_5 = true
								var_12_4 = iter_12_2

								break
							end
						end

						if var_12_5 then
							var_12_3 = iter_12_0

							break
						end
					end
				end

				if var_12_3 and var_12_4 then
					local var_12_7 = var_12_1[var_12_3].list[var_12_4]

					school_cinema_manager:doPlayerStoryPlot({
						index = 3,
						unlocklevel = var_12_1[var_12_3].list[var_12_4].id,
						dIndex = var_12_3,
						cIndex = var_12_4
					}, function()
						if var_12_7.pv then
							if DeviceManager.platform == "ios" or DeviceManager.platform == "android" then
								require("view.Layer.SchoolCinemaLayer")
								SchoolCinemaLayer:playPV("video/" .. var_12_7.pv .. ".mp4")
							else
								global_ShowBlockWords(L_PV_WARNING.Platform_Win32)
							end
						else
							require("view.Layer.TalkLayer")
							global_basic_scene:addChild(TalkLayer:create(var_12_7.classification, nil, TALK_TYPE_NORMAL, var_12_7.name), 5)
						end
					end)
				end
			end)
		end)
	end
end
