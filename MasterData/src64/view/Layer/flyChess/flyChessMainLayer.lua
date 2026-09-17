flyChessMainLayer = class("flyChessMainLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local flyChessUtility = require("view.Layer.flyChess.flyChessUtility")
local time_check_manager = require("controller.time_check_manager")
local TempWidget = require("view.Sprite.TempWidget")

require("view.Layer.flyChess.flyChessMap")
require("view.Layer.flyChess.flyChessPlayer")

local battlefield_status_data = require("data.battlefield_status_data")
local photo_manager = require("controller.photo_manager")
local model_data = require("data.model_data")

local function var_0_10(arg_2_0)
	local var_2_0 = activity_manager:getActivityObj(arg_2_0).finishtime

	if not var_2_0 then
		return ""
	end

	local var_2_1 = global_get_time_by_date(var_2_0) - time_check_manager:getCurTime()

	if var_2_1 < 0 then
		return ""
	end

	local var_2_7 = math.floor(var_2_1 / 24 / 3600)
	local var_2_8 = math.floor((var_2_1 - var_2_7 * 24 * 3600) / 3600)
	local var_2_9 = math.floor((var_2_1 - var_2_7 * 24 * 3600 - var_2_8 * 3600) / 60)

	return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_2_7, var_2_8) or var_2_8 ~= 0 and string.format(L_TIME_TEXT[2], var_2_8, var_2_9) or string.format(L_TIME_TEXT[3], var_2_9)
end

local var_0_11 = 3
local var_0_12 = 9
local var_0_13 = {}

var_0_13[1] = false
var_0_13[2] = false
var_0_13[3] = true
var_0_13[4] = false
var_0_13[5] = false
var_0_13[6] = true
var_0_13[7] = true
var_0_13[8] = false
var_0_13[9] = true

local var_0_14 = {
	nil,
	function(arg_3_0)
		local var_3_0 = activity_manager:getFlychessAllInfo(arg_3_0.layer.activityId).map_infos[arg_3_0.pos]

		if var_3_0.score then
			global_ShowBlockWords((string.format("获得了%d点探索值~", var_3_0.score)))
		end
	end,
	function(arg_7_0)
		local var_7_0 = arg_7_0.layer

		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationMainLayer", {
			repeatChallenge = true,
			configcallback = function()
				activity_manager:initFlyChessFight(var_7_0.activityId)
			end
		})
	end,
	function(arg_4_0)
		local var_4_0 = activity_manager:getFlychessAllInfo(arg_4_0.layer.activityId).map_infos[arg_4_0.pos]

		if var_4_0.score then
			global_ShowBlockWords((string.format("获得了%d点探索值~", var_4_0.score)))
		end
	end,
	function(arg_6_0)
		global_ShowBlockWords("补给站！获得一次免费投掷！")
	end,
	function(arg_9_0)
		local var_9_0 = arg_9_0.layer

		LayerManager:pushInLayer("flyChessDiceSelectLayer", {
			activityId = arg_9_0.layer.activityId,
			eventType = arg_9_0.cur_eventType,
			callback = function(arg_10_0)
				activity_manager:user_handle_flychess_events(var_9_0.activityId, {
					eventType = arg_9_0.cur_eventType,
					forward_num = arg_10_0
				})
			end
		})
	end,
	function(arg_11_0)
		local var_11_0 = arg_11_0.layer

		LayerManager:pushInLayer("flyChessDiceSelectLayer", {
			activityId = arg_11_0.layer.activityId,
			eventType = arg_11_0.cur_eventType,
			callback = function(arg_12_0)
				activity_manager:user_handle_flychess_events(var_11_0.activityId, {
					eventType = arg_11_0.cur_eventType,
					forward_num = arg_12_0
				})
			end
		})
	end,
	function(arg_5_0)
		local var_5_0 = activity_manager:getFlychessAllInfo(arg_5_0.layer.activityId).map_infos[arg_5_0.pos]

		global_ShowBlockWords((var_5_0.score or nil) and string.format("发现了一条线索,获得了%d点探索值！", var_5_0.score))
	end,
	function(arg_13_0)
		local var_13_0 = arg_13_0.layer

		LayerManager:pushInLayer("flyChessBuildSelectLayer", {
			activityId = arg_13_0.layer.activityId,
			eventType = arg_13_0.cur_eventType,
			callback = function(arg_14_0)
				activity_manager:user_handle_flychess_events(var_13_0.activityId, {
					eventType = arg_13_0.cur_eventType,
					build_grid_type = arg_14_0
				})
			end
		})
	end
}

