RogueExploreLayer = class("RogueExploreLayer", function()
	return cc.Layer:create()
end)

local RogueRoom
local var_0_1 = config._DEBUG and 0 or 1
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
local explore_aim_data = require("data.explore.explore_aim_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local L2Actor = require("view.Sprite.L2Actor")
local rogue_explore_manager = require("controller.rogue_explore_manager")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local core_manager = require("controller.core_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local l2utils = require("controller.l2utils")
local MaskNode = require("view.Sprite.MaskNode")
local Utility = require("common.Utility")
local var_0_32
local var_0_33
local var_0_34
local var_0_35

require("view.Layer.ExploreTalkLayer")
require("view.Sprite.ConfirmDialogSprite")

local var_0_36
local var_0_37
local var_0_38 = 0
local var_0_39 = 10
local var_0_40 = 20
local var_0_41 = 30
local var_0_42 = 1
local var_0_43 = 2
local var_0_44 = 3
local var_0_45 = 4
local var_0_46 = 8
local var_0_47 = 7
local var_0_48 = 6
local var_0_49 = 5
local var_0_50 = 9
local var_0_51 = {}

var_0_51[1] = 3
var_0_51[2] = 4
var_0_51[3] = 1
var_0_51[4] = 2
var_0_51[8] = 6
var_0_51[7] = 5
var_0_51[6] = 8
var_0_51[5] = 7
;({})[TILE_TYPE.SPECIAL_ENEMY] = "explore/monster_title1.png"

local var_0_55 = {
	monster = "explore/small_map_boss.png",
	box = "explore/small_map_box.png",
	aim = "explore/small_map_aim.png"
}
local var_0_56 = {
	"FightLayer/anim_quality_equipment_lv1.png",
	"FightLayer/anim_quality_equipment_lv2.png",
	"FightLayer/anim_quality_equipment_lv3.png",
	"FightLayer/anim_quality_equipment_lv4.png",
	"FightLayer/anim_quality_equipment_lv5.png",
	"FightLayer/anim_quality_equipment_lv5.png"
}
local var_0_57 = {
	{
		"explore/arrow_green_1.png",
		"explore/arrow_yellow_2.png"
	},
	{
		"explore/arrow_green_2.png",
		"explore/arrow_yellow_1.png"
	},
	{
		"explore/arrow_green_3.png",
		"explore/arrow_yellow_2.png"
	},
	{
		"explore/arrow_green_4.png",
		"explore/arrow_yellow_1.png"
	}
}
local var_0_58 = 2
local var_0_59 = 3
local var_0_60 = {
	{
		idle = "idle",
		run = "run"
	},
	{
		idle = "caishui",
		run = "swim"
	},
	{
		idle = "idle",
		run = "run"
	}
}
local var_0_61 = {
	EXPLORE_WALK,
	EXPLORE_SWIM_EFFECT,
	EXPLORE_WALK
}
local var_0_62 = false
local var_0_63 = 1
local var_0_68 = 0.24
local var_0_69 = 0.8
local var_0_70 = 100
local var_0_71 = 0.3
local var_0_72 = {
	cc.p(336, 873),
	cc.p(147, 688),
	cc.p(464, 630),
	cc.p(49, 461),
	cc.p(409, 405),
	(cc.p(-25, 255))
}

function RogueExploreLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = RogueExploreLayer.new(arg_3_1)

	var_3_0:init(arg_3_1)

	return var_3_0
end

function RogueExploreLayer.getInstance()
	return var_0_36
end

function RogueExploreLayer:init(arg_5_1)
	var_0_36 = self
	self.touchLock = false
	self.isMainAimFinish = false
	self.model = arg_5_1.model
	var_0_37 = self.model
	self.activityid = self.model.activityid

	if arg_5_1 then
		self.returnUiLayer = arg_5_1.returnUiLayer or "SchoolAreaLayer"
	end

	self.failReturnUiLayer = arg_5_1 and arg_5_1.failReturnUiLayer
	self.curMapConfig = var_0_37.curMapConfig
	self.curMapId = self.curMapConfig.mapid
	self.curMapSize = self.curMapConfig.mapRoomSize
	self.curAimId = self.curMapConfig.aimid
	self.followQueue = self.curMapConfig.followQueue
	self.bridgeLocks = self.curMapConfig.bridgeLocks
	self.aimTypeTbl = self.curMapConfig.aimTypeTbl
	self.puzzleConfig = self.curMapConfig.puzzleConfig
	self.roomPathTree = self.curMapConfig.pathtree
	self.roomMapBlocks = self.curMapConfig.mapBlocks
	self.usedTilesConfig = self.curMapConfig.usedTile
	self.replaceConfig = self.curMapConfig.replaceConfig
	self.exploredRooms = self.curMapConfig.exploredRooms
	self.rangeConfig = self.curMapConfig.objectRange
	self.monsterRangeConfig = self.curMapConfig.monsterRange
	self.roomsLightConfig = self.curMapConfig.roomsLightConfig
	self.effect = self.curMapConfig.effect
	self.particle = self.curMapConfig.particle
	self.roomColor = self.curMapConfig.roomColor
	self.jumpEffect = self.curMapConfig.jumpEffect
	self.roomfollowholeConfig = self.curMapConfig.roomfollowholeConfig
	self.roomteleportConfig = self.curMapConfig.roomteleportConfig
	self.roomgreenConfig = self.curMapConfig.roomgreenConfig
	self.exploreProgressList = {}
	var_0_32 = require("data.explore.map_data")
	var_0_33 = require("data.explore.room_data")
	var_0_34 = require("data.explore.room_tile_data")
	var_0_35 = require("data.explore.tile_data")

	self:initUI()
	self:enterMap()

	self.start_time = os.time()

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_36 = nil

			playermodel:resetExploreArraysHpInherit()
			var_0_37:clearExploreInfoHpInherit()
			var_0_37:reset_map()
			self:removeCachedTextured()
			audio_manager:stopAllEffects()

			for iter_6_0 = 1, #self.followQueue do
				self.followQueue[iter_6_0]:release()
			end
		end
	end)
end

function RogueExploreLayer.onForeground(arg_7_0, arg_7_1)
	return
end

function RogueExploreLayer.onBackground(arg_8_0)
	return
end

function RogueExploreLayer:playUIAnimation(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(cc.size(640, GameDisplay.height))
	var_9_0:setTouchEnabled(true)
	var_9_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_9_0, 999)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_9_0:runAction(cc.RemoveSelf:create())

		if arg_9_2 then
			arg_9_2()
		end
	end)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(arg_9_1 .. ".ExportJson")

	local var_9_1 = ccs.Armature:create(arg_9_1)

	var_9_1:setPosition(320, GameDisplay.height / 2)
	var_9_0:addChild(var_9_1)
	var_9_1:getAnimation():play("Animation1")
	var_9_1:getAnimation():setFrameEventCallFunc(function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		if arg_11_1 == "end" and not arg_9_3 then
			var_9_0:runAction(cc.RemoveSelf:create())

			if arg_9_2 then
				arg_9_2()
			end
		end
	end)
end

function RogueExploreLayer:enterMap()
	local var_12_0

	if self.curMapConfig.aimid == 10000001 then
		function var_12_0()
			LayerManager:pushInLayer("TipsLayer", {
				tips = {
					"mainScenebg/guide/30.jpg",
					"mainScenebg/guide/31.jpg",
					"mainScenebg/guide/32.jpg",
					"mainScenebg/guide/33.jpg",
					"mainScenebg/guide/34.jpg"
				}
			})
		end
	end

	if explore_aim_data[self.curMapConfig.aimid].enter_map_talk and self.model:checkIsFirst() then
		global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].enter_map_talk, nil, TALK_TYPE_NORMAL, "", var_12_0), 9999)
	elseif self.model:checkIsFirst() and var_12_0 then
		var_12_0()
	end

	self:mapLoading(self.curMapId, function()
		self:initSmallMap()
		self:initAimUI()
		self:switchRoom()
		self.mapPanel:setVisible(true)
	end)
end

function RogueExploreLayer.exit(arg_15_0, arg_15_1)
	local function var_15_0()
		var_0_37:rogueExploreFailServer()
		var_0_37:reset_map(arg_15_0.curMapType, {
			mapfloor = 0,
			maplevel = 6
		})
		arg_15_0.curRoomMap:stopAllActions()
		print("??????????????????", arg_15_0.returnUiLayer, arg_15_0.failReturnUiLayer)

		if arg_15_0.failReturnUiLayer then
			LayerManager:switchShowLayer(arg_15_0.failReturnUiLayer)
		else
			LayerManager:switchShowLayer(arg_15_0.returnUiLayer, {
				activityid = arg_15_0.activityid
			})
		end

		AnalyticManager.explore_cancel({
			aimid = arg_15_0.curAimId
		})
	end

	local var_15_1 = {
		other_bnt2 = "public/button/public_button_normal.png",
		surecallback = function()
			var_0_37:rogueExploreRetreatServer()
			var_0_37:reset_map(arg_15_0.curMapType, {
				mapfloor = 0,
				maplevel = 6
			})
			arg_15_0.curRoomMap:stopAllActions()
			print("??????????????????", arg_15_0.returnUiLayer, arg_15_0.failReturnUiLayer)

			if arg_15_0.failReturnUiLayer then
				LayerManager:switchShowLayer(arg_15_0.failReturnUiLayer)
			else
				LayerManager:switchShowLayer(arg_15_0.returnUiLayer, {
					activityid = arg_15_0.activityid
				})
			end

			AnalyticManager.explore_cancel({
				aimid = arg_15_0.curAimId
			})
		end,
		cancelcallback = arg_15_1,
		labels = L_EXPLOREMAP_EXIT_MSG.Exit_Button_Rogue,
		other_bnt2_label = L_EXPLOREMAP_EXIT_MSG.Exit_Button_Rogue.button2,
		other_bnt2_callback = function()
			var_15_0()
		end
	}

	var_15_1.labels.titleImage = "title_retreat.png"

	LayerManager:pushInLayer("PopDoLayer", var_15_1)
end

function RogueExploreLayer:failExit()
	local function var_19_0()
		self:playUIAnimation("shibai", function()
			self.curRoomMap:stopAllActions()

			if self.failReturnUiLayer then
				LayerManager:switchShowLayer(self.failReturnUiLayer)
			else
				LayerManager:switchShowLayer(self.returnUiLayer)
			end

			AnalyticManager.explore_fail({
				aimid = self.curAimId
			})
		end, true)
	end

	if explore_aim_data[self.curMapConfig.aimid].aim_fail_talk then
		global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].aim_fail_talk, nil, TALK_TYPE_NORMAL, "", var_19_0), 999)
	else
		var_19_0()
	end
end

function RogueExploreLayer:initUI()
	local var_22_0 = ccui.Layout:create()

	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_22_0:setBackGroundColorOpacity(opacity)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	self:addChild(var_22_0, -1)

	self.mapPanel = ccui.Layout:create()

	self.mapPanel:setVisible(false)
	self:addChild(self.mapPanel)

	self.effectLayer = ccui.Layout:create()

	self.effectLayer:setVisible(false)
	self.effectLayer:setTouchEnabled(false)
	self.effectLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.effectLayer:setPosition(-GameDisplay.fix_x, -GameDisplay.fix_y)
	self:addChild(self.effectLayer)

	local var_22_1 = var_0_33[var_0_37:getRoomid(self.curMapId, self.curMapConfig.curRoomOrder)]

	self.mapView = ccui.ScrollView:create()

	self.mapView:setDirection(ccui.ScrollViewDir.both)
	self.mapView:setContentSize(cc.size(640, 880))
	self.mapView:setPosition(0, 0)
	self.mapView:setTouchEnabled(false)

	local var_22_2 = var_22_1.width_num * var_0_70
	local var_22_3 = var_22_1.height_num * var_0_70

	var_22_2 = var_22_1.width_num * var_0_70 < self.mapView:getContentSize().width / var_0_69 and self.mapView:getContentSize().width / var_0_69 or var_22_2
	var_22_3 = var_22_3 < self.mapView:getContentSize().height / var_0_69 and self.mapView:getContentSize().height / var_0_69 or var_22_3

	self.mapView:setInnerContainerSize(cc.size(var_22_2, var_22_3))
	self.mapView:getInnerContainer():setScale(var_0_69)
	self.mapPanel:addChild(self.mapView, 1)

	self.mapUIPanel = ccui.Layout:create()

	self.mapPanel:addChild(self.mapUIPanel, 9)

	self.gainItemPanel = ccui.Layout:create()
	self.gainItemPanel.sp_tbl = {}

	self.mapUIPanel:addChild(self.gainItemPanel, 9)

	local var_22_4 = var_0_37:isHpInherit()
	local var_22_5 = ccui.Button:create("explore/top_bg.png", "explore/top_bg.png", "explore/top_bg.png", var_0_1)

	if var_22_4 then
		var_22_5 = ccui.Button:create("explore/hpInherit/bg.png", "explore/hpInherit/bg.png", "explore/hpInherit/bg.png", var_0_1)
	end

	var_22_5:setTouchEnabled(false)
	var_22_5:setSwallowTouches(false)
	var_22_5:setAnchorPoint(cc.p(0, 1))
	var_22_5:setPosition(0, GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX))
	var_22_5:setName("topbg")
	self.mapUIPanel:addChild(var_22_5)

	self.mapFloorLabel = cc.Label:createWithTTF(explore_aim_data[self.curMapConfig.aimid].name, FONT_NAME, 30)

	self.mapFloorLabel:setName("mapfloor")
	self.mapFloorLabel:setAnchorPoint(cc.p(0, 0.5))
	self.mapFloorLabel:setPosition(5, 240)
	var_22_5:addChild(self.mapFloorLabel)

	self.btnDetail = ccui.Button:create("public/button/btn_detail_red.png", nil, "public/button/btn_detail_red.png", var_0_1)

	self.btnDetail:setName("btnDetail")
	self.btnDetail:setAnchorPoint(cc.p(0, 0.5))
	self.btnDetail:setPosition(self.mapFloorLabel:getContentSize().width - 1, 243)
	self.btnDetail:setScale(0.65)
	var_22_5:addChild(self.btnDetail)
	self.btnDetail:addTouchEventListener(function(arg_23_0, arg_23_1)
		local var_23_0

		if arg_23_1 ~= ccui.TouchEventType.ended then
			do return end

			var_23_0 = {}
		end

		var_23_0.tips = {
			"mainScenebg/guide/30.jpg",
			"mainScenebg/guide/31.jpg",
			"mainScenebg/guide/32.jpg",
			"mainScenebg/guide/33.jpg",
			"mainScenebg/guide/34.jpg"
		}

		LayerManager:pushInLayer("TipsLayer", var_23_0)
	end)

	local var_22_6 = ccui.Button:create("explore/map_give_up.png", nil, "explore/map_give_up.png", var_0_1)

	if var_22_4 then
		var_22_6 = ccui.Button:create("explore/hpInherit/map_retreat.png", nil, "explore/hpInherit/map_retreat.png", var_0_1)
	end

	var_22_6:setName("mapGiveupBnt")
	var_22_6:setAnchorPoint(cc.p(1, 1))
	var_22_6:setPosition(var_22_5:getContentSize().width - 10, var_22_5:getContentSize().height)
	var_22_5:addChild(var_22_6)
	var_22_6:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_24_0:isBright() then
			return
		end

		arg_24_0:setBright(false)
		self:exit(function()
			arg_24_0:setBright(true)
		end)
	end)

	local var_22_7 = ccui.Button:create("explore/bag_icon.png", nil, "explore/bag_icon.png", var_0_1)

	if var_22_4 then
		var_22_7 = ccui.Button:create("explore/hpInherit/bag_icon.png", nil, "explore/hpInherit/bag_icon.png", var_0_1)
	end

	var_22_7:setAnchorPoint(cc.p(1, 0))
	var_22_7:setPosition(638, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 2, TRANSFORM_UNIT.PX))
	var_22_7:setName("bagBnt")
	self.mapUIPanel:addChild(var_22_7)
	var_22_7:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:popExploreBag()
	end)
	self:initBtnArray(var_22_4)

	local var_22_8 = ccui.Button:create("explore/small_map_switch.png", nil, "explore/small_map_switch.png", var_0_1)

	var_22_8:setAnchorPoint(cc.p(1, 0))
	var_22_8:setPosition(638, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 100, TRANSFORM_UNIT.PX))
	var_22_8:setName("spaceBnt")
	self.mapUIPanel:addChild(var_22_8)
	var_22_8:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curRoomMap:switchSpace()
	end)

	if self.curMapConfig.npcLockConf and self.curMapConfig.npcLockConf.space and not self.curMapConfig.npcLockConf.space.is_have then
		var_22_8:setVisible(false)
	else
		var_22_8:setVisible(true)
	end

	local var_22_9 = ccui.Button:create("activitiesRes/activity" .. self.curMapConfig.activityid .. "/main/btnExploreBuff.png", nil, "activitiesRes/activity" .. self.curMapConfig.activityid .. "/main/btnExploreBuff.png")

	var_22_9:setScale(0.78)
	var_22_9:setAnchorPoint(cc.p(1, 0))
	var_22_9:setPosition(426, GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX))
	var_22_9:setName("buffBtn")
	self.mapUIPanel:addChild(var_22_9)
	var_22_9:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("ActivityBuffLayer_505")
	end)

	local var_22_10 = ccui.Layout:create()

	var_22_10:setTouchEnabled(true)
	var_22_10:setBackGroundImage("explore/small_map_bg.png", var_0_1)

	if var_22_4 then
		var_22_10:setBackGroundImage("explore/hpInherit/small_map_bg.png", var_0_1)
	end

	var_22_10:setAnchorPoint(cc.p(0, 0))
	var_22_10:setClippingEnabled(true)
	var_22_10:setPosition(7, 17)
	var_22_10:setContentSize(cc.size(168, 199))
	var_22_5:addChild(var_22_10, -1)
	var_22_10:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:popBigMap()
	end)

	self.smallMap = ccui.Layout:create()

	var_22_10:addChild(self.smallMap)

	local var_22_11 = ccui.ImageView:create("explore/room_name_bg.png", var_0_1)

	if var_22_4 then
		var_22_11 = ccui.ImageView:create("explore/hpInherit/room_name_bg.png", var_0_1)
	end

	var_22_11:setAnchorPoint(cc.p(0, 1))
	var_22_11:setPosition(0, 5)
	var_22_5:addChild(var_22_11, -1)

	self.roomName = cc.Label:createWithTTF("", FONT_NAME, 30)

	self.roomName:setPosition(var_22_11:getContentSize().width / 2, var_22_11:getContentSize().height / 2)
	var_22_11:addChild(self.roomName)

	local var_22_12 = ccui.Layout:create()

	var_22_12:setPosition(184, 20)
	var_22_12:setClippingEnabled(true)
	var_22_12:setContentSize(cc.size(450, 200))
	var_22_5:addChild(var_22_12)

	self.aimLayout = ccui.Layout:create()

	self.aimLayout:setPosition(-var_22_12:getPositionX(), -var_22_12:getPositionY())
	var_22_12:addChild(self.aimLayout)

	self.exploreProgressLayout = ccui.Layout:create()

	self.exploreProgressLayout:setVisible(false)
	self.exploreProgressLayout:setPosition(-var_22_12:getPositionX(), -var_22_12:getPositionY())
	var_22_12:addChild(self.exploreProgressLayout)
	self:initBloodUI()
	self:initExploreProgress()
	self:registerExploreBeginFightCallback()
end

function RogueExploreLayer.registerExploreBeginFightCallback(arg_30_0)
	if var_0_37:isHpInherit() then
		var_0_37:initHorcruxCache()
		var_0_37:setFightBeginCallback(function(arg_31_0)
			local var_31_0 = var_0_37.arrayIndex or 1

			local function var_31_1()
				arg_30_0.touchLock = false
			end

			local function var_31_2(arg_33_0)
				var_0_37:updateSelectedArray(arg_33_0)

				var_0_37.levelmode = arg_31_0
				var_0_37.dieCount = 0

				FightManager.refreshFightToType(FIGHTTYPE_ROGUEEXPLORE)
				LayerManager:switchShowLayer("FightLayer", {
					is_hide_topcost = true,
					is_hide_listbutton = true
				})
			end

			local var_31_3, var_31_4 = var_0_37:getCurrentFixArray()

			if var_0_37:isFixArray() then
				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationSpecialExploreLayer", {
					is_hp_inherit = true,
					fix_array = var_31_4,
					initindex = var_31_0,
					configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT,
					configCallback = var_31_2
				})
			else
				require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationExploreLayer", {
					is_hp_inherit = true,
					fix_array = var_31_4,
					initindex = var_31_0,
					configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT,
					fighttype = FIGHTTYPE_ROGUEEXPLORE,
					configCallback = var_31_2,
					customConfigexitCallback = var_31_1
				})
			end
		end)
	end
end

function RogueExploreLayer:initBtnArray(arg_34_1)
	if not arg_34_1 then
		return
	end

	local var_34_0 = self.mapUIPanel:getChildByName("bagBnt")
	local var_34_1 = ccui.Button:create("explore/hpInherit/team_icon.png", "explore/hpInherit/team_icon.png", "explore/hpInherit/team_icon.png", var_0_1)

	var_34_1:setAnchorPoint(var_34_0:getAnchorPoint())
	var_34_1:setPosition(var_34_0:getPositionX() - var_34_0:getContentSize().width - 20, (var_34_0:getPositionY()))
	self.mapUIPanel:addChild(var_34_1, 1, "btnArray")
	var_34_1:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_35_0 = var_0_37.arrayIndex or 1

		local function var_35_1()
			self.touchLock = false
		end

		local var_35_2, var_35_3 = var_0_37:getCurrentFixArray()
		local var_35_4 = {
			is_hp_inherit = true,
			initindex = var_35_0,
			configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT,
			fighttype = FIGHTTYPE_ROGUEEXPLORE,
			configcallback = function(arg_37_0)
				self.touchLock = false

				var_0_37:updateSelectedArray(arg_37_0)
			end,
			exitcallback = var_35_1,
			fix_array = var_35_3
		}

		if var_0_37:isFixArray() then
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationSpecialExploreLayer", var_35_4)
		else
			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationExploreLayer", var_35_4)
		end
	end)
end

function RogueExploreLayer:mapLoading(arg_38_1, arg_38_2)
	local var_38_0 = explore_aim_data[self.curAimId]
	local var_38_1 = "sound/" .. explore_aim_data[self.curAimId].bgm .. ".ogg"
	local var_38_2 = ccui.Layout:create()

	var_38_2:setContentSize(cc.size(640, GameDisplay.height))
	var_38_2:setTouchEnabled(true)
	global_basic_scene:addChild(var_38_2, 999)

	var_38_2.wait_ani = true
	var_38_2.wait_load = 2

	function var_38_2:initUI(arg_39_1)
		self.up = cc.Sprite:create("mainScenebg/explore/loading.jpg")

		self.up:setPosition(cc.p(320, GameDisplay.height / 2))
		self:addChild(self.up, 1)

		if config._DEBUG then
			self.title = cc.Sprite:create("explore/load_title.png") or cc.Sprite:createWithSpriteFrameName("explore/load_title.png")
		end

		self.title:setPosition(cc.p(480, 60))
		self:addChild(self.title, 2)

		self.points = {}

		for iter_39_0 = 1, 3 do
			local var_39_0

			if config._DEBUG then
				var_39_0 = cc.Sprite:create("explore/load_point.png") or cc.Sprite:createWithSpriteFrameName("explore/load_point.png")
			end

			var_39_0:setPosition(self.title:getPositionX() + self.title:getContentSize().width / 2 + 4 + (iter_39_0 - 1) * 12, 60)
			self:addChild(var_39_0, 2)

			self.points[iter_39_0] = var_39_0
		end
	end

	function var_38_2.startScheduler(arg_40_0)
		arg_40_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_41_0)
			if not arg_40_0.wait_ani and arg_40_0.wait_load <= 0 then
				arg_40_0:loadEnding()
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_40_0.scheduler)

				arg_40_0.scheduler = nil
			end
		end, 0.1, false)
	end

	function var_38_2:startLoading()
		local var_42_0 = var_0_37:getSpineList()

		print("??????spinelist>>>>>>>需要加载spine的list", dump(var_42_0))
		self:checkResource(var_42_0)
	end

	local file_check_manager = require("controller.filedownloader.file_check_manager")

	require("controller.filedownloader.download_node_utils"):addDownloadInterface(var_38_2)

	function var_38_2:checkResource(arg_43_1)
		self._downloadinglist = {}

		local var_43_0, var_43_1 = file_check_manager:checkSpineByIDList(arg_43_1)

		var_43_1 = var_43_1 or {}

		if file_check_manager:checkFileNeedDownload(var_38_1) then
			table.insert(var_43_1, file_check_manager:getFileDownloadInfo(var_38_1))
		end

		if #var_43_1 > 0 then
			self:startDownload(var_43_1)
		else
			self:onDownloadComplete()
		end
	end

	function var_38_2:startDownload(arg_44_1)
		self._downloadinglist = {}

		for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
			self._downloadinglist[iter_44_1.filename] = true
		end

		require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_44_1, "fight")
	end

	function var_38_2.onDownloadComplete(arg_45_0)
		local var_45_0 = {}

		if var_0_32[arg_38_1].fullImage:find(",") then
			for iter_45_0 in var_0_32[arg_38_1].fullImage:gmatch("([^,]+)") do
				table.insert(var_45_0, "tilemap/tiles_" .. iter_45_0 .. ".plist")
			end
		else
			var_45_0 = {
				"tilemap/tiles_" .. var_0_32[arg_38_1].fullImage .. ".plist"
			}
		end

		for iter_45_1, iter_45_2 in pairs(var_45_0) do
			local var_45_1

			if iter_45_2:find(".png") then
				var_45_1 = iter_45_2
			elseif iter_45_2:find(".plist") then
				var_45_1 = iter_45_2:match("(.+).plist") .. ".png"
			end

			cc.Director:getInstance():getTextureCache():addImageAsync(var_45_1, function()
				if iter_45_2:find(".plist") then
					cc.SpriteFrameCache:getInstance():addSpriteFrames(iter_45_2)
				end

				arg_45_0.wait_load = arg_45_0.wait_load - 1
			end)
		end

		audio_manager:loadAudio(var_38_1, function()
			arg_45_0.wait_load = arg_45_0.wait_load - 1
		end)
	end

	function var_38_2:startAction()
		for iter_48_0 = 1, 3 do
			self.points[iter_48_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create((iter_48_0 - 1) * 0.2), cc.JumpBy:create(0.2, cc.p(0, 0), 8, 1), cc.DelayTime:create(3 * 0.2 + 0.5 - (iter_48_0 - 1) * 0.2))))
		end

		self.wait_ani = false
	end

	function var_38_2:loadEnding()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			if arg_38_2 then
				arg_38_2()
			end

			for iter_50_0 = 1, 3 do
				self.points[iter_50_0]:stopAllActions()
			end

			audio_manager:switchLayerBGM("sound/" .. var_38_0.bgm, true)
		end), cc.RemoveSelf:create()))
	end

	var_38_2:initDownload()
	var_38_2:initUI()
	var_38_2:startScheduler()
	var_38_2:startLoading()
	var_38_2:startAction()
