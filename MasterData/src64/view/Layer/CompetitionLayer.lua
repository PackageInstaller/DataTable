CompetitionLayer = class("CompetitionLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.TvTRankSprite")

local scorearena_manager = require("controller.scorearena_manager")
local arena_manager = require("controller.arena_manager")
local arenatft_manager = require("controller.arenatft_manager")
local alert_manager = require("controller.alert_manager")
local array_manager = require("controller.array_manager")
local monster_manager = require("controller.monster_manager")
local time_check_manager = require("controller.time_check_manager")
local levelmode_data = require("data.levelmode_data")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local substitution_manager = require("controller.substitution_manager")
local audio_manager = require("controller.audio_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local var_0_15 = {
	"ScoreArenaLayer",
	"ArenaLayer",
	"ThreeVsThreeLayer"
}
local var_0_18 = {
	ArenaLayer = "ArenaLayerIsEnter",
	ScoreArenaLayer = "ScoreArenaLayerIsEnter"
}
local var_0_19 = cc.c3b(245, 212, 19)

local function var_0_20(arg_2_0)
	if not arg_2_0 then
		return
	end

	if arg_2_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_2_0 / 60))
	end
end

local var_0_21

function CompetitionLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = CompetitionLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function CompetitionLayer:init(arg_4_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "CompetitionLayer.json" or "CompetitionLayer.ExportJson")

	self:addChild(self.rootLayer)

	if arg_4_1 then
		self.returnbacklayer = arg_4_1.returnbacklayer or "AdventureLayer"
	end

	var_0_21 = self

	self:initUI()
	self:updateBtnLables()
	self:initNewAlertStatus()
	self:fullScreen(self.rootLayer)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_21 = nil
		end
	end)
end

function CompetitionLayer:initUI()
	self:initBottomList()
	self:createTitleSprite()
	self:initListView()
end

function CompetitionLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer(self.returnbacklayer)
	end)

	self:addChild(self.bottomList, 10)
end

function CompetitionLayer:createTitleSprite()
	self.title = TitleSprite:create("CompetitionLayer/tile.png", 2)

	self.title:setName("title")
	self.title:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.title, 5)
end

function CompetitionLayer:initListView()
	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_13")

	self.Listview:setContentSize(cc.size(640, 1000 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)))
	self.Listview:setPosition(cc.p(0, 90))
	self.Listview:setBounceEnabled(true)
	self.Listview:setItemsMargin(10)

	for iter_10_0, iter_10_1 in ipairs(var_0_15) do
		local var_10_0 = self:createNode(iter_10_0)

		var_10_0:setName("btn_" .. iter_10_1)

		local var_10_1 = ccui.Helper:seekWidgetByName(var_10_0, "jump_btn")

		var_10_1:setSwallowTouches(false)
		var_10_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.15 * (iter_10_0 - 1)), cc.FadeIn:create(0.4)))
		var_10_1:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:updateBtnAlerts(iter_10_1)

			if iter_10_1 == "ThreeVsThreeLayer" and arenatft_manager:getCurSeason() < 0 then
				global_ShowBlockWords(L_TVT_BEHAND_SEASON_2)

				return
			end

			LayerManager:switchShowLayer(iter_10_1)
		end)
		self:updateCompetionTimes(var_10_0, iter_10_0)
		self.Listview:pushBackCustomItem(var_10_0)
	end
end

function CompetitionLayer:createNode(arg_12_1)
	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "items" .. arg_12_1):clone()

	var_12_0:setTouchEnabled(false)
	var_12_0:setOpacity(0)

	return var_12_0
end

