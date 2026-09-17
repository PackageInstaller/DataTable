ScoreArenaLayer = class("ScoreArenaLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local diamond_update_data = require("data.diamond_update_data")
local arenaawardsnew_data = require("data.arenaawardsnew_data")
local array_manager = require("controller.array_manager")
local scorearena_manager = require("controller.scorearena_manager")

require("view.Sprite.ConfirmDialogSprite")
require("view.Layer.BattleArrayLayerNew")
require("view.Layer.PopLayer")

local score_arena_awards_data = require("data.score_arena_awards_data")
local score_daily_awards_data = require("data.score_daily_awards_data")

ScoreArenaLayer.arenatype = nil
ScoreArenaLayer.arenaframes = {}
ScoreArenaLayer.playerfightdata = {}
ScoreArenaLayer.enemyfightdata = {}

local var_0_19 = 1
local var_0_27 = config._DEBUG and 0 or 1
local var_0_28

function ScoreArenaLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ScoreArenaLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ScoreArenaLayer.getInstance()
	return var_0_28
end

function ScoreArenaLayer:init(arg_4_1)
	var_0_28 = self

	if arg_4_1 then
		self.createPopLayerCallBack = arg_4_1.createPopLayerCallBack
	end

	self.arenatype = var_0_19
	self.remainTimes = nil
	self.lastFightTime = nil
	self.buyTimesCount = nil
	self.timeCount = nil
	self.battleInfos = {}
	self.freeflashtimes = nil
	self.buyflashtimes = nil
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ArenaSceneNewOne.json" or "ArenaSceneNewOne.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_17"):setVisible(false)

	self.shopBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_21_1")

	self.shopBnt:setPositionY(self.shopBnt:getPositionY() - 20)

	self.ranklistBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_21_0")

	self.ranklistBnt:setPositionY(self.ranklistBnt:getPositionY() - 20)

	self.scrambleBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_21_2")

	self.scrambleBnt:setVisible(false)

	self.baseimage = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_13")
	self.refreshBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_61")
	self.ruleBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_7")
	self.backBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_44")
	self.top_title = ccui.Helper:seekWidgetByName(self.rootLayer, "top_title")
	self.topPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_25")
	self.buttomPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "buttom_Panel")
	self.midpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "mid_title_0")
	self.scollbg = ccui.Helper:seekWidgetByName(self.rootLayer, "Imagebg_scrollview")
	self.timepanel = ccui.Helper:seekWidgetByName(self.rootLayer, "time_bg")
	self.roleImage = ccui.Helper:seekWidgetByName(self.rootLayer, "roleimagebg")

	self.roleImage:loadTexture("role/23120.png")
	self.roleImage:setScale(0.6)
	self.roleImage:setPosition(cc.p(160, 120))

	self.topTitle = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_4")

	self.topTitle:loadTexture("arenascenenew/jifen_logo.png", var_0_27)
	self.topTitle:setPositionX(self.topTitle:getPositionX() - 9)

	self.playerDW = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_17")
	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_49")
	self.progressbar = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_50")
	self.box1 = ccui.Helper:seekWidgetByName(self.rootLayer, "box_Image_1")
	self.box2 = ccui.Helper:seekWidgetByName(self.rootLayer, "box_Image_2")
	self.box3 = ccui.Helper:seekWidgetByName(self.rootLayer, "box_Image_3")
	self.boxs = {
		self.box1,
		self.box2,
		self.box3
	}

	self:moveToScreenOut()

	for iter_4_0 = 1, #self.boxs do
		self.boxs[iter_4_0]:addTouchEventListener(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.boxs[iter_4_0]:runAction(cc.Sequence:create(cc.ScaleTo:create(0.05, 1.5), cc.ScaleTo:create(0.05, 1), cc.CallFunc:create(function()
				scorearena_manager:get_daily_scorearena_awards(iter_4_0, function(arg_7_0)
					if not var_0_28 then
						return
					end

					if arg_7_0 == 1 then
						AnalyticManager.get_score_lsvictor({
							score_getawardid = score_daily_awards_data[iter_4_0].id
						})
						global_gain({
							diamond = score_daily_awards_data[iter_4_0].diamond,
							honor = score_daily_awards_data[iter_4_0].honor
						})
						self.boxs[iter_4_0]:getChildByName("Image_" .. iter_4_0 .. "_2"):setVisible(false)
						self.boxs[iter_4_0]:getChildByName("Image_" .. iter_4_0 .. "_1"):setVisible(false)
						self.boxs[iter_4_0]:getChildByName("Image_" .. iter_4_0):setVisible(true)
						self:updateRedStatus()
					elseif arg_7_0 == 3 then
						self:showAwardInfo(self.boxs[iter_4_0], score_daily_awards_data[iter_4_0].need, score_daily_awards_data[iter_4_0].diamond, score_daily_awards_data[iter_4_0].honor, iter_4_0)
					end
				end)
			end)))
		end)
	end

	self.ruleBtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopScoreArenaDetailPage")
	end)
	self.shopBnt:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_9_0:setTouchEnabled(false)

		local var_9_0 = cc.EventCustom:new("switchShowLayer")

		var_9_0.layerName = "MarketLayer"
		var_9_0.initparam = {
			singleMarket = "1-9",
			returnLayer = "ScoreArenaLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_9_0)
	end)
	self.refreshBnt:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updateFlashTimes(callback)
	end)
	self.backBtn:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.ranklistBnt:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_12_0:setTouchEnabled(false)
		self:layerOutAction(function()
			local var_13_0 = cc.EventCustom:new("switchShowLayer")

			var_13_0.layerName = "ScoreArenaRankingPanelLayer"
			var_13_0.initparam = {
				score = self.score,
				rank = self.rank
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_13_0)
		end)
	end)
	self.scrambleBnt:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_14_0 = cc.EventCustom:new("switchShowLayer")

		var_14_0.layerName = "ArenaLayer"

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_14_0)
	end)

	self.remaintimeslable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_9")
	self.myrank = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_14_2")
	self.arenaranklable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_14_1")
	self.hororpointlable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_14_1_0")

	local var_4_0 = ccui.ImageView:create("public/currency/arenascene_dot_1.png", var_0_27)

	var_4_0:setScale(0.5, 0.5)
	var_4_0:setAnchorPoint(0, 0)
	var_4_0:setPosition(cc.p(self.hororpointlable:getPositionX() - 30, self.hororpointlable:getPositionY() - 2))
	self.baseimage:addChild(var_4_0, 9)

	self.flashlable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_60")
	self.victorlable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_45")
	self.victorlable11 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_44")

	self.victorlable11:setString(L_SCORE_AREAN_VICTOR)
	ccui.Helper:seekWidgetByName(self.rootLayer, "time_label"):setString(L_SCORE_AREAN_DES[1])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_44_0"):setString(L_SCORE_AREAN_DES[2])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_21"):setString(L_SCORE_AREAN_DES[3])
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_59"):setString(L_SCORE_AREAN_DES[5])
	self.buttomPanel:getChildByName("Label_45"):setString(L_SCORE_AREAN_DES[4])

	self.thisviclable = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_22")
	self.copyitem = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollviewItem_panel")

	scorearena_manager:get_player_scorearena_data(function(arg_15_0)
		if tolua.isnull(self) then
			return
		end

		print(dump(arg_15_0))
		self:initMyInfoPanel(arg_15_0)
		self:initEnemyScrollView(arg_15_0.enemies)
		self.playerDW:setVisible(true)

		if arg_4_1 and arg_4_1.needAutoFight then
			self:checkAutoFight()
		end
	end)

	self.autoFight = RoleDefault:getInstance():getBoolForKey("ScoreAutoFight", false)

	local var_4_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_64")
	local var_4_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_66")

	var_4_2:setVisible(self.autoFight)
	var_4_1:setTouchEnabled(true)
	var_4_1:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.autoFight = not self.autoFight

		var_4_2:setVisible(self.autoFight)
		RoleDefault:getInstance():setBoolForKey("ScoreAutoFight", self.autoFight)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("score_cancel_auto_fight", function(arg_17_0)
		self.autoFight = false

		var_4_2:setVisible(self.autoFight)
	end), self)
	self:registerScriptHandler(function(arg_18_0)
		if arg_18_0 == "exit" then
			var_0_28 = nil
		end
	end)
	self:fullScreen(self.rootLayer)
	self:playEnterOrOutAni(true)
	RoleDefault:getInstance():setBoolForKey("ScoreArenaLayerIsEnter", true)