end

function RogueExploreLayer:removeCachedTextured()
	for iter_51_0, iter_51_1 in pairs({
		"tilemap/tiles_" .. var_0_32[self.curMapId].fullImage .. ".plist"
	}) do
		if iter_51_1:find(".png") then
			cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_51_1)
		elseif iter_51_1:find(".plist") then
			cc.SpriteFrameCache:getInstance():removeSpriteFramesFromFile(iter_51_1)
			cc.Director:getInstance():getTextureCache():removeTextureForKey(iter_51_1:match("(.+).plist") .. ".png")
		end
	end
end

function RogueExploreLayer:checkCurRoomLogo(arg_52_1)
	if not self.exploredRooms[arg_52_1] then
		return false
	end

	local function var_52_0(arg_53_0)
		return self.curMapConfig.aimTypeTbl[arg_53_0] and self.curMapConfig.aimTypeTbl[arg_53_0].result_type == "map" and self.curMapConfig.aimTypeTbl[arg_53_0].is_show
	end

	local function var_52_1(arg_54_0)
		if var_0_35[arg_54_0].show_class then
			return true
		else
			return false
		end
	end

	local function var_52_2(arg_55_0)
		return var_0_35[arg_55_0].class == TILE_TYPE.SPECIAL_ENEMY
	end

	local var_52_3
	local var_52_4
	local var_52_5

	for iter_52_0, iter_52_1 in pairs(self.usedTilesConfig[arg_52_1]) do
		var_52_3 = var_52_3 or var_52_0(iter_52_1.tileid)
		var_52_4 = var_52_4 or var_52_1(iter_52_1.tileid)
		var_52_5 = var_52_5 or var_52_2(iter_52_1.tileid)
	end

	local var_52_6

	if var_52_3 then
		var_52_6 = "aim"
	elseif var_52_4 then
		var_52_6 = "box"
	elseif var_52_5 then
		var_52_6 = "monster"
	end

	return var_52_6
end

function RogueExploreLayer:initSmallMap()
	local var_56_0 = 18
	local var_56_1 = cc.size(var_0_37:getCurMapMaxSize(var_0_32[self.curMapId].map_cad_id))

	self.smallMap:setContentSize(cc.size(var_56_1.width * 87 + (var_56_1.width - 1) * 18 + 40, var_56_1.height * 84 + (var_56_1.height - 1) * 18 + 40))
	self.smallMap:setScale(0.5)

	local var_56_2 = var_0_37:get_map_cad_config(var_0_32[self.curMapId].map_cad_id)

	for iter_56_0, iter_56_1 in pairs(var_56_2) do
		local var_56_3
		local var_56_4

		if self.roomPathTree[iter_56_0] then
			var_56_3 = iter_56_0 == self.curMapConfig.curRoomOrder and "explore/small_map_room2.png" or "explore/small_map_room1.png"
			var_56_4 = self:checkCurRoomLogo(iter_56_0)
		else
			var_56_3 = "explore/small_map_room3.png"
		end

		local var_56_5 = ccui.ImageView:create(var_56_3, var_0_1)

		if var_0_37:isHpInherit() and var_56_3 == "explore/small_map_room1.png" then
			var_56_5 = ccui.ImageView:create("explore/hpInherit/small_map_room1.png", var_0_1)
		end

		var_56_5:setName("room" .. iter_56_0)
		var_56_5:setPosition(20 + var_56_5:getContentSize().width / 2 + ((iter_56_0 - 1) % self.curMapSize.width + 1 - 1) * (var_56_0 + var_56_5:getContentSize().width), self.smallMap:getContentSize().height - 20 - var_56_5:getContentSize().height / 2 - (math.floor((iter_56_0 - 1) / self.curMapSize.width) + 1 - 1) * (var_56_0 + var_56_5:getContentSize().height))
		self.smallMap:addChild(var_56_5)

		if var_56_4 then
			local var_56_6 = ccui.ImageView:create(var_0_55[var_56_4], var_0_1)

			var_56_6:setPosition(var_56_5:getPositionX(), var_56_5:getPositionY())
			var_56_6:setName("logo" .. iter_56_0)

			var_56_6.show_type = var_56_4

			self.smallMap:addChild(var_56_6)
		end

		if self.roomPathTree[iter_56_0] then
			for iter_56_2, iter_56_3 in pairs(self.roomPathTree[iter_56_0].nexts) do
				local var_56_7 = var_0_37:getBridgeOrderByDirection(iter_56_0, iter_56_2)

				if not self.smallMap:getChildByName("bridge" .. var_56_7) then
					local var_56_8

					if self.bridgeLocks[var_56_7] then
						var_56_8 = ccui.ImageView:create("explore/small_map_path2.png", var_0_1)
					else
						var_56_8 = ccui.ImageView:create("explore/small_map_path1.png", var_0_1)

						if var_0_37:isHpInherit() then
							var_56_8 = ccui.ImageView:create("explore/hpInherit/small_map_path1.png", var_0_1)
						end
					end

					local var_56_9
					local var_56_10
					local var_56_11

					if iter_56_2 == var_0_42 then
						var_56_9 = var_56_5:getPositionX()
						var_56_10 = var_56_5:getPositionY() + var_56_5:getContentSize().height / 2 + var_56_8:getContentSize().height / 2
						var_56_11 = 0
					elseif iter_56_2 == var_0_44 then
						var_56_9 = var_56_5:getPositionX()
						var_56_10 = var_56_5:getPositionY() - var_56_5:getContentSize().height / 2 - var_56_8:getContentSize().height / 2
						var_56_11 = 0
					elseif iter_56_2 == var_0_45 then
						var_56_9 = var_56_5:getPositionX() - var_56_5:getContentSize().width / 2 - var_56_8:getContentSize().height / 2
						var_56_10 = var_56_5:getPositionY()
						var_56_11 = 90
					elseif iter_56_2 == var_0_43 then
						var_56_9 = var_56_5:getPositionX() + var_56_5:getContentSize().width / 2 + var_56_8:getContentSize().height / 2
						var_56_10 = var_56_5:getPositionY()
						var_56_11 = 90
					end

					var_56_8:setName("bridge" .. var_56_7)
					var_56_8:setPosition(var_56_9, var_56_10)
					var_56_8:setRotation(var_56_11)
					self.smallMap:addChild(var_56_8)
				end
			end
		end
	end

	function self.smallMap.updateExploredRoom(arg_57_0)
		local var_57_0
		local var_57_1 = cc.p(self.smallMap:getParent():getContentSize().width / 2, self.smallMap:getParent():getContentSize().height / 2)

		for iter_57_0, iter_57_1 in pairs(self.roomPathTree) do
			if self.exploredRooms[iter_57_0] then
				self.smallMap:getChildByName("room" .. iter_57_0):setVisible(true)
				self.smallMap:getChildByName("room" .. iter_57_0):stopAllActions()

				if iter_57_0 == self.curMapConfig.curRoomOrder then
					self.smallMap:getChildByName("room" .. iter_57_0):loadTexture("explore/small_map_room2.png", var_0_1)

					var_57_0 = cc.p(self.smallMap:getChildByName("room" .. iter_57_0):getPosition())

					self.smallMap:getChildByName("room" .. iter_57_0):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
				else
					self.smallMap:getChildByName("room" .. iter_57_0):loadTexture("explore/small_map_room1.png", var_0_1)

					if var_0_37:isHpInherit() then
						self.smallMap:getChildByName("room" .. iter_57_0):loadTexture("explore/hpInherit/small_map_room1.png", var_0_1)
					end
				end
			else
				self.smallMap:getChildByName("room" .. iter_57_0):loadTexture("explore/small_map_room3.png", var_0_1)
			end
		end

		self.smallMap:stopAllActions()
		self.smallMap:runAction(cc.MoveTo:create(0.3, cc.p(var_57_1.x - var_57_0.x * self.smallMap:getScale(), var_57_1.y - var_57_0.y * self.smallMap:getScale())))
	end

	function self.smallMap.updateByObject(arg_58_0, arg_58_1)
		local var_58_0 = self:checkCurRoomLogo(self.curRoomMap.curRoomOrder)
		local var_58_1 = self.smallMap:getChildByName("logo" .. self.curRoomMap.curRoomOrder)

		if var_58_0 then
			if not var_58_1 then
				local var_58_2 = self.smallMap:getChildByName("room" .. self.curRoomMap.curRoomOrder)
				local var_58_3 = ccui.ImageView:create(var_0_55[var_58_0], var_0_1)

				var_58_3:setPosition(var_58_2:getPositionX(), var_58_2:getPositionY())
				var_58_3:setName("logo" .. self.curRoomMap.curRoomOrder)

				var_58_3.show_type = var_58_0

				self.smallMap:addChild(var_58_3)
			elseif var_58_1.show_type ~= var_58_0 then
				var_58_1:loadTexture(var_0_55[var_58_0], var_0_1)

				var_58_1.show_type = var_58_0
			end
		elseif var_58_1 then
			var_58_1:removeFromParent()
		end
	end

	function self.smallMap.updateAll(arg_59_0)
		for iter_59_0, iter_59_1 in pairs(var_56_2) do
			local var_59_0 = self:checkCurRoomLogo(iter_59_0)
			local var_59_1 = self.smallMap:getChildByName("logo" .. iter_59_0)

			if var_59_0 then
				if not var_59_1 then
					local var_59_2 = self.smallMap:getChildByName("room" .. iter_59_0)
					local var_59_3 = ccui.ImageView:create(var_0_55[var_59_0], var_0_1)

					var_59_3:setPosition(var_59_2:getPositionX(), var_59_2:getPositionY())
					var_59_3:setName("logo" .. iter_59_0)

					var_59_3.show_type = var_59_0

					self.smallMap:addChild(var_59_3)
				elseif var_59_1.show_type ~= var_59_0 then
					var_59_1:loadTexture(var_0_55[var_59_0], var_0_1)

					var_59_1.show_type = var_59_0
				end
			elseif var_59_1 then
				var_59_1:removeFromParent()
			end
		end
	end

	self.smallMap:updateExploredRoom()
end

function RogueExploreLayer:popBigMap()
	if self.bigMap then
		self.bigMap:updateBigMap()
		self.bigMap:setVisible(true)

		return
	end

	self.bigMap = ccui.ScrollView:create()

	self.bigMap:setContentSize(cc.size(640, GameDisplay.height))
	self.bigMap:setTouchEnabled(true)
	self.bigMap:setDirection(cc.SCROLLVIEW_DIRECTION_BOTH)
	self.bigMap:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.bigMap:setBackGroundColor(cc.c3b(0, 0, 0))
	self.bigMap:setBackGroundColorOpacity(200)
	self.bigMap:setCascadeOpacityEnabled(false)
	self.bigMap:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.bigMap, 999)

	local var_60_0 = ccui.Layout:create()

	var_60_0:setTouchEnabled(false)
	self.bigMap:addChild(var_60_0, 999)

	local var_60_1 = cc.EventListenerTouchOneByOne:create()

	var_60_1:setSwallowTouches(false)
	var_60_1:registerScriptHandler(function(arg_61_0, arg_61_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_60_1:registerScriptHandler(function(arg_62_0, arg_62_1)
		local var_62_0 = var_60_0:convertToNodeSpace(arg_62_0:getStartLocation())
		local var_62_1 = var_60_0:convertToNodeSpace(arg_62_0:getLocation())

		if math.abs(var_62_1.x - var_62_0.x) < 50 and math.abs(var_62_1.y - var_62_0.y) < 50 then
			self.bigMap:setVisible(false)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_60_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_60_1, var_60_0)

	local var_60_2 = 87
	local var_60_3 = 84
	local var_60_4 = 18
	local var_60_5 = cc.size(var_0_37:getCurMapMaxSize(var_0_32[self.curMapId].map_cad_id))
	local var_60_6 = var_60_5.width * 87 + (var_60_5.width - 1) * 18 + 40
	local var_60_7 = var_60_5.height * 84 + (var_60_5.width - 1) * 18 + 40

	var_60_6 = var_60_5.width * 87 + (var_60_5.width - 1) * 18 + 40 < self.bigMap:getContentSize().width and self.bigMap:getContentSize().width or var_60_6
	var_60_7 = var_60_7 < self.bigMap:getContentSize().height and self.bigMap:getContentSize().height or var_60_7

	self.bigMap:setInnerContainerSize(cc.size(1200, var_60_7))

	local function var_60_8(arg_63_0)
		if self.curMapConfig.curRoomOrder > 100 then
			return arg_63_0 > 100
		else
			return arg_63_0 <= 100
		end
	end

	for iter_60_0, iter_60_1 in pairs((var_0_37:get_map_cad_config(var_0_32[self.curMapId].map_cad_id))) do
		local var_60_9
		local var_60_10

		if self.roomPathTree[iter_60_0] then
			var_60_9 = iter_60_0 == self.curMapConfig.curRoomOrder and "explore/small_map_room2.png" or self.exploredRooms[iter_60_0] and "explore/small_map_room1.png" or "explore/small_map_room3.png"
			var_60_10 = self:checkCurRoomLogo(iter_60_0)
		else
			var_60_9 = "explore/small_map_room3.png"
		end

		local var_60_11 = ccui.ImageView:create(var_60_9, var_0_1)

		if var_0_37:isHpInherit() and var_60_9 == "explore/small_map_room1.png" then
			var_60_11 = ccui.ImageView:create("explore/hpInherit/small_map_room1.png", var_0_1)
		end

		var_60_11:setName("room" .. iter_60_0)
		var_60_11:setPosition(var_60_6 / 2 + ((iter_60_0 - 1) % self.curMapSize.width + 1 - (var_60_5.width + 1) / 2) * (var_60_4 + var_60_2), var_60_7 / 2 + ((var_60_5.height + 1) / 2 - (math.floor((iter_60_0 - 1) / self.curMapSize.width) + 1)) * (var_60_4 + var_60_3))
		self.bigMap:addChild(var_60_11)

		if var_60_9 == "explore/small_map_room2.png" then
			var_60_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
		end

		if var_60_10 then
			local var_60_12 = ccui.ImageView:create(var_0_55[var_60_10], var_0_1)

			var_60_12:setPosition(var_60_11:getPositionX(), var_60_11:getPositionY())
			var_60_12:setName("logo" .. iter_60_0)

			var_60_12.show_type = var_60_10

			self.bigMap:addChild(var_60_12)
		end

		if self.roomPathTree[iter_60_0] then
			for iter_60_2, iter_60_3 in pairs(self.roomPathTree[iter_60_0].nexts) do
				local var_60_13 = var_0_37:getBridgeOrderByDirection(iter_60_0, iter_60_2)

				if not self.bigMap:getChildByName("bridge" .. var_60_13) then
					local var_60_14

					if self.bridgeLocks[var_60_13] then
						var_60_14 = ccui.ImageView:create("explore/small_map_path2.png", var_0_1)
						var_60_14.is_yellow = true
					else
						var_60_14 = ccui.ImageView:create("explore/small_map_path1.png", var_0_1)

						if var_0_37:isHpInherit() then
							var_60_14 = ccui.ImageView:create("explore/hpInherit/small_map_path1.png", var_0_1)
						end
					end

					local var_60_15
					local var_60_16
					local var_60_17

					if iter_60_2 == var_0_42 then
						var_60_15 = var_60_11:getPositionX()
						var_60_16 = var_60_11:getPositionY() + var_60_11:getContentSize().height / 2 + var_60_14:getContentSize().height / 2
						var_60_17 = 0
					elseif iter_60_2 == var_0_44 then
						var_60_15 = var_60_11:getPositionX()
						var_60_16 = var_60_11:getPositionY() - var_60_11:getContentSize().height / 2 - var_60_14:getContentSize().height / 2
						var_60_17 = 0
					elseif iter_60_2 == var_0_45 then
						var_60_15 = var_60_11:getPositionX() - var_60_11:getContentSize().width / 2 - var_60_14:getContentSize().height / 2
						var_60_16 = var_60_11:getPositionY()
						var_60_17 = 90
					elseif iter_60_2 == var_0_43 then
						var_60_15 = var_60_11:getPositionX() + var_60_11:getContentSize().width / 2 + var_60_14:getContentSize().height / 2
						var_60_16 = var_60_11:getPositionY()
						var_60_17 = 90
					end

					var_60_14:setName("bridge" .. var_60_13)
					var_60_14:setPosition(var_60_15, var_60_16)
					var_60_14:setRotation(var_60_17)
					self.bigMap:addChild(var_60_14)
				end
			end
		end
	end

	function self.bigMap.updateBigMap(arg_64_0)
		local var_64_1 = cc.p(self.bigMap:getContentSize().width / 2, self.bigMap:getContentSize().height / 2)
		local var_64_2 = var_0_37:isHpInherit()

		for iter_64_0, iter_64_1 in pairs(self.roomPathTree) do
			if self.exploredRooms[iter_64_0] then
				self.bigMap:getChildByName("room" .. iter_64_0):setVisible(true)
				self.bigMap:getChildByName("room" .. iter_64_0):stopAllActions()

				if iter_64_0 == self.curMapConfig.curRoomOrder then
					self.bigMap:getChildByName("room" .. iter_64_0):loadTexture("explore/small_map_room2.png", var_0_1)

					local var_64_3 = cc.p(self.bigMap:getChildByName("room" .. iter_64_0):getPosition())

					self.bigMap:getChildByName("room" .. iter_64_0):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 80), cc.FadeTo:create(1, 255))))
				else
					self.bigMap:getChildByName("room" .. iter_64_0):loadTexture("explore/small_map_room1.png", var_0_1)

					if var_64_2 then
						self.bigMap:getChildByName("room" .. iter_64_0):loadTexture("explore/hpInherit/small_map_room1.png", var_0_1)
					end
				end
			else
				self.bigMap:getChildByName("room" .. iter_64_0):loadTexture("explore/small_map_room3.png", var_0_1)
			end

			local var_64_4 = self:checkCurRoomLogo(iter_64_0)
			local var_64_5 = self.bigMap:getChildByName("logo" .. iter_64_0)

			if var_64_4 then
				if not var_64_5 then
					local var_64_6 = self.bigMap:getChildByName("room" .. iter_64_0)
					local var_64_7 = ccui.ImageView:create(var_0_55[var_64_4], var_0_1)

					var_64_7:setPosition(var_64_6:getPositionX(), var_64_6:getPositionY())
					var_64_7:setName("logo" .. iter_64_0)

					var_64_7.show_type = var_64_4

					self.bigMap:addChild(var_64_7)
				elseif var_64_5.show_type ~= var_64_4 then
					var_64_5:loadTexture(var_0_55[var_64_4], var_0_1)

					var_64_5.show_type = var_64_4
				end
			elseif var_64_5 then
				var_64_5:removeFromParent()
			end

			local var_64_8 = var_60_8(iter_64_0)

			if self.bigMap:getChildByName("room" .. iter_64_0) then
				self.bigMap:getChildByName("room" .. iter_64_0):setVisible(var_64_8)
			end

			if self.bigMap:getChildByName("logo" .. iter_64_0) then
				self.bigMap:getChildByName("logo" .. iter_64_0):setVisible(var_64_8)
			end
		end

		for iter_64_2, iter_64_3 in pairs(self.aimTypeTbl) do
			if iter_64_3.result_type == "bridge" then
				if not self.bridgeLocks[iter_64_3.result_param1] and self.bigMap:getChildByName("bridge" .. iter_64_3.result_param1).is_yellow then
					self.bigMap:getChildByName("bridge" .. iter_64_3.result_param1):loadTexture("explore/small_map_path1.png", var_0_1)

					if var_64_2 then
						self.bigMap:getChildByName("bridge" .. iter_64_3.result_param1):loadTexture("explore/hpInherit/small_map_path1.png", var_0_1)
					end

					self.bigMap:getChildByName("bridge" .. iter_64_3.result_param1).is_yellow = false
				end
			end
		end

		local var_64_9 = self.curMapConfig.curRoomOrder > 100 and 126 or 26
		local var_64_10 = cc.p(0, 0)

		var_64_10.y = self.bigMap:getChildByName("room" .. (self.curMapConfig.curRoomOrder > 100 and 126 or 26)):getPositionY() - 130
		var_64_10.x = self.bigMap:getChildByName("room" .. var_64_9):getPositionX()

		self.bigMap:getInnerContainer():setPosition(var_64_1.x - var_64_10.x * self.bigMap:getInnerContainer():getScale(), var_64_1.y - var_64_10.y * self.bigMap:getInnerContainer():getScale())
	end

	self.bigMap:updateBigMap()
end