function CompetitionLayer:updateBtnLables()
	self:updateScroceBtnLable()
	arena_manager:get_fight_data(function(arg_14_0)
		if not var_0_21 then
			return
		end

		self:updateArenaBtnLable(arg_14_0.rank, arg_14_0.class)
	end)
	arenatft_manager:get_season_data(function(arg_15_0)
		if not var_0_21 then
			return
		end

		self:updateTftBtnLable()
	end)

	local var_13_0 = self.Listview:getChildByName("btn_ThreeVsThreeLayer")
	local var_13_1 = var_13_0:getChildByName("jump_btn")

	if not level_manager:isPlayerPassLevel(UNLOCK_THREE_VS_THREE) then
		var_13_1:setColor(cc.c3b(82, 82, 82))

		local var_13_2 = ccui.ImageView:create("public/button/horcrux_lock.png", var_0_0)

		var_13_2:setPosition(cc.p(125, 130))
		var_13_0:addChild(var_13_2)

		local var_13_3 = cc.Label:createWithTTF(L_TVT_UNKOCK, FONT_NAME, 25)

		var_13_3:setPosition(cc.p(325, 125))
		var_13_0:addChild(var_13_3)
	else
		var_13_1:setColor(cc.c3b(255, 255, 255))
	end

	local var_13_4 = self.Listview:getChildByName("btn_ScoreArenaLayer")
	local var_13_5 = var_13_4:getChildByName("jump_btn")

	if not level_manager:isPlayerPassLevel(UNLOCK_SCOREARENA) then
		var_13_5:setColor(cc.c3b(82, 82, 82))

		local var_13_6 = ccui.ImageView:create("public/button/horcrux_lock.png", var_0_0)

		var_13_6:setPosition(cc.p(125, 130))
		var_13_4:addChild(var_13_6)

		local var_13_7 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_SCOREARENA)), FONT_NAME, 25)

		var_13_7:setPosition(cc.p(325, 125))
		var_13_4:addChild(var_13_7)
	else
		var_13_5:setColor(cc.c3b(255, 255, 255))
	end

	local var_13_8 = self.Listview:getChildByName("btn_ArenaLayer")
	local var_13_9 = var_13_8:getChildByName("jump_btn")

	if not level_manager:isPlayerPassLevel(UNLOCK_ARENA) then
		var_13_9:setColor(cc.c3b(82, 82, 82))

		local var_13_10 = ccui.ImageView:create("public/button/horcrux_lock.png", var_0_0)

		var_13_10:setPosition(cc.p(125, 130))
		var_13_8:addChild(var_13_10)

		local var_13_11 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_ARENA)), FONT_NAME, 25)

		var_13_11:setPosition(cc.p(325, 125))
		var_13_8:addChild(var_13_11)
	else
		var_13_9:setColor(cc.c3b(255, 255, 255))
	end
end

function CompetitionLayer:updateScroceBtnLable()
	local var_16_0 = time_check_manager:getCurTime()
	local var_16_1 = os.date("*t", math.floor(var_16_0))
	local var_16_2 = 0

	if var_16_1.wday < 7 and var_16_1.wday >= 2 then
		var_16_2 = (5 - (var_16_1.wday - 1)) * 24 * 3600 + (23 - var_16_1.hour) * 3600 + (59 - var_16_1.min) * 60 + (59 - var_16_1.sec)
	elseif var_16_1.wday == 1 then
		var_16_2 = (23 - var_16_1.hour) * 3600 + (59 - var_16_1.min) * 60 + (59 - var_16_1.sec) + 432000
	elseif var_16_1.wday == 7 then
		var_16_2 = (23 - var_16_1.hour) * 3600 + (59 - var_16_1.min) * 60 + (59 - var_16_1.sec) + 518400
	end

	self.endtime = var_16_2 + var_16_0

	self.Listview:getChildByName("btn_ScoreArenaLayer"):getChildByName("time"):setString(var_0_20(var_16_2))
end

function CompetitionLayer:updateArenaBtnLable(arg_17_1, arg_17_2)
	if self.Listview:getChildByName("btn_ArenaLayer") then
		local var_17_0 = self.Listview:getChildByName("btn_ArenaLayer"):getChildByName("time")

		if arg_17_1 < 0 then
			var_17_0:setString(L_PVP_RESULT_NO_RANK)
		elseif arg_17_1 < 1000 then
			var_17_0:setString(string.format("%03d", arg_17_1))
		else
			var_17_0:setString(arg_17_1)
		end

		if arg_17_2 and arg_17_2 < 0 then
			arg_17_2 = -1 * arg_17_2
		end

		if arg_17_2 < 1000 then
			self.Listview:getChildByName("btn_ArenaLayer"):getChildByName("class_image"):getChildByName("Label_13"):setString(string.format("%04d", arg_17_2))
		else
			self.Listview:getChildByName("btn_ArenaLayer"):getChildByName("class_image"):getChildByName("Label_13"):setString(string.format("%04d", arg_17_2))
		end
	end
end

function CompetitionLayer:updateTftBtnLable()
	local var_18_0 = self.Listview:getChildByName("btn_ThreeVsThreeLayer")
	local var_18_1 = var_18_0:getChildByName("jump_btn")
	local var_18_2 = var_18_0:getChildByName("time")
	local var_18_3 = arenatft_manager:getSeasonLessTime()
	local var_18_4 = L_SEASON_END

	if arenatft_manager:getCurSeason() < 0 then
		var_18_4 = L_TVT_BEHAND_SEASON
	elseif var_18_3 > 0 then
		var_18_4 = L_SEASON_LESS_TIME .. var_0_20(var_18_3)
	end

	var_18_2:setPosition(cc.p(52, 235))
	var_18_2:setString(var_18_4)

	if self.tvtSprite then
		self.tvtSprite:update(arenatft_manager:getCurScore())
	else
		self.tvtSprite = TvTRankSprite:create(arenatft_manager:getCurScore())

		self.tvtSprite:setCascadeOpacityEnabled(true)
		self.tvtSprite:setName("tvTRankSprite")
		self.tvtSprite:setScale(0.35)
		self.tvtSprite:setPosition(cc.p(140, 45))
		var_18_1:addChild(self.tvtSprite)
	end
end

function CompetitionLayer.initNewAlertStatus(arg_19_0)
	return
end

