ExploreMapLayer = class("ExploreMapLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local favor_data = require("data.favor_data")
local explore_buff_data = require("data.explore.explore_buff_data")
local explore_sellbuff_data = require("data.explore.explore_sellbuff_data")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local explore_sellweapon_data = require("data.explore.explore_sellweapon_data")
local explore_weapon_data = require("data.explore.explore_weapon_data")
local explore_map_config_data = require("data.explore.explore_map_config_data")
local servant_data = require("data.servant_data")
local plot_data = require("data.plot_data")
local plot_class_data = require("data.plot_class_data")
local explore_img_data = require("data.explore.explore_img_data")
local L2Actor = require("view.Sprite.L2Actor")
local explore_manager = require("controller.explore_manager")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local l2utils = require("controller.l2utils")
local var_0_26
local var_0_27
local var_0_28
local var_0_29
local var_0_30
local var_0_31
local var_0_32
local var_0_40 = 1
local var_0_41 = 2
local var_0_42 = 3
local var_0_43 = 4
local var_0_46 = {
	RANDOM_EVENT = 5,
	ACTIVITY_MONEY = 29,
	MONEY = 6,
	SKILL_BOOK = 15,
	SPECIAL_ENEMY = 11,
	GOLD_BOX = 14,
	ACTIVITY_ITEM = 30,
	COMPONENT_CHIP = 21,
	KEY = 9,
	WEAPON = 22,
	CHIP = 17,
	LAB_MATERIALS = 16,
	COMPONENT = 7,
	ENERGY_BATTERY = 8,
	NORMAL_ENEMY = 13,
	NPC = 27,
	DES_WALL = 19,
	LOCK_BOX = 10
}
local var_0_47 = {
	[var_0_46.RANDOM_EVENT] = "随机事件",
	[var_0_46.MONEY] = "探险货币",
	[var_0_46.COMPONENT] = "零件",
	[var_0_46.ENERGY_BATTERY] = "能量电池",
	[var_0_46.KEY] = "探险磁卡",
	[var_0_46.LOCK_BOX] = "泛用魂器箱",
	[var_0_46.SPECIAL_ENEMY] = "秘藏守护者",
	[var_0_46.NORMAL_ENEMY] = "探险怪物",
	[var_0_46.GOLD_BOX] = "钞票箱",
	[var_0_46.SKILL_BOOK] = "职业技能书箱",
	[var_0_46.LAB_MATERIALS] = "礼物箱",
	[var_0_46.CHIP] = "职业模块箱",
	[var_0_46.COMPONENT_CHIP] = "零件芯片",
	[var_0_46.WEAPON] = "通用魂武箱",
	[var_0_46.ACTIVITY_MONEY] = "应援棒",
	[var_0_46.ACTIVITY_ITEM] = "剧情物品"
}
local var_0_48 = {
	[var_0_46.SPECIAL_ENEMY] = "explore/monster_title1.png"
}
local var_0_49 = {
	[var_0_46.SPECIAL_ENEMY] = true,
	[var_0_46.NORMAL_ENEMY] = true
}
local var_0_50 = {
	GET_ITEM = 7,
	SHOP_BUFF = 6,
	NEXT_FLOOR = 5,
	SUB_HP = 2,
	FIGHT = 4,
	GET_DROP = 3,
	SHOP_ITEM = 8,
	NOTHING = 666,
	ADD_HP = 1,
	DEAD = 0
}
local var_0_51 = false
local var_0_52 = {
	94,
	320,
	546
}
local var_0_53 = 50
local var_0_54 = 163
local var_0_55 = 0.2
local var_0_56 = 0.28
local var_0_57 = 0.8
local var_0_58 = {
	cc.p(336, 873),
	cc.p(147, 688),
	cc.p(464, 630),
	cc.p(49, 461),
	cc.p(409, 405),
	(cc.p(-25, 255))
}

function ExploreMapLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ExploreMapLayer.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ExploreMapLayer.getInstance()
	return var_0_32
end

function ExploreMapLayer:init(arg_5_1)
	var_0_32 = self
	self.touchLock = false
	self.curMapType = explore_manager.curMapConfig.otherInfos.maptype
	self.curMapFloor = explore_manager.curMapConfig.otherInfos.mapfloor
	var_0_26 = explore_manager.getCurData("map", self.curMapType)
	var_0_27 = explore_manager.getCurData("room", self.curMapType)
	var_0_28 = explore_manager.getCurData("roomTile", self.curMapType)
	var_0_29 = explore_manager.getCurData("tile", self.curMapType)
	var_0_30 = explore_manager.getCurData("level", self.curMapType)
	var_0_31 = explore_manager.getCurData("monsterTeam", self.curMapType)

	self:initUI()

	local var_5_0
	local var_5_1 = explore_manager.getCurData("map", explore_manager.curMapConfig.otherInfos.maptype)

	var_5_0 = explore_manager.curMapConfig.plotMapId and var_5_1[explore_manager.curMapConfig.plotMapId].enter_map_talk or var_5_1[explore_manager.curMapConfig.otherInfos.mapfloor].enter_map_talk

	if var_5_0 then
		global_basic_scene:addChild(TalkLayer:create(var_5_0, nil, TALK_TYPE_NORMAL, "", function()
			if oldmaptype == 101 and oldmaplevel == 1 then
				LayerManager:pushInLayer("TipsLayer", {
					tips = {
						"mainScenebg/guide/5.jpg",
						"mainScenebg/guide/6.jpg",
						"mainScenebg/guide/7.jpg",
						"mainScenebg/guide/13.jpg"
					}
				})
			end
		end))
	end

	self:mapLoading(explore_manager.curMapConfig.otherInfos.maptype, explore_manager.curMapConfig.otherInfos.mapfloor, function()
		self:updateMapUI()
		self:genMap()
		self.mapPanel:setVisible(true)
	end)
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			var_0_32 = nil
		end
	end)
end

function ExploreMapLayer:initUI()
	self.mapPanel = ccui.Layout:create()

	self.mapPanel:setVisible(false)
	self:addChild(self.mapPanel)

	self.mapView = ccui.ScrollView:create()

	self.mapView:setDirection(ccui.ScrollViewDir.both)
	self.mapView:setContentSize(cc.size(640, 1136))
	self.mapView:setTouchEnabled(false)
	self.mapPanel:addChild(self.mapView, 1)

	self.mapUIPanel = ccui.Layout:create()

	self.mapPanel:addChild(self.mapUIPanel, 9)

	local var_9_0 = ccui.ImageView:create("explore/top_bg.png", var_0_0)

	var_9_0:setAnchorPoint(cc.p(0, 1))
	var_9_0:setPosition(0, SCREEN_HEIGHT)
	var_9_0:setName("topbg")
	self.mapUIPanel:addChild(var_9_0)

	self.mapFloorLabel = cc.Label:createWithTTF("", FONT_TITLE, 40)

	self.mapFloorLabel:setName("mapfloor")
	self.mapFloorLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self.mapFloorLabel:setPosition(var_9_0:getContentSize().width / 2, var_9_0:getContentSize().height / 2 + 14)
	var_9_0:addChild(self.mapFloorLabel)

	local var_9_1 = ccui.Button:create("explore/map_give_up.png", nil, "explore/map_give_up.png", var_0_0)

	var_9_1:setAnchorPoint(cc.p(1, 1))
	var_9_1:setPosition(var_9_0:getContentSize().width - 10, var_9_0:getContentSize().height)
	var_9_0:addChild(var_9_1)
	var_9_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		explore_manager:reset_map(self.curMapType, {
			mapfloor = 0,
			maplevel = 6
		})
		LayerManager:switchShowLayer("ExploreUILayer")
	end)

	local var_9_2 = ccui.Button:create("explore/box_icon.png", nil, nil, var_0_0)

	var_9_2:setTouchEnabled(true)
	var_9_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_2:setPosition(640 - var_9_2:getContentSize().width / 2, 1036)
	var_9_2:setName("boxicon")
	self.mapUIPanel:addChild(var_9_2)

	local var_9_3 = ccui.ImageView:create("explore/box_bar_bg.png", var_0_0)

	var_9_3:setAnchorPoint(cc.p(0.5, 1))
	var_9_3:setPosition(var_9_2:getPositionX(), var_9_2:getPositionY() - var_9_2:getContentSize().height / 2 - 8)
	self.mapUIPanel:addChild(var_9_3)

	self.exploreProgressBar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("explore/box_bar.png") or cc.Sprite:createWithSpriteFrameName("explore/box_bar.png")))

	self.exploreProgressBar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.exploreProgressBar:setBarChangeRate(cc.p(1, 0))
	self.exploreProgressBar:setMidpoint(cc.p(0, 0))
	self.exploreProgressBar:setAnchorPoint(cc.p(0.5, 0.5))
	self.exploreProgressBar:setPosition(var_9_3:getContentSize().width / 2, var_9_3:getContentSize().height / 2)
	var_9_3:addChild(self.exploreProgressBar)

	self.exploreProgressLabel = cc.Label:createWithTTF("", FONT_NAME, 24)

	self.exploreProgressLabel:setPosition(self.exploreProgressBar:getContentSize().width / 2, self.exploreProgressBar:getContentSize().height / 2)
	self.exploreProgressBar:addChild(self.exploreProgressLabel)

	self.exploreProgressBg = ccui.Layout:create()

	self.exploreProgressBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.exploreProgressBg:setBackGroundColor(cc.c3b(0, 0, 0))
	self.exploreProgressBg:setBackGroundColorOpacity(160)
	self.exploreProgressBg:setCascadeOpacityEnabled(false)
	self.exploreProgressBg:setAnchorPoint(cc.p(1, 1))
	self.exploreProgressBg:setPosition(640, var_9_2:getPositionY() - var_9_2:getContentSize().height / 2 - 30)

	self.exploreProgressBg.pos_type = "up"

	self.exploreProgressBg:setVisible(false)
	self.exploreProgressBg:setScale(0.1)
	self.mapUIPanel:addChild(self.exploreProgressBg)
	var_9_2:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			self:showExploreProgress()
		end
	end)

	local var_9_4 = ccui.ImageView:create("explore/bottom_bg.png", var_0_0)

	var_9_4:setName("bottombg")
	var_9_4:setTouchEnabled(true)
	var_9_4:setAnchorPoint(cc.p(0, 0))
	var_9_4:setPosition(0, -70)

	var_9_4.status = "down"

	self.mapUIPanel:addChild(var_9_4)

	function var_9_4.changePos(arg_12_0)
		if var_9_4.status == "up" then
			var_9_4.status = "running"

			var_9_4:getChildByName("arrowBnt"):loadTextures("explore/arrow_up.png", nil, "explore/arrow_up.png", var_0_0)
			var_9_4:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(0, -70)), cc.CallFunc:create(function()
				var_9_4.status = "down"

				for iter_13_0 = 1, 3 do
					if var_9_4:getChildByName(iter_13_0) then
						var_9_4:getChildByName(iter_13_0):setVisible(false)
					end
				end
			end)))
		elseif var_9_4.status == "down" then
			var_9_4.status = "running"

			var_9_4:getChildByName("arrowBnt"):loadTextures("explore/arrow_down.png", nil, "explore/arrow_down.png", var_0_0)
			var_9_4:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				local var_14_0 = {}

				for iter_14_0, iter_14_1 in pairs(explore_manager.curMapConfig.otherInfos.array) do
					var_14_0[iter_14_1.pos] = true
				end

				for iter_14_2 = 1, 3 do
					if var_14_0[iter_14_2] and var_9_4:getChildByName(iter_14_2) then
						var_9_4:getChildByName(iter_14_2):setVisible(true)
					end
				end
			end), cc.MoveTo:create(0.5, cc.p(0, 80)), cc.CallFunc:create(function()
				var_9_4.status = "up"
			end)))
		end
	end

	var_9_4:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y > var_9_4:getContentSize().height / 3 and var_9_4.status == "up" then
			var_9_4:changePos()
		elseif var_9_4.status == "down" then
			var_9_4:changePos()
		end
	end)

	local var_9_5 = ccui.Button:create("explore/bag_icon.png", nil, "explore/bag_icon.png", var_0_0)

	var_9_5:setAnchorPoint(cc.p(1, 0))
	var_9_5:setPosition(638, var_9_4:getContentSize().height - 2)
	var_9_4:addChild(var_9_5)
	var_9_5:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:popExploreBag()
	end)

	local var_9_6 = ccui.ImageView:create("explore/blood_bg.png", var_0_0)

	var_9_6:setAnchorPoint(cc.p(0, 0))
	var_9_6:setPosition(0, var_9_4:getContentSize().height)
	var_9_4:addChild(var_9_6)

	local var_9_7 = ccui.Button:create("explore/arrow_up.png", nil, "explore/arrow_up.png", var_0_0)

	var_9_7:setName("arrowBnt")
	var_9_7:setAnchorPoint(cc.p(0.5, 0))
	var_9_7:setPosition(320, var_9_4:getContentSize().height + var_9_6:getContentSize().height - 20)
	var_9_4:addChild(var_9_7)
	var_9_7:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_9_4:changePos()
	end)

	self.bloodbar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("explore/blood_bar.png") or cc.Sprite:createWithSpriteFrameName("explore/blood_bar.png")))

	self.bloodbar:setBarChangeRate(cc.p(1, 0))
	self.bloodbar:setMidpoint(cc.p(0, 0))
	self.bloodbar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bloodbar:setAnchorPoint(0, 0)
	self.bloodbar:setPosition(0, 0)
	var_9_6:addChild(self.bloodbar)

	self.bloodLabel = cc.Label:createWithTTF("", FONT_NAME, 16)

	self.bloodLabel:setAnchorPoint(cc.p(0, 1))
	self.bloodLabel:setPosition(6, var_9_6:getContentSize().height - 4)
	var_9_6:addChild(self.bloodLabel)

	self.smallMap = ccui.ImageView:create("explore/small_map_bg.png", var_0_0)

	self.smallMap:setAnchorPoint(cc.p(0, 1))
	self.smallMap:setPosition(0, 1136)
	self.mapUIPanel:addChild(self.smallMap)

	local var_9_8 = ccui.Layout:create()

	var_9_8:setPosition(0, 0)
	var_9_8:setContentSize(cc.size(640, 80))
	var_9_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_8:setBackGroundColor(cc.c3b(0, 0, 0))
	self.mapUIPanel:addChild(var_9_8)
end

function ExploreMapLayer:removeMap(arg_19_1)
	if not arg_19_1 then
		return
	end

	if self.isPopExploreDifficult and self.isPopExploreDifficult.maptype == arg_19_1 then
		self.isPopExploreDifficult:runAction(cc.RemoveSelf:create())

		self.isPopExploreDifficult = nil
	end

	TopcostLayer.getInstance():showTopcostLayer()
end

function ExploreMapLayer:popExploreBag()
	local var_20_0 = ccui.Layout:create()

	var_20_0:setTouchEnabled(true)
	var_20_0:setContentSize(cc.size(640, 1136))
	var_20_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_20_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_20_0:setBackGroundColorOpacity(200)
	var_20_0:setCascadeOpacityEnabled(false)
	self:addChild(var_20_0, 999)
	var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_20_0:runAction(cc.RemoveSelf:create())
	end)

	local var_20_1 = cc.SpriteBatchNode:create("tilemap/pop_bg_tile.png")

	var_20_0:addChild(var_20_1)

	for iter_20_0 = 1, 10 do
		for iter_20_1 = 1, 7 do
			local var_20_2 = cc.Sprite:create("tilemap/pop_bg_tile.png")

			var_20_2:setPosition(80 + (iter_20_1 - 1) * 80, 260 + (iter_20_0 - 1) * 80)
			var_20_1:addChild(var_20_2)
		end
	end

	local var_20_3 = ccui.ImageView:create("explore/pop_up.png", var_0_0)

	var_20_3:setPosition(320, 1040)
	var_20_3:setScaleX(560 / var_20_3:getContentSize().width)
	var_20_0:addChild(var_20_3)

	local var_20_4 = cc.Label:createWithTTF("探险背包", FONT_TITLE, 30)

	var_20_4:setAnchorPoint(cc.p(0, 0.5))
	var_20_4:setPosition(10, 20)
	var_20_3:addChild(var_20_4)

	local var_20_5 = ccui.ImageView:create("explore/pop_down.png", var_0_0)

	var_20_5:setPosition(320, 218)
	var_20_5:setScaleX(560 / var_20_5:getContentSize().width)
	var_20_0:addChild(var_20_5)

	local var_20_6 = explore_manager:getCurMapItems()

	if next(var_20_6) == nil then
		local var_20_7 = cc.Label:createWithTTF("空空如也~", FONT_TITLE, 40)

		var_20_7:setPosition(var_20_0:getContentSize().width / 2, var_20_0:getContentSize().height / 2 + 30)
		var_20_7:setOpacity(200)
		var_20_0:addChild(var_20_7, 9)
	end

	local var_20_8 = ccui.ScrollView:create()

	var_20_8:setBounceEnabled(true)

	local var_20_9 = #var_20_6 * 250 < 800 and 800 or #var_20_6 * 250

	var_20_8:setInnerContainerSize(cc.size(560, #var_20_6 * 250 < 800 and 800 or #var_20_6 * 250))
	var_20_8:setDirection(ccui.ScrollViewDir.vertical)
	var_20_8:setContentSize(cc.size(560, 800))
	var_20_8:setAnchorPoint(cc.p(0.5, 0))
	var_20_8:setPosition(320, 220)
	var_20_0:addChild(var_20_8)

	for iter_20_2, iter_20_3 in ipairs(var_20_6) do
		local var_20_10 = ItemSprite:createBigWithEntityId(iter_20_3.entityid)

		var_20_10:setAnchorPoint(cc.p(0, 0))
		var_20_10:setPosition(4 + (iter_20_2 - 1) % 3 * 189, var_20_9 - (math.floor((iter_20_2 - 1) / 3) + 1) * 250)
		var_20_8:addChild(var_20_10)
		var_20_10:setTouchEnabled(true)
		var_20_10:addSpriteTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_20_0:addChild(PopLayer:Item({
				hideGainButton = true,
				entityid = iter_20_3.entityid,
				itemid = iter_20_3.itemid
			}))
		end)
	end
end

function ExploreMapLayer:updateMapUI()
	self:updateHPUI()
	self:updateArrayUI()
	self:updateBuffUI()
	self:updateFloorUI()
	self:initExploreProgress()
end

function ExploreMapLayer:updateFloorUI()
	self.mapFloorLabel:setString(explore_manager.curMapConfig.otherInfos.mapfloor)
end

function ExploreMapLayer:updateBuffUI()
	if not explore_manager.curMapConfig.otherInfos.bufflist then
		return
	end

	for iter_25_0, iter_25_1 in pairs(explore_manager.curMapConfig.otherInfos.bufflist) do
		local var_25_0 = total_skill_data[iter_25_1]
		local var_25_1

		if total_skill_data[iter_25_1].icon then
			var_25_1 = "skill_new/skill/" .. total_skill_data[iter_25_1].icon .. ".png" or "skill_new/skill/7.png"

			if self.mapUIPanel:getChildByName("buff" .. iter_25_0) then
				self.mapUIPanel:getChildByName("buff" .. iter_25_0):getChildByName("icon"):loadTexture(var_25_1, var_0_0)

				goto label_25_0
			end
		end

		do
			local var_25_2 = self.mapUIPanel:getChildByName("bottombg")
			local var_25_3 = var_25_2:getPositionY() + var_25_2:getContentSize().height + 12
			local var_25_4 = ccui.ImageView:create("explore/buff_bg.png", var_0_0)

			var_25_4:setName("buff" .. iter_25_0)
			var_25_4:setTouchEnabled(true)
			var_25_4:setAnchorPoint(cc.p(0.5, 0))
			var_25_4:setPosition(600 - iter_25_0 * 60, var_25_3)
			self.mapUIPanel:addChild(var_25_4)

			local var_25_5 = ccui.ImageView:create(var_25_1, var_0_0)

			var_25_5:setName("icon")
			var_25_5:setScale(51 / var_25_5:getContentSize().width)
			var_25_5:setPosition(var_25_4:getContentSize().width / 2, var_25_4:getContentSize().height / 2)
			var_25_4:addChild(var_25_5)
		end

		::label_25_0::

		self.mapUIPanel:getChildByName("buff" .. iter_25_0):addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 == ccui.TouchEventType.began then
				local var_26_0 = ccui.Layout:create()

				var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_26_0:setBackGroundColor(cc.c3b(0, 0, 0))
				var_26_0:setBackGroundColorOpacity(200)
				var_26_0:setName("des_layout")
				var_26_0:setAnchorPoint(cc.p(0.5, 0))
				var_26_0:setCascadeOpacityEnabled(false)
				var_26_0:setPosition(self.mapUIPanel:getChildByName("buff" .. iter_25_0):getContentSize().width / 2, self.mapUIPanel:getChildByName("buff" .. iter_25_0):getContentSize().height + 10)
				self.mapUIPanel:getChildByName("buff" .. iter_25_0):addChild(var_26_0)

				local var_26_1 = cc.Label:createWithTTF(var_25_0.name .. ": " .. var_25_0.description, FONT_DES, 24)

				var_26_1:setMaxLineWidth(210)
				var_26_1:setAnchorPoint(cc.p(0, 1))
				var_26_0:setContentSize(var_26_1:getContentSize())
				var_26_1:setPosition(0, var_26_0:getContentSize().height)
				var_26_0:addChild(var_26_1)
			elseif arg_26_1 == ccui.TouchEventType.ended or arg_26_1 == ccui.TouchEventType.canceled then
				if self.mapUIPanel:getChildByName("buff" .. iter_25_0):getChildByName("des_layout") then
					self.mapUIPanel:getChildByName("buff" .. iter_25_0):getChildByName("des_layout"):runAction(cc.RemoveSelf:create())
				end
			end
		end)
	end
end

function ExploreMapLayer:removeAllBuffIcon()
	for iter_27_0 = 1, 3 do
		if self.mapUIPanel:getChildByName("buff" .. iter_27_0) then
			self.mapUIPanel:getChildByName("buff" .. iter_27_0):removeFromParent()
		end
	end
end

function ExploreMapLayer:updateArrayUI()
	local var_28_0 = self.mapUIPanel:getChildByName("bottombg")
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in pairs(explore_manager.curMapConfig.otherInfos.array) do
		local var_28_2 = var_28_0:getChildByName(iter_28_1.pos)

		if var_28_2 then
			var_28_2:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[iter_28_1.fight_girl].modelid].cute_role .. ".png", CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[iter_28_1.fight_girl].modelid].cute_role .. ".png", CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[iter_28_1.fight_girl].modelid].cute_role .. ".png")
			var_28_0:getChildByName("namebg" .. iter_28_1.pos):getChildByName("nameLabel"):setString(major_factor_data[model_data[servant_data[iter_28_1.fight_girl].modelid].major].easy_name)
		else
			local var_28_3 = ccui.Button:create(CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[iter_28_1.fight_girl].modelid].cute_role .. ".png", CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[iter_28_1.fight_girl].modelid].cute_role .. ".png", CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[iter_28_1.fight_girl].modelid].cute_role .. ".png")

			var_28_3:setName(iter_28_1.pos)
			var_28_3:setScale(0.4)
			var_28_3:setAnchorPoint(cc.p(0.5, 0))
			var_28_3:setPosition(var_0_52[iter_28_1.pos], 30)
			var_28_0:addChild(var_28_3)
			var_28_3:setTouchEnabled(true)
			var_28_3:setSwallowTouches(false)
			var_28_3:addTouchEventListener(function(arg_29_0, arg_29_1)
				if arg_29_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_29_0:convertToNodeSpace(arg_29_0:getTouchEndPosition()).y > arg_29_0:getContentSize().height - 160 then
					return
				end

				self:updateSelectedFrame(iter_28_0)
			end)

			local var_28_4 = ccui.ImageView:create("explore/name_bg.png", var_0_0)

			var_28_4:setName("namebg" .. iter_28_1.pos)
			var_28_4:setAnchorPoint(cc.p(0.5, 1))
			var_28_4:setPosition(var_0_52[iter_28_1.pos], 30)
			var_28_0:addChild(var_28_4)

			local var_28_5 = cc.Label:createWithTTF(major_factor_data[model_data[servant_data[iter_28_1.fight_girl].modelid].major].easy_name, FONT_NAME, 20)

			var_28_5:setName("nameLabel")
			var_28_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_28_5:setPosition(var_28_4:getContentSize().width / 2, var_28_4:getContentSize().height / 2)
			var_28_4:addChild(var_28_5)
		end

		var_28_1[iter_28_1.pos] = true
	end

	if var_28_0.status == "up" then
		for iter_28_2 = 1, 3 do
			if var_28_1[iter_28_2] and var_28_0:getChildByName(iter_28_2) then
				var_28_0:getChildByName(iter_28_2):setVisible(true)
			end
		end
	else
		for iter_28_3 = 1, 3 do
			if var_28_0:getChildByName(iter_28_3) then
				var_28_0:getChildByName(iter_28_3):setVisible(false)
			end
		end
	end
