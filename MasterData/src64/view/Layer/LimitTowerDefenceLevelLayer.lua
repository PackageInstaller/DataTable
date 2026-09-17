LimitTowerDefenceLevelLayer = class("LimitTowerDefenceLevelLayer", (require("view.Layer.BaseUILayer")))

local levelmode_data = require("data.levelmode_data")
local battlefield_status_data = require("data.battlefield_status_data")
local CityList = require("view.Sprite.CityList")
local TableViewEx = require("view.Sprite.TableViewEx")
local TempWidget = require("view.Sprite.TempWidget")
local GoodsItem = require("view.Sprite.GoodsItem")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = "TowerDefenceLevelLayer/"
local var_0_8 = "LimitTowerDefenceLevelLayer/"
local var_0_9 = {
	{
		on = "TowerDefenceLevelLayer/" .. "level_bg.png",
		off = "TowerDefenceLevelLayer/" .. "small_level_gray.png"
	},
	{
		on = "TowerDefenceLevelLayer/" .. "level_bg.png",
		off = "TowerDefenceLevelLayer/" .. "small_level_gray.png"
	},
	{
		on = "TowerDefenceLevelLayer/" .. "big_level_bg.png",
		off = "TowerDefenceLevelLayer/" .. "big_level_bg_off.png"
	}
}
local var_0_10 = {
	cc.p(300, 250),
	cc.p(400, 250),
	(cc.p(350, 250))
}
local var_0_11 = "level_bg.png"
local var_0_12 = {
	cc.p(430, 126),
	cc.p(590, 126),
	(cc.p(513, 126))
}
local var_0_13 = {
	cc.p(1, 0.5),
	cc.p(1, 0.5),
	(cc.p(1, 0.5))
}
local var_0_14 = {
	cc.p(360, 21),
	cc.p(518, 21),
	(cc.p(443, 21))
}
local var_0_15 = {
	cc.p(0.5, 0.5),
	cc.p(0.5, 0.5),
	(cc.p(0.5, 0.5))
}
local var_0_16 = {
	cc.c4b(65, 58, 90, 255),
	cc.c4b(65, 58, 90, 255),
	(cc.c4b(65, 58, 90, 255))
}
local var_0_17 = {
	cc.size(395, 150),
	cc.size(395, 150),
	(cc.size(395, 150))
}
local var_0_18 = {
	cc.p(72, 4),
	cc.p(228, 4),
	(cc.p(154, 4))
}
local var_0_19 = {
	Top = 2,
	Map = 1
}

function LimitTowerDefenceLevelLayer:ctor()
	self.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.limit_tower_defence_level_manager"):getInstance()
end

function LimitTowerDefenceLevelLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LimitTowerDefenceLevelLayer.new()

	if var_2_0 and var_2_0:init() then
		return var_2_0
	end

	return nil
end

function LimitTowerDefenceLevelLayer:init()
	self:initLayer()
	self:initListener()

	return true
end

function LimitTowerDefenceLevelLayer:onEnter()
	self.super.onEnter(self)
	self.manager:RequestInfo()
end