function flyChessMainLayer.create(arg_15_0, arg_15_1)
	local var_15_0 = flyChessMainLayer.new()

	var_15_0:init(arg_15_1)

	return var_15_0
end

function flyChessMainLayer:init(arg_16_1)
	self.activityId = arg_16_1.activityId
	self.respath = "activity_flyChess_" .. self.activityId
	self.layerName = "flyChessMainLayer_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.respath
	})
	self:initUI()
	self:initComponent(arg_16_1)
	self:registerScriptHandler(function(arg_17_0)
		if arg_17_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.respath
			})
		end
	end)
	self:addTouchEvent()
	self:registerEventListener()
	self:initData()
end

function flyChessMainLayer:registerEventListener()
	local function var_18_0()
		self._dice_num_label:setString((item_manager:getItemNumber((activity_manager:getFlyChessTicket(self.activityId)))))
	end

	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_20_0)
		var_18_0()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLYCHESS_DATA_UPDATE, function(arg_21_0)
		self:choose_btn_Test(arg_21_0)
		self:updateUI(arg_21_0)
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLYCHESS_ALLMAP_UPDATE, function(arg_22_0)
		if arg_22_0.pos then
			self.player:setMapPos(arg_22_0.pos)
		end

		self.map:updateAllGrids(arg_22_0.map_infos)
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLYCHESS_DICE_RANDOM, function(arg_23_0)
		if var_0_14[arg_23_0.cur_eventType] then
			arg_23_0.cb = var_0_14[arg_23_0.cur_eventType]
			arg_23_0.layer = self
		end

		self:normalDiceAnima(arg_23_0)
		var_18_0()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLYCHESS_DICE_ANY, function(arg_24_0)
		if var_0_14[arg_24_0.cur_eventType] then
			arg_24_0.cb = var_0_14[arg_24_0.cur_eventType]
			arg_24_0.layer = self
		end

		self:anyDiceAnima(arg_24_0)
		var_18_0()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FLYCHESS_BOSSFIGHT_SUCESS, function(arg_25_0)
		self:showBossFightSuccess(arg_25_0)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_26_0)
		var_18_0()
	end), self)
end

function flyChessMainLayer:addTouchEvent()
	self._titleImg:_addEvent(function()
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "flychess_" .. self.activityId
		})
	end)

	local function var_27_0()
		local var_29_0 = {}

		var_29_0[1] = "1-" .. (activity_manager:getFlyChessShop(self.activityId) or self.activityId .. "06")

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_29_0,
			showType = var_29_0[1]
		})
	end

	local var_27_1 = self._diceBtn

	self._diceBtn:_addEvent(function()
		if not self:canThrow() then
			return
		end

		if not var_27_1:isBright() then
			return
		end

		var_27_1:setBright(false)

		if item_manager:getItemNumber((activity_manager:getFlyChessTicket(self.activityId))) + (activity_manager:getFlychessAllInfo(self.activityId).free_count or 0) < 1 then
			global_ShowBlockWords("骰子不足！")
			var_27_0()

			return
		end

		activity_manager:dice_goto_next(self.activityId, function()
			var_27_1:setBright(true)
		end)
	end)
	self._formationBtn:_addEvent(function()
		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationMainLayer", {
			repeatChallenge = true,
			configcallback = function()
				return
			end
		})
	end)
	self.paihang:_addEvent(function()
		LayerManager:pushInLayer("FlyChessRankListLayer", {
			activityId = self.activityId
		})
	end)
	self.shop_btn:_addEvent(function()
		var_27_0()
	end)
	self.task_btn:_addEvent(function()
		LayerManager:pushInLayer("flychessTaskLayer", {
			activityId = self.activityId
		})
	end)
	self._dice_num_btn:_addEvent(function()
		var_27_0()
	end)
	self.boss_fight:_addEvent(function()
		activity_manager:initFlyChessBossFight(self.activityId)
	end)
	self._backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._bossRewardBg:setTouchEnabled(true)
	self._bossRewardBg:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("flyChessLevelRewardLayer", {
			activityId = self.activityId
		})
	end)