end

function ExploreMapLayer:updateHPUI()
	self.bloodbar:setPercentage(explore_manager.curMapConfig.otherInfos.HP / 10 * 100)
	self.bloodLabel:setString("血量(" .. explore_manager.curMapConfig.otherInfos.HP .. "/" .. 10 .. ")")
end

function ExploreMapLayer.switchMapType(arg_31_0)
	return
end

function ExploreMapLayer:showExploreProgress()
	if self.exploreProgressBg.pos_type == "up" then
		self.exploreProgressBg.pos_type = "running"

		self.exploreProgressBg:runAction(cc.Sequence:create(cc.Show:create(), cc.ScaleTo:create(0.2, 1.1), cc.ScaleTo:create(0.1, 0.9), cc.ScaleTo:create(0.1, 1), cc.CallFunc:create(function()
			self.exploreProgressBg.pos_type = "down"
		end)))
	elseif self.exploreProgressBg.pos_type == "down" then
		self.exploreProgressBg.pos_type = "running"

		self.exploreProgressBg:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.1), cc.ScaleTo:create(0.2, 0.1), cc.Hide:create(), cc.CallFunc:create(function()
			self.exploreProgressBg.pos_type = "up"
		end)))
	end
end

function ExploreMapLayer:initExploreProgress()
	self.exploreProgressBg:removeAllChildren()
	self.exploreProgressBg:setContentSize(cc.size(180, table.nums(explore_manager.curMapConfig.mapProgress) * 36 + 8))

	for iter_35_0, iter_35_1 in pairs(explore_manager.curMapConfig.mapProgress) do
		local var_35_0 = self.exploreProgressBg:getContentSize().height - 4 - 1 * 32
		local var_35_1 = cc.Label:createWithTTF(var_0_47[iter_35_0] .. ":", FONT_DES, 22)

		var_35_1:setAnchorPoint(cc.p(0, 0))
		var_35_1:setPosition(0, var_35_0)
		self.exploreProgressBg:addChild(var_35_1)

		local var_35_2 = cc.Label:createWithTTF(iter_35_1.used .. "/" .. iter_35_1.total, FONT_DES, 20)

		var_35_2:setName("num" .. iter_35_0)
		var_35_2:setHorizontalAlignment(cc.TEXT_ALIGNMENT_RIGHT)
		var_35_2:setAnchorPoint(cc.p(1, 0))
		var_35_2:setPosition(self.exploreProgressBg:getContentSize().width, var_35_0)
		self.exploreProgressBg:addChild(var_35_2)
	end

	self.exploreProgressLabel:setString(explore_manager:getMapProgress() .. "%")

	local var_35_4 = explore_manager:getMapProgress()

	self.exploreProgressBar:setPercentage(var_35_4)

	if var_35_4 >= 100 then
		self.mapUIPanel:getChildByName("boxicon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 0.85), cc.ScaleTo:create(1, 1))))
	end
end

function ExploreMapLayer:updateExploreProgress(arg_36_1)
	self.exploreProgressBg:getChildByName("num" .. arg_36_1):setString(explore_manager.curMapConfig.mapProgress[arg_36_1].used .. "/" .. explore_manager.curMapConfig.mapProgress[arg_36_1].total)
	self.exploreProgressLabel:setString(explore_manager:getMapProgress() .. "%")

	local var_36_0 = explore_manager:getMapProgress()

	self.exploreProgressBar:setPercentage(var_36_0)

	if var_36_0 >= 100 then
		self.mapUIPanel:getChildByName("boxicon"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(1, 0.85), cc.ScaleTo:create(1, 1))))
	end
end