function LimitTowerDefenceLevelLayer:initLayer()
	self._root = cc.Layer:create()

	self:addChild(self._root)

	local var_5_0 = ccui.ImageView:create("LimitTowerDefenceLevelLayer/" .. "bg.png", var_0_6)

	var_5_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self._root:addChild(var_5_0)

	local var_5_1 = ccui.ImageView:create(var_0_7 .. "down_line.png", var_0_6)

	var_5_1:setAnchorPoint(cc.p(0, 0))
	self._root:addChild(var_5_1)

	local var_5_2 = ccui.Button:create(var_0_7 .. "btn_back.png", nil, nil, var_0_6)

	var_5_2:setAnchorPoint(cc.p(0, 0.5))
	var_5_2:setPosition(0, var_5_1:getContentSize().height / 2)
	var_5_1:addChild(var_5_2)

	self.backBtn = var_5_2

	local var_5_3 = TempWidget:CreateTempImg(var_0_7 .. "title.png")

	var_5_3:setAnchorPoint(cc.p(0, 1))
	var_5_3:setPosition(0, GameDisplay.height)
	var_5_3:setTouchEnabled(true)
	self._root:addChild(var_5_3, var_0_19.Top)

	local var_5_4 = TempWidget:CreateTempLayout()

	var_5_4:setContentSize(cc.size(360, var_5_3:getContentSize().height))
	var_5_4:setPosition(cc.p(0, 0))
	var_5_3:addChild(var_5_4)

	self.titleTouchLayout = var_5_4

	local var_5_5 = TempWidget:CreateTempBtn(var_0_8 .. "shop_btn.png", var_5_3)

	var_5_5:align(cc.p(1, 1), var_5_3:size().w - 5, var_5_3:size().h - 5)
	var_5_5:_addEvent(function()
		LayerManager:switchShowLayer("MarketLayer", {
			returnLayer = "LimitTowerDefenceLevelLayer",
			singleMarket = {
				"1-49"
			}
		})
	end, {
		touchDelay = 1
	})

	local var_5_6 = TempWidget:CreateTempBtn("LevelMap/star_reward.png", self._root)

	var_5_6:hide()
	var_5_6:align(cc.p(0, 1), 0, var_5_3:getPositionY() - var_5_3:getContentSize().height)

	self.starRewardBtn = var_5_6

	local var_5_7 = ccui.ImageView:create("LevelMap/star_icon.png", var_0_6)

	var_5_7:setPosition(65, 48)
	self.starRewardBtn:addChild(var_5_7)

	local var_5_8 = TempWidget:CreateTempLabel("", FONT_NAME, 14, var_5_6)

	var_5_8:align(cc.p(0, 0.5), 80, 48)

	self.starProText = var_5_8

	local var_5_9 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_6)

	var_5_9:setPosition(5, self.starRewardBtn:getContentSize().height - 40)
	var_5_9:setVisible(false)

	self.reddotImg = var_5_9

	var_5_6:addChild(var_5_9)
end

function LimitTowerDefenceLevelLayer:initListener()
	self.backBtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 == ccui.TouchEventType.ended then
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)
	self.titleTouchLayout:setTouchEnabled(true)
	self.titleTouchLayout:addTouchEventListener(function(arg_9_0, arg_9_1)
		if not arg_9_0:isBright() then
			return
		end

		if arg_9_1 == ccui.TouchEventType.ended then
			arg_9_0:setBright(false)
			LayerManager:pushInLayer("PopActivityDetail", {
				key = "tower_defence_level_layer",
				callback = function()
					arg_9_0:setBright(true)
				end
			})
		end
	end)
	self.starRewardBtn:_addEvent(function()
		return
	end)
end

function LimitTowerDefenceLevelLayer:updateModeListView()
	if self.modeListView then
		self.modeListView:removeFromParent()

		self.modeListView = nil
	end

	local var_12_0 = CityList:create()

	var_12_0:setCityInitPosY(-135)
	var_12_0:openSlideMode(true)
	var_12_0:setPosition(cc.p(GameDisplay.cx, 145))
	var_12_0:updateCitiesProperties()
	var_12_0:setContentSize(cc.size(640, 180))

	self.modeListView = var_12_0

	self._root:addChild(var_12_0, 99)

	local var_12_1 = self.manager:getModeList()

	if var_12_1 and next(var_12_1) and #var_12_1 > 1 then
		self.modeBtns = {}

		for iter_12_0 = 1, #var_12_1 do
			local var_12_2 = self:createModeBtn(var_12_1[iter_12_0], iter_12_0)

			var_12_0:pushInCity(var_12_2)

			self.modeBtns[var_12_1[iter_12_0]] = var_12_2
		end

		local var_12_3 = ccui.ImageView:create(var_0_7 .. "arrow.png", var_0_6)
		local var_12_4 = ccui.ImageView:create(var_0_7 .. "arrow.png", var_0_6)

		var_12_4:setFlippedX(true)
		var_12_3:setPosition(cc.p(150, 0))
		var_12_4:setPosition(cc.p(-150, 0))
		var_12_0:addChild(var_12_3)
		var_12_0:addChild(var_12_4)
		var_12_0:registerSelectCityHandler(function(arg_13_0)
			local var_13_0 = self.manager:getCurMode()

			if self.manager:getCurModeIndex() == arg_13_0 then
				return
			end

			local var_13_1 = self.manager:getModeByModeIndex(arg_13_0)

			if var_13_1 then
				self.manager:setCurMode(var_13_1)
			end

			self.manager:setCurModeIndex(arg_13_0)

			local var_13_2 = self.manager:getCurMode()

			for iter_13_0, iter_13_1 in pairs(self.modeBtns) do
				if iter_13_0 ~= var_13_2 then
					iter_13_1:getChildByName("nameBg"):setVisible(false)
				else
					iter_13_1:getChildByName("nameBg"):setVisible(true)
				end
			end

			self:updateChapterView()
			self:updateAffixes()
		end)
		var_12_0:jumpToIndex(self.manager:getCurModeIndex() or 1)
	end