function CompetitionLayer:updateBtnAlerts(arg_20_1)
	if not arg_20_1 or arg_20_1 == "-1" then
		return
	end

	if var_0_18[arg_20_1] then
		RoleDefault:getInstance():setBoolForKey(var_0_18[arg_20_1], true)
	end

	if arg_20_1 == "ScoreArenaLayer" then
		-- block empty
	elseif arg_20_1 == "ArenaLayer" then
		-- block empty
	end

	self:updateNewAlertStatus()
end

function CompetitionLayer.updateNewAlertStatus(arg_21_0)
	return
end

function CompetitionLayer:fullScreen(arg_22_1)
	arg_22_1:setContentSize((GameDisplay.getScreenSize()))
	arg_22_1:setPositionY(arg_22_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function CompetitionLayer.updateCompetionTimes(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		{
			max = 2,
			pos = cc.p(390, 20)
		},
		{
			max = 10,
			pos = cc.p(20, 20)
		},
		{
			max = 5,
			pos = cc.p(390, 60)
		}
	}

	if arg_23_1:getChildByName("jfsl") then
		arg_23_1:getChildByName("jfsl"):removeFromParent()
	end

	local var_23_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 20)

	var_23_1:setAnchorPoint(cc.p(0, 0))
	var_23_1:setName("jfsl")
	arg_23_1:addChild(var_23_1, 1000)
	var_23_1:setColor(var_0_19)
	var_23_1:enableOutline(cc.c4b(0, 0, 0, 255), 0.5)

	local var_23_2 = ccui.ImageView:create("CompetitionLayer/less_time.png", var_0_0)

	var_23_2:setName("jfslbg")
	arg_23_1:addChild(var_23_2, 99)
	var_23_2:setVisible(false)
	var_23_2:setScale(-1)

	if arg_23_2 == 1 then
		scorearena_manager:get_player_scorearena_data(function(arg_24_0)
			local var_24_9000

			if var_0_21 and arg_24_0 then
				if arg_24_0.refreshtime then
					arg_23_1:getChildByName("jfsl"):setString(string.format(L_QUICK_FIGHT.more, arg_24_0.refreshtime, var_23_0[arg_23_2].max))
					arg_23_1:getChildByName("jfsl"):setPosition(var_23_0[arg_23_2].pos)
					arg_23_1:getChildByName("jfslbg"):setPosition(cc.p(arg_23_1:getChildByName("jfsl"):getPositionX() + var_24_9000 + 8, arg_23_1:getChildByName("jfsl").getPositionY(arg_23_1:getChildByName("jfsl"):getContentSize().width / 2) + arg_23_1:getChildByName("jfsl"):getContentSize().height / 2))
					arg_23_1:getChildByName("jfslbg"):setVisible(true)
				else
					arg_23_1:getChildByName("jfsl"):setString("")
				end
			end
		end)
	elseif arg_23_2 == 2 then
		arena_manager:get_arena_daily_times(function(arg_25_0)
			local var_25_9000

			if var_0_21 and arg_25_0 then
				if arg_25_0.single then
					arg_23_1:getChildByName("jfsl"):setString(string.format(L_QUICK_FIGHT.more, var_23_0[arg_23_2].max - arg_25_0.single, var_23_0[arg_23_2].max))
					arg_23_1:getChildByName("jfsl"):setPosition(var_23_0[arg_23_2].pos)
					arg_23_1:getChildByName("jfslbg"):setPosition(cc.p(arg_23_1:getChildByName("jfsl"):getPositionX() + var_25_9000 + 8, arg_23_1:getChildByName("jfsl").getPositionY(arg_23_1:getChildByName("jfsl"):getContentSize().width / 2) + arg_23_1:getChildByName("jfsl"):getContentSize().height / 2))
					arg_23_1:getChildByName("jfslbg"):setVisible(true)
				else
					arg_23_1:getChildByName("jfsl"):setString("")
				end
			end
		end)
	elseif arg_23_2 == 3 then
		arenatft_manager:get_player_arenatft_info(function(arg_26_0)
			local var_26_9000

			if var_0_21 and arg_26_0 then
				if arg_26_0.daily_remain_count then
					arg_23_1:getChildByName("jfsl"):setString(string.format(L_QUICK_FIGHT.more_2, arg_26_0.daily_remain_count, arg_26_0.daily_total_count))
					arg_23_1:getChildByName("jfsl"):setPosition(var_23_0[arg_23_2].pos)
					arg_23_1:getChildByName("jfslbg"):setPosition(cc.p(arg_23_1:getChildByName("jfsl"):getPositionX() + var_26_9000 + 8, arg_23_1:getChildByName("jfsl").getPositionY(arg_23_1:getChildByName("jfsl"):getContentSize().width / 2) + arg_23_1:getChildByName("jfsl"):getContentSize().height / 2))
					arg_23_1:getChildByName("jfslbg"):setVisible(true)
				else
					arg_23_1:getChildByName("jfsl"):setString("")
				end
			end
		end)
	end
end