end

function flyChessMainLayer:initUI()
	local var_41_0 = TempWidget:CreateTempLayout(self)

	var_41_0:_setBack()
	var_41_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_41_0
	self.rootLayer = ccui.ImageView:create(("mainScenebg/activity_flychess_bg/bg_" .. self.activityId) .. ".png")

	self._root:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPosition(0, -180 + GameDisplay.fix_y)

	local var_41_1 = TempWidget:CreateTempBtn(self.respath .. "/title.png", var_41_0)

	var_41_1:align(cc.p(0.5, 1), var_41_0:size().w / 2, var_41_0:size().h - GameDisplay.fix_y)

	self._titleImg = var_41_1

	TempWidget:CreateTempLabel(var_0_10(self.activityId), FONT_DES, 20, var_41_1):align(cc.p(0.5, 0.5), var_41_1:size().w / 2, 15)

	local var_41_2 = TempWidget:CreateTempBtn(self.respath .. "/back_btn.png", var_41_0)

	var_41_2:align(cc.p(0, 0.5), 20, 0)

	self._backBtn = var_41_2

	local var_41_3 = TempWidget:CreateTempBtn(self.respath .. "/dice_btn.png", var_41_0)

	var_41_3:align(cc.p(0.5, 0), 640 - var_41_3:size().w / 2 - 20, -33)
	var_41_3:setName("diceBtn")

	self._diceBtn = var_41_3

	local var_41_4 = TempWidget:CreateTempImg(self.respath .. "/dice_icon.png", var_41_3)

	var_41_4:align(cc.p(0.5, 0), var_41_3:size().w / 2 - 7, var_41_3:size().h / 2 - 36)
	var_41_4:setScale(0.6)

	local var_41_5 = TempWidget:CreateTempBtn(self.respath .. "/dice_num_btn.png", var_41_3)

	var_41_5:align(cc.p(0.5, 0), 10, 10)

	self._dice_num_btn = var_41_5

	local var_41_6 = TempWidget:CreateTempLabel("99", FONT_DES, 18, var_41_5)

	var_41_6:align(cc.p(0.5, 0.5), var_41_5:size().w / 2, var_41_5:size().h / 2)

	self._dice_num_label = var_41_6

	local var_41_7 = TempWidget:CreateTempBtn(self.respath .. "/formation_btn.png", var_41_0)

	var_41_7:align(cc.p(0.5, 0.5), 380, 10)

	self._formationBtn = var_41_7

	local var_41_8 = TempWidget:CreateTempImg(self.respath .. "/bossreward_bg.png", var_41_0)

	var_41_8:align(cc.p(0.5, 0.5), var_41_0:size().w / 2, 540)

	self._bossRewardBg = var_41_8

	TempWidget:CreateTempLabel("当前区域头目赏金：", FONT_DES, 22, var_41_8):align(cc.p(0.5, 1), var_41_8:size().w / 2, var_41_8:size().h - 70)

	local var_41_9 = TempWidget:CreateTempBtn(self.respath .. "/boss_fight.png", var_41_8)

	var_41_9:align(cc.p(0.5, 0), var_41_8:size().w / 2, 45)

	self.boss_fight = var_41_9

	local var_41_10 = ccui.ListView:create()

	var_41_10:setDirection(ccui.ScrollViewDir.horizontal)
	var_41_10:setContentSize(cc.size(290, 120))
	var_41_10:setPosition(cc.p(50, 125))
	var_41_8:addChild(var_41_10)
	var_41_10:setBackGroundColorOpacity(100)
	var_41_10:setBounceEnabled(true)

	for iter_41_0, iter_41_1 in pairs(drop_manager:getDropMsg("PLANEBIGTASK01").equips) do
		local var_41_11 = ccui.Layout:create()

		var_41_11:setContentSize(cc.size(105, 120))

		local var_41_12 = ccui.ImageView:create(self.respath .. "/item_reward_bg.png", var_0_0)

		var_41_12:setPosition(cc.p(50, 60))

		local var_41_13, var_41_14 = flyChessUtility.createIcon("PLANEBIGTASK01", true, iter_41_1.dropid, iter_41_1.dropNum)

		var_41_13:setPosition(50, 60)
		var_41_13:setScale(var_41_13:getScale() * 0.6)
		var_41_12:addChild(var_41_13)
		var_41_11:addChild(var_41_12)

		local var_41_15 = ccui.ImageView:create(self.respath .. "/item_reward_labelbg.png", var_0_0)

		var_41_15:setAnchorPoint(0, 0)
		var_41_12:addChild(var_41_15)

		local var_41_16 = cc.Label:createWithTTF("x" .. var_41_14, FONT_DES, 16)

		var_41_16:setPosition(50, 13)
		var_41_15:addChild(var_41_16)
		var_41_10:pushBackCustomItem(var_41_11)
	end

	self._bossReward_listView = var_41_10

	local var_41_17 = TempWidget:CreateTempImg(self.respath .. "/level_bg.png", var_41_0)

	var_41_17:align(cc.p(0.5, 0.5), var_41_0:size().w / 2, var_41_0:size().h - 255 - GameDisplay.fix_y * 0.6)

	local var_41_18 = TempWidget:CreateTempLabel("区域 1", FONT_DES, 23, var_41_17)

	var_41_18:align(cc.p(0.5, 0.5), var_41_17:size().w / 2, var_41_17:size().h / 2)

	self._level_label = var_41_18

	local var_41_19 = TempWidget:CreateTempImg(self.respath .. "/explore_progress_bg.png", var_41_0)

	var_41_19:align(cc.p(0.5, 0.5), var_41_0:size().w / 2, var_41_0:size().h - 320 - GameDisplay.fix_y * 0.6)

	self._explore_progress_bg = var_41_19

	local var_41_20 = ccui.Slider:create()

	var_41_20:loadBarTexture(self.respath .. "/ex_progress_off.png", var_0_0)
	var_41_20:loadProgressBarTexture(self.respath .. "/ex_progress_on.png", var_0_0)
	var_41_20:setPosition(var_41_19:size().w / 2 + 10, 50)
	var_41_20:setPercent(50)
	var_41_20:setName("explore1_progressBar")
	var_41_19:addChild(var_41_20)

	self._explore_progressBar = var_41_20

	local var_41_21 = TempWidget:CreateTempImg(self.respath .. "/explore_labelbg.png", var_41_19)

	var_41_21:align(cc.p(0, 0), 5, 10)

	local var_41_22 = TempWidget:CreateTempLabel("300", FONT_DES, 18, var_41_21)

	var_41_22:align(cc.p(0.5, 1), var_41_21:size().w / 2 + 10, 28)

	self._explore_label = var_41_22

	local var_41_23 = TempWidget:CreateTempBtn(self.respath .. "/boss_icon_off.png", var_41_19)

	var_41_23:align(cc.p(0.5, 0.5), var_41_19:size().w - 42, var_41_19:size().h / 2 + 5)

	self._bossIconBtn = var_41_23

	var_41_23:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_42_0 = activity_manager:getFlyChessBossInfo(self.activityId)
		local var_42_1

		if not var_42_0 then
			do return end

			var_42_1 = {
				id = model_data[var_42_0.modelid].photofile_model,
				modelid = var_42_0.modelid
			}
		end

		var_42_1.contentType = {
			contentType = photo_manager:getFileType(model_data[var_42_0.modelid].photofile_type)
		}

		if photo_manager:isBigPicture(model_data[var_42_0.modelid].photofile_type) then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_42_1)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_42_1)
		end
	end)

	local var_41_24 = ccui.Slider:create()

	var_41_24:loadBarTexture(self.respath .. "/buff_progress_off.png", var_0_0)
	var_41_24:loadProgressBarTexture(self.respath .. "/buff_progress_on.png", var_0_0)
	var_41_24:setPosition(var_41_19:size().w / 2 + 10, 20)
	var_41_24:setPercent(50)
	var_41_24:setName("explore2_progressBar")
	var_41_19:addChild(var_41_24)

	self._buff_progressBar = var_41_24

	for iter_41_2, iter_41_3 in ipairs((activity_manager:getBuffsAndScoreList(self.activityId))) do
		local var_41_25 = TempWidget:CreateTempImg(self.respath .. "/buff_icon.png", var_41_19)

		var_41_25:align(cc.p(0, 1), 35 * iter_41_2 + 60, -5)
		var_41_25:setTouchEnabled(true)

		self["buff_icon" .. iter_41_2] = var_41_25

		var_41_25:addTouchEventListener(function(arg_43_0, arg_43_1)
			if arg_43_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showBuffInfo(iter_41_3.buff, iter_41_3.buff_score)
		end)
	end

	local var_41_26 = TempWidget:CreateTempBtn(self.respath .. "/paihang.png", var_41_0)

	var_41_26:align(cc.p(0.5, 0.5), 370, 200)

	self.paihang = var_41_26

	local var_41_27 = TempWidget:CreateTempBtn(self.respath .. "/shop_btn.png", var_41_0)

	var_41_27:align(cc.p(0.5, 0.5), 90, 200)

	self.shop_btn = var_41_27

	local var_41_28 = TempWidget:CreateTempBtn(self.respath .. "/task_btn.png", var_41_0)

	var_41_28:align(cc.p(0.5, 0.5), 230, 200)

	self.task_btn = var_41_28