end

function LimitTowerDefenceLevelLayer.createModeBtn(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ccui.Button:create("TowerDefenceLevelLayer/chapter_bg" .. arg_14_2 .. ".png", nil, nil, var_0_6)

	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 == ccui.TouchEventType.ended then
			if math.abs(arg_15_0:getTouchBeganPosition().x - arg_15_0:getTouchEndPosition().x) >= 25 then
				return
			end

			arg_14_0.modeListView:scrollToIndexManual(arg_14_2)
		end
	end)
	var_14_0:setAnchorPoint(cc.p(0.5, 0))

	local var_14_1 = ccui.ImageView:create(var_0_7 .. "chapter_name" .. arg_14_2 .. ".png", var_0_6)

	var_14_1:setPosition(cc.p(250, 55))
	var_14_1:setName("nameBg")
	var_14_1:setAnchorPoint(cc.p(1, 1))
	var_14_0:addChild(var_14_1)

	local var_14_3 = ccui.Text:create((levelmode_data[arg_14_1] or nil) and (levelmode_data[arg_14_1].name or ""), FONT_NAME, 22)

	var_14_3:setPosition(cc.p(var_14_1:getContentSize().width / 2, var_14_1:getContentSize().height / 2))
	var_14_1:addChild(var_14_3)

	return var_14_0
end

function LimitTowerDefenceLevelLayer:updateChapterView()
	if self.chapterView then
		self.chapterView:removeFromParent()

		self.chapterView = nil
	end

	local var_16_0 = self.manager:getCurChapterInfo()

	if next(var_16_0) then
		local var_16_1 = TableViewEx:create({
			size = cc.size(640, GameDisplay.height - 400),
			cellSizeForTable = function(arg_17_0, arg_17_1)
				if arg_17_1 + 1 ~= 1 then
					if (arg_17_1 + 1) % 3 == 0 then
						return 640, 352
					elseif (arg_17_1 + 1) % 3 == 1 then
						return 640, 352
					elseif (arg_17_1 + 1) % 3 == 2 then
						return 640, 352
					end
				else
					return 640, 352
				end
			end,
			tableCellAtIndex = function(self, arg_18_1)
				local var_18_0 = self:dequeueCell()

				if not var_18_0 then
					var_18_0 = cc.TableViewCell:new()
				else
					var_18_0:removeAllChildren()
				end

				var_18_0:addChild((self:createCellLayout(arg_18_1 + 1)))

				return var_18_0
			end,
			numberOfCellsInTableView = function(arg_19_0)
				return #var_16_0
			end,
			verticalFillOrder = cc.TABLEVIEW_FILL_BOTTOMUP
		})
		local var_16_2 = self.manager:getCurChapter()
		local var_16_3 = self.manager:getModeTotalChapter()

		if var_16_3 then
			var_16_1:scrollToPercent(math.max(0, (math.min(var_16_2 <= 4 and 0 or (var_16_2 - 4) / var_16_3 * 100, 100))), nil, false)
		end

		self._root:addChild(var_16_1, var_0_19.Map)
		var_16_1:setPosition(cc.p(0, 300))

		self.chapterView = var_16_1
	end