end

local function var_0_30(arg_20_0)
	if not arg_20_0 then
		return
	end

	if arg_20_0 >= 86400 then
		return string.format(L_TIME_FORMAT_DAYNHOUR, math.floor(arg_20_0 / 86400), math.floor(arg_20_0 % 86400 / 3600))
	elseif arg_20_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_20_0 / 3600), math.floor(arg_20_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_20_0 / 60))
	end
end

function ScoreArenaLayer:initMyInfoPanel(arg_21_1)
	local var_21_2 = arg_21_1.rank

	if not arg_21_1.rank or var_21_2 == 0 then
		var_21_2 = L_SCORE_AREAN_NO_RANK
	end

	self.rank = var_21_2

	local var_21_3 = global_trans_number(arg_21_1.score)

	self.score = var_21_3
	self.freeflashtimes = arg_21_1.refreshtime

	self.flashlable:setString("" .. self.freeflashtimes)

	self.buyflashtimes = arg_21_1.diamondtime

	self.remaintimeslable:setString((var_0_30(arg_21_1.settletime or 86400)))

	local var_21_4 = 0
	local var_21_5 = 5

	for iter_21_0, iter_21_1 in pairs(score_arena_awards_data) do
		if arg_21_1.score >= iter_21_1.min and arg_21_1.score <= iter_21_1.max then
			var_21_5 = iter_21_0

			break
		end
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_1.enemies) do
		if iter_21_3.isdefeat then
			var_21_4 = var_21_4 + 1
		end
	end

	self.thisviclable:setString("" .. var_21_4 .. "/" .. 6)
	self.arenaranklable:setString("" .. var_21_3)
	self.myrank:setString("" .. var_21_2)
	self.playerDW:loadTexture("arenascenenew/duanwei" .. "_" .. var_21_5 .. ".png", var_0_27)
	self.hororpointlable:setString("" .. playermodel.honor)
	self.victorlable:setString("" .. arg_21_1.success_daily)
	RoleDefault:getInstance():setIntegerForKey("ScoreArenaLayerLeijiShengChang", arg_21_1.success_daily)
	self:updateDayWinAwardBar(arg_21_1.success_daily, arg_21_1.dailyawards)