end

function flyChessMainLayer:initComponent(arg_44_1)
	self.map = flyChessMap:create(arg_44_1)
	self.player = flyChessPlayer:create(arg_44_1)

	self.map:attachPlayer(self.player)
	self.player:attachMap(self.map)
	self._root:addChild(self.map, 2)
	self.player:setMapPos(1)
end

function flyChessMainLayer:initData()
	activity_manager:enter_flychess_get_conf(self.activityId, function(arg_46_0)
		return
	end)
end

function flyChessMainLayer:normalDiceAnima(arg_47_1)
	self.isThrowing = true

	local var_47_0 = self._root:getChildByName("normalDiceSpine")
	local var_47_1 = self._root:getChildByName("normalDiceTipsBg")
	local var_47_2 = self._root:getChildByName("normalDiceTips")

	if not var_47_0 then
		var_47_0 = L2Skeleton:create("spine/monopoly/shaizi.json", "spine/monopoly/shaizi.atlas")

		var_47_0:refreshSkeleton()
		var_47_0:setName("normalDiceSpine")
		var_47_0:setScale(0.5)
		self._root:addChild(var_47_0)
		var_47_0:setPosition(cc.p(self._root:getContentSize().width / 2, self._root:getContentSize().height / 2))
	end

	if not var_47_1 and not var_47_2 then
		var_47_1 = TempWidget:CreateTempImg(self.respath .. "/go_bg.png", var_47_0)

		var_47_1:align(cc.p(0.5, 1), var_47_0:getContentSize().width / 2, -100)
		var_47_1:setName("normalDiceTipsBg")

		var_47_2 = ccui.TextBMFont:create("", "fonts/dice.fnt")

		var_47_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_47_2:setPosition(cc.p(var_47_1:getContentSize().width / 2, var_47_1:getContentSize().height / 2))
		var_47_2:setName("normalDiceTips")
		var_47_1:addChild(var_47_2)
	end

	var_47_0:setLocalZOrder(2)
	var_47_1:setLocalZOrder(2)
	var_47_1:setOpacity(0)
	var_47_2:setString(string.format(L_MONOPOLY[40], arg_47_1.diceRandom))
	var_47_0:setVisible(true)
	var_47_0:play(tostring(arg_47_1.diceRandom), false)
	var_47_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_48_0)
		var_47_1:stopAllActions()
		var_47_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.3), cc.DelayTime:create(0.5), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
			var_47_0:setVisible(false)

			self.isThrowing = false
		end)))
		self.player:forward(arg_47_1)
	end)