function RogueExploreLayer:popExploreBag()
	local var_65_0 = ccui.Layout:create()

	var_65_0:setTouchEnabled(true)
	var_65_0:setContentSize(cc.size(640, GameDisplay.height))
	var_65_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_65_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_65_0:setBackGroundColorOpacity(200)
	var_65_0:setCascadeOpacityEnabled(false)
	var_65_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_65_0, 999)

	local var_65_1 = ccui.ImageView:create("explore/bag_effect.png", var_0_1)

	if var_0_37:isHpInherit() then
		var_65_1 = ccui.ImageView:create("explore/hpInherit/bag_effect.png", var_0_1)
	end

	var_65_1:setAnchorPoint(cc.p(1, 0))
	var_65_1:setPosition(638, 2)
	var_65_0:addChild(var_65_1)
	var_65_1:setScale(0)
	var_65_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))
	var_65_0:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_65_1:stopAllActions()
		var_65_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0, 0), cc.CallFunc:create(function()
			var_65_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
	print(dump(self.curMapConfig.itemcache))

	if next(self.curMapConfig.itemcache) == nil then
		local var_65_2 = cc.Label:createWithTTF(L_EXPLOREMAP_BAG.Empty, FONT_TITLE, 40)

		var_65_2:setPosition(var_65_1:getContentSize().width / 2 - 20, var_65_1:getContentSize().height / 2 + 160)
		var_65_2:setOpacity(200)
		var_65_1:addChild(var_65_2, 9)
	end

	local var_65_3 = ccui.ScrollView:create()

	var_65_3:setBounceEnabled(true)

	local var_65_4 = table.nums(self.curMapConfig.itemcache)
	local var_65_5 = var_65_4 * 200 < 507 and 507 or var_65_4 * 200

	var_65_3:setInnerContainerSize(cc.size(508, var_65_4 * 200 < 507 and 507 or var_65_4 * 200))
	var_65_3:setDirection(ccui.ScrollViewDir.vertical)
	var_65_3:setContentSize(cc.size(508, 507))
	var_65_3:setAnchorPoint(cc.p(0, 0))
	var_65_3:setPosition(6, 276)
	var_65_1:addChild(var_65_3)

	local var_65_6 = 1

	for iter_65_0, iter_65_1 in pairs(self.curMapConfig.itemcache) do
		local var_65_7 = ItemSprite:createNewWithItemId(iter_65_1.itemid, iter_65_1.number)

		var_65_7:setScale(0.8)
		var_65_7:setAnchorPoint(cc.p(0, 0))
		var_65_7:setPosition(4 + (var_65_6 - 1) % 3 * 176, var_65_5 - (math.floor((var_65_6 - 1) / 3) + 1) * 200)
		var_65_3:addChild(var_65_7)
		var_65_7:setTouchEnabled(true)
		var_65_7:addSpriteTouchEventListener(function(arg_68_0, arg_68_1)
			if arg_68_1 ~= ccui.TouchEventType.ended then
				return
			end

			PopLayer:Item({
				hideGainButton = true,
				itemid = iter_65_1.itemid,
				itemnum = iter_65_1.number
			})
		end)

		if item_data[iter_65_1.itemid].buffid then
			local var_65_8 = ccui.ImageView:create("explore/item_tips_buff.png", var_0_1)

			var_65_8:setAnchorPoint(cc.p(0, 1))
			var_65_8:setPosition(0, var_65_7:getContentSize().height)
			var_65_7:addChild(var_65_8, 99)
		elseif item_data[iter_65_1.itemid].bag_item_type == kITEM_EXPLORE_ITEM then
			local var_65_9 = ccui.ImageView:create("explore/item_tips.png", var_0_1)

			var_65_9:setAnchorPoint(cc.p(0, 1))
			var_65_9:setPosition(0, var_65_7:getContentSize().height)
			var_65_7:addChild(var_65_9, 99)
		end

		var_65_6 = var_65_6 + 1
	end
end

function RogueExploreLayer:initAimUI()
	local var_69_0 = var_0_37:isHpInherit()
	local var_69_1 = ccui.ImageView:create("explore/aim_title_bg1.png", var_0_1)

	if var_69_0 then
		var_69_1 = ccui.ImageView:create("explore/hpInherit/aim_title_bg1.png", var_0_1)
	end

	var_69_1:setAnchorPoint(cc.p(0, 0.5))
	var_69_1:setPosition(186, 200)
	self.aimLayout:addChild(var_69_1)

	local var_69_2 = cc.Label:createWithTTF(L_EXPLOREMAP_AIM.Title[1], FONT_NAME, 26)

	var_69_2:setAnchorPoint(cc.p(0, 0.5))
	var_69_2:setPosition(15, var_69_1:getContentSize().height / 2)
	var_69_1:addChild(var_69_2)

	local var_69_3 = ccui.ImageView:create("explore/aim_title_bg2.png", var_0_1)

	if var_69_0 then
		var_69_3 = ccui.ImageView:create("explore/hpInherit/aim_title_bg2.png", var_0_1)
	end

	var_69_3:setName("aimTile2")
	var_69_3:setAnchorPoint(cc.p(0, 0.5))
	var_69_3:setPosition(186, 80)
	self.aimLayout:addChild(var_69_3)

	local var_69_4 = cc.Label:createWithTTF(L_EXPLOREMAP_AIM.Title[2], FONT_NAME, 26)

	var_69_4:setAnchorPoint(cc.p(0, 0.5))
	var_69_4:setPosition(15, var_69_1:getContentSize().height / 2)
	var_69_3:addChild(var_69_4)

	local var_69_5 = {}
	local var_69_6 = true
	local var_69_7 = true

	for iter_69_0, iter_69_1 in pairs(self.aimTypeTbl) do
		if iter_69_1.result_type == "map" then
			table.insert(var_69_5, iter_69_1)
		elseif var_69_6 then
			table.insert(var_69_5, iter_69_1)

			var_69_6 = false
		end

		if iter_69_1.result_type == "map" and iter_69_1.flag < iter_69_1.num then
			var_69_7 = false
		end
	end

	local var_69_8 = var_69_6 and {
		cc.p(200, 160),
		cc.p(200, 120),
		cc.p(200, 80),
		cc.p(200, 40)
	} or {
		cc.p(200, 160),
		cc.p(200, 120),
		cc.p(200, 45)
	}

	for iter_69_2, iter_69_3 in pairs(var_69_5) do
		local var_69_9 = ccui.Layout:create()

		var_69_9:setVisible(iter_69_3.is_show)
		var_69_9:setName("aim" .. iter_69_3.tileid)

		var_69_9.aimInfo = iter_69_3
		var_69_9.tileid = iter_69_3.tileid

		self.aimLayout:addChild(var_69_9)

		local var_69_10 = cc.DrawNode:create()

		var_69_10:setName("drawNode")
		var_69_9:addChild(var_69_10, 9)

		local var_69_11 = ccui.ImageView:create("explore/aim_bg.png", var_0_1)

		var_69_11:setName("aim_bg")
		var_69_11:setVisible(false)
		var_69_11:setAnchorPoint(cc.p(0, 0.5))
		var_69_11:setPosition(var_69_8[iter_69_3.order].x - 18, var_69_8[iter_69_3.order].y)
		var_69_9:addChild(var_69_11)

		local var_69_12 = ccui.ImageView:create("explore/aim_light.png", var_0_1)

		if var_69_0 then
			var_69_12 = ccui.ImageView:create("explore/hpInherit/aim_light.png", var_0_1)
		end

		var_69_12.img_n = "explore/aim_light.png"
		var_69_12.img_s = "explore/aim_yellow_point.png"

		var_69_12:setName("aim_point")
		var_69_12:setPosition(var_69_8[iter_69_3.order])
		var_69_9:addChild(var_69_12)

		local var_69_13 = cc.Label:createWithTTF(iter_69_3.flag .. "/" .. iter_69_3.num, FONT_NAME, 25)
		local var_69_14 = cc.Label:createWithTTF(iter_69_3.des .. "(", FONT_NAME, 25)
		local var_69_15 = var_69_14:getContentSize().width
		local var_69_16 = " "

		for iter_69_4 = 1, string.len(iter_69_3.flag .. "/" .. iter_69_3.num) do
			var_69_16 = var_69_16 .. " "
		end

		var_69_14:setString(iter_69_3.des .. "(" .. var_69_16 .. ")")
		var_69_14:setColor(cc.c3b(64, 154, 192))
		var_69_14:setAnchorPoint(cc.p(0, 0.5))
		var_69_14:setPosition(var_69_12:getPositionX() + var_69_12:getContentSize().width / 2 + 4, var_69_12:getPositionY())
		var_69_14:setName("aim_des")

		var_69_14.color_n = cc.c3b(64, 154, 192)
		var_69_14.color_s = cc.c3b(255, 154, 0)

		var_69_13:setAnchorPoint(cc.p(0, 0.5))
		var_69_13:setPosition(var_69_14:getPositionX() + var_69_15 + 4, var_69_12:getPositionY())
		var_69_13:setColor(cc.c3b(60, 192, 159))
		var_69_13:setName("aim_label")
		var_69_9:addChild(var_69_14)
		var_69_9:addChild(var_69_13)

		local var_69_17 = ccui.ImageView:create("explore/aim_box.png", var_0_1)

		if var_69_0 then
			var_69_17 = ccui.ImageView:create("explore/hpInherit/aim_box.png", var_0_1)
		end

		var_69_17:setName("aim_box")
		var_69_17:setPosition(608, var_69_12:getPositionY())
		var_69_9:addChild(var_69_17)

		function var_69_9:finish_action()
			local var_70_0 = 0.5
			local var_70_1 = 0
			local var_70_2 = cc.p(var_69_12:getPosition())

			var_69_10:stopAllActions()
			var_69_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				var_70_1 = var_70_1 + 1

				var_69_10:clear()
				var_69_10:drawSegment(var_70_2, cc.p(var_69_12:getPositionX() + var_70_1 * 0.016666666666666666 * (var_69_14:getContentSize().width + var_69_12:getContentSize().width / 2 + 4) / var_70_0, var_69_12:getPositionY()), 2, cc.c4f(0.2549019607843137, 0.6509803921568628, 0.8196078431372549, 1))

				if var_70_1 * 0.016666666666666666 >= var_70_0 then
					var_69_10:stopAllActions()
					var_69_9:setOpacity(120)
				end
			end))))

			local var_70_3 = var_69_9:getChildByName("finish_aim_box")

			if not var_70_3 then
				var_70_3 = ccui.ImageView:create("explore/aim_box2.png", var_0_1)

				var_70_3:setName("finish_aim_box")
				var_70_3:setPosition(var_69_17:getPosition())
				var_69_9:addChild(var_70_3)
			end

			var_70_3:setVisible(true)
			var_70_3:setScale(3)
			var_70_3:runAction(cc.ScaleTo:create(0.5, 1))

			if self.aimInfo.result_type == "bridge" then
				local var_70_4 = self.aimInfo.result_param1
				local var_70_5 = not not var_0_37:checkBridegRoomClosed(self.curRoomMap.curRoomOrder, self.aimInfo.result_param1)

				if var_70_5 then
					self.isBridgeAction = self.aimInfo.result_param1
				end

				var_69_9:stopAllActions()
				var_69_9:runAction(cc.Sequence:create(cc.DelayTime:create(0.8), cc.MoveBy:create(0.1, cc.p(40, 0)), cc.MoveBy:create(0.3, cc.p(-450, 0)), cc.Hide:create(), cc.CallFunc:create(function()
					var_69_3:setVisible(false)
					self.smallMap:getChildByName("bridge" .. var_70_4):loadTexture("explore/small_map_path1.png", var_0_1)

					if var_69_0 then
						self.smallMap:getChildByName("bridge" .. var_70_4):loadTexture("explore/hpInherit/small_map_path1.png", var_0_1)
					end

					self.curRoomMap:popTalkSp(L_EXPLOREMAP_AIM.TalkSp)

					if var_70_5 then
						self.curRoomMap:updateBoundUI(var_70_4)
					end
				end)))
			end
		end

		if iter_69_3.result_type == "bridge" then
			self.aimLayout.bridge_aim_panel = var_69_9

			function var_69_9.bridge_aim_panel_reset(arg_73_0, arg_73_1)
				var_69_9:setVisible(true)
				var_69_3:setVisible(true)

				if arg_73_1.tileid == var_69_9.tileid then
					return
				end

				var_69_9.tileid = arg_73_1.tileid
				var_69_9.aimInfo = arg_73_1

				var_69_9:setName("aim" .. arg_73_1.tileid)
				var_69_9:setPositionX(450)
				var_69_9:setOpacity(255)

				var_69_9.isfinish = false

				var_69_10:clear()

				if var_69_9:getChildByName("finish_aim_box") then
					var_69_9:getChildByName("finish_aim_box"):setVisible(false)
				end

				var_69_9:runAction(cc.Sequence:create(cc.MoveTo:create(0.4, cc.p(-20, var_69_9:getPositionY())), cc.MoveTo:create(0.05, cc.p(20, var_69_9:getPositionY())), cc.MoveTo:create(0.05, cc.p(0, var_69_9:getPositionY()))))
				var_69_14:setString(arg_73_1.des .. "(")

				local var_73_0 = " "

				for iter_73_0 = 1, string.len(arg_73_1.flag .. "/" .. arg_73_1.num) do
					var_73_0 = var_73_0 .. " "
				end

				var_69_14:setString(arg_73_1.des .. "(" .. var_73_0 .. ")")
				var_69_13:setString(arg_73_1.flag .. "/" .. arg_73_1.num)
				var_69_13:setPositionX(var_69_14:getPositionX() + var_69_14:getContentSize().width + 4)
			end
		else
			function var_69_9.show_main_aim_by_object(arg_74_0, arg_74_1)
				var_69_9:setPositionX(410)
				var_69_9:setVisible(true)
				var_69_9:runAction(cc.Sequence:create(cc.MoveTo:create(0.4, cc.p(-20, var_69_9:getPositionY())), cc.MoveTo:create(0.05, cc.p(20, var_69_9:getPositionY())), cc.MoveTo:create(0.05, cc.p(0, var_69_9:getPositionY()))))
			end
		end

		if iter_69_3.flag >= iter_69_3.num then
			var_69_9:finish_action()
		end
	end

	if var_69_7 then
		self.isMainAimFinish = true

		self.aimLayout:setVisible(false)
		self.exploreProgressLayout:setVisible(true)
		self:updateEffect()
		self.mapUIPanel:getChildByName("topbg"):getChildByName("mapGiveupBnt"):loadTextures("explore/map_finish.png", nil, "explore/map_finish.png", var_0_1)
	end

	function self.aimLayout.updateAim(arg_75_0, arg_75_1)
		if not self.aimTypeTbl[arg_75_1] then
			return
		end

		local var_75_0 = self.aimLayout:getChildByName("aim" .. self.aimTypeTbl[arg_75_1].tileid)

		if var_75_0 and var_75_0.isfinish then
			return
		end

		if var_75_0 then
			var_75_0:getChildByName("aim_label"):setString(self.aimTypeTbl[arg_75_1].flag .. "/" .. self.aimTypeTbl[arg_75_1].num)

			if self.aimTypeTbl[arg_75_1].flag >= self.aimTypeTbl[arg_75_1].num and not var_75_0.isfinish then
				var_75_0.isfinish = true

				var_75_0:finish_action()
			end
		end

		local var_75_1 = true

		for iter_75_0, iter_75_1 in pairs(self.aimTypeTbl) do
			if iter_75_1.result_type == "map" and iter_75_1.flag < iter_75_1.num then
				var_75_1 = false
			end
		end

		if var_75_1 and self.aimTypeTbl[arg_75_1].result_type == "map" then
			self.isMainAimFinish = true

			self.aimLayout:setVisible(false)
			self.exploreProgressLayout:setVisible(true)
			self:playAimFinishAni()
			self:updateEffect()
		end
	end

	function self.aimLayout.triggerAim(arg_76_0, arg_76_1)
		local var_76_0 = self.aimLayout:getChildByName("aim" .. arg_76_1)

		var_76_0:stopAllActions()
		var_76_0:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			var_76_0:getChildByName("aim_bg"):setVisible(true)
			var_76_0:getChildByName("aim_point"):loadTexture(var_76_0:getChildByName("aim_point").img_s, var_0_1)
			var_76_0:getChildByName("aim_des"):setColor(var_76_0:getChildByName("aim_des").color_s)
		end), cc.MoveTo:create(0.1, cc.p(-10, 0)), cc.MoveTo:create(0.2, cc.p(10, 0)), cc.MoveTo:create(0.2, cc.p(-10, 0)), cc.MoveTo:create(0.4, cc.p(10, 0)), cc.MoveTo:create(0.3, cc.p(-10, 0)), cc.MoveTo:create(0.3, cc.p(0, 0)), cc.CallFunc:create(function()
			var_76_0:getChildByName("aim_bg"):setVisible(false)
			var_76_0:getChildByName("aim_point"):loadTexture(var_76_0:getChildByName("aim_point").img_n, var_0_1)
			var_76_0:getChildByName("aim_des"):setColor(var_76_0:getChildByName("aim_des").color_n)
		end)))
	end
end

function RogueExploreLayer:updateEffect()
	if self.mapPanel:getChildByTag(123) then
		self.mapPanel:getChildByTag(123):removeFromParent()
	end

	if self.mapPanel:getChildByTag(456) then
		self.mapPanel:getChildByTag(456):removeFromParent()
	end

	if self.mapPanel:getChildByTag(789) then
		self.mapPanel:getChildByTag(789):removeFromParent()
	end
end

function RogueExploreLayer:playAimFinishAni()
	local function var_80_0()
		local var_81_0 = self.mapUIPanel:getChildByName("topbg"):getChildByName("mapGiveupBnt")

		var_81_0:setPositionX(var_81_0:getParent():getContentSize().width + var_81_0:getContentSize().width)
		var_81_0:loadTextures("explore/map_finish.png", nil, "explore/map_finish.png", var_0_1)

		local var_81_1 = ccui.ImageView:create("explore/map_finish_bg.png", var_0_1)

		if var_0_37:isHpInherit() then
			var_81_1 = ccui.ImageView:create("explore/hpInherit/map_finish_bg.png", var_0_1)
		end

		var_81_1:setAnchorPoint(cc.p(1, 1))
		var_81_1:setPosition(var_81_0:getContentSize().width, var_81_0:getContentSize().height)
		var_81_0:addChild(var_81_1, -1)
		var_81_0:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_81_0:getParent():getContentSize().width, var_81_0:getPositionY()))))

		for iter_81_0 = 1, 2 do
			local var_81_2 = ccui.ImageView:create("explore/map_finish_frame.png", var_0_1)

			var_81_2:setAnchorPoint(cc.p(1, 1))
			var_81_2:setPosition(var_81_0:getContentSize().width, var_81_0:getContentSize().height)
			var_81_0:addChild(var_81_2)
			var_81_2:runAction(cc.Sequence:create(cc.DelayTime:create((iter_81_0 - 1) * 0.4), cc.CallFunc:create(function()
				var_81_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.8, 1.1), cc.FadeOut:create(0.8)), cc.CallFunc:create(function()
					var_81_2:setScale(1)
					var_81_2:setOpacity(255)
				end))))
			end)))
		end
	end

	local function var_80_1()
		if self.curMapConfig.isrepeat then
			var_80_0()

			return
		end

		local var_84_0 = ccui.Layout:create()

		var_84_0:setTouchEnabled(true)
		var_84_0:setContentSize(cc.size(640, GameDisplay.height))
		var_84_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_84_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_84_0:setBackGroundColorOpacity(200)
		var_84_0:setCascadeOpacityEnabled(false)
		var_84_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_84_0, 999)

		local var_84_1 = ccui.Layout:create()

		var_84_1:setPositionY(GameDisplay.height / 2 - 100)
		var_84_1:setVisible(false)
		var_84_1:setScaleY(0.01)
		var_84_0:addChild(var_84_1, 9)
		var_84_0:setBackGroundColorOpacity(0)
		audio_manager:playeffectMusicTest("sound/achievement")
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("chenggong.ExportJson")

		local var_84_3 = ccs.Armature:create("chenggong")

		var_84_3:setPosition(320, GameDisplay.height / 2)
		var_84_0:addChild(var_84_3)
		var_84_3:getAnimation():play("Animation1")
		var_84_3:getAnimation():setFrameEventCallFunc(function(arg_85_0, arg_85_1, arg_85_2, arg_85_3)
			if arg_85_1 == "end1" then
				var_84_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
			elseif arg_85_1 == "end2" then
				var_84_0.lock = false
			elseif arg_85_1 == "end3" then
				var_84_0:runAction(cc.RemoveSelf:create())
			end
		end)
		var_84_0:addTouchEventListener(function(arg_86_0, arg_86_1)
			if arg_86_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_84_0.lock then
				return
			end

			var_84_0.lock = true

			var_84_0:runAction(cc.RemoveSelf:create())
		end)
		var_80_0()
	end

	if explore_aim_data[self.curMapConfig.aimid].aim_finish_talk then
		global_basic_scene:addChild(TalkLayer:create(explore_aim_data[self.curMapConfig.aimid].aim_finish_talk, nil, TALK_TYPE_NORMAL, "", var_80_1), 999)
	else
		var_80_1()
	end
end

function RogueExploreLayer:initExploreProgress()
	local var_87_0 = ccui.Button:create("explore/box_icon.png", nil, nil, var_0_1)

	var_87_0:setOpacity(200)
	var_87_0:setAnchorPoint(cc.p(1, 0.5))
	var_87_0:setPosition(640, 110)
	var_87_0:setName("boxicon")
	self.exploreProgressLayout:addChild(var_87_0)

	self.exploreProgressBar = ccui.Layout:create()

	self.exploreProgressLayout:addChild(self.exploreProgressBar)

	local var_87_1 = var_0_37:isHpInherit()

	for iter_87_0 = 1, 20 do
		local var_87_2 = ccui.ImageView:create("explore/bar_bg.png", var_0_1)

		if var_87_1 then
			var_87_2 = ccui.ImageView:create("explore/hpInherit/bar_bg.png", var_0_1)
		end

		var_87_2:setPosition(610, 40 + (iter_87_0 - 1) * 8)
		self.exploreProgressBar:addChild(var_87_2)

		local var_87_3 = ccui.ImageView:create("explore/bar_icon.png", var_0_1)

		if var_87_1 then
			local var_87_4 = ccui.ImageView:create("explore/hpInherit/bar_icon.png", var_0_1)
		end

		var_87_3:setVisible(false)
		var_87_3:setName("bar_icon" .. iter_87_0)
		var_87_3:setPosition(610, 40 + (iter_87_0 - 1) * 8)
		self.exploreProgressBar:addChild(var_87_3)
	end

	function self.exploreProgressBar.setPercentage(arg_88_0, arg_88_1)
		local var_88_0 = math.floor(arg_88_1 / 100 * 20)

		for iter_88_0 = 1, 20 do
			if iter_88_0 <= var_88_0 then
				self.exploreProgressBar:getChildByName("bar_icon" .. iter_88_0):setVisible(true)
			else
				self.exploreProgressBar:getChildByName("bar_icon" .. iter_88_0):setVisible(false)
			end
		end
	end

	self.exploreProgressLabel = cc.Label:createWithTTF(var_0_37:getMapProgress() .. "%", FONT_NAME, 14)

	self.exploreProgressLabel:setColor(cc.c3b(138, 213, 255))
	self.exploreProgressLabel:setPosition(610, 28)
	self.exploreProgressLayout:addChild(self.exploreProgressLabel)

	local var_87_5 = ccui.ScrollView:create()

	var_87_5:setContentSize(cc.size(320, 200))
	var_87_5:setPosition(180, 20)
	self.exploreProgressLayout:addChild(var_87_5)

	local var_87_6 = table.nums(var_0_37.curMapConfig.mapProgress)
	local var_87_7 = 60 + 30 * var_87_6 < 200 and 200 or 60 + 30 * table.nums(var_0_37.curMapConfig.mapProgress)

	var_87_5:setInnerContainerSize(cc.size(180, var_87_7))

	local var_87_8 = 1

	for iter_87_1, iter_87_2 in pairs(var_0_37.curMapConfig.mapProgress) do
		local var_87_9 = ccui.Layout:create()

		if var_87_7 > 200 then
			var_87_9:setPosition(26, var_87_7 - 30 - (var_87_8 - 1) * 30)
		else
			var_87_9:setPosition(26, var_87_7 / 2 + (var_87_8 - (var_87_6 + 1) / 2) * 30)
		end

		var_87_5:addChild(var_87_9)

		self.exploreProgressList[iter_87_1] = var_87_9

		local var_87_10 = cc.DrawNode:create()

		var_87_10:setName("drawNode")
		var_87_9:addChild(var_87_10)

		local var_87_11 = ccui.ImageView:create("explore/aim_light.png", var_0_1)

		if var_87_1 then
			var_87_11 = ccui.ImageView:create("explore/hpInherit/aim_light.png", var_0_1)
		end

		var_87_11:setPosition(0, 0)
		var_87_9:addChild(var_87_11)

		local var_87_12 = cc.Label:createWithTTF(iter_87_2.total .. "/" .. iter_87_2.total, FONT_NAME, 25)
		local var_87_13 = string.len(iter_87_2.total .. "/" .. iter_87_2.total)
		local var_87_14 = cc.Label:createWithTTF(TILE_SHOW_STR[iter_87_1] .. "(", FONT_NAME, 25)

		var_87_14:setString(TILE_SHOW_STR[iter_87_1] .. ": ")
		var_87_14:setColor(cc.c3b(64, 154, 192))
		var_87_14:setAnchorPoint(cc.p(0, 0.5))
		var_87_14:setPosition(var_87_11:getPositionX() + var_87_11:getContentSize().width / 2 + 4, var_87_11:getPositionY())
		var_87_12:setString(iter_87_2.used .. "/" .. iter_87_2.total)
		var_87_12:setAnchorPoint(cc.p(0, 0.5))
		var_87_12:setPosition(var_87_14:getPositionX() + var_87_14:getContentSize().width, var_87_11:getPositionY())
		var_87_12:setColor(cc.c3b(60, 192, 159))
		var_87_12:setName("num")
		var_87_9:addChild(var_87_14)
		var_87_9:addChild(var_87_12)

		var_87_9.count = var_87_8
		var_87_8 = var_87_8 + 1

		function var_87_9.finish_action(arg_89_0)
			local var_89_0 = 0.5
			local var_89_1 = 0
			local var_89_2 = cc.p(var_87_11:getPosition())

			var_87_10:stopAllActions()
			var_87_10:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
				var_89_1 = var_89_1 + 1

				var_87_10:clear()
				var_87_10:drawSegment(var_89_2, cc.p(var_87_11:getPositionX() + var_89_1 * 0.016666666666666666 * (var_87_12:getContentSize().width + var_87_14:getContentSize().width + var_87_11:getContentSize().width / 2 + 4) / var_89_0, var_87_11:getPositionY()), 2, cc.c4f(0.2549019607843137, 0.6509803921568628, 0.8196078431372549, 1))

				if var_89_1 * 0.016666666666666666 >= var_89_0 then
					var_87_10:stopAllActions()
				end
			end))))
			var_87_14:stopAllActions()
			var_87_14:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeTo:create(0.3, 100)))
			var_87_12:stopAllActions()
			var_87_12:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeTo:create(0.3, 100)))
		end

		if iter_87_2.used >= iter_87_2.total then
			var_87_9:finish_action()
		end
	end

	function self.exploreProgressLayout.exploreProgressComplete(arg_91_0)
		var_87_5:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(-300, 0)), cc.FadeOut:create(0.3)), cc.Hide:create()))
		self.exploreProgressBar:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(200, 0)), cc.FadeOut:create(0.3)), cc.Hide:create()))
		self.exploreProgressLabel:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(200, 0)), cc.FadeOut:create(0.3)), cc.Hide:create()))
		var_87_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.MoveTo:create(0.5, cc.p(565, var_87_0:getPositionY())), cc.CallFunc:create(function()
			local var_92_0 = ccui.Button:create("explore/finish_bnt.png", nil, "explore/finish_bnt.png", var_0_1)

			var_92_0:setPosition(415, 115)
			var_92_0:setOpacity(0)
			var_92_0:setScaleX(0.5)
			self.exploreProgressLayout:addChild(var_92_0)
			var_92_0:runAction(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.5, 1)))
			var_92_0:addTouchEventListener(function(arg_93_0, arg_93_1)
				if arg_93_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not arg_93_0:isBright() then
					return
				end

				arg_93_0:setBright(false)
				self:exit(function()
					arg_93_0:setBright(true)
				end)
			end)

			local var_92_1 = ccui.ImageView:create("explore/clear_img.png", var_0_1)

			var_92_1:setPosition(var_92_0:getPositionX(), var_92_0:getPositionY() + 10)
			var_92_1:setOpacity(0)
			self.exploreProgressLayout:addChild(var_92_1)
			var_92_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.FadeIn:create(0.2)))

			local var_92_2 = ccui.ImageView:create("explore/yellow_arrow.png", var_0_1)

			var_92_2:setOpacity(0)
			var_92_2:setPosition(var_92_0:getPositionX(), var_92_1:getPositionY() - 30)
			self.exploreProgressLayout:addChild(var_92_2)
			var_92_2:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.2)))

			local var_92_3 = {
				0.9,
				0.74,
				0.58
			}

			for iter_92_0 = 1, 3 do
				local var_92_4 = ccui.ImageView:create("explore/blue_arrow.png", var_0_1)

				if var_87_1 then
					var_92_4 = ccui.ImageView:create("explore/hpInherit/blue_arrow.png", var_0_1)
				end

				var_92_4:setVisible(false)
				var_92_4:setPosition(var_92_0:getPositionX() + 180, var_92_1:getPositionY())
				self.exploreProgressLayout:addChild(var_92_4)

				local var_92_5 = ccui.ImageView:create("explore/blue_arrow.png", var_0_1)

				if var_87_1 then
					var_92_5 = ccui.ImageView:create("explore/hpInherit/blue_arrow.png", var_0_1)
				end

				var_92_5:setFlippedX(true)
				var_92_5:setVisible(false)
				var_92_5:setPosition(var_92_0:getPositionX() - 180, var_92_1:getPositionY())
				self.exploreProgressLayout:addChild(var_92_5)
				var_92_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.Show:create(), cc.MoveTo:create(var_92_3[iter_92_0], cc.p(var_92_0:getPositionX() + 90 + (iter_92_0 - 1) * 16, var_92_1:getPositionY())), cc.DelayTime:create(0.05 * (4 - iter_92_0)), cc.CallFunc:create(function()
					var_92_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.4, 50), cc.FadeTo:create(0.4, 255))))
				end)))
				var_92_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.Show:create(), cc.MoveTo:create(var_92_3[iter_92_0], cc.p(var_92_0:getPositionX() - 90 - (iter_92_0 - 1) * 16, var_92_1:getPositionY())), cc.DelayTime:create(0.05 * (4 - iter_92_0)), cc.CallFunc:create(function()
					var_92_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(0.4, 50), cc.FadeTo:create(0.4, 255))))
				end)))
			end
		end)))
	end

	if next(self.curMapConfig.mapProgress) == nil or var_0_37:getMapProgress() == 100 then
		self.exploreProgressLayout.exploreProgressComplete()

		if var_0_37:is_main_aim_finish() then
			self.mapUIPanel:getChildByName("topbg"):getChildByName("mapGiveupBnt"):runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.Hide:create()))
		end
	end