end

function LimitTowerDefenceLevelLayer:createCellLayout(arg_20_1)
	local var_20_0 = self.manager:getCurChapterInfo()[arg_20_1]
	local var_20_1 = cc.size(0, 0)
	local var_20_2 = arg_20_1 % 3

	var_20_2 = arg_20_1 % 3 == 0 and 3 or var_20_2

	if self.manager:isLevelModeAutoUnlocked() and self.manager:isChapterModeUnlocked(arg_20_1) then
		if var_20_0.bgPath then
			if string.find(var_20_0.bgPath, "army") then
				var_0_11 = string.gsub(var_20_0.bgPath, "TowerDefenceLevelLayer", "LimitTowerDefenceLevelLayer")
			end
		else
			var_0_11 = var_0_9[var_20_2].on
		end
	else
		var_0_11 = var_20_0.bgPathGray and (string.find(var_20_0.bgPathGray, "army") and string.gsub(var_20_0.bgPathGray, "TowerDefenceLevelLayer", "LimitTowerDefenceLevelLayer") or var_0_7 .. string.format("army0%d_gray.png", arg_20_1)) or var_0_9[var_20_2].off
	end

	local var_20_3 = cc.p(0, 0)

	if arg_20_1 ~= 1 then
		if arg_20_1 % 3 == 0 then
			var_20_1 = cc.size(640, 352)
			var_20_3 = cc.p(153, -1)
		elseif arg_20_1 % 3 == 1 then
			var_20_1 = cc.size(640, 352)
			var_20_3 = cc.p(70, 0)
		elseif arg_20_1 % 3 == 2 then
			var_20_1 = cc.size(640, 352)
			var_20_3 = cc.p(227, -1)
		end
	else
		var_20_1 = cc.size(640, 352)
		var_20_3 = cc.p(70, 0)
	end

	local var_20_4 = TempWidget:CreateTempLayout()

	var_20_4:setContentSize(var_20_1)

	if var_20_0 and next(var_20_0) then
		local var_20_6 = ccui.ImageView:create(var_0_8 .. "line" .. ((var_20_2 % 2 == 0 or nil) and 2) .. ".png", var_0_6)

		var_20_6:setPosition(var_0_10[var_20_2])
		var_20_4:addChild(var_20_6)

		local var_20_7 = ccui.ImageView:create(var_0_11, var_0_6)

		var_20_7:setAnchorPoint(cc.p(0, 0))
		var_20_7:setPosition(var_20_3)
		var_20_4:addChild(var_20_7)

		local var_20_8 = cc.Label:createWithTTF("", "fonts/name.ttf", 30)

		var_20_8:setString(var_20_0.name or "")
		var_20_8:setAnchorPoint(var_0_13[var_20_2])
		var_20_8:setPosition(var_0_12[var_20_2])
		var_20_4:addChild(var_20_8)

		local var_20_9 = cc.Label:createWithTTF("", "fonts/name.ttf", 20)

		var_20_9:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)
		var_20_9:setTextColor(var_0_16[var_20_2])
		var_20_9:setString(var_20_0.des or "")
		var_20_9:setAnchorPoint(var_0_15[var_20_2])
		var_20_9:setPosition(var_0_14[var_20_2])
		var_20_4:addChild(var_20_9)

		local var_20_10 = TempWidget:CreateTempLayout()

		var_20_10:hide()
		var_20_10:setContentSize(cc.size(100, 30))
		var_20_7:addChild(var_20_10)

		local var_20_11 = self.manager:getChapterStarsState(arg_20_1)

		for iter_20_0 = 1, #var_20_11 do
			local var_20_12 = TempWidget:CreateTempImg()

			var_20_10:addChild(var_20_12)

			if var_20_11[iter_20_0] then
				var_20_12:loadTexture("LevelMap/star_icon.png", var_0_6)
			else
				var_20_12:loadTexture("LevelMap/star_gray.png", var_0_6)
			end

			var_20_12:align(cc.p(1, 0.5), var_20_10:size().w - (iter_20_0 - 1) * 22, var_20_10:size().h / 2 - 7)
		end

		if var_20_2 ~= 3 then
			var_20_10:align(cc.p(1, 0), var_20_7:getContentSize().width - 20, 50)

			if var_20_2 == 1 then
				-- block empty
			elseif var_20_2 == 2 then
				-- block empty
			end
		else
			var_20_10:align(cc.p(1, 0), var_20_7:getContentSize().width - 45, 80)
		end

		local var_20_13 = ccui.Button:create()

		var_20_13:ignoreContentAdaptWithSize(false)
		var_20_13:setContentSize(var_0_17[var_20_2])
		var_20_13:setPosition(var_0_18[var_20_2])
		var_20_13:setSwallowTouches(false)
		var_20_13:setAnchorPoint(cc.p(0, 0))
		var_20_13:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 == ccui.TouchEventType.ended then
				if arg_21_1 ~= ccui.TouchEventType.ended then
					return
				end

				if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
					return
				end

				local var_21_0 = self.manager:getCurMode()
				local var_21_1 = arg_20_1
				local tower_defence_manager = require("controller.tower_defence_manager")

				LayerManager:pushInLayer("TowerDefenceDetailLayer", {
					mode = var_21_0,
					chapter = arg_20_1,
					surecallback = function()
						LayerManager:switchShowLayer("TowerDefenceSelectLayer", {
							mode = var_21_0,
							chapter = var_21_1,
							sureCallback = function(arg_23_0)
								tower_defence_manager:switchToTowerDefence(var_21_0, var_21_1, arg_23_0, function(arg_24_0)
									if arg_24_0.result == 1 then
										RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", var_21_0)
										FightManager.refreshFightToType(FIGHTTYPE_TOWER)
										LayerManager:switchShowLayer("FightLayer", {
											is_hide_topcost = true,
											is_hide_listbutton = true
										})
									end
								end)
							end
						})
					end
				})
			end
		end)
		var_20_4:addChild(var_20_13)

		local var_20_14 = ccui.Layout:create()

		var_20_14:setContentSize(var_20_13:getContentSize())
		var_20_14:setPosition(cc.p(var_20_13:getPosition()))
		var_20_4:addChild(var_20_14)

		local var_20_15 = ccui.ImageView:create()

		var_20_15:loadTexture(var_0_7 .. "select.png", var_0_6)
		var_20_15:setFlippedX(true)
		var_20_15:setAnchorPoint(cc.p(1, 0.5))
		var_20_15:setPosition(cc.p(-10, var_20_14:getContentSize().height / 2))
		var_20_14:addChild(var_20_15)

		local var_20_16 = ccui.ImageView:create()

		var_20_16:loadTexture(var_0_7 .. "select.png", var_0_6)
		var_20_16:setAnchorPoint(cc.p(0, 0.5))
		var_20_16:setPosition(cc.p(var_20_14:getContentSize().width + 10, var_20_14:getContentSize().height / 2))
		var_20_14:addChild(var_20_16)

		if var_20_0.curStatus == 1 then
			var_20_14:setVisible(true)
			var_20_15:stopAllActions()
			var_20_16:stopAllActions()
			var_20_15:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				var_20_15:setPositionX(-30)
				var_20_15:setOpacity(255)
			end), cc.MoveBy:create(0.7, cc.p(20, 0)), cc.FadeOut:create(0.8)))))
			var_20_16:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				var_20_16:setPositionX(var_20_14:getContentSize().width + 30)
				var_20_16:setOpacity(255)
			end), cc.MoveBy:create(0.7, cc.p(-20, 0)), cc.FadeOut:create(0.8)))))
		else
			var_20_14:setVisible(false)
		end

		local var_20_17 = self.manager:getAllDrop(arg_20_1)

		for iter_20_1 = 1, #var_20_17 do
			local var_20_18 = var_20_17[iter_20_1].dropNum

			if IsOpenPrivilege() and var_20_17[iter_20_1].dropid == 10100003 then
				var_20_18 = var_20_18 + var_20_18 * (GetPrivilegeWarCompetitivePointMarkup() / 100)
			end

			local var_20_19 = GoodsItem:create({
				itemId = var_20_17[iter_20_1].dropid,
				count = var_20_18
			})

			var_20_13:addChild(var_20_19)

			local var_20_20 = cc.p(0, 0)

			var_20_19:setScale(0.45)
			var_20_19:align(cc.p(0, 0), 35 + 100 * (iter_20_1 - 1), 55 - 5)
			var_20_19:setCountTextScale(1.2)

			local var_20_21 = cc.p(var_20_19:getPositionX() + var_20_19:size().w * 0.45 + 10, var_20_19:getPositionY())
			local var_20_22 = TempWidget:CreateTempLabel("X " .. var_20_18, FONT_W5, 20, var_20_13)

			var_20_22:_setColor("#FFFFFF")
			var_20_22:hide()
			var_20_22:align(cc.p(0, 0), var_20_21.x, var_20_21.y)

			local activity_return_manager = require("controller.activity_return_manager")

			if var_20_17[iter_20_1].dropid ~= GoodsItem.SpecialID.Diamond and activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_ADVENTURE_DROP) then
				local var_20_24 = ccui.ImageView:create("public/panelbg/img_getup.png", var_0_6)

				var_20_24:setName("imgCatchUp")
				var_20_19:addChild(var_20_24)
				var_20_24:setPosition(var_20_19:getContentSize().width - 30, 60)
				var_20_24:setVisible(levelmode_data[self.manager:getCurMode()].modetype == 2 or levelmode_data[self.manager:getCurMode()].modetype == 1031)
			end
		end
	end

	return var_20_4