end

function flyChessMainLayer:anyDiceAnima(arg_50_1)
	self.isThrowing = true

	if not arg_50_1.forward_num or arg_50_1.forward_num == 0 then
		if arg_50_1.cb then
			arg_50_1:cb()
		end

		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_FLYCHESS_DATA_UPDATE, arg_50_1)

		self.isThrowing = false

		return
	end

	local var_50_0 = self._root:getChildByName("anyDiceSpine" .. arg_50_1.forward_num)
	local var_50_1 = self._root:getChildByName("anyDiceTipsBg" .. arg_50_1.forward_num)
	local var_50_2 = self._root:getChildByName("anyDiceTips" .. arg_50_1.forward_num)

	if not var_50_0 then
		var_50_0 = L2Skeleton:create(string.format("spine/monopoly/shaizi_%s.json", arg_50_1.forward_num), (string.format("spine/monopoly/shaizi_%s.atlas", arg_50_1.forward_num)))

		var_50_0:refreshSkeleton()
		var_50_0:setName("anyDiceSpine" .. arg_50_1.forward_num)
		var_50_0:setPosition(cc.p(self._root:getContentSize().width / 2, self._root:getContentSize().height / 2))
		self._root:addChild(var_50_0)
	end

	if not var_50_1 and not var_50_2 then
		var_50_1 = TempWidget:CreateTempImg(self.respath .. "/go_bg.png", var_50_0)

		var_50_1:align(cc.p(0.5, 1), var_50_0:getContentSize().width / 2, -100)
		var_50_1:setName("anyDiceTipsBg" .. arg_50_1.forward_num)

		var_50_2 = ccui.TextBMFont:create("", "fonts/dice.fnt")

		var_50_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_50_2:setPosition(cc.p(var_50_1:getContentSize().width / 2, var_50_1:getContentSize().height / 2))
		var_50_2:setName("anyDiceTips" .. arg_50_1.forward_num)
		var_50_1:addChild(var_50_2)
	end

	var_50_0:setLocalZOrder(2)
	var_50_1:setLocalZOrder(2)
	var_50_1:setOpacity(0)
	var_50_2:setString(string.format(L_MONOPOLY[40], arg_50_1.forward_num))
	var_50_0:setVisible(true)
	var_50_0:play("animation", false)
	var_50_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_51_0)
		var_50_1:stopAllActions()
		var_50_1:runAction(cc.Sequence:create(cc.FadeIn:create(0.3), cc.DelayTime:create(0.5), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
			var_50_0:setVisible(false)

			self.isThrowing = false
		end)))
		self.player:forward(arg_50_1)
	end)