end

function RogueExploreLayer:updateExploreProgress(arg_97_1)
	if var_0_37.curMapConfig.mapProgress[var_0_35[arg_97_1].show_class] then
		self.exploreProgressList[var_0_35[arg_97_1].show_class]:getChildByName("num"):setString(var_0_37.curMapConfig.mapProgress[var_0_35[arg_97_1].show_class].used .. "/" .. var_0_37.curMapConfig.mapProgress[var_0_35[arg_97_1].show_class].total)
		self.exploreProgressLabel:setString(var_0_37:getMapProgress() .. "%")
		self.exploreProgressBar:setPercentage((var_0_37:getMapProgress()))

		if var_0_37.curMapConfig.mapProgress[var_0_35[arg_97_1].show_class].used >= var_0_37.curMapConfig.mapProgress[var_0_35[arg_97_1].show_class].total then
			self.exploreProgressList[var_0_35[arg_97_1].show_class]:finish_action()
		end

		if var_0_37:getMapProgress() == 100 then
			self.exploreProgressLayout:exploreProgressComplete()

			if var_0_37:is_main_aim_finish() then
				self.mapUIPanel:getChildByName("topbg"):getChildByName("mapGiveupBnt"):runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.Hide:create()))
			end
		end
	end
end

function RogueExploreLayer:initBloodUI()
	local var_98_0 = var_0_37:isHpInherit()

	self.bloodbg = ccui.ImageView:create("explore/blood_bg.png", var_0_1)

	if var_98_0 then
		self.bloodbg = ccui.ImageView:create("explore/hpInherit/blood_bg.png", var_0_1)
	end

	self.bloodbg:setScale9Enabled(true)
	self.bloodbg:setCapInsets(cc.rect(160, 5, 10, 5))
	self.bloodbg:setContentSize(cc.size(self.bloodbg:getContentSize().width + 20, self.bloodbg:getContentSize().height))
	self.bloodbg:setAnchorPoint(cc.p(0, 0))
	self.bloodbg:setPosition(0, -GameDisplay.fix_y)
	self.mapUIPanel:addChild(self.bloodbg)

	local var_98_1 = cc.Label:createWithTTF(self.curMapConfig.team_hp .. "/" .. TOTAL_TEAM_HP, FONT_NAME, 12)

	var_98_1:setColor(cc.c3b(0, 216, 255))

	if var_98_0 then
		var_98_1:setColor(cc.c3b(230, 0, 0))
	end

	var_98_1:setAnchorPoint(cc.p(0, 0))
	var_98_1:setPosition(10, 5)
	var_98_1:setName("label")
	self.bloodbg:addChild(var_98_1)

	for iter_98_0 = 1, TOTAL_TEAM_HP do
		local var_98_2 = ccui.ImageView:create("explore/blood_bar.png", var_0_1)

		if var_98_0 then
			var_98_2 = ccui.ImageView:create("explore/hpInherit/blood_bar.png", var_0_1)
		end

		var_98_2:setName("blood" .. iter_98_0)
		var_98_2:setAnchorPoint(cc.p(0, 0))
		var_98_2:setPosition(50 + (iter_98_0 - 1) * var_98_2:getContentSize().width, 4)
		var_98_2:ignoreContentAdaptWithSize(false)
		self.bloodbg:addChild(var_98_2)
	end

	function self.bloodbg.updateBloodUI(arg_99_0)
		for iter_99_0 = 1, TOTAL_TEAM_HP do
			local var_99_0 = self.bloodbg:getChildByName("blood" .. iter_99_0)

			if iter_99_0 <= self.curMapConfig.team_hp then
				var_99_0:loadTexture("explore/blood_bar.png", var_0_1)

				if var_98_0 then
					var_99_0:loadTexture("explore/hpInherit/blood_bar.png", var_0_1)
				end
			else
				var_99_0:loadTexture("explore/blood_bar_gray.png", var_0_1)
			end
		end

		self.bloodbg:getChildByName("label"):setString(self.curMapConfig.team_hp .. "/" .. TOTAL_TEAM_HP)
	end

	self.bloodbg:updateBloodUI()
end

function RogueExploreLayer:switchRoom(arg_100_1)
	if self.curRoomMap then
		self.curRoomMap = RogueRoom:create(self, arg_100_1)

		self.mapView:addChild(self.curRoomMap)
		self.smallMap:updateExploredRoom()
		self.smallMap:updateAll()
		self.roomName:setString(var_0_33[self.curRoomMap.curRoomId].name or L_EXPLOREMAP_ROOM.Room_SP_Name)
		LayerManager:cleanPopLayer()
		self.curRoomMap:go_out_action(arg_100_1, function()
			self.touchLock = false
		end)
	else
		self.curRoomMap = RogueRoom:create(self)

		self.mapView:addChild(self.curRoomMap)
		self.roomName:setString(var_0_33[self.curRoomMap.curRoomId].name or L_EXPLOREMAP_ROOM.Room_SP_Name)
	end
end

function RogueExploreLayer:jumpRoom(arg_102_1)
	local var_102_0 = var_0_37:get_two_room_direction(self.curRoomMap.curRoomOrder, arg_102_1)

	self.curRoomMap = RogueRoom:create(self, var_102_0)

	self.mapView:addChild(self.curRoomMap)
	self.smallMap:updateExploredRoom()
	self.smallMap:updateAll()
	self.roomName:setString(var_0_33[self.curRoomMap.curRoomId].name or L_EXPLOREMAP_ROOM.Room_SP_Name)
	self.curRoomMap:go_out_action(var_102_0, function()
		return
	end)

	local var_102_1 = self.curRoomMap:getChildByName("iconLayout"):getChildByName("tag")

	if self.jumpEffect and self.jumpEffect.jump_effect then
		local var_102_2 = L2Skeleton:create("spine/explore/" .. self.jumpEffect.jump_effect .. ".json", "spine/explore/" .. self.jumpEffect.jump_effect .. ".atlas")

		var_102_2:setName("jumpRoomEffect")
		var_102_2:setScaleX(1.2)
		var_102_2:setScaleY(1.2)
		var_102_2:refreshSkeleton()
		var_102_2:play("animation", false)
		var_102_2:registerListener(SP_ANIMATION_COMPLETE, function(arg_104_0)
			self.touchLock = false

			var_102_2:runAction(cc.RemoveSelf:create())
		end)
		var_102_2:setPosition(cc.p(var_102_1:getContentSize().width / 2, var_102_1:getContentSize().height / 2))
		var_102_1:addChild(var_102_2, 99)
		var_102_2:setGlobalZOrder(-1)
	else
		self.touchLock = false
	end
end

function RogueExploreLayer.showFailLayer(arg_105_0)
	FightManager.setFightState(FIGHTSTATE_WAIT)
	FightManager.stopStatistics()

	FightManager.needGuideFight = false

	FightManager.battlefieldRef:rogueExploreFightFail(function()
		FightManager.switchFight(FIGHTTYPE_NORMAL)
	end)

	local var_105_0 = cloneconf(var_0_37.curMapConfig.array)

	for iter_105_0, iter_105_1 in pairs(var_105_0) do
		iter_105_1.classtype = 1
	end

	require("view.Layer.LevelResultLayer")

	local function var_105_1()
		arg_105_0:failExit()
	end

	LevelResultLayer:create({
		showtype = 7,
		curarray = var_105_0,
		surecallback = var_105_1,
		cancelcallback = var_105_1
	})
end

RogueRoom = class("RogueRoom", function()
	return ccui.Layout:create()
end)

function RogueRoom:create(arg_109_1, arg_109_2)
	local var_109_0 = RogueRoom.new()

	var_109_0:init(arg_109_1, arg_109_2)

	return var_109_0
end

function RogueRoom:init(arg_110_1, arg_110_2)
	self.direction = arg_110_2
	self.root = arg_110_1
	self.curMapConfig = self.root.curMapConfig
	self.curMapId = self.curMapConfig.mapid
	self.curMapSize = self.curMapConfig.mapRoomSize
	self.curRoomOrder = self.curMapConfig.curRoomOrder
	self.curRoomObjectId = self.curMapConfig.pathtree[self.curRoomOrder].objectid
	self.curRoomId = var_0_37:getRoomid(self.curMapId, self.curRoomOrder)
	self.curRoomInfo = var_0_33[self.curRoomId]
	self.effect = self.root.effect
	self.particle = self.root.particle
	self.roomColor = self.root.roomColor
	self.room_width_num, self.room_height_num = self.curRoomInfo.width_num, self.curRoomInfo.height_num
	self.room_width, self.room_height = self.room_width_num * var_0_70, self.room_height_num * var_0_70
	self.roomBound = {
		x_min = 0,
		y_min = 0,
		x_max = self.room_width,
		y_max = self.room_height
	}
	self.bridgeLocks = self.curMapConfig.bridgeLocks
	self.aimTypeTbl = self.curMapConfig.aimTypeTbl
	self.roomPathTree = self.curMapConfig.pathtree
	self.roomMapBlocks = self.curMapConfig.mapBlocks
	self.roomMapEnvs = self.curMapConfig.mapEnvs
	self.usedTilesConfig = self.curMapConfig.usedTile
	self.replaceConfig = self.curMapConfig.replaceConfig
	self.roomsLightConfig = self.curMapConfig.roomsLightConfig
	self.roomfollowholeConfig = self.curMapConfig.roomfollowholeConfig
	self.roomteleportConfig = self.curMapConfig.roomteleportConfig
	self.roomgreenConfig = self.curMapConfig.roomgreenConfig
	self.rangeConfig = self.curMapConfig.objectRange
	self.monsterRangeConfig = self.curMapConfig.monsterRange
	self.alignmentType = self.curMapConfig.alignmentType
	self.puzzleConfig = self.curMapConfig.puzzleConfig
	self.pathTree = self.roomPathTree[self.curRoomOrder]
	self.mapBlock = self.roomMapBlocks[self.curRoomOrder]
	self.mapEnvs = self.roomMapEnvs[self.curRoomOrder]
	self.usedTile = self.usedTilesConfig[self.curRoomOrder]
	self.roomLight = self.roomsLightConfig[self.curRoomOrder]
	self.replaceModel = self.replaceConfig[self.curRoomOrder]
	self.objectRange = self.rangeConfig[self.curRoomOrder]
	self.monsterRange = self.monsterRangeConfig[self.curRoomOrder]
	self.tileobjects = {}
	self.curMapEnv = 1

	self:initMapViewHeight(arg_110_2)
	self:setContentSize(self:getFirstSize())
	self:setPosition(self:getFirstPos())

	self.batchNodeLayout = cc.SpriteBatchNode:create("tilemap/tiles_" .. var_0_32[self.curMapId].fullImage .. ".png")

	self.batchNodeLayout:setPosition(0, 0)
	self:addChild(self.batchNodeLayout, var_0_38)

	self.maskPanel = ccui.Layout:create()

	self:addChild(self.maskPanel, var_0_39)

	self.iconLayout = ccui.Layout:create()

	self.iconLayout:setName("iconLayout")
	self.iconLayout:setPosition(0, 0)
	self:addChild(self.iconLayout, var_0_40)

	self.darkLayout = ccui.Layout:create()

	self.darkLayout:setTouchEnabled(false)
	self.darkLayout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.darkLayout:setBackGroundColor(cc.c3b(0, 0, 0))
	self.darkLayout:setBackGroundColorOpacity(80)
	self.darkLayout:setContentSize(cc.size(self:getContentSize().width * 2, self:getContentSize().height * 2))
	self.darkLayout:setPosition(cc.p(-self:getContentSize().width / 2, -self:getContentSize().height / 2))
	self:addChild(self.darkLayout, var_0_41)

	if var_0_62 then
		local var_110_0 = ccui.Layout:create()

		var_110_0:setName("testLayout")
		self:addChild(var_110_0)
	end

	self:updateCurPosInfo()
	self:initDarkLayer()
	self:initSelectedFrame()
	self:initTouchMark()
	self:genMap()
	self:updateBoundUI()
	self:registerTouchEvent()
	self:triggerRoomEvent()

	if self.root.isMainAimFinish ~= true or var_0_37:isEndEffect(self.root.curAimId) then
		self:initEffectRoom()
		self:initParticletRoom()
		self:initRoomColorEffect()
	end

	if self.direction then
		self:go_in_action(function()
			self.root.mapView:getInnerContainer():setContentSize(self:getFirstSize())

			if self.mask then
				self.mask:setPosition((self:convertToNodeSpace(cc.p(GameDisplay.cx, GameDisplay.cy))))

				local var_111_0 = self:convertToWorldSpace(cc.p(self.curCoordinate.x, self.curCoordinate.y + 50))

				self.mask:focus(var_111_0.x, var_111_0.y)
			end

			self.darkLayout:setVisible(false)
		end)
		self:initCameraPos()
	else
		self:initCameraPos()
	end

	Utility:registerNodeEvent(self)
end

function RogueRoom:onEnter()
	var_0_37:registerEvent(self, EVENT_TYPE.CHANGE_DRESS, handler(self, self.onUpdateRole))
end

function RogueRoom:onExit()
	var_0_37:removeEvent(self)
end

function RogueRoom:onUpdateRole()
	local var_114_0 = 1

	for iter_114_0, iter_114_1 in ipairs(self.curMapConfig.array) do
		if iter_114_1.fight_girl then
			var_114_0 = iter_114_0

			break
		end
	end

	self:updateSelectedFrame(var_114_0)
end

function RogueRoom:isMainAimFinish()
	local var_115_0 = true

	for iter_115_0, iter_115_1 in pairs(self.aimTypeTbl) do
		if iter_115_1.result_type == "map" and iter_115_1.flag < iter_115_1.num then
			var_115_0 = false
		end
	end

	return var_115_0
end

function RogueRoom:handleColorStr(arg_116_1)
	return (string_split(arg_116_1, ","))
end

function RogueRoom:initRoomColorEffect()
	if self.roomColor and self.roomColor["room_" .. self.curRoomOrder] and not self.root.isCloseRoomColor then
		if not self.root.mapPanel:getChildByName(self.roomColor["room_" .. self.curRoomOrder]) then
			if self.root.mapPanel:getChildByTag(789) then
				self.root.mapPanel:getChildByTag(789):removeFromParent()
			end

			local var_117_0 = ccui.Layout:create()

			var_117_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)

			local var_117_1 = self:handleColorStr(self.roomColor["room_" .. self.curRoomOrder])

			var_117_0:setBackGroundColor(cc.c3b(var_117_1[1], var_117_1[2], var_117_1[3]))
			var_117_0:setContentSize(cc.size(640, GameDisplay.height))
			var_117_0:setPosition(cc.p(0, -GameDisplay.fix_y))
			var_117_0:setTag(789)
			var_117_0:setName(self.roomColor["room_" .. self.curRoomOrder])
			var_117_0:setOpacity(60)
			self.root.mapPanel:addChild(var_117_0, 2)

			local var_117_2 = var_117_1[4] or 0.5

			var_117_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(var_117_2, var_117_1[5] or 45), cc.FadeTo:create(var_117_2, var_117_1[6] or 60))))
		end
	elseif self.root.mapPanel:getChildByTag(789) then
		self.root.mapPanel:getChildByTag(789):removeFromParent()
	end
end

function RogueRoom:updateRoomColorEffect(arg_118_1)
	if arg_118_1 == 1 then
		self.root.isCloseRoomColor = true

		if self.root.mapPanel:getChildByTag(789) then
			self.root.mapPanel:getChildByTag(789):removeFromParent()
		end
	end
end

function RogueRoom:initParticletRoom()
	if self.particle and self.particle["room_" .. self.curRoomOrder] then
		if not self.root.mapPanel:getChildByName(self.particle["room_" .. self.curRoomOrder]) then
			if self.root.mapPanel:getChildByTag(456) then
				self.root.mapPanel:getChildByTag(456):removeFromParent()
			end

			print("$$$$$$$$$$$$$$$$$$$$$$", "effect/" .. self.particle["room_" .. self.curRoomOrder] .. ".plist")

			local var_119_0 = cc.ParticleSystemQuad:create("effect/" .. self.particle["room_" .. self.curRoomOrder] .. ".plist")

			var_119_0:setName(self.particle["room_" .. self.curRoomOrder])
			var_119_0:setTag(456)
			var_119_0:setAutoRemoveOnFinish(true)
			var_119_0:setPosition(cc.p(320, -GameDisplay.fix_y))
			self.root.mapPanel:addChild(var_119_0, 2)
		end
	elseif self.root.mapPanel:getChildByTag(456) then
		self.root.mapPanel:getChildByTag(456):removeFromParent()
	end
end

function RogueRoom:initEffectRoom()
	if self.effect and self.effect["room_" .. self.curRoomOrder] then
		if not self.root.mapPanel:getChildByName(self.effect["room_" .. self.curRoomOrder]) then
			if self.root.mapPanel:getChildByTag(123) then
				self.root.mapPanel:getChildByTag(123):removeFromParent()
			end

			local var_120_0 = L2Skeleton:create("spine/explore/" .. self.effect["room_" .. self.curRoomOrder] .. ".json", "spine/explore/" .. self.effect["room_" .. self.curRoomOrder] .. ".atlas")

			var_120_0:setTag(123)
			var_120_0:setName(self.effect["room_" .. self.curRoomOrder])
			var_120_0:refreshSkeleton()
			var_120_0:setScaleX(1.3)
			var_120_0:setScaleY((GameDisplay.height - 205) / 874)
			var_120_0:setVisible(true)
			var_120_0:play("animation", true)
			var_120_0:setPosition(cc.p(320, GameDisplay.height / 2 - 205))
			self.root.mapPanel:addChild(var_120_0, 2)
		end
	elseif self.root.mapPanel:getChildByTag(123) then
		self.root.mapPanel:getChildByTag(123):removeFromParent()
	end
end

function RogueRoom:initMapViewHeight(arg_121_1)
	local var_121_0 = GameDisplay.height - 256

	if self.room_height_num * var_0_70 * var_0_69 < GameDisplay.height - 256 then
		var_121_0 = self.room_height_num * var_0_70 * var_0_69
	end

	self.root.mapView:setContentSize(cc.size(640, var_121_0))
	self.root.mapView:setPositionY((GameDisplay.height - 256 - var_121_0) / 2 - GameDisplay.fix_y)

	if arg_121_1 then
		local var_121_1 = self.root.mapView:getInnerContainerSize().width * var_0_69 - self.root.mapView:getContentSize().width
		local var_121_2 = self.root.mapView:getInnerContainerSize().height * var_0_69 - self.root.mapView:getContentSize().height
		local var_121_3 = self.root.curRoomMap.curCoordinate.x * var_0_69 - self.root.mapView:getContentSize().width / 2
		local var_121_4 = self.root.curRoomMap.curCoordinate.y * var_0_69 - self.root.mapView:getContentSize().height / 2

		if var_121_1 < var_121_3 then
			var_121_3 = var_121_1
		elseif var_121_3 < 0 then
			var_121_3 = 0
		end

		if var_121_2 < var_121_4 then
			var_121_4 = var_121_2
		elseif var_121_4 < -100 then
			var_121_4 = -100
		end

		self.root.mapView:getInnerContainer():setPosition(-var_121_3, -var_121_4)
	end
end

function RogueRoom:initDarkLayer()
	if not self.roomfollowholeConfig[self.curRoomOrder] then
		self.darkLayout:setVisible(false)
	else
		self.darkLayout:setVisible(false)
		self.darkLayout:setBackGroundColorOpacity(255)

		local var_122_0

		if self.curMapConfig.npcLockConf and self.curMapConfig.npcLockConf.hole and self.curMapConfig.npcLockConf.hole.is_have then
			var_122_0 = cc.p(0.2, 0.25)
		end

		local var_122_1

		do
			var_122_0 = cc.p(0.1, 0.1)
			var_122_1 = {
				range = var_122_0
			}
		end

		var_122_1.focus = self:convertToWorldSpace(cc.p(self.curCoordinate.x, self.curCoordinate.y + 50))
		self.mask = MaskNode:create(var_122_1)

		self:addChild(self.mask, var_0_41)
	end

	if self.roomteleportConfig[self.curRoomOrder] then
		if self.root.mapPanel:getChildByName("zhangzongmiwu") then
			self.root.mapPanel:getChildByName("zhangzongmiwu"):removeFromParent()
		end

		self.mask1 = MaskNode:createDreamMask()

		self.mask1:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 - 200))
		self.mask1:setScale(self.roomteleportConfig[self.curRoomOrder])
		self.mask1:setName("zhangzongmiwu")
		self.root.mapPanel:addChild(self.mask1, 3)
	elseif self.root.mapPanel:getChildByName("zhangzongmiwu") then
		self.root.mapPanel:getChildByName("zhangzongmiwu"):removeFromParent()
	end

	if self.root.mapPanel:getChildByName("greenScreen") then
		self.root.mapPanel:getChildByName("greenScreen"):removeFromParent()
	end

	if self.roomgreenConfig[self.curRoomOrder] and self.roomgreenConfig[self.curRoomOrder] == 1 then
		local var_122_2 = ccui.ImageView:create("mainScenebg/test3.png")

		var_122_2:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2 - 200))
		var_122_2:setName("greenScreen")
		self.root.mapPanel:addChild(var_122_2, 2)
	end
end