end

function ScoreArenaLayer:updateVictorLable(arg_22_1)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		if iter_22_1.isdefeat then
			var_22_0 = var_22_0 + 1
		end
	end

	self.thisviclable:setString("" .. var_22_0 .. "/" .. 6)
end

function ScoreArenaLayer:updateFlashTimes(arg_23_1)
	if not self.freeflashtimes or not self.buyflashtimes then
		return
	end

	if self.freeflashtimes > 0 then
		global_basic_scene:addChild(ConfirmDialogSprite:create("", L_SCORE_AREAN_REFRESH_TIMES.Sure_Refresh, {
			layerType = "ScoreArenaLayer",
			surecallback = function()
				scorearena_manager:refresh_match_enemies_manual(function(arg_25_0, arg_25_1)
					if arg_25_0 == 1 then
						AnalyticManager.score_flash_success({
							score_flash_cost = 50
						})
						self:initEnemyScrollView(arg_25_1, true)

						self.freeflashtimes = self.freeflashtimes - 1

						self.flashlable:setString("" .. self.freeflashtimes)
					end
				end)
			end,
			cancelcallback = cancelCallback,
			btnLabel = L_BUTTON_TEXT.Sure
		}, true, true), 999)
	elseif self.buyflashtimes > 0 then
		self.freeflashtimes = self.freeflashtimes - 1

		self.buytime()
	else
		global_ShowBlockWords(L_SCORE_AREAN_REFRESH_TIMES.Out_Of_Times)
	end

	if arg_23_1 then
		arg_23_1()
	end
end