end

function flyChessMainLayer:canThrow()
	if self.player.ismoving then
		return false
	end

	if self.isThrowing then
		return false
	end

	if not activity_manager:can_throw(self.activityId) then
		global_ShowBlockWords("有需要有需要班长处理的事件！")
	end

	return activity_manager:can_throw(self.activityId)
end

function flyChessMainLayer:updateUI(arg_54_1)
	if arg_54_1.explore_point then
		local var_54_0 = activity_manager:getFlyChessBossBattleScore(self.activityId)

		self._explore_label:setString(arg_54_1.explore_point)
		self._explore_progressBar:setPercent(100 * arg_54_1.explore_point / var_54_0)

		local var_54_1 = activity_manager:getBuffsAndScoreList(self.activityId)

		self._buff_progressBar:setPercent(100 * (arg_54_1.explore_point - var_54_0) / (var_54_1[#var_54_1].buff_score - var_54_0))

		if var_54_0 <= arg_54_1.explore_point then
			self._bossIconBtn:loadTextures(self.respath .. "/boss_icon_on.png", nil, self.respath .. "/boss_icon_on.png", var_0_0)
			self.boss_fight:loadTextures(self.respath .. "/boss_fight.png", nil, self.respath .. "/boss_fight.png", var_0_0)
		else
			self._bossIconBtn:loadTextures(self.respath .. "/boss_icon_off.png", nil, self.respath .. "/boss_icon_off.png", var_0_0)
			self.boss_fight:loadTextures(self.respath .. "/boss_fight_off.png", nil, self.respath .. "/boss_fight_off.png", var_0_0)
		end

		for iter_54_0, iter_54_1 in ipairs(var_54_1) do
			if arg_54_1.explore_point >= iter_54_1.buff_score then
				self["buff_icon" .. iter_54_0]:setOpacity(255)
			else
				self["buff_icon" .. iter_54_0]:setOpacity(100)
			end
		end
	end

	self._dice_num_label:setString((item_manager:getItemNumber((activity_manager:getFlyChessTicket(self.activityId)))))

	if arg_54_1.boss_dropid then
		self._bossReward_listView:removeAllChildren()

		for iter_54_2, iter_54_3 in pairs(drop_manager:getDropMsg(arg_54_1.boss_dropid).equips) do
			local var_54_2 = ccui.Layout:create()

			var_54_2:setContentSize(cc.size(105, 120))

			local var_54_3 = ccui.ImageView:create(self.respath .. "/item_reward_bg.png", var_0_0)

			var_54_3:setPosition(cc.p(50, 60))

			local var_54_4, var_54_5 = flyChessUtility.createIcon(arg_54_1.boss_dropid, true, iter_54_3.dropid, iter_54_3.dropNum)

			var_54_4:setPosition(50, 60)
			var_54_4:setScale(var_54_4:getScale() * 0.6)
			var_54_3:addChild(var_54_4)
			var_54_2:addChild(var_54_3)

			local var_54_6 = ccui.ImageView:create(self.respath .. "/item_reward_labelbg.png", var_0_0)

			var_54_6:setAnchorPoint(0, 0)
			var_54_3:addChild(var_54_6)

			local var_54_7 = cc.Label:createWithTTF("x" .. var_54_5, FONT_DES, 16)

			var_54_7:setPosition(50, 13)
			var_54_6:addChild(var_54_7)
			self._bossReward_listView:pushBackCustomItem(var_54_2)
		end
	end

	if arg_54_1.level then
		self._level_label:setString("区域 " .. math.min(arg_54_1.level, activity_manager:getFlyChessMaxLevel(self.activityId)))
	end
end

function flyChessMainLayer:showBuffInfo(arg_55_1, arg_55_2)
	local var_55_0 = ccui.Layout:create()

	var_55_0:setTouchEnabled(true)
	var_55_0:setContentSize(640, 1600)
	var_55_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_55_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_55_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_55_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_55_0:setBackGroundColorOpacity(120)
	var_55_0:addTouchEventListener(function(arg_56_0, arg_56_1)
		if arg_56_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_55_0:runAction(cc.RemoveSelf:create())
	end)
	;(function()
		local var_57_0 = ccui.ImageView:create("EquipLayer/skill_des_bg.png", var_0_0)

		var_57_0:setPosition(cc.p(320, 800))
		var_57_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_55_0:addChild(var_57_0)

		local var_57_1 = ccui.Layout:create()

		var_57_1:setContentSize(cc.size(500, 124))
		var_57_1:setAnchorPoint(cc.p(0, 0))
		var_57_1:setPosition(cc.p(20, 728))
		var_57_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_57_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_57_1:setBackGroundColorOpacity(0)
		var_55_0:addChild(var_57_1, 2)

		local var_57_2 = RichTextPro:create()

		var_57_2:setMaxWidth(480)
		var_57_2:setSize(32)
		var_57_2:setColor(cc.c3b(220, 251, 241))
		var_57_2:setLineSpace(0)
		var_57_2:setText((transSkillDesToRichText(battlefield_status_data[arg_55_1].des)))
		var_57_2:setName("richText")
		var_57_2:setPosition(cc.p(60, 86))
		var_57_1:addChild(var_57_2)
		TempWidget:CreateTempLabel(string.format("探索值达到%d点时", arg_55_2), FONT_DES, 24, var_57_1):align(cc.p(0, 0), 10, 110)
	end)()
	self:addChild(var_55_0, 1000)
end

function flyChessMainLayer:showBossFightSuccess(arg_58_1)
	local var_58_0 = ccui.Layout:create()

	var_58_0:setTouchEnabled(true)
	var_58_0:setContentSize(640, 1600)
	var_58_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_58_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_58_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_58_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_58_0:setBackGroundColorOpacity(120)
	var_58_0:addTouchEventListener(function(arg_59_0, arg_59_1)
		if arg_59_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_58_0:runAction(cc.RemoveSelf:create())
	end)

	local var_58_1 = TempWidget:CreateTempImg(self.respath .. "/bossfight_bg.png", var_58_0)

	var_58_1:align(cc.p(0.5, 0.5), 320, 800)

	self.task_btn = var_58_1

	local var_58_2 = ccui.ListView:create()

	var_58_2:setDirection(ccui.ScrollViewDir.horizontal)
	var_58_2:setContentSize(cc.size(450, 120))
	var_58_2:setPosition(cc.p(125, 170))
	var_58_1:addChild(var_58_2)
	var_58_2:setBackGroundColorOpacity(66)
	var_58_2:setBounceEnabled(true)

	for iter_58_0, iter_58_1 in pairs(drop_manager:getDropMsg(arg_58_1).equips) do
		local var_58_3 = ccui.Layout:create()

		var_58_3:setContentSize(cc.size(145, 120))

		local var_58_4 = ccui.ImageView:create(self.respath .. "/bossfight_reward_bg.png", var_0_0)

		var_58_4:setPosition(cc.p(50, 60))

		local var_58_5, var_58_6 = flyChessUtility.createIcon(arg_58_1, true, iter_58_1.dropid, iter_58_1.dropNum)

		var_58_5:setPosition(50, 60)
		var_58_5:setScale(var_58_5:getScale() * 0.6)
		var_58_4:addChild(var_58_5)
		var_58_3:addChild(var_58_4)

		local var_58_7 = ccui.ImageView:create(self.respath .. "/bossfight_reward_label.png", var_0_0)

		var_58_7:setAnchorPoint(0, 0)
		var_58_4:addChild(var_58_7)

		local var_58_8 = cc.Label:createWithTTF("x" .. var_58_6, FONT_DES, 16)

		var_58_8:setPosition(50, 13)
		var_58_7:addChild(var_58_8)
		var_58_2:pushBackCustomItem(var_58_3)
	end

	local var_58_9 = TempWidget:CreateTempBtn(self.respath .. "/bossfight_sure_btn.png", var_58_1)

	var_58_9:align(cc.p(0.5, 0.5), var_58_1:size().width / 2, 0)
	var_58_9:_addEvent(function()
		var_58_0:runAction(cc.RemoveSelf:create())
	end)
	self:addChild(var_58_0, 1000)
end

function flyChessMainLayer:choose_btn_Test(arg_61_1)
	if not self.player_choose_btn then
		local var_61_0 = TempWidget:CreateTempBtn(self.respath .. "/event_select_btn.png", self._root)

		var_61_0:align(cc.p(0.5, 0), self._diceBtn:getPositionX(), self._diceBtn:getPositionY() + self._diceBtn:size().h)

		self.player_choose_btn = var_61_0

		local var_61_1 = TempWidget:CreateTempImg(self.respath .. "/select_icon.png", var_61_0)

		var_61_1:align(cc.p(0.5, 0), var_61_0:size().w / 2 - 5, var_61_0:size().h / 2 - 20)

		self.select_icon = var_61_1
	end

	if arg_61_1.cur_eventType == var_0_12 then
		self.player_choose_btn:loadTextures(self.respath .. "/build_btn.png", nil, self.respath .. "/build_btn.png", var_0_0)
		self.select_icon:loadTexture(self.respath .. "/build_icon.png", var_0_0)
	elseif arg_61_1.cur_eventType == var_0_11 then
		self.player_choose_btn:loadTextures(self.respath .. "/fight_btn.png", nil, self.respath .. "/fight_btn.png", var_0_0)
		self.select_icon:loadTexture(self.respath .. "/fight_icon.png", var_0_0)
	else
		self.player_choose_btn:loadTextures(self.respath .. "/event_select_btn.png", nil, self.respath .. "/event_select_btn.png", var_0_0)
		self.select_icon:loadTexture(self.respath .. "/select_icon.png", var_0_0)
	end

	self.player_choose_btn:_addEvent(function()
		if not arg_61_1.waiting then
			return
		end

		if self.player.ismoving then
			return
		end

		if self.isThrowing then
			return
		end

		arg_61_1.layer = self

		var_0_14[arg_61_1.cur_eventType](arg_61_1)
	end)

	if not arg_61_1.waiting then
		self.player_choose_btn:setVisible(false)

		return
	end

	self.player_choose_btn:setVisible(true)
end