function RogueRoom:triggerRoomEvent()
	(function()
		local var_124_0 = {}

		for iter_124_0, iter_124_1 in pairs(self.bridgeLocks) do
			var_124_0[iter_124_1.room_order1] = iter_124_0
			var_124_0[iter_124_1.room_order2] = iter_124_0
		end

		if var_124_0[self.curRoomOrder] then
			self.root.aimLayout.bridge_aim_panel:bridge_aim_panel_reset(self.aimTypeTbl[self.bridgeLocks[var_124_0[self.curRoomOrder]].tileid])
		else
			self.root.aimLayout:getChildByName("aimTile2"):setVisible(self.root.aimLayout.bridge_aim_panel and self.root.aimLayout.bridge_aim_panel:isVisible() or false)
		end
	end)()
end

function RogueRoom:updateBoundUI(arg_125_1)
	if not var_0_33[self.curRoomId].arrowsImg then
		return
	end

	local var_125_0 = {}

	for iter_125_0, iter_125_1 in pairs(var_0_33[self.curRoomId].arrowsImg) do
		var_125_0[iter_125_1] = var_125_0[iter_125_1] or {}

		table.insert(var_125_0[iter_125_1], iter_125_0)
	end

	for iter_125_2 = 1, 4 do
		if self.roomPathTree[self.curMapConfig.curRoomOrder].nexts[iter_125_2] and var_125_0[iter_125_2] then
			local var_125_1
			local var_125_3

			if self:checkBoundIsLock(iter_125_2) and not self.root.isBridgeAction then
				var_125_1 = var_0_57[iter_125_2][2]
				var_125_3 = false
			else
				var_125_1 = var_0_57[iter_125_2][1]
				var_125_3 = true
			end

			local var_125_4
			local var_125_5

			if iter_125_2 == 1 then
				var_125_4 = cc.p(0, -20)
				var_125_5 = cc.p(0, 20)
			elseif iter_125_2 == 2 then
				var_125_4 = cc.p(-20, 0)
				var_125_5 = cc.p(20, 0)
			elseif iter_125_2 == 3 then
				var_125_4 = cc.p(0, 20)
				var_125_5 = cc.p(0, -20)
			elseif iter_125_2 == 4 then
				var_125_4 = cc.p(20, 0)
				var_125_5 = cc.p(-20, 0)
			end

			for iter_125_3, iter_125_4 in pairs(var_125_0[iter_125_2]) do
				local var_125_6 = self.maskPanel:getChildByName("arrow" .. iter_125_4)

				if var_125_6 then
					var_125_6:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
						var_125_6:loadTexture(var_125_1, var_0_1)

						if var_125_6.is_action ~= var_125_3 then
							if var_125_3 then
								self.root.isBridgeAction = nil

								var_125_6:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.15, var_125_4), cc.MoveBy:create(0.15, var_125_5), cc.MoveBy:create(0.15, var_125_4), cc.MoveBy:create(0.15, var_125_5), cc.DelayTime:create(1))))
							else
								var_125_6:stopAllActions()
							end
						end
					end), cc.FadeIn:create(0.5)))
				else
					local var_125_7 = self:transform_index_pos_coordinate(iter_125_4, "index")

					var_125_6 = ccui.ImageView:create(var_125_1, var_0_1)

					var_125_6:setAnchorPoint(cc.p(0, 0))
					var_125_6:setName("arrow" .. iter_125_4)
					var_125_6:setPosition(var_125_7.x, var_125_7.y)

					if var_125_3 then
						var_125_6.is_action = var_125_3

						var_125_6:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.15, var_125_4), cc.MoveBy:create(0.15, var_125_5), cc.MoveBy:create(0.15, var_125_4), cc.MoveBy:create(0.15, var_125_5), cc.DelayTime:create(1))))
					end

					self.maskPanel:addChild(var_125_6)
				end
			end
		end
	end
end

function RogueRoom:initCameraPos()
	local var_127_0 = self:getContentSize().width * var_0_69 - self.root.mapView:getContentSize().width
	local var_127_1 = self:getContentSize().height * var_0_69 - self.root.mapView:getContentSize().height
	local var_127_2 = self.curCoordinate.x * var_0_69 - self.root.mapView:getContentSize().width / 2
	local var_127_3 = self.curCoordinate.y * var_0_69 - self.root.mapView:getContentSize().height / 2

	if var_127_0 < var_127_2 then
		var_127_2 = var_127_0
	elseif var_127_2 < 0 then
		var_127_2 = 0
	end

	if var_127_1 < var_127_3 then
		var_127_3 = var_127_1
	elseif var_127_3 < -100 then
		var_127_3 = -100
	end

	self.root.mapView:getInnerContainer():runAction(cc.MoveTo:create(var_0_71, cc.p(-var_127_2, -var_127_3)))
end

function RogueRoom:getFirstSize()
	return cc.size(self.room_width < self.root.mapView:getContentSize().width / var_0_69 and self.root.mapView:getContentSize().width / var_0_69 or self.room_width, self.room_height < self.root.mapView:getContentSize().height / var_0_69 and self.root.mapView:getContentSize().height / var_0_69 or self.room_height)
end

local var_0_74 = {
	function(arg_129_0, arg_129_1)
		return 0
	end,
	function(arg_130_0, arg_130_1)
		return (arg_130_0 - arg_130_1) / 2
	end,
	function(arg_131_0, arg_131_1)
		return arg_131_0 - arg_131_1
	end
}

function RogueRoom:getFirstPos()
	local var_132_0 = 1

	if self.direction then
		var_132_0 = self:getCurAlignment(self.curRoomOrder, self.root.curRoomMap.curRoomOrder)
	end

	if self.direction then
		local var_132_1
		local var_132_2

		if self.direction == var_0_42 then
			var_132_1 = var_0_74[var_132_0](self.root.mapView:getInnerContainerSize().width, self:getContentSize().width)
			var_132_2 = self.root.mapView:getInnerContainerSize().height
		elseif self.direction == var_0_43 then
			var_132_1 = self.root.mapView:getInnerContainerSize().width
			var_132_2 = var_0_74[var_132_0](self.root.mapView:getInnerContainerSize().height, self:getContentSize().height)
		elseif self.direction == var_0_44 then
			var_132_1 = var_0_74[var_132_0](self.root.mapView:getInnerContainerSize().width, self:getContentSize().width)
			var_132_2 = -self.room_height
		elseif self.direction == var_0_45 then
			var_132_1 = -self.room_width
			var_132_2 = var_0_74[var_132_0](self.root.mapView:getInnerContainerSize().height, self:getContentSize().height)
		elseif self.direction == var_0_49 then
			var_132_1 = self.root.mapView:getInnerContainerSize().width
			var_132_2 = self.root.mapView:getInnerContainerSize().height
		elseif self.direction == var_0_48 then
			var_132_1 = self.root.mapView:getInnerContainerSize().width
			var_132_2 = -self:getContentSize().width
		elseif self.direction == var_0_47 then
			var_132_1 = -self:getContentSize().width
			var_132_2 = -self:getContentSize().height
		elseif self.direction == var_0_46 then
			var_132_1 = -self:getContentSize().width
			var_132_2 = self.root.mapView:getInnerContainerSize().height
		elseif self.direction == var_0_50 then
			var_132_2 = 0
			var_132_1 = 0
		end

		return var_132_1, var_132_2
	else
		return 0, 0
	end
end

function RogueRoom:go_in_action(arg_133_1)
	self:runAction(cc.Sequence:create(self.direction == var_0_50 and cc.FadeIn:create(var_0_71) or cc.MoveTo:create(var_0_71, cc.p(0, 0)), cc.CallFunc:create(function()
		if self.roomfollowholeConfig and next(self.roomfollowholeConfig) then
			-- block empty
		end
	end), cc.CallFunc:create(function()
		if arg_133_1 then
			arg_133_1()
		end
	end)))
	self:mainRoleEnterAction(0.1)
end

function RogueRoom:go_out_action(arg_136_1, arg_136_2)
	local var_136_0 = self:getCurAlignment(self.curRoomOrder, self.root.curRoomMap.curRoomOrder)

	self:stopAllActions()
	self.tag:setVisible(false)
	self:runAction(cc.Sequence:create(({
		[var_0_42] = cc.MoveBy:create(var_0_71, cc.p(var_0_74[var_136_0](self.root.curRoomMap:getContentSize().width, self:getContentSize().width), -self:getContentSize().height)),
		[var_0_43] = cc.MoveBy:create(var_0_71, cc.p(-self:getContentSize().width, var_0_74[var_136_0](self.root.curRoomMap:getContentSize().height, self:getContentSize().height))),
		[var_0_44] = cc.MoveBy:create(var_0_71, cc.p(var_0_74[var_136_0](self.root.curRoomMap:getContentSize().width, self:getContentSize().width), self.root.curRoomMap:getContentSize().height)),
		[var_0_45] = cc.MoveBy:create(var_0_71, cc.p(self.root.curRoomMap:getContentSize().width, var_0_74[var_136_0](self.root.curRoomMap:getContentSize().height, self:getContentSize().height))),
		[var_0_46] = cc.MoveBy:create(var_0_71, cc.p(self:getContentSize().width, -self:getContentSize().height)),
		[var_0_47] = cc.MoveBy:create(var_0_71, cc.p(self:getContentSize().width, self.root.curRoomMap:getContentSize().height)),
		[var_0_48] = cc.MoveBy:create(var_0_71, cc.p(-self.root.curRoomMap:getContentSize().width, self.root.curRoomMap:getContentSize().height)),
		[var_0_49] = cc.MoveBy:create(var_0_71, cc.p(-self.root.curRoomMap:getContentSize().width, -self:getContentSize().height)),
		[var_0_50] = cc.FadeOut:create(var_0_71)
	})[arg_136_1], cc.Hide:create(), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		if arg_136_2 then
			arg_136_2()
		end
	end)))

	if self.mask then
		self.darkLayout:setVisible(true)
	end
end

function RogueRoom:getCurAlignment(arg_138_1, arg_138_2)
	return self.alignmentType[var_0_37:getBridgeOrder(arg_138_1 .. "-" .. arg_138_2)] or 1
end

function RogueRoom:transform_index_pos_coordinate(arg_139_1, arg_139_2)
	if arg_139_2 == "index" then
		local var_139_0 = math.floor((arg_139_1 - 1) / self.room_width_num) + 1

		return {
			index = arg_139_1,
			order_x = (arg_139_1 - 1) % self.room_width_num + 1,
			order_y = var_139_0,
			x = ((arg_139_1 - 1) % self.room_width_num + 1 - (self.room_width_num + 1) / 2) * var_0_70 + self:getContentSize().width / 2 - var_0_70 / 2,
			y = (var_139_0 - (self.room_height_num + 1) / 2) * var_0_70 + self:getContentSize().height / 2 - var_0_70 / 2
		}
	elseif arg_139_2 == "pos" then
		return {
			index = (arg_139_1.y - 1) * self.room_width_num + arg_139_1.x,
			order_x = arg_139_1.x,
			order_y = arg_139_1.y,
			x = (arg_139_1.x - (self.room_width_num + 1) / 2) * var_0_70 + self:getContentSize().width / 2 - var_0_70 / 2,
			y = (arg_139_1.y - (self.room_height_num + 1) / 2) * var_0_70 + self:getContentSize().height / 2 - var_0_70 / 2
		}
	elseif arg_139_2 == "coordinate" then
		if arg_139_1.x < self.roomBound.x_min or arg_139_1.x > self.roomBound.x_max or arg_139_1.y < self.roomBound.y_min or arg_139_1.y > self.roomBound.y_max then
			local var_139_1
			local var_139_2

			var_139_1 = arg_139_1.x < self.roomBound.x_min and self.roomBound.x_min - (math.floor((self.roomBound.x_min - arg_139_1.x) / var_0_70) + 1) * var_0_70 or arg_139_1.x > self.roomBound.x_max and self.roomBound.x_max + (math.floor((arg_139_1.x - self.roomBound.x_max) / var_0_70) + 1) * var_0_70 or (math.floor((arg_139_1.x - self.roomBound.x_min) / var_0_70) + 1 - (self.room_width_num + 1) / 2) * var_0_70 + self:getContentSize().width / 2 - var_0_70
			var_139_2 = arg_139_1.y < self.roomBound.y_min and self.roomBound.y_min - (math.floor((self.roomBound.y_min - arg_139_1.y) / var_0_70) + 1) * var_0_70 or arg_139_1.y > self.roomBound.y_max and self.roomBound.y_max + (math.floor((arg_139_1.y - self.roomBound.y_max) / var_0_70) + 1) * var_0_70 or (math.floor((arg_139_1.y - self.roomBound.y_min) / var_0_70) + 1 - (self.room_height_num + 1) / 2) * var_0_70 + self:getContentSize().height / 2 - var_0_70

			return {
				x = var_139_1,
				y = var_139_2,
				index = tonumber(var_139_1 .. var_139_2)
			}
		else
			local var_139_5 = math.floor((arg_139_1.x - self.roomBound.x_min) / var_0_70) + 1
			local var_139_6 = math.floor((arg_139_1.y - self.roomBound.y_min) / var_0_70) + 1

			return {
				index = (var_139_6 - 1) * self.room_width_num + var_139_5,
				order_x = var_139_5,
				order_y = var_139_6,
				x = (var_139_5 - (self.room_width_num + 1) / 2) * var_0_70 + self:getContentSize().width / 2 - var_0_70 / 2,
				y = (var_139_6 - (self.room_height_num + 1) / 2) * var_0_70 + self:getContentSize().height / 2 - var_0_70 / 2
			}
		end
	end
end

function RogueRoom:transform_map_camera(arg_140_1, arg_140_2)
	local var_140_0, var_140_1 = self.root.mapView:getInnerContainer():getPosition()
	local var_140_2, var_140_3 = self.root.mapView:getInnerContainer():getContentSize()

	if arg_140_2 == "map_to_camera" then
		return arg_140_1.x + var_140_0, arg_140_1.y + var_140_1
	elseif arg_140_2 == "camera_to_map" then
		return arg_140_1.x - var_140_0, arg_140_1.y - var_140_1
	end
end

function RogueRoom:getChangeEnvAni(arg_141_1, arg_141_2)
	if arg_141_1 == 1 and arg_141_2 == 2 then
		return "xiashui", "run"
	elseif arg_141_1 == 2 and arg_141_2 == 1 then
		return "shangshui", "run"
	elseif arg_141_1 == 3 and arg_141_2 == 1 then
		return "run", "idle"
	elseif arg_141_1 == 1 and arg_141_2 == 3 then
		return "idle", "noAni"
	end
end

function RogueRoom:isEnvRedayByCurSkin(arg_142_1)
	if not self.curMapConfig.array[self.tag.arrayorder] then
		return false
	end

	local var_142_0 = var_0_37:getCurArraySkin(self.curMapConfig.array[self.tag.arrayorder])

	if var_142_0 and var_142_0 == major_factor_data[servant_data[self.curMapConfig.array[self.tag.arrayorder].fight_girl].major][({
		[var_0_58] = "swim_suit"
	})[arg_142_1]] then
		return true
	else
		return false
	end
end

function RogueRoom:isEnvCanPass(arg_143_1)
	if ({
		[var_0_59] = true
	})[arg_143_1] then
		return true
	else
		return false
	end
end

function RogueRoom:playChangeEnvAni()
	local var_144_0 = self.mapEnvs[self.curPosIndex] or 1

	if var_144_0 ~= self.curMapEnv and (function(arg_145_0)
		if arg_145_0 == var_0_58 then
			return self:isEnvRedayByCurSkin(arg_145_0)
		else
			return true
		end
	end)(var_144_0, self.curMapEnv) then
		local var_144_1, var_144_2 = self:getChangeEnvAni(self.curMapEnv, var_144_0)

		if self:isEnvCanPass(var_144_0) == false then
			self:playAni(var_144_1, function()
				self:playAni(var_144_2)
			end)
		end

		self.curMapEnv = var_144_0
	end
end

function RogueRoom:updateCurPosInfo()
	self.curPosIndex = self.curMapConfig.curPosIndex

	local var_147_0 = math.floor((self.curPosIndex - 1) / self.room_width_num) + 1

	self.curPos = cc.p((self.curPosIndex - 1) % self.room_width_num + 1, var_147_0)
	self.curCoordinate = cc.p(((self.curPosIndex - 1) % self.room_width_num + 1 - (self.room_width_num + 1) / 2) * var_0_70 + self:getContentSize().width / 2, (var_147_0 - (self.room_height_num + 1) / 2) * var_0_70 + self:getContentSize().height / 2)
end

function RogueRoom:randomRole(arg_148_1)
	if not self.curMapConfig.array then
		return
	end

	local var_148_0 = {}

	if arg_148_1 then
		local var_148_3

		for iter_148_0 = 1, 4 do
			if self.curMapConfig.array[iter_148_0] and self.curMapConfig.array[iter_148_0].fight_girl then
				var_148_3 = iter_148_0

				break
			end
		end

		local var_148_6 = self.curMapConfig.change_role_modelid
		local var_148_9
		local var_148_7
		local var_148_10
		local var_148_8

		if not self.curMapConfig.change_role_modelid then
			var_148_6 = var_0_37:getCurArrayModel(self.curMapConfig.array[var_148_3])
			var_148_7 = model_data[var_148_6].clothes_model
			var_148_8 = var_0_68 * (model_data[var_148_6].modelscale > 1.3 and 1.3 or model_data[var_148_6].modelscale)
			var_148_9 = cc.size(model_data[var_148_6].modelweight, model_data[var_148_6].modelheight)
			var_148_10 = {
				jsonFilePath = ROLE_SPINE_PATH .. model_data[var_148_6].spine_model .. ".json"
			}
		end

		var_148_10.atlasFilePath = ROLE_SPINE_PATH .. model_data[var_148_6].spine_model .. ".atlas"

		if var_148_7 then
			var_148_10.clothesFilePath = CLOTHES_SPINE_PATH .. var_148_7 .. ".atlas" or nil
		end

		var_148_10.scale = var_148_8
		var_148_10.size = var_148_9
		var_148_10.modelid = var_148_6
		var_148_10.arrayorder = var_148_3

		return var_148_10
	end

	for iter_148_1, iter_148_2 in pairs(self.curMapConfig.array) do
		if iter_148_2.fight_girl then
			var_148_0[#var_148_0 + 1] = iter_148_2.fight_girl
		end
	end

	return CUTE_ROLE_IMAGE_PATH .. model_data[servant_data[var_148_0[math.random(#var_148_0)]].modelid].cute_role .. ".png"
end

function RogueRoom:initSelectedFrame()
	local var_149_0 = self:randomRole(true)

	self.tag = L2Actor:createExploreLead(var_149_0.jsonFilePath, var_149_0.atlasFilePath, var_149_0.clothesFilePath)

	self.tag:setName("tag")

	self.tag.modelid = var_149_0.modelid
	self.tag.arrayorder = var_149_0.arrayorder

	self.tag:setScale(var_149_0.scale * (self.direction == var_0_45 and -1 or 1), var_149_0.scale)

	self.tag.cur_scale = var_149_0.scale

	self.tag:setContentSize(var_149_0.size)
	self.tag:setPosition(self.curCoordinate)
	self:playAni("idle")
	self.tag.skeletonAnimation:setTimeScale(1.5)
	self.iconLayout:addChild(self.tag, (self.room_height_num - self.curPos.y + 1) * 2)

	self.SPEED = 720

	if self.roomfollowholeConfig[self.curRoomOrder] and self.mask then
		self.mask:setScale(self.roomfollowholeConfig[self.curRoomOrder].scale)
		self.mask:setPosition((self:convertToNodeSpace(cc.p(GameDisplay.cx, GameDisplay.cy))))

		local var_149_2 = self:convertToWorldSpace(cc.p(self.curCoordinate.x, self.curCoordinate.y + 50))

		self.mask:focus(var_149_2.x, var_149_2.y)
	end

	self:createFollowNpcByServer()

	for iter_149_0 = 1, #self.root.followQueue do
		self.root.followQueue[iter_149_0]:removeFromParent()

		if self.direction == var_0_42 then
			local var_149_3 = self:transform_index_pos_coordinate(self.curPosIndex - self.room_width_num, "index")

			self.root.followQueue[iter_149_0]:setPosition(cc.p(var_149_3.x, var_149_3.y))
			self.root.followQueue[iter_149_0]:updateNpcPosInfo(self.curPosIndex - self.room_width_num, self)
		elseif self.direction == var_0_44 then
			local var_149_4 = self:transform_index_pos_coordinate(self.curPosIndex + self.room_width_num, "index")

			self.root.followQueue[iter_149_0]:setPosition(cc.p(var_149_4.x, var_149_4.y))
			self.root.followQueue[iter_149_0]:updateNpcPosInfo(self.curPosIndex + self.room_width_num, self)
		elseif self.direction == var_0_45 then
			local var_149_5 = self:transform_index_pos_coordinate(self.curPosIndex + 1, "index")

			print("m_tbl===", dump(var_149_5), dump(self.curCoordinate))
			self.root.followQueue[iter_149_0]:setPosition(cc.p(var_149_5.x, var_149_5.y))
			self.root.followQueue[iter_149_0]:updateNpcPosInfo(self.curPosIndex + 1, self)
		elseif self.direction == var_0_43 then
			local var_149_6 = self:transform_index_pos_coordinate(self.curPosIndex - 1, "index")

			self.root.followQueue[iter_149_0]:setPosition(cc.p(var_149_6.x, var_149_6.y))
			self.root.followQueue[iter_149_0]:updateNpcPosInfo(self.curPosIndex - 1, self)
		else
			local var_149_7 = self:transform_index_pos_coordinate(self.curPosIndex, "index")

			self.root.followQueue[iter_149_0]:setPosition(cc.p(var_149_7.x, var_149_7.y))
			self.root.followQueue[iter_149_0]:updateNpcPosInfo(self.curPosIndex, self)
		end

		self.root.followQueue[iter_149_0]:playAni(nil, "idle", true)
		self.iconLayout:addChild(self.root.followQueue[iter_149_0], (self.room_height_num - 3 + 1) * 2)
	end
end

function RogueRoom:popTalkSp(arg_150_1, arg_150_2, arg_150_3)
	require("view.Sprite.TalkSprite")

	arg_150_1 = arg_150_1 or "Hello World"

	if self.tag:getChildByName("pop_talk") then
		self.tag:getChildByName("pop_talk"):updateString(arg_150_1, arg_150_3, arg_150_2)
	else
		local var_150_0 = TalkSprite:create(arg_150_1, 120, nil, arg_150_3, arg_150_2)

		var_150_0:setName("pop_talk")
		self.tag:addChild(var_150_0)
	end

	if self.roomBound.x_max - self.tag:getPositionX() <= 150 then
		self.tag:getChildByName("pop_talk"):setAnchorPoint(cc.p(0.75, self.tag:getChildByName("pop_talk"):getAnchorPoint().y))
		self.tag:getChildByName("pop_talk"):setArrowPositionX(self.tag:getChildByName("pop_talk"):getContentSize().width / 4 + 125)
	end
end

function RogueRoom:updateSelectedFrame(arg_151_1)
	if not self.curMapConfig.array then
		return
	end

	if not self.curMapConfig.array[arg_151_1] then
		return
	end

	local var_151_2 = var_0_37:getCurArraySkin(self.curMapConfig.array[arg_151_1])
	local var_151_3 = var_0_37:getCurArrayModel(self.curMapConfig.array[arg_151_1])
	local var_151_4

	if model_data[var_151_3].clothes_model then
		var_151_4 = CLOTHES_SPINE_PATH .. model_data[var_151_3].clothes_model .. ".atlas" or nil
	end

	local var_151_5 = var_0_68 * (model_data[var_151_3].modelscale > 1.3 and 1.3 or model_data[var_151_3].modelscale)

	self.tag:updateSpine(ROLE_SPINE_PATH .. model_data[var_151_3].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_151_3].spine_model .. ".atlas", var_151_4)
	self.tag:setScale(var_151_5, var_151_5)
	self.tag:setContentSize((cc.size(model_data[var_151_3].modelweight, model_data[var_151_3].modelheight)))
	self.tag:playAni(nil, self.tag.aniName, true)

	self.tag.modelid = var_151_3
	self.tag.arrayorder = arg_151_1

	var_0_37:setModelId(var_151_3)
end

function RogueRoom:mainRoleEnterAction(arg_152_1)
	if not self.direction then
		return
	end

	arg_152_1 = arg_152_1 or 0

	if self.direction == var_0_42 then
		self.tag:setPositionY(self.curCoordinate.y - var_0_70 * 1.5)
	elseif self.direction == var_0_44 then
		self.tag:setPositionY(self.curCoordinate.y + var_0_70 * 1.5)
	elseif self.direction == var_0_45 then
		self.tag:setPositionX(self.curCoordinate.x + var_0_70 * 1.5)
	elseif self.direction == var_0_43 then
		self.tag:setPositionX(self.curCoordinate.x - var_0_70 * 1.5)
	end

	self:playAni("run")
	self.tag:runAction(cc.Sequence:create(cc.DelayTime:create(arg_152_1), cc.MoveTo:create(var_0_71, self.curCoordinate), cc.CallFunc:create(function()
		self:playAni("idle")

		if self.roomfollowholeConfig and next(self.roomfollowholeConfig) then
			audio_manager:playeffectMusicTest("sound/bat_transition")
		end
	end)))
end

function RogueRoom:getIcePath()
	local var_154_0 = self.curPosIndex
	local var_154_1 = {}

	if self.curPosIndex - self.prePosIndex == 1 then
		while not self.objectRange[var_154_0] and not self.mapBlock[var_154_0] and self.mapEnvs[var_154_0] == var_0_59 do
			table.insert(var_154_1, var_154_0)

			var_154_0 = var_154_0 + 1
		end
	elseif self.curPosIndex - self.prePosIndex == -1 then
		while not self.objectRange[var_154_0] and not self.mapBlock[var_154_0] and self.mapEnvs[var_154_0] == var_0_59 do
			table.insert(var_154_1, var_154_0)

			var_154_0 = var_154_0 - 1
		end
	elseif self.curPosIndex - self.prePosIndex > 1 then
		while not self.objectRange[var_154_0] and not self.mapBlock[var_154_0] and self.mapEnvs[var_154_0] == var_0_59 do
			table.insert(var_154_1, var_154_0)

			var_154_0 = var_154_0 + self.room_width_num
		end
	else
		while not self.objectRange[var_154_0] and not self.mapBlock[var_154_0] and self.mapEnvs[var_154_0] == var_0_59 do
			table.insert(var_154_1, var_154_0)

			var_154_0 = var_154_0 - self.room_width_num
		end
	end

	if self.mapEnvs[var_154_0] ~= var_0_59 and not self.mapBlock[var_154_0] and var_154_0 > 0 then
		table.insert(var_154_1, var_154_0)
	end

	return var_154_1
end

function RogueRoom:updateRoute()
	if (self.curMapEnv == var_0_59 or self.preEnv == var_0_59) and self.root.touchLock == false then
		self.root.touchLock = true

		local var_155_0 = self:getIcePath()

		if next(var_155_0) == nil then
			self.root.touchLock = false

			return
		end

		if #var_155_0 >= 2 then
			self.SPEED = 1440
			self.actionMove = "noAni"

			self:moveSelectedFrame(var_155_0, nil, function()
				self.root.touchLock = false
				self.SPEED = 720
				self.actionMove = nil
			end)
		else
			self:moveSelectedFrame(var_155_0)

			self.root.touchLock = false
			self.SPEED = 720
		end

		return true
	end
end

function RogueRoom:updateRouteWithEnv()
	if self.curMapEnv == var_0_59 or self.preEnv == var_0_59 and self.root.touchLock == false then
		return self:updateRoute()
	end
end

function RogueRoom:getAniNameByEnv(arg_158_1)
	if arg_158_1 == "idle" or arg_158_1 == "run" then
		if var_0_60[self.curMapEnv] then
			return var_0_60[self.curMapEnv][arg_158_1]
		end
	else
		return arg_158_1
	end
end

function RogueRoom:playAni(arg_159_1, arg_159_2)
	if self.tag.aniName == "run" and arg_159_1 == "skill1" then
		self.root.touchLock = false

		return
	end

	if self.role_ani_lock then
		return
	end

	arg_159_1 = self:getAniNameByEnv(arg_159_1)

	if arg_159_1 == self.tag.aniName then
		return
	end

	if arg_159_1 == "noAni" then
		arg_159_1 = "idle"
	end

	self.tag.aniName = arg_159_1

	if arg_159_2 then
		self.tag:playAni(arg_159_2, arg_159_1, false)
	else
		self.tag:playAni(nil, arg_159_1, true)

		if arg_159_1 == var_0_60[self.curMapEnv].run then
			if not self.cur_sound_effect or self.cur_sound_effect and self.cur_sound_effect ~= var_0_61[self.curMapEnv] then
				self.cur_sound_effect = var_0_61[self.curMapEnv]

				audio_manager:stopAllEffects()
			end

			audio_manager:playeffectMusic(self.cur_sound_effect, true)
		else
			audio_manager:stopAllEffects()
		end
	end

	if arg_159_1 == "run" then
		self.tag.skeletonAnimation:setTimeScale(1)
	elseif arg_159_1 == "idle" then
		self.tag.skeletonAnimation:setTimeScale(0.8)
	else
		self.tag.skeletonAnimation:setTimeScale(1)
	end
end

function RogueRoom:initTouchMark()
	self.touchMark = ccui.ImageView:create("explore/touch_mark1.png", var_0_1)

	self.touchMark:setAnchorPoint(cc.p(0, 0))
	self.touchMark:setVisible(false)
	self.iconLayout:addChild(self.touchMark, 999)

	local var_160_0 = ccui.ImageView:create("explore/touch_mark2.png", var_0_1)

	var_160_0:setName("mark2")
	var_160_0:setPosition(self.touchMark:getContentSize().width / 2, self.touchMark:getContentSize().height / 2)
	self.touchMark:addChild(var_160_0)
end

function RogueRoom:setTouchMarkPos(arg_161_1, arg_161_2, arg_161_3, arg_161_4, arg_161_5)
	self.touchMark:stopAllActions()
	self.touchMark:setVisible(true)
	self.touchMark:setOpacity(255)
	self.touchMark:getChildByName("mark2"):stopAllActions()
	self.touchMark:getChildByName("mark2"):setOpacity(0)
	self.touchMark:getChildByName("mark2"):setScale(1)
	self.touchMark:setPosition(arg_161_1)

	if arg_161_2 > 0 then
		self.touchMark:loadTexture("explore/touch_mark1.png", var_0_1)
		self.touchMark:getChildByName("mark2"):loadTexture("explore/touch_mark2.png", var_0_1)
	else
		self.touchMark:loadTexture("explore/no_touch_mark1.png", var_0_1)
		self.touchMark:getChildByName("mark2"):loadTexture("explore/no_touch_mark2.png", var_0_1)
	end

	self.touchMark.flag = arg_161_2
	self.touchMark.path = arg_161_3
	self.touchMark.curIndex = arg_161_4
	self.touchMark.targetIndex = arg_161_5
end

function RogueRoom:playTouchMarkAction()
	if not self.touchMark then
		return
	end

	local var_162_0 = self.touchMark:getChildByName("mark2")

	self.touchMark:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeOut:create(0.2)))
	var_162_0:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.3), cc.ScaleTo:create(0.3, 1.1)), cc.ScaleTo:create(0.2, 1)))

	if self.touchMark.flag == 2 then
		if self.touchMark.curIndex and self.touchMark.curIndex ~= self.curPosIndex then
			local var_162_1 = self:findRoad(self.touchMark.targetIndex)

			if var_162_1 then
				return 2, var_162_1
			else
				return -3
			end
		else
			return self.touchMark.flag, self.touchMark.path
		end
	else
		print("self.touchMark.flag, self.touchMark.path222", self.touchMark.flag, dump(self.touchMark.path))

		return self.touchMark.flag, self.touchMark.path
	end