end

function LimitTowerDefenceLevelLayer:updateAffixes()
	if self.affixes then
		self.affixes:removeFromParent()

		self.affixes = nil
	end

	local var_27_0 = self.manager:getCurMode()
	local var_27_1 = self.manager:getChapterInfoByMode(var_27_0)

	if var_27_1 and var_27_1[1] then
		local var_27_2, var_27_3 = require("controller.level_manager"):getChapterBattleFieldInfo(var_27_0 .. "-" .. 1)

		if var_27_3 and var_27_3[1] then
			local var_27_4 = ccui.ImageView:create("Array/btn_element_on.png", var_0_6)

			var_27_4:setAnchorPoint(cc.p(1, 0))
			var_27_4:setPosition(self._root:getContentSize().width + 10, 230)

			self.affixes = var_27_4

			self._root:addChild(var_27_4, 99)

			local var_27_5 = ccui.ImageView:create("Array/" .. battlefield_status_data[var_27_3[1]].img .. ".png", var_0_6)

			var_27_5:setPosition(cc.p(35, var_27_4:getContentSize().height / 2))
			var_27_4:addChild(var_27_5)

			local var_27_6 = cc.Label:createWithTTF(battlefield_status_data[var_27_3[1]].des, FONT_DES, 17)

			var_27_6:setAnchorPoint(cc.p(1, 0.5))
			var_27_6:setColor(cc.c3b(212, 226, 242))
			var_27_6:setPosition(cc.p(var_27_4:getContentSize().width - 15, var_27_4:getContentSize().height / 2 - 3))
			var_27_4:addChild(var_27_6)
		end
	end
end

function LimitTowerDefenceLevelLayer:updateStarReward()
	self.starProText:setString(self.manager:getModeTotalStars() .. "/" .. self.manager:getModeTotalChapter() * 3)

	if self.manager:checkIsNewStarReward() then
		self.reddotImg:setVisible(true)
	else
		self.reddotImg:setVisible(false)
	end
end

function LimitTowerDefenceLevelLayer:updateLayer()
	self:updateModeListView()
	self:updateChapterView()
	self:updateAffixes()
	self:updateStarReward()
end