function ScoreArenaLayer:updatePlayerTatsuki()
	local var_26_0 = array_manager:getArenaDefenceArray()

	self.roleImage:loadTexture("role/" .. model_data[global_get_servant_skin(((var_26_0 and #var_26_0 > 0 or nil) and var_26_0[1]).fight_girl)].role_image .. ".png")
	self.roleImage:setScale(0.65)
	self.roleImage:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, (cc.p(-300, 100))), (cc.MoveTo:create(0.1, (cc.p(200, 100))))))
end

function ScoreArenaLayer:updateDayWinAwardBar(arg_27_1, arg_27_2)
	local var_27_0 = 0

	if arg_27_1 == 3 then
		var_27_0 = -0.1
	elseif arg_27_1 == 5 then
		var_27_0 = 0.1
	elseif arg_27_1 == 9 then
		var_27_0 = 0.3
	end

	self.progressbar:setPercent(math.floor(100 * (arg_27_1 + var_27_0) / score_daily_awards_data[#score_daily_awards_data].need))

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		local var_27_1 = self.boxs[iter_27_0]

		if not self.boxs[iter_27_0] then
			break
		end

		var_27_1:getChildByName("Image_" .. iter_27_0):setVisible(iter_27_1.isget)
		var_27_1:getChildByName("Image_" .. iter_27_0 .. "_1"):setVisible(not iter_27_1.isget and not iter_27_1.canget)
		var_27_1:getChildByName("Image_" .. iter_27_0 .. "_1"):getChildByName("Label_31"):setString("" .. score_daily_awards_data[iter_27_0].need .. L_VICTOR)
		var_27_1:getChildByName("Image_" .. iter_27_0 .. "_2"):setVisible(not iter_27_1.isget and iter_27_1.canget)
	end

	self:updateRedStatus()
end

function ScoreArenaLayer:updateRedStatus()
	local var_28_0 = false

	for iter_28_0, iter_28_1 in ipairs(self.boxs) do
		if iter_28_1:getChildByName("Image_" .. iter_28_0 .. "_2"):isVisible() then
			global_add_alert_tag(iter_28_1, cc.p(80, 80))

			var_28_0 = true
		else
			global_remove_alert_tag(iter_28_1)
		end
	end

	RoleDefault:getInstance():setBoolForKey("ScoreBoxRedisExit", var_28_0)

	if var_28_0 then
		local alert_manager = require("controller.alert_manager")
	end
end

function ScoreArenaLayer:initEnemyScrollView(arg_29_1, arg_29_2)
	self:updateVictorLable(arg_29_1)

	local var_29_0 = 140
	local var_29_2 = arg_29_1
	local var_29_3 = #arg_29_1
	local var_29_4 = cc.size(640, 490 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))
	local var_29_5 = #arg_29_1 * 140 + 52

	if #arg_29_1 * 140 + 52 < var_29_4.height then
		var_29_5 = var_29_4.height
	end

	self.scrollView:setContentSize(var_29_4)
	self.scrollView:setInnerContainerSize(cc.size(var_29_4.width, var_29_5))
	self.scrollView:removeAllChildren()

	local var_29_6 = {}

	for iter_29_0 = 1, var_29_3 do
		local var_29_7 = self.copyitem:clone()
		local var_29_8 = global_trans_number(var_29_2[iter_29_0].fightpower)

		ccui.Helper:seekWidgetByName(var_29_7, "emeyname"):setString("" .. var_29_2[iter_29_0].name)
		ccui.Helper:seekWidgetByName(var_29_7, "fightpoint"):setString(L_SCORE_AREAN_ENEMY.Fightpoint .. var_29_8)
		ccui.Helper:seekWidgetByName(var_29_7, "awardsvalue"):setString(L_SCORE_AREAN_ENEMY.Awardsvalue .. var_29_2[iter_29_0].score)

		if var_29_2[iter_29_0].isdefeat then
			ccui.Helper:seekWidgetByName(var_29_7, "vs_image"):setVisible(true)
			ccui.Helper:seekWidgetByName(var_29_7, "changeemeybtn"):setVisible(false)
		else
			ccui.Helper:seekWidgetByName(var_29_7, "vs_image"):setVisible(false)
			ccui.Helper:seekWidgetByName(var_29_7, "changeemeybtn"):setVisible(true)
		end

		ccui.Helper:seekWidgetByName(var_29_7, "btn_Label_61"):setString(L_SUBSTITUTION_FIGHT)
		ccui.Helper:seekWidgetByName(var_29_7, "changeemeybtn"):setName("changeemeybtn" .. "_" .. iter_29_0)
		ccui.Helper:seekWidgetByName(var_29_7, "changeemeybtn" .. "_" .. iter_29_0):addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			scorearena_manager:get_matched_enemy_data(var_29_2[iter_29_0].playerid, function(arg_31_0, arg_31_1)
				if arg_31_0 == 1 then
					LayerManager:pushInLayer("PopShowScoreArenaEnemyArray", {
						enemysData = arg_31_1,
						fightpoint = var_29_2[iter_29_0].fightpower,
						playerid = var_29_2[iter_29_0].playerid
					})
				end
			end)
		end)

		local var_29_9 = ccui.Helper:seekWidgetByName(var_29_7, "emeyface")
		local var_29_10 = ccui.Helper:seekWidgetByName(var_29_7, "avatar")

		var_29_9:setVisible(false)

		if not var_29_10 then
			var_29_10 = AvatarSprite:create(var_29_2[iter_29_0].head_sculpture)

			var_29_10:setScale(0.6)
			var_29_10:setPosition(cc.p(10, 0))
			var_29_9:getParent():addChild(var_29_10)
		else
			var_29_10:switchShowAvatar(var_29_2[iter_29_0].head_sculpture)
		end

		self.scrollView:addChild(var_29_7)

		if arg_29_2 then
			var_29_7:runAction((cc.MoveTo:create(1 / var_29_3, cc.p(33, var_29_5 - var_29_0 * iter_29_0 + 15))))
		else
			var_29_7:setPosition(cc.p(33, var_29_5 - var_29_0 * iter_29_0 + 15))
			var_29_7:setOpacity(0)

			var_29_6[iter_29_0] = var_29_7
		end
	end

	if not arg_29_2 then
		local function var_29_11(arg_32_0)
			if arg_32_0 > #var_29_6 then
				return
			end

			var_29_6[arg_32_0]:runAction(cc.Sequence:create(cc.FadeIn:create(0.05), cc.DelayTime:create(0.01), cc.CallFunc:create(function()
				var_29_11(arg_32_0 + 1)
			end)))
		end

		if var_29_6 and #var_29_6 > 0 then
			var_29_11(1)
		end
	end
end

function ScoreArenaLayer.updateArray(arg_34_0, arg_34_1, arg_34_2)
	return
end

function ScoreArenaLayer.popDetail(arg_35_0)
	return
end

function ScoreArenaLayer:showAwardInfo(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	for iter_36_0 = 1, 3 do
		if iter_36_0 ~= arg_36_5 and self.boxs[iter_36_0]:getChildByName("showawardpanel") then
			self.boxs[iter_36_0]:getChildByName("showawardpanel"):removeFromParent()
		end
	end

	if arg_36_1:getChildByName("showawardpanel") then
		return
	end

	local var_36_0 = ccui.Layout:create()

	var_36_0:setContentSize(cc.size(200, 100))
	var_36_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_36_0:setAnchorPoint(0.5, 0)
	var_36_0:setPosition(cc.p(arg_36_1:getPositionX() / 2 - 100, arg_36_1:getPositionY() + 15))
	var_36_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_36_0:setCascadeOpacityEnabled(false)
	var_36_0:setBackGroundColorOpacity(190)
	var_36_0:setName("showawardpanel")
	var_36_0:setTouchEnabled(true)
	var_36_0:setScale(0)
	arg_36_1:addChild(var_36_0)

	local var_36_1 = cc.Label:createWithTTF("1", FONT_DES, 18)

	var_36_1:setMaxLineWidth(190)
	var_36_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_1:setPosition(cc.p(var_36_0:getContentSize().width / 2, var_36_0:getContentSize().height / 2 + 38))
	var_36_1:setName("Label1")
	var_36_1:setString(string.format(L_SCORE_AREAN_SHOW_ADDUP_AWARD, arg_36_2))
	var_36_0:addChild(var_36_1)

	local var_36_2 = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_27)

	var_36_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_2:setPosition(cc.p(var_36_0:getContentSize().width / 2 - 50, var_36_0:getContentSize().height / 2 - 5))
	var_36_2:setScale(1)
	var_36_2:setName("Img1")
	var_36_0:addChild(var_36_2)

	local var_36_3 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_36_3:setMaxLineWidth(23)
	var_36_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_3:setColor(cc.c3b(208, 203, 187))
	var_36_3:setPosition(cc.p(var_36_2:getContentSize().width / 2, var_36_2:getContentSize().height / 2 - 30))
	var_36_3:setName("Label1")
	var_36_3:setString("x" .. arg_36_3)
	var_36_2:addChild(var_36_3)

	local var_36_4 = ccui.ImageView:create("public/currency/arenascene_dot_1.png", var_0_27)

	var_36_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_4:setPosition(cc.p(var_36_0:getContentSize().width / 2 + 40, var_36_0:getContentSize().height / 2 - 8))
	var_36_4:setScale(0.7)
	var_36_0:addChild(var_36_4)

	local var_36_5 = cc.Label:createWithTTF("1", FONT_DES, 20)

	var_36_5:setMaxLineWidth(23)
	var_36_5:setAnchorPoint(cc.p(0.5, 0.5))
	var_36_5:setColor(cc.c3b(208, 203, 187))
	var_36_5:setPosition(cc.p(var_36_0:getContentSize().width / 2 + 40, var_36_0:getContentSize().height / 2 - 35))
	var_36_5:setName("Label2")
	var_36_5:setString("x" .. arg_36_4)
	var_36_0:addChild(var_36_5)

	local var_36_6 = cc.EventListenerTouchOneByOne:create()

	var_36_6:setSwallowTouches(false)
	var_36_6:registerScriptHandler(function(arg_37_0, arg_37_1)
		if arg_36_1:getChildByName("showawardpanel") then
			arg_36_1:getChildByName("showawardpanel"):removeFromParent()
		end

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_36_6:registerScriptHandler(function(arg_38_0, arg_38_1)
		if arg_36_1:getChildByName("showawardpanel") then
			arg_36_1:getChildByName("showawardpanel"):removeFromParent()
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_36_6, var_36_0)
	var_36_0:runAction((cc.ScaleTo:create(0.2, 1)))
end

function ScoreArenaLayer.buytime(arg_39_0, arg_39_1)
	LayerManager:pushInLayer("PopDoLayer", {
		cost = 50,
		costtype = "diamond",
		own = playermodel.diamond,
		surecallback = function()
			scorearena_manager:refresh_match_enemies_manual(function(arg_41_0, arg_41_1)
				if arg_41_0 == 1 then
					var_0_28:initEnemyScrollView(arg_41_1, true)
					global_ShowBlockWords(L_ARENA_BUY_TIME.Success)
				elseif arg_41_0 == 2 then
					global_ShowBlockWords(L_DIAMOND_LACK)
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 0
					})
				elseif arg_41_0 == 0 then
					global_ShowBlockWords(L_ARENA_BUY_TIME.Fail)
				end

				if arg_39_1 then
					arg_39_1()
				end
			end)
		end,
		labels = L_GO_BUY_SCOREARENA_TIMES
	})
end

function ScoreArenaLayer.layerOutAction(arg_43_0, arg_43_1)
	if arg_43_1 then
		arg_43_1()
	end
end

function ScoreArenaLayer:fullScreen(arg_44_1)
	arg_44_1:setContentSize((GameDisplay.getScreenSize()))
	arg_44_1:setPositionY(arg_44_1:getPositionY() - GameDisplay.fix_y)
	self.top_title:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height - 29))
	self.topPanel:setPositionY(self.top_title:getPositionY() - self.topPanel:getContentSize().height - 30)

	local var_44_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.buttomPanel:setContentSize(cc.size(640, 539 + var_44_0))
	self.midpanel:setPositionY(self.buttomPanel:getPositionY() + self.buttomPanel:getContentSize().height)
	self.scollbg:setScale9Enabled(true)
	self.scollbg:setCapInsets(cc.rect(0, 475, 539, 27))
	self.scollbg:setContentSize(cc.size(640, 539 + var_44_0))