end

function RogueRoom:createTileObject(arg_163_1, arg_163_2, arg_163_3, arg_163_4)
	local var_163_0 = {
		tileInfo = arg_163_1,
		idx = arg_163_2,
		order = arg_163_3,
		pos = arg_163_4,
		zOrder = (self.room_height_num - self:transform_index_pos_coordinate(arg_163_3, "index").order_y + 1) * 2 - 1,
		parent = self,
		fullImage = var_0_32[self.curMapId].fullImage,
		size_num = cc.size(var_0_37:getTileSize(arg_163_1.id))
	}
	local var_163_1 = {
		[TILE_TYPE.NORMAL_ENEMY] = function()
			return require("view.Sprite.rogue_explore.MonsterTile"):create(var_163_0)
		end,
		[TILE_TYPE.SPECIAL_ENEMY] = function()
			return require("view.Sprite.rogue_explore.MonsterTile"):create(var_163_0)
		end,
		[TILE_TYPE.NPC] = function()
			return require("view.Sprite.rogue_explore.NpcTile"):create(var_163_0)
		end,
		[TILE_TYPE.DES_WALL] = function()
			return require("view.Sprite.rogue_explore.DesWallTile"):create(var_163_0)
		end,
		[TILE_TYPE.POKEMON] = function()
			return require("view.Sprite.rogue_explore.PokemonTile"):create(var_163_0)
		end,
		[TILE_TYPE.NPCFOLLOW] = function()
			return require("view.Sprite.rogue_explore.NpcfollowTile"):create(var_163_0)
		end,
		[TILE_TYPE.STATEPROCESS] = function()
			return require("view.Sprite.rogue_explore.StateProceTile"):create(var_163_0)
		end,
		[TILE_TYPE.ANIMATION] = function()
			return require("view.Sprite.rogue_explore.aniTile"):create(var_163_0)
		end,
		[TILE_TYPE.CRACKLE] = function()
			return require("view.Sprite.rogue_explore.CrackleTile"):create(var_163_0)
		end,
		[TILE_TYPE.CRACKLE_DOOR] = function()
			return require("view.Sprite.rogue_explore.crackleDoorTile"):create(var_163_0)
		end,
		[TILE_TYPE.PASSWORD] = function()
			return require("view.Sprite.rogue_explore.PasswordTile"):create(var_163_0)
		end,
		[TILE_TYPE.STORY_ENEMY] = function()
			return require("view.Sprite.rogue_explore.storyMonsterTile"):create(var_163_0)
		end,
		[TILE_TYPE.MEMORY_CARD] = function()
			return require("view.Sprite.rogue_explore.memoryCardTile"):create(var_163_0)
		end,
		[TILE_TYPE.SELECT_TALK] = function()
			return require("view.Sprite.rogue_explore.TalkTile"):create(var_163_0)
		end,
		[TILE_TYPE.PATH_GOLD] = function()
			return require("view.Sprite.rogue_explore.PathGoldTile"):create(var_163_0)
		end
	}

	setmetatable(var_163_1, {
		__index = function()
			return function()
				return require("view.Sprite.rogue_explore.TileSprite"):create(var_163_0)
			end
		end,
		__call = function(self, arg_181_1)
			return self[arg_181_1]()
		end
	})

	return var_163_1(arg_163_1.class)
end

function RogueRoom:genMap()
	(function()
		for iter_184_0 = 1, self.room_width_num * self.room_height_num do
			local var_184_0 = self:transform_index_pos_coordinate(iter_184_0, "index")
			local var_184_2 = {}

			for iter_184_1, iter_184_2 in pairs(var_0_34[self.curRoomInfo.imglayer][iter_184_0]) do
				iter_184_2, transform_type = var_0_37:decodeImgid(iter_184_2)

				if type(iter_184_1) == "number" or type(iter_184_1) == "string" and not self.replaceModel[iter_184_0] then
					iter_184_1 = type(iter_184_1) == "number" and iter_184_1 or var_0_34[self.curRoomInfo.imglayer].max_zorder

					table.insert(var_184_2, {
						img = iter_184_2,
						z_order = iter_184_1,
						transform_type = transform_type
					})
				end
			end

			if var_0_37.curMapConfig.finishImgs[self.curRoomInfo.imglayer] and var_0_37.curMapConfig.finishImgs[self.curRoomInfo.imglayer][iter_184_0] then
				table.insert(var_184_2, 1, {
					img = var_0_37.curMapConfig.finishImgs[self.curRoomInfo.imglayer][iter_184_0],
					z_order = var_0_34[self.curRoomInfo.imglayer].max_zorder
				})
			end

			table.sort(var_184_2, function(arg_185_0, arg_185_1)
				return arg_185_0.z_order > arg_185_1.z_order
			end)

			if self.curRoomInfo.doorsImg[iter_184_0] and not self.pathTree.nexts[self.curRoomInfo.doorsImg[iter_184_0].direction] then
				imgid, transform_type = var_0_37:decodeImgid(self.curRoomInfo.doorsImg[iter_184_0].img)

				if self.curRoomInfo.doorsImg[iter_184_0].is_replace then
					var_184_2[1].img = imgid
					var_184_2[1].transform_type = transform_type
				else
					table.insert(var_184_2, 1, {
						img = imgid,
						z_order = var_184_2[1].z_order + 1,
						transform_type = transform_type
					})
				end
			end

			for iter_184_3 = #var_184_2, 1, -1 do
				local var_184_3 = cc.Sprite:createWithSpriteFrameName("tiles_" .. var_0_32[self.curMapId].fullImage .. "/" .. var_184_2[iter_184_3].img .. ".png")

				var_184_3:setPosition(var_184_0.x + var_184_3:getContentSize().width / 2, var_184_0.y + var_184_3:getContentSize().height / 2)
				var_182_2(var_184_3, var_184_2[iter_184_3].transform_type)

				if explore_img_data[var_184_2[iter_184_3].img].is_big_icon then
					self.iconLayout:addChild(var_184_3, (self.room_height_num - var_184_0.order_y + 1) * 2 - 1)
				else
					self.batchNodeLayout:addChild(var_184_3, (self.room_height_num - var_184_0.order_y + 1) * 2 - 1)
				end
			end
		end
	end)()
	;(function()
		for iter_186_0, iter_186_1 in pairs(self.usedTile) do
			local var_186_0 = self:transform_index_pos_coordinate(iter_186_1.order, "index")

			self.tileobjects[iter_186_0] = self:createTileObject(var_0_35[iter_186_1.tileid], iter_186_0, var_186_0.index, cc.p(var_186_0.x, var_186_0.y))
		end
	end)()
	;(function()
		if not self.roomLight then
			return
		end

		for iter_187_0, iter_187_1 in pairs(self.roomLight) do
			local var_187_0

			if config._DEBUG then
				var_187_0 = cc.Sprite:create("explore/" .. iter_187_1.light .. ".png") or cc.Sprite:createWithSpriteFrameName("explore/" .. iter_187_1.light .. ".png")
			end

			local var_187_1 = self:transform_index_pos_coordinate(iter_187_1.light_pos, "pos")

			var_187_0:setPosition(var_187_1.x + var_0_70 / 2 + iter_187_1.light_offset.x, var_187_1.y + var_0_70 / 2 + iter_187_1.light_offset.y)
			var_187_0:setScale(iter_187_1.light_scale)
			var_187_0:setOpacity(255 * iter_187_1.light_opacity)
			var_187_0:setBlendFunc(GL_SRC_COLOR, GL_ONE)
			self.iconLayout:addChild(var_187_0, 99)
		end
	end)()
end

function RogueRoom:updateRangeModel(arg_188_1)
	if not self.rangeModel.center[arg_188_1] then
		return
	end

	local function var_188_0(arg_189_0)
		if self.maskPanel:getChildByName("maskPanel" .. arg_189_0) then
			self.maskPanel:getChildByName("maskPanel" .. arg_189_0):removeFromParent()
		end
	end

	for iter_188_0, iter_188_1 in pairs(self.rangeModel.center[arg_188_1]) do
		for iter_188_2, iter_188_3 in pairs(self.rangeModel.range[iter_188_1]) do
			if iter_188_3 == arg_188_1 then
				table.remove(self.rangeModel.range[iter_188_1], iter_188_2)
			end
		end

		if next(self.rangeModel.range[iter_188_1]) == nil then
			self.rangeModel.range[iter_188_1] = nil
		end
	end

	self.rangeModel.center[arg_188_1] = nil

	var_188_0(arg_188_1)
end

function RogueRoom:registerTouchEvent()
	local var_190_0 = cc.EventListenerTouchOneByOne:create()

	var_190_0:setSwallowTouches(true)
	var_190_0:registerScriptHandler(function(arg_191_0, arg_191_1)
		if self.root.touchLock then
			return false
		end

		local var_191_0 = self:convertToNodeSpace(arg_191_0:getLocation())

		if cc.rectContainsPoint(cc.rect(self.root.mapView:getPositionX(), GameDisplay.fix_y + self.root.mapView:getPositionY(), self.root.mapView:getContentSize().width, self.root.mapView:getContentSize().height), arg_191_0:getLocation()) then
			local var_191_1 = self:transform_index_pos_coordinate(var_191_0, "coordinate")

			self:setTouchMarkPos(cc.p(var_191_1.x, var_191_1.y), self:getTouchResult(var_191_0))

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_190_0:registerScriptHandler(function(arg_192_0, arg_192_1)
		local var_192_0 = self:convertToNodeSpace(arg_192_0:getLocation())
		local var_192_1 = self:transform_index_pos_coordinate(var_192_0, "coordinate")

		if var_192_1.index ~= self:transform_index_pos_coordinate(self:convertToNodeSpace(arg_192_0:getPreviousLocation()), "coordinate").index or var_192_1.index ~= self.touchMark.targetIndex then
			self:setTouchMarkPos(cc.p(var_192_1.x, var_192_1.y), self:getTouchResult(var_192_0))
		end
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_190_0:registerScriptHandler(function(arg_193_0, arg_193_1)
		local var_193_0, var_193_1 = self:playTouchMarkAction()
		local var_193_2 = self:transform_index_pos_coordinate(self:convertToNodeSpace(arg_193_0:getLocation()), "coordinate").index

		if self.touchMark.targetIndex and self.touchMark.targetIndex ~= var_193_2 then
			var_193_2 = self.touchMark.targetIndex
		end

		if var_193_0 > 0 then
			if var_193_2 == self.curPosIndex then
				if self.objectRange[var_193_2] then
					if self.tileobjects[self.objectRange[var_193_2]].tileInfo.is_touch ~= 0 then
						self:triggerEvent(self.objectRange[var_193_2])
					end
				else
					self:popSwitchRole()
				end
			else
				self:updatePos(var_193_2, var_193_1)
			end
		elseif var_193_0 == -1 then
			-- block empty
		elseif var_193_0 == -2 then
			audio_manager:playeffectMusicTest(EXPLORE_INVALID)
			global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[2])
		elseif var_193_0 == -3 then
			global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[3])
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_190_0, self)
end

function RogueRoom:getnext(arg_194_1, arg_194_2)
	local var_194_0 = self:transform_index_pos_coordinate(arg_194_1, "index")
	local var_194_1

	if arg_194_2 == var_0_42 then
		var_194_1 = arg_194_1 + self.room_width_num

		if var_194_0.order_y == self.room_height_num then
			var_194_1 = nil
		end
	elseif arg_194_2 == var_0_43 then
		var_194_1 = arg_194_1 + 1

		if var_194_0.order_x == self.room_width_num then
			var_194_1 = nil
		end
	elseif arg_194_2 == var_0_44 then
		var_194_1 = arg_194_1 - self.room_width_num

		if var_194_0.order_y == 1 then
			var_194_1 = nil
		end
	elseif arg_194_2 == var_0_45 then
		var_194_1 = arg_194_1 - 1

		if var_194_0.order_x == 1 then
			var_194_1 = nil
		end
	end

	return var_194_1
end

function RogueRoom:isImgMapBlock(arg_195_1)
	if self.mapEnvs[arg_195_1] then
		if self:isEnvRedayByCurSkin(self.mapEnvs[arg_195_1]) or self:isEnvCanPass(self.mapEnvs[arg_195_1]) then
			return not not self.mapBlock[arg_195_1]
		else
			return true
		end
	elseif self.mapBlock[arg_195_1] then
		return true
	else
		return false
	end
end

function RogueRoom:isTileCanPass(arg_196_1)
	if self.monsterRange[arg_196_1] then
		return false
	elseif self.objectRange[arg_196_1] then
		return self.tileobjects[self.objectRange[arg_196_1]]:isTileCanPass() and not self:isImgMapBlock(arg_196_1)
	elseif self:checkIsBound(arg_196_1) then
		return false
	else
		return not self:isImgMapBlock(arg_196_1)
	end
end

function RogueRoom:checkIsBound(arg_197_1)
	local var_197_0 = self:transform_index_pos_coordinate(arg_197_1, "index")

	if (var_197_0.order_x == 1 or var_197_0.order_x == self.room_width_num) and (var_197_0.order_y == 1 or var_197_0.order_y == self.room_height_num) then
		return false
	end

	if var_197_0.order_x == 1 and self.pathTree.nexts[var_0_45] then
		return true, var_0_45
	elseif var_197_0.order_x == self.room_width_num and self.pathTree.nexts[var_0_43] then
		return true, var_0_43
	elseif var_197_0.order_y == 1 and self.pathTree.nexts[var_0_44] then
		return true, var_0_44
	elseif var_197_0.order_y == self.room_height_num and self.pathTree.nexts[var_0_42] then
		return true, var_0_42
	end

	return false
end

function RogueRoom:checkBoundIsLock(arg_198_1)
	local var_198_0 = math.floor((self.curRoomOrder - 1) / self.curMapSize.width) + 1

	if self.pathTree.nexts[arg_198_1] then
		local var_198_1

		if arg_198_1 == var_0_42 then
			var_198_1 = (var_198_0 - 1) * (self.curMapSize.width - 1) + (var_198_0 - 1 - 1) * self.curMapSize.width + ((self.curRoomOrder - 1) % self.curMapSize.width + 1)
		elseif arg_198_1 == var_0_44 then
			var_198_1 = var_198_0 * (self.curMapSize.width - 1) + (var_198_0 - 1) * self.curMapSize.width + ((self.curRoomOrder - 1) % self.curMapSize.width + 1)
		elseif arg_198_1 == var_0_45 then
			var_198_1 = (var_198_0 - 1) * (self.curMapSize.width - 1 + self.curMapSize.width) + ((self.curRoomOrder - 1) % self.curMapSize.width + 1) - 1
		elseif arg_198_1 == var_0_43 then
			var_198_1 = (var_198_0 - 1) * (self.curMapSize.width - 1 + self.curMapSize.width) + ((self.curRoomOrder - 1) % self.curMapSize.width + 1)
		end

		if self.bridgeLocks[var_198_1] then
			return true, self.bridgeLocks[var_198_1]
		elseif self.root.isBridgeAction and self.root.isBridgeAction == var_198_1 then
			return true, {
				tileid = self.root.isBridgeAction
			}
		end
	end
end

function RogueRoom:getTouchResult(arg_199_1)
	if arg_199_1.x < self.roomBound.x_min or arg_199_1.x > self.roomBound.x_max or arg_199_1.y < self.roomBound.y_min or arg_199_1.y > self.roomBound.y_max then
		return -1
	end

	local var_199_0 = self:transform_index_pos_coordinate(arg_199_1, "coordinate")
	local var_199_1 = var_199_0.index

	if var_199_0.index == self.curPosIndex then
		return 1
	end

	if (var_199_0.order_x == 1 or var_199_0.order_x == self.room_width_num) and (var_199_0.order_y == 1 or var_199_0.order_y == self.room_height_num) then
		return -1
	end

	if not self.objectRange[var_199_1] and self:isImgMapBlock(var_199_1) then
		return -1
	end

	if (function(arg_200_0)
		if self.monsterRange[arg_200_0] then
			return false
		end

		if self.objectRange[arg_200_0] then
			if var_0_37:objectIsMonster(self.usedTile[self.objectRange[arg_200_0]].tileid) and self.tileobjects[self.objectRange[arg_200_0]].order == arg_200_0 then
				return false
			end

			local var_200_0 = self.tileobjects[self.objectRange[arg_200_0]].size_num.width
			local var_200_1 = self.tileobjects[self.objectRange[arg_200_0]].size_num.height
			local var_200_2 = self:transform_index_pos_coordinate(self.tileobjects[self.objectRange[arg_200_0]].order, "index")
			local var_200_3 = var_200_2.order_x
			local var_200_4 = var_200_2.order_y
			local var_200_5 = 0
			local var_200_6 = 0

			for iter_200_0 = 1, 4 do
				if iter_200_0 == var_0_42 or iter_200_0 == var_0_44 then
					for iter_200_1 = var_200_3, var_200_3 + var_200_0 - 1 do
						local var_200_7 = self:getnext(self:transform_index_pos_coordinate(cc.p(iter_200_1, (iter_200_0 == var_0_42 or nil) and (var_200_4 + var_200_1 - 1 or var_200_4)), "pos").index, iter_200_0)

						if not var_200_7 then
							var_200_6 = var_200_6 + 1
						elseif not self:isTileCanPass(var_200_7) then
							var_200_6 = var_200_6 + 1
						end

						var_200_5 = var_200_5 + 1
					end
				elseif iter_200_0 == var_0_45 or iter_200_0 == var_0_43 then
					local var_200_8 = iter_200_0 == var_0_45 and var_200_3 or var_200_3 + var_200_0 - 1

					for iter_200_2 = var_200_4, var_200_4 + var_200_1 - 1 do
						local var_200_9 = self:getnext(self:transform_index_pos_coordinate(cc.p(var_200_8, iter_200_2), "pos").index, iter_200_0)

						if not var_200_9 then
							var_200_6 = var_200_6 + 1
						elseif not self:isTileCanPass(var_200_9) then
							var_200_6 = var_200_6 + 1
						end

						var_200_5 = var_200_5 + 1
					end
				end
			end

			if var_200_5 == var_200_6 then
				return true
			else
				return false
			end
		else
			local var_200_10 = 0

			for iter_200_3 = 1, 4 do
				local var_200_11 = self:getnext(arg_200_0, iter_200_3)

				if not var_200_11 then
					var_200_10 = var_200_10 + 1
				elseif not self:isTileCanPass(var_200_11) then
					var_200_10 = var_200_10 + 1
				end
			end

			if var_200_10 == 4 then
				return true
			else
				return false
			end
		end
	end)(var_199_1) then
		return -3
	end

	local var_199_2 = self:findRoad(var_199_1)

	if var_199_2 then
		return 2, var_199_2, self.curPosIndex, var_199_1
	else
		return -3
	end