function ExploreMapLayer:genMap()
	local var_37_0 = explore_manager.curMapConfig.otherInfos
	local var_37_1 = explore_manager.curMapConfig.mapModel
	local var_37_2 = explore_manager.curMapConfig.bgModel
	local var_37_3 = explore_manager.getCurData("map", explore_manager.curMapConfig.otherInfos.maptype)
	local var_37_4 = explore_manager.getCurData("room", explore_manager.curMapConfig.otherInfos.maptype)
	local var_37_5 = explore_manager.getCurData("roomTile", explore_manager.curMapConfig.otherInfos.maptype)
	local var_37_6 = explore_manager.getCurData("tile", explore_manager.curMapConfig.otherInfos.maptype)
	local var_37_7 = explore_manager.getCurData("level", explore_manager.curMapConfig.otherInfos.maptype)
	local var_37_8 = explore_manager.getCurData("monsterTeam", explore_manager.curMapConfig.otherInfos.maptype)
	local var_37_9 = tonumber(3)
	local var_37_10 = tonumber(3)
	local var_37_12
	local var_37_13

	if explore_manager.curMapConfig.plotClassId then
		if var_37_3[explore_manager.curMapConfig.plotMapId].plot_map_size then
			var_37_12, var_37_13 = var_37_3[explore_manager.curMapConfig.plotMapId].plot_map_size:match("([^,]+),(.+)")
			var_37_13 = tonumber(var_37_13)
			var_37_12 = tonumber(var_37_12)
		else
			var_37_13 = var_37_9 * 10 + var_37_9 - 1
			var_37_12 = var_37_10 * 10 + var_37_10 - 1
		end
	else
		var_37_13 = var_37_9 * 10 + var_37_9 - 1
		var_37_12 = var_37_10 * 10 + var_37_10 - 1

		local var_37_14 = explore_manager.curMapConfig.otherInfos.maptype
		local var_37_15 = explore_manager.curMapConfig.otherInfos.mapfloor
	end

	local var_37_16 = cc.p((explore_manager.curMapConfig.curPosIndex - 1) % var_37_12 + 1, math.floor((explore_manager.curMapConfig.curPosIndex - 1) / var_37_12) + 1)

	self.layout = ccui.Layout:create()

	self.layout:setTouchEnabled(false)

	local var_37_19 = cc.size(100 * var_37_12, 100 * (var_37_13 + 2) - 37)

	self.mapView:setInnerContainerSize(var_37_19)
	self.mapView:getInnerContainer():setScale(var_0_57)
	self.layout:setContentSize(var_37_19)
	self.mapView:addChild(self.layout, 2)

	self.batchNodeLayout = cc.SpriteBatchNode:create("tilemap/tilebg.png")

	self.batchNodeLayout:setPosition(0, 0)
	self.layout:addChild(self.batchNodeLayout)

	self.maskPanel = ccui.Layout:create()

	self.layout:addChild(self.maskPanel)

	local var_37_20
	local var_37_21

	if explore_manager.curMapConfig.plotClassId then
		var_37_21 = plot_data[PlotManager:getRunningPlotId(explore_manager.curMapConfig.plotClassId)].finish_param2
		var_37_20 = var_37_3[var_37_21].fullImage
	else
		var_37_20 = var_37_3[explore_manager.curMapConfig.otherInfos.mapfloor].fullImage
	end

	self.iconBatchNodeLayout = cc.SpriteBatchNode:create("tilemap/tiles_" .. var_37_20 .. ".png")

	self.iconBatchNodeLayout:setPosition(0, 0)
	self.layout:addChild(self.iconBatchNodeLayout)

	self.iconLayout = ccui.Layout:create()

	self.layout:addChild(self.iconLayout)
	self.layout:addChild(ccui.Layout:create(), 97)

	local var_37_22 = ccui.Layout:create()

	self.layout:addChild(var_37_22, 98)

	if var_0_51 then
		testLayout = ccui.Layout:create()

		testLayout:setName("testLayout")
		self.layout:addChild(testLayout)
	end

	self:initSelectedFrame()
	self:initTouchMark()
	self:initSmallMap(var_37_12, var_37_13)

	local function var_37_23(arg_38_0)
		if var_37_6[var_37_1[arg_38_0]].class == var_0_46.DES_WALL then
			return false
		end

		if not explore_manager.curMapConfig.usedTile[arg_38_0] then
			return true
		end

		if var_37_6[var_37_1[arg_38_0]].trigger_count > 0 and explore_manager.curMapConfig.usedTile[arg_38_0].usedcount >= var_37_6[var_37_1[arg_38_0]].trigger_count then
			return true
		else
			return false
		end
	end

	local function var_37_24(arg_39_0)
		if explore_manager.curMapConfig.rangeModel.range[arg_39_0] then
			return false
		elseif var_37_6[var_37_1[arg_39_0]].is_block == 1 then
			if var_37_6[var_37_1[arg_39_0]].is_touch == 1 then
				return var_37_23(arg_39_0)
			else
				return false
			end
		else
			return true
		end
	end

	local function var_37_25(arg_40_0, arg_40_1)
		local var_40_0 = math.floor((arg_40_0 - 1) / var_37_12) + 1
		local var_40_1

		if arg_40_1 == var_0_40 then
			var_40_1 = arg_40_0 + var_37_12

			if var_40_0 == var_37_13 then
				var_40_1 = nil
			end
		elseif arg_40_1 == var_0_41 then
			var_40_1 = arg_40_0 + 1

			if (arg_40_0 - 1) % var_37_12 + 1 == var_37_12 then
				var_40_1 = nil
			end
		elseif arg_40_1 == var_0_42 then
			var_40_1 = arg_40_0 - var_37_12

			if var_40_0 == 1 then
				var_40_1 = nil
			end
		elseif arg_40_1 == var_0_43 then
			var_40_1 = arg_40_0 - 1

			if (arg_40_0 - 1) % var_37_12 + 1 == 1 then
				var_40_1 = nil
			end
		end

		return var_40_1
	end

	local function var_37_27(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
		local var_42_0 = math.floor((arg_42_0 - 1) / var_37_12) + 1
		local var_42_1 = cc.Sprite:createWithSpriteFrameName(var_37_2[arg_42_0] .. ".png")

		var_42_1:setPosition(var_0_53 + ((arg_42_0 - 1) % var_37_12 + 1 - 1) * 100, var_0_54 + (var_42_0 - 1) * 100)

		var_42_1.index = arg_42_0

		var_42_1:setName(arg_42_0)
		self.batchNodeLayout:addChild(var_42_1)

		if (function()
			if not var_37_6[arg_42_1].icon and not var_0_49[var_37_6[arg_42_1].class] then
				return false
			end

			if var_37_6[arg_42_1].is_show_icon == 0 then
				return false
			end

			if var_37_6[arg_42_1].is_touch > 0 then
				return not var_37_23(arg_42_0)
			else
				return true
			end
		end)() then
			local var_42_2

			if var_0_49[var_37_6[arg_42_1].class] then
				local var_42_4 = var_37_6[arg_42_1]["result" .. (explore_manager.curMapConfig.usedTile[arg_42_0].result or 1) .. "_param"]

				assert(var_37_7[var_37_6[arg_42_1]["result" .. (explore_manager.curMapConfig.usedTile[arg_42_0].result or 1) .. "_param"]], var_37_6[arg_42_1]["result" .. (explore_manager.curMapConfig.usedTile[arg_42_0].result or 1) .. "_param"])
				assert(var_37_7[var_42_4].boss_team, var_42_4)
				assert(var_37_8[var_37_7[var_42_4].boss_team], var_37_7[var_42_4].boss_team)
				assert(var_37_8[var_37_7[var_42_4].boss_team].boss_icon, var_37_7[var_42_4].boss_team)
				assert(var_37_8[var_37_7[var_42_4].boss_team].boss_icon, var_37_7[var_42_4].boss_team)
				assert(model_data[var_37_8[var_37_7[var_42_4].boss_team].boss_icon], var_37_8[var_37_7[var_42_4].boss_team].boss_icon)

				var_42_2 = cc.Sprite:create("roleimage/role1/" .. (model_data[var_37_8[var_37_7[var_42_4].boss_team].boss_icon].cute_Q or model_data[var_37_8[var_37_7[var_42_4].boss_team].boss_icon].cute_role) .. ".png")

				var_42_2:setScale(160 / var_42_2:getContentSize().width)
				var_42_2:setAnchorPoint(cc.p(0.5, 0))
				var_42_2:setPosition(var_42_1:getPositionX(), var_42_1:getPositionY())
				var_42_2:setName(arg_42_0 .. "icon")

				local var_42_5 = ccui.ImageView:create("explore/shadow.png", var_0_0)
				local var_42_6 = var_37_8[var_37_7[var_42_4].boss_team].shadow_offset_x or 0

				var_42_5:setScale(var_37_8[var_37_7[var_42_4].boss_team].shadow_scale or 0.8)
				var_42_5:setPosition(var_42_1:getPositionX() + var_42_6, var_42_1:getPositionY() + 5)
				self.iconLayout:addChild(var_42_5, var_37_13 - var_42_0 + 1)
				self.iconLayout:addChild(var_42_2, var_37_13 - var_42_0 + 1)

				var_42_2.shadow = var_42_5

				if var_0_48[var_37_6[arg_42_1].class] then
					local var_42_7

					if config._DEBUG then
						var_42_7 = cc.Sprite:create(var_0_48[var_37_6[arg_42_1].class]) or cc.Sprite:createWithSpriteFrameName(var_0_48[var_37_6[arg_42_1].class])
					end

					var_42_7:setAnchorPoint(cc.p(0.5, 1))
					var_42_7:setScale(var_42_2:getContentSize().width / 160)
					var_42_7:setPosition(var_42_2:getContentSize().width / 2, var_42_2:getContentSize().height)
					var_42_2:addChild(var_42_7)
				end
			elseif var_37_6[arg_42_1].class == var_0_46.NPC then
				local var_42_8 = tonumber(var_37_6[arg_42_1].icon)
				local var_42_9 = var_0_56
				local var_42_10 = cc.size(model_data[var_42_8].modelweight, model_data[var_42_8].modelheight)

				var_42_2 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_42_8].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_42_8].spine_model .. ".atlas", (model_data[var_42_8].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_42_8].clothes_model .. ".atlas" or nil))

				var_42_2:setScale(var_42_9, var_42_9)
				var_42_2:setContentSize(var_42_10)
				var_42_2:playAni(nil, "idle", true)
				var_42_2:setPosition(var_42_1:getPositionX(), var_42_1:getPositionY())
				var_42_2:setName(arg_42_0 .. "icon")
				self.iconLayout:addChild(var_42_2, var_37_13 - var_42_0 + 1)

				if var_0_48[var_37_6[arg_42_1].class] then
					local var_42_11

					if config._DEBUG then
						var_42_11 = cc.Sprite:create(var_0_48[var_37_6[arg_42_1].class]) or cc.Sprite:createWithSpriteFrameName(var_0_48[var_37_6[arg_42_1].class])
					end

					var_42_11:setAnchorPoint(cc.p(0.5, 1))
					var_42_11:setScale(var_42_2:getContentSize().width / 160)
					var_42_11:setPosition(var_42_2:getContentSize().width / 2, var_42_2:getContentSize().height)
					var_42_2:addChild(var_42_11)
				end
			elseif var_37_6[arg_42_1].is_big_icon then
				var_42_2 = cc.Sprite:createWithSpriteFrameName(var_37_6[arg_42_1].icon .. ".png")

				var_42_2:setName(arg_42_0 .. "icon")
				var_42_2:setAnchorPoint(cc.p(0.5, 0))

				if var_37_6[arg_42_1].is_shadow then
					var_42_2:setPosition(var_42_1:getPositionX(), var_42_1:getPositionY())

					local var_42_12 = ccui.ImageView:create("explore/shadow.png", var_0_0)

					var_42_12:setScale(0.9)
					var_42_12:setPosition(var_42_1:getPositionX(), var_42_1:getPositionY() - 10)
					self.iconLayout:addChild(var_42_12, var_37_13 - var_42_0 + 1)

					var_42_2.shadow = var_42_12
				else
					var_42_2:setPosition(var_42_1:getPositionX(), var_42_1:getPositionY() - var_42_1:getContentSize().height / 2)
				end

				self.iconLayout:addChild(var_42_2, var_37_13 - var_42_0 + 1)
			else
				var_42_2 = cc.Sprite:createWithSpriteFrameName(var_37_6[arg_42_1].icon .. ".png")

				var_42_2:setPosition(var_42_1:getPositionX(), var_42_1:getPositionY())
				var_42_2:setName(arg_42_0 .. "icon")
				self.iconBatchNodeLayout:addChild(var_42_2, 1)
			end

			if var_37_6[arg_42_1].light then
				local var_42_13 = var_37_6[arg_42_1].light_offset_x or 0
				local var_42_14 = var_37_6[arg_42_1].light_offset_y or 0
				local var_42_15 = var_37_6[arg_42_1].light_scale or 1
				local var_42_16

				if var_37_6[arg_42_1].light_opacity then
					var_42_16 = var_37_6[arg_42_1].light_opacity / 100 or 1

					local var_42_17

					if config._DEBUG then
						var_42_17 = cc.Sprite:create("explore/" .. var_37_6[arg_42_1].light .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. var_37_6[arg_42_1].light .. ".png")
					end
				end

				var_42_17:setPosition(var_42_1:getPositionX() + var_42_13, var_42_1:getPositionY() + var_42_14)
				var_42_17:setScale(var_42_15)
				var_42_17:setOpacity(255 * var_42_16)
				var_42_17:setBlendFunc(GL_SRC_ALPHA, GL_ONE)

				var_42_2.light = var_42_17

				self.iconLayout:addChild(var_42_17, 99)
			end
		end
	end

	local function var_37_28(arg_44_0)
		local var_44_0

		if config._DEBUG then
			var_44_0 = cc.Sprite:create("explore/" .. arg_44_0.light .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. arg_44_0.light .. ".png")
		end

		var_44_0:setPosition(var_0_53 + (arg_44_0.light_pos.x - 1) * 100 + arg_44_0.light_offset.x, var_0_54 + (arg_44_0.light_pos.y - 1) * 100 + arg_44_0.light_offset.y)
		var_44_0:setScale(arg_44_0.light_scale)
		var_44_0:setOpacity(255 * arg_44_0.light_opacity)
		var_44_0:setBlendFunc(GL_SRC_ALPHA, GL_ONE)
		self.iconLayout:addChild(var_44_0, 99)
	end

	local function var_37_29(arg_45_0)
		if var_37_23(arg_45_0) then
			local var_45_0 = var_37_6[var_37_1[arg_45_0]].finished_tile

			if var_37_6[var_37_1[arg_45_0]].finished_tile then
				if var_37_6[var_37_1[arg_45_0]].is_big_icon ~= var_37_6[var_45_0].is_big_icon then
					local var_45_1 = var_37_6[var_37_1[arg_45_0]].is_big_icon and self.iconLayout:getChildByName(arg_45_0 .. "icon") or self.iconBatchNodeLayout:getChildByName(arg_45_0 .. "icon")

					if var_45_1 then
						if var_45_1.shadow then
							var_45_1.shadow:removeFromParent()
						end

						if var_45_1.light then
							var_45_1.light:removeFromParent()
						end

						var_45_1:removeFromParent()
					end

					if var_37_6[var_45_0].is_big_icon then
						local var_45_4 = cc.Sprite:createWithSpriteFrameName(var_37_6[var_45_0].icon .. ".png")

						var_45_4:setAnchorPoint(cc.p(0.5, 0))

						local var_45_5 = math.floor((arg_45_0 - 1) / var_37_12) + 1

						var_45_4:setPosition(var_0_53 + ((arg_45_0 - 1) % var_37_12 + 1 - 1) * 100, var_0_54 + (var_45_5 - 1) * 100)
						var_45_4:setName(arg_45_0 .. "icon")
						self.iconLayout:addChild(var_45_4, var_37_13 - var_45_5 + 1)
					else
						local var_45_6 = cc.Sprite:createWithSpriteFrameName(var_37_6[var_45_0].icon .. ".png")

						var_45_6:setPosition(var_0_53 + ((arg_45_0 - 1) % var_37_12 + 1 - 1) * 100, var_0_54 + (math.floor((arg_45_0 - 1) / var_37_12) + 1 - 1) * 100)
						var_45_6:setName(arg_45_0 .. "icon")
						self.iconBatchNodeLayout:addChild(var_45_6, 1)
					end
				else
					local var_45_7

					if var_37_6[var_45_0].is_big_icon then
						var_45_7 = self.iconLayout:getChildByName(arg_45_0 .. "icon")

						self.iconLayout:getChildByName(arg_45_0 .. "icon"):setSpriteFrame(var_37_6[var_45_0].icon .. ".png")
					else
						var_45_7 = self.iconBatchNodeLayout:getChildByName(arg_45_0 .. "icon")

						self.iconBatchNodeLayout:getChildByName(arg_45_0 .. "icon"):setSpriteFrame(var_37_6[var_45_0].icon .. ".png")
					end

					if var_45_7 then
						if var_45_7.shadow then
							var_45_7.shadow:removeFromParent()
						end

						if var_45_7.light then
							var_45_7.light:removeFromParent()
						end
					end
				end

				var_37_1[arg_45_0] = var_45_0
			else
				local var_45_8 = var_0_49[var_37_6[var_37_1[arg_45_0]].class] and self.iconLayout:getChildByName(arg_45_0 .. "icon") or var_37_6[var_37_1[arg_45_0]].is_big_icon and self.iconLayout:getChildByName(arg_45_0 .. "icon") or var_37_6[var_37_1[arg_45_0]].class == var_0_46.NPC and self.iconLayout:getChildByName(arg_45_0 .. "icon") or self.iconBatchNodeLayout:getChildByName(arg_45_0 .. "icon")

				if var_45_8 then
					if var_45_8.shadow then
						var_45_8.shadow:removeFromParent()
					end

					if var_45_8.light then
						var_45_8.light:removeFromParent()
					end

					var_45_8:removeFromParent()
				end
			end
		end
	end

	local function var_37_30(arg_47_0, arg_47_1)
		local var_47_0 = 480

		self.layout:stopActionByTag(480)

		local var_47_1 = self.tag:getPositionX()
		local var_47_2 = self.tag:getPositionY()

		local function var_47_3(arg_48_0, arg_48_1)
			if math.abs(arg_48_0 - arg_48_1) == 1 then
				return "x"
			elseif math.abs(arg_48_0 - arg_48_1) == var_37_12 then
				return "y"
			else
				print(arg_48_0, arg_48_1, arg_48_0 - arg_48_1)
			end
		end

		local var_47_4 = var_47_3(explore_manager.curMapConfig.curPosIndex, arg_47_0[1])
		local var_47_5 = 1
		local var_47_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			local var_49_0 = arg_47_0[var_47_5]
			local var_49_1 = math.floor((arg_47_0[var_47_5] - 1) / var_37_12) + 1
			local var_49_2 = var_0_53 + ((arg_47_0[var_47_5] - 1) % var_37_12 + 1 - 1) * 100
			local var_49_3 = var_0_54 + (var_49_1 - 1) * 100
			local var_49_4 = self.tag:getPositionX()
			local var_49_5 = self.tag:getPositionY()
			local var_49_6 = self.layout:getContentSize().width * var_0_57 - 640
			local var_49_7 = self.layout:getContentSize().height * var_0_57 - 1136

			if cc.rectContainsPoint(cc.rect(var_0_53 + ((arg_47_0[var_47_5] - 1) % var_37_12 + 1 - 1) * 100 - 50, var_0_54 + (var_49_1 - 1) * 100 - 50, 100, 100), cc.p(var_49_4, var_49_5)) and var_49_0 ~= explore_manager.curMapConfig.curPosIndex then
				var_37_16 = cc.p((arg_47_0[var_47_5] - 1) % var_37_12 + 1, var_49_1)
				explore_manager.curMapConfig.curPosIndex = var_49_0
			end

			if var_47_4 and var_47_4 == "x" or not var_47_4 then
				if var_47_5 == #arg_47_0 then
					if var_49_4 == var_49_2 and var_49_5 == var_49_3 then
						if var_47_5 == #arg_47_0 then
							if arg_47_1 then
								arg_47_1()
							end

							self.layout:stopActionByTag(var_47_0)
							self:playAni("idle")

							return
						end

						var_47_5 = var_47_5 + 1
						var_47_4 = var_47_3(explore_manager.curMapConfig.curPosIndex, arg_47_0[var_47_5])
					elseif var_49_4 ~= var_49_2 then
						local var_49_8 = math.abs(var_49_2 - var_49_4) < 0.016666666666666666 * var_47_0 and math.abs(var_49_2 - var_49_4) or 0.016666666666666666 * var_47_0
						local var_49_9 = (var_49_2 - var_49_4) / math.abs(var_49_2 - var_49_4)

						var_49_4 = var_49_4 + var_49_9 * var_49_8

						if var_49_9 ~= self.tag.dir then
							self.tag:setScale(var_49_9 * var_0_56, var_0_56)
						end
					elseif var_49_5 ~= var_49_3 then
						var_49_5 = var_49_5 + (var_49_3 - var_49_5) / math.abs(var_49_3 - var_49_5) * (math.abs(var_49_3 - var_49_5) < 0.016666666666666666 * var_47_0 and math.abs(var_49_3 - var_49_5) or 0.016666666666666666 * var_47_0)
					end
				elseif var_49_4 == var_49_2 and explore_manager.curMapConfig.curPosIndex == var_49_0 then
					if var_47_5 == #arg_47_0 then
						if arg_47_1 then
							arg_47_1()
						end

						self.layout:stopActionByTag(var_47_0)
						self:playAni("idle")

						return
					end

					var_47_5 = var_47_5 + 1
					var_47_4 = var_47_3(explore_manager.curMapConfig.curPosIndex, arg_47_0[var_47_5])
				elseif var_49_4 ~= var_49_2 then
					local var_49_11 = math.abs(var_49_2 - var_49_4) < 0.016666666666666666 * var_47_0 and math.abs(var_49_2 - var_49_4) or 0.016666666666666666 * var_47_0
					local var_49_12 = (var_49_2 - var_49_4) / math.abs(var_49_2 - var_49_4)

					var_49_4 = var_49_4 + var_49_12 * var_49_11

					if var_49_12 ~= self.tag.dir then
						self.tag:setScale(var_49_12 * var_0_56, var_0_56)
					end
				elseif var_49_5 ~= var_49_3 then
					var_49_5 = var_49_5 + (var_49_3 - var_49_5) / math.abs(var_49_3 - var_49_5) * (math.abs(var_49_3 - var_49_5) < 0.016666666666666666 * var_47_0 and math.abs(var_49_3 - var_49_5) or 0.016666666666666666 * var_47_0)
				end
			elseif var_47_4 and var_47_4 == "y" then
				if var_47_5 == #arg_47_0 then
					if var_49_4 == var_49_2 and var_49_5 == var_49_3 then
						if var_47_5 == #arg_47_0 then
							if arg_47_1 then
								arg_47_1()
							end

							self.layout:stopActionByTag(var_47_0)
							self:playAni("idle")

							return
						end

						var_47_5 = var_47_5 + 1
						var_47_4 = var_47_3(explore_manager.curMapConfig.curPosIndex, arg_47_0[var_47_5])
					elseif var_49_5 ~= var_49_3 then
						var_49_5 = var_49_5 + (var_49_3 - var_49_5) / math.abs(var_49_3 - var_49_5) * (math.abs(var_49_3 - var_49_5) < 0.016666666666666666 * var_47_0 and math.abs(var_49_3 - var_49_5) or 0.016666666666666666 * var_47_0)
					elseif var_49_4 ~= var_49_2 then
						local var_49_15 = math.abs(var_49_2 - var_49_4) < 0.016666666666666666 * var_47_0 and math.abs(var_49_2 - var_49_4) or 0.016666666666666666 * var_47_0
						local var_49_16 = (var_49_2 - var_49_4) / math.abs(var_49_2 - var_49_4)

						var_49_4 = var_49_4 + var_49_16 * var_49_15

						if var_49_16 ~= self.tag.dir then
							self.tag:setScale(var_49_16 * var_0_56, var_0_56)
						end
					end
				elseif var_49_5 == var_49_3 and explore_manager.curMapConfig.curPosIndex == var_49_0 then
					if var_47_5 == #arg_47_0 then
						if arg_47_1 then
							arg_47_1()
						end

						self.layout:stopActionByTag(var_47_0)
						self:playAni("idle")

						return
					end

					var_47_5 = var_47_5 + 1
					var_47_4 = var_47_3(explore_manager.curMapConfig.curPosIndex, arg_47_0[var_47_5])
				elseif var_49_5 ~= var_49_3 then
					var_49_5 = var_49_5 + (var_49_3 - var_49_5) / math.abs(var_49_3 - var_49_5) * (math.abs(var_49_3 - var_49_5) < 0.016666666666666666 * var_47_0 and math.abs(var_49_3 - var_49_5) or 0.016666666666666666 * var_47_0)
				elseif var_49_4 ~= var_49_2 then
					local var_49_18 = math.abs(var_49_2 - var_49_4) < 0.016666666666666666 * var_47_0 and math.abs(var_49_2 - var_49_4) or 0.016666666666666666 * var_47_0
					local var_49_19 = (var_49_2 - var_49_4) / math.abs(var_49_2 - var_49_4)

					var_49_4 = var_49_4 + var_49_19 * var_49_18

					if var_49_19 ~= self.tag.dir then
						self.tag:setScale(var_49_19 * var_0_56, var_0_56)
					end
				end
			end

			self.tag:setPosition(var_49_4, var_49_5)
			self.tag:setLocalZOrder(var_37_13 - var_49_1 + 1)
			self.smallMapTag:setPosition((var_49_4 - var_0_53 + 50) / (var_37_12 * 100) * self.smallMap.width, (var_49_5 - var_0_54 + 50) / (var_37_13 * 100) * self.smallMap.height)
			self.smallMapBox:setBoxPos((var_49_4 - var_0_53 + 50) / (var_37_12 * 100) * self.smallMap.width, (var_49_5 - var_0_54 + 50) / (var_37_13 * 100) * self.smallMap.height)

			local var_49_20 = var_49_4 * var_0_57 - 320
			local var_49_21 = var_49_5 * var_0_57 - 568

			if var_49_6 < var_49_4 * var_0_57 - 320 then
				var_49_20 = var_49_6
			elseif var_49_20 < 0 then
				var_49_20 = 0
			end

			if var_49_7 < var_49_21 then
				var_49_21 = var_49_7
			elseif var_49_21 < 0 then
				var_49_21 = 0
			end

			self.mapView:getInnerContainer():setPosition(-var_49_20, -var_49_21)
		end)))

		var_47_6:setTag(480)
		self.layout:runAction(var_47_6)
		self:playAni("run")
	end

	;(function()
		for iter_46_0, iter_46_1 in pairs(explore_manager.curMapConfig.mapModel) do
			var_37_27(iter_46_0, iter_46_1, var_37_0.maptype, var_37_0.mapfloor)
		end

		for iter_46_2, iter_46_3 in pairs(explore_manager.curMapConfig.rangeModel.range) do
			for iter_46_4, iter_46_5 in pairs(iter_46_3) do
				if not self.maskPanel:getChildByName("maskPanel" .. iter_46_5) then
					local var_46_0 = ccui.Layout:create()

					var_46_0:setClippingEnabled(false)
					var_46_0:setName("maskPanel" .. iter_46_5)
					self.maskPanel:addChild(var_46_0, 1)
				end

				local var_46_1, var_46_2 = self.batchNodeLayout:getChildByName(iter_46_2):getPosition()
				local var_46_3 = ccui.ImageView:create("explore/red_mask.png", var_0_0)

				var_46_3:setPosition(var_46_1, var_46_2)
				self.maskPanel:getChildByName("maskPanel" .. iter_46_5):addChild(var_46_3)
			end
		end

		if explore_manager.curMapConfig.roomsLight then
			for iter_46_6, iter_46_7 in pairs(explore_manager.curMapConfig.roomsLight) do
				var_37_28(iter_46_7)
			end
		end
	end)()
	;(function()
		self:scrollToPoint(var_37_16.x, var_37_16.y)
		self:addSelectedFrame(var_37_16.x, var_37_16.y, var_37_12, var_37_13)
	end)()
	;(function()
		local var_59_0 = {}

		local function var_59_1(arg_60_0)
			if self.layout:getChildByName("testLayout") then
				self.layout:getChildByName("testLayout"):removeAllChildren()
			end

			local var_60_0 = explore_manager.curMapConfig.curPosIndex
			local var_60_1 = cc.p((explore_manager.curMapConfig.curPosIndex - 1) % var_37_12 + 1, math.floor((explore_manager.curMapConfig.curPosIndex - 1) / var_37_12) + 1)
			local var_60_2 = cc.p((arg_60_0 - 1) % var_37_12 + 1, math.floor((arg_60_0 - 1) / var_37_12) + 1)
			local var_60_3 = {
				{
					index = explore_manager.curMapConfig.curPosIndex
				}
			}
			local var_60_4 = {
				[explore_manager.curMapConfig.curPosIndex] = 1
			}
			local var_60_5 = {}
			local var_60_6 = {
				[explore_manager.curMapConfig.curPosIndex] = -1
			}

			local function var_60_7(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
				if not var_0_51 then
					return
				end

				local var_61_0 = self.layout:getChildByName("testLayout")

				if not var_61_0 then
					var_61_0 = ccui.Layout:create()

					var_61_0:setName("testLayout")
					self.layout:addChild(var_61_0)
				end

				self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_61_3), cc.CallFunc:create(function()
					local var_62_0 = ccui.ImageView:create("public/box/UI_smeltScene_equipOn.png", var_0_0)

					var_62_0:setName("test" .. arg_61_0)
					var_62_0:setPosition(var_0_53 + ((arg_61_0 - 1) % var_37_12 + 1 - 1) * 100, var_0_54 + (math.floor((arg_61_0 - 1) / var_37_12) + 1 - 1) * 100)
					var_61_0:addChild(var_62_0, 1)

					local var_62_1 = cc.Label:createWithTTF("G: " .. arg_61_1, FONT_NAME, 20)

					var_62_1:setName("G_label")
					var_62_1:setColor(cc.c3b(0, 0, 0))
					var_62_1:setAnchorPoint(cc.p(0, 0.5))
					var_62_1:setPosition(0, 30)
					var_62_0:addChild(var_62_1)

					local var_62_2 = cc.Label:createWithTTF("H: " .. arg_61_2, FONT_NAME, 20)

					var_62_2:setName("H_label")
					var_62_2:setColor(cc.c3b(0, 0, 0))
					var_62_2:setAnchorPoint(cc.p(0, 0.5))
					var_62_2:setPosition(0, 60)
					var_62_0:addChild(var_62_2)

					local var_62_3 = cc.Label:createWithTTF("F: " .. arg_61_2 + arg_61_1, FONT_NAME, 20)

					var_62_3:setName("F_label")
					var_62_3:setColor(cc.c3b(0, 0, 0))
					var_62_3:setAnchorPoint(cc.p(0, 0.5))
					var_62_3:setPosition(0, 90)
					var_62_0:addChild(var_62_3)
				end)))
			end

			local function var_60_8(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
				if not var_0_51 then
					return
				end

				if not self.layout:getChildByName("testLayout") then
					return
				end

				self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_63_3), cc.CallFunc:create(function()
					local var_64_0 = self.layout:getChildByName("testLayout"):getChildByName("test" .. arg_63_0)

					var_64_0:getChildByName("G_label"):setString("G:" .. arg_63_1)
					var_64_0:getChildByName("H_label"):setString("H:" .. arg_63_2)
					var_64_0:getChildByName("F_label"):setString("F:" .. arg_63_2 + arg_63_1)
				end)))
			end

			local function var_60_9(arg_65_0, arg_65_1)
				if not var_0_51 then
					return
				end

				self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_65_1), cc.CallFunc:create(function()
					if not self.layout:getChildByName("testLayout") then
						return
					end

					if not self.layout:getChildByName("testLayout"):getChildByName("test" .. arg_65_0) then
						return
					end

					self.layout:getChildByName("testLayout"):getChildByName("test" .. arg_65_0):setColor(cc.c3b(100, 0, 0))
				end)))
			end

			local function var_60_10(arg_67_0)
				if not var_60_6[arg_67_0] then
					return
				end

				local var_67_0 = 1
				local var_67_1 = arg_67_0

				while var_60_6[arg_67_0] > 0 do
					var_67_0 = var_67_0 + 1
					var_67_1 = var_60_6[arg_67_0]
				end

				return var_67_0
			end

			local function var_60_11(arg_68_0)
				local var_68_0 = math.floor((arg_68_0 - 1) / var_37_12) + 1
				local var_68_1 = math.sqrt(math.abs((arg_68_0 - 1) % var_37_12 + 1 - var_60_2.x) * math.abs((arg_68_0 - 1) % var_37_12 + 1 - var_60_2.x) + math.abs(var_68_0 - var_60_2.y) * math.abs(var_68_0 - var_60_2.y))

				return (math.abs((arg_68_0 - 1) % var_37_12 + 1 - var_60_2.x) + math.abs(var_68_0 - var_60_2.y)) * 1.01
			end

			local function var_60_12()
				var_60_4 = {}

				for iter_69_0, iter_69_1 in pairs(var_60_3) do
					var_60_4[iter_69_1.index] = iter_69_0
				end
			end

			local function var_60_13(arg_70_0, arg_70_1)
				var_60_3[arg_70_0], var_60_3[arg_70_1] = var_60_3[arg_70_1], var_60_3[arg_70_0]
			end

			local function var_60_14()
				local var_71_0 = 0

				while 1 * 2 <= #var_60_3 and not false do
					var_71_0 = var_60_3[1].F_value > var_60_3[1 * 2].F_value and 1 * 2 or 1

					if 1 * 2 + 1 <= #var_60_3 and var_60_3[var_71_0].F_value > var_60_3[1 * 2 + 1].F_value then
						var_71_0 = 1 * 2 + 1
					end

					local var_71_1, var_71_2

					if var_71_0 ~= 1 then
						var_60_13(var_71_0, 1)

						var_71_1 = var_71_0
					else
						var_71_2 = true
					end
				end
			end

			local function var_60_15()
				if #var_60_3 == 1 then
					return
				end

				local var_72_0 = #var_60_3

				::label_72_0::

				while var_72_0 ~= 1 and not false do
					if var_72_0 % 2 == 0 then
						local var_72_1 = var_72_0 / 2 or (var_72_0 - 1) / 2

						if var_60_3[var_72_0].F_value < var_60_3[var_72_1].F_value then
							var_60_13(var_72_0, var_72_1)

							var_72_0 = var_72_1

							goto label_72_0
						end
					end
				end
			end

			local function var_60_16(arg_73_0, arg_73_1, arg_73_2)
				var_60_3[#var_60_3 + 1] = {
					index = arg_73_0,
					G_value = arg_73_1,
					H_value = arg_73_2,
					F_value = arg_73_1 + arg_73_2
				}

				var_60_15()
				var_60_12()
			end

			local function var_60_17()
				var_60_3[1] = var_60_3[#var_60_3]
				var_60_3[#var_60_3] = nil

				var_60_14()
				var_60_12()
			end

			if var_37_6[var_37_1[arg_60_0]].trigger_range == 1 and not var_37_23(arg_60_0) then
				local var_60_18 = {}
				local var_60_19 = false
				local var_60_20 = 0
				local var_60_21 = {}

				for iter_60_0, iter_60_1 in pairs(explore_manager.curMapConfig.rangeModel.center[arg_60_0]) do
					var_60_21[iter_60_1] = true
				end

				while next(var_60_3) ~= nil do
					var_60_9(var_60_3[1].index, var_60_20 * 0.01)
					var_60_17()

					var_60_5[var_60_3[1].index] = 1

					for iter_60_2 = 1, 4 do
						local var_60_22 = var_37_25(var_60_3[1].index, iter_60_2)

						if var_60_22 then
							if not var_60_21[var_60_22] then
								if var_37_24(var_60_22) and not var_60_5[var_60_22] then
									if var_60_4[var_60_22] then
										indexInfo = var_60_3[var_60_4[var_60_22]]

										local var_60_23 = var_60_10(var_60_3[1].index) + 1

										if var_60_23 < indexInfo.G_value then
											indexInfo.G_value = var_60_23
											indexInfo.F_value = var_60_23 + var_60_11(var_60_22)
											var_60_6[var_60_22] = var_60_3[1].index

											var_60_8(var_60_22, var_60_10(var_60_3[1].index) + 1, var_60_11(var_60_22), var_60_20 * 0.01)
										end
									else
										var_60_7(var_60_22, var_60_10(var_60_3[1].index) + 1, var_60_11(var_60_22), var_60_20 * 0.01)

										var_60_20 = var_60_20 + 1

										var_60_16(var_60_22, var_60_10(var_60_3[1].index) + 1, var_60_11(var_60_22))

										var_60_6[var_60_22] = var_60_3[1].index
									end
								end
							else
								var_60_19 = true
								var_60_18 = {
									var_60_22
								}
								var_60_6[var_60_22] = var_60_3[1].index

								local var_60_24 = var_60_22

								while var_60_6[var_60_24] ~= var_60_0 do
									table.insert(var_60_18, 1, var_60_6[var_60_24])

									var_60_24 = var_60_6[var_60_24]
								end

								break
							end
						end
					end

					if var_60_19 then
						return var_60_18
					end
				end

				if var_60_19 == false then
					return
				end
			else
				local var_60_25 = {
					arg_60_0
				}
				local var_60_26 = false
				local var_60_27 = 0

				while next(var_60_3) ~= nil do
					var_60_9(var_60_3[1].index, var_60_27 * 0.01)
					var_60_17()

					var_60_5[var_60_3[1].index] = 1

					for iter_60_3 = 1, 4 do
						local var_60_28 = var_37_25(var_60_3[1].index, iter_60_3)

						if var_60_28 then
							if var_60_28 ~= arg_60_0 then
								if var_37_24(var_60_28) and not var_60_5[var_60_28] then
									if var_60_4[var_60_28] then
										indexInfo = var_60_3[var_60_4[var_60_28]]

										local var_60_29 = var_60_10(var_60_3[1].index) + 1

										if var_60_29 < indexInfo.G_value then
											indexInfo.G_value = var_60_29
											indexInfo.F_value = var_60_29 + var_60_11(var_60_28)
											var_60_6[var_60_28] = var_60_3[1].index

											var_60_8(var_60_28, var_60_10(var_60_3[1].index) + 1, var_60_11(var_60_28), var_60_27 * 0.01)
										end
									else
										var_60_7(var_60_28, var_60_10(var_60_3[1].index) + 1, var_60_11(var_60_28), var_60_27 * 0.01)

										var_60_27 = var_60_27 + 1

										var_60_16(var_60_28, var_60_10(var_60_3[1].index) + 1, var_60_11(var_60_28))

										var_60_6[var_60_28] = var_60_3[1].index
									end
								end
							else
								var_60_26 = true
								var_60_6[var_60_28] = var_60_3[1].index

								local var_60_30 = arg_60_0

								while var_60_6[var_60_30] ~= var_60_0 do
									table.insert(var_60_25, 1, var_60_6[var_60_30])

									var_60_30 = var_60_6[var_60_30]
								end

								break
							end
						end
					end

					if var_60_26 then
						return var_60_25
					end
				end

				if var_60_26 == false then
					return
				end
			end
		end

		local function var_59_2(arg_75_0)
			if self.touchLock then
				return
			end

			self.touchLock = true

			local var_75_0 = var_37_6[var_37_1[arg_75_0]]

			local function var_75_1(arg_77_0, arg_77_1, arg_77_2)
				if var_75_0.class == 5 then
					if arg_77_2 then
						arg_77_2()
					end

					return
				end

				local var_77_0 = {
					labels = {
						title = "探险信息",
						des = arg_77_0
					},
					surecallback = arg_77_2,
					cancelcallback = arg_77_2
				}

				if arg_77_1 == var_0_50.DEAD then
					var_77_0.labels = {
						des = "死球啦!从来吧!",
						title = "探险信息"
					}
				end

				self:addChild(PopLayer:Do(var_77_0), 999)
			end

			local function var_75_2(arg_78_0, arg_78_1)
				local function var_78_0()
					if var_75_0.class == var_0_46.DES_WALL then
						self.touchLock = false

						return
					end

					local var_79_0
					local var_79_1
					local var_79_2

					if arg_78_0 then
						var_79_0 = arg_78_0.type
						var_79_1 = arg_78_0.param
						var_79_2 = arg_78_0.des
					end

					if var_79_0 == var_0_50.FIGHT then
						local var_79_3 = var_37_0.maptype

						explore_manager:beginExploreFight(var_79_1)
						explore_manager:setFightFinishCallback(function(arg_80_0, arg_80_1)
							explore_manager:trigger_event(var_37_0.maptype, arg_75_0, var_37_1[arg_75_0], var_79_0, var_79_1, arg_80_1, function(arg_81_0)
								if arg_81_0.result >= 0 then
									if arg_81_0.result == var_0_50.FIGHT then
										self:updateHPUI()
										var_37_29(arg_75_0)
										self:updateRangeModel(arg_75_0)
									elseif arg_81_0.result == 0 then
										self:resetCurMap(var_37_14, var_37_15, var_37_21)
									end

									local var_81_0

									if arg_81_0.items and next(arg_81_0.items) ~= nil then
										local var_81_1 = {}

										for iter_81_0, iter_81_1 in pairs(arg_81_0.items) do
											table.insert(var_81_1, {
												dropid = iter_81_1.itemid,
												entityid = iter_81_1.entityid,
												dropNum = iter_81_1.itemcount
											})
										end

										local function var_81_2()
											self:popTalkSp(self.tag.modelid, arg_81_0.result, var_37_6[var_37_1[arg_75_0]].class)
										end

										local var_81_3 = {
											items = var_81_1,
											gold = arg_81_0.gold,
											diamond = arg_81_0.diamond,
											surecallback = var_81_2,
											cancelcallback = var_81_2
										}

										function var_81_0()
											LayerManager:pushInLayer("PopPurchaseResultLayer", var_81_3)
										end
									end

									if var_79_2 then
										var_75_1(var_79_2, arg_81_0.result, var_81_0)
									elseif var_81_0 then
										var_81_0()
									else
										self:popTalkSp(self.tag.modelid, arg_81_0.result, var_37_6[var_37_1[arg_75_0]].class)
									end
								elseif arg_81_0.result == -5 then
									self:removeMap(var_79_3)
									self:resetCurMap(var_37_14, var_37_15, var_37_21)
								end

								if arg_80_0 then
									arg_80_0()
								end

								self.touchLock = false
							end)
						end)
					else
						local var_79_4 = var_37_0.maplevel or 0
						local var_79_5 = var_37_0.maptype

						explore_manager:trigger_event(var_37_0.maptype, arg_75_0, var_37_1[arg_75_0], var_79_0, var_79_1, arg_78_1, function(arg_84_0)
							if arg_84_0.result >= 0 then
								if arg_84_0.result == var_0_50.ADD_HP then
									self:updateHPUI()
									var_37_29(arg_75_0)
								elseif arg_84_0.result == var_0_50.SUB_HP then
									self:updateHPUI()
									var_37_29(arg_75_0)
									self:playAni("hit", function()
										self:playAni("idle")
									end)
								elseif arg_84_0.result == var_0_50.GET_ITEM then
									var_37_29(arg_75_0)
								elseif arg_84_0.result == var_0_50.GET_DROP then
									self:updateHPUI()
									var_37_29(arg_75_0)
								elseif arg_84_0.result == var_0_50.NEXT_FLOOR then
									if not explore_manager.curMapConfig then
										self:updateMapCover(var_37_14)
										self:resetCurMap(var_37_14, var_37_15, var_37_21)

										if var_79_4 ~= arg_84_0.config.maplevel then
											self.isPopExploreDifficult:getChildByName("scrollView").difficult = nil

											self.isPopExploreDifficult:switchDifficult(arg_84_0.config.maplevel <= 6 and 1 or arg_84_0.config.maplevel <= 12 and 2 or 3)
										end
									else
										self:goToNextFloor()
									end
								elseif arg_84_0.result == var_0_50.SHOP_BUFF then
									self:updateBuffUI()
									var_37_29(arg_75_0)
								elseif arg_84_0.result == 0 then
									self:resetCurMap(var_37_14, var_37_15, var_37_21)
								elseif arg_84_0.result == var_0_50.NOTHING then
									var_37_29(arg_75_0)
								elseif arg_84_0.result == var_0_50.SHOP_ITEM then
									var_37_29(arg_75_0)
								end

								local var_84_1

								if arg_84_0.items and next(arg_84_0.items) ~= nil or arg_84_0.gold or arg_84_0.diamond then
									arg_84_0.items = arg_84_0.items or {}

									local var_84_2 = {}

									for iter_84_0, iter_84_1 in pairs(arg_84_0.items) do
										table.insert(var_84_2, {
											dropid = iter_84_1.itemid,
											entityid = iter_84_1.entityid,
											dropNum = iter_84_1.itemcount
										})
									end

									local function var_84_3()
										self:popTalkSp(self.tag.modelid, arg_84_0.result, var_37_6[var_37_1[arg_75_0]].class)
									end

									local var_84_4 = {
										items = var_84_2,
										gold = arg_84_0.gold,
										diamond = arg_84_0.diamond,
										surecallback = var_84_3,
										cancelcallback = var_84_3
									}

									function var_84_1()
										LayerManager:pushInLayer("PopPurchaseResultLayer", var_84_4)
									end
								end

								if var_79_2 then
									var_75_1(var_79_2, arg_84_0.result, var_84_1)
								elseif var_84_1 then
									var_84_1()
								else
									self:popTalkSp(self.tag.modelid, arg_84_0.result, var_37_6[var_37_1[arg_75_0]].class)
								end

								if var_75_0.result_talk then
									global_basic_scene:addChild(TalkLayer:create(var_75_0.result_talk, nil, TALK_TYPE_NORMAL, "", nil), ZORDER_TALKLAYER)
								end
							elseif arg_84_0.result == -5 then
								self:removeMap(var_79_5)
								self:resetCurMap(var_37_14, var_37_15, var_37_21)
							end

							self.touchLock = false
						end)
					end
				end

				if var_75_0.trigger_talk then
					global_basic_scene:addChild(TalkLayer:create(var_75_0.trigger_talk, nil, TALK_TYPE_NORMAL, "", function()
						var_78_0()
					end), ZORDER_TALKLAYER)
				else
					var_78_0()
				end
			end

			local var_75_3 = (function()
				if not var_75_0.result1_type then
					return {}
				end

				local var_76_0 = not var_75_0.result2_type and 1 or explore_manager.curMapConfig.usedTile[arg_75_0].result and explore_manager.curMapConfig.usedTile[arg_75_0].result or 1

				return {
					type = var_75_0["result" .. var_76_0 .. "_type"],
					param = var_75_0["result" .. var_76_0 .. "_param"],
					des = var_75_0["result" .. var_76_0 .. "_des"]
				}
			end)()

			if var_37_6[var_37_1[arg_75_0]].class == 5 then
				local function var_75_4()
					var_75_2(var_75_3)
				end

				self:addChild(PopLayer:Do({
					labels = {
						title = "探险信息",
						des = var_75_3.des
					},
					surecallback = var_75_4,
					cancelcallback = var_75_4
				}), 999)
			elseif var_75_3.type == var_0_50.FIGHT then
				local var_75_6 = self.iconLayout:getChildByName(arg_75_0 .. "icon")
				local var_75_7 = 160 / var_75_6:getContentSize().width

				var_75_6:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, var_75_7 * 1.2), cc.ScaleTo:create(0.05, var_75_7 * 0.9), cc.ScaleTo:create(0.05, var_75_7 * 1), cc.CallFunc:create(function()
					if LayerManager:getActiveLayerName() == "ExploreMapLayer" then
						print("ChapterDetailsLayer is Deprecated!!!!!")
					end
				end)))

				local var_75_8 = ccui.ImageView:create("explore/tanhao.png", var_0_0)

				var_75_8:setAnchorPoint(cc.p(0.5, 0))
				var_75_8:setPosition(var_75_6:getContentSize().width / 2 + 20, var_75_6:getContentSize().height / 2)
				var_75_6:addChild(var_75_8, 9)
				var_75_8:setScale(0.1)
				var_75_8:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.5 / var_75_7), cc.ScaleTo:create(0.05, 0.9 / var_75_7), cc.ScaleTo:create(0.05, 1 / var_75_7), cc.RemoveSelf:create()))
			elseif var_75_3.type == var_0_50.SHOP_BUFF then
				self:buffShopPopLayer(explore_sellbuff_data[tonumber(var_37_6[var_37_1[arg_75_0]].result1_param)]["buffclass" .. explore_manager.curMapConfig.usedTile[arg_75_0].result], function(arg_93_0)
					var_75_2(var_75_3, arg_93_0)
				end, function()
					self.touchLock = false
				end)
			elseif var_75_3.type == var_0_50.SHOP_ITEM then
				self:itemShopPopLayer(explore_sellweapon_data[tonumber(var_37_6[var_37_1[arg_75_0]].result1_param)]["weaponclass" .. explore_manager.curMapConfig.usedTile[arg_75_0].result], function(arg_95_0)
					var_75_2(var_75_3, arg_95_0)
				end, function()
					self.touchLock = false
				end)
			elseif var_75_3.type == var_0_50.NEXT_FLOOR then
				if var_37_6[var_37_1[arg_75_0]].trigger_type == 1 then
					self:needKeyPopLayer({
						needid = var_37_6[var_37_1[arg_75_0]].trigger_param1,
						neednum = var_37_6[var_37_1[arg_75_0]].trigger_param2,
						ownnum = item_manager:getItemNumber(var_37_6[var_37_1[arg_75_0]].trigger_param1),
						des = var_37_6[var_37_1[arg_75_0]].trigger_des,
						surecallback = function()
							if var_75_0.trigger_param2 <= item_manager:getItemNumber(var_75_0.trigger_param1) then
								local var_97_0 = explore_manager.curMapConfig.plotMapId and var_37_3[explore_manager.curMapConfig.plotMapId].out_map_talk or var_37_3[explore_manager.curMapConfig.otherInfos.mapfloor].out_map_talk

								if var_97_0 then
									global_basic_scene:addChild(TalkLayer:create(var_97_0, nil, TALK_TYPE_NORMAL, var_75_2(var_75_3)), 999)
								else
									var_75_2(var_75_3)
								end
							else
								var_75_2(var_75_3)
							end
						end,
						cancelcallback = function()
							self.touchLock = false
						end
					})
				else
					self:addChild(PopLayer:Do({
						other_bnt = "public/button/public_button_normal.png",
						labels = {
							title = "探险信息",
							des = var_37_6[var_37_1[arg_75_0]].trigger_des
						},
						system_figure = self:randomRole(),
						surecallback = function()
							local var_99_0 = explore_manager.curMapConfig.plotMapId and var_37_3[explore_manager.curMapConfig.plotMapId].out_map_talk or var_37_3[explore_manager.curMapConfig.otherInfos.mapfloor].out_map_talk

							if var_99_0 then
								global_basic_scene:addChild(TalkLayer:create(var_99_0, nil, TALK_TYPE_NORMAL, var_75_2(var_75_3)), 999)
							else
								var_75_2(var_75_3)
							end
						end,
						cancelcallback = function()
							self.touchLock = false
						end
					}), 999)
				end
			elseif var_37_6[var_37_1[arg_75_0]].trigger_type > 0 then
				if var_37_6[var_37_1[arg_75_0]].trigger_type == 1 then
					self:needKeyPopLayer({
						needid = var_37_6[var_37_1[arg_75_0]].trigger_param1,
						neednum = var_37_6[var_37_1[arg_75_0]].trigger_param2,
						ownnum = item_manager:getItemNumber(var_37_6[var_37_1[arg_75_0]].trigger_param1),
						des = var_37_6[var_37_1[arg_75_0]].trigger_des,
						surecallback = function()
							var_75_2(var_75_3)
						end,
						cancelcallback = function()
							self.touchLock = false
						end
					})
				elseif var_37_6[var_37_1[arg_75_0]].trigger_type == 2 then
					self:addChild(PopLayer:Do({
						labels = {
							title = "探险信息",
							des = var_37_6[var_37_1[arg_75_0]].trigger_des
						},
						system_figure = self:randomRole(),
						surecallback = function()
							var_75_2(var_75_3)
						end,
						cancelcallback = function()
							self.touchLock = false
						end
					}), 999)
				elseif var_37_6[var_37_1[arg_75_0]].trigger_type == 3 then
					if explore_manager.curMapConfig.usedTile[arg_75_0].usedcount == 0 then
						if var_37_6[var_37_1[arg_75_0]].trigger_param1 then
							global_basic_scene:addChild(TalkLayer:create(var_37_6[var_37_1[arg_75_0]].trigger_param1, nil, TALK_TYPE_NORMAL))
						end

						var_75_2(var_75_3)
					end

					if var_37_6[var_37_1[arg_75_0]].trigger_param2 then
						self:npcPopLayer({
							tileInfo = var_37_6[var_37_1[arg_75_0]],
							surecallback = function()
								var_75_2(var_75_3)
							end,
							cancelcallback = function()
								self.touchLock = false
							end
						})
					end
				end
			elseif var_37_6[var_37_1[arg_75_0]].trigger_des then
				self:addChild(PopLayer:Do({
					labels = {
						title = "探险信息",
						des = var_37_6[var_37_1[arg_75_0]].trigger_des
					},
					system_figure = self:randomRole(),
					surecallback = function()
						var_75_2(var_75_3)
					end,
					cancelcallback = function()
						self.touchLock = false
					end
				}), 999)
			else
				var_75_2(var_75_3)
			end
		end

		local function var_59_3(arg_109_0)
			if arg_109_0.x < var_0_53 - 50 or arg_109_0.x > var_0_53 - 50 + var_37_12 * 100 or arg_109_0.y < var_0_54 - 50 or arg_109_0.y > var_0_54 - 50 + var_37_13 * 100 then
				return
			end

			return (math.floor((arg_109_0.y - var_0_54 + 50) / 100) + 1 - 1) * var_37_12 + (math.floor((arg_109_0.x - var_0_53 + 50) / 100) + 1)
		end

		local function var_59_4(arg_110_0, arg_110_1)
			local var_110_0 = var_37_6[var_37_1[arg_110_0]]

			if not arg_110_1 then
				global_ShowBlockWords("无法到达~")

				return
			end

			local var_110_5, var_110_6, var_110_7 = (function(arg_111_0)
				local var_111_0
				local var_111_1

				if explore_manager.curMapConfig.rangeModel.range[arg_111_0[#arg_111_0]] then
					var_111_1 = var_110_0.trigger_range and not var_37_23(arg_110_0) and arg_110_0 or explore_manager.curMapConfig.rangeModel.range[arg_111_0[#arg_111_0]][1]

					table.remove(arg_111_0, #arg_111_0)
				elseif var_37_6[var_37_1[arg_111_0[#arg_111_0]]].is_block == 1 and var_37_6[var_37_1[arg_111_0[#arg_111_0]]].is_touch == 1 and not var_37_23(arg_111_0[#arg_111_0]) then
					var_111_1 = arg_111_0[#arg_111_0]

					table.remove(arg_111_0, #arg_111_0)
				else
					var_111_0 = arg_111_0[#arg_111_0]
				end

				for iter_111_0, iter_111_1 in ipairs(arg_111_0) do
					if iter_111_0 == #arg_111_0 then
						var_111_0 = iter_111_1

						if arg_110_0 == iter_111_1 and var_37_6[var_37_1[iter_111_1]].is_touch > 0 and not var_37_23(iter_111_1) then
							var_111_1 = iter_111_1
						end
					end

					if var_37_6[var_37_1[iter_111_1]].is_touch == 2 and not var_37_23(iter_111_1) then
						var_111_1 = iter_111_1
						var_111_0 = iter_111_1

						break
					end
				end

				local var_111_2 = {}

				for iter_111_2, iter_111_3 in ipairs(arg_111_0) do
					var_111_2[iter_111_2] = iter_111_3

					if iter_111_3 == var_111_0 then
						break
					end
				end

				if next(var_111_2) == nil then
					var_111_2 = nil
				end

				return var_111_0, var_111_1, var_111_2
			end)(arg_110_1)

			if var_110_7 then
				var_37_30(var_110_7, function()
					if var_110_6 then
						var_59_2(var_110_6)
					end

					explore_manager:move_cur_pos(var_37_0.maptype, var_110_5, nil)
				end)
			elseif var_110_6 then
				var_59_2(var_110_6)
			end
		end

		local function var_59_5(arg_113_0)
			return cc.p((math.floor((arg_113_0.x - var_0_53 + 50) / 100) + 1 - 1) * 100 + var_0_53, (math.floor((arg_113_0.y - var_0_54 + 50) / 100) + 1 - 1) * 100 + var_0_54)
		end

		local function var_59_6(arg_114_0)
			if explore_manager.curMapConfig.rangeModel.center[arg_114_0] then
				return false
			end

			local var_114_0 = 0

			for iter_114_0 = 1, 4 do
				local var_114_1 = var_37_25(arg_114_0, iter_114_0)

				if not var_114_1 then
					var_114_0 = var_114_0 + 1
				elseif not var_37_24(var_114_1) then
					var_114_0 = var_114_0 + 1
				end
			end

			if var_114_0 == 4 then
				return true
			else
				return false
			end
		end

		local function var_59_7(arg_115_0)
			if arg_115_0.x < var_0_53 - 50 or arg_115_0.x > var_0_53 - 50 + var_37_12 * 100 or arg_115_0.y < var_0_54 - 50 or arg_115_0.y > var_0_54 - 50 + var_37_13 * 100 then
				return -1
			end

			local var_115_0 = (math.floor((arg_115_0.y - var_0_54 + 50) / 100) + 1 - 1) * var_37_12 + (math.floor((arg_115_0.x - var_0_53 + 50) / 100) + 1)

			if var_115_0 == explore_manager.curMapConfig.curPosIndex then
				return 1
			end

			if var_37_6[var_37_1[var_115_0]].class == 1 then
				return -1
			end

			if explore_manager.curMapConfig.rangeModel.range[var_115_0] and not explore_manager.curMapConfig.rangeModel.center[var_115_0] then
				return -2
			end

			if var_59_6(var_115_0) then
				return -3
			end

			local var_115_1 = var_59_1(var_115_0)

			if var_115_1 then
				return 2, var_115_1, explore_manager.curMapConfig.curPosIndex, var_115_0
			else
				return -3
			end
		end

		listener = cc.EventListenerTouchOneByOne:create()

		listener:setSwallowTouches(true)
		listener:registerScriptHandler(function(arg_116_0, arg_116_1)
			if self.touchLock then
				return false
			end

			local var_116_0 = self.layout:convertToNodeSpace(arg_116_0:getLocation())
			local var_116_1 = var_59_3(var_116_0)

			if var_116_1 == (var_37_16.y - 1) * var_37_12 + var_37_16.x then
				var_59_0 = {
					var_116_1
				}
			end

			self:setTouchMarkPos(var_59_5(var_116_0), var_59_7(var_116_0))

			return true
		end, cc.Handler.EVENT_TOUCH_BEGAN)
		listener:registerScriptHandler(function(arg_117_0, arg_117_1)
			local var_117_0 = var_59_3((self.layout:convertToNodeSpace(arg_117_0:getStartLocation())))
			local var_117_1 = self.layout:convertToNodeSpace(arg_117_0:getLocation())
			local var_117_2 = var_59_3(var_117_1)
			local var_117_3 = var_59_5(var_117_1)
			local var_117_4 = var_59_5((self.layout:convertToNodeSpace(arg_117_0:getPreviousLocation())))

			if var_117_3.x .. var_117_3.y ~= var_117_4.x .. var_117_4.y then
				self:setTouchMarkPos(var_117_3, var_59_7(var_117_1))
			end
		end, cc.Handler.EVENT_TOUCH_MOVED)
		listener:registerScriptHandler(function(arg_118_0, arg_118_1)
			local var_118_0, var_118_1 = self:playTouchMarkAction(var_59_1)
			local var_118_2 = var_59_3((self.layout:convertToNodeSpace(arg_118_0:getLocation())))

			if var_118_0 > 0 then
				if var_118_2 == explore_manager.curMapConfig.curPosIndex then
					if var_37_6[var_37_1[var_118_2]].is_touch == 1 and not var_37_23(var_118_2) then
						var_59_2(var_118_2)
					end

					return
				else
					var_59_4(var_118_2, var_118_1)
				end
			elseif var_118_0 == -1 then
				-- block empty
			elseif var_118_0 == -2 then
				audio_manager:playeffectMusicTest(EXPLORE_INVALID)
				global_ShowBlockWords("已被怪物封印")
			elseif var_118_0 == -3 then
				global_ShowBlockWords("无法到达")
			end
		end, cc.Handler.EVENT_TOUCH_ENDED)
		self.layout:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self.layout)
	end)()
end

function ExploreMapLayer:initSmallMap()
	for iter_119_0, iter_119_1 in pairs(explore_manager.curMapConfig.path_tree) do
		local var_119_0 = ccui.ImageView:create(iter_119_0 == self.curRoomOrder and "explore/small_map_room2.png" or "explore/small_map_room1.png", var_0_0)

		var_119_0:setName(iter_119_0)
		var_119_0:setPosition(39 + ((iter_119_0 - 1) % 3 + 1 - 1) * (6 + var_119_0:getContentSize().width), self.smallMap:getContentSize().height - 25 - (math.floor((iter_119_0 - 1) / 3) + 1 - 1) * (6 + var_119_0:getContentSize().height))
		self.smallMap:addChild(var_119_0)

		for iter_119_2, iter_119_3 in pairs(iter_119_1.node) do
			local var_119_1 = ccui.ImageView:create("explore/small_map_path.png", var_0_0)
			local var_119_2
			local var_119_3
			local var_119_4

			if iter_119_2 == var_0_40 then
				var_119_2 = var_119_0:getContentSize().width / 2
				var_119_3 = var_119_0:getContentSize().height + var_119_1:getContentSize().height / 2
				var_119_4 = 0
			elseif iter_119_2 == var_0_42 then
				var_119_2 = var_119_0:getContentSize().width / 2
				var_119_3 = -var_119_1:getContentSize().height / 2
				var_119_4 = 0
			elseif iter_119_2 == var_0_43 then
				var_119_2 = -var_119_1:getContentSize().height / 2
				var_119_3 = var_119_0:getContentSize().height / 2
				var_119_4 = 90
			elseif iter_119_2 == var_0_41 then
				var_119_2 = var_119_0:getContentSize().width + var_119_1:getContentSize().height / 2
				var_119_3 = var_119_0:getContentSize().height / 2
				var_119_4 = 90
			end

			var_119_1:setPosition(var_119_2, var_119_3)
			var_119_1:setRotation(var_119_4)
			var_119_0:addChild(var_119_1)
		end
	end

	function self.smallMap.updateExploredRoom(arg_120_0)
		for iter_120_0, iter_120_1 in pairs(explore_manager.curMapConfig.path_tree) do
			if self.exploredRooms[iter_120_0] then
				self.smallMap:getChildByName(iter_120_0):setVisible(true)

				if iter_120_0 == self.curRoomOrder then
					self.smallMap:getChildByName(iter_120_0):loadTexture("explore/small_map_room2.png", var_0_0)
				else
					self.smallMap:getChildByName(iter_120_0):loadTexture("explore/small_map_room1.png", var_0_0)
				end
			end
		end
	end

	self.smallMap:updateExploredRoom()
end

function ExploreMapLayer.randomRole(arg_121_0, arg_121_1)
	if not explore_manager.curMapConfig.otherInfos.array then
		return
	end

	local var_121_0 = {}

	if arg_121_1 then
		local var_121_1

		for iter_121_0 = 1, 3 do
			if explore_manager.curMapConfig.otherInfos.array[iter_121_0] and explore_manager.curMapConfig.otherInfos.array[iter_121_0].fight_girl then
				var_121_1 = explore_manager.curMapConfig.otherInfos.array[iter_121_0].fight_girl

				break
			end
		end

		local var_121_2 = global_get_servant_skin(var_121_1)
		local var_121_4 = {
			jsonFilePath = ROLE_SPINE_PATH .. model_data[var_121_2].spine_model .. ".json",
			atlasFilePath = ROLE_SPINE_PATH .. model_data[var_121_2].spine_model .. ".atlas"
		}

		if model_data[var_121_2].clothes_model then
			var_121_4.clothesFilePath = CLOTHES_SPINE_PATH .. model_data[var_121_2].clothes_model .. ".atlas" or nil
		end

		var_121_4.scale = var_0_56
		var_121_4.size = cc.size(model_data[var_121_2].modelweight, model_data[var_121_2].modelheight)
		var_121_4.modelid = var_121_2

		return var_121_4
	end

	for iter_121_1, iter_121_2 in pairs(explore_manager.curMapConfig.otherInfos.array) do
		if iter_121_2.fight_girl then
			var_121_0[#var_121_0 + 1] = iter_121_2.fight_girl
		end
	end

	return CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[var_121_0[math.random(#var_121_0)]].modelid].cute_role .. ".png"
end

function ExploreMapLayer:initSelectedFrame(arg_122_1)
	self.curPos = cc.p((explore_manager.curMapConfig.curPosIndex - 1) % self.room_WIDTH_num + 1, math.floor((explore_manager.curMapConfig.curPosIndex - 1) / self.room_WIDTH_num) + 1)

	local var_122_0 = 1

	if arg_122_1 and arg_122_1 == var_0_43 then
		var_122_0 = -1
	end

	local var_122_1 = self:randomRole(true)

	self.tag = L2Actor:create(var_122_1.jsonFilePath, var_122_1.atlasFilePath, var_122_1.clothesFilePath)
	self.tag.modelid = var_122_1.modelid

	self.tag:setScale(var_122_1.scale * var_122_0, var_122_1.scale)
	self.tag:setContentSize(var_122_1.size)
	self.tag:setPosition((self:getCurPos(self.curPos.x, self.curPos.y)))
	self:playAni("idle")
	self.iconLayout:addChild(self.tag, self.room_HEIGHT_num - self.curPos.y + 1)

	local var_122_2 = explore_manager.getCurData("map", explore_manager.curMapConfig.otherInfos.maptype)
	local var_122_3 = explore_manager.curMapConfig.plotClassId and explore_manager.curMapConfig.plotMapId and var_122_2[explore_manager.curMapConfig.plotMapId] or var_122_2[explore_manager.curMapConfig.otherInfos.mapfloor]

	if var_122_3.star_aura then
		local var_122_4 = var_122_3.star_aura_offset_x or 0
		local var_122_5 = var_122_3.star_aura_offset_y or 0
		local var_122_6 = var_122_3.star_aura_scale or 1
		local var_122_7

		if var_122_3.star_aura_opacity then
			var_122_7 = var_122_3.star_aura_opacity / 100 or 1

			local var_122_8

			if var_122_1._DEBUG then
				var_122_8 = cc.Sprite:create("explore/" .. var_122_3.star_aura .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. var_122_3.star_aura .. ".png")
			end
		end

		var_122_8:setPosition(self.tag:getContentSize().width / 2 + var_122_4, self.tag:getContentSize().height / 2 + 50 + var_122_5)
		var_122_8:setScale(var_122_6)
		var_122_8:setOpacity(255 * var_122_7)
		var_122_8:setBlendFunc(GL_SRC_ALPHA, GL_ONE)
		self.tag:addChild(var_122_8, 99)
	end
end

function ExploreMapLayer:updateSelectedFrame(arg_123_1)
	if not explore_manager.curMapConfig.otherInfos.array then
		return
	end

	if not explore_manager.curMapConfig.otherInfos.array[arg_123_1] then
		return
	end

	local var_123_0 = global_get_servant_skin(explore_manager.curMapConfig.otherInfos.array[arg_123_1].fight_girl)
	local var_123_1 = var_0_56
	local var_123_2 = cc.size(model_data[var_123_0].modelweight, model_data[var_123_0].modelheight)
	local var_123_3

	if model_data[var_123_0].clothes_model then
		var_123_3 = CLOTHES_SPINE_PATH .. model_data[var_123_0].clothes_model .. ".atlas" or nil
	end

	local var_123_4 = var_123_1

	self.tag:updateSpine(ROLE_SPINE_PATH .. model_data[var_123_0].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_123_0].spine_model .. ".atlas", var_123_3)
	self.tag:setScale(var_123_4, var_123_4)
	self.tag:setContentSize(var_123_2)
	self.tag:playAni(nil, self.tag.aniName, true)

	self.tag.modelid = var_123_0
end

function ExploreMapLayer:playAni(arg_124_1, arg_124_2)
	if arg_124_1 == self.tag.aniName then
		return
	end

	self.tag.aniName = arg_124_1

	if arg_124_2 then
		self.tag:playAni(arg_124_2, arg_124_1, false)
	else
		self.tag:playAni(nil, arg_124_1, true)

		if arg_124_1 == "run" then
			audio_manager:playeffectMusic(EXPLORE_WALK, true)
		else
			audio_manager:stopAllEffects()
		end
	end
end

function ExploreMapLayer:addSelectedFrame(arg_125_1, arg_125_2, arg_125_3, arg_125_4)
	self.tag:setPosition((cc.p(var_0_53 + (arg_125_1 - 1) * 100, var_0_54 + (arg_125_2 - 1) * 100)))
	self.tag:setLocalZOrder(arg_125_4 - arg_125_2 + 1)
	self.smallMapTag:setPosition(arg_125_1 / arg_125_3 * self.smallMap.width, arg_125_2 / arg_125_4 * self.smallMap.height)
	self.smallMapBox:setBoxPos(arg_125_1 / arg_125_3 * self.smallMap.width, arg_125_2 / arg_125_4 * self.smallMap.height)
end

function ExploreMapLayer:scrollToPoint(arg_126_1, arg_126_2, arg_126_3)
	local var_126_0 = self.layout:getContentSize().width * var_0_57 - 640
	local var_126_1 = self.layout:getContentSize().height * var_0_57 - 1136
	local var_126_2 = (var_0_53 + (arg_126_1 - 1) * 100) * var_0_57 - 320
	local var_126_3 = (var_0_54 + (arg_126_2 - 1) * 100) * var_0_57 - 568

	if (var_0_53 + (arg_126_1 - 1) * 100) * var_0_57 - 320 < 0 then
		var_126_2 = 0
	elseif var_126_0 < var_126_2 then
		var_126_2 = var_126_0
	end

	if var_126_3 < 0 then
		var_126_3 = 0
	elseif var_126_1 < var_126_3 then
		var_126_3 = var_126_1
	end

	self.mapView:getInnerContainer():runAction(cc.Sequence:create(cc.DelayTime:create(arg_126_3), cc.MoveTo:create(var_0_55, cc.p(-var_126_2, -var_126_3))))
end

function ExploreMapLayer:goToNextFloor()
	local var_127_0 = explore_manager.getCurData("map", explore_manager.curMapConfig.otherInfos.maptype)[explore_manager.curMapConfig.otherInfos.mapfloor].enter_map_talk

	if var_127_0 then
		global_basic_scene:addChild(TalkLayer:create(var_127_0, nil, TALK_TYPE_NORMAL))
	end

	self.layout:removeFromParent()

	self.layout = nil

	self:genMap()
	self:updateMapUI()
end

function ExploreMapLayer:resetCurMap(arg_128_1, arg_128_2, arg_128_3)
	self.mapPanel:setVisible(false)
	self.mapView:removeAllChildren()
	self:updateMapCover(arg_128_1)
	self:removeCachedTextured(arg_128_1, arg_128_2, arg_128_3)
	self:removeAllBuffIcon()
	TopcostLayer.getInstance():showTopcostLayer()
end

function ExploreMapLayer:updateRangeModel(arg_129_1)
	if not explore_manager.curMapConfig.rangeModel[self.curRoomOrder].center[arg_129_1] then
		return
	end

	local function var_129_0(arg_130_0)
		if self.maskPanel:getChildByName("maskPanel" .. arg_130_0) then
			self.maskPanel:getChildByName("maskPanel" .. arg_130_0):removeFromParent()
		end
	end

	for iter_129_0, iter_129_1 in pairs(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].center[arg_129_1]) do
		for iter_129_2, iter_129_3 in pairs(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[iter_129_1]) do
			if iter_129_3 == arg_129_1 then
				table.remove(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[iter_129_1], iter_129_2)
			end
		end

		if next(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[iter_129_1]) == nil then
			explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[iter_129_1] = nil
		end
	end

	explore_manager.curMapConfig.rangeModel[self.curRoomOrder].center[arg_129_1] = nil

	var_129_0(arg_129_1)
end

function ExploreMapLayer:onForeground(arg_131_1)
	self.touchLock = false

	if self.auto_explore_num then
		self.auto_explore_num:setString("×" .. item_manager:getItemNumber(1749901))
	end

	if self.isPopExploreDifficult then
		self.isPopExploreDifficult:updateUI()
		LayerManager:getPlotObj():exploreUpdatePlotShow("ExploreMapLayer" .. self.isPopExploreDifficult.maptype)
	end

	if explore_manager.curMapConfig then
		TopcostLayer.getInstance():hideTopcostLayer()
	end
end

function ExploreMapLayer.onBackground(arg_132_0)
	arg_132_0.touchLock = true

	TopcostLayer.getInstance():showTopcostLayer()
end

function ExploreMapLayer.buffShopPopLayer(arg_133_0, arg_133_1, arg_133_2, arg_133_3)
	local function var_133_0(arg_134_0, arg_134_1)
		local var_134_0 = total_skill_data[arg_134_0.id]
		local var_134_1 = ccui.Layout:create()

		var_134_1:setTouchEnabled(true)
		var_134_1:setContentSize(cc.size(640, 1136))
		var_134_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_134_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_134_1:setBackGroundColorOpacity(200)
		var_134_1:setCascadeOpacityEnabled(false)
		arg_134_1:addChild(var_134_1, 999)
		var_134_1:addTouchEventListener(function(arg_135_0, arg_135_1)
			if arg_135_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_134_1:runAction(cc.RemoveSelf:create())
		end)

		local var_134_2 = ccui.ImageView:create("explore/buff_pop.png", var_0_0)

		var_134_2:setTouchEnabled(true)
		var_134_2:setPosition(320, 700)
		var_134_1:addChild(var_134_2)

		local var_134_3 = cc.Label:createWithTTF("BUFF详情", FONT_TITLE, 26)

		var_134_3:setAnchorPoint(cc.p(0, 0.5))
		var_134_3:setPosition(12, 432)
		var_134_2:addChild(var_134_3)

		local var_134_4 = ccui.ImageView:create((var_134_0.icon or nil) and ("skill_new/skill/" .. var_134_0.icon .. ".png" or "skill_new/skill/7.png"), var_0_0)

		var_134_4:setAnchorPoint(cc.p(0, 0.5))
		var_134_4:setPosition(30, 340)
		var_134_2:addChild(var_134_4)

		local var_134_5 = cc.Label:createWithTTF(var_134_0.name, FONT_NAME, 30)

		var_134_5:setAnchorPoint(cc.p(0, 0.5))
		var_134_5:setPosition(150, 340)
		var_134_2:addChild(var_134_5)

		local var_134_6 = ccui.Layout:create()

		var_134_6:setContentSize(cc.size(470, 180))
		var_134_6:setPosition(30, 80)
		var_134_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_134_6:setBackGroundColor(cc.c3b(0, 0, 0))
		var_134_6:setBackGroundColorOpacity(76)
		var_134_6:setCascadeOpacityEnabled(false)
		var_134_2:addChild(var_134_6)

		local var_134_7 = cc.Label:createWithTTF(var_134_0.description, FONT_DES, 24)

		var_134_7:setMaxLineWidth(462)
		var_134_7:setAnchorPoint(cc.p(0, 1))
		var_134_7:setPosition(4, var_134_6:getContentSize().height - 4)
		var_134_6:addChild(var_134_7)

		local var_134_8 = ccui.Layout:create()

		var_134_8:setPosition(30, 20)
		var_134_8:setContentSize(cc.size(470, 40))
		var_134_8:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_134_8:setBackGroundColor(cc.c3b(0, 0, 0))
		var_134_8:setBackGroundColorOpacity(76)
		var_134_8:setCascadeOpacityEnabled(false)
		var_134_2:addChild(var_134_8)

		local var_134_9 = cc.Label:createWithTTF("由学院研发的技术,用于保护外出出勤的学员", FONT_DES, 20)

		var_134_9:setAnchorPoint(cc.p(0, 0.5))
		var_134_9:setPosition(4, var_134_8:getContentSize().height / 2)
		var_134_8:addChild(var_134_9)

		local var_134_10 = ccui.Button:create("public/button/public_button_big_y.png", "public/button/public_button_big_y_on.png", nil, var_0_0)

		var_134_10:setTitleText("购买")
		var_134_10:setTitleFontSize(32)
		var_134_10:setTitleFontName(FONT_BUTTON)
		var_134_10:setTitleColor(cc.c3b(0, 0, 0))
		var_134_10:setPosition(320, 400)
		var_134_1:addChild(var_134_10)

		if arg_134_0.price == 0 then
			var_134_10:setTitleText("装备")

			var_134_10.isCanBuy = true
		elseif item_manager:isHaveEnoughItem(arg_134_0.costitem, arg_134_0.price) then
			var_134_10:setTitleText("购买")

			var_134_10.isCanBuy = true
		else
			var_134_10:setTitleText("不足")

			var_134_10.isCanBuy = false
		end

		var_134_10:addTouchEventListener(function(arg_136_0, arg_136_1)
			if arg_136_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_136_0.isCanBuy then
				var_134_10:setTouchEnabled(false)

				if arg_133_2 then
					arg_133_2(arg_134_0.order)
				end

				arg_134_1:runAction(cc.RemoveSelf:create())
			else
				global_ShowBlockWords("货币不足")
			end
		end)
	end

	local var_133_1 = ccui.Layout:create()

	var_133_1:setTouchEnabled(true)
	var_133_1:setContentSize(cc.size(640, 1136))
	var_133_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_133_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_133_1:setBackGroundColorOpacity(145)
	var_133_1:setCascadeOpacityEnabled(false)
	global_basic_scene:addChild(var_133_1, 999)
	var_133_1:addTouchEventListener(function(arg_137_0, arg_137_1)
		if arg_137_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_133_1:runAction(cc.RemoveSelf:create())

		if arg_133_3 then
			arg_133_3()
		end
	end)

	local var_133_2 = cc.Label:createWithTTF("接受命运的馈赠吧,幸福三选一~~", FONT_TITLE, 32)

	var_133_2:setPosition(320, 800)
	var_133_1:addChild(var_133_2)

	local var_133_3 = {}

	while explore_buff_data[arg_133_1]["buff" .. 1] do
		var_133_3[1] = {
			order = 1,
			id = explore_buff_data[arg_133_1]["buff" .. 1],
			costitem = explore_buff_data[arg_133_1]["itemid" .. 1],
			price = explore_buff_data[arg_133_1]["buff_price" .. 1]
		}
	end

	for iter_133_0, iter_133_1 in ipairs(var_133_3) do
		local var_133_5 = total_skill_data[iter_133_1.id]
		local var_133_6 = ccui.ImageView:create("explore/buff_shop_box.png", var_0_0)

		var_133_6:setPosition((iter_133_0 - (#var_133_3 + 1) / 2) * 220 + 320, 600)
		var_133_1:addChild(var_133_6)

		local var_133_7 = ccui.ImageView:create((var_133_5.icon or nil) and ("skill_new/skill/" .. var_133_5.icon .. ".png" or "equipment/3_on.png"), var_0_0)

		var_133_7:setPosition(var_133_6:getContentSize().width / 2, var_133_6:getContentSize().height / 2)
		var_133_6:addChild(var_133_7)

		local var_133_8 = ccui.ImageView:create("public/button/public_button_normal_y.png", var_0_0)

		var_133_8:setAnchorPoint(cc.p(0.5, 1))
		var_133_8:setPosition(var_133_6:getContentSize().width / 2, -10)
		var_133_6:addChild(var_133_8)

		local var_133_9 = cc.Label:createWithTTF(var_133_5.name, FONT_NAME, 28)

		var_133_9:setColor(cc.c3b(0, 0, 0))
		var_133_9:setPosition(var_133_8:getContentSize().width / 2, var_133_8:getContentSize().height / 2)
		var_133_8:addChild(var_133_9)

		if iter_133_1.price ~= 0 then
			local var_133_10 = ccui.ImageView:create("explore/price_bg.png", var_0_0)

			var_133_10:setPosition(var_133_6:getContentSize().width / 2, -70)
			var_133_6:addChild(var_133_10)

			local var_133_11 = ccui.ImageView:create("explore/cost_icon_black.png", var_0_0)

			var_133_11:setAnchorPoint(cc.p(0, 0.5))
			var_133_11:setPosition(0, var_133_10:getContentSize().height / 2)
			var_133_10:addChild(var_133_11)

			local var_133_12 = cc.Label:createWithTTF(iter_133_1.price, FONT_NAME, 30)

			var_133_12:setColor(cc.c3b(0, 0, 0))
			var_133_12:setAnchorPoint(cc.p(0, 0.5))
			var_133_12:setPosition(var_133_11:getPositionX() + var_133_11:getContentSize().width + 4, var_133_10:getContentSize().height / 2)
			var_133_10:addChild(var_133_12)
		end

		var_133_6:setTouchEnabled(true)
		var_133_6:addTouchEventListener(function(arg_138_0, arg_138_1)
			if arg_138_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_133_0(iter_133_1, var_133_1)
		end)
	end
end

function ExploreMapLayer.itemShopPopLayer(arg_139_0, arg_139_1, arg_139_2, arg_139_3)
	local var_139_0 = ccui.Layout:create()

	var_139_0:setContentSize(cc.size(640, 1136))
	var_139_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_139_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_139_0:setBackGroundColorOpacity(145)
	var_139_0:setCascadeOpacityEnabled(false)
	var_139_0:setTouchEnabled(true)
	global_basic_scene:addChild(var_139_0, 999)
	var_139_0:addTouchEventListener(function(arg_140_0, arg_140_1)
		if arg_140_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_139_0:runAction(cc.RemoveSelf:create())

		if arg_139_3 then
			arg_139_3()
		end
	end)

	local var_139_1 = cc.Label:createWithTTF("×" .. global_trans_number(playermodel.diamond), FONT_TITLE, 30)

	var_139_1:setAnchorPoint(cc.p(1, 0.5))
	var_139_1:setPosition(640, 920)
	var_139_1:setGlobalZOrder(9999)
	var_139_0:addChild(var_139_1)

	local var_139_2

	if config._DEBUG then
		var_139_2 = cc.Sprite:create("public/currency/UI_battleEnd_diamond.png") or cc.Sprite:createWithSpriteFrameName("public/currency/UI_battleEnd_diamond.png")
	end

	var_139_2:setAnchorPoint(cc.p(1, 0.5))
	var_139_2:setGlobalZOrder(9999)
	var_139_2:setPosition(var_139_1:getPositionX() - var_139_1:getContentSize().width, 920)
	var_139_2:setScale(1.5)
	var_139_0:addChild(var_139_2)

	local var_139_3 = {}

	while explore_weapon_data[arg_139_1]["weapon" .. 1] do
		var_139_3[1] = {
			order = 1,
			id = explore_weapon_data[arg_139_1]["weapon" .. 1],
			costitem = explore_weapon_data[arg_139_1]["itemid" .. 1],
			price = explore_weapon_data[arg_139_1]["weapon_price" .. 1]
		}
	end

	for iter_139_0, iter_139_1 in ipairs(var_139_3) do
		local var_139_6 = ItemSprite:createNewWithItemId(iter_139_1.id)

		var_139_6:setPosition((iter_139_0 - (#var_139_3 + 1) / 2) * 220 + 320, 640)
		var_139_0:addChild(var_139_6)

		local var_139_7 = ccui.ImageView:create("explore/price_bg.png", var_0_0)

		var_139_7:setPosition(var_139_6:getContentSize().width / 2, -35)
		var_139_6:addChild(var_139_7)

		local var_139_8 = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_0)

		var_139_8:setAnchorPoint(cc.p(0, 0.5))
		var_139_8:setScale(30 / var_139_8:getContentSize().width)
		var_139_8:setPosition(0, var_139_7:getContentSize().height / 2)
		var_139_7:addChild(var_139_8)

		local var_139_9 = cc.Label:createWithTTF(iter_139_1.price, FONT_NAME, 30)

		var_139_9:setColor(cc.c3b(255, 255, 255))
		var_139_9:setAnchorPoint(cc.p(0, 0.5))
		var_139_9:setPosition(var_139_8:getPositionX() + var_139_8:getBoundingBox().width + 4, var_139_7:getContentSize().height / 2)
		var_139_7:addChild(var_139_9)
		var_139_6:setTouchEnabled(true)
		var_139_6:setSwallowTouches(true)
		var_139_6:addSpriteTouchEventListener(function(arg_141_0, arg_141_1)
			if arg_141_1 ~= ccui.TouchEventType.ended then
				local var_141_0 = PopLayer:Item({
					hideGainButton = true,
					limitNum = 1,
					itemid = iter_139_1.id,
					slidecost = {
						costtype = "public/currency/UI_battleEnd_diamond.png",
						cost_scale = 1,
						costnum = iter_139_1.price,
						nowHave = playermodel.diamond
					},
					ShopSliderCallback = function(self, arg_142_1)
						if not self:isBright() then
							return
						end

						self:setTouchEnabled(false)

						if iter_139_1.price < playermodel.diamond then
							if arg_139_2 then
								arg_139_2(iter_139_1.order)
							end

							var_139_0:runAction(cc.RemoveSelf:create())
						else
							self:setTouchEnabled(true)
							global_ShowBlockWords("货币不足")
						end
					end
				})

				var_141_0:setName("poplayer")
				var_139_0:addChild(var_141_0)
			end
		end)
	end
end

function ExploreMapLayer:needKeyPopLayer(arg_143_1)
	local var_143_0 = ccui.Layout:create()

	var_143_0:setContentSize(cc.size(640, 1136))
	var_143_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_143_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_143_0:setBackGroundColorOpacity(145)
	var_143_0:setCascadeOpacityEnabled(false)
	var_143_0:setTouchEnabled(true)
	self:addChild(var_143_0, 999)
	var_143_0:addTouchEventListener(function(arg_144_0, arg_144_1)
		if arg_144_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_143_1.cancelcallback then
			arg_143_1.cancelcallback()
		end

		var_143_0:runAction(cc.RemoveSelf:create())
	end)

	local var_143_1 = ccui.ImageView:create("explore/buff_pop.png", var_0_0)

	var_143_1:setPosition(320, 700)
	var_143_0:addChild(var_143_1)

	local var_143_2 = cc.Label:createWithTTF("消耗物品", FONT_TITLE, 30)

	var_143_2:setAnchorPoint(cc.p(0, 0.5))
	var_143_2:setPosition(20, 430)
	var_143_1:addChild(var_143_2)

	local var_143_3 = ItemSprite:createNewWithItemId(arg_143_1.needid, 1)

	var_143_3:getChildByName("number"):setString(arg_143_1.ownnum .. "/" .. arg_143_1.neednum)

	if arg_143_1.neednum > arg_143_1.ownnum then
		var_143_3:getChildByName("number"):setColor(cc.c3b(200, 0, 0))
	end

	var_143_3:setScale(0.9)
	var_143_3:setAnchorPoint(cc.p(0.5, 1))
	var_143_3:setPosition(var_143_1:getContentSize().width / 2, var_143_1:getContentSize().height - 80)
	var_143_1:addChild(var_143_3)
	var_143_3:setTouchEnabled(true)
	var_143_3:setSwallowTouches(true)
	var_143_3:addSpriteTouchEventListener(function(arg_145_0, arg_145_1)
		if arg_145_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_basic_scene:addChild(PopLayer:Item({
			hideGainButton = true,
			itemid = arg_143_1.needid
		}))
	end)

	local var_143_4 = ccui.Layout:create()

	var_143_4:setContentSize(cc.size(500, 150))
	var_143_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_143_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_143_4:setBackGroundColorOpacity(145)
	var_143_4:setCascadeOpacityEnabled(false)
	var_143_4:setAnchorPoint(cc.p(0.5, 0))
	var_143_4:setPosition(var_143_1:getContentSize().width / 2, 4)
	var_143_1:addChild(var_143_4)

	local var_143_5 = cc.Label:createWithTTF(arg_143_1.des, FONT_NAME, 24)

	var_143_5:setMaxLineWidth(490)
	var_143_5:setAnchorPoint(cc.p(0.5, 1))
	var_143_5:setPosition(var_143_4:getContentSize().width / 2, var_143_4:getContentSize().height - 4)
	var_143_4:addChild(var_143_5)

	local var_143_6 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y_on.png", var_0_0)

	var_143_6:setScale9Enabled(true)

	local var_143_7 = var_143_6:getContentSize()

	var_143_6:setCapInsets(cc.rect(var_143_7.width / 2 - 10, var_143_7.height / 2 - 10, 10, 10))
	var_143_6:setContentSize(cc.size(450, 80))
	var_143_6:setTitleText("确认")
	var_143_6:setTitleColor(cc.c3b(0, 0, 0))
	var_143_6:setTitleFontName(FONT_BUTTON)
	var_143_6:setTitleFontSize(30)
	var_143_6:setPosition(var_143_1:getContentSize().width / 2, -100)
	var_143_1:addChild(var_143_6)
	var_143_6:addTouchEventListener(function(arg_146_0, arg_146_1)
		if arg_146_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_143_1.surecallback then
			arg_143_1.surecallback()
		end

		var_143_0:runAction(cc.RemoveSelf:create())
	end)

	return var_143_0
end

function ExploreMapLayer:npcPopLayer(arg_147_1)
	local var_147_0 = ccui.Layout:create()

	var_147_0:setContentSize(cc.size(640, 1136))
	var_147_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_147_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_147_0:setBackGroundColorOpacity(145)
	var_147_0:setCascadeOpacityEnabled(false)
	var_147_0:setTouchEnabled(true)
	self:addChild(var_147_0, 999)
	var_147_0:addTouchEventListener(function(arg_148_0, arg_148_1)
		if arg_148_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_147_1.cancelcallback then
			arg_147_1.cancelcallback()
		end

		var_147_0:runAction(cc.RemoveSelf:create())
	end)

	local var_147_1 = ccui.ImageView:create("explore/buff_pop.png", var_0_0)

	var_147_1:setPosition(320, 700)
	var_147_0:addChild(var_147_1)

	local var_147_2 = cc.Label:createWithTTF("任务需求", FONT_TITLE, 30)

	var_147_2:setAnchorPoint(cc.p(0, 0.5))
	var_147_2:setPosition(20, 430)
	var_147_1:addChild(var_147_2)

	if arg_147_1.tileInfo.trigger_param1 then
		local var_147_3 = ccui.Button:create("public/button/public_button_normal_y.png", nil, "public/button/public_button_off.png", var_0_0)

		var_147_3:setAnchorPoint(cc.p(1, 0))
		var_147_3:setPosition(var_147_1:getContentSize().width - 10, 5)
		var_147_3:setScale(0.6)

		local var_147_4 = cc.Label:createWithTTF("线索", FONT_BUTTON, 30)

		var_147_4:setColor(cc.c3b(41, 49, 58))
		var_147_4:setName("label")
		var_147_4:setPosition(cc.p(var_147_3:getContentSize().width / 2, var_147_3:getContentSize().height / 2))
		var_147_3:addChild(var_147_4)
		var_147_1:addChild(var_147_3, 9)
		var_147_3:addTouchEventListener(function(arg_149_0, arg_149_1)
			if arg_149_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_basic_scene:addChild(TalkLayer:create(arg_147_1.tileInfo.trigger_param1, nil, TALK_TYPE_NORMAL))
		end)
	end

	local var_147_5 = {}
	local var_147_6 = 2

	while arg_147_1.tileInfo["trigger_param" .. var_147_6] do
		local var_147_8 = {
			itemid = arg_147_1.tileInfo["trigger_param" .. var_147_6]
		}

		var_147_8.neednum = arg_147_1.tileInfo["trigger_param" .. var_147_6 + 1] or 1
		var_147_8.ownnum = item_manager:getItemNumber(arg_147_1.tileInfo["trigger_param" .. var_147_6])

		table.insert(var_147_5, var_147_8)

		var_147_6 = var_147_6 + 2
	end

	local var_147_9 = cc.Label:createWithTTF("需要消耗:", FONT_NAME, 24)

	var_147_9:setColor(cc.c3b(250, 124, 30))
	var_147_9:setAnchorPoint(cc.p(0, 1))
	var_147_9:setPosition(5, 410)
	var_147_1:addChild(var_147_9)

	for iter_147_0, iter_147_1 in ipairs(var_147_5) do
		local var_147_10 = ItemSprite:createNewWithItemId(iter_147_1.itemid, 1)

		var_147_10:getChildByName("number"):setString(iter_147_1.ownnum .. "/" .. iter_147_1.neednum)

		if iter_147_1.neednum > iter_147_1.ownnum then
			var_147_10:getChildByName("number"):setColor(cc.c3b(200, 0, 0))
		end

		var_147_10:setScale(0.9)
		var_147_10:setAnchorPoint(cc.p(0.5, 1))
		var_147_10:setPosition(var_147_1:getContentSize().width / 2 + (iter_147_0 - (#var_147_5 + 1) / 2) * 180, var_147_1:getContentSize().height - 90)
		var_147_1:addChild(var_147_10)
		var_147_10:setTouchEnabled(true)
		var_147_10:setSwallowTouches(true)
		var_147_10:addSpriteTouchEventListener(function(arg_150_0, arg_150_1)
			if arg_150_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_basic_scene:addChild(PopLayer:Item({
				hideGainButton = true,
				itemid = iter_147_1.itemid
			}))
		end)
	end

	local var_147_11 = ccui.Layout:create()

	var_147_11:setContentSize(cc.size(500, 150))
	var_147_11:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_147_11:setBackGroundColor(cc.c3b(0, 0, 0))
	var_147_11:setBackGroundColorOpacity(145)
	var_147_11:setCascadeOpacityEnabled(false)
	var_147_11:setAnchorPoint(cc.p(0.5, 0))
	var_147_11:setPosition(var_147_1:getContentSize().width / 2, 4)
	var_147_1:addChild(var_147_11)

	local var_147_12 = cc.Label:createWithTTF(arg_147_1.tileInfo.trigger_des, FONT_NAME, 24)

	var_147_12:setMaxLineWidth(490)
	var_147_12:setAnchorPoint(cc.p(0.5, 1))
	var_147_12:setPosition(var_147_11:getContentSize().width / 2, var_147_11:getContentSize().height - 4)
	var_147_11:addChild(var_147_12)

	local var_147_13 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y_on.png", var_0_0)

	var_147_13:setScale9Enabled(true)

	local var_147_14 = var_147_13:getContentSize()

	var_147_13:setCapInsets(cc.rect(var_147_14.width / 2 - 10, var_147_14.height / 2 - 10, 10, 10))
	var_147_13:setContentSize(cc.size(450, 80))
	var_147_13:setTitleText("确认")
	var_147_13:setTitleColor(cc.c3b(0, 0, 0))
	var_147_13:setTitleFontName(FONT_BUTTON)
	var_147_13:setTitleFontSize(30)
	var_147_13:setPosition(var_147_1:getContentSize().width / 2, -100)
	var_147_1:addChild(var_147_13)
	var_147_13:addTouchEventListener(function(arg_151_0, arg_151_1)
		if arg_151_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_147_1.surecallback then
			arg_147_1.surecallback()
		end

		var_147_0:runAction(cc.RemoveSelf:create())
	end)

	return var_147_0
end

function ExploreMapLayer:settlementPopLayer(arg_152_1)
	local var_152_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_mainLine_settlement.json" or "Pop_mainLine_settlement.ExportJson")

	self:addChild(var_152_0, 999)

	local var_152_1 = ccui.Helper:seekWidgetByName(var_152_0, "Panel_settlement")

	var_152_1:setScaleY(0.1)
	var_152_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1)))
	var_152_1:getChildByName("Image_5"):loadTexture("explore/settlement_bg.png", var_0_0)
	ccui.Helper:seekWidgetByName(var_152_0, "Label_5"):setString("通关第: ")
	ccui.Helper:seekWidgetByName(var_152_0, "Label_chappter"):setString(arg_152_1.mapfloor .. "层")
	var_152_0:addTouchEventListener(function(arg_153_0, arg_153_1)
		if arg_153_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_152_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
			var_152_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	ccui.Helper:seekWidgetByName(var_152_0, "Button_sure"):setTitleText("确认")
	ccui.Helper:seekWidgetByName(var_152_0, "Button_sure"):addTouchEventListener(function(arg_155_0, arg_155_1)
		if arg_155_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_152_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
			var_152_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_152_2 = {}
	local var_152_4

	if arg_152_1.items then
		for iter_152_0, iter_152_1 in pairs(arg_152_1.items) do
			var_152_2[#var_152_2 + 1] = {}
			var_152_2[#var_152_2].itemid = iter_152_1.itemid
			var_152_2[#var_152_2].itemcount = iter_152_1.num or 1
		end

		var_152_4 = PopLayer:Pop_Create_Settlement_ItemList(var_152_2)
	end

	var_152_4:setPosition(cc.p(SCREEN_WIDTH / 2 - 74, 177))
	var_152_1:addChild(var_152_4, 10)
	var_152_4:setCascadeOpacityEnabled(true)
end

function ExploreMapLayer.mapLoading(arg_157_0, arg_157_1, arg_157_2, arg_157_3)
	local var_157_0 = ccui.Layout:create()

	var_157_0:setContentSize(cc.size(640, 1136))
	var_157_0:setTouchEnabled(true)
	global_basic_scene:addChild(var_157_0, 9999)

	var_157_0.wait_ani = true
	var_157_0.wait_load = 1

	function var_157_0:initUI(arg_158_1)
		self.up = cc.Sprite:create("mainScenebg/explore/loading.jpg")

		self.up:setPosition(cc.p(320, 568))
		self:addChild(self.up, 1)

		if config._DEBUG then
			self.title = cc.Sprite:create("explore/load_title.png") or cc.Sprite:createWithSpriteFrameName("explore/load_title.png")
		end

		self.title:setPosition(cc.p(480, 60))
		self:addChild(self.title, 2)

		self.points = {}

		for iter_158_0 = 1, 3 do
			local var_158_0

			if config._DEBUG then
				var_158_0 = cc.Sprite:create("explore/load_point.png") or cc.Sprite:createWithSpriteFrameName("explore/load_point.png")
			end

			var_158_0:setPosition(self.title:getPositionX() + self.title:getContentSize().width / 2 + 4 + (iter_158_0 - 1) * 12, 60)
			self:addChild(var_158_0, 2)

			self.points[iter_158_0] = var_158_0
		end
	end

	function var_157_0.startScheduler(arg_159_0)
		arg_159_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_160_0)
			if not arg_159_0.wait_ani and arg_159_0.wait_load <= 0 then
				arg_159_0:loadEnding()
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_159_0.scheduler)

				arg_159_0.scheduler = nil
			end
		end, 0.1, false)
	end

	function var_157_0.startLoading(arg_161_0)
		local var_161_0 = explore_manager.getCurData("map", arg_157_1)
		local var_161_1 = explore_manager.curMapConfig.plotClassId and var_161_0[plot_data[PlotManager:getRunningPlotId(explore_manager.curMapConfig.plotClassId)].finish_param2].fullImage or var_161_0[arg_157_2].fullImage

		for iter_161_0, iter_161_1 in pairs({
			"tilemap/tiles_" .. var_161_1 .. ".plist",
			"tilemap/tilebg.plist"
		}) do
			local var_161_2

			if iter_161_1:find(".png") then
				var_161_2 = iter_161_1
			elseif iter_161_1:find(".plist") then
				var_161_2 = iter_161_1:match("(.+).plist") .. ".png"
			end

			cc.Director:getInstance():getTextureCache():addImageAsync(var_161_2, function()
				if iter_161_1:find(".plist") then
					cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_161_1)
				end

				arg_161_0.wait_load = arg_161_0.wait_load - 1
			end)
		end
	end

	function var_157_0:startAction()
		for iter_163_0 = 1, 3 do
			self.points[iter_163_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_163_0 - 1) * 0.2), cc.JumpBy:create(0.2, cc.p(0, 0), 8, 1), cc.DelayTime:create(3 * 0.2 + 0.5 - (iter_163_0 - 1) * 0.2))))
		end

		self.wait_ani = false
	end

	function var_157_0:loadEnding()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			if arg_157_3 then
				arg_157_3()
			end

			for iter_165_0 = 1, 3 do
				self.points[iter_165_0]:stopAllActions()
			end
		end), cc.RemoveSelf:create()))
	end

	var_157_0:initUI()
	var_157_0:startScheduler()
	var_157_0:startLoading()
	var_157_0:startAction()
end

function ExploreMapLayer.removeCachedTextured(arg_166_0, arg_166_1, arg_166_2, arg_166_3)
	local var_166_0 = explore_manager.getCurData("map", arg_166_1)
	local var_166_1 = arg_166_3 and var_166_0[arg_166_3].fullImage or var_166_0[arg_166_2].fullImage

	for iter_166_0, iter_166_1 in pairs({
		"tilemap/tiles_" .. var_166_1 .. ".plist",
		"tilemap/tilebg.plist"
	}) do
		if iter_166_1:find(".png") then
			cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_166_1)
		elseif iter_166_1:find(".plist") then
			cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(iter_166_1)
			cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_166_1:match("(.+).plist") .. ".png")
		end
	end
end

function ExploreMapLayer:initTouchMark()
	self.touchMark = ccui.ImageView:create("explore/touch_mark1.png", var_0_0)

	self.touchMark:setVisible(false)
	self.iconLayout:addChild(self.touchMark, 999)

	local var_167_0 = ccui.ImageView:create("explore/touch_mark2.png", var_0_0)

	var_167_0:setName("mark2")
	var_167_0:setPosition(self.touchMark:getContentSize().width / 2, self.touchMark:getContentSize().height / 2)
	self.touchMark:addChild(var_167_0)
end

function ExploreMapLayer:setTouchMarkPos(arg_168_1, arg_168_2, arg_168_3, arg_168_4, arg_168_5)
	self.touchMark:stopAllActions()
	self.touchMark:setVisible(true)
	self.touchMark:setOpacity(255)
	self.touchMark:getChildByName("mark2"):stopAllActions()
	self.touchMark:getChildByName("mark2"):setOpacity(0)
	self.touchMark:getChildByName("mark2"):setScale(1)
	self.touchMark:setPosition(arg_168_1)

	if arg_168_2 > 0 then
		self.touchMark:loadTexture("explore/touch_mark1.png", var_0_0)
		self.touchMark:getChildByName("mark2"):loadTexture("explore/touch_mark2.png", var_0_0)
	else
		self.touchMark:loadTexture("explore/no_touch_mark1.png", var_0_0)
		self.touchMark:getChildByName("mark2"):loadTexture("explore/no_touch_mark2.png", var_0_0)
	end

	self.touchMark.flag = arg_168_2
	self.touchMark.path = arg_168_3
	self.touchMark.curIndex = arg_168_4
	self.touchMark.targetIndex = arg_168_5
end

function ExploreMapLayer:playTouchMarkAction(arg_169_1)
	if not self.touchMark then
		return
	end

	local var_169_0 = self.touchMark:getChildByName("mark2")

	self.touchMark:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeOut:create(0.2)))
	var_169_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), cc.ScaleTo:create(0.3, 1.1)), cc.ScaleTo:create(0.2, 1)))

	if self.touchMark.curIndex and self.touchMark.curIndex ~= explore_manager.curMapConfig.curPosIndex then
		local var_169_1 = arg_169_1(self.touchMark.targetIndex)

		if var_169_1 then
			return 2, var_169_1
		else
			return -3
		end
	else
		return self.touchMark.flag, self.touchMark.path
	end
end

function ExploreMapLayer.initPlotMap(arg_170_0, arg_170_1, arg_170_2)
	local var_170_0 = {
		maptype = arg_170_1.finishParam1,
		mapdifficult = arg_170_2.mapdifficult,
		plotClassId = arg_170_1.plotClassId
	}

	LayerManager:pushInLayer("AdventurePreviewLayer", {
		previewType = "EXPLORE",
		mode = var_170_0.maptype,
		level = arg_170_2.mapdifficult,
		surecallback = function(arg_171_0)
			var_170_0.array = arg_171_0

			local var_171_0 = var_170_0.maptype
			local var_171_1 = explore_manager.exploreConfigs[var_170_0.maptype].maplevel

			explore_manager:gen_plot_map_info(var_170_0, function(arg_172_0)
				if arg_172_0 < 3 then
					arg_170_0:switchMapType(arg_172_0, var_171_0, var_171_1)
				elseif arg_172_0 == 5 then
					arg_170_0:removeMap(var_170_0.maptype)
				end

				ListButtonLayer.getInstance():showLayer()

				if arg_170_2 and arg_170_2.lock then
					arg_170_2.lock = false
				end
			end)
		end,
		exitcallback = function()
			ListButtonLayer.getInstance():showLayer()

			if arg_170_2 and arg_170_2.lock then
				arg_170_2.lock = false
			end
		end
	})
end

function ExploreMapLayer.popTalkSp(arg_174_0, arg_174_1, arg_174_2, arg_174_3)
	return
end

function ExploreMapLayer:getCurPos(arg_175_1, arg_175_2)
	local var_175_0 = self.layout:getContentSize()

	return cc.p((arg_175_1 - (self.room_WIDTH_num + 1) / 2) * 100 + var_175_0.width / 2, (arg_175_2 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_175_0.height / 2)
end

function ExploreMapLayer:genMap()
	local var_176_9000

	for iter_176_0, iter_176_1 in pairs(explore_manager.curMapConfig.path_tree) do
		if iter_176_1.root == -1 then
			self.curRoomOrder = iter_176_0

			break
		end
	end

	self.exploredRooms = {
		[self.curRoomOrder] = true
	}

	local var_176_0 = var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]]

	self.room_WIDTH_num, self.room_HEIGHT_num = var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width + 2, var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].height + 2

	local var_176_1 = cc.size(100 * self.room_WIDTH_num, 100 * self.room_HEIGHT_num)

	if var_176_1.width > 800 then
		var_176_1.width = var_176_1.width or 800
	end

	if var_176_1.height > 1420 then
		var_176_1.height = var_176_1.width or 1420
	end

	self.mapView:setInnerContainerSize(var_176_1)
	self.mapView:getInnerContainer():setScale(var_0_57)
	self.mapView:getInnerContainer().runAction(self.mapView:getInnerContainer():getBoundingBox().height, cc.MoveTo:create(0.01, cc.p((self.mapView:getContentSize().width - self.mapView:getInnerContainer():getBoundingBox().width) / 2, (self.mapView:getContentSize().height - var_176_9000) / 2)))

	self.clipLayout = ccui.Layout:create()

	self.clipLayout:setTouchEnabled(false)
	self.clipLayout:setContentSize(cc.size(var_176_0.width * 100, var_176_0.height * 100))
	self.clipLayout:setPosition((var_176_1.width - var_176_0.width * 100) / 2, (var_176_1.height - var_176_0.height * 100) / 2)
	self.clipLayout:setClippingEnabled(false)
	self.mapView:addChild(self.clipLayout)

	self.layout = ccui.Layout:create()

	self.layout:setTouchEnabled(false)
	self.layout:setPosition(-((var_176_1.width - var_176_0.width * 100) / 2), -((var_176_1.height - var_176_0.height * 100) / 2))
	self.layout:setContentSize(var_176_1)
	self.clipLayout:addChild(self.layout, 2)
	self:genRoomMap()
	self:registerTouchEvent()
	self:initSmallMap()