end

function ScoreArenaLayer:playEnterOrOutAni(arg_45_1, arg_45_2)
	if arg_45_1 then
		self.baseimage:runAction(cc.MoveTo:create(0.5, cc.p(487, self.baseimage:getPositionY())))
		self.timepanel:runAction(cc.MoveTo:create(0.5, cc.p(337, self.timepanel:getPositionY())))
		self.roleImage:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.FadeIn:create(0.5)))
	else
		self.baseimage:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.baseimage:getPositionY())))
		self.timepanel:runAction(cc.MoveTo:create(0.5, cc.p(1500, self.timepanel:getPositionY())))
		self.roleImage:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.FadeOut:create(0.5)))

		if arg_45_2 then
			arg_45_2()
		end
	end
end

function ScoreArenaLayer:moveToScreenOut()
	self.baseimage:setPositionX(1500)
	self.timepanel:setPositionX(1500)
	self.roleImage:setOpacity(0)
end

function ScoreArenaLayer.checkAutoFight(arg_47_0)
	local var_47_0 = scorearena_manager:get_auto_fight_enemy()

	if not var_47_0 then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("ScoreAutoFight", false) then
		global_count_down_layer(4, function()
			scorearena_manager:get_matched_enemy_data(var_47_0.playerid, function(arg_49_0, arg_49_1)
				if arg_49_0 == 1 then
					LayerManager:pushInLayer("PopShowScoreArenaEnemyArray", {
						enemysData = arg_49_1,
						fightpoint = var_47_0.fightpower,
						playerid = var_47_0.playerid
					})
				end
			end)
		end, function()
			RoleDefault:getInstance():setBoolForKey("ScoreAutoFight", false)
		end)
	end
end

return ChangeBtnLayer