end

function RogueRoom:findRoad(arg_201_1)
	if self:getChildByName("testLayout") then
		self:getChildByName("testLayout"):removeAllChildren()
	end

	local var_201_0 = self.curPosIndex
	local var_201_2 = self:transform_index_pos_coordinate(arg_201_1, "index")
	local var_201_3 = cc.p(var_201_2.order_x, var_201_2.order_y)
	local var_201_4 = {
		{
			index = self.curPosIndex
		}
	}
	local var_201_5 = {
		[self.curPosIndex] = 1
	}
	local var_201_6 = {}
	local var_201_7 = {
		[self.curPosIndex] = -1
	}

	local function var_201_8(arg_202_0, arg_202_1, arg_202_2, arg_202_3)
		if not var_0_62 then
			return
		end

		local var_202_0 = self:getChildByName("testLayout")

		self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_202_3), cc.CallFunc:create(function()
			local var_203_0 = self:transform_index_pos_coordinate(arg_202_0, "index")
			local var_203_3 = ccui.ImageView:create("public/box/UI_smeltScene_equipOn.png", var_0_1)

			var_203_3:setAnchorPoint(cc.p(0, 0))
			var_203_3:setName("test" .. arg_202_0)
			var_203_3:setPosition(var_203_0.x, var_203_0.y)
			var_202_0:addChild(var_203_3, 1)

			local var_203_4 = cc.Label:createWithTTF("G: " .. arg_202_1, FONT_NAME, 20)

			var_203_4:setName("G_label")
			var_203_4:setColor(cc.c3b(0, 0, 0))
			var_203_4:setAnchorPoint(cc.p(0, 0.5))
			var_203_4:setPosition(0, 30)
			var_203_3:addChild(var_203_4)

			local var_203_5 = cc.Label:createWithTTF("H: " .. arg_202_2, FONT_NAME, 20)

			var_203_5:setName("H_label")
			var_203_5:setColor(cc.c3b(0, 0, 0))
			var_203_5:setAnchorPoint(cc.p(0, 0.5))
			var_203_5:setPosition(0, 60)
			var_203_3:addChild(var_203_5)

			local var_203_6 = cc.Label:createWithTTF("F: " .. arg_202_2 + arg_202_1, FONT_NAME, 20)

			var_203_6:setName("F_label")
			var_203_6:setColor(cc.c3b(0, 0, 0))
			var_203_6:setAnchorPoint(cc.p(0, 0.5))
			var_203_6:setPosition(0, 90)
			var_203_3:addChild(var_203_6)
		end)))
	end

	local function var_201_9(arg_204_0, arg_204_1, arg_204_2, arg_204_3)
		if not var_0_62 then
			return
		end

		if not self:getChildByName("testLayout") then
			return
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_204_3), cc.CallFunc:create(function()
			local var_205_0 = self:getChildByName("testLayout"):getChildByName("test" .. arg_204_0)

			var_205_0:getChildByName("G_label"):setString("G:" .. arg_204_1)
			var_205_0:getChildByName("H_label"):setString("H:" .. arg_204_2)
			var_205_0:getChildByName("F_label"):setString("F:" .. arg_204_2 + arg_204_1)
		end)))
	end

	local function var_201_10(arg_206_0, arg_206_1)
		if not var_0_62 then
			return
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_206_1), cc.CallFunc:create(function()
			if not self:getChildByName("testLayout") then
				return
			end

			if not self:getChildByName("testLayout"):getChildByName("test" .. arg_206_0) then
				return
			end

			self:getChildByName("testLayout"):getChildByName("test" .. arg_206_0):setColor(cc.c3b(100, 0, 0))
		end)))
	end

	local function var_201_11(arg_208_0)
		if not var_201_7[arg_208_0] then
			return
		end

		local var_208_0 = 1
		local var_208_1 = arg_208_0

		while var_201_7[arg_208_0] > 0 do
			var_208_0 = var_208_0 + 1
			var_208_1 = var_201_7[arg_208_0]
		end

		return var_208_0
	end

	local function var_201_12(arg_209_0)
		local var_209_0 = self:transform_index_pos_coordinate(arg_209_0, "index")
		local var_209_1 = math.sqrt(math.abs(var_209_0.order_x - var_201_3.x) * math.abs(var_209_0.order_x - var_201_3.x) + math.abs(var_209_0.order_y - var_201_3.y) * math.abs(var_209_0.order_y - var_201_3.y))

		return (math.abs(var_209_0.order_x - var_201_3.x) + math.abs(var_209_0.order_y - var_201_3.y)) * 1.01
	end

	local function var_201_13()
		var_201_5 = {}

		for iter_210_0, iter_210_1 in pairs(var_201_4) do
			var_201_5[iter_210_1.index] = iter_210_0
		end
	end

	local function var_201_14(arg_211_0, arg_211_1)
		var_201_4[arg_211_0], var_201_4[arg_211_1] = var_201_4[arg_211_1], var_201_4[arg_211_0]
	end

	local function var_201_15()
		local var_212_0 = 0

		while 1 * 2 <= #var_201_4 and not false do
			var_212_0 = var_201_4[1].F_value > var_201_4[1 * 2].F_value and 1 * 2 or 1

			if 1 * 2 + 1 <= #var_201_4 and var_201_4[var_212_0].F_value > var_201_4[1 * 2 + 1].F_value then
				var_212_0 = 1 * 2 + 1
			end

			local var_212_1, var_212_2

			if var_212_0 ~= 1 then
				var_201_14(var_212_0, 1)

				var_212_1 = var_212_0
			else
				var_212_2 = true
			end
		end
	end

	local function var_201_16()
		if #var_201_4 == 1 then
			return
		end

		local var_213_0 = #var_201_4

		::label_213_0::

		while var_213_0 ~= 1 and not false do
			if var_213_0 % 2 == 0 then
				local var_213_1 = var_213_0 / 2 or (var_213_0 - 1) / 2

				if var_201_4[var_213_0].F_value < var_201_4[var_213_1].F_value then
					var_201_14(var_213_0, var_213_1)

					var_213_0 = var_213_1

					goto label_213_0
				end
			end
		end
	end

	local function var_201_17(arg_214_0, arg_214_1, arg_214_2)
		var_201_4[#var_201_4 + 1] = {
			index = arg_214_0,
			G_value = arg_214_1,
			H_value = arg_214_2,
			F_value = arg_214_1 + arg_214_2
		}

		var_201_16()
		var_201_13()
	end

	local function var_201_18()
		var_201_4[1] = var_201_4[#var_201_4]
		var_201_4[#var_201_4] = nil

		var_201_15()
		var_201_13()
	end

	local function var_201_19(arg_217_0)
		local var_217_0 = {}
		local var_217_1 = false

		while next(var_201_4) ~= nil do
			var_201_10(var_201_4[1].index, 0 * 0.01)
			var_201_18()

			var_201_6[var_201_4[1].index] = 1

			for iter_217_0 = 1, 4 do
				local var_217_2 = self:getnext(var_201_4[1].index, iter_217_0)

				if var_217_2 then
					local var_217_4

					if not self.usedTile[arg_217_0].range[var_217_2] then
						if self:isTileCanPass(var_217_2) and not var_201_6[var_217_2] then
							if var_201_5[var_217_2] then
								indexInfo = var_201_4[var_201_5[var_217_2]]

								local var_217_3 = var_201_11(var_201_4[1].index) + 1

								if var_217_3 < indexInfo.G_value then
									indexInfo.G_value = var_217_3
									indexInfo.F_value = var_217_3 + var_201_12(var_217_2)
									var_201_7[var_217_2] = var_201_4[1].index

									var_201_9(var_217_2, var_201_11(var_201_4[1].index) + 1, var_201_12(var_217_2), 0 * 0.01)
								end
							else
								var_201_8(var_217_2, var_201_11(var_201_4[1].index) + 1, var_201_12(var_217_2), 0 * 0.01)

								var_217_4 = 0 + 1

								var_201_17(var_217_2, var_201_11(var_201_4[1].index) + 1, var_201_12(var_217_2))

								var_201_7[var_217_2] = var_201_4[1].index
							end
						end
					else
						var_217_1 = true
						var_217_0 = {
							var_217_2
						}
						var_201_7[var_217_2] = var_201_4[1].index

						local var_217_5 = var_217_2

						while var_201_7[var_217_5] ~= var_201_0 do
							table.insert(var_217_0, 1, var_201_7[var_217_5])

							var_217_5 = var_201_7[var_217_5]
						end

						break
					end
				end
			end

			if var_217_1 then
				return var_217_0
			end
		end

		if var_217_1 == false then
			return
		end
	end

	if self.monsterRange[arg_201_1] then
		return var_201_19(self.monsterRange[arg_201_1][1])
	elseif self.objectRange[arg_201_1] then
		return var_201_19(self.objectRange[arg_201_1])
	else
		return (function()
			local var_216_0 = {
				arg_201_1
			}
			local var_216_1 = false

			while next(var_201_4) ~= nil do
				var_201_10(var_201_4[1].index, 0 * 0.01)
				var_201_18()

				var_201_6[var_201_4[1].index] = 1

				for iter_216_0 = 1, 4 do
					local var_216_2 = self:getnext(var_201_4[1].index, iter_216_0)

					if var_216_2 then
						local var_216_4

						if var_216_2 ~= arg_201_1 then
							if self:isTileCanPass(var_216_2) and not var_201_6[var_216_2] then
								if var_201_5[var_216_2] then
									indexInfo = var_201_4[var_201_5[var_216_2]]

									local var_216_3 = var_201_11(var_201_4[1].index) + 1

									if var_216_3 < indexInfo.G_value then
										indexInfo.G_value = var_216_3
										indexInfo.F_value = var_216_3 + var_201_12(var_216_2)
										var_201_7[var_216_2] = var_201_4[1].index

										var_201_9(var_216_2, var_201_11(var_201_4[1].index) + 1, var_201_12(var_216_2), 0 * 0.01)
									end
								else
									var_201_8(var_216_2, var_201_11(var_201_4[1].index) + 1, var_201_12(var_216_2), 0 * 0.01)

									var_216_4 = 0 + 1

									var_201_17(var_216_2, var_201_11(var_201_4[1].index) + 1, var_201_12(var_216_2))

									var_201_7[var_216_2] = var_201_4[1].index
								end
							end
						else
							var_216_1 = true
							var_201_7[var_216_2] = var_201_4[1].index

							local var_216_5 = arg_201_1

							while var_201_7[var_216_5] ~= var_201_0 do
								table.insert(var_216_0, 1, var_201_7[var_216_5])

								var_216_5 = var_201_7[var_216_5]
							end

							break
						end
					end
				end

				if var_216_1 then
					return var_216_0
				end
			end

			if var_216_1 == false then
				return
			end
		end)()
	end
end

function RogueRoom:updatePos(arg_218_1, arg_218_2)
	local var_218_0
	local var_218_1
	local var_218_2 = {}

	if not arg_218_2 then
		global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[3])

		return
	end

	local var_218_3 = arg_218_2[#arg_218_2]

	if self.monsterRange[arg_218_1] then
		if self.tileobjects[self.monsterRange[arg_218_1][1]]:isTileActive() then
			var_218_1 = self.monsterRange[arg_218_1][1]
		end

		table.remove(arg_218_2, #arg_218_2)
	elseif self.objectRange[arg_218_1] then
		if self.tileobjects[self.objectRange[arg_218_1]]:isTileActive() then
			if self.tileobjects[self.objectRange[arg_218_1]].tileInfo.is_touch ~= 0 then
				var_218_1 = self.objectRange[arg_218_1]
			end

			if not self.tileobjects[self.objectRange[arg_218_1]]:isTileCanPass() then
				table.remove(arg_218_2, #arg_218_2)
			end
		end
	else
		var_218_0 = var_218_3
	end

	for iter_218_0, iter_218_1 in ipairs(arg_218_2) do
		if iter_218_0 == #arg_218_2 then
			var_218_0 = iter_218_1
		end

		if self.objectRange[iter_218_1] then
			if self.tileobjects[self.objectRange[iter_218_1]] and self.tileobjects[self.objectRange[iter_218_1]].tileInfo.is_touch == 2 then
				var_218_1 = self.objectRange[iter_218_1]
				var_218_0 = iter_218_1

				break
			end
		end
	end

	for iter_218_2, iter_218_3 in ipairs(arg_218_2) do
		var_218_2[iter_218_2] = iter_218_3

		if iter_218_3 == var_218_0 then
			break
		end
	end

	if next(var_218_2) ~= nil then
		local var_218_4, var_218_5 = self:checkIsBound(var_218_0)

		if var_218_4 then
			if self:checkBoundIsLock(var_218_5) then
				table.remove(var_218_2, #var_218_2)
			end

			if not self.root.touchLock then
				self:moveSelectedFrame(var_218_2, var_218_5, nil)
			end
		elseif not self.root.touchLock then
			self:moveSelectedFrame(var_218_2, nil, function()
				if var_218_1 then
					self:triggerEvent(var_218_1)
				else
					var_0_37:saveRogue()
				end
			end)
		end
	elseif var_218_1 then
		self:stopActionByTag(self.actionTag)
		self:playAni("idle")
		self:triggerEvent(var_218_1)
	end
end

function RogueRoom:getFinialPath(arg_220_1, arg_220_2)
	local var_220_0
	local var_220_2 = {}

	if not arg_220_2 then
		global_ShowBlockWords(L_EXPLOREMAP_ROOM.Room_state[3])

		return
	end

	local var_220_3 = arg_220_2[#arg_220_2]

	if self.monsterRange[arg_220_1] then
		if self.tileobjects[self.monsterRange[arg_220_1][1]]:isTileActive() then
			-- block empty
		end

		table.remove(arg_220_2, #arg_220_2)
	elseif self.objectRange[arg_220_1] then
		if self.tileobjects[self.objectRange[arg_220_1]]:isTileActive() then
			if not self.tileobjects[self.objectRange[arg_220_1]]:isTileCanPass() then
				table.remove(arg_220_2, #arg_220_2)
			end
		end
	else
		var_220_0 = var_220_3
	end

	for iter_220_0, iter_220_1 in ipairs(arg_220_2) do
		if iter_220_0 == #arg_220_2 then
			var_220_0 = iter_220_1
		end

		if self.objectRange[iter_220_1] then
			if self.tileobjects[self.objectRange[iter_220_1]] and self.tileobjects[self.objectRange[iter_220_1]].tileInfo.is_touch == 2 then
				var_220_0 = iter_220_1

				break
			end
		end
	end

	for iter_220_2, iter_220_3 in ipairs(arg_220_2) do
		var_220_2[iter_220_2] = iter_220_3

		if iter_220_3 == var_220_0 then
			break
		end
	end

	return var_220_2
end

function RogueRoom:moveSelectedFrame(arg_221_1, arg_221_2, arg_221_3)
	self.curPosIndex = self.curMapConfig.curPosIndex
	self.actionTag = 111

	self:stopActionByTag(self.actionTag)

	local function var_221_2(arg_222_0, arg_222_1)
		print(string.format("moveSelectedFrame_check_log: line:%d, curIndex:%d, targetIndex:%d", 4217, arg_222_0 or -999, arg_222_1 or -999))

		if math.abs(arg_222_0 - arg_222_1) == 1 then
			return "x"
		elseif math.abs(arg_222_0 - arg_222_1) == self.room_width_num then
			return "y"
		else
			print(arg_222_0, arg_222_1, arg_222_0 - arg_222_1)
		end
	end

	local function var_221_3()
		local var_223_0, var_223_1 = self:checkBoundIsLock(arg_221_2)

		if var_223_0 then
			self:playAni("idle")
			self:popTalkSp(L_EXPLOREMAP_ROOM.TalkSp)
			self:isTriggerAim(var_223_1.tileid)

			return
		end

		self.root.touchLock = true

		local var_223_2 = self.curCoordinate.x
		local var_223_3 = self.curCoordinate.y
		local var_223_4
		local var_223_5

		if arg_221_2 == var_0_42 then
			var_223_5 = self.curCoordinate.y + var_0_70 / 2
			var_223_4 = self.curCoordinate.x
		elseif arg_221_2 == var_0_44 then
			var_223_5 = self.curCoordinate.y - var_0_70 / 2
			var_223_4 = self.curCoordinate.x
		elseif arg_221_2 == var_0_45 then
			var_223_5 = self.curCoordinate.y
			var_223_4 = self.curCoordinate.x - var_0_70 / 2
		elseif arg_221_2 == var_0_43 then
			var_223_5 = self.curCoordinate.y
			var_223_4 = self.curCoordinate.x + var_0_70 / 2
		end

		local var_223_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			var_223_2, var_223_3 = self.tag:getPositionX(), self.tag:getPositionY()

			if arg_221_2 == var_0_42 or arg_221_2 == var_0_44 then
				if var_223_3 ~= var_223_5 then
					print(string.format("moveSelectedFrame_check_log: line:%d, target_y:%d, cur_y:%d", 4253, var_223_5 or -999, var_223_3 or -999))

					var_223_3 = var_223_3 + (var_223_5 - var_223_3) / math.abs(var_223_5 - var_223_3) * (math.abs(var_223_5 - var_223_3) < 0.016666666666666666 * self.SPEED and math.abs(var_223_5 - var_223_3) or 0.016666666666666666 * self.SPEED)
				else
					var_0_37:goto_next_room(arg_221_2)
					self.root:switchRoom(arg_221_2)
					self:stopActionByTag(self.actionTag)
					var_0_37:saveRogue()

					return
				end
			elseif arg_221_2 == var_0_45 or arg_221_2 == var_0_43 then
				if var_223_2 ~= var_223_4 then
					local var_224_1

					print(string.format("moveSelectedFrame_check_log: line:%d, target_x:%d, cur_x:%d", 4270, var_223_4 or -999, var_223_2 or -999))

					var_224_1 = math.abs(var_223_4 - var_223_2) < 0.016666666666666666 * self.SPEED and math.abs(var_223_4 - var_223_2) or 0.016666666666666666 * self.SPEED

					local var_224_2 = (var_223_4 - var_223_2) / math.abs(var_223_4 - var_223_2)

					var_223_2 = var_223_2 + var_224_2 * var_224_1

					if var_224_2 ~= self.tag.dir then
						self.tag:setScale(var_224_2 * math.abs(self.tag.scale), math.abs(self.tag.scale))
					end
				else
					var_0_37:goto_next_room(arg_221_2)
					self.root:switchRoom(arg_221_2)
					self:stopActionByTag(self.actionTag)
					var_0_37:saveRogue()

					return
				end
			end

			self.tag:setPosition(var_223_2, var_223_3)
		end)))

		var_223_6:setTag(self.SPEED)
		self:runAction(var_223_6)
		self:playAni("run")
	end

	if next(arg_221_1) == nil and arg_221_2 then
		var_221_3()

		return
	end

	local var_221_4 = var_221_2(self.curPosIndex, arg_221_1[1])
	local var_221_5 = 1
	local var_221_6 = cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		local var_225_9000
		local var_225_0 = arg_221_1[var_221_5]
		local var_225_1 = self:transform_index_pos_coordinate(arg_221_1[var_221_5], "index")
		local var_225_3 = var_225_1.order_y
		local var_225_4 = var_225_1.x + var_0_70 / 2
		local var_225_5 = var_225_1.y + var_0_70 / 2
		local var_225_6 = self.tag:getPositionX()
		local var_225_7 = self.tag:getPositionY()

		self:checkPathObject(arg_221_1[var_221_5])
		print(string.format("moveSelectedFrame_check_log: line:%d, target_x:%d, target_y:%d", 4312, var_225_4 or -999, var_225_5 or -999))

		if cc.rectContainsPoint(cc.rect(var_225_4 - 50, var_225_5 - 50, 100, 100), cc.p(var_225_6, var_225_7)) and var_225_0 ~= self.curPosIndex then
			self.prePosIndex = self.curPosIndex
			self.preEnv = self.curMapEnv
			self.curMapConfig.curPosIndex = var_225_0

			self:updateCurPosInfo()
			self:playChangeEnvAni()

			if self:updateRouteWithEnv() then
				return
			end

			if self.curMapConfig.curPosIndex == arg_221_1[#arg_221_1] and arg_221_3 then
				arg_221_3()
			end
		end

		if var_221_4 and var_221_4 == "x" or not var_221_4 then
			if var_221_5 == #arg_221_1 then
				if var_225_6 == var_225_4 and var_225_7 == var_225_5 then
					self:stopActionByTag(self.actionTag)

					if arg_221_2 then
						var_221_3()
					else
						self:playAni("idle")
					end

					return
				elseif var_225_6 ~= var_225_4 then
					local var_225_8 = math.abs(var_225_4 - var_225_6) < 0.016666666666666666 * self.SPEED and math.abs(var_225_4 - var_225_6) or 0.016666666666666666 * self.SPEED
					local var_225_9 = (var_225_4 - var_225_6) / math.abs(var_225_4 - var_225_6)

					var_225_6 = var_225_6 + var_225_9 * var_225_8

					if var_225_9 ~= self.tag.dir then
						self.tag:setScale(var_225_9 * math.abs(self.tag.scale), math.abs(self.tag.scale))
					end
				elseif var_225_7 ~= var_225_5 then
					var_225_7 = var_225_7 + (var_225_5 - var_225_7) / math.abs(var_225_5 - var_225_7) * (math.abs(var_225_5 - var_225_7) < 0.016666666666666666 * self.SPEED and math.abs(var_225_5 - var_225_7) or 0.016666666666666666 * self.SPEED)
				end
			elseif var_225_6 == var_225_4 and self.curPosIndex == var_225_0 then
				var_221_5 = var_221_5 + 1
				var_221_4 = var_221_2(var_0_37.curMapConfig.curPosIndex, arg_221_1[var_221_5])
			elseif var_225_6 ~= var_225_4 then
				local var_225_11 = math.abs(var_225_4 - var_225_6) < 0.016666666666666666 * self.SPEED and math.abs(var_225_4 - var_225_6) or 0.016666666666666666 * self.SPEED
				local var_225_12 = (var_225_4 - var_225_6) / math.abs(var_225_4 - var_225_6)

				var_225_6 = var_225_6 + var_225_12 * var_225_11

				if var_225_12 ~= self.tag.dir then
					self.tag:setScale(var_225_12 * math.abs(self.tag.scale), math.abs(self.tag.scale))
				end
			elseif var_225_7 ~= var_225_5 then
				var_225_7 = var_225_7 + (var_225_5 - var_225_7) / math.abs(var_225_5 - var_225_7) * (math.abs(var_225_5 - var_225_7) < 0.016666666666666666 * self.SPEED and math.abs(var_225_5 - var_225_7) or 0.016666666666666666 * self.SPEED)
			end
		elseif var_221_4 and var_221_4 == "y" then
			if var_221_5 == #arg_221_1 then
				if var_225_6 == var_225_4 and var_225_7 == var_225_5 then
					self:stopActionByTag(self.actionTag)

					if arg_221_2 then
						var_221_3()
					else
						self:playAni("idle")
					end

					return
				elseif var_225_7 ~= var_225_5 then
					var_225_7 = var_225_7 + (var_225_5 - var_225_7) / math.abs(var_225_5 - var_225_7) * (math.abs(var_225_5 - var_225_7) < 0.016666666666666666 * self.SPEED and math.abs(var_225_5 - var_225_7) or 0.016666666666666666 * self.SPEED)
				elseif var_225_6 ~= var_225_4 then
					local var_225_15 = math.abs(var_225_4 - var_225_6) < 0.016666666666666666 * self.SPEED and math.abs(var_225_4 - var_225_6) or 0.016666666666666666 * self.SPEED
					local var_225_16 = (var_225_4 - var_225_6) / math.abs(var_225_4 - var_225_6)

					var_225_6 = var_225_6 + var_225_16 * var_225_15

					if var_225_16 ~= self.tag.dir then
						self.tag:setScale(var_225_16 * math.abs(self.tag.scale), math.abs(self.tag.scale))
					end
				end
			elseif var_225_7 == var_225_5 and self.curPosIndex == var_225_0 then
				var_221_5 = var_221_5 + 1
				var_221_4 = var_221_2(var_0_37.curMapConfig.curPosIndex, arg_221_1[var_221_5])
			elseif var_225_7 ~= var_225_5 then
				var_225_7 = var_225_7 + (var_225_5 - var_225_7) / math.abs(var_225_5 - var_225_7) * (math.abs(var_225_5 - var_225_7) < 0.016666666666666666 * self.SPEED and math.abs(var_225_5 - var_225_7) or 0.016666666666666666 * self.SPEED)
			elseif var_225_6 ~= var_225_4 then
				local var_225_18 = math.abs(var_225_4 - var_225_6) < 0.016666666666666666 * self.SPEED and math.abs(var_225_4 - var_225_6) or 0.016666666666666666 * self.SPEED
				local var_225_19 = (var_225_4 - var_225_6) / math.abs(var_225_4 - var_225_6)

				var_225_6 = var_225_6 + var_225_19 * var_225_18

				if var_225_19 ~= self.tag.dir then
					self.tag:setScale(var_225_19 * math.abs(self.tag.scale), math.abs(self.tag.scale))
				end
			end
		end

		self.tag:setPosition(var_225_6, var_225_7)

		if self.mask then
			self.mask:setPosition((self:convertToNodeSpace(cc.p(GameDisplay.cx, GameDisplay.cy))))

			local var_225_20 = self:convertToWorldSpace(cc.p(var_225_6, var_225_7 + 50))

			self.mask:focus(var_225_20.x, var_225_20.y)
		end

		self.tag:setLocalZOrder((self.room_height_num - var_225_3 + 1) * 2)

		if var_0_63 == 1 then
			local var_225_21 = self:getContentSize().width * var_0_69 - self.root.mapView:getContentSize().width
			local var_225_22 = self:getContentSize().height * var_0_69 - self.root.mapView:getContentSize().height
			local var_225_23 = var_225_6 * var_0_69 - self.root.mapView:getContentSize().width / 2
			local var_225_24 = var_225_7 * var_0_69 - self.root.mapView:getContentSize().height / 2

			if var_225_21 < var_225_23 then
				var_225_23 = var_225_21
			elseif var_225_23 < 0 then
				var_225_23 = 0
			end

			if var_225_22 < var_225_24 then
				var_225_24 = var_225_22
			elseif var_225_24 < -100 then
				var_225_24 = -100
			end

			self.root.mapView:getInnerContainer():setPosition(-var_225_23, -var_225_24)
		elseif var_0_63 == 2 then
			local var_225_25 = 200
			local var_225_26 = 600
			local var_225_27 = self.root.mapView:getInnerContainer():getPositionY() + var_225_7 * var_0_69
			local var_225_28, var_225_29 = self.root.mapView:getInnerContainer():getPosition()

			if self.root.mapView:getInnerContainer():getPositionX() + var_225_6 * var_0_69 < 160 then
				var_225_28 = var_225_28 + 160 - (self.root.mapView:getInnerContainer():getPositionX() + var_225_6 * var_0_69)
			elseif 480 < self.root.mapView:getInnerContainer():getPositionX() + var_225_6 * var_0_69 then
				var_225_28 = var_225_28 - (self.root.mapView:getInnerContainer():getPositionX() + var_225_6 * var_0_69) + 480
			end

			if var_225_27 < var_225_25 then
				var_225_29 = var_225_29 + var_225_25 - var_225_27
			else
				local var_225_30

				if var_225_26 < var_225_27 then
					var_225_29 = var_225_29 - var_225_27 + var_225_26
					var_225_30 = self:getContentSize().height * var_0_69 - self.root.mapView:getContentSize().height
				end
			end

			if self:getContentSize().width < -var_225_28 then
				var_225_28 = -(var_225_9000 * var_0_69 - self.root.mapView:getContentSize().width)
			elseif -var_225_28 < 0 then
				var_225_28 = 0
			end

			if var_225_30 < -var_225_29 then
				var_225_29 = -var_225_30
			elseif -var_225_29 < 0 then
				var_225_29 = 0
			end

			self.root.mapView:getInnerContainer():setPosition(var_225_28, var_225_29)
		end
	end)))

	var_221_6:setTag(self.actionTag)
	self:runAction(var_221_6)
	self:playAni((self.actionMove or nil) and (self.actionMove or "run"))
	self:npcMove(arg_221_1)
end

function RogueRoom:npcMove(arg_226_1)
	local var_226_0 = global_deepCopy(arg_226_1)

	table.insert(var_226_0, 1, self.curMapConfig.curPosIndex)
	table.remove(var_226_0, #var_226_0)

	if self.root.followQueue and next(self.root.followQueue) ~= nil then
		for iter_226_0 = 1, #self.root.followQueue do
			self.root.followQueue[iter_226_0]:npcMove(var_226_0)

			local var_226_2 = global_deepCopy(var_226_0)

			table.insert(var_226_2, 1, self.root.followQueue[iter_226_0].curPosIndexNpc)
			table.remove(var_226_2, #var_226_2)

			var_226_0 = var_226_2
		end
	end
end

function RogueRoom:triggerEvent(arg_227_1)
	print("??????triggerEvent", arg_227_1, self.usedTile[arg_227_1], self.tileobjects[arg_227_1])

	if not self.usedTile[arg_227_1] then
		return
	end

	if not self.tileobjects[arg_227_1] and self.tileobjects[arg_227_1].tileid then
		return
	end

	if self.root.touchLock then
		return
	end

	self.root.touchLock = true

	self:isTriggerAim(self.tileobjects[arg_227_1].tileid)
	self.tileobjects[arg_227_1]:triggerEvent(function(arg_228_0)
		local var_228_0 = arg_228_0.msg
		local var_228_1 = arg_228_0.eventconfig

		if arg_228_0.msg.result > 0 then
			self:checkisShowMainAim(arg_227_1, var_228_1)
			self.root.smallMap:updateByObject(arg_228_0.tileInfo.id)
			self.root:updateExploreProgress(arg_228_0.tileInfo.id)
			self.root.aimLayout:updateAim(arg_228_0.tileInfo.id)

			if arg_228_0.msg.config and arg_228_0.msg.config.HP then
				self.root.bloodbg.updateBloodUI()

				if arg_228_0.msg.config.add_hp > 0 then
					self:playAni("hitdown")
					self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
						self.role_ani_lock = false

						self:playAni("idle")

						if var_228_1.result_des then
							LayerManager:pushInLayer("PopDoLayer", {
								labels = {
									titleImage = "title_explore_msg.png",
									title = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.title,
									des = var_228_1.result_des or L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.des,
									button = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.button
								}
							})
						else
							global_ShowBlockWords(string.format(L_EXPLOREMAP_TRIGGER_EVENT.Team_Energe_Minus, var_228_0.config.add_hp))
						end
					end)))

					self.role_ani_lock = true
				elseif arg_228_0.msg.config.add_hp < 0 then
					self:playAni("win", function()
						self.role_ani_lock = false

						self:playAni("idle")

						if var_228_1.result_des then
							LayerManager:pushInLayer("PopDoLayer", {
								labels = {
									titleImage = "title_explore_msg.png",
									title = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.title,
									des = var_228_1.result_des or L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.des,
									button = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.button
								}
							})
						else
							global_ShowBlockWords(string.format(L_EXPLOREMAP_TRIGGER_EVENT.Team_Energe_Plus, var_228_0.config.add_hp * -1))
						end
					end)

					self.role_ani_lock = true
				end
			end

			if arg_228_0.tileInfo.class == TILE_TYPE.POKEMON then
				self.root:playUIAnimation("BZchenggong")
			elseif var_228_1.result_type == EVENT_TYPE.CHANGE_DRESS then
				self:updateCurGirlSkin(var_228_1.result_param)
			elseif var_228_1.result_type == EVENT_TYPE.PORTAL then
				if self.root.jumpEffect then
					local var_228_2 = self.root.jumpEffect.jump_effect or "chansongh"

					if var_228_2 then
						local var_228_3 = L2Skeleton:create("spine/explore/" .. var_228_2 .. ".json", "spine/explore/" .. var_228_2 .. ".atlas")

						var_228_3:setScaleX(1.2)
						var_228_3:setScaleY(1.2)
						var_228_3:setName("jumpRoomEffect")
						var_228_3:refreshSkeleton()
						var_228_3:play("animation", false)
						var_228_3:registerListener(SP_ANIMATION_COMPLETE, function(arg_231_0)
							var_228_3:runAction(cc.RemoveSelf:create())

							local var_231_0, var_231_1 = var_228_1.result_param:match("(%d+)-(%d+)")
							local var_231_2 = tonumber(var_231_0)

							var_0_37:jumpto_other_room(var_231_2, (tonumber(var_231_1)))
							self.root:jumpRoom(var_231_2)
						end)
						var_228_3:setPosition(cc.p(self.tag:getContentSize().width / 2, self.tag:getContentSize().height / 2))
						self.tag:addChild(var_228_3, 99)
						var_228_3:setGlobalZOrder(-1)

						goto label_228_0
					end
				end

				local var_228_4, var_228_5 = var_228_1.result_param:match("(%d+)-(%d+)")
				local var_228_6 = tonumber(var_228_4)

				var_0_37:jumpto_other_room(var_228_6, (tonumber(var_228_5)))
				self.root:jumpRoom(var_228_6)
			elseif arg_228_0.tileInfo.class == TILE_TYPE.NPCFOLLOW then
				self.root.followQueue[#self.root.followQueue + 1] = self.tileobjects[arg_227_1]
				self.root.followQueue[#self.root.followQueue].index = #self.root.followQueue

				self.root.followQueue[#self.root.followQueue]:retain()

				if not arg_228_0.tileInfo.is_not_fight then
					for iter_228_0 = 1, 4 do
						if self.root.curMapConfig.array[iter_228_0] then
							if not self.root.curMapConfig.array[iter_228_0].fight_girl then
								self.root.curMapConfig.array[iter_228_0] = {
									pos = #self.root.curMapConfig.array + 1,
									fight_girl = npc_fightconfig_data[tonumber(var_228_1.result_param)].servantid,
									npcid = npc_fightconfig_data[tonumber(var_228_1.result_param)].soulid
								}

								break
							end
						end
					end
				end

				global_ShowBlockWords(var_228_1.result_des)
				self:checkNpcLock(arg_228_0.tileInfo.id)
			elseif arg_228_0.tileInfo.class == TILE_TYPE.CRACKLE then
				self.root.touchLock = false
			end

			::label_228_0::

			if var_228_1.result_type == EVENT_TYPE.CHANGE_ROLEMODEL then
				self:changeMainRoleMode(var_228_1.result_param)
			elseif var_228_1.result_type == EVENT_TYPE.UPDATE_ROOM_COLOR then
				self:updateRoomColorEffect(tonumber(var_228_1.result_param))
			end
		elseif arg_228_0.msg.result == 0 then
			if var_228_1.result_type == EVENT_TYPE.FIGHT then
				for iter_228_1, iter_228_2 in pairs(arg_228_0.msg.cur_array) do
					iter_228_2.classtype = 1
				end

				require("view.Layer.LevelResultLayer")

				local function var_228_7()
					self.root:failExit()
				end

				LevelResultLayer:create({
					showtype = 7,
					curarray = arg_228_0.msg.cur_array,
					surecallback = var_228_7,
					cancelcallback = var_228_7
				})
			else
				self.root:failExit()
			end
		elseif arg_228_0.msg.result == -5 then
			self.root.curRoomMap:stopAllActions()
			LayerManager:switchShowLayer(self.root.returnUiLayer)
		end

		if var_228_1.result_type ~= EVENT_TYPE.PORTAL then
			self.root.touchLock = false
		elseif arg_228_0.msg.result < 0 then
			self.root.touchLock = false
		end
	end)
end

function RogueRoom:popSwitchRole()
	return
end

function RogueRoom:isTriggerAim(arg_234_1)
	if self.aimTypeTbl[arg_234_1] then
		self.root.aimLayout:triggerAim(arg_234_1)
	end
end

function RogueRoom:gainItemToCache(arg_235_1)
	local var_235_0 = cc.size(var_0_37:getTileSize(self.usedTile[arg_235_1.object_idx].tileid))
	local var_235_1 = self:transform_index_pos_coordinate(self.usedTile[arg_235_1.object_idx].order, "index")
	local var_235_2, var_235_3 = self:transform_map_camera(cc.p(var_235_1.x + var_235_0.width / 2, var_235_1.y + var_235_0.height / 2), "map_to_camera")

	for iter_235_0, iter_235_1 in pairs(arg_235_1.items) do
		local var_235_5 = cc.Node:create()

		var_235_5:setVisible(false)
		var_235_5:setPosition(var_235_2, var_235_3)

		var_235_5.order = #self.root.gainItemPanel.sp_tbl

		self.root.gainItemPanel:addChild(var_235_5)
		table.insert(self.root.gainItemPanel.sp_tbl, var_235_5)

		local var_235_6 = item_data[iter_235_1.itemid]

		item = item_data[iter_235_1.itemid].bag_item_type == kITEM_COMPONENT and component_manager:create_component_icon(iter_235_1.itemid) or var_235_6.bag_item_type == kITEM_HORCRUX and cc.Sprite:create("role1/" .. model_data[var_235_6.model].cute_role .. ".png") or cc.Sprite:create("equipment/" .. var_235_6.image_id .. ".png")

		item:setScale(168 / item:getContentSize().width * 0.4)
		item:setName("item")
		var_235_5:addChild(item, 2)

		local var_235_7

		if config._DEBUG then
			var_235_7 = cc.Sprite:create(var_0_56[var_235_6.equip_quality]) or cc.Sprite:createWithSpriteFrameName(var_0_56[var_235_6.equip_quality])
		end

		var_235_7:setScale(0.4)
		var_235_7:setName("light")
		var_235_5:addChild(var_235_7, 1)
		var_235_5:runAction(cc.Sequence:create(cc.DelayTime:create(var_235_5.order * 7 / 6), cc.Show:create(), cc.MoveTo:create(0.3333333333333333, cc.p(320, 600)), cc.DelayTime:create(0.8333333333333334), cc.MoveTo:create(0.3333333333333333, cc.p(596, 50)), cc.CallFunc:create(function()
			if var_0_36 then
				table.remove(var_0_36.gainItemPanel.sp_tbl, 1)
			end
		end), cc.DelayTime:create(0.16666666666666666), cc.RemoveSelf:create()))
		var_235_7:runAction(cc.Sequence:create(cc.DelayTime:create(var_235_5.order * 7 / 6), cc.ScaleTo:create(0.3333333333333333, 1), cc.RotateTo:create(0.16666666666666666, 44), cc.RotateTo:create(0.6666666666666666, 164), cc.ScaleTo:create(0.3333333333333333, 0.6), cc.FadeOut:create(0.16666666666666666)))
		item:runAction(cc.Sequence:create(cc.DelayTime:create(var_235_5.order * 7 / 6), cc.ScaleTo:create(0.3333333333333333, 168 / item:getContentSize().width), cc.DelayTime:create(0.8333333333333334), cc.ScaleTo:create(0.3333333333333333, 168 / item:getContentSize().width * 0.4), cc.FadeOut:create(0.16666666666666666)))
	end
end

function RogueRoom:updateCurGirlSkin(arg_237_1)
	if not arg_237_1 then
		return
	end

	for iter_237_0 = 1, 4 do
		if self.curMapConfig.array[iter_237_0] and self.curMapConfig.array[iter_237_0].fight_girl then
			if self.curMapConfig.array[iter_237_0].fight_girl then
				if major_factor_data[servant_data[self.curMapConfig.array[iter_237_0].fight_girl].major][arg_237_1] then
					self.curMapConfig.array[iter_237_0].servantskin = major_factor_data[servant_data[self.curMapConfig.array[iter_237_0].fight_girl].major][arg_237_1]

					if self.tag.arrayorder == iter_237_0 then
						self:updateSelectedFrame(self.tag.arrayorder)
					end
				end
			end
		end
	end
end

function RogueRoom:changeMainRoleMode(arg_238_1)
	if not arg_238_1 then
		return
	end

	local var_238_0 = arg_238_1

	if not model_data[arg_238_1].spine_model then
		print("error:modelid is not have spine  ", var_238_0)

		return
	end

	local var_238_1

	if model_data[var_238_0].clothes_model then
		var_238_1 = CLOTHES_SPINE_PATH .. model_data[var_238_0].clothes_model .. ".atlas" or nil
	end

	local var_238_2 = var_0_68 * (model_data[var_238_0].modelscale > 1.3 and 1.3 or model_data[var_238_0].modelscale)

	self.tag:updateSpine(ROLE_SPINE_PATH .. model_data[arg_238_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_238_1].spine_model .. ".atlas", var_238_1)
	self.tag:setScale(var_238_2, var_238_2)
	self.tag:setContentSize((cc.size(model_data[var_238_0].modelweight, model_data[var_238_0].modelheight)))
	self.tag:playAni(nil, self.tag.aniName, true)

	self.tag.modelid = var_238_0
	self.curMapConfig.change_role_modelid = var_238_0
end

function RogueRoom:checkisShowMainAim(arg_239_1, arg_239_2)
	for iter_239_0, iter_239_1 in pairs(self.aimTypeTbl) do
		if iter_239_1.trigger_objectidx == arg_239_1 and (not iter_239_1.trigger_condition or iter_239_1.trigger_condition and arg_239_2 and iter_239_1.trigger_condition == arg_239_2.aim_condition) then
			self.aimTypeTbl[iter_239_0].is_show = true

			self.root.aimLayout:getChildByName("aim" .. iter_239_1.tileid):show_main_aim_by_object(self.aimTypeTbl[iter_239_1.tileid])
			self.root.smallMap:updateAll()

			break
		end
	end
end

function RogueRoom:checkPuzzle(arg_240_1)
	if not var_0_35[arg_240_1].puzzleids then
		return
	end

	local var_240_0 = {}

	for iter_240_0, iter_240_1 in pairs(self.usedTilesConfig) do
		for iter_240_2, iter_240_3 in pairs(iter_240_1) do
			if var_0_35[iter_240_3.tileid].puzzleids then
				for iter_240_4 in var_0_35[iter_240_3.tileid].puzzleids:gmatch("([^,]+)") do
					var_240_0[iter_240_4] = var_240_0[iter_240_4] and var_240_0[iter_240_4] + 1 or 1
				end
			end
		end
	end

	for iter_240_5 = #self.puzzleConfig, 1, -1 do
		local var_240_1

		if self.puzzleConfig[iter_240_5].is_and then
			var_240_1 = true

			for iter_240_6, iter_240_7 in pairs(self.puzzleConfig[iter_240_5].condition) do
				if (var_240_0[iter_240_7.puzzleid] or 0) < iter_240_7.puzzlenum then
					var_240_1 = false

					break
				end
			end
		else
			var_240_1 = false

			for iter_240_8, iter_240_9 in pairs(self.puzzleConfig[iter_240_5].condition) do
				if (var_240_0[iter_240_9.puzzleid] or 0) >= iter_240_9.puzzlenum then
					var_240_1 = true

					break
				end
			end
		end

		if var_240_1 then
			for iter_240_10, iter_240_11 in pairs(self.puzzleConfig[iter_240_5].controller) do
				local var_240_4 = iter_240_11.roomorder
				local var_240_5 = iter_240_11.controller_idx

				if iter_240_11.roomorder == self.curRoomOrder then
					if self.tileobjects[var_240_5] then
						self.tileobjects[var_240_5]:updateState(true)
					end
				else
					var_0_37:updateObjectState(var_240_4, var_240_5)
				end

				var_0_37:trigger_event({
					room_order = var_240_4,
					object_idx = var_240_5
				}, function(arg_241_0)
					print("???checkPuzzle trigger_event???", var_240_4, var_240_5)
				end)
			end

			local var_240_6 = self.puzzleConfig[iter_240_5].controller_des or L_EXPLORE_CONTROLLER_OPEN

			if var_240_6 ~= "kong" then
				self:popTalkSp(var_240_6)
			end

			table.remove(self.puzzleConfig, iter_240_5)
		end
	end
end

function RogueRoom:checkPathObject(arg_242_1)
	if self.objectRange[arg_242_1] then
		if self.tileobjects[self.objectRange[arg_242_1]] and self.tileobjects[self.objectRange[arg_242_1]].tileInfo.is_touch == 3 and self.tileobjects[self.objectRange[arg_242_1]]:checkIsCanTrigger() then
			(function(arg_243_0)
				if not self.usedTile[arg_243_0] then
					return
				end

				if not self.tileobjects[arg_243_0] and self.tileobjects[arg_243_0].tileid then
					return
				end

				self:isTriggerAim(self.tileobjects[arg_243_0].tileid)
				self.tileobjects[arg_243_0]:triggerEvent(function(arg_244_0)
					local var_244_0 = arg_244_0.msg
					local var_244_1 = arg_244_0.eventconfig

					if arg_244_0.msg.result > 0 then
						self:checkisShowMainAim(arg_243_0, arg_244_0.eventconfig)
						self.root.smallMap:updateByObject(arg_244_0.tileInfo.id)
						self.root:updateExploreProgress(arg_244_0.tileInfo.id)
						self.root.aimLayout:updateAim(arg_244_0.tileInfo.id)

						if arg_244_0.msg.config and arg_244_0.msg.config.HP then
							self.root.bloodbg.updateBloodUI()

							if arg_244_0.msg.config.add_hp > 0 then
								self:playAni("hitdown")
								self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function()
									self.role_ani_lock = false

									self:playAni("idle")

									if var_244_1.result_des then
										LayerManager:pushInLayer("PopDoLayer", {
											labels = {
												titleImage = "title_explore_msg.png",
												title = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.title,
												des = var_244_1.result_des or L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.des,
												button = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.button
											}
										})
									else
										global_ShowBlockWords(string.format(L_EXPLOREMAP_TRIGGER_EVENT.Team_Energe_Minus, var_244_0.config.add_hp))
									end
								end)))

								self.role_ani_lock = true
							elseif arg_244_0.msg.config.add_hp < 0 then
								self:playAni("win", function()
									self.role_ani_lock = false

									self:playAni("idle")

									if var_244_1.result_des then
										LayerManager:pushInLayer("PopDoLayer", {
											labels = {
												titleImage = "title_explore_msg.png",
												title = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.title,
												des = var_244_1.result_des or L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.des,
												button = L_EXPLOREMAP_TRIGGER_EVENT.Popmsg_Label.button
											}
										})
									else
										global_ShowBlockWords(string.format(L_EXPLOREMAP_TRIGGER_EVENT.Team_Energe_Plus, var_244_0.config.add_hp * -1))
									end
								end)

								self.role_ani_lock = true
							end
						end

						if arg_244_0.tileInfo.class == TILE_TYPE.PATH_GOLD then
							-- block empty
						end
					elseif arg_244_0.msg.result == 0 then
						if arg_244_0.eventconfig.result_type == EVENT_TYPE.FIGHT then
							for iter_244_0, iter_244_1 in pairs(arg_244_0.msg.cur_array) do
								iter_244_1.classtype = 1
							end

							require("view.Layer.LevelResultLayer")

							local function var_244_2()
								self.root:failExit()
							end

							LevelResultLayer:create({
								showtype = 7,
								curarray = arg_244_0.msg.cur_array,
								surecallback = var_244_2,
								cancelcallback = var_244_2
							})
						else
							self.root:failExit()
						end
					elseif arg_244_0.msg.result == -5 then
						self.root.curRoomMap:stopAllActions()
						LayerManager:switchShowLayer(self.root.returnUiLayer)
					end

					self.tileobjects[arg_243_0].isCanTrigger = true
				end)
			end)(self.objectRange[arg_242_1])
		end
	end
end

function RogueRoom:switchSpace()
	if self.root.touchLock then
		return
	end

	self.root.touchLock = true

	local var_248_0

	if self.curRoomOrder <= 100 then
		var_248_0 = self.curRoomOrder + 100 or self.curRoomOrder - 100
	end

	self.curMapConfig.curSpaceType = -self.curMapConfig.curSpaceType

	var_0_37:jumpto_other_room(var_248_0, self.curPosIndex)
	self.root:jumpRoom(var_248_0)
end

function RogueRoom:checkNpcLock(arg_249_1)
	if not self.curMapConfig.npcLockConf then
		return
	end

	local var_249_0 = {
		space = function()
			self.root.mapUIPanel:getChildByName("spaceBnt"):setVisible(true)
		end,
		fire = function()
			return
		end,
		hole = function()
			if self.mask then
				self.mask:updteRange(cc.p(0.2, 0.25))
			end
		end
	}

	for iter_249_0, iter_249_1 in pairs(self.curMapConfig.npcLockConf) do
		if iter_249_1.npc_tileid == arg_249_1 then
			iter_249_1.is_have = true

			var_249_0[iter_249_0]()
		end
	end
end

function RogueRoom:createFollowNpcByServer()
	if not self.curMapConfig.serverFollowQueue then
		return
	end

	if next(self.curMapConfig.serverFollowQueue) == nil then
		return
	end

	for iter_253_0, iter_253_1 in ipairs(self.curMapConfig.serverFollowQueue) do
		self.root.followQueue[#self.root.followQueue + 1] = require("view.Sprite.rogue_explore.NpcfollowTile"):create({
			is_finished = 1,
			zOrder = 1,
			order = 1,
			tileInfo = var_0_35[iter_253_1.tileid],
			idx = iter_253_1.index,
			pos = cc.p(1, 1),
			parent = self,
			fullImage = var_0_32[self.curMapId].fullImage,
			size_num = cc.size(var_0_37:getTileSize(var_0_35[iter_253_1.tileid].id))
		})
		self.root.followQueue[#self.root.followQueue].index = #self.root.followQueue

		self.root.followQueue[#self.root.followQueue]:retain()
		self:checkNpcLock(iter_253_1.tileid)
	end

	self.curMapConfig.serverFollowQueue = {}
end