end

function ExploreMapLayer:genRoomMap()
	self.batchNodeLayout = cc.SpriteBatchNode:create("tilemap/tiles_" .. var_0_26[self.curMapFloor].fullImage .. ".png")

	self.batchNodeLayout:setPosition(0, 0)
	self.layout:addChild(self.batchNodeLayout)

	self.maskPanel = ccui.Layout:create()

	self.layout:addChild(self.maskPanel)

	self.iconLayout = ccui.Layout:create()

	self.iconLayout:setPosition(0, 0)
	self.layout:addChild(self.iconLayout)
	self:initSelectedFrame()
	self:initTouchMark()

	local var_177_0 = self.layout:getContentSize()

	for iter_177_0 = 1, var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width * var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].height do
		local var_177_1 = math.floor((iter_177_0 - 1) / var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width) + 2

		for iter_177_1, iter_177_2 in ipairs(var_0_28[var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].imglayer][iter_177_0]) do
			local var_177_2 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_26[self.curMapFloor].fullImage .. "/" .. iter_177_2 .. ".png")

			var_177_2:setPosition(((iter_177_0 - 1) % var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width + 2 - (self.room_WIDTH_num + 1) / 2) * 100 + var_177_0.width / 2, (var_177_1 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_177_0.height / 2)
			var_177_2:setLocalZOrder(iter_177_1)

			if explore_img_data[iter_177_2].is_big_icon then
				var_177_2:setAnchorPoint(cc.p(0.5, 0))
				var_177_2:setPosition(((iter_177_0 - 1) % var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width + 2 - (self.room_WIDTH_num + 1) / 2) * 100 + var_177_0.width / 2, (var_177_1 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_177_0.height / 2 - 50)
				self.iconLayout:addChild(var_177_2, self.room_HEIGHT_num - var_177_1 + 1)
			else
				self.batchNodeLayout:addChild(var_177_2)
			end
		end
	end

	for iter_177_3 = 1, self.room_WIDTH_num * self.room_HEIGHT_num do
		local var_177_3 = var_0_29[explore_manager.curMapConfig.objectmodels[self.curRoomOrder][iter_177_3]]

		assert(var_0_29[explore_manager.curMapConfig.objectmodels[self.curRoomOrder][iter_177_3]], explore_manager.curMapConfig.objectmodels[self.curRoomOrder][iter_177_3])

		local var_177_4 = math.floor((iter_177_3 - 1) / self.room_WIDTH_num) + 1
		local var_177_5 = ((iter_177_3 - 1) % self.room_WIDTH_num + 1 - (self.room_WIDTH_num + 1) / 2) * 100 + var_177_0.width / 2
		local var_177_6 = (var_177_4 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_177_0.height / 2

		if var_177_3.icon or var_0_49[var_177_3.class] then
			if var_0_49[var_177_3.class] and explore_manager.curMapConfig.usedTile[self.curRoomOrder][iter_177_3].usedcount == 0 then
				assert(var_0_30[var_177_3["result" .. 1 .. "_param"]], var_177_3["result" .. 1 .. "_param"])
				assert(var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team, var_177_3["result" .. 1 .. "_param"])
				assert(var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team], var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team)
				assert(var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon, var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team)
				assert(var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon, var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team)
				assert(model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon], var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon)

				local var_177_8 = var_0_56
				local var_177_9 = cc.size(model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon].modelweight, model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon].modelheight)
				local var_177_10 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon].spine_model .. ".atlas", (model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_0_31[var_0_30[var_177_3["result" .. 1 .. "_param"]].boss_team].boss_icon].clothes_model .. ".atlas" or nil))

				var_177_10:setScale(var_177_8, var_177_8)
				var_177_10:setContentSize(var_177_9)
				var_177_10:playAni(nil, "idle", true)
				var_177_10:setPosition(var_177_5, var_177_6)
				var_177_10:setName(iter_177_3 .. "icon")
				self.iconLayout:addChild(var_177_10, self.room_HEIGHT_num - var_177_4 + 1)

				if var_0_48[var_177_3.class] then
					local var_177_11

					if config._DEBUG then
						var_177_11 = cc.Sprite:create(var_0_48[var_177_3.class]) or cc.Sprite:createWithSpriteFrameName(var_0_48[var_177_3.class])
					end

					var_177_11:setAnchorPoint(cc.p(0.5, 1))
					var_177_11:setScale(var_177_10:getContentSize().width / 160)
					var_177_11:setPosition(var_177_10:getContentSize().width / 2, var_177_10:getContentSize().height)
					var_177_10:addChild(var_177_11)
				end
			elseif var_177_3.is_big_icon then
				local var_177_12 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_26[self.curMapFloor].fullImage .. "/" .. var_177_3.icon .. ".png")

				var_177_12:setName(iter_177_3 .. "icon")
				var_177_12:setAnchorPoint(cc.p(0.5, 0))

				if var_177_3.is_shadow then
					var_177_12:setPosition(var_177_5, var_177_6)

					local var_177_13 = ccui.ImageView:create("explore/shadow.png", var_0_0)

					var_177_13:setScale(0.9)
					var_177_13:setPosition(var_177_5, var_177_6 - 10)
					self.iconLayout:addChild(var_177_13, self.room_HEIGHT_num - var_177_4 + 1)

					var_177_12.shadow = var_177_13
				else
					var_177_12:setPosition(var_177_5, var_177_6 - 50)
				end

				self.iconLayout:addChild(var_177_12, self.room_HEIGHT_num - var_177_4 + 1)
			else
				local var_177_14 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_26[self.curMapFloor].fullImage .. "/" .. var_177_3.icon .. ".png")

				var_177_14:setPosition(var_177_5, var_177_6)
				var_177_14:setName(index .. "icon")
				self.iconLayout:addChild(var_177_14, self.room_HEIGHT_num - var_177_4 + 1)
			end
		end
	end

	for iter_177_4, iter_177_5 in pairs(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range) do
		for iter_177_6, iter_177_7 in pairs(iter_177_5) do
			local var_177_17
			local var_177_16

			if not self.maskPanel:getChildByName("maskPanel" .. iter_177_7) then
				local var_177_15 = ccui.Layout:create()

				var_177_15:setClippingEnabled(false)
				var_177_15:setName("maskPanel" .. iter_177_7)
				self.maskPanel:addChild(var_177_15, 1)

				var_177_16 = math.floor((iter_177_4 - 1) / self.room_WIDTH_num) + 1
				var_177_17 = ccui.ImageView:create("explore/red_mask.png", var_0_0)
			end

			var_177_17:setPosition(((iter_177_4 - 1) % self.room_WIDTH_num + 1 - (self.room_WIDTH_num + 1) / 2) * 100 + var_177_0.width / 2, (var_177_16 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_177_0.height / 2)
			self.maskPanel:getChildByName("maskPanel" .. iter_177_7):addChild(var_177_17)
		end
	end
end

function ExploreMapLayer:registerTouchEvent()
	local var_178_2 = (self.layout:getContentSize().width - self.room_WIDTH_num * 100) / 2
	local var_178_3 = (self.layout:getContentSize().width + self.room_WIDTH_num * 100) / 2
	local var_178_4 = (self.layout:getContentSize().height - self.room_HEIGHT_num * 100) / 2
	local var_178_5 = (self.layout:getContentSize().height + self.room_HEIGHT_num * 100) / 2
	local var_178_6 = explore_manager.curMapConfig.objectmodels[self.curRoomOrder]

	local function var_178_7(arg_179_0, arg_179_1)
		local var_179_0 = math.floor((arg_179_0 - 1) / self.room_WIDTH_num) + 1
		local var_179_1

		if arg_179_1 == var_0_40 then
			var_179_1 = arg_179_0 + self.room_WIDTH_num

			if var_179_0 == self.room_HEIGHT_num then
				var_179_1 = nil
			end
		elseif arg_179_1 == var_0_41 then
			var_179_1 = arg_179_0 + 1

			if (arg_179_0 - 1) % self.room_WIDTH_num + 1 == self.room_WIDTH_num then
				var_179_1 = nil
			end
		elseif arg_179_1 == var_0_42 then
			var_179_1 = arg_179_0 - self.room_WIDTH_num

			if var_179_0 == 1 then
				var_179_1 = nil
			end
		elseif arg_179_1 == var_0_43 then
			var_179_1 = arg_179_0 - 1

			if (arg_179_0 - 1) % self.room_WIDTH_num + 1 == 1 then
				var_179_1 = nil
			end
		end

		return var_179_1
	end

	local function var_178_8(arg_180_0)
		if var_0_29[var_178_6[arg_180_0]].class == var_0_46.DES_WALL then
			return false
		end

		if not explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_180_0] then
			return true
		end

		if var_0_29[var_178_6[arg_180_0]].trigger_count > 0 and explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_180_0].usedcount >= var_0_29[var_178_6[arg_180_0]].trigger_count then
			return true
		else
			return false
		end
	end

	local function var_178_9(arg_181_0)
		if explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[arg_181_0] then
			return false
		elseif var_0_29[var_178_6[arg_181_0]].is_block == 1 then
			if var_0_29[var_178_6[arg_181_0]].is_touch == 1 then
				return var_178_8(arg_181_0)
			else
				return false
			end
		else
			return true
		end
	end

	local function var_178_10(arg_182_0, arg_182_1)
		local var_182_0 = 480

		self.layout:stopActionByTag(480)

		local var_182_1 = self.tag:getPositionX()
		local var_182_2 = self.tag:getPositionY()

		local function var_182_3(arg_183_0, arg_183_1)
			if math.abs(arg_183_0 - arg_183_1) == 1 then
				return "x"
			elseif math.abs(arg_183_0 - arg_183_1) == self.room_WIDTH_num then
				return "y"
			else
				print(arg_183_0, arg_183_1, arg_183_0 - arg_183_1)
			end
		end

		local var_182_4 = var_182_3(explore_manager.curMapConfig.curPosIndex, arg_182_0[1])
		local var_182_5 = 1
		local var_182_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			local var_184_0 = arg_182_0[var_182_5]
			local var_184_1 = math.floor((arg_182_0[var_182_5] - 1) / self.room_WIDTH_num) + 1
			local var_184_2 = self:getCurPos((arg_182_0[var_182_5] - 1) % self.room_WIDTH_num + 1, var_184_1)
			local var_184_3 = var_184_2.x
			local var_184_4 = var_184_2.y
			local var_184_5 = self.tag:getPositionX()
			local var_184_6 = self.tag:getPositionY()
			local var_184_7 = self.layout:getContentSize().width * var_0_57 - 640
			local var_184_8 = self.layout:getContentSize().height * var_0_57 - 1136

			if cc.rectContainsPoint(cc.rect(var_184_2.x - 50, var_184_2.y - 50, 100, 100), cc.p(var_184_5, var_184_6)) and var_184_0 ~= explore_manager.curMapConfig.curPosIndex then
				curPos = cc.p((arg_182_0[var_182_5] - 1) % self.room_WIDTH_num + 1, var_184_1)
				explore_manager.curMapConfig.curPosIndex = var_184_0
			end

			if var_182_4 and var_182_4 == "x" or not var_182_4 then
				if var_182_5 == #arg_182_0 then
					if var_184_5 == var_184_3 and var_184_6 == var_184_4 then
						if var_182_5 == #arg_182_0 then
							if arg_182_1 then
								arg_182_1()
							end

							self.layout:stopActionByTag(var_182_0)
							self:playAni("idle")

							return
						end

						var_182_5 = var_182_5 + 1
						var_182_4 = var_182_3(explore_manager.curMapConfig.curPosIndex, arg_182_0[var_182_5])
					elseif var_184_5 ~= var_184_3 then
						local var_184_9 = math.abs(var_184_3 - var_184_5) < 0.016666666666666666 * var_182_0 and math.abs(var_184_3 - var_184_5) or 0.016666666666666666 * var_182_0
						local var_184_10 = (var_184_3 - var_184_5) / math.abs(var_184_3 - var_184_5)

						var_184_5 = var_184_5 + var_184_10 * var_184_9

						if var_184_10 ~= self.tag.dir then
							self.tag:setScale(var_184_10 * var_0_56, var_0_56)
						end
					elseif var_184_6 ~= var_184_4 then
						var_184_6 = var_184_6 + (var_184_4 - var_184_6) / math.abs(var_184_4 - var_184_6) * (math.abs(var_184_4 - var_184_6) < 0.016666666666666666 * var_182_0 and math.abs(var_184_4 - var_184_6) or 0.016666666666666666 * var_182_0)
					end
				elseif var_184_5 == var_184_3 and explore_manager.curMapConfig.curPosIndex == var_184_0 then
					if var_182_5 == #arg_182_0 then
						if arg_182_1 then
							arg_182_1()
						end

						self.layout:stopActionByTag(var_182_0)
						self:playAni("idle")

						return
					end

					var_182_5 = var_182_5 + 1
					var_182_4 = var_182_3(explore_manager.curMapConfig.curPosIndex, arg_182_0[var_182_5])
				elseif var_184_5 ~= var_184_3 then
					local var_184_12 = math.abs(var_184_3 - var_184_5) < 0.016666666666666666 * var_182_0 and math.abs(var_184_3 - var_184_5) or 0.016666666666666666 * var_182_0
					local var_184_13 = (var_184_3 - var_184_5) / math.abs(var_184_3 - var_184_5)

					var_184_5 = var_184_5 + var_184_13 * var_184_12

					if var_184_13 ~= self.tag.dir then
						self.tag:setScale(var_184_13 * var_0_56, var_0_56)
					end
				elseif var_184_6 ~= var_184_4 then
					var_184_6 = var_184_6 + (var_184_4 - var_184_6) / math.abs(var_184_4 - var_184_6) * (math.abs(var_184_4 - var_184_6) < 0.016666666666666666 * var_182_0 and math.abs(var_184_4 - var_184_6) or 0.016666666666666666 * var_182_0)
				end
			elseif var_182_4 and var_182_4 == "y" then
				if var_182_5 == #arg_182_0 then
					if var_184_5 == var_184_3 and var_184_6 == var_184_4 then
						if var_182_5 == #arg_182_0 then
							if arg_182_1 then
								arg_182_1()
							end

							self.layout:stopActionByTag(var_182_0)
							self:playAni("idle")

							return
						end

						var_182_5 = var_182_5 + 1
						var_182_4 = var_182_3(explore_manager.curMapConfig.curPosIndex, arg_182_0[var_182_5])
					elseif var_184_6 ~= var_184_4 then
						var_184_6 = var_184_6 + (var_184_4 - var_184_6) / math.abs(var_184_4 - var_184_6) * (math.abs(var_184_4 - var_184_6) < 0.016666666666666666 * var_182_0 and math.abs(var_184_4 - var_184_6) or 0.016666666666666666 * var_182_0)
					elseif var_184_5 ~= var_184_3 then
						local var_184_16 = math.abs(var_184_3 - var_184_5) < 0.016666666666666666 * var_182_0 and math.abs(var_184_3 - var_184_5) or 0.016666666666666666 * var_182_0
						local var_184_17 = (var_184_3 - var_184_5) / math.abs(var_184_3 - var_184_5)

						var_184_5 = var_184_5 + var_184_17 * var_184_16

						if var_184_17 ~= self.tag.dir then
							self.tag:setScale(var_184_17 * var_0_56, var_0_56)
						end
					end
				elseif var_184_6 == var_184_4 and explore_manager.curMapConfig.curPosIndex == var_184_0 then
					if var_182_5 == #arg_182_0 then
						if arg_182_1 then
							arg_182_1()
						end

						self.layout:stopActionByTag(var_182_0)
						self:playAni("idle")

						return
					end

					var_182_5 = var_182_5 + 1
					var_182_4 = var_182_3(explore_manager.curMapConfig.curPosIndex, arg_182_0[var_182_5])
				elseif var_184_6 ~= var_184_4 then
					var_184_6 = var_184_6 + (var_184_4 - var_184_6) / math.abs(var_184_4 - var_184_6) * (math.abs(var_184_4 - var_184_6) < 0.016666666666666666 * var_182_0 and math.abs(var_184_4 - var_184_6) or 0.016666666666666666 * var_182_0)
				elseif var_184_5 ~= var_184_3 then
					local var_184_19 = math.abs(var_184_3 - var_184_5) < 0.016666666666666666 * var_182_0 and math.abs(var_184_3 - var_184_5) or 0.016666666666666666 * var_182_0
					local var_184_20 = (var_184_3 - var_184_5) / math.abs(var_184_3 - var_184_5)

					var_184_5 = var_184_5 + var_184_20 * var_184_19

					if var_184_20 ~= self.tag.dir then
						self.tag:setScale(var_184_20 * var_0_56, var_0_56)
					end
				end
			end

			self.tag:setPosition(var_184_5, var_184_6)
			self.tag:setLocalZOrder(self.room_HEIGHT_num - var_184_1 + 1)
		end)))

		var_182_6:setTag(480)
		self.layout:runAction(var_182_6)
		self:playAni("run")
	end

	local function var_178_11(arg_185_0)
		if self.layout:getChildByName("testLayout") then
			self.layout:getChildByName("testLayout"):removeAllChildren()
		end

		local var_185_0 = explore_manager.curMapConfig.curPosIndex
		local var_185_1 = cc.p((explore_manager.curMapConfig.curPosIndex - 1) % self.room_WIDTH_num + 1, math.floor((explore_manager.curMapConfig.curPosIndex - 1) / self.room_WIDTH_num) + 1)
		local var_185_2 = cc.p((arg_185_0 - 1) % self.room_WIDTH_num + 1, math.floor((arg_185_0 - 1) / self.room_WIDTH_num) + 1)
		local var_185_3 = {
			{
				index = explore_manager.curMapConfig.curPosIndex
			}
		}
		local var_185_4 = {
			[explore_manager.curMapConfig.curPosIndex] = 1
		}
		local var_185_5 = {}
		local var_185_6 = {
			[explore_manager.curMapConfig.curPosIndex] = -1
		}

		local function var_185_7(arg_186_0, arg_186_1, arg_186_2, arg_186_3)
			if not var_0_51 then
				return
			end

			local var_186_0 = self.layout:getChildByName("testLayout")

			if not var_186_0 then
				var_186_0 = ccui.Layout:create()

				var_186_0:setName("testLayout")
				self.layout:addChild(var_186_0)
			end

			self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_186_3), cc.CallFunc:create(function()
				local var_187_0 = ccui.ImageView:create("public/box/UI_smeltScene_equipOn.png", var_0_0)

				var_187_0:setName("test" .. arg_186_0)
				var_187_0:setPosition(var_0_53 + ((arg_186_0 - 1) % self.room_WIDTH_num + 1 - 1) * 100, var_0_54 + (math.floor((arg_186_0 - 1) / self.room_WIDTH_num) + 1 - 1) * 100)
				var_186_0:addChild(var_187_0, 1)

				local var_187_1 = cc.Label:createWithTTF("G: " .. arg_186_1, FONT_NAME, 20)

				var_187_1:setName("G_label")
				var_187_1:setColor(cc.c3b(0, 0, 0))
				var_187_1:setAnchorPoint(cc.p(0, 0.5))
				var_187_1:setPosition(0, 30)
				var_187_0:addChild(var_187_1)

				local var_187_2 = cc.Label:createWithTTF("H: " .. arg_186_2, FONT_NAME, 20)

				var_187_2:setName("H_label")
				var_187_2:setColor(cc.c3b(0, 0, 0))
				var_187_2:setAnchorPoint(cc.p(0, 0.5))
				var_187_2:setPosition(0, 60)
				var_187_0:addChild(var_187_2)

				local var_187_3 = cc.Label:createWithTTF("F: " .. arg_186_2 + arg_186_1, FONT_NAME, 20)

				var_187_3:setName("F_label")
				var_187_3:setColor(cc.c3b(0, 0, 0))
				var_187_3:setAnchorPoint(cc.p(0, 0.5))
				var_187_3:setPosition(0, 90)
				var_187_0:addChild(var_187_3)
			end)))
		end

		local function var_185_8(arg_188_0, arg_188_1, arg_188_2, arg_188_3)
			if not var_0_51 then
				return
			end

			if not self.layout:getChildByName("testLayout") then
				return
			end

			self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_188_3), cc.CallFunc:create(function()
				local var_189_0 = self.layout:getChildByName("testLayout"):getChildByName("test" .. arg_188_0)

				var_189_0:getChildByName("G_label"):setString("G:" .. arg_188_1)
				var_189_0:getChildByName("H_label"):setString("H:" .. arg_188_2)
				var_189_0:getChildByName("F_label"):setString("F:" .. arg_188_2 + arg_188_1)
			end)))
		end

		local function var_185_9(arg_190_0, arg_190_1)
			if not var_0_51 then
				return
			end

			self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_190_1), cc.CallFunc:create(function()
				if not self.layout:getChildByName("testLayout") then
					return
				end

				if not self.layout:getChildByName("testLayout"):getChildByName("test" .. arg_190_0) then
					return
				end

				self.layout:getChildByName("testLayout"):getChildByName("test" .. arg_190_0):setColor(cc.c3b(100, 0, 0))
			end)))
		end

		local function var_185_10(arg_192_0)
			if not var_185_6[arg_192_0] then
				return
			end

			local var_192_0 = 1
			local var_192_1 = arg_192_0

			while var_185_6[arg_192_0] > 0 do
				var_192_0 = var_192_0 + 1
				var_192_1 = var_185_6[arg_192_0]
			end

			return var_192_0
		end

		local function var_185_11(arg_193_0)
			local var_193_0 = math.floor((arg_193_0 - 1) / self.room_WIDTH_num) + 1
			local var_193_1 = math.sqrt(math.abs((arg_193_0 - 1) % self.room_WIDTH_num + 1 - var_185_2.x) * math.abs((arg_193_0 - 1) % self.room_WIDTH_num + 1 - var_185_2.x) + math.abs(var_193_0 - var_185_2.y) * math.abs(var_193_0 - var_185_2.y))

			return (math.abs((arg_193_0 - 1) % self.room_WIDTH_num + 1 - var_185_2.x) + math.abs(var_193_0 - var_185_2.y)) * 1.01
		end

		local function var_185_12()
			var_185_4 = {}

			for iter_194_0, iter_194_1 in pairs(var_185_3) do
				var_185_4[iter_194_1.index] = iter_194_0
			end
		end

		local function var_185_13(arg_195_0, arg_195_1)
			var_185_3[arg_195_0], var_185_3[arg_195_1] = var_185_3[arg_195_1], var_185_3[arg_195_0]
		end

		local function var_185_14()
			local var_196_0 = 0

			while 1 * 2 <= #var_185_3 and not false do
				var_196_0 = var_185_3[1].F_value > var_185_3[1 * 2].F_value and 1 * 2 or 1

				if 1 * 2 + 1 <= #var_185_3 and var_185_3[var_196_0].F_value > var_185_3[1 * 2 + 1].F_value then
					var_196_0 = 1 * 2 + 1
				end

				local var_196_1, var_196_2

				if var_196_0 ~= 1 then
					var_185_13(var_196_0, 1)

					var_196_1 = var_196_0
				else
					var_196_2 = true
				end
			end
		end

		local function var_185_15()
			if #var_185_3 == 1 then
				return
			end

			local var_197_0 = #var_185_3

			::label_197_0::

			while var_197_0 ~= 1 and not false do
				if var_197_0 % 2 == 0 then
					local var_197_1 = var_197_0 / 2 or (var_197_0 - 1) / 2

					if var_185_3[var_197_0].F_value < var_185_3[var_197_1].F_value then
						var_185_13(var_197_0, var_197_1)

						var_197_0 = var_197_1

						goto label_197_0
					end
				end
			end
		end

		local function var_185_16(arg_198_0, arg_198_1, arg_198_2)
			var_185_3[#var_185_3 + 1] = {
				index = arg_198_0,
				G_value = arg_198_1,
				H_value = arg_198_2,
				F_value = arg_198_1 + arg_198_2
			}

			var_185_15()
			var_185_12()
		end

		local function var_185_17()
			var_185_3[1] = var_185_3[#var_185_3]
			var_185_3[#var_185_3] = nil

			var_185_14()
			var_185_12()
		end

		if var_178_6[arg_185_0] == 203 then
			local var_185_18 = {}
			local var_185_19 = false
			local var_185_20 = 0

			local function var_185_21(arg_200_0)
				local var_200_0 = math.floor((arg_185_0 - 1) / self.room_WIDTH_num) + 1
				local var_200_1 = math.floor((arg_200_0 - 1) / self.room_WIDTH_num) + 1

				if (arg_185_0 - 1) % self.room_WIDTH_num + 1 == 1 then
					if (arg_200_0 - 1) % self.room_WIDTH_num + 1 == (arg_185_0 - 1) % self.room_WIDTH_num + 1 then
						return true
					end
				elseif (arg_185_0 - 1) % self.room_WIDTH_num + 1 == self.room_WIDTH_num then
					if (arg_200_0 - 1) % self.room_WIDTH_num + 1 == (arg_185_0 - 1) % self.room_WIDTH_num + 1 then
						return true
					end
				elseif var_200_0 == 1 then
					if var_200_1 == var_200_0 then
						return true
					end
				elseif var_200_0 == self.room_HEIGHT_num and var_200_1 == var_200_0 then
					return true
				end
			end

			while next(var_185_3) ~= nil do
				var_185_9(var_185_3[1].index, var_185_20 * 0.01)
				var_185_17()

				var_185_5[var_185_3[1].index] = 1

				for iter_185_0 = 1, 4 do
					local var_185_22 = var_178_7(var_185_3[1].index, iter_185_0)

					if var_185_22 then
						if not var_185_21(var_185_22) then
							if var_178_9(var_185_22) and not var_185_5[var_185_22] then
								if var_185_4[var_185_22] then
									indexInfo = var_185_3[var_185_4[var_185_22]]

									local var_185_23 = var_185_10(var_185_3[1].index) + 1

									if var_185_23 < indexInfo.G_value then
										indexInfo.G_value = var_185_23
										indexInfo.F_value = var_185_23 + var_185_11(var_185_22)
										var_185_6[var_185_22] = var_185_3[1].index

										var_185_8(var_185_22, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_22), var_185_20 * 0.01)
									end
								else
									var_185_7(var_185_22, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_22), var_185_20 * 0.01)

									var_185_20 = var_185_20 + 1

									var_185_16(var_185_22, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_22))

									var_185_6[var_185_22] = var_185_3[1].index
								end
							end
						else
							var_185_19 = true
							var_185_18 = {
								var_185_22
							}
							var_185_6[var_185_22] = var_185_3[1].index

							local var_185_24 = var_185_22

							while var_185_6[var_185_24] ~= var_185_0 do
								table.insert(var_185_18, 1, var_185_6[var_185_24])

								var_185_24 = var_185_6[var_185_24]
							end

							break
						end
					end
				end

				if var_185_19 then
					return var_185_18
				end
			end

			if var_185_19 == false then
				return
			end
		elseif var_0_29[var_178_6[arg_185_0]].trigger_range == 1 and not var_178_8(arg_185_0) then
			local var_185_25 = {}
			local var_185_26 = false
			local var_185_27 = 0
			local var_185_28 = {}

			for iter_185_1, iter_185_2 in pairs(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].center[arg_185_0]) do
				var_185_28[iter_185_2] = true
			end

			while next(var_185_3) ~= nil do
				var_185_9(var_185_3[1].index, var_185_27 * 0.01)
				var_185_17()

				var_185_5[var_185_3[1].index] = 1

				for iter_185_3 = 1, 4 do
					local var_185_29 = var_178_7(var_185_3[1].index, iter_185_3)

					if var_185_29 then
						if not var_185_28[var_185_29] then
							if var_178_9(var_185_29) and not var_185_5[var_185_29] then
								if var_185_4[var_185_29] then
									indexInfo = var_185_3[var_185_4[var_185_29]]

									local var_185_30 = var_185_10(var_185_3[1].index) + 1

									if var_185_30 < indexInfo.G_value then
										indexInfo.G_value = var_185_30
										indexInfo.F_value = var_185_30 + var_185_11(var_185_29)
										var_185_6[var_185_29] = var_185_3[1].index

										var_185_8(var_185_29, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_29), var_185_27 * 0.01)
									end
								else
									var_185_7(var_185_29, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_29), var_185_27 * 0.01)

									var_185_27 = var_185_27 + 1

									var_185_16(var_185_29, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_29))

									var_185_6[var_185_29] = var_185_3[1].index
								end
							end
						else
							var_185_26 = true
							var_185_25 = {
								var_185_29
							}
							var_185_6[var_185_29] = var_185_3[1].index

							local var_185_31 = var_185_29

							while var_185_6[var_185_31] ~= var_185_0 do
								table.insert(var_185_25, 1, var_185_6[var_185_31])

								var_185_31 = var_185_6[var_185_31]
							end

							break
						end
					end
				end

				if var_185_26 then
					return var_185_25
				end
			end

			if var_185_26 == false then
				return
			end
		else
			local var_185_32 = {
				arg_185_0
			}
			local var_185_33 = false
			local var_185_34 = 0

			while next(var_185_3) ~= nil do
				var_185_9(var_185_3[1].index, var_185_34 * 0.01)
				var_185_17()

				var_185_5[var_185_3[1].index] = 1

				for iter_185_4 = 1, 4 do
					local var_185_35 = var_178_7(var_185_3[1].index, iter_185_4)

					if var_185_35 then
						if var_185_35 ~= arg_185_0 then
							if var_178_9(var_185_35) and not var_185_5[var_185_35] then
								if var_185_4[var_185_35] then
									indexInfo = var_185_3[var_185_4[var_185_35]]

									local var_185_36 = var_185_10(var_185_3[1].index) + 1

									if var_185_36 < indexInfo.G_value then
										indexInfo.G_value = var_185_36
										indexInfo.F_value = var_185_36 + var_185_11(var_185_35)
										var_185_6[var_185_35] = var_185_3[1].index

										var_185_8(var_185_35, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_35), var_185_34 * 0.01)
									end
								else
									var_185_7(var_185_35, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_35), var_185_34 * 0.01)

									var_185_34 = var_185_34 + 1

									var_185_16(var_185_35, var_185_10(var_185_3[1].index) + 1, var_185_11(var_185_35))

									var_185_6[var_185_35] = var_185_3[1].index
								end
							end
						else
							var_185_33 = true
							var_185_6[var_185_35] = var_185_3[1].index

							local var_185_37 = arg_185_0

							while var_185_6[var_185_37] ~= var_185_0 do
								table.insert(var_185_32, 1, var_185_6[var_185_37])

								var_185_37 = var_185_6[var_185_37]
							end

							break
						end
					end
				end

				if var_185_33 then
					return var_185_32
				end
			end

			if var_185_33 == false then
				return
			end
		end
	end

	local function var_178_12(arg_201_0)
		if self.touchLock then
			return
		end

		self.touchLock = true

		local var_201_0 = var_0_29[var_178_6[arg_201_0]]

		local function var_201_1(arg_203_0, arg_203_1, arg_203_2)
			if var_201_0.class == 5 then
				if arg_203_2 then
					arg_203_2()
				end

				return
			end

			local var_203_0 = {
				labels = {
					title = "探险信息",
					des = arg_203_0
				},
				surecallback = arg_203_2,
				cancelcallback = arg_203_2
			}

			if arg_203_1 == var_0_50.DEAD then
				var_203_0.labels = {
					des = "死球啦!从来吧!",
					title = "探险信息"
				}
			end

			self:addChild(PopLayer:Do(var_203_0), 999)
		end

		local function var_201_2(arg_204_0, arg_204_1)
			local function var_204_0()
				if var_201_0.class == var_0_46.DES_WALL then
					self.touchLock = false

					return
				end

				local var_205_0
				local var_205_1
				local var_205_2

				if arg_204_0 then
					var_205_0 = arg_204_0.type
					var_205_1 = arg_204_0.param
					var_205_2 = arg_204_0.des
				end

				if var_205_0 == var_0_50.FIGHT then
					local var_205_3 = curMapOtherInfo.maptype

					explore_manager:beginExploreFight(var_205_1)
					explore_manager:setFightFinishCallback(function(arg_206_0, arg_206_1)
						explore_manager:trigger_event(curMapOtherInfo.maptype, arg_201_0, var_178_6[arg_201_0], var_205_0, var_205_1, arg_206_1, function(arg_207_0)
							if arg_207_0.result >= 0 then
								if arg_207_0.result == var_0_50.FIGHT then
									self:updateHPUI()
									updateTile(arg_201_0)
									self:updateRangeModel(arg_201_0)
								elseif arg_207_0.result == 0 then
									self:resetCurMap(curMapType, curMapFloor, plotMapId)
								end

								local var_207_0

								if arg_207_0.items and next(arg_207_0.items) ~= nil then
									local var_207_1 = {}

									for iter_207_0, iter_207_1 in pairs(arg_207_0.items) do
										table.insert(var_207_1, {
											dropid = iter_207_1.itemid,
											entityid = iter_207_1.entityid,
											dropNum = iter_207_1.itemcount
										})
									end

									local function var_207_2()
										self:popTalkSp(self.tag.modelid, arg_207_0.result, var_0_29[var_178_6[arg_201_0]].class)
									end

									local var_207_3 = {
										items = var_207_1,
										gold = arg_207_0.gold,
										diamond = arg_207_0.diamond,
										surecallback = var_207_2,
										cancelcallback = var_207_2
									}

									function var_207_0()
										LayerManager:pushInLayer("PopPurchaseResultLayer", var_207_3)
									end
								end

								if var_205_2 then
									var_201_1(var_205_2, arg_207_0.result, var_207_0)
								elseif var_207_0 then
									var_207_0()
								else
									self:popTalkSp(self.tag.modelid, arg_207_0.result, var_0_29[var_178_6[arg_201_0]].class)
								end
							elseif arg_207_0.result == -5 then
								self:removeMap(var_205_3)
								self:resetCurMap(curMapType, curMapFloor, plotMapId)
							end

							if arg_206_0 then
								arg_206_0()
							end

							self.touchLock = false
						end)
					end)
				else
					local var_205_4 = curMapOtherInfo.maplevel or 0
					local var_205_5 = curMapOtherInfo.maptype

					explore_manager:trigger_event(curMapOtherInfo.maptype, arg_201_0, var_178_6[arg_201_0], var_205_0, var_205_1, arg_204_1, function(arg_210_0)
						if arg_210_0.result >= 0 then
							if arg_210_0.result == var_0_50.ADD_HP then
								self:updateHPUI()
								updateTile(arg_201_0)
							elseif arg_210_0.result == var_0_50.SUB_HP then
								self:updateHPUI()
								updateTile(arg_201_0)
								self:playAni("hit", function()
									self:playAni("idle")
								end)
							elseif arg_210_0.result == var_0_50.GET_ITEM then
								updateTile(arg_201_0)
							elseif arg_210_0.result == var_0_50.GET_DROP then
								self:updateHPUI()
								updateTile(arg_201_0)
							elseif arg_210_0.result == var_0_50.NEXT_FLOOR then
								if not explore_manager.curMapConfig then
									self:updateMapCover(curMapType)
									self:resetCurMap(curMapType, curMapFloor, plotMapId)

									if var_205_4 ~= arg_210_0.config.maplevel then
										self.isPopExploreDifficult:getChildByName("scrollView").difficult = nil

										self.isPopExploreDifficult:switchDifficult(arg_210_0.config.maplevel <= 6 and 1 or arg_210_0.config.maplevel <= 12 and 2 or 3)
									end
								else
									self:goToNextFloor()
								end
							elseif arg_210_0.result == var_0_50.SHOP_BUFF then
								self:updateBuffUI()
								updateTile(arg_201_0)
							elseif arg_210_0.result == 0 then
								self:resetCurMap(curMapType, curMapFloor, plotMapId)
							elseif arg_210_0.result == var_0_50.NOTHING then
								updateTile(arg_201_0)
							elseif arg_210_0.result == var_0_50.SHOP_ITEM then
								updateTile(arg_201_0)
							end

							local var_210_1

							if arg_210_0.items and next(arg_210_0.items) ~= nil or arg_210_0.gold or arg_210_0.diamond then
								arg_210_0.items = arg_210_0.items or {}

								local var_210_2 = {}

								for iter_210_0, iter_210_1 in pairs(arg_210_0.items) do
									table.insert(var_210_2, {
										dropid = iter_210_1.itemid,
										entityid = iter_210_1.entityid,
										dropNum = iter_210_1.itemcount
									})
								end

								local function var_210_3()
									self:popTalkSp(self.tag.modelid, arg_210_0.result, var_0_29[var_178_6[arg_201_0]].class)
								end

								local var_210_4 = {
									items = var_210_2,
									gold = arg_210_0.gold,
									diamond = arg_210_0.diamond,
									surecallback = var_210_3,
									cancelcallback = var_210_3
								}

								function var_210_1()
									LayerManager:pushInLayer("PopPurchaseResultLayer", var_210_4)
								end
							end

							if var_205_2 then
								var_201_1(var_205_2, arg_210_0.result, var_210_1)
							elseif var_210_1 then
								var_210_1()
							else
								self:popTalkSp(self.tag.modelid, arg_210_0.result, var_0_29[var_178_6[arg_201_0]].class)
							end

							if var_201_0.result_talk then
								global_basic_scene:addChild(TalkLayer:create(var_201_0.result_talk, nil, TALK_TYPE_NORMAL, "", nil), ZORDER_TALKLAYER)
							end
						elseif arg_210_0.result == -5 then
							self:removeMap(var_205_5)
							self:resetCurMap(curMapType, curMapFloor, plotMapId)
						end

						self.touchLock = false
					end)
				end
			end

			if var_201_0.trigger_talk then
				global_basic_scene:addChild(TalkLayer:create(var_201_0.trigger_talk, nil, TALK_TYPE_NORMAL, "", function()
					var_204_0()
				end), ZORDER_TALKLAYER)
			else
				var_204_0()
			end
		end

		local var_201_3 = (function()
			if not var_201_0.result1_type then
				return {}
			end

			local var_202_0 = not var_201_0.result2_type and 1 or explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_201_0].result and explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_201_0].result or 1

			return {
				type = var_201_0["result" .. var_202_0 .. "_type"],
				param = var_201_0["result" .. var_202_0 .. "_param"],
				des = var_201_0["result" .. var_202_0 .. "_des"]
			}
		end)()

		if var_0_29[var_178_6[arg_201_0]].class == 5 then
			local function var_201_4()
				var_201_2(var_201_3)
			end

			self:addChild(PopLayer:Do({
				labels = {
					title = "探险信息",
					des = var_201_3.des
				},
				surecallback = var_201_4,
				cancelcallback = var_201_4
			}), 999)
		elseif var_0_29[var_178_6[arg_201_0]].id == 203 then
			local var_201_5 = math.floor((arg_201_0 - 1) / self.room_WIDTH_num) + 1
			local var_201_6

			if (arg_201_0 - 1) % self.room_WIDTH_num + 1 == 1 then
				var_201_6 = var_0_43
			elseif (arg_201_0 - 1) % self.room_WIDTH_num + 1 == self.room_WIDTH_num then
				var_201_6 = var_0_41
			elseif var_201_5 == 1 then
				var_201_6 = var_0_42
			elseif var_201_5 == self.room_HEIGHT_num then
				var_201_6 = var_0_40
			end

			self:changeRoom(var_201_6)
		elseif var_201_3.type == var_0_50.FIGHT then
			local var_201_7 = self.iconLayout:getChildByName(arg_201_0 .. "icon")

			self.tag:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(var_201_7:getPosition())), cc.CallFunc:create(function()
				explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_201_0].usedcount = 99

				var_201_7:removeFromParent()
				self:updateRangeModel(arg_201_0)
			end), cc.MoveTo:create(0.2, (cc.p(self.tag:getPosition()))), cc.CallFunc:create(function()
				self.touchLock = false
			end)))
		elseif var_201_3.type == var_0_50.SHOP_BUFF then
			self:buffShopPopLayer(explore_sellbuff_data[tonumber(var_0_29[var_178_6[arg_201_0]].result1_param)]["buffclass" .. explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_201_0].result], function(arg_218_0)
				var_201_2(var_201_3, arg_218_0)
			end, function()
				self.touchLock = false
			end)
		elseif var_201_3.type == var_0_50.SHOP_ITEM then
			self:itemShopPopLayer(explore_sellweapon_data[tonumber(var_0_29[var_178_6[arg_201_0]].result1_param)]["weaponclass" .. explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_201_0].result], function(arg_220_0)
				var_201_2(var_201_3, arg_220_0)
			end, function()
				self.touchLock = false
			end)
		elseif var_201_3.type == var_0_50.NEXT_FLOOR then
			if var_0_29[var_178_6[arg_201_0]].trigger_type == 1 then
				self:needKeyPopLayer({
					needid = var_0_29[var_178_6[arg_201_0]].trigger_param1,
					neednum = var_0_29[var_178_6[arg_201_0]].trigger_param2,
					ownnum = item_manager:getItemNumber(var_0_29[var_178_6[arg_201_0]].trigger_param1),
					des = var_0_29[var_178_6[arg_201_0]].trigger_des,
					surecallback = function()
						if var_201_0.trigger_param2 <= item_manager:getItemNumber(var_201_0.trigger_param1) then
							local var_222_0 = explore_manager.curMapConfig.plotMapId and var_0_26[explore_manager.curMapConfig.plotMapId].out_map_talk or var_0_26[explore_manager.curMapConfig.otherInfos.mapfloor].out_map_talk

							if var_222_0 then
								global_basic_scene:addChild(TalkLayer:create(var_222_0, nil, TALK_TYPE_NORMAL, var_201_2(var_201_3)), 999)
							else
								var_201_2(var_201_3)
							end
						else
							var_201_2(var_201_3)
						end
					end,
					cancelcallback = function()
						self.touchLock = false
					end
				})
			else
				self:addChild(PopLayer:Do({
					other_bnt = "public/button/public_button_normal.png",
					labels = {
						title = "探险信息",
						des = var_0_29[var_178_6[arg_201_0]].trigger_des
					},
					system_figure = self:randomRole(),
					surecallback = function()
						local var_224_0 = explore_manager.curMapConfig.plotMapId and var_0_26[explore_manager.curMapConfig.plotMapId].out_map_talk or var_0_26[explore_manager.curMapConfig.otherInfos.mapfloor].out_map_talk

						if var_224_0 then
							global_basic_scene:addChild(TalkLayer:create(var_224_0, nil, TALK_TYPE_NORMAL, var_201_2(var_201_3)), 999)
						else
							var_201_2(var_201_3)
						end
					end,
					cancelcallback = function()
						self.touchLock = false
					end
				}), 999)
			end
		elseif var_0_29[var_178_6[arg_201_0]].trigger_type > 0 then
			if var_0_29[var_178_6[arg_201_0]].trigger_type == 1 then
				self:needKeyPopLayer({
					needid = var_0_29[var_178_6[arg_201_0]].trigger_param1,
					neednum = var_0_29[var_178_6[arg_201_0]].trigger_param2,
					ownnum = item_manager:getItemNumber(var_0_29[var_178_6[arg_201_0]].trigger_param1),
					des = var_0_29[var_178_6[arg_201_0]].trigger_des,
					surecallback = function()
						var_201_2(var_201_3)
					end,
					cancelcallback = function()
						self.touchLock = false
					end
				})
			elseif var_0_29[var_178_6[arg_201_0]].trigger_type == 2 then
				self:addChild(PopLayer:Do({
					labels = {
						title = "探险信息",
						des = var_0_29[var_178_6[arg_201_0]].trigger_des
					},
					system_figure = self:randomRole(),
					surecallback = function()
						var_201_2(var_201_3)
					end,
					cancelcallback = function()
						self.touchLock = false
					end
				}), 999)
			elseif var_0_29[var_178_6[arg_201_0]].trigger_type == 3 then
				if explore_manager.curMapConfig.usedTile[self.curRoomOrder][arg_201_0].usedcount == 0 then
					if var_0_29[var_178_6[arg_201_0]].trigger_param1 then
						global_basic_scene:addChild(TalkLayer:create(var_0_29[var_178_6[arg_201_0]].trigger_param1, nil, TALK_TYPE_NORMAL))
					end

					var_201_2(var_201_3)
				end

				if var_0_29[var_178_6[arg_201_0]].trigger_param2 then
					self:npcPopLayer({
						tileInfo = var_0_29[var_178_6[arg_201_0]],
						surecallback = function()
							var_201_2(var_201_3)
						end,
						cancelcallback = function()
							self.touchLock = false
						end
					})
				end
			end
		elseif var_0_29[var_178_6[arg_201_0]].trigger_des then
			self:addChild(PopLayer:Do({
				labels = {
					title = "探险信息",
					des = var_0_29[var_178_6[arg_201_0]].trigger_des
				},
				system_figure = self:randomRole(),
				surecallback = function()
					var_201_2(var_201_3)
				end,
				cancelcallback = function()
					self.touchLock = false
				end
			}), 999)
		else
			var_201_2(var_201_3)
		end
	end

	local function var_178_13(arg_234_0)
		if arg_234_0.x < var_178_2 or arg_234_0.x > var_178_3 or arg_234_0.y < var_178_4 or arg_234_0.y > var_178_5 then
			return
		end

		return (math.floor((arg_234_0.y - var_178_4) / 100) + 1 - 1) * self.room_WIDTH_num + (math.floor((arg_234_0.x - var_178_2) / 100) + 1)
	end

	local function var_178_14(arg_235_0, arg_235_1)
		local var_235_0 = var_0_29[var_178_6[arg_235_0]]

		if not arg_235_1 then
			global_ShowBlockWords("无法到达~")

			return
		end

		local var_235_5, var_235_6, var_235_7 = (function(arg_236_0)
			local var_236_0
			local var_236_1

			if explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[arg_236_0[#arg_236_0]] then
				var_236_1 = var_235_0.trigger_range and not var_178_8(arg_235_0) and arg_235_0 or explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[arg_236_0[#arg_236_0]][1]

				table.remove(arg_236_0, #arg_236_0)
			elseif var_0_29[var_178_6[arg_236_0[#arg_236_0]]].is_block == 1 and var_0_29[var_178_6[arg_236_0[#arg_236_0]]].is_touch == 1 and not var_178_8(arg_236_0[#arg_236_0]) then
				var_236_1 = arg_236_0[#arg_236_0]

				table.remove(arg_236_0, #arg_236_0)
			else
				var_236_0 = arg_236_0[#arg_236_0]
			end

			for iter_236_0, iter_236_1 in ipairs(arg_236_0) do
				if iter_236_0 == #arg_236_0 then
					var_236_0 = iter_236_1

					if arg_235_0 == iter_236_1 and var_0_29[var_178_6[iter_236_1]].is_touch > 0 and not var_178_8(iter_236_1) then
						var_236_1 = iter_236_1
					end
				end

				if var_0_29[var_178_6[iter_236_1]].is_touch == 2 and not var_178_8(iter_236_1) then
					var_236_1 = iter_236_1
					var_236_0 = iter_236_1

					break
				end

				if var_0_29[var_178_6[iter_236_1]].id == 203 then
					var_236_1 = iter_236_1
					var_236_0 = iter_236_1

					break
				end
			end

			local var_236_2 = {}

			for iter_236_2, iter_236_3 in ipairs(arg_236_0) do
				var_236_2[iter_236_2] = iter_236_3

				if iter_236_3 == var_236_0 then
					break
				end
			end

			if next(var_236_2) == nil then
				var_236_2 = nil
			end

			return var_236_0, var_236_1, var_236_2
		end)(arg_235_1)

		if var_235_7 then
			var_178_10(var_235_7, function()
				if var_235_6 then
					var_178_12(var_235_6)
				end

				explore_manager:move_cur_pos(self.curMapType, var_235_5, nil)
			end)
		elseif var_235_6 then
			var_178_12(var_235_6)
		end
	end

	local function var_178_15(arg_238_0)
		return self:getCurPos(math.floor((arg_238_0.x - var_178_2) / 100) + 1, math.floor((arg_238_0.y - var_178_4) / 100) + 1)
	end

	local function var_178_16(arg_239_0)
		if explore_manager.curMapConfig.rangeModel[self.curRoomOrder].center[arg_239_0] then
			return false
		end

		if var_178_6[arg_239_0] == 203 then
			return false
		end

		local var_239_0 = 0

		for iter_239_0 = 1, 4 do
			local var_239_1 = var_178_7(arg_239_0, iter_239_0)

			if not var_239_1 then
				var_239_0 = var_239_0 + 1
			elseif not var_178_9(var_239_1) then
				var_239_0 = var_239_0 + 1
			end
		end

		if var_239_0 == 4 then
			return true
		else
			return false
		end
	end

	local function var_178_17(arg_240_0)
		if arg_240_0.x < var_178_2 or arg_240_0.x > var_178_3 or arg_240_0.y < var_178_4 or arg_240_0.y > var_178_5 then
			return -1
		end

		local var_240_0 = (math.floor((arg_240_0.y - var_178_4) / 100) + 1 - 1) * self.room_WIDTH_num + (math.floor((arg_240_0.x - var_178_2) / 100) + 1)

		if var_240_0 == explore_manager.curMapConfig.curPosIndex then
			return 1
		end

		if var_0_29[var_178_6[var_240_0]].class == 1 then
			return -1
		end

		if explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range[var_240_0] and not explore_manager.curMapConfig.rangeModel[self.curRoomOrder].center[var_240_0] then
			return -2
		end

		if var_178_16(var_240_0) then
			return -3
		end

		local var_240_1 = var_178_11(var_240_0)

		if var_240_1 then
			return 2, var_240_1, explore_manager.curMapConfig.curPosIndex, var_240_0
		else
			return -3
		end
	end

	listener = cc.EventListenerTouchOneByOne:create()

	listener:setSwallowTouches(true)
	listener:registerScriptHandler(function(arg_241_0, arg_241_1)
		if self.touchLock then
			return false
		end

		local var_241_0 = self.layout:convertToNodeSpace(arg_241_0:getLocation())

		self:setTouchMarkPos(var_178_15(var_241_0), var_178_17(var_241_0))

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(function(arg_242_0, arg_242_1)
		local var_242_0 = var_178_13((self.layout:convertToNodeSpace(arg_242_0:getStartLocation())))
		local var_242_1 = self.layout:convertToNodeSpace(arg_242_0:getLocation())
		local var_242_2 = var_178_13(var_242_1)
		local var_242_3 = var_178_15(var_242_1)
		local var_242_4 = var_178_15((self.layout:convertToNodeSpace(arg_242_0:getPreviousLocation())))

		if var_242_3.x .. var_242_3.y ~= var_242_4.x .. var_242_4.y then
			self:setTouchMarkPos(var_242_3, var_178_17(var_242_1))
		end
	end, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(function(arg_243_0, arg_243_1)
		local var_243_0, var_243_1 = self:playTouchMarkAction(var_178_11)
		local var_243_2 = var_178_13((self.layout:convertToNodeSpace(arg_243_0:getLocation())))

		if var_243_0 > 0 then
			if var_243_2 == explore_manager.curMapConfig.curPosIndex then
				if var_0_29[var_178_6[var_243_2]].is_touch == 1 and not var_178_8(var_243_2) then
					var_178_12(var_243_2)
				end

				return
			else
				var_178_14(var_243_2, var_243_1)
			end
		elseif var_243_0 == -1 then
			-- block empty
		elseif var_243_0 == -2 then
			audio_manager:playeffectMusicTest(EXPLORE_INVALID)
			global_ShowBlockWords("已被怪物封印")
		elseif var_243_0 == -3 then
			global_ShowBlockWords("无法到达")
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self.layout:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self.layout)
end

function ExploreMapLayer:changeRoom(arg_244_1)
	if not explore_manager.curMapConfig.path_tree[self.curRoomOrder].nexts[arg_244_1] then
		return
	end

	self.touchLock = true

	self.clipLayout:setClippingEnabled(true)

	self.curRoomOrder = explore_manager.curMapConfig.path_tree[self.curRoomOrder].nexts[arg_244_1]
	self.exploredRooms[self.curRoomOrder] = true

	self.smallMap:updateExploredRoom()

	local var_244_0 = var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]]
	local var_244_1 = var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].birth_points[({
		[var_0_40] = var_0_42,
		[var_0_42] = var_0_40,
		[var_0_41] = var_0_43,
		[var_0_43] = var_0_41
	})[arg_244_1]]

	explore_manager.curMapConfig.curPosIndex = (math.floor((var_244_1 - 1) / var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width) + 2 - 1) * self.room_WIDTH_num + ((var_244_1 - 1) % var_0_27[var_0_26[self.curMapFloor]["room" .. self.curRoomOrder]].width + 2)

	local var_244_2 = self.layout:getContentSize()
	local var_244_3
	local var_244_4

	if arg_244_1 == var_0_40 then
		var_244_3 = self.layout:getPositionX()
		var_244_4 = self.layout:getPositionY() + self.clipLayout:getContentSize().height
	elseif arg_244_1 == var_0_41 then
		var_244_3 = self.layout:getPositionX() + self.clipLayout:getContentSize().width
		var_244_4 = self.layout:getPositionY()
	elseif arg_244_1 == var_0_42 then
		var_244_3 = self.layout:getPositionX()
		var_244_4 = self.layout:getPositionY() - self.clipLayout:getContentSize().height
	elseif arg_244_1 == var_0_43 then
		var_244_3 = self.layout:getPositionX() - self.clipLayout:getContentSize().width
		var_244_4 = self.layout:getPositionY()
	end

	local var_244_5 = self.layout

	self.layout:stopAllActions()

	self.layout = nil
	self.batchNodeLayout = nil
	self.iconLayout = nil

	self.tag:removeFromParent()

	self.tag = nil
	self.layout = ccui.Layout:create()

	self.layout:setTouchEnabled(false)
	self.layout:setPosition(var_244_3, var_244_4)
	self.layout:setContentSize(var_244_2)
	self.clipLayout:addChild(self.layout)

	self.batchNodeLayout = cc.SpriteBatchNode:create("tilemap/tiles_" .. var_0_26[self.curMapFloor].fullImage .. ".png")

	self.batchNodeLayout:setPosition(0, 0)
	self.layout:addChild(self.batchNodeLayout)

	self.maskPanel = ccui.Layout:create()

	self.layout:addChild(self.maskPanel)

	self.iconLayout = ccui.Layout:create()

	self.iconLayout:setPosition(0, 0)
	self.layout:addChild(self.iconLayout)

	for iter_244_0 = 1, var_244_0.width * var_244_0.height do
		local var_244_8 = math.floor((iter_244_0 - 1) / var_244_0.width) + 2

		for iter_244_1, iter_244_2 in ipairs(var_0_28[var_244_0.imglayer][iter_244_0]) do
			local var_244_9 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_26[self.curMapFloor].fullImage .. "/" .. iter_244_2 .. ".png")

			var_244_9:setPosition(((iter_244_0 - 1) % var_244_0.width + 2 - (self.room_WIDTH_num + 1) / 2) * 100 + var_244_2.width / 2, (var_244_8 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_244_2.height / 2)
			var_244_9:setLocalZOrder(iter_244_1)

			if explore_img_data[iter_244_2].is_big_icon then
				var_244_9:setAnchorPoint(cc.p(0.5, 0))
				var_244_9:setPosition(((iter_244_0 - 1) % var_244_0.width + 2 - (self.room_WIDTH_num + 1) / 2) * 100 + var_244_2.width / 2, (var_244_8 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_244_2.height / 2 - 50)
				self.iconLayout:addChild(var_244_9, self.room_HEIGHT_num - var_244_8 + 1)
			else
				self.batchNodeLayout:addChild(var_244_9)
			end
		end
	end

	for iter_244_3 = 1, self.room_WIDTH_num * self.room_HEIGHT_num do
		local var_244_10 = var_0_29[explore_manager.curMapConfig.objectmodels[self.curRoomOrder][iter_244_3]]
		local var_244_11 = math.floor((iter_244_3 - 1) / self.room_WIDTH_num) + 1
		local var_244_12 = ((iter_244_3 - 1) % self.room_WIDTH_num + 1 - (self.room_WIDTH_num + 1) / 2) * 100 + var_244_2.width / 2
		local var_244_13 = (var_244_11 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_244_2.height / 2

		if var_0_29[explore_manager.curMapConfig.objectmodels[self.curRoomOrder][iter_244_3]].icon or var_0_49[var_244_10.class] then
			if var_0_49[var_244_10.class] then
				assert(var_244_10["result" .. 1 .. "_param"], explore_manager.curMapConfig.objectmodels[self.curRoomOrder][iter_244_3])
				assert(var_0_30[var_244_10["result" .. 1 .. "_param"]], var_244_10["result" .. 1 .. "_param"])
				assert(var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team, var_244_10["result" .. 1 .. "_param"])
				assert(var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team], var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team)
				assert(var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon, var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team)
				assert(var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon, var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team)
				assert(model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon], var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon)

				local var_244_15 = var_0_56
				local var_244_16 = cc.size(model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon].modelweight, model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon].modelheight)
				local var_244_17 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon].spine_model .. ".atlas", (model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_0_31[var_0_30[var_244_10["result" .. 1 .. "_param"]].boss_team].boss_icon].clothes_model .. ".atlas" or nil))

				var_244_17:setScale(var_244_15, var_244_15)
				var_244_17:setContentSize(var_244_16)
				var_244_17:playAni(nil, "idle", true)
				var_244_17:setPosition(var_244_12, var_244_13)
				var_244_17:setName(iter_244_3 .. "icon")
				self.iconLayout:addChild(var_244_17, self.room_HEIGHT_num - var_244_11 + 1)

				if var_0_48[var_244_10.class] then
					local var_244_18

					if config._DEBUG then
						var_244_18 = cc.Sprite:create(var_0_48[var_244_10.class]) or cc.Sprite:createWithSpriteFrameName(var_0_48[var_244_10.class])
					end

					var_244_18:setAnchorPoint(cc.p(0.5, 1))
					var_244_18:setScale(var_244_17:getContentSize().width / 160)
					var_244_18:setPosition(var_244_17:getContentSize().width / 2, var_244_17:getContentSize().height)
					var_244_17:addChild(var_244_18)
				end
			elseif var_244_10.is_big_icon then
				local var_244_19 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_26[self.curMapFloor].fullImage .. "/" .. var_244_10.icon .. ".png")

				var_244_19:setName(iter_244_3 .. "icon")
				var_244_19:setAnchorPoint(cc.p(0.5, 0))

				if var_244_10.is_shadow then
					var_244_19:setPosition(var_244_12, var_244_13)

					local var_244_20 = ccui.ImageView:create("explore/shadow.png", var_0_0)

					var_244_20:setScale(0.9)
					var_244_20:setPosition(var_244_12, var_244_13 - 10)
					self.iconLayout:addChild(var_244_20, self.room_HEIGHT_num - var_244_11 + 1)

					var_244_19.shadow = var_244_20
				else
					var_244_19:setPosition(var_244_12, var_244_13 - 50)
				end

				self.iconLayout:addChild(var_244_19, self.room_HEIGHT_num - var_244_11 + 1)
			else
				local var_244_21 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_26[self.curMapFloor].fullImage .. "/" .. var_0_29[p].icon .. ".png")

				var_244_21:setPosition(var_244_12, var_244_13)
				var_244_21:setName(index .. "icon")
				self.iconLayout:addChild(var_244_21, self.room_HEIGHT_num - var_244_11 + 1)
			end
		end
	end

	for iter_244_4, iter_244_5 in pairs(explore_manager.curMapConfig.rangeModel[self.curRoomOrder].range) do
		for iter_244_6, iter_244_7 in pairs(iter_244_5) do
			local var_244_23
			local var_244_24

			if not self.maskPanel:getChildByName("maskPanel" .. iter_244_7) then
				local var_244_22 = ccui.Layout:create()

				var_244_22:setClippingEnabled(false)
				var_244_22:setName("maskPanel" .. iter_244_7)
				self.maskPanel:addChild(var_244_22, 1)

				var_244_23 = math.floor((iter_244_4 - 1) / self.room_WIDTH_num) + 1
				var_244_24 = ccui.ImageView:create("explore/red_mask.png", var_0_0)
			end

			var_244_24:setPosition(((iter_244_4 - 1) % self.room_WIDTH_num + 1 - (self.room_WIDTH_num + 1) / 2) * 100 + var_244_2.width / 2, (var_244_23 - (self.room_HEIGHT_num + 1) / 2) * 100 + var_244_2.height / 2)
			self.maskPanel:getChildByName("maskPanel" .. iter_244_7):addChild(var_244_24)
		end
	end

	self:initSelectedFrame(arg_244_1)
	self:initTouchMark()
	self:registerTouchEvent()
	var_244_5:runAction(cc.Sequence:create(({
		[var_0_40] = cc.MoveBy:create(0.3, cc.p(0, -self.clipLayout:getContentSize().height)),
		[var_0_41] = cc.MoveBy:create(0.3, cc.p(-self.clipLayout:getContentSize().width, 0)),
		[var_0_42] = cc.MoveBy:create(0.3, cc.p(0, self.clipLayout:getContentSize().height)),
		[var_0_43] = cc.MoveBy:create(0.3, cc.p(self.clipLayout:getContentSize().width, 0))
	})[arg_244_1], cc.Hide:create(), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		self.touchLock = false

		self.clipLayout:setClippingEnabled(false)
	end)))
	self.layout:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(-self.clipLayout:getPositionX(), -self.clipLayout:getPositionY()))))
end
