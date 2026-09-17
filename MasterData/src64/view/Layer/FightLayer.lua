FightLayer = class("FightLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.PopLayer")
require("view.Sprite.ItemSprite")
require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Sprite.PlayerItem")
require("view.Layer.PublishnoticeLayer")

local TempWidget = require("view.Sprite.TempWidget")
local FightBuffPanel = require("view.Sprite.FightBuffPanel")
local RichTextPro = require("view.Sprite.RichTextPro")
local playermodel = require("model.playermodel")
local armature_manager = require("controller.armature_manager")
local level_manager = require("controller.level_manager")
local parse_server = require("controller.parse_server")
local audio_manager = require("controller.audio_manager")
local array_manager = require("controller.array_manager")
local monster_manager = require("controller.monster_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local aiattack_manager = require("controller.aiattack_manager")
local l2utils = require("controller.l2utils")
local barrage_manager = require("controller.barrage_manager")
local horcrux_manager = require("controller.horcrux_manager")
local item_manager = require("controller.item_manager")
local team_skill_manager = require("controller.team_skill_manager")
local activity_manager = require("controller.activity_manager")
local arenatft_manager = require("controller.arenatft_manager")
local community_system_manager = require("controller.community_system_manager")
local tower_defence_manager = require("controller.tower_defence_manager")
local bond_manager = require("controller.bond_manager")
local arena_manager = require("controller.arena_manager")
local birthday_party_manager = require("controller.birthday_party_manager")
local expedition_manager = require("controller.expedition_manager")
local photo_manager = require("controller.photo_manager")
local school_cinema_manager = require("controller.school_cinema_manager")
local friend_system_manager = require("controller.friend_system_manager")
local var_0_28 = require("controller.formation.formation_manager"):getInstance()
local test_fight_manager = require("controller.test_fight_manager")
local hexie_manager = require("controller.hexie_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_32 = require("controller.supermarket_limited_time_package_manager"):getInstance()
local task_manager = require("controller.task_manager")
local total_skill_data = require("data.total_skill_data")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local item_data = require("data.item_data")
local npc_data = require("data.npc_data")
local var_0_39 = require("data.item_data")
local battlefield_status_data = require("data.battlefield_status_data")
local activity_return_manager = require("controller.activity_return_manager")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local var_0_46 = config._DEBUG and 0 or 1
local var_0_47
local LocalEvent = require("common.LocalEvent")
local Utility = require("common.Utility")

AnalyticManager = require("controller.analysis_bridge")

local var_0_50 = 1
local var_0_51 = 2
local var_0_52 = 4
local var_0_53 = 8
local var_0_54 = 16
local var_0_55 = {
	"level_d.png",
	"level_c.png",
	"level_b.png",
	"level_a.png",
	"level_s.png"
}
local var_0_56 = {
	HANGUP = "FightLayer/fight_btn_search.png",
	COMPLETE = "FightLayer/fight_btn_search.png",
	LEVEL = "FightLayer/fight_btn_search.png",
	BOSS = "FightLayer/fight_btn_search.png"
}
local var_0_57 = "FightLayer/btn_auto.png"
local var_0_58 = "FightLayer/btn_auto_on.png"
local var_0_59 = "FightLayer/btn_speedup.png"
local var_0_60 = "FightLayer/btn_speedup_on.png"
local var_0_61 = {
	(cc.p(70, 210))
}

var_0_61[2] = cc.p(70 + (640 - 70 * 2) / 4 * 1, 210)
var_0_61[3] = cc.p(70 + (640 - 70 * 2) / 4 * 2, 210)
var_0_61[4] = cc.p(70 + (640 - 70 * 2) / 4 * 3, 210)
var_0_61[5] = cc.p(70 + (640 - 70 * 2) / 4 * 4, 210)

local var_0_62 = "FightLayer/battlefield_status_bg.png"
local var_0_63 = {
	"FightLayer/map_name_bg1.png",
	"FightLayer/map_name_bg2.png",
	"FightLayer/map_name_bg3.png",
	"FightLayer/map_name_bg4.png"
}
local var_0_64 = {
	cc.c3b(165, 186, 255),
	cc.c3b(191, 149, 255),
	cc.c3b(242, 114, 114),
	cc.c3b(231, 117, 117)
}
local var_0_65 = "FightLayer/big_boss_bg.png"
local var_0_66 = "FightLayer/big_boss_bg2.png"

function FightLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = FightLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function FightLayer.getInstance()
	return var_0_47
end

function FightLayer:init(arg_4_1)
	var_0_47 = self

	FightManager.attachConsole(self)

	self.showstat = nil
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "FightLayer.json" or "FightLayer.ExportJson")

	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer, 1)
	self.rootLayer:setTouchEnabled(false)
	self:initUI()
	self:initNewLevelModeListener()
	self:initPassLevelListener()
	self:initPassLevelAwardUI()
	activity_return_manager:get_game_buffs()
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.SHOW_LIMITTIME_PACKAGES, handler(self, self.handleShowLimittimePackages))
	self:initDownloadFightResourceListener()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_47 = nil

			LocalEvent:removeEvent(self)
			FightManager.detachConsole()
			FightManager.detachAllPlayerItems()

			if self.scheduler then
				for iter_5_0, iter_5_1 in pairs(self.scheduler) do
					time_check_manager:removeUpdatePool(iter_5_1)

					self.scheduler[iter_5_0] = nil
				end
			end
		end
	end)
	self:dealWithJumpToPanel(arg_4_1)
end

function FightLayer:testfunc()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		return
	end), cc.DelayTime:create(5), cc.CallFunc:create(function()
		return
	end)))
end

function FightLayer:testFightWorldMap()
	local var_9_0 = 500 / FightManager.getWorldMapSize()
	local var_9_1 = FightManager.getCamera().getBaseConfig()
	local var_9_2 = ccui.Layout:create()

	var_9_2:setContentSize(cc.size(500, 100))
	var_9_2:setTouchEnabled(false)
	var_9_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_2:setBackGroundColor(cc.c3b(255, 0, 0))
	var_9_2:setBackGroundColorOpacity(150)
	var_9_2:setPosition(cc.p(70, 900))
	self:addChild(var_9_2, 100)

	local var_9_3 = ccui.Layout:create()

	var_9_3:setContentSize(cc.size((var_9_1.bound.left + var_9_1.bound.right) * var_9_0, 100))
	var_9_3:setTouchEnabled(true)
	var_9_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_3:setBackGroundColor(cc.c3b(0, 255, 0))
	var_9_3:setBackGroundColorOpacity(150)
	var_9_3:setPosition(cc.p((FightManager.convertCameraToWorldSpace() - var_9_1.bound.left) * var_9_0, 0))
	var_9_2:addChild(var_9_3)

	local function var_9_4(arg_10_0)
		return arg_10_0 / var_9_0 + var_9_1.bound.left
	end

	local var_9_5 = false

	var_9_3:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 == ccui.TouchEventType.began then
			var_9_5 = true

			FightManager.getCamera().lockCameraManual(var_9_4(arg_11_0:getPositionX()))
		elseif arg_11_1 == ccui.TouchEventType.moved then
			var_9_5 = true

			local var_11_0 = var_9_2:convertToNodeSpace(arg_11_0:getTouchMovePosition())

			arg_11_0:setPositionX(var_11_0.x)
			FightManager.getCamera().lockCameraManual(var_9_4(var_11_0.x))
		else
			var_9_5 = false

			FightManager.getCamera().unlockCameraManual()
		end
	end)
	FightManager.registerWorldMapListener(var_9_3, function()
		if var_9_5 then
			return
		end

		var_9_3:setPosition(cc.p((FightManager.convertCameraToWorldSpace() - var_9_1.bound.left) * var_9_0, 0))
	end)
end

function FightLayer:initBarrage()
	self.barrage = require("view.Layer.BarrageLayer"):create()

	self.barrage:setName("barrageLayer")
	self.panelMap:addChild(self.barrage)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("changeTopRightPos", function(arg_14_0)
		self:adaptFightLayerTopRightPos()
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("onRegisterBarrage", function(arg_15_0)
		require("controller.barrage_manager"):registerRef(self.barrage)
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_16_0)
		if arg_16_0.id == L_ONCE_RECHARGE_NOVICE then
			self.btnNoviceRecharge:setVisible(false)
		elseif arg_16_0.id == L_ONCE_RECHARGE_BACK then
			self.btnBackRecharge:setVisible(false)

			self.btnBackRecharge.remain = self.btnBackRecharge.remain - 1
		end

		self:adaptFightLayerTopRightPos()
	end), self)
end

function FightLayer:initUnlockTipUI()
	local var_17_0 = ccui.ImageView:create("FightLayer/unlock_tip.png", var_0_46)

	self.panelMap:addChild(var_17_0)
	var_17_0:setPosition(cc.p(145, 340))

	local var_17_1 = RichTextPro:create()

	var_17_1:setSize(14)
	var_17_1:setFontName(FONT_NAME)
	var_17_0:addChild(var_17_1)
	var_17_1:setPosition(cc.p(10, var_17_0:getContentSize().height - 5))
	var_17_0:setScale(1.4)

	local function var_17_2()
		if not level_manager:isPlayerPassLevel(FIGHTLAYER_UNLOCK_TIPS_SHOWLEVEL) then
			var_17_0:setVisible(false)

			return
		end

		local var_18_0 = true

		for iter_18_0, iter_18_1 in ipairs(FIGHTLAYER_UNLOCK_TIPS) do
			if not level_manager:isPlayerPassLevel(iter_18_1.unlock_level) then
				var_17_1:clearText()
				var_17_1:setText(string.format("<p>通关<span style=color: rgb(197,226,253);>%s</span>解锁%s</p>", level_manager:formatSystemUnlockLevel(iter_18_1.unlock_level, true), iter_18_1.text))

				var_18_0 = false

				break
			end
		end

		var_17_0:setVisible(not var_18_0)
	end

	var_17_2()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("passLevel", function(arg_19_0)
		var_17_2()
	end), self)
end

function FightLayer:initNewLevelModeListener()
	self.newUnlockLevelMode = false

	self:registerCustomEvent("newUnlockMode", function()
		self.newUnlockLevelMode = true

		local var_21_0 = not not (level_manager:isPlayerPassLevel({
			chapter = 10,
			mode = 4
		}) and (friend_system_manager:isHaveFriends() or community_system_manager:getCurfamilyid()))

		self.chatsp:setVisible((hexie_manager:needHexieInput() or nil) and false)
	end)
end

function FightLayer:initPassLevelListener()
	self:registerCustomEvent("passLevel", handler(self, self.updatePlotViewBtn))
end

function FightLayer:onFirstCreate()
	self.panelMap:setVisible(false)
	self.panelConsole:setVisible(false)
	self:updateCurrentChapterInfo(true)

	if config._DEVELOP_MODE == "FIGHTDEV" then
		local var_23_0 = FightManager.getPlayerConf()

		for iter_23_0 = 1, 5 do
			self.playerItems[iter_23_0]:updatePlayerInfo(var_23_0[iter_23_0])
			FightManager.attachPlayerItem(iter_23_0, self.playerItems[iter_23_0])
		end

		self.panelConsole:setVisible(true)
		self.barrage:setVisible(false)
		self:switchToBossFight()
	else
		self.panelMap:setVisible(true)
		barrage_manager:resume()
	end

	FightManager:initFight()
end

local function var_0_67()
	local var_24_0 = ccui.Layout:create()

	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setTouchEnabled(true)
	var_24_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_0:setPosition(GameDisplay.width / 2, GameDisplay.height / 2)
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(15, 15, 15))
	var_24_0:setCascadeOpacityEnabled(false)
	var_24_0:setBackGroundColorOpacity(150)
	global_basic_scene:addChild(var_24_0, 100)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("fighteffect/anim_nextchapter.ExportJson")

	local var_24_1 = ccs.Armature:create("anim_nextchapter")

	var_24_1:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2))
	var_24_0:addChild(var_24_1)
	audio_manager:playeffectMusicTest("sound/open_newchapter_3")
	var_24_1:getAnimation():play("Animation1")
	var_24_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.25), cc.RemoveSelf:create()))
end

function FightLayer:onForeground(arg_25_1)
	audio_manager.infight = true

	if self.showstat == var_0_50 or self.showstat == var_0_54 then
		LayerManager:showTopBottomLayer({
			TopcostLayer = false,
			ListButtonLayer = false
		})
	else
		barrage_manager:resume()

		if self.newUnlockLevelMode then
			self.newUnlockLevelMode = false

			var_0_67()
		end
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	LayerManager:getPlotObj():fightlayerUpdatePlotRemind()
	self:dealWithJumpToPanel(arg_25_1)
	self:queryLimitRechargeInfos()

	local var_25_0 = not not (level_manager:isPlayerPassLevel({
		chapter = 10,
		mode = 4
	}) and (friend_system_manager:isHaveFriends() or community_system_manager:getCurfamilyid()))

	self.chatsp:setVisible((hexie_manager:needHexieInput() or nil) and false)
	self:updateOnlineRewardReddot()
	self:updateActivityEntranceBtn()
end

function FightLayer.dealWithJumpToPanel(arg_27_0, arg_27_1)
	if arg_27_1 and arg_27_1.jumpToBattleArray == true then
		audio_manager.infight = false

		var_0_28:pushFormationLayer("FormationMainLayer", {
			initindex = array_manager:getLevelArray(playermodel.curMode),
			initmode = playermodel.curMode,
			configtype = CONFIG_TYPE_HANGUP,
			exitcallback = function()
				audio_manager.infight = true
			end
		})
	end
end

function FightLayer.onBackground(arg_29_0)
	audio_manager.infight = false

	barrage_manager:stop()
	GuideListener.showAllGuides(true)
end

function FightLayer.checkGuideFightMode(arg_30_0)
	if config.open_guidefight and not playermodel.gameInitGuides[3] then
		LayerManager:showTopBottomLayer({
			ListButtonLayer = false,
			TopcostLayer = false
		})

		return true
	else
		return false
	end
end

function GetFightLayerFixOffsetY()
	return GameDisplay.fix_y * (1 - 150 / GameDisplay.origin_design_y)
end

function FightLayer:registerCustomEvent(arg_32_1, arg_32_2)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create(arg_32_1, arg_32_2), self)
end

function FightLayer:initUI()
	self.panelMap = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_map")
	self.panelConsole = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_console")
	self._touchlimit = false

	self:initControllButton()
	self:initPanelMap()
	self:initPanelConsole()
	self:initBattleFieldStatusInfoPanel()
	self:initPatrolUI()
	community_system_manager:get_family_data()
end

function FightLayer.checkAutoFight(arg_34_0)
	if RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false) then
		global_count_down_layer(4, function()
			arg_34_0:onFightCallBack(arg_34_0.btnFight, function()
				if level_manager:isPlayerPassLevel({
					mode = playermodel.curMode,
					chapter = level_manager:getCurChapter(playermodel.curMode)
				}) then
					arg_34_0:startReFightBoss()
				else
					arg_34_0:startFightBoss()
				end
			end)
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
			RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)
		end)
	end
end

function FightLayer:initPanelMap()
	self:initArrayPower()
	self:initDropCacheItem()
	self:initEnemyPreviewPanel()
	self:initModeName()
	self:initFightBtn()
	self:initPassLevelAwardUI()
	self:initMainLineTaskUI()
	self:initActivityEntranceBtn()
	self:initRecruitUI()
	self:initNoviceRecharegeIUI()
	self:initReturnBackRechargeUI()
	self:initPromotionRechargeUI()
	self:initPopReturnBackPacksUI()
	self:initNewRulesPacksUI()
	self:initBarrage()
	self:initUnlockTipUI()
	self:initOnlineRewardUI()
	self:adaptFightLayerTopRightPos()
	self:initAutoFightUI()
end

function FightLayer:initPanelConsole()
	self:initFightAutoMode()
	self:initPlayerItems()
	self:initFightSpeedUp()
	self:initFightStage()
	self:initHorcruxEffectPanel()
	self:initBuffPanel()
	self:registerCustomEvent("HideXPConsole", function()
		self.chatsp:setVisible(false)

		if self.showstat ~= var_0_50 then
			return
		end

		self.panelConsole:setVisible(false)
	end)
	self:registerCustomEvent("ShowXPConsole", function()
		local var_41_0 = not not (level_manager:isPlayerPassLevel({
			chapter = 10,
			mode = 4
		}) and (friend_system_manager:isHaveFriends() or community_system_manager:getCurfamilyid()))

		self.chatsp:setVisible((hexie_manager:needHexieInput() or nil) and false)

		if self.showstat ~= var_0_50 then
			return
		end

		self.panelConsole:setVisible(true)
	end)
end

function FightLayer:testPlayerItem()
	for iter_42_0, iter_42_1 in ipairs(var_0_61) do
		local var_42_0 = PlayerItem:create(iter_42_0)

		var_42_0:setPosition(iter_42_1)
		self.panelConsole:addChild(var_42_0, 10)
	end
end

function FightLayer:initControllButton()
	local function var_43_1(arg_52_0)
		if arg_52_0:getChildByName("lock_icon") then
			return
		end

		local var_52_0 = ccui.ImageView:create("public/button/fight_lock.png", var_0_46)

		var_52_0:setName("lock_icon")
		var_52_0:setVisible(false)
		var_52_0:setPosition(cc.p(arg_52_0:getContentSize().width - 10, arg_52_0:getContentSize().height - 10))
		arg_52_0:addChild(var_52_0)
	end

	for iter_43_0, iter_43_1 in pairs({
		{
			"btnStrength",
			"btn_strength",
			function(arg_44_0, arg_44_1)
				if arg_44_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("SoulStrengthLayer", {
					goto_bcak_system_id = 201
				})
			end
		},
		{
			"btnMap",
			"btn_map",
			function(arg_45_0, arg_45_1)
				if arg_45_1 ~= ccui.TouchEventType.ended then
					return
				end

				if FightManager.isBigBossFight() then
					return
				end

				if not level_manager:isPlayerPassLevel(UNLOCK_OTHER) then
					global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, (level_manager:formatSystemUnlockLevel(UNLOCK_OTHER))))

					return
				end

				if level_manager:isTalkLevel(playermodel.curMode) then
					LayerManager:switchShowLayer("LevelTalkMapLayer", {
						initcity = level_manager:getCityByMode(playermodel.curMode)
					})
				elseif level_manager:isBranchLevel(playermodel.curMode) then
					LayerManager:switchShowLayer("LevelMapBoxLayer")
				elseif level_manager:isSpecailLevel(playermodel.curMode) then
					LayerManager:switchShowLayer("SpecialOperationLayer")
				else
					LayerManager:switchShowLayer("LevelMapLayer")
				end

				AnalyticManager.entercitymap()
			end,
			nil,
			1.2
		},
		{
			"btnArray",
			"btn_array",
			function(arg_46_0, arg_46_1)
				local var_46_0

				if arg_46_1 ~= ccui.TouchEventType.ended then
					do return end

					var_46_0 = {}
				end

				var_46_0.initindex = array_manager:getLevelArray(playermodel.curMode)
				var_46_0.initmode = playermodel.curMode
				var_46_0.configtype = CONFIG_TYPE_HANGUP

				function var_46_0.exitcallback()
					audio_manager.infight = true
				end

				audio_manager.infight = false

				var_0_28:pushFormationLayer("FormationMainLayer", var_46_0)
			end
		},
		{
			"btnAuto",
			"btn_auto",
			function(arg_49_0, arg_49_1)
				if arg_49_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self._touchlimit then
					return
				end

				if FightManager.getFightType() == FIGHTTYPE_TOWER then
					return
				end

				if not self.autoflag then
					if not level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT) then
						global_ShowBlockWords(string.format(L_UNLOCK_AUTO_FIGHT, (level_manager:formatSystemUnlockLevel(UNLOCK_AUTO_FIGHT))))
						audio_manager:playeffectMusicTest("sound/invalid")

						return
					end

					self:updateFightAutoMode(true)
				else
					self:updateFightAutoMode(false)
				end
			end,
			UNLOCK_AUTO_FIGHT
		},
		{
			"btnSpeedup",
			"btn_speedup",
			function(arg_50_0, arg_50_1)
				if arg_50_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self.speedupFlag == 1 then
					self:updateFightSpeedUp(1.5)
				else
					self:updateFightSpeedUp(1)
				end
			end,
			UNLOCK_QUICK_FIGHT
		},
		{
			"btnPause",
			"btn_pause",
			function(arg_51_0, arg_51_1)
				if arg_51_1 ~= ccui.TouchEventType.ended then
					return
				end

				if self._touchlimit then
					return
				end

				if config._DEVELOP_MODE == "FIGHTDEV" then
					self:switchToBossFight((FightManager.getPlayerConf()))
					FightManager:resetTestFight()
				elseif FightManager.getFightType() == FIGHTTYPE_ARENA or FightManager.getFightType() == FIGHTTYPE_ARENATFT then
					FightManager.fightSurrender()
				else
					if FightManager.getFightState() ~= FIGHTSTATUS_FIGHTING then
						return
					end

					cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("main_line_auto_fight")))
					RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", false)
					self:showFightPauseLayer()
				end
			end
		}
	}) do
		self[iter_43_1[1]] = ccui.Helper:seekWidgetByName(self.rootLayer, iter_43_1[2])

		self[iter_43_1[1]]:setPressedActionEnabled(true)
		var_43_1(self[iter_43_1[1]])
		self[iter_43_1[1]]:setVisible(true)
		self[iter_43_1[1]]:addTouchEventListener(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_43_1[4] and not level_manager:isPlayerPassLevel(iter_43_1[4]) then
				global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(iter_43_1[4])))

				return
			end

			iter_43_1[3](arg_53_0, arg_53_1)
		end)

		if iter_43_1[4] then
			self[iter_43_1[1]]:getChildByName("lock_icon"):setVisible(not level_manager:isPlayerPassLevel(iter_43_1[4]))
		end

		if iter_43_1[5] then
			self[iter_43_1[1]]:setScale(iter_43_1[5])
		end
	end

	if AlertManager:checkAlertByID(ALERT_STRENGTHEN) then
		self:updateBtnStrength(true)
	end
end

function FightLayer:updateBtnStrength(arg_54_1)
	self.btnStrength:stopAllActions()

	if arg_54_1 then
		self.btnStrength:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(0, 16)), cc.MoveBy:create(0.075, cc.p(0, -24)), cc.MoveBy:create(0.025, cc.p(0, 8)), cc.DelayTime:create(0.1), cc.MoveBy:create(0.1, cc.p(0, 16)), cc.MoveBy:create(0.075, cc.p(0, -24)), cc.MoveBy:create(0.025, cc.p(0, 8)), cc.DelayTime:create(3))))
	end
end

function FightLayer:initArrayPower()
	self.arrayPower = self.btnArray:getChildByName("power")

	local function var_55_0(arg_56_0)
		self.arrayPower:setString(global_trans_number((fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData(playermodel.curArray)))))
	end

	self:registerCustomEvent("syncFightPower", var_55_0)
	var_55_0()
end

function FightLayer:initDropCacheItem()
	local var_57_0 = require("view.Sprite.DropCacheSprite"):create()

	var_57_0:setName("dropcache")
	var_57_0:setVisible(level_manager:isPlayerPassLevel(UNLOCK_EQUIPLAYER_COMPONENT))
	var_57_0:setPosition(cc.p(270, 226))
	self.panelMap:addChild(var_57_0, 3)

	self.dropcachesp = var_57_0

	local var_57_1 = require("view.Sprite.chatEntrySprite"):create()

	var_57_1:setName("chatEntrySP")
	self:addChild(var_57_1, 100000)

	self.chatsp = var_57_1

	community_system_manager:get_family_base_info(function(arg_58_0)
		local var_58_0 = not not (level_manager:isPlayerPassLevel({
			chapter = 10,
			mode = 4
		}) and (friend_system_manager:isHaveFriends() or community_system_manager:getCurfamilyid()))

		self.chatsp:setVisible((hexie_manager:needHexieInput() or nil) and false)
	end)
end

function FightLayer:initEnemyPreviewPanel()
	self.panelEnemies = self.panelMap:getChildByName("panel_enemy")

	self.panelEnemies:setVisible(true)
	self:initNormalBossPanel()
	self:initSmallBossPanel()
	self:initBigBossPanel()
end

function FightLayer:initNormalBossPanel()
	local var_60_0 = self.panelEnemies:getChildByName("panel_normalboss")

	function var_60_0:updateInfo(arg_61_1, arg_61_2)
		self._mode = arg_61_1
		self._level = arg_61_2

		self:updateBossID()
	end

	function var_60_0:updateBossID()
		local var_62_0 = monster_manager.getLevelBoss(self._mode, self._level)

		self._bossid = var_62_0 and var_62_0.majorlist.modelid or nil
	end

	function var_60_0:updateBoss()
		if not self._bossid then
			print("Can't Read BossID From ", self._mode, self._level)

			return
		end

		self:getChildByName("boss"):loadTexture(ROLE_HEAD_IMAGE_PATH .. model_data[self._bossid].head_image .. ".png")
	end

	function var_60_0:updateLevelWave()
		assert(self._mode and self._level, "Level Can't Be Nil")

		local var_64_1, var_64_2 = self._level:match("(%d+)-(%d+)")

		self:getChildByName("label_wave"):setString(string.format(L_FIGHTLAYER[1], tonumber(var_64_2), (level_manager:getChapterLevelNum(self._mode, tonumber(var_64_1)))))
	end

	self.panelNormalBoss = var_60_0
end

function FightLayer:initSmallBossPanel()
	local var_65_0 = self.panelEnemies:getChildByName("panel_smallboss")

	var_65_0:setTouchEnabled(true)
	var_65_0:addTouchEventListener(function(arg_66_0, arg_66_1)
		local var_66_0

		if arg_66_1 ~= ccui.TouchEventType.ended then
			do return end

			var_66_0 = {}
		end

		var_66_0.mode = playermodel.curMode
		var_66_0.chapter = level_manager:getCurChapter(playermodel.curMode)

		if level_manager:isPlayerPassLevel(var_66_0) then
			self:startReFightBoss()
		else
			self:startFightBoss()
		end
	end)

	function var_65_0.updateBossID(arg_67_0, arg_67_1)
		arg_67_0._bossid = arg_67_1
	end

	function var_65_0:updateBoss()
		assert(self._bossid, "Need BossID")
		self:getChildByName("boss"):loadTexture("role1/" .. model_data[self._bossid].cute_role .. ".png")
	end

	function var_65_0:updateBossRank()
		assert(self._bossid, "Need BossID")

		self._rank = model_data[self._bossid].monster_level

		self:getChildByName("img_lv"):loadTexture("FightLayer/" .. var_0_55[model_data[self._bossid].monster_level], var_0_46)
	end

	function var_65_0:getBossID()
		return self._bossid
	end

	function var_65_0:showOnNotPass()
		self:getChildByName("mask"):setVisible(true)
		self:getChildByName("img_fightagain"):setVisible(false)
	end

	function var_65_0:showOnPass()
		self:getChildByName("mask"):setVisible(false)
		self:getChildByName("img_fightagain"):setVisible(true)
	end

	self.panelSmallBoss = var_65_0
end

function FightLayer:initBigBossPanel()
	local var_73_0 = self.panelEnemies:getChildByName("panel_bigboss")
	local var_73_1 = L2Skeleton:create("spine/ui/boss.json", "spine/ui/boss.atlas")

	var_73_1:refreshSkeleton()
	var_73_1:setPosition(cc.p(50, 80))
	var_73_1:setName("bossani")
	var_73_1:setVisible(false)
	var_73_0:addChild(var_73_1, 2)
	var_73_1:registerListener(SP_ANIMATION_COMPLETE, function(arg_74_0)
		if arg_74_0.animation == "warning" then
			var_73_0:playBossEnterAni()
		elseif arg_74_0.animation == "bosschuxian" then
			var_73_1:setVisible(false)
		end
	end)
	var_73_0:setTouchEnabled(true)
	var_73_0:addTouchEventListener(function(arg_75_0, arg_75_1)
		local var_75_0

		if arg_75_1 ~= ccui.TouchEventType.ended then
			do return end

			var_75_0 = {}
		end

		var_75_0.mode = playermodel.curMode
		var_75_0.chapter = level_manager:getCurChapter(playermodel.curMode)

		if level_manager:isPlayerPassLevel(var_75_0) then
			self:startReFightBoss()
		else
			self:startFightBoss()
		end
	end)

	function var_73_0.updateBossID(arg_76_0, arg_76_1)
		arg_76_0._bossid = arg_76_1
	end

	function var_73_0:updateBoss()
		assert(self._bossid, "Need BossID")
		self:getChildByName("boss"):loadTexture(ROLE_IMAGE_PATH .. "bosspreview/" .. model_data[self._bossid].role_image .. ".png")
	end

	function var_73_0:updateBossRank()
		assert(self._bossid, "Need BossID")

		self._rank = model_data[self._bossid].monster_level

		self:getChildByName("img_lv"):loadTexture("FightLayer/" .. var_0_55[model_data[self._bossid].monster_level], var_0_46)
	end

	function var_73_0:playBossWarnAni()
		self:getChildByName("img_lv"):setVisible(false)
		self:getChildByName("boss"):setVisible(false)
		self:getChildByName("bg"):setVisible(false)
		self:getChildByName("img_lv"):setOpacity(0)
		self:getChildByName("boss"):setOpacity(0)
		self:getChildByName("bg"):setOpacity(0)
		self:getChildByName("bossani"):setVisible(true)
		self:getChildByName("bossani"):play("warning", false)
	end

	function var_73_0:playBossEnterAni()
		self:getChildByName("img_lv"):setVisible(false)
		self:getChildByName("boss"):setVisible(false)
		self:getChildByName("bg"):setVisible(false)
		self:getChildByName("img_lv"):setOpacity(0)
		self:getChildByName("boss"):setOpacity(0)
		self:getChildByName("bg"):setOpacity(0)

		local var_80_0 = cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.2))

		self:getChildByName("img_lv"):runAction(var_80_0:clone())
		self:getChildByName("boss"):runAction(var_80_0:clone())
		self:getChildByName("bg"):runAction(var_80_0:clone())
		self:getChildByName("bossani"):setVisible(true)
		self:getChildByName("bossani"):play("bosschuxian", false)
	end

	function var_73_0:getBossID()
		return self._bossid
	end

	function var_73_0:showOnNotPass()
		self:getChildByName("bg"):loadTexture(var_0_65, var_0_46)
		self:getChildByName("img_fightagain"):setVisible(false)
	end

	function var_73_0:showOnPass()
		self:getChildByName("bg"):loadTexture(var_0_66, var_0_46)
		self:getChildByName("img_fightagain"):setVisible(true)
	end

	self.panelBigBoss = var_73_0
end

function FightLayer:initModeName()
	self.chapterName = self.btnMap:getChildByName("img_map_name"):getChildByName("map_name")
	self.chapterBg = self.btnMap:getChildByName("img_map_name")

	if not self.plotViewBtn then
		self.plotViewBtn = TempWidget:CreateTempBtn("FightLayer/look_story_btn.png")

		self.btnMap:getParent():addChild(self.plotViewBtn)
		self.plotViewBtn:align(cc.p(0, 1), self.btnMap:getPositionX() + 40, self.btnMap:getPositionY() + 10)

		local function var_84_0()
			local var_85_0 = playermodel.curMode
			local var_85_2 = level_manager:getCurChapter(playermodel.curMode)

			if not level_manager:isPlayerPassLevel(playermodel.curMode .. "-" .. var_85_2) then
				global_ShowBlockWords(L_UNLOCK_PLOT)

				return
			end

			school_cinema_manager:init(function()
				local var_86_0 = school_cinema_manager:getCinemaInfo(3)
				local var_86_2
				local var_86_3

				for iter_86_0, iter_86_1 in pairs(var_86_0) do
					if type(iter_86_1) == "table" then
						local var_86_4 = false

						for iter_86_2 = #iter_86_1.list, 1, -1 do
							local var_86_5 = string.split(iter_86_1.list[iter_86_2].id, "#")

							if tostring(var_85_0) == var_86_5[1] and tostring(var_85_2) == string.split(var_86_5[2], "-")[1] then
								var_86_4 = true
								var_86_3 = iter_86_2

								break
							end
						end

						if var_86_4 then
							var_86_2 = iter_86_0

							break
						end
					end
				end

				if var_86_2 and var_86_3 then
					local var_86_6 = var_86_0[var_86_2].list[var_86_3]

					school_cinema_manager:doPlayerStoryPlot({
						index = 3,
						unlocklevel = var_86_0[var_86_2].list[var_86_3].id,
						dIndex = var_86_2,
						cIndex = var_86_3
					}, function()
						if var_86_6.pv then
							if DeviceManager.platform == "ios" or DeviceManager.platform == "android" then
								require("view.Layer.SchoolCinemaLayer")
								SchoolCinemaLayer:playPV("video/" .. var_86_6.pv .. ".mp4")
							else
								global_ShowBlockWords(L_PV_WARNING.Platform_Win32)
							end
						else
							require("view.Layer.TalkLayer")
							global_basic_scene:addChild(TalkLayer:create(var_86_6.classification, nil, TALK_TYPE_NORMAL, var_86_6.name), 5)
						end
					end)
				end
			end)
		end

		self.plotViewBtn:_addEvent(var_84_0, {
			touchDelay = 1
		})

		local var_84_1 = TempWidget:CreateTempLayout(self.plotViewBtn)

		var_84_1:setContentSize(cc.size(self.plotViewBtn:size().w, self.plotViewBtn:size().h + 15))
		var_84_1:align(cc.p(0.5, 0), self.plotViewBtn:size().w / 2, self.plotViewBtn:size().h)
		var_84_1:_addEvent(var_84_0, {
			touchDelay = 1
		})
		self:updatePlotViewBtn()
	end
end

function FightLayer:initFightBtn()
	self.btnFight = self.panelMap:getChildByName("btn_fight")

	function self.btnFight:updateOnComplete()
		self._stat = "complete"

		self:loadTextures(var_0_56.COMPLETE, nil, var_0_56.COMPLETE, var_0_46)
		self:getChildByName("ani"):play("xiayizhang")
	end

	function self.btnFight:updateOnHangup()
		self._stat = "hangup"

		self:loadTextures(var_0_56.HANGUP, nil, var_0_56.HANGUP, var_0_46)
		self:getChildByName("ani"):play("xiayiguan")
	end

	function self.btnFight:updateOnBoss()
		self._stat = "boss"

		self:loadTextures(var_0_56.BOSS, nil, var_0_56.BOSS, var_0_46)
		self:getChildByName("ani"):play("boss")
	end

	function self.btnFight:updateOnLevels()
		self._stat = "level"

		self:loadTextures(var_0_56.LEVEL, nil, var_0_56.LEVEL, var_0_46)
		self:getChildByName("ani"):play("xundi")
	end

	local var_88_0 = {
		complete = function(arg_93_0, arg_93_1)
			local var_93_0 = level_manager:getJumpNextMode(playermodel.curMode) or playermodel.curMode

			if var_93_0 and var_93_0 == -1 then
				var_93_0 = playermodel.curMode

				global_ShowBlockWords(L_NO_NEW_CHAPTER)
			end

			if level_manager:isModeManualLocked(var_93_0) then
				global_ShowBlockWords(level_manager:getModeName(var_93_0) .. L_NIGHTMARE_LOCK)

				return
			end

			if level_manager:isTalkLevel(playermodel.curMode) then
				LayerManager:switchShowLayer("LevelTalkMapLayer")
			elseif level_manager:isBranchLevel(playermodel.curMode) then
				self:gotoNextBranchLevelmode(arg_93_1)
			else
				self:goToNextCity(arg_93_1)
			end
		end,
		hangup = function(arg_94_0, arg_94_1)
			local var_94_0 = level_manager:getCurChapter(playermodel.curMode)

			if var_94_0 == level_manager:getUnlockChapter(playermodel.curMode) then
				self:unlockNextChapter(arg_94_1)
			elseif var_94_0 < level_manager:getUnlockChapter(playermodel.curMode) then
				self:goToNextChapter(arg_94_1)
			end
		end,
		boss = function(arg_95_0, arg_95_1)
			self:startFightBoss()
		end,
		level = function(arg_96_0, arg_96_1)
			return
		end
	}

	self.fightBtnEvent = var_88_0

	self.btnFight:addTouchEventListener(function(arg_97_0, arg_97_1)
		if arg_97_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._touchlimit then
			return
		end

		print("BtnFight: ", arg_97_0._stat)
		var_88_0[arg_97_0._stat](arg_97_0)
	end)

	local var_88_1 = L2Skeleton:create("spine/ui/uidongxiao.json", "spine/ui/uidongxiao.atlas")

	var_88_1:refreshSkeleton()
	var_88_1:setPosition(cc.p(self.btnFight:getContentSize().width / 2, 0))
	var_88_1:setName("ani")
	self.btnFight:addChild(var_88_1)
end

function FightLayer:initAutoFightUI()
	self.auto_fight_bg = self.panelMap:getChildByName("auto_fight_bg")
	self.auto_fight_on = self.panelMap:getChildByName("auto_fight_on")

	self.auto_fight_bg:setTouchEnabled(true)
	self.auto_fight_bg:addTouchEventListener(function(arg_99_0, arg_99_1)
		if arg_99_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isPlayerPassLevel(UNLOCK_FIGHT_AUTO) then
			global_ShowBlockWords(string.format("通关%s后解锁自动挑战", level_manager:formatSystemUnlockLevel(UNLOCK_FIGHT_AUTO)))

			return
		end

		local var_99_0 = not RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false)

		self.auto_fight_on:setVisible(var_99_0)
		AnalyticManager.clickAutoFight({
			autofight = var_99_0
		})
		RoleDefault:getInstance():setBoolForKey("MainLineAutoFight", var_99_0)
	end)
	self.auto_fight_on:setVisible((RoleDefault:getInstance():getBoolForKey("MainLineAutoFight", false)))
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("main_line_auto_fight", function(arg_100_0)
		self.auto_fight_on:setVisible(false)
	end), self)
end

function FightLayer:onFightCallBack(arg_101_1, arg_101_2)
	print(self._touchlimit, arg_101_1._stat, "ttttt")

	if self._touchlimit then
		return
	end

	print("BtnFight: ", arg_101_1._stat)
	self.fightBtnEvent[arg_101_1._stat](arg_101_1, arg_101_2)
end

local function var_0_68(arg_102_0)
	local var_102_0, var_102_1 = arg_102_0:match("(%d+)-(%d+)")

	return tonumber(var_102_0), tonumber(var_102_1)
end

function FightLayer:updateCurrentChapterInfo(arg_103_1, arg_103_2)
	local var_103_0 = playermodel.curMode
	local var_103_2 = level_manager:getCurChapter(playermodel.curMode)

	GlobalUpdateDropinfo(level_manager:getGoldDropSpeed() * 6, level_manager:getSpDropSpeed() * 6)

	local var_103_3 = level_manager:getModeName(var_103_0) .. level_manager:getChapterName(var_103_0, var_103_2)

	if playermodel.curMode < 401 then
		self.chapterName:setString("(" .. L_LEVEL_MODE_DIF[level_manager:getCurFightDifficulty()] .. ")" .. level_manager:getChapterName(var_103_0, var_103_2))
	else
		self.chapterName:setString(level_manager:getModeName(var_103_0) .. level_manager:getChapterName(var_103_0, var_103_2))
	end

	self.chapterBg:loadTexture(var_0_63[level_manager:getDifficultByMode(var_103_0)], var_0_46)
	self.chapterName:setColor(var_0_64[level_manager:getDifficultByMode(var_103_0)])
	level_manager:get_cur_activity_hangup_conf_client(var_103_0, var_103_2, function(arg_104_0)
		LayerManager:getUIElement("TopcostLayer"):checkActivityHangupInfo(arg_104_0)
	end)
	self:showFightMap(false)

	if not arg_103_1 then
		self:refreshGuidesOnFight()
	end

	self:updatePassLevelAwardButton()
	self:updateMainLineTaskUI()
	self.barrage:setVisible(level_manager:isPlayerPassLevel("1-5"))

	if hexie_manager:needHexieInput() then
		self.barrage:setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "patrolPopBnt"):setVisible(level_manager:isPlayerPassLevel("2-5"))
	self:updatePlotViewBtn()

	if arg_103_2 then
		arg_103_2()
	end
end

function FightLayer:updatePlotViewBtn()
	local var_105_0 = playermodel.curMode
	local var_105_2 = level_manager:getCurChapter(playermodel.curMode)

	self.plotViewBtn:hide()

	if not level_manager:isPlayerPassLevel(var_105_0 .. "-" .. var_105_2) or level_manager:getDifficultByMode(playermodel.curMode) ~= 1 then
		self.plotViewBtn:loadTextureNormal("FightLayer/unlock_story_btn.png", var_0_46)
	else
		self.plotViewBtn:loadTextureNormal("FightLayer/look_story_btn.png", var_0_46)
	end

	if photo_manager:checkHaveDataByModeAndChapter(var_105_0, var_105_2) then
		self.plotViewBtn:show()
		self.chapterBg:setPositionY(60)
	else
		self.chapterBg:setPositionY(40)
	end

	if self.btn_recruit then
		self.btn_recruit:setColor(level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) and cc.c3b(255, 255, 255) or cc.c3b(155, 155, 155))
		self.btn_recruit:setVisible(level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT))
		self.btn_recruit:getChildByName("lock_icon"):setVisible(not level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT))
		self.panelMap:getChildByName("recruit_entrance_tipText"):setVisible(not level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) and level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT))
		self:adaptFightLayerTopRightPos()
	end

	if self.btnNoviceRecharge then
		self.btnNoviceRecharge:setVisible(playermodel.create_time + 86400 - time_check_manager:getCurTime() > 0 and not RoleDefault:getInstance():getBoolForKey("recharege" .. L_ONCE_RECHARGE_NOVICE, false))
		self:adaptFightLayerTopRightPos()
	end

	if self.btnBackRecharge then
		require("network.network"):rpc("get_recharge_info", {
			client = config.clientmode,
			types = {
				111
			}
		}, function(arg_106_0)
			if arg_106_0.result == 1 then
				if arg_106_0.products and arg_106_0.products[1] then
					self.btnBackRecharge.finishtime = arg_106_0.products[1].finishtime
					self.btnBackRecharge.remain = arg_106_0.products[1].buy_limit - arg_106_0.products[1].have_bought

					self.btnBackRecharge:setVisible(arg_106_0.products[1].buy_limit > arg_106_0.products[1].have_bought)
				else
					self.btnBackRecharge:setVisible(false)
				end

				self:adaptFightLayerTopRightPos()
			end
		end)
	end

	if self.passLevelAwardBtn then
		self.passLevelAwardBtn:setVisible(level_manager:isPlayerPassLevel(UNLOCK_PASSLEVEL_AWARD))
	end

	self.dropcachesp:setVisible(level_manager:isPlayerPassLevel(UNLOCK_EQUIPLAYER_COMPONENT))
end

function FightLayer:showFightMap(arg_107_1)
	local var_107_0 = level_manager:getCurChapter(playermodel.curMode)

	if level_manager:isChapterPass(playermodel.curMode, var_107_0) then
		if level_manager:isLevelModeComplete(playermodel.curMode, var_107_0) then
			self:showFightMapForComplete(arg_107_1)
		else
			self:showFightMapForHangup(arg_107_1)
		end

		self.showstat = var_0_53
	elseif level_manager:isUnlockBigBoss(playermodel.curMode, var_107_0) then
		self:showFightMapForBoss(arg_107_1)

		self.showstat = var_0_52
	else
		self:showFightMapForLevels()

		self.showstat = var_0_51
	end
end

function FightLayer:showFightMapForComplete(arg_108_1)
	self.panelNormalBoss:setVisible(false)
	self.btnFight:updateOnComplete()

	local var_108_0 = monster_manager.getChapterBigBoss(playermodel.curMode .. "-" .. level_manager:getCurChapter(playermodel.curMode)).majorlist.modelid

	if model_data[var_108_0].role_image then
		if cc.FileUtils:getInstance():isFileExist(ROLE_IMAGE_PATH .. "bosspreview/" .. model_data[var_108_0].role_image .. ".png") then
			self:showFightMapForBigBossComplete(var_108_0)

			goto label_108_0
		end
	end

	self:showFightMapForSmallBossComplete(var_108_0)

	::label_108_0::

	if arg_108_1 then
		GuideListener.triggerGuide(TRIGGER_PASSLEVEL)
	end
end

function FightLayer:showFightMapForBigBossComplete(arg_109_1)
	self.panelSmallBoss:updateBossID(arg_109_1)
	self.panelSmallBoss:setVisible(false)
	self.panelBigBoss:updateBossID(arg_109_1)
	self.panelBigBoss:setVisible(true)
	self.panelBigBoss:updateBoss()
	self.panelBigBoss:updateBossRank()
	self.panelBigBoss:showOnPass()
end

function FightLayer:showFightMapForSmallBossComplete(arg_110_1)
	self.panelSmallBoss:updateBossID(arg_110_1)
	self.panelSmallBoss:setVisible(true)
	self.panelBigBoss:updateBossID(arg_110_1)
	self.panelBigBoss:setVisible(false)
	self.panelSmallBoss:updateBoss()
	self.panelSmallBoss:updateBossRank()
	self.panelSmallBoss:showOnPass()
end

function FightLayer:showFightMapForHangup(arg_111_1)
	self.panelNormalBoss:setVisible(false)
	self.btnFight:updateOnHangup()

	local var_111_0 = monster_manager.getChapterBigBoss(playermodel.curMode .. "-" .. level_manager:getCurChapter(playermodel.curMode)).majorlist.modelid

	if model_data[var_111_0].role_image then
		if cc.FileUtils:getInstance():isFileExist(ROLE_IMAGE_PATH .. "bosspreview/" .. model_data[var_111_0].role_image .. ".png") then
			self:showFightMapForBigBossComplete(var_111_0)

			goto label_111_0
		end
	end

	self:showFightMapForSmallBossComplete(var_111_0)

	::label_111_0::

	if arg_111_1 then
		GuideListener.triggerGuide(TRIGGER_PASSLEVEL)
	end
end

function FightLayer:showFightMapForBoss(arg_112_1)
	self.panelNormalBoss:setVisible(false)
	self.btnFight:updateOnBoss()

	local var_112_0 = level_manager:getCurChapter(playermodel.curMode)
	local var_112_1 = monster_manager.getChapterBigBoss(playermodel.curMode .. "-" .. var_112_0)

	hx_print(playermodel.curMode .. "-" .. var_112_0)

	if model_data[var_112_1.majorlist.modelid].role_image then
		if cc.FileUtils:getInstance():isFileExist(ROLE_IMAGE_PATH .. "bosspreview/" .. model_data[var_112_1.majorlist.modelid].role_image .. ".png") then
			self:showFightMapForBigBoss(var_112_1.majorlist.modelid, arg_112_1)

			goto label_112_0
		end
	end

	self:showFightMapForSmallBoss(var_112_1.majorlist.modelid, arg_112_1)

	::label_112_0::
end

function FightLayer:showFightMapForBigBoss(arg_113_1, arg_113_2)
	self.panelSmallBoss:updateBossID(arg_113_1)
	self.panelSmallBoss:setVisible(false)
	self.panelBigBoss:updateBossID(arg_113_1)
	self.panelBigBoss:setVisible(true)
	self.panelBigBoss:updateBoss()
	self.panelBigBoss:updateBossRank()
	self.panelBigBoss:showOnNotPass()

	if arg_113_2 then
		self.panelBigBoss:playBossEnterAni()
	end
end

function FightLayer:showFightMapForSmallBoss(arg_114_1, arg_114_2)
	self.panelSmallBoss:updateBossID(arg_114_1)
	self.panelSmallBoss:setVisible(true)
	self.panelBigBoss:updateBossID(arg_114_1)
	self.panelBigBoss:setVisible(false)
	self.panelSmallBoss:updateBoss()
	self.panelSmallBoss:updateBossRank()
	self.panelSmallBoss:showOnNotPass()
end

function FightLayer:showFightMapForLevels()
	self.panelSmallBoss:setVisible(false)
	self.panelBigBoss:setVisible(false)
	self.panelNormalBoss:setVisible(true)
	self.btnFight:updateOnLevels()
	self.panelNormalBoss:updateInfo(playermodel.curMode, playermodel.curLevel)
	self.panelNormalBoss:updateBoss()
	self.panelNormalBoss:updateLevelWave()
end

function FightLayer:onFindBigBoss()
	self:showFightMap(true)
	self:refreshGuidesOnFight()
	GuideListener.triggerGuide(TRIGGER_PASSBEFOREBOSS)
end

function FightLayer:onPassNormalBoss()
	self.panelNormalBoss:updateInfo(playermodel.curMode, playermodel.curLevel)
	self.panelNormalBoss:updateBoss()
	self.panelNormalBoss:updateLevelWave()
end

function FightLayer:initFightAutoMode()
	self.autoflag = RoleDefault:getInstance():getBoolForKey("fightauto", false)

	if not level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT) then
		self.autoflag = false

		RoleDefault:getInstance():setBoolForKey("fightauto", self.autoflag)
		self.btnSpeedup:getChildByName("lock_icon"):setVisible(true)
	end

	playermodel.autoXP = self.autoflag

	self:updateFightAutoModeAction(self.autoflag)
end

function FightLayer:updateFightAutoMode(arg_119_1)
	if arg_119_1 == self.autoflag then
		return
	end

	self.autoflag = arg_119_1
	playermodel.autoXP = arg_119_1

	RoleDefault:getInstance():setBoolForKey("fightauto", arg_119_1)
	self:updateFightAutoModeAction(arg_119_1)
end

function FightLayer:updateFightAutoModeAction(arg_120_1)
	if arg_120_1 then
		self.btnAuto:loadTextures(var_0_58, var_0_58, var_0_58, var_0_46)
	else
		self.btnAuto:loadTextures(var_0_57, var_0_58, var_0_57, var_0_46)
	end
end

function FightLayer:initFightSpeedUp()
	self.speedupFlag = FightManager.getBossSpeedUpForce()

	self:updateFightSpeedUpAction(self.speedupFlag)
end

function FightLayer:updateFightSpeedUp(arg_122_1)
	if self.speedupFlag == arg_122_1 then
		return
	end

	FightManager.setBossSpeedUp(arg_122_1)

	self.speedupFlag = arg_122_1

	self:updateFightSpeedUpAction(arg_122_1)
end

function FightLayer:updateFightSpeedUpAction(arg_123_1)
	if arg_123_1 == 1 then
		self.btnSpeedup:loadTextures(var_0_59, var_0_59, var_0_59, var_0_46)
	else
		self.btnSpeedup:loadTextures(var_0_60, var_0_60, var_0_60, var_0_46)
	end
end

local var_0_69 = {
	cc.p(320, 380),
	cc.p(200, 380)
}
local var_0_70 = {
	"130%",
	"150%",
	"200%",
	"500%",
	"1000%"
}
local var_0_71 = setmetatable({
	cc.c3b(227, 245, 255),
	cc.c3b(233, 227, 255),
	cc.c3b(255, 227, 247)
}, {
	__index = function()
		return cc.c3b(255, 227, 247)
	end
})
local var_0_72 = setmetatable({
	"FightLayer/fight_stage1.png",
	"FightLayer/fight_stage2.png",
	"FightLayer/fight_stage3.png"
}, {
	__index = function()
		return "FightLayer/fight_stage3.png"
	end
})

function FightLayer:initFightStage()
	local var_126_0 = self.panelConsole:getChildByName("panel_fighttime")

	var_126_0:getChildByName("label_time"):setPosition(var_0_69[1])
	var_126_0:getChildByName("img_stage"):setPositionY(380)

	function var_126_0:reset()
		self:getChildByName("label_time"):setPosition(var_0_69[1])
		self:getChildByName("label_time"):setString("")
		self:getChildByName("label_time"):setFontSize(30)
		self:getChildByName("label_time"):disableEffect()
		self:getChildByName("label_time"):setRotation(0)
		self:getChildByName("label_time"):setColor(cc.c3b(255, 255, 255))
		self:getChildByName("img_stage"):setVisible(false)
	end

	function var_126_0:showDamageAddition()
		self:getChildByName("label_time"):setPosition(var_0_69[2])
		self:getChildByName("img_stage"):setVisible(true)
		self:getChildByName("img_stage"):loadTexture(var_0_72[1], var_0_46)
		self:getChildByName("img_stage"):getChildByName("label_damageaddition"):setString(string.format(L_FIGHT_STAGE, 1, var_0_70[1]))
		self:getChildByName("img_stage"):getChildByName("label_damageaddition"):setColor(var_0_71[1])
	end

	function var_126_0:hideDamageAddition()
		self:getChildByName("label_time"):setPosition(var_0_69[1])
		self:getChildByName("img_stage"):setVisible(false)
	end

	function var_126_0:switchDamageAddition(arg_130_1)
		self:getChildByName("label_time"):setPosition(var_0_69[2])
		self:getChildByName("img_stage"):setVisible(true)
		self:getChildByName("img_stage"):loadTexture(var_0_72[arg_130_1 - 1], var_0_46)
		self:getChildByName("img_stage"):getChildByName("label_damageaddition"):setString(string.format(L_FIGHT_STAGE, arg_130_1 - 1, var_0_70[arg_130_1 - 1]))
		self:getChildByName("img_stage"):getChildByName("label_damageaddition"):setColor(var_0_71[arg_130_1 - 1])
	end

	function var_126_0:updateDamageAddition(arg_131_1)
		if arg_131_1 == 1 then
			self:hideDamageAddition()
		elseif arg_131_1 == 2 then
			self:showDamageAddition()
		else
			self:switchDamageAddition(arg_131_1)
		end
	end

	local function var_126_1(arg_132_0)
		return string.format("%02d:%02d", math.fmod(math.floor(arg_132_0 / 60), 60), (math.fmod(arg_132_0, 60)))
	end

	function var_126_0:updateTime(arg_133_1)
		if arg_133_1 < 0 then
			arg_133_1 = -arg_133_1

			if arg_133_1 <= 10 then
				self:getChildByName("label_time"):setColor(cc.c3b(255, 0, 0))
				self:getChildByName("label_time"):setString(var_126_1(arg_133_1))
			else
				self:getChildByName("label_time"):setColor(cc.c3b(255, 255, 255))
				self:getChildByName("label_time"):setString(var_126_1(arg_133_1))
			end
		else
			self:getChildByName("label_time"):setString(var_126_1(arg_133_1))
		end
	end

	self.panelFightTime = var_126_0
end

function FightLayer:initPlayerItems()
	self.playerItems = {}

	for iter_134_0, iter_134_1 in ipairs(var_0_61) do
		self.playerItems[iter_134_0] = PlayerItem:create(iter_134_0)

		self.playerItems[iter_134_0]:setPosition(iter_134_1)
		self.panelConsole:addChild(self.playerItems[iter_134_0], 5)
	end
end

function FightLayer:updateConsoleUIByFightType()
	if FightManager.getFightType() == FIGHTTYPE_ARENA or FightManager.getFightType() == FIGHTTYPE_ARENATFT then
		self.btnPause:loadTextures("FightLayer/fight_btn_surrender2.png", "FightLayer/fight_btn_surrender2.png", "FightLayer/fight_btn_surrender2.png", var_0_46)
	else
		self.btnPause:loadTextures("FightLayer/fight_btn_pause.png", "FightLayer/fight_btn_pause.png", "FightLayer/fight_btn_pause.png", var_0_46)
	end

	if FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION then
		-- block empty
	end

	if FightManager.getFightType() == FIGHTTYPE_INFINITE then
		self:updateInfinteTimePanel((require("controller.infinite_fight_manager"):get_remain_time()))

		if self.infinteTimePanel then
			self.infinteTimePanel:setVisible(true)
		end
	elseif FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION then
		timeinit = require("controller.substitution_manager"):get_remain_time()

		self:updateInfinteTimePanel(timeinit)

		if self.infinteTimePanel then
			self.infinteTimePanel:setVisible(true)
		end
	elseif self.infinteTimePanel then
		self.infinteTimePanel:setVisible(false)
	end

	;(function()
		if self.panelConsole:getChildByName("towerListPanel") then
			self.panelConsole:getChildByName("towerListPanel"):removeFromParent()

			self.towerDefencePanel = nil
			self.expeditionTowerPanel = nil
		end
	end)()

	if FightManager.getFightType() == FIGHTTYPE_TOWER then
		self:resetTowerDefencePanel()

		if self.towerDefencePanel then
			self.towerDefencePanel:setVisible(true)
		end

		for iter_135_0, iter_135_1 in pairs(self.playerItems) do
			iter_135_1:setVisible(false)
		end

		self.panelConsole:getChildByName("panelbg"):loadTexture("TowerDefenceListPanel/panelbg.png", var_0_46)

		local var_135_0 = self.panelConsole:getChildByName("panel_fighttime"):getChildByName("label_time")

		var_135_0:setFontSize(24)

		var_0_69[1] = cc.p(60, 360)

		var_135_0:setRotation(2)
		var_135_0:enableShadow(cc.c4b(100, 100, 100, 90), cc.size(3, -3))
	elseif FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER then
		self:resetExpeditionTowerPanel()

		if self.expeditionTowerPanel then
			self.expeditionTowerPanel:setVisible(true)
		end

		for iter_135_2, iter_135_3 in pairs(self.playerItems) do
			iter_135_3:setVisible(false)
		end

		self.panelConsole:getChildByName("panelbg"):loadTexture("TowerDefenceListPanel/panelbg.png", var_0_46)

		local var_135_1 = self.panelConsole:getChildByName("panel_fighttime"):getChildByName("label_time")

		var_135_1:setFontSize(24)

		var_0_69[1] = cc.p(60, 360)

		var_135_1:setRotation(2)
		var_135_1:enableShadow(cc.c4b(100, 100, 100, 90), cc.size(3, -3))
	else
		var_0_69[1] = cc.p(320, 380)

		if self.towerDefencePanel then
			self.towerDefencePanel:setVisible(false)
		end

		if self.expeditionTowerPanel then
			self.expeditionTowerPanel:setVisible(false)
		end

		for iter_135_4, iter_135_5 in pairs(self.playerItems) do
			iter_135_5:setVisible(true)
		end

		self.panelConsole:getChildByName("panelbg"):loadTexture("FightLayer/fight_console_bg.png", var_0_46)
	end
end

function FightLayer:onBtnTeamCallback()
	self:dealWithJumpToPanel({
		jumpToBattleArray = true
	})
end

function FightLayer:startFight()
	local var_139_0 = level_manager:getCurChapter(playermodel.curMode)

	if level_manager:isPlayerPassLevel({
		mode = playermodel.curMode,
		chapter = var_139_0
	}) then
		self:startReFightBoss()
	else
		LayerManager:getUIElement("TopcostLayer"):setTouchLock(false)
		LayerManager:getUIElement("ListButton"):setTouchLock(false)
		require("controller.autopop_manager"):pauseAchievementPop()
		parse_server:onFightBigBoss(playermodel.curMode, var_139_0, array_manager.last_refight_array)
		FightManager.startFightBigBoss()

		local var_139_1 = {
			mode_chapter = playermodel.curMode .. "-" .. var_139_0,
			speedup = tostring(FightManager.getBossSpeedUpForce()),
			autoxp = playermodel.autoXP and "Yes" or "No"
		}

		array_manager:getHangupInfoForAnalytic(var_139_1)
		AnalyticManager.fightBigBoss(var_139_1)
	end
end

function FightLayer.startFightBoss(arg_140_0)
	if not FightManager.isNormalFight() then
		return
	end

	if FightManager.isBigBossFight() then
		return
	end

	local var_140_0 = playermodel.curMode
	local var_140_1 = level_manager:getCurChapter(playermodel.curMode)

	if level_manager:isChapterPass(playermodel.curMode, var_140_1) or not level_manager:isUnlockBigBoss(var_140_0, var_140_1) then
		return
	end

	local function var_140_2()
		LayerManager:getUIElement("TopcostLayer"):setTouchLock(false)
		LayerManager:getUIElement("ListButton"):setTouchLock(false)
		require("controller.autopop_manager"):pauseAchievementPop()
		parse_server:onFightBigBoss(var_140_0, var_140_1, array_manager.last_refight_array)
		FightManager.startFightBigBoss()

		local var_141_0 = {
			mode_chapter = var_140_0 .. "-" .. var_140_1,
			speedup = tostring(FightManager.getBossSpeedUpForce()),
			autoxp = playermodel.autoXP and "Yes" or "No"
		}

		array_manager:getHangupInfoForAnalytic(var_141_0)
		print(dump(var_141_0))
		AnalyticManager.fightBigBoss(var_141_0)
	end

	if var_140_0 ~= 1 then
		var_140_2()
	else
		var_140_2()
	end

	AnalyticManager.clickFightBoss({
		mode_chapter = var_140_0 .. "-" .. var_140_1
	})
end

function FightLayer.startReFightBoss(arg_142_0)
	local function var_142_0(arg_143_0)
		LayerManager:getUIElement("TopcostLayer"):setTouchLock(false)
		LayerManager:getUIElement("ListButton"):setTouchLock(false)
		require("controller.autopop_manager"):pauseAchievementPop()
		FightManager.startRefightBigBoss()
		parse_server:onFightBigBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode), arg_143_0)
	end

	;(function(arg_144_0)
		var_0_28:pushFormationLayer("FormationMainLayer", {
			repeatChallenge = true,
			configtype = CONFIG_TYPE_REFIGHT,
			configcallback = var_142_0,
			isAuto = arg_144_0
		})
	end)()
end

function FightLayer:goToNextCity(arg_145_1)
	local var_145_0 = level_manager:getJumpNextMode(playermodel.curMode) or playermodel.curMode

	if var_145_0 and var_145_0 == -1 then
		var_145_0 = playermodel.curMode

		global_ShowBlockWords(L_NO_NEW_CHAPTER)
	end

	if level_manager:isTalkLevel(playermodel.curMode) then
		LayerManager:switchShowLayer("LevelTalkMapLayer", {
			initcity = level_manager:getCityByMode(playermodel.curMode)
		})

		return
	end

	if level_manager:isBranchLevel(playermodel.curMode) then
		LayerManager:switchShowLayer("LevelMapBoxLayer")
		self:switchToMap(playermodel.curMode)

		return
	end

	if playermodel.curMode == var_145_0 then
		LayerManager:switchShowLayer("LevelMapLayer", {
			initcity = level_manager:getCityByMode(var_145_0),
			initdifficulty = level_manager:getDifficultByMode(var_145_0)
		})
	else
		local var_145_1 = level_manager:getCityByMode(var_145_0)

		if not level_manager:isCityUnlocked(var_145_1) then
			level_manager:unlockCity(var_145_1, function()
				audio_manager:playeffectMusic(CITY_UNLOCK_EFFECT)
				FightManager.changeChapter()

				if arg_145_1 then
					arg_145_1()
				end
			end)
		else
			self._touchlimit = true

			level_manager:selectChapter(var_145_0, level_manager:getCurChapter(var_145_0), function(arg_147_0)
				if arg_147_0 == 1 then
					audio_manager:playeffectMusicTest("sound/switch_chapter")
					FightManager.changeChapter()

					if arg_145_1 then
						arg_145_1()
					end
				end

				self._touchlimit = false
			end)
		end
	end
end

function FightLayer.gotoNextBranchLevelmode(arg_148_0, arg_148_1)
	local var_148_0 = level_manager:getJumpNextMode(playermodel.curMode) or playermodel.curMode

	if var_148_0 and var_148_0 == -1 then
		LayerManager:switchShowLayer("LevelMapBoxLayer")
	else
		arg_148_0._touchlimit = true

		level_manager:selectChapter(var_148_0, level_manager:getCurChapter(var_148_0), function(arg_149_0)
			if arg_149_0 == 1 then
				audio_manager:playeffectMusicTest("sound/switch_chapter")
				FightManager.changeChapter()

				if arg_148_1 then
					arg_148_1()
				end
			end

			arg_148_0._touchlimit = false
		end)
	end
end

function FightLayer.unlockNextChapter(arg_150_0, arg_150_1)
	if not FightManager.canSwitchFight() then
		return
	end

	local var_150_0 = playermodel.curMode

	if level_manager:getCurChapter(playermodel.curMode) >= level_manager:getModeTotalChapter(playermodel.curMode) then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(L_FIGHT_NEXT_CHAPTER.End)

		return
	end

	if not level_manager:isChapterModeValid(var_150_0, playermodel.levelmode[var_150_0].status) then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(L_FIGHT_NEXT_CHAPTER.Next_Lock)

		return
	end

	arg_150_0._touchlimit = true

	parse_server:unlockNextChapter(playermodel.curMode, playermodel.curLevel, function(arg_151_0)
		if arg_151_0 == 1 then
			if not FightManager.isNormalFight() then
				arg_150_0._touchlimit = false

				return
			end

			local function var_151_0()
				FightManager.openFight(function()
					require("fight.FightEventManager"):triggerFightEventListener(FIGHT_LISTENER_ON_JOINCHAPTER, function()
						arg_150_0:updateCurrentChapterInfo()
						GuideListener.triggerGuide(TRIGGER_PASSLEVEL)
						GuideListener.triggerGuide(TRIGGER_UNLOCKCHAPTER)

						arg_150_0._touchlimit = false

						barrage_manager:reset(level_manager:getCurFightChapter())
						barrage_manager:resume()
						arg_150_0:updatePassLevelAwardButton()
						arg_150_0:updateMainLineTaskUI()

						if arg_150_1 then
							arg_150_1()
						end
					end)
				end)
			end

			barrage_manager:stop()
			FightManager.closeFight(var_151_0)
		else
			arg_150_0._touchlimit = false
		end
	end)
end

function FightLayer.goToNextChapter(arg_155_0, arg_155_1)
	if not FightManager.canSwitchFight() then
		return
	end

	arg_155_0._touchlimit = true

	level_manager:selectChapter(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode) + 1, function(arg_156_0)
		if arg_156_0 == 1 then
			if not FightManager.isNormalFight() then
				arg_155_0._touchlimit = false

				return
			end

			FightManager.changeChapter(arg_155_1)
		else
			arg_155_0._touchlimit = false
		end
	end)
end

function FightLayer.chapterSettlement(arg_157_0, arg_157_1, arg_157_2)
	local var_157_0, var_157_1 = var_0_68(arg_157_1.level)
	local var_157_2 = level_manager:getModeName(arg_157_1.mode)

	function arg_157_1.cancelcallback(arg_158_0, arg_158_1)
		if arg_157_2 then
			arg_157_2(arg_158_0, arg_158_1)
		end
	end

	arg_157_1.showText = level_manager:getChapterName(arg_157_1.mode, var_157_0)

	if FightManager.isBigBossRefight() then
		arg_157_1.isrefight = true
	end

	LayerManager:pushInLayer("PopMainLineResultLayer", arg_157_1)
end

function FightLayer:initBattleFieldStatusInfoPanel()
	if self.battlefieldStatusInfo then
		return
	end

	self.battlefieldStatusInfo = cc.Node:create()

	self.battlefieldStatusInfo:setPosition(cc.p(0, 520))

	self.battlefieldStatusInfo.curchapter = nil

	self.panelConsole:addChild(self.battlefieldStatusInfo, 10)
	self:registerCustomEvent("UPDATE_BATTLEFIELD_INFO", function(arg_160_0)
		if not arg_160_0.mode or not arg_160_0.chapter then
			return
		end

		self:updateChapterBattleFieldStatusInfo(arg_160_0.mode, arg_160_0.chapter)
	end)
end

local function var_0_74(arg_161_0, arg_161_1, arg_161_2, arg_161_3)
	local var_161_0 = arg_161_0:getChildByName("bg")

	var_161_0:stopAllActions()

	arg_161_1 = arg_161_1 or 0
	arg_161_2 = arg_161_2 or 999

	local var_161_1 = var_161_0:getChildren()

	for iter_161_0 = 1, #var_161_1 do
		var_161_1[iter_161_0]:setVisible(true)
	end

	var_161_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_161_1), cc.MoveTo:create(0.1, cc.p(0, var_161_0:getPositionY())), cc.DelayTime:create(arg_161_2), cc.MoveTo:create(0.1, cc.p(-var_161_0:getContentSize().width + 40, 0)), cc.CallFunc:create(function()
		arg_161_3:setRotation(180)

		local var_162_0 = var_161_0:getChildren()

		for iter_162_0 = 1, #var_162_0 do
			if var_162_0[iter_162_0]:getName() ~= "bntShowInfo" then
				var_162_0[iter_162_0]:setVisible(false)
			end
		end
	end)))
end

local function var_0_75(arg_163_0, arg_163_1)
	local var_163_0 = arg_163_0:getChildByName("bg")

	var_163_0:stopAllActions()

	arg_163_1 = arg_163_1 or 0

	var_163_0:runAction(cc.Sequence:create(cc.DelayTime:create(arg_163_1), cc.MoveTo:create(0.1, cc.p(-var_163_0:getContentSize().width + 40, var_163_0:getPositionY())), cc.CallFunc:create(function()
		local var_164_0 = var_163_0:getChildren()

		for iter_164_0 = 1, #var_164_0 do
			if var_164_0[iter_164_0]:getName() ~= "bntShowInfo" then
				var_164_0[iter_164_0]:setVisible(false)
			end
		end
	end)))
end

local function var_0_76(arg_165_0)
	local var_165_0 = cc.Node:create()
	local var_165_1 = ccui.ImageView:create(var_0_62, var_0_46)

	var_165_1:setScale9Enabled(true)
	var_165_1:setScaleX(-1)
	var_165_1:setAnchorPoint(cc.p(1, 0.5))
	var_165_1:setName("bg")
	var_165_1:setPosition(cc.p(-var_165_1:getContentSize().width, 0))
	var_165_1:setTouchEnabled(true)

	local var_165_2 = 0
	local var_165_3 = {}
	local var_165_4 = {}
	local var_165_5 = 0.3

	for iter_165_0 = 1, #arg_165_0 do
		local var_165_6 = cc.Label:createWithTTF(arg_165_0[iter_165_0].des, FONT_DES, 20)

		var_165_6:setScaleX(-1)
		var_165_6:setAnchorPoint(cc.p(0, 0.5))
		var_165_6:setColor(cc.c3b(212, 226, 242))
		var_165_6:setName("label")
		var_165_6:setAnchorPoint(cc.p(0, 0.5))

		var_165_3[#var_165_3 + 1] = var_165_6

		var_165_1:addChild(var_165_6, 99)

		local var_165_7 = ccui.ImageView:create(arg_165_0[iter_165_0].icon, var_0_46)

		var_165_7:setScale(var_165_5)
		var_165_7:setAnchorPoint(cc.p(1, 0.5))
		var_165_7:setName("icon")

		var_165_4[#var_165_4 + 1] = var_165_7

		var_165_1:addChild(var_165_7, 99)

		if var_165_2 < var_165_6:getContentSize().width + var_165_7:getContentSize().width * var_165_5 then
			var_165_2 = var_165_6:getContentSize().width + var_165_7:getContentSize().width * var_165_5
		end
	end

	local var_165_8 = var_165_3[1]:getContentSize().height

	print(":::::::::::::::::::21", var_165_8)

	local var_165_9 = var_165_2

	if var_165_9 > 320 then
		var_165_1:setContentSize(cc.size(var_165_9 + 50, #arg_165_0 < 3 and 67 or 104 + (#arg_165_0 - 2) * 20))
	else
		var_165_1:setContentSize(cc.size(340, #arg_165_0 < 3 and 67 or 104 + (#arg_165_0 - 2) * 20))
	end

	if #var_165_3 == 1 then
		var_165_4[1]:setPosition(cc.p(var_165_1:getContentSize().width - 5, var_165_1:getContentSize().height / 2))
		var_165_3[1]:setPosition(cc.p(var_165_1:getContentSize().width - 10 - var_165_4[1]:getContentSize().width * var_165_5, var_165_1:getContentSize().height / 2))
	elseif #var_165_3 % 2 == 1 then
		for iter_165_1 = 1, #var_165_3 do
			var_165_4[iter_165_1]:setPosition(cc.p(var_165_1:getContentSize().width - 5, var_165_1:getContentSize().height / 2 + var_165_8 - (iter_165_1 - math.floor(#var_165_3 / 2)) * (var_165_8 + 3)))
			var_165_3[iter_165_1]:setPosition(cc.p(var_165_1:getContentSize().width - 10 - var_165_4[iter_165_1]:getContentSize().width * var_165_5, var_165_1:getContentSize().height / 2 + var_165_8 - (iter_165_1 - math.floor(#var_165_3 / 2)) * (var_165_8 + 3)))
		end
	elseif #var_165_3 % 2 == 0 then
		for iter_165_2 = 1, #var_165_3 do
			var_165_4[iter_165_2]:setPosition(cc.p(var_165_1:getContentSize().width - 5, var_165_1:getContentSize().height / 2 + var_165_8 / 2 - (iter_165_2 - #var_165_3 / 2) * (var_165_8 + 3)))
			var_165_3[iter_165_2]:setPosition(cc.p(var_165_1:getContentSize().width - 10 - var_165_4[iter_165_2]:getContentSize().width * var_165_5, var_165_1:getContentSize().height / 2 + var_165_8 / 2 - (iter_165_2 - #var_165_3 / 2) * (var_165_8 + 3)))
		end
	end

	var_165_0.show = var_0_74
	var_165_0.hide = var_0_75

	var_165_0:addChild(var_165_1)

	return var_165_0
end

function FightLayer:updateChapterBattleFieldStatusInfo(arg_166_1, arg_166_2, arg_166_3)
	if not arg_166_3 then
		self.battlefieldStatusInfo:removeAllChildren()
	end

	self.battlefieldStatusInfo.curchapter = arg_166_1 .. "-" .. arg_166_2

	local var_166_0 = {}

	if arg_166_1 == "arena" then
		local var_166_1 = arena_manager:get_arena_battlefield_status_info()

		if var_166_1 then
			for iter_166_0, iter_166_1 in ipairs(var_166_1) do
				table.insert(var_166_0, {
					icon = "FightLayer/map_icon.png",
					des = iter_166_1
				})
			end
		end
	elseif arg_166_1 == "arenatft" then
		local var_166_2 = arenatft_manager:get_arenatft_battlefield_status_info()

		if var_166_2 then
			for iter_166_2, iter_166_3 in ipairs(var_166_2) do
				table.insert(var_166_0, {
					icon = "FightLayer/map_icon.png",
					des = iter_166_3
				})
			end
		end
	elseif arg_166_1 ~= "none" then
		for iter_166_4, iter_166_5 in ipairs((level_manager:getChapterBattleFieldInfo(arg_166_1 .. "-" .. arg_166_2))) do
			table.insert(var_166_0, {
				icon = "FightLayer/map_icon.png",
				des = iter_166_5
			})
		end
	end

	if FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER then
		local var_166_3 = expedition_manager:get_expedition_battlefield_status_info()

		if var_166_3 then
			for iter_166_6, iter_166_7 in ipairs(var_166_3) do
				table.insert(var_166_0, iter_166_7)
			end
		end
	end

	local var_166_4 = {}
	local var_166_5 = {}

	if FightManager.getFightType() == FIGHTTYPE_EXPLORE then
		local var_166_6 = {}

		for iter_166_8, iter_166_9 in ipairs((array_manager:getExploreArray())) do
			if iter_166_9.npcid then
				local var_166_7 = {
					pos = iter_166_9.pos
				}

				if npc_data[iter_166_9.fight_girl] then
					var_166_7.fight_girl = npc_data[iter_166_9.fight_girl].model or iter_166_9.fight_girl
				end

				table.insert(var_166_6, var_166_7)
			else
				table.insert(var_166_6, {
					pos = iter_166_9.pos,
					fight_girl = iter_166_9.fight_girl
				})
			end
		end

		var_166_4 = team_skill_manager:getTeamskillByArrayTbl(var_166_6)
		var_166_5 = require("controller.explore_manager"):getExploreSkillDes()
	else
		var_166_4 = FightManager.getFightType() == FIGHTTYPE_ARENA and team_skill_manager:getTeamskillByArrayTbl(array_manager:getArenaAttackArray()) or FightManager.getFightType() == FIGHTTYPE_SCOREARENA and team_skill_manager:getTeamskillByArrayId(array_manager:getScoreAreanArrayID()) or FightManager.getFightType() == FIGHTTYPE_ARENATFT and team_skill_manager:getTeamskillByArrayTbl(arenatft_manager:getTftAreanArray()) or FightManager.getFightType() == FIGHTTYPE_TOWER and {} or (FightManager.getFightType() == FIGHTTYPE_STAKE_PVP or fighttype == FIGHTTYPE_STAKE_PVE) and team_skill_manager:getTeamskillByArrayTbl(test_fight_manager:getPlayerArray()) or FightManager.getFightType() == FIGHTTYPE_FRIENDFIGHT and team_skill_manager:getTeamskillByArrayTbl(array_manager:getArenaAttackArray()) or FightManager.getFightType() == FIGHTTYPE_EXPEDITION and team_skill_manager:getTeamskillByArrayTbl(expedition_manager:getArray()) or FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER and team_skill_manager:getTeamskillByArrayTbl(expedition_manager:getArray()) or FightManager.getFightType() == FIGHTTYPE_EXPEDITION_MONOPOLY and team_skill_manager:getTeamskillByArrayTbl(expedition_manager:getArray()) or team_skill_manager:getTeamskillByArrayTbl(playermodel.curSoul)
	end

	for iter_166_10, iter_166_11 in ipairs(var_166_4) do
		table.insert(var_166_0, {
			des = total_skill_data[iter_166_11.skillid].description,
			icon = "public/career_icon/" .. iter_166_11.eleIcon .. ".png"
		})
	end

	for iter_166_12, iter_166_13 in ipairs(var_166_5) do
		table.insert(var_166_0, {
			icon = "FightLayer/map_icon.png",
			des = battlefield_status_data[iter_166_13].des
		})
	end

	if bond_manager:isHaveBondEffect() == true then
		if battlefield_status_data[6301] and battlefield_status_data[6301].des then
			table.insert(var_166_0, {
				icon = "FightLayer/map_icon.png",
				des = battlefield_status_data[6301].des
			})
		end
	end

	if birthday_party_manager:isHaveBirthdayPartyEffect() == true then
		local var_166_8 = birthday_party_manager:getBirthdayPartyBattleFiled()

		if battlefield_status_data[var_166_8] and battlefield_status_data[var_166_8].des then
			table.insert(var_166_0, {
				icon = "FightLayer/map_icon.png",
				des = battlefield_status_data[var_166_8].des
			})
		end
	end

	if config._DEVELOP_MODE ~= "FIGHTDEV" then
		self:generateCourseField(var_166_0)
	end

	if not var_166_0 or #var_166_0 == 0 then
		return
	end

	if not arg_166_3 then
		local var_166_10 = 0
		local var_166_13 = ccui.Button:create("FightLayer/btn_show_info.png", nil, "FightLayer/btn_show_info.png", var_0_46)

		var_166_13:setName("bntShowInfo")
		var_166_13:setSwallowTouches(false)

		local var_166_15 = var_0_76(var_166_0)
		local var_166_16 = var_166_15:getChildByName("bg")

		var_166_15:setPosition(cc.p(0, var_166_10 + (var_166_16:getContentSize().height > 90 and var_166_16:getContentSize().height - 90 or 0) + 105))
		self.battlefieldStatusInfo:addChild(var_166_15)
		var_166_13:setPosition(18, var_166_16:getContentSize().height / 2)
		var_166_15:hide(0)
		var_166_13:setRotation(180)
		var_166_16:addChild(var_166_13, 99)
		var_166_16:addTouchEventListener(function(arg_167_0, arg_167_1)
			if arg_167_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_166_13:getRotation() == 180 then
				var_166_15:show(0, nil, var_166_13)
				var_166_13:setRotation(0)
			else
				var_166_15:hide(0)
				var_166_13:setRotation(180)
			end
		end)
	end
end

function FightLayer:showBattleFieldStatusOnSwitch()
	if FightManager.getFightType() == FIGHTTYPE_NORMAL or FightManager.getFightType() == FIGHTTYPE_ADVENTURE or FightManager.getFightType() == FIGHTTYPE_INFINITE or FightManager.getFightType() == FIGHTTYPE_ADVENTURE_TOWER then
		self:updateChapterBattleFieldStatusInfo(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode))
	elseif FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION then
		self:updateChapterBattleFieldStatusInfo("none", "none")
	elseif FightManager.getFightType() == FIGHTTYPE_ARENA then
		self:updateChapterBattleFieldStatusInfo("arena", "none")
	elseif FightManager.getFightType() == FIGHTTYPE_ARENATFT then
		self:updateChapterBattleFieldStatusInfo("arenatft", "none")
	else
		self:updateChapterBattleFieldStatusInfo("none", "none")
	end
end

function FightLayer.updateWave(arg_169_0)
	return
end

function FightLayer:updateTime(arg_170_1)
	if self.showstat ~= var_0_50 then
		return
	end

	self.panelFightTime:updateTime(arg_170_1)
end

function FightLayer:updateDamageAddition(arg_171_1)
	if self.showstat ~= var_0_50 then
		return
	end

	self.panelFightTime:updateDamageAddition(arg_171_1)
end

function FightLayer:resetDamageAddition()
	self.panelFightTime:reset()
end

function FightLayer.removeGuidesOnLayer(arg_173_0)
	if LayerManager:getCurrentLayerName() ~= "FightLayer" then
		return
	end

	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()
end

function FightLayer.updateGuidesOnLayer(arg_174_0)
	LayerManager:updateGuidesOnSwitchLayer()
end

function FightLayer:refreshGuidesOnFight()
	if LayerManager:getCurrentLayerName() ~= "FightLayer" then
		return
	end

	self:removeGuidesOnLayer()
	self:updateGuidesOnLayer()
end

function FightLayer:getShowStat()
	return self.showstat
end

function FightLayer:switchToMap(arg_177_1, arg_177_2)
	if self.showstat ~= var_0_50 then
		return
	end

	for iter_177_0 = 1, 5 do
		FightManager.detachPlayerItem(iter_177_0)
	end

	self:detachBuffPanel()
	self:removeGuidesOnLayer()
	self.panelMap:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:refreshGuidesOnFight()
	end)))
	self:removeWave()
	self:showFightMap(arg_177_1)
	self.panelConsole:setVisible(false)
	self.panelMap:setVisible(true)
	self:removeFightPauseLayer()
	self:hideSubUI()
	barrage_manager:resume()
	self.barrage:setVisible(level_manager:isPlayerPassLevel("1-5"))
	ccui.Helper:seekWidgetByName(self.rootLayer, "patrolPopBnt"):setVisible(level_manager:isPlayerPassLevel("2-5"))

	if LayerManager:getCurrentLayerName() == "FightLayer" or LayerManager:getCurrentLayerName() == "PopChatInterfaceLayer" then
		LayerManager:showTopBottomLayer({
			TopcostLayer = true,
			ListButtonLayer = true
		})
		audio_manager:switchLayerBGM(FIGHT_BGM)
	end

	require("view.Layer.ListButtonLayer")

	if ListButtonLayer.getInstance() then
		ListButtonLayer.getInstance():updateShowBtnList()
	end

	self.autoflag = RoleDefault:getInstance():getBoolForKey("fightauto", false)
	playermodel.autoXP = self.autoflag

	self:updateFightAutoModeAction(self.autoflag)

	if self.newUnlockLevelMode then
		self.newUnlockLevelMode = false

		var_0_67()
	end

	self:updatePassLevelAwardButton()
	self:updateMainLineTaskUI()
end

function FightLayer:switchToBossFight(arg_179_1, arg_179_2)
	LayerManager:showTopBottomLayer({
		TopcostLayer = false,
		ListButtonLayer = false
	})

	self.showstat = var_0_50
	arg_179_1 = arg_179_1 or {}

	for iter_179_0 = 1, 5 do
		self.playerItems[iter_179_0]:updatePlayerInfo(arg_179_1[iter_179_0])
		FightManager.attachPlayerItem(iter_179_0, self.playerItems[iter_179_0])
	end

	self:attachBuffPanelOnBoss(arg_179_1)
	self.panelMap:setVisible(false)
	self.panelConsole:setVisible(true)
	self.panelConsole:getChildByName("panelbg"):setVisible(true)
	self.panelConsole:getChildByName("buffPanel"):setVisible(true)
	self.btnAuto:getChildByName("lock_icon"):setVisible(not level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT))
	self.btnSpeedup:getChildByName("lock_icon"):setVisible(not level_manager:isPlayerPassLevel(UNLOCK_QUICK_FIGHT))
	self.panelFightTime:reset()
	self:showBattleFieldStatusOnSwitch()
	self:updateConsoleUIByFightType()
	self:playHorcruxEffectOnEnter(arg_179_1)
	self:removeGuidesOnLayer()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	barrage_manager:stop()
	self.barrage:setVisible(false)

	if not arg_179_2 then
		audio_manager:playbackgroundMusic(level_manager:getChapterBossBgm(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)), true, BOSS_VOLUME)
	end
end

function FightLayer:createFightLoadIngAni()
	local var_181_0 = ccui.Layout:create()

	var_181_0:setContentSize(cc.size(640, GameDisplay.height))
	var_181_0:setTouchEnabled(true)
	var_181_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_181_0, 999)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/fight_loading.ExportJson")

	local var_181_1 = ccs.Armature:create("fight_loading")

	var_181_1:setPosition(320, GameDisplay.height / 2)
	var_181_0:addChild(var_181_1)
	var_181_1:getAnimation():play("Animation1")
	var_181_1:getAnimation():setFrameEventCallFunc(function(arg_182_0, arg_182_1, arg_182_2, arg_182_3)
		if arg_182_1 == "end" then
			var_181_0:runAction(cc.RemoveSelf:create())
		end
	end)
end

function FightLayer:playHorcruxEffectOnEnter(arg_183_1)
	for iter_183_0, iter_183_1 in ipairs((horcrux_manager:handleHelpGirlData((horcrux_manager:getHelpGirlData(arg_183_1))))) do
		self.horcruxEffectPanel:insert(iter_183_1)
	end
end

local var_0_77 = "FightLayer/bubble_horcrux_skill.png"
local var_0_78 = -92
local var_0_79 = 955
local var_0_80 = 90

local function var_0_81(arg_184_0)
	local var_184_0 = ccui.ImageView:create(var_0_77, var_0_46)
	local var_184_1 = ccui.ImageView:create("role/wuji/" .. horcrux_manager:getHorcruxHeadImage(arg_184_0.modelid) .. ".png")

	var_184_1:setScale(0.38)
	var_184_1:setPosition(cc.p(25, 30))
	var_184_0:addChild(var_184_1, 1)

	local var_184_2 = cc.Label:createWithTTF(total_skill_data[arg_184_0.skillid].name, FONT_NAME, global_change_fontsize_by_length(total_skill_data[arg_184_0.skillid].name, 30, 3, 4))

	var_184_2:setPosition(cc.p(78, 25))
	var_184_2:setAnchorPoint(cc.p(0, 0.5))
	var_184_2:setColor(cc.c3b(38, 61, 98))
	var_184_0:addChild(var_184_2, 1)

	local var_184_3 = cc.Label:createWithTTF(total_skill_data[arg_184_0.skillid].name, FONT_NAME, global_change_fontsize_by_length(total_skill_data[arg_184_0.skillid].name, 30, 3, 4))

	var_184_3:setPosition(cc.p(76, 27))
	var_184_3:setAnchorPoint(cc.p(0, 0.5))
	var_184_3:setColor(cc.c3b(237, 230, 240))
	var_184_0:addChild(var_184_3, 1)

	return var_184_0
end

function FightLayer:initHorcruxEffectPanel()
	local var_185_0 = cc.Node:create()

	self.panelConsole:addChild(var_185_0, 10)

	var_185_0._curindex = 0
	var_185_0._maxindex = 4
	var_185_0._queue = {}

	for iter_185_0 = 1, var_185_0._maxindex do
		table.insert(var_185_0._queue, {})
	end

	function var_185_0:insert(arg_186_1)
		arg_186_1.isover = false

		local var_186_0 = false

		for iter_186_0, iter_186_1 in ipairs(self._queue) do
			if #iter_186_1 == 0 then
				table.insert(iter_186_1, arg_186_1)

				self._curindex = iter_186_0
				var_186_0 = true

				break
			end
		end

		if not var_186_0 then
			local var_186_1 = self:getInsertIndex()

			table.insert(self._queue[var_186_1], arg_186_1)

			self._curindex = var_186_1
		end

		self:broadcastEffect(self._curindex)
	end

	function var_185_0:getInsertIndex()
		return (self._curindex + 1 > self._maxindex or nil) and 1
	end

	function var_185_0:broadcastEffect(arg_188_1)
		local var_188_0 = self._queue[arg_188_1]

		if not self._queue[arg_188_1][1] then
			return
		end

		if self._queue[arg_188_1][1].isover then
			return
		end

		local var_188_1 = var_0_81(self._queue[arg_188_1][1])

		var_188_1:setPosition(cc.p(var_0_78, var_0_79 - (arg_188_1 - 1) * var_0_80))
		self:addChild(var_188_1)
		var_188_1:runAction(cc.Sequence:create(cc.MoveBy:create(0.1, cc.p(216, 0)), cc.MoveBy:create(0.15, cc.p(10, 0)), cc.DelayTime:create(0.92), cc.FadeOut:create(0.17), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			table.remove(var_188_0, 1)
			self:broadcastEffect(arg_188_1)
		end)))
	end

	self.horcruxEffectPanel = var_185_0

	self:registerCustomEvent("triggerHorcrux", function(arg_190_0)
		local var_190_0

		if self.showstat ~= var_0_50 then
			do return end

			var_190_0 = {}
		end

		var_190_0.modelid = arg_190_0.modelid
		var_190_0.skillid = arg_190_0.skillid

		self.horcruxEffectPanel:insert(var_190_0)
	end)
end

function FightLayer:showFightPauseLayer()
	if self.fightPauseLayer then
		return
	end

	self.fightPauseLayer = ccui.Layout:create()

	self.fightPauseLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.fightPauseLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.fightPauseLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.fightPauseLayer:setBackGroundColorOpacity(100)
	self.fightPauseLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self:addChild(self.fightPauseLayer, 100)
	self.fightPauseLayer:setTouchEnabled(true)
	FightManager.pauseBattleField()

	local var_191_0 = ccui.ImageView:create("FightLayer/pausebg.png", var_0_46)

	var_191_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.fightPauseLayer:addChild(var_191_0)

	local function var_191_1(arg_192_0, arg_192_1)
		if arg_192_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:removeWave()
		FightManager.refreshFight()
		self:removeFightPauseLayer()
	end

	local function var_191_2(arg_193_0, arg_193_1)
		if arg_193_1 ~= ccui.TouchEventType.ended then
			return
		end

		FightManager.resumeBattleField()
		self:removeFightPauseLayer()
	end

	local function var_191_3(arg_194_0, arg_194_1)
		if arg_194_1 ~= ccui.TouchEventType.ended then
			return
		end

		FightManager.fightSurrender()
		self:removeFightPauseLayer()
	end

	local var_191_4 = level_manager:isPlayerPassLevel(UNLOCK_FIGHT_SURRENDER) and {
		{
			"refight",
			"FightLayer/fight_btn_refight.png",
			cc.p(GameDisplay.cx, GameDisplay.cy),
			var_191_1
		},
		{
			"resume",
			"FightLayer/fight_btn_resume.png",
			cc.p(GameDisplay.cx + 200, GameDisplay.cy),
			var_191_2
		},
		{
			"surrender",
			"FightLayer/fight_btn_surrender.png",
			cc.p(GameDisplay.cx - 200, GameDisplay.cy),
			var_191_3
		}
	} or {
		{
			"refight",
			"FightLayer/fight_btn_refight.png",
			cc.p(GameDisplay.cx - 150, GameDisplay.cy),
			var_191_1
		},
		{
			"resume",
			"FightLayer/fight_btn_resume.png",
			cc.p(GameDisplay.cx + 150, GameDisplay.cy),
			var_191_2
		}
	}

	if FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION or FightManager.getFightType() == FIGHTTYPE_SUBSTITUTION_OLD then
		var_191_4 = {
			{
				"resume",
				"FightLayer/fight_btn_resume.png",
				cc.p(GameDisplay.cx + 150, GameDisplay.cy),
				var_191_2
			},
			{
				"surrender",
				"FightLayer/fight_btn_surrender.png",
				cc.p(GameDisplay.cx - 150, GameDisplay.cy),
				var_191_3
			}
		}
	end

	for iter_191_0, iter_191_1 in ipairs((FightManager.getFightType() == FIGHTTYPE_INFINITE or nil) and {
		{
			"resume",
			"FightLayer/fight_btn_resume.png",
			cc.p(GameDisplay.cx - 150, GameDisplay.cy),
			var_191_2
		},
		{
			"surrender",
			"FightLayer/fight_btn_surrender.png",
			cc.p(GameDisplay.cx + 150, GameDisplay.cy),
			var_191_3
		}
	}) do
		local var_191_5 = ccui.Button:create(iter_191_1[2], iter_191_1[2], iter_191_1[2], var_0_46)

		var_191_5:setPressedActionEnabled(true)
		var_191_5:setPosition(iter_191_1[3])
		var_191_5:setName(iter_191_1[1])
		var_191_5:addTouchEventListener(iter_191_1[4])
		self.fightPauseLayer:addChild(var_191_5, 2)
	end
end

function FightLayer:removeFightPauseLayer()
	FightManager.resumeBattleField()

	if not self.fightPauseLayer then
		return
	end

	self.fightPauseLayer:runAction(cc.RemoveSelf:create())

	self.fightPauseLayer = nil
end

function FightLayer:initRecruitUI()
	if not self.btn_recruit then
		self.btn_recruit = ccui.Button:create("mainScenebg/activity/common/recruit_entrance.png", nil, "mainScenebg/activity/common/recruit_entrance.png")

		self.btn_recruit:setAnchorPoint(0.5, 0.5)
		self.panelMap:addChild(self.btn_recruit)

		if level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) then
			self.btn_recruit:setPosition(cc.p(600, 887))
		else
			self.btn_recruit:setPosition(cc.p(600, 987))
		end

		self.btn_recruit:setName("btn_recruit")
		self.btn_recruit:addTouchEventListener(function(arg_197_0, arg_197_1)
			if arg_197_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) then
				global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_RECRUIT_ROLE)))
			else
				LayerManager:switchShowLayer("SchoolStudyLayer")
			end
		end)

		local var_196_0 = ccui.ImageView:create("public/button/fight_lock.png", var_0_46)

		var_196_0:setName("lock_icon")
		var_196_0:setVisible(not level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE))
		var_196_0:setPosition(cc.p(self.btn_recruit:getContentSize().width - 20, self.btn_recruit:getContentSize().height - 20))
		self.btn_recruit:addChild(var_196_0)

		local var_196_1 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK_TIPS, level_manager:formatSystemUnlockLevel(UNLOCK_RECRUIT_ROLE)):gsub(L_CHECK_TASK_DATA.tasktypeStr[1], ""), FONT_BUTTON, 16)

		var_196_1:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_196_1:setAnchorPoint(0.5, 0.5)
		var_196_1:setName("recruit_entrance_tipText")
		self.panelMap:addChild(var_196_1, 10)
	end

	self.btn_recruit:setColor(level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) and cc.c3b(255, 255, 255) or cc.c3b(155, 155, 155))
	self.btn_recruit:setVisible(level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT))

	self.btn_recruit.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.btn_recruit:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	self.btn_recruit:setPositionY(self.btn_recruit.full_posY)
	self.panelMap:getChildByName("recruit_entrance_tipText"):setPosition(self.btn_recruit:getPositionX(), self.btn_recruit:getPositionY() - self.actEntranceBtn:getContentSize().height / 2 - self.btn_recruit:getContentSize().height / 2 + 8)
	self.panelMap:getChildByName("recruit_entrance_tipText"):setVisible(not level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) and level_manager:isPlayerPassLevel(UNLOCK_AUTO_FIGHT))
end

function FightLayer:initNoviceRecharegeIUI()
	local var_198_0

	if not self.btnNoviceRecharge then
		self.btnNoviceRecharge = ccui.Button:create("mainScenebg/activity/common/recharge_novice.png", nil, "mainScenebg/activity/common/recharge_novice.png")

		self.panelMap:addChild(self.btnNoviceRecharge)
		self.btnNoviceRecharge:setPositionX(600)
		self.btnNoviceRecharge:setName("btn_novicerecharge")
		self.btnNoviceRecharge:addTouchEventListener(function(arg_199_0, arg_199_1)
			if arg_199_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopNoviceRechargeLayer", {
				rechargeid = L_ONCE_RECHARGE_NOVICE
			})
		end)

		var_198_0 = RoleDefault:getInstance():getBoolForKey("recharege" .. L_ONCE_RECHARGE_NOVICE, false)
	end

	self.btnNoviceRecharge:setVisible(playermodel.create_time + 259200 - time_check_manager:getCurTime() > 0 and not var_198_0)
end

function FightLayer:initReturnBackRechargeUI()
	if not self.btnBackRecharge then
		self.btnBackRecharge = ccui.Button:create("mainScenebg/activity/common/recharge_dierect.png", nil, "mainScenebg/activity/common/recharge_dierect.png")

		self.panelMap:addChild(self.btnBackRecharge)
		self.btnBackRecharge:setPositionX(600)
		self.btnBackRecharge:setName("btn_returnback_recharge")
		self.btnBackRecharge:addTouchEventListener(function(arg_201_0, arg_201_1)
			if arg_201_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopNoviceRechargeLayer", {
				rechargeid = L_ONCE_RECHARGE_BACK,
				remain = self.btnBackRecharge.remain,
				finishtime = self.btnBackRecharge.finishtime
			})
		end)
	end

	require("network.network"):rpc("get_recharge_info", {
		client = config.clientmode,
		types = {
			111
		}
	}, function(arg_202_0)
		if arg_202_0.result == 1 then
			if arg_202_0.products and arg_202_0.products[1] then
				self.btnBackRecharge.remain = arg_202_0.products[1].buy_limit - arg_202_0.products[1].have_bought
				self.btnBackRecharge.finishtime = arg_202_0.products[1].finishtime

				self.btnBackRecharge:setVisible(arg_202_0.products[1].buy_limit > arg_202_0.products[1].have_bought)
			else
				self.btnBackRecharge:setVisible(false)
			end

			self:adaptFightLayerTopRightPos()
		end
	end)
end

function FightLayer:initPromotionRechargeUI()
	if not self.btnPromoteRecharge then
		self.btnPromoteRecharge = ccui.Button:create("mainScenebg/activity/common/recharge_promoto.png", nil, "mainScenebg/activity/common/recharge_promoto.png")

		self.panelMap:addChild(self.btnPromoteRecharge)
		self.btnPromoteRecharge:setPositionX(600)
		self.btnPromoteRecharge:setName("btn_promoterecharge")
		self.btnPromoteRecharge:addTouchEventListener(function(arg_204_0, arg_204_1)
			if arg_204_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PromoteRechargeLayer")
		end)
		self.btnPromoteRecharge:setVisible(true)
	end

	self.btnPromoteRecharge:setVisible(playermodel.create_time + 604800 - time_check_manager:getCurTime() > 0)
	var_0_32:requestInfo(8998, function()
		if not var_0_32:getInfo() then
			self.btnPromoteRecharge:setVisible(false)
		else
			self.btnPromoteRecharge:setVisible(true)
		end
	end)
end

function FightLayer:initPopReturnBackPacksUI()
	if not self.btnPopReturnBackPacks then
		self.btnPopReturnBackPacks = ccui.Button:create("mainScenebg/activity/common/returnback_packs.png", nil, "mainScenebg/activity/common/returnback_packs.png")

		self.panelMap:addChild(self.btnPopReturnBackPacks)
		self.btnPopReturnBackPacks:setPositionX(600)
		self.btnPopReturnBackPacks:setName("btn_popReturnBackPacks")
		self.btnPopReturnBackPacks:addTouchEventListener(function(arg_207_0, arg_207_1)
			if arg_207_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopReturnBackPacksLayer")
		end)
		self.btnPopReturnBackPacks:setVisible(true)
	end

	if not activity_manager:getActivityObj(176) then
		self.btnPopReturnBackPacks:setVisible(false)

		return
	end

	self.scheduler = self.scheduler or {}

	local var_206_0 = ccui.Text:create("", FONT_BUTTON, 16)

	var_206_0:setName("timeLabel")
	var_206_0:setColor(cc.c3b(254, 242, 242))
	var_206_0:setPosition(cc.p(50, 8))
	self.btnPopReturnBackPacks:addChild(var_206_0)

	local function var_206_1(arg_208_0)
		if not arg_208_0 then
			return ""
		end

		if arg_208_0 > 86400 then
			return string.format(L_TIME_SINGLE.Day, math.floor(arg_208_0 / 3600 / 24))
		elseif arg_208_0 >= 3600 then
			return string.format(L_TIME_SINGLE.Hour, math.floor(arg_208_0 / 3600))
		elseif arg_208_0 >= 60 then
			return string.format(L_TIME_SINGLE.Minute, math.floor(arg_208_0 % 3600 / 60))
		else
			return string.format(L_TIME_SINGLE.Minute, 1)
		end
	end

	local function var_206_2(arg_209_0)
		var_206_0:setString((var_206_1(arg_209_0)))

		if arg_209_0 <= 0 and var_206_0 and self.scheduler and self.scheduler.btn_popReturnBackPacks then
			time_check_manager:removeUpdatePool(self.scheduler.btn_popReturnBackPacks)

			self.scheduler.btn_popReturnBackPacks = nil

			self.btnPopReturnBackPacks:setVisible(false)
		end
	end

	local var_206_3 = global_get_time_by_date(activity_manager:getActivityObj(176).finishtime) - 2332800 - time_check_manager:getCurTime()

	if var_206_3 <= 0 then
		self.btnPopReturnBackPacks:setVisible(false)

		return
	end

	if not var_206_3 then
		return
	end

	var_206_2(var_206_3)

	if var_206_3 < 86400 then
		var_206_0:setColor(cc.c3b(248, 99, 99))
	end

	self.scheduler.btn_popReturnBackPacks = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_206_3, var_206_2)))
end

function FightLayer:initNewRulesPacksUI()
	if not self.btnNewRulesPacks then
		self.btnNewRulesPacks = ccui.Button:create("mainScenebg/activity/common/recharge_condition_trigger.png", nil, "mainScenebg/activity/common/recharge_condition_trigger.png")

		self.panelMap:addChild(self.btnNewRulesPacks)
		self.btnNewRulesPacks:setPositionX(600)
		self.btnNewRulesPacks:setName("btn_newrulespacks")
		self.btnNewRulesPacks:addTouchEventListener(function(arg_211_0, arg_211_1)
			if arg_211_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("RulesPacksCollectionLayer")
		end)
		self.btnNewRulesPacks:setVisible(false)
	end

	require("controller.condition_trigger_packs_manager"):get_condition_packs_active(function(arg_212_0)
		if not arg_212_0.packs_types then
			return
		end

		if #arg_212_0.packs_types > 0 then
			self.btnNewRulesPacks:setVisible(true)
		end

		self:adaptFightLayerTopRightPos()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("condition_packs_trigger", function(arg_213_0)
		print("condition_packs_trigger!!!!!!!!!!!!!!!!")
		self.btnNewRulesPacks:setVisible(true)
		self:adaptFightLayerTopRightPos()
	end), self)
end

function FightLayer:initActivityEntranceBtn()
	if not self.actEntranceBtn then
		self.actEntranceBtn = ccui.Button:create("mainScenebg/activity/common/new_activity_entrance.png", nil, "mainScenebg/activity/common/new_activity_entrance.png")

		if time_check_manager:getCurTime() > global_get_time_by_date("2026-02-16 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2026-03-29 23:59:59") then
			self.actEntranceBtn:loadTextures("mainScenebg/activity/common/new_activity_entrance_replace.png", nil, "mainScenebg/activity/common/new_activity_entrance_replace.png")
		end

		self.actEntranceBtn:setName("btn_act_entrance")
		self.actEntranceBtn:setPosition(cc.p(585, GameDisplay.height - 150))
		self.actEntranceBtn:setScale(0.9, 0.9)
		self.panelMap:addChild(self.actEntranceBtn)
		self.actEntranceBtn:addTouchEventListener(function(arg_215_0, arg_215_1)
			if arg_215_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_215_0:isBright() then
				return
			end

			LayerManager:switchShowLayer("ActivityEntranceLayer")
		end)

		local var_214_0 = ccui.ImageView:create("public/button/horcrux_lock.png", var_0_46)

		var_214_0:setPosition(cc.p(100, 100))
		var_214_0:setName("image")
		self.actEntranceBtn:addChild(var_214_0)

		local var_214_1 = cc.Label:createWithTTF(string.format(L_AREAN_UNLOCK_TIPS, level_manager:formatSystemUnlockLevel(UNLOCK_ACTIVITY_ENTTRANCE)):gsub(L_CHECK_TASK_DATA.tasktypeStr[1], ""), FONT_BUTTON, 16)

		var_214_1:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_214_1:setName("activity_entrance_tipText")
		self.panelMap:addChild(var_214_1)
		var_214_1:setPosition(self.actEntranceBtn:getPositionX(), self.actEntranceBtn:getPositionY())

		if not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_ENTTRANCE) then
			var_214_0:setVisible(true)
			var_214_1:setVisible(true)
			self.actEntranceBtn:setColor(cc.c3b(117, 117, 117))
			var_214_1:setColor(cc.c3b(255, 255, 255))
		else
			var_214_0:setVisible(false)
			var_214_1:setVisible(false)
			self.actEntranceBtn:setColor(cc.c3b(255, 255, 255))
		end
	end
end

function FightLayer:initOnlineRewardUI(...)
	if not self.btn_onlinereward then
		self.btn_onlinereward = ccui.Button:create("mainScenebg/activity/common/online_reward.png", nil, "mainScenebg/activity/common/online_reward.png")

		self.panelMap:addChild(self.btn_onlinereward)

		if level_manager:isPlayerPassLevel(UNLOCK_RECRUIT_ROLE) then
			self.btn_onlinereward:setPosition(cc.p(600, 787))
		else
			self.btn_onlinereward:setPosition(cc.p(600, 887))
		end

		self.btn_onlinereward:setName("btn_onlinereward")
		self.btn_onlinereward:addTouchEventListener(function(arg_217_0, arg_217_1)
			if arg_217_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopOnlineRewardLayer", {
				callback = function(...)
					self:updateOnlineRewardReddot()
				end
			})
		end)
	end

	local var_216_0 = self.btn_onlinereward

	var_216_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self.btn_onlinereward:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

	var_216_0:setPositionY(var_216_0.full_posY)

	local var_216_1 = os.date("*t", playermodel.create_time)
	local var_216_2 = os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_216_1.year,
		month = var_216_1.month,
		day = var_216_1.day
	})

	self.btn_onlinereward:setVisible(require("controller.time_check_manager"):getCurTime() < var_216_2 + 604800 and os.time({
		hour = 0,
		month = 3,
		year = 2023,
		min = 0,
		sec = 1,
		day = 10
	}) < var_216_2 and var_216_2 < os.time({
		hour = 0,
		month = 3,
		year = 2033,
		min = 0,
		sec = 1,
		day = 10
	}))
	self:updateOnlineRewardReddot()
end

function FightLayer:initPassLevelAwardUI()
	local var_219_0 = GameDisplay.height - 260
	local var_219_1
	local var_219_2 = false
	local novice_pass_level_data = require("data.novice_pass_level_data")

	if not activity_manager:is_module_stat_finished(2, "wake_fund") then
		var_219_1 = true
		var_219_2 = true
	end

	if not activity_manager:is_module_stat_finished(406, "wake_fund") then
		var_219_1 = true
		var_219_2 = true
	end

	if not activity_manager:is_module_stat_finished(486, "wake_fund") then
		var_219_1 = true
		var_219_2 = true
	end

	if not activity_manager:is_module_stat_finished(710, "wake_fund") then
		var_219_1 = true
		var_219_2 = true
	end

	if not self.passLevelAwardBtn and var_219_1 then
		self.passLevelAwardBtn = ccui.Layout:create()

		self.passLevelAwardBtn:setBackGroundImageColor(cc.c3b(255, 255, 255))
		self.passLevelAwardBtn:setContentSize(cc.size(200, 100))
		self.passLevelAwardBtn:setAnchorPoint(cc.p(0.5, 0.5))
		self.passLevelAwardBtn:setPosition(cc.p(100, var_219_0))
		self.passLevelAwardBtn:setName("passLevelAwardBtn")
		self.passLevelAwardBtn:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self.passLevelAwardBtn:setBackGroundColor(cc.c3b(0, 0, 0))
		self.passLevelAwardBtn:setTouchEnabled(true)
		self.panelMap:addChild(self.passLevelAwardBtn)
		self.passLevelAwardBtn:setVisible(level_manager:isPlayerPassLevel(UNLOCK_PASSLEVEL_AWARD))

		local var_219_4 = L2Skeleton:create("spine/ui/passLevelAwardBtn.json", "spine/ui/passLevelAwardBtn.atlas")

		var_219_4:setName("wakefunSpine")
		var_219_4:setAnchorPoint(cc.p(0, 0))
		var_219_4:refreshSkeleton()
		self.passLevelAwardBtn:addChild(var_219_4)
		var_219_4:setPosition(cc.p(100, 50))
		var_219_4:setVisible(var_219_2 == true)

		local var_219_5 = ccui.Button:create("mainScenebg/activity/common/pass_level_award_btn_.png", nil, "mainScenebg/activity/common/pass_level_award_btn_.png")

		var_219_5:setTouchEnabled(false)
		var_219_5:setName("passLevelIcon")
		var_219_5:setAnchorPoint(cc.p(0.5, 0.5))
		var_219_5:setScale(1)
		var_219_5:setPosition(50, 50)
		self.passLevelAwardBtn:addChild(var_219_5)
		var_219_5:setVisible(var_219_2 ~= true)

		local var_219_6 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_46)

		var_219_6:setPositionX(100)
		var_219_6:setPositionY(80)
		var_219_6:setVisible(false)
		var_219_6:setName("reddot")
		self.passLevelAwardBtn:addChild(var_219_6)

		local var_219_7 = cc.Label:createWithTTF(L_FIGHTLAYER[2], FONT_NAME, 17)

		var_219_7:setPosition(cc.p(-90, 13))
		var_219_7:setAnchorPoint(cc.p(0, 0.5))
		var_219_7:setName("levelLabel")
		var_219_4:addChild(var_219_7)

		local var_219_8 = cc.Label:createWithTTF(L_FIGHTLAYER[3], FONT_NAME, 23)

		var_219_8:setPosition(cc.p(-90, -12))
		var_219_8:setAnchorPoint(cc.p(0, 0.5))
		var_219_8:setName("surplusLevelLabel")
		var_219_8:setColor(cc.c3b(227, 215, 112))
		var_219_4:addChild(var_219_8)

		local var_219_9 = cc.Label:createWithTTF("0", FONT_NAME, 22)

		var_219_9:setPosition(cc.p(74, -18))
		var_219_9:setAnchorPoint(cc.p(0.5, 0.5))
		var_219_9:setName("numLabel")
		var_219_4:addChild(var_219_9)
		self.passLevelAwardBtn:addTouchEventListener(function(arg_220_0, arg_220_1)
			if arg_220_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_220_0 = {
				layerName = var_219_2 and "ActivityWakefundBaseLayer" or "PopNovicePasslevelAwardLayer"
			}

			var_220_0.isHideOther = true
			var_220_0.type = "wake_fund"

			function var_220_0.exitCallback(...)
				local var_221_0

				if not activity_manager:is_module_stat_finished(2, "wake_fund") then
					var_221_0 = true
				end

				if not activity_manager:is_module_stat_finished(406, "wake_fund") then
					var_221_0 = true
				end

				if not activity_manager:is_module_stat_finished(486, "wake_fund") then
					var_221_0 = true
				end

				if not ((not activity_manager:is_module_stat_finished(710, "wake_fund") or nil) and true) then
					self.passLevelAwardBtn:setVisible(false)
				end

				self:updatePassLevelAwardButton()
			end

			LayerManager:switchShowLayer("NoviceSummaryLayer", var_220_0)
		end)
		self:updatePassLevelAwardButton()
	end
end

function FightLayer:updatePassLevelAwardButton()
	local novice_pass_level_data = require("data.novice_pass_level_data")

	if self.passLevelAwardBtn then
		local var_222_1
		local var_222_2

		if not activity_manager:is_module_stat_finished(2, "wake_fund") then
			var_222_2 = true
		end

		if not activity_manager:is_module_stat_finished(406, "wake_fund") then
			var_222_2 = true
		end

		if not activity_manager:is_module_stat_finished(486, "wake_fund") then
			var_222_2 = true
		end

		if not activity_manager:is_module_stat_finished(710, "wake_fund") then
			var_222_2 = true
		end

		self.passLevelAwardBtn:stopAllActions()

		var_222_1 = (activity_manager:getAlertStatus(2, "wake_fund") or activity_manager:getAlertStatus(406, "wake_fund") or activity_manager:getAlertStatus(710, "wake_fund")) and true

		self.passLevelAwardBtn:getChildByName("passLevelIcon"):setVisible(var_222_2 ~= true)
		self.passLevelAwardBtn:getChildByName("wakefunSpine"):setVisible(var_222_2 == true)
		self.passLevelAwardBtn:getChildByName("reddot"):setVisible(var_222_1)

		if var_222_2 then
			self.passLevelAwardBtn:getChildByName("reddot"):setPositionX(200)
		else
			self.passLevelAwardBtn:getChildByName("reddot"):setPositionX(80)
		end

		local var_222_3 = 1

		if var_222_1 then
			self.passLevelAwardBtn:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(96, GameDisplay.height - 300 + 40 + 8 * var_222_3)), cc.MoveTo:create(0.15, cc.p(96, GameDisplay.height - 300 + 40 - 12 * var_222_3)), cc.MoveTo:create(0.05, cc.p(96, GameDisplay.height - 300 + 40 + 4 * var_222_3)), cc.DelayTime:create(0.8)))))
		else
			self.passLevelAwardBtn:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(600), cc.ScaleTo:create(0.3, 0.7), cc.ScaleTo:create(0.3, 1.2), cc.ScaleTo:create(0.3, 1)))))
		end

		;(function()
			if not var_222_2 then
				return
			end

			local var_223_0 = {
				2,
				406
			}
			local activity_conf_data = require("data.activity_conf_data")
			local task_data = require("data.task_data")
			local chapter_data = require("data.chapter_data")
			local levelmode_data = require("data.levelmode_data")
			local drop_manager = require("controller.drop_manager")
			local activity_wake_fund_conf = require("data.activity_modules.activity_wake_fund_conf")
			local item_manager = require("controller.item_manager")
			local var_223_8 = {}
			local var_223_9 = {}

			for iter_223_0, iter_223_1 in pairs(var_223_0) do
				for iter_223_2, iter_223_3 in pairs((require("data." .. activity_conf_data[iter_223_1].taskindexfile))) do
					if iter_223_3.usemodule == "wake_fund" then
						table.insert(var_223_8, {
							taskid = iter_223_3.taskid,
							vipItem = activity_wake_fund_conf[iter_223_1].extra_drop_vip,
							activityid = iter_223_1
						})
					end
				end
			end

			for iter_223_4, iter_223_5 in pairs(var_223_8) do
				if task_data[iter_223_5.taskid].task_type == 1 then
					table.insert(var_223_9, {
						taskid = iter_223_5.taskid,
						vipItem = iter_223_5.vipItem,
						mode = task_data[iter_223_5.taskid].needs_target,
						chapter = task_data[iter_223_5.taskid].needs_num,
						activityid = activityid
					})
				end
			end

			local var_223_10 = {
				[3] = {
					weight = 1,
					func = function(self, arg_224_1)
						return self.chapter < arg_224_1.chapter
					end
				},
				[2] = {
					weight = 2,
					func = function(self, arg_225_1)
						if self.mode == arg_225_1.mode then
							return "=="
						else
							return self.mode < arg_225_1.mode
						end
					end
				},
				{
					weight = 3,
					func = function(self, arg_226_1)
						if self.activityid == arg_226_1.activityid then
							return "=="
						else
							return self.activityid < arg_226_1.activityid
						end
					end
				}
			}

			table.sort(var_223_10, function(arg_227_0, arg_227_1)
				return arg_227_0.weight > arg_227_1.weight
			end)
			table.sort(var_223_9, function(arg_228_0, arg_228_1)
				for iter_228_0 = 1, #var_223_10 do
					if var_223_10[iter_228_0].func(arg_228_0, arg_228_1) ~= "==" then
						return var_223_10[iter_228_0].func(arg_228_0, arg_228_1)
					end
				end
			end)

			local var_223_12 = {}
			local var_223_13 = {}

			for iter_223_6, iter_223_7 in pairs(var_223_0) do
				for iter_223_8, iter_223_9 in pairs((require("data." .. activity_conf_data[710].taskindexfile))) do
					if iter_223_9.usemodule == "wake_fund" then
						table.insert(var_223_12, {
							taskid = iter_223_9.taskid,
							vipItem = activity_wake_fund_conf[iter_223_7].extra_drop_vip,
							activityid = iter_223_7
						})
					end
				end
			end

			for iter_223_10, iter_223_11 in pairs(var_223_8) do
				if task_data[iter_223_11.taskid].task_type == 1 then
					table.insert(var_223_13, {
						taskid = iter_223_11.taskid,
						vipItem = iter_223_11.vipItem,
						starNum = task_data[iter_223_11.taskid].needs_num
					})
				end
			end

			local var_223_14
			local var_223_15
			local var_223_16
			local var_223_17
			local var_223_18
			local var_223_19

			for iter_223_12, iter_223_13 in pairs(var_223_9) do
				if not level_manager:isPlayerPassLevel(iter_223_13.mode .. "-" .. iter_223_13.chapter) then
					var_223_15 = iter_223_13.mode
					var_223_16 = iter_223_13.chapter
					var_223_17 = iter_223_13.taskid
					var_223_18 = iter_223_13.vipItem
					var_223_19 = iter_223_13.activityid

					break
				end
			end

			local var_223_20 = level_manager:getAllNomalStarCount()

			for iter_223_14, iter_223_15 in pairs(var_223_13) do
				if var_223_20 < iter_223_15.starNum then
					var_223_14 = iter_223_15.starNum - var_223_20
					var_223_17 = iter_223_15.taskid
					var_223_18 = iter_223_15.vipItem
					var_223_19 = iter_223_15.activityid
				end
			end

			if var_223_15 then
				local var_223_21 = 0
				local var_223_22 = var_223_15
				local var_223_23 = var_223_16

				while var_223_22 > 0 and not level_manager:isPlayerPassLevel(var_223_22 .. "-" .. var_223_23) do
					var_223_21 = var_223_21 + 1

					if var_223_23 > 1 then
						var_223_23 = var_223_23 - 1
					elseif levelmode_data[var_223_22 - 1] then
						var_223_22 = var_223_22 - 1
						var_223_23 = levelmode_data[var_223_22].totalchapter
					else
						break
					end
				end

				local var_223_24 = 0
				local var_223_25 = task_data[var_223_17].name
				local var_223_26 = drop_manager:getDropMsg(task_data[var_223_17].drop)

				if next(var_223_26.equips) then
					for iter_223_16, iter_223_17 in pairs(var_223_26.equips) do
						if iter_223_17.dropid == TWIST_TICKET_ID then
							var_223_24 = var_223_24 + iter_223_17.dropNum
						end
					end
				end

				if task_data[var_223_17].free_extra_drop then
					local var_223_27 = drop_manager:getDropMsg(task_data[var_223_17].free_extra_drop)

					if next(var_223_27.equips) then
						for iter_223_18, iter_223_19 in pairs(var_223_27.equips) do
							if iter_223_19.dropid == TWIST_TICKET_ID then
								var_223_24 = var_223_24 + iter_223_19.dropNum
							end
						end
					end
				end

				if var_223_18 and item_manager:getItemNumber(var_223_18) > 0 and task_data[var_223_17].extra_drop then
					local var_223_28 = drop_manager:getDropMsg(task_data[var_223_17].extra_drop)

					if next(var_223_28.equips) then
						for iter_223_20, iter_223_21 in pairs(var_223_28.equips) do
							if iter_223_21.dropid == TWIST_TICKET_ID then
								var_223_24 = var_223_24 + iter_223_21.dropNum
							end
						end
					end
				end

				if var_223_19 == 2 then
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setSystemFontSize(16)
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setDimensions(400, 0)
				else
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setSystemFontSize(14)
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setDimensions(70, 0)
				end

				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setString(string.format("%s", var_223_25))
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("surplusLevelLabel"):setString(string.format(L_SURPLUS_LEVEL, var_223_21))
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("numLabel"):setString(var_223_24)
			elseif var_223_14 then
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setString(string.format("%s", taskName))
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("surplusLevelLabel"):setString(string.format(L_SURPLUS_STAR, var_223_14))
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("numLabel"):setString(var_223_14)
			else
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setSystemFontSize(16)
				self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setDimensions(400, 0)

				if var_223_9[1].vipItem and item_manager:getItemNumber(var_223_9[1].vipItem) > 0 and var_223_9[#var_223_9].vipItem and item_manager:getItemNumber(var_223_9[#var_223_9].vipItem) > 0 then
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setString("")
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("surplusLevelLabel"):setString(L_WAKEFUND_GET_FREE_REWARDS)
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("numLabel"):setString("")
				else
					local var_223_29 = 0

					for iter_223_22, iter_223_23 in pairs(var_223_9) do
						if item_manager:getItemNumber(iter_223_23.vipItem) == 0 then
							local var_223_30 = drop_manager:getDropMsg(task_data[iter_223_23.taskid].extra_drop)

							if next(var_223_30.equips) then
								for iter_223_24, iter_223_25 in pairs(var_223_30.equips) do
									if iter_223_25.dropid == TWIST_TICKET_ID then
										var_223_29 = var_223_29 + iter_223_25.dropNum
									end
								end
							end
						end
					end

					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("levelLabel"):setString("")
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("surplusLevelLabel"):setString(L_WAKEFUND_GET_FREE_REWARDS)
					self.passLevelAwardBtn:getChildByName("wakefunSpine"):getChildByName("numLabel"):setString(var_223_29)
				end
			end
		end)()
	end
end

function FightLayer:updateOnlineRewardReddot()
	if self.btn_onlinereward then
		if require("controller.alert_manager").alertsys[E_ALERT_ONLINE_REWARD] ~= nil then
			AlertManager:add_alert_by_config(self.btn_onlinereward, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(70, 80)
			})
		else
			AlertManager:add_alert_by_config(self.btn_onlinereward, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(70, 80)
			})
		end
	end
end

function FightLayer:updateActivityEntranceBtn()
	local var_230_0 = self.actEntranceBtn:getChildByName("image")
	local var_230_1 = self.panelMap:getChildByName("activity_entrance_tipText")

	if not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_ENTTRANCE) then
		var_230_0:setVisible(true)
		var_230_1:setVisible(true)
		self.actEntranceBtn:setColor(cc.c3b(117, 117, 117))
	else
		var_230_0:setVisible(false)
		var_230_1:setVisible(false)
		self.actEntranceBtn:setColor(cc.c3b(255, 255, 255))
	end
end

function FightLayer:initMainLineTaskUI()
	if not self.mainLineTaskBtn then
		self.mainLineTaskBtn = ccui.Layout:create()

		self.mainLineTaskBtn:setBackGroundImageColor(cc.c3b(255, 255, 255))
		self.mainLineTaskBtn:setContentSize(cc.size(200, 100))
		self.mainLineTaskBtn:setAnchorPoint(cc.p(0.5, 0.5))
		self.mainLineTaskBtn:setPosition(cc.p(100, GameDisplay.height - 360))
		self.mainLineTaskBtn:setName("mainLineTaskBtn")
		self.mainLineTaskBtn:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self.mainLineTaskBtn:setBackGroundColor(cc.c3b(0, 0, 0))
		self.mainLineTaskBtn:setTouchEnabled(true)
		self.panelMap:addChild(self.mainLineTaskBtn)

		local var_231_0 = ccui.ImageView:create("MainLineTask/bg_off.png", var_0_46)

		var_231_0:setTouchEnabled(false)
		var_231_0:setName("mainLineTaskBg")
		var_231_0:setAnchorPoint(cc.p(0, 0.5))
		var_231_0:setScale(1)
		var_231_0:setPosition(0, 50)
		self.mainLineTaskBtn:addChild(var_231_0)

		local var_231_1 = ccui.ImageView:create("equipment/1688999.png")

		var_231_1:setScale(0.5)
		var_231_1:setName("mainLineTaskReward")
		var_231_1:setAnchorPoint(cc.p(1, 0))
		self.mainLineTaskBtn:addChild(var_231_1)
		var_231_1:setPosition(cc.p(var_231_0:getContentSize().width - 20, 60 - var_231_0:getContentSize().height / 2))

		local var_231_2 = cc.Label:createWithTTF("任务名称", FONT_DES, 20)

		var_231_2:setPosition(cc.p(8, var_231_0:getContentSize().height - 15))
		var_231_2:setColor(cc.c3b(255, 255, 255))
		var_231_2:setAnchorPoint(cc.p(0, 0.5))
		var_231_2:setName("mainLineTaskName")
		self.mainLineTaskBtn:addChild(var_231_2)

		local var_231_3 = cc.Label:createWithTTF("任务内容", "fonts/yanwenzi.ttf", 14)

		var_231_3:setPosition(cc.p(8, var_231_0:getContentSize().height - 50))
		var_231_3:setAnchorPoint(cc.p(0, 0.5))
		var_231_3:setName("mainLineTaskDetails")
		self.mainLineTaskBtn:addChild(var_231_3)

		local var_231_4 = cc.Label:createWithTTF("", "fonts/yanwenzi.ttf", 14)

		var_231_4:setPosition(cc.p(8, var_231_0:getContentSize().height - 75))
		var_231_4:setAnchorPoint(cc.p(0, 0.5))
		var_231_4:setName("mainLineTaskDetailsDone")
		self.mainLineTaskBtn:addChild(var_231_4)

		local var_231_5 = ccui.ImageView:create("MainLineTask/rewardNum.png", var_0_46)

		var_231_5:setName("rewardNum")
		var_231_5:setAnchorPoint(cc.p(1, 0.5))
		var_231_5:setScale(1)
		var_231_5:setPosition(cc.p(var_231_0:getContentSize().width - 10, var_231_0:getContentSize().height - 80))
		self.mainLineTaskBtn:addChild(var_231_5)

		local var_231_6 = cc.Label:createWithTTF("10", FONT_NAME, 16)

		var_231_6:setPosition(cc.p(var_231_0:getContentSize().width - 10, var_231_0:getContentSize().height - 80))
		var_231_6:setAnchorPoint(cc.p(1, 0.5))
		var_231_6:setName("rewardNumText")
		self.mainLineTaskBtn:addChild(var_231_6)

		local var_231_7 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_46)

		var_231_7:setName("redDot")
		var_231_7:setAnchorPoint(cc.p(1, 0.5))
		var_231_7:setScale(1)
		var_231_7:setPosition(cc.p(var_231_0:getContentSize().width - 10, var_231_0:getContentSize().height - 40))
		self.mainLineTaskBtn:addChild(var_231_7)
		self:registerCustomEvent("updateMainLineTaskUI", function(arg_232_0)
			self:updateMainLineTaskUI()
		end)
	end

	self:updateMainLineTaskUI()
end

function FightLayer.updateMainLineTaskUI(arg_233_0)
	task_manager:get_task_info(function(arg_234_0)
		local var_234_0 = 0
		local task_data = require("data.task_data")
		local drop_manager = require("controller.drop_manager")

		arg_233_0.mainLineTaskBtn:getChildByName("redDot"):setVisible(false)

		if #task_manager.tasks[TASK_TYPE_CAREER] == 0 then
			if playermodel.class < 5 then
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):setVisible(false)
				arg_233_0.mainLineTaskBtn:getChildByName("rewardNumText"):setString("")
				arg_233_0.mainLineTaskBtn:getChildByName("rewardNum"):setVisible(false)
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskName"):setString(L_MAINLINE_UPGRADE_TASK)
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetails"):setString(L_MAINLINE_GO_UPGRADE)
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetailsDone"):setString("")
				arg_233_0.mainLineTaskBtn:addTouchEventListener(function(arg_235_0, arg_235_1)
					if arg_235_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("TopPlotListLayer")
				end)
				arg_233_0.mainLineTaskBtn:getChildByName("redDot"):setVisible(true)
			else
				arg_233_0.mainLineTaskBtn:setVisible(false)
			end
		else
			arg_233_0.mainLineTaskBtn:setVisible(true)

			for iter_234_0, iter_234_1 in pairs(task_manager.tasks[TASK_TYPE_CAREER]) do
				if iter_234_1.percent == 100 then
					var_234_0 = iter_234_0

					break
				end
			end

			if var_234_0 == 0 then
				var_234_0 = 1
			end

			arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):setVisible(true)
			arg_233_0.mainLineTaskBtn:getChildByName("rewardNum"):setVisible(true)

			if #drop_manager:getDropMsg(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].drop).equips ~= 0 then
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):loadTexture("equipment/" .. drop_manager:getDropMsg(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].drop).equips[1].dropid .. ".png")
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):setTouchEnabled(true)
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):addTouchEventListener(function(arg_236_0, arg_236_1)
					if arg_236_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopItemLayer", {
						itemid = drop_manager:getDropMsg(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].drop).equips[1].dropid
					})
				end)
				arg_233_0.mainLineTaskBtn:getChildByName("rewardNumText"):setString(drop_manager:getDropMsg(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].drop).equips[1].dropNum)
			elseif drop_manager:getDropMsg(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].drop).diamond ~= 0 then
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):loadTexture("equipment/1000000.png")
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskReward"):setTouchEnabled(false)
				arg_233_0.mainLineTaskBtn:getChildByName("rewardNumText"):setString(drop_manager:getDropMsg(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].drop).diamond)
			end

			arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskName"):setString(L_MAINLINE_UPGRADE_TASK)
			arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetails"):setString(task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].task_des)
			arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetailsDone"):setString("(" .. task_manager.tasks[TASK_TYPE_CAREER][var_234_0].finished .. "/" .. task_manager.tasks[TASK_TYPE_CAREER][var_234_0].need .. ")")
			arg_233_0.mainLineTaskBtn:stopAllActions()

			if task_manager.tasks[TASK_TYPE_CAREER][var_234_0].percent == 100 then
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskBg"):loadTexture("MainLineTask/bg_on.png", var_0_46)
				arg_233_0.mainLineTaskBtn:getChildByName("redDot"):setVisible(true)

				if task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].needs_type == 1 then
					arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetailsDone"):setString("(1/1)")
				elseif task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].needs_type == 1000 then
					arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetailsDone"):setString("(" .. task_manager.tasks[TASK_TYPE_CAREER][var_234_0].finished - 100 * (playermodel.class - 1) .. "/" .. task_manager.tasks[TASK_TYPE_CAREER][var_234_0].need - 100 * (playermodel.class - 1) .. ")")
				end

				arg_233_0.mainLineTaskBtn:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(100, GameDisplay.height - 360 + 8 * 1)), cc.MoveTo:create(0.15, cc.p(100, GameDisplay.height - 360 - 12 * 1)), cc.MoveTo:create(0.05, cc.p(100, GameDisplay.height - 360 + 4 * 1)), cc.DelayTime:create(0.8)))))
			else
				arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskBg"):loadTexture("MainLineTask/bg_off.png", var_0_46)

				if task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].needs_type == 1 then
					arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetailsDone"):setString("(0/1)")
				elseif task_data[task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid].needs_type == 1000 then
					arg_233_0.mainLineTaskBtn:getChildByName("mainLineTaskDetailsDone"):setString("(" .. task_manager.tasks[TASK_TYPE_CAREER][var_234_0].finished - 100 * (playermodel.class - 1) .. "/" .. task_manager.tasks[TASK_TYPE_CAREER][var_234_0].need - 100 * (playermodel.class - 1) .. ")")
				end
			end

			arg_233_0.mainLineTaskBtn:addTouchEventListener(function(arg_237_0, arg_237_1)
				if arg_237_1 ~= ccui.TouchEventType.ended then
					return
				end

				if task_manager.tasks[TASK_TYPE_CAREER][var_234_0].percent == 100 then
					arg_233_0:confirmAwards(task_manager.tasks[TASK_TYPE_CAREER][var_234_0].taskid)
				else
					LayerManager:pushInLayer("TopPlotListLayer")
				end
			end)
		end
	end)
end

function FightLayer.onBtnTaskJump(arg_238_0, arg_238_1)
	print("taskinfo.jump = ", arg_238_1.jump)

	if arg_238_1.jump then
		require("controller.goto_system_manager")

		local var_238_0 = {
			jump_to_system = arg_238_1.jump
		}

		var_238_0.config = system_jump_config[SYSTEMID[arg_238_1.jump]] and global_deepCopy(system_jump_config[SYSTEMID[arg_238_1.jump]].config)

		if var_238_0.config then
			if var_238_0.config.exitCallbackType == "function" then
				var_238_0.config.exitCallback = nil
			elseif var_238_0.config.exitCallbackType == "string" then
				var_238_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_238_0)
	end
end

function FightLayer.confirmAwards(arg_239_0, arg_239_1)
	task_manager:getTaskReward(arg_239_1, function(arg_240_0, arg_240_1)
		if arg_240_0 == 1 then
			global_gain(arg_240_1)

			if arg_240_1.items then
				while arg_240_1.items[1] do
					if var_0_39[arg_240_1.items[1].itemid].bag_item_type == 64 then
						require("view.Layer.GetRoleAnimationLayer")
						cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(arg_240_1.items[1].itemid), 1000)
					end
				end
			end

			AnalyticManager.main_line_task_reward({
				tasktype = TASK_TYPE_CAREER,
				taskid = arg_239_1
			})
		end

		arg_239_0:updateMainLineTaskUI()
	end)
end

function FightLayer:initPatrolUI()
	local var_241_0 = ccui.Button:create("FightLayer/arrow_bg.png", nil, "FightLayer/arrow_bg.png", var_0_46)

	var_241_0:setAnchorPoint(cc.p(0, 0.5))
	var_241_0:setPosition(0, GameDisplay.height * 0.86 - 350)
	var_241_0:setName("patrolPopBnt")
	self.panelMap:addChild(var_241_0)

	local var_241_1 = ccui.Layout:create()

	var_241_1:setTouchEnabled(true)
	var_241_1:setContentSize(cc.size(var_241_0:getContentSize().width + 30, var_241_0:getContentSize().height))
	var_241_0:addChild(var_241_1, -1)
	var_241_1:addTouchEventListener(function(arg_242_0, arg_242_1)
		if arg_242_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isChapterPass(2, 5) then
			global_ShowBlockWords(L_PATROL_LIST_LOCK)

			return
		end

		LayerManager:pushInLayer("PopQuickEntranceLayer")
	end)

	local var_241_2 = ccui.ImageView:create("FightLayer/arrow.png", var_0_46)

	var_241_2:setFlippedX(true)
	var_241_2:setPosition(var_241_0:getContentSize().width / 2, var_241_0:getContentSize().height / 2)
	var_241_0:addChild(var_241_2)
	var_241_0:addTouchEventListener(function(arg_243_0, arg_243_1)
		if arg_243_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not level_manager:isChapterPass(2, 5) then
			global_ShowBlockWords(L_PATROL_LIST_LOCK)

			return
		end

		LayerManager:pushInLayer("PopQuickEntranceLayer")
		AnalyticManager.click_fight_patrol_bnt()
	end)
end

function FightLayer:initBuffPanel()
	local var_244_0 = ccui.ImageView:create("FightLayer/bg_buffpanel.png", var_0_46)

	var_244_0:setPosition(cc.p(320, 346))
	var_244_0:setName("buffPanel")
	self.panelConsole:addChild(var_244_0, 20)

	local var_244_1 = {
		-2,
		-1,
		0,
		1,
		2
	}
	local var_244_2 = {
		cc.p(15, 30),
		cc.p(143, 24),
		cc.p(271, 20),
		cc.p(395, 20),
		cc.p(517, 24)
	}

	for iter_244_0 = 1, 5 do
		local var_244_3 = FightBuffPanel:createPlayerV2()

		var_244_3:setName("buffsp" .. iter_244_0)
		var_244_3:setAnchor(0)
		var_244_3:setShowCount(3)
		var_244_3:setIntervalY(var_244_1[iter_244_0])
		var_244_3:setPosition(var_244_2[iter_244_0])
		var_244_3:setVisible(false)
		var_244_0:addChild(var_244_3)
	end

	self.buffPanel = var_244_0

	function self.buffPanel:showBuff(arg_245_1)
		self:getChildByName("buffsp" .. arg_245_1):setVisible(true)
		FightManager.attachBuffPanel(arg_245_1, self:getChildByName("buffsp" .. arg_245_1))
	end

	function self.buffPanel:hideBuff(arg_246_1)
		self:getChildByName("buffsp" .. arg_246_1):setVisible(false)
		FightManager.detachBuffPanel(arg_246_1)
	end

	function self.buffPanel:updatePos(arg_247_1, arg_247_2)
		self:getChildByName("buffsp" .. arg_247_1):setPosition(arg_247_2)
	end

	function self.buffPanel:reset(arg_248_1)
		self:getChildByName("buffsp" .. arg_248_1):reset()
	end

	function self.buffPanel:hideAllBuff()
		for iter_249_0 = 1, 5 do
			self:getChildByName("buffsp" .. iter_249_0):setVisible(false)
			FightManager.detachBuffPanel(iter_249_0)
		end
	end
end

function FightLayer:attachBuffPanelOnBoss(arg_250_1)
	for iter_250_0 = 1, 5 do
		if arg_250_1[iter_250_0] then
			self.buffPanel:showBuff(iter_250_0)
			self.buffPanel:reset(iter_250_0)
		else
			self.buffPanel:hideBuff(iter_250_0)
		end
	end
end

function FightLayer:detachBuffPanel()
	self.buffPanel:hideAllBuff()
end

function FightLayer:updateArenatftWave()
	if not self.waveBottom then
		self.waveBottom = ccui.ImageView:create("FightLayer/wave_bottom.png", var_0_46)

		self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
		self.panelConsole:addChild(self.waveBottom, 999)

		local var_252_0 = ccui.ImageView:create("FightLayer/wave_label_tft.png", var_0_46)

		var_252_0:setPosition(cc.p(self.waveBottom:getContentSize().width / 2, self.waveBottom:getContentSize().height / 2))
		self.waveBottom:addChild(var_252_0, 999)

		local var_252_1 = cc.Label:createWithBMFont("fonts/boss_fightcapacity_red.fnt", arenatft_manager:getAttackProceed() .. "/" .. 3)

		var_252_1:setName("labelWave")
		var_252_1:setPosition(cc.p(self.waveBottom:getContentSize().width / 2 + 7, self.waveBottom:getContentSize().height / 2))
		self.waveBottom:addChild(var_252_1, 999)

		local var_252_2 = ccui.ImageView:create("FightLayer/wave_notice.png", var_0_46)

		var_252_2:setPosition(cc.p(-7, self.waveBottom:getContentSize().height / 2))
		self.waveBottom:addChild(var_252_2, 999)
		self.waveBottom:runAction(cc.MoveTo:create(0.2, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))
	else
		self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
		self.waveBottom:runAction(cc.MoveTo:create(0.4, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))
		self.waveBottom:getChildByName("labelWave"):setString(arenatft_manager:getAttackProceed() .. "/" .. 3)
	end
end

function FightLayer:updateWave()
	if level_manager:isBossTeam() then
		if not self.waveBottom then
			self.waveBottom = ccui.ImageView:create("FightLayer/wave_bottom.png", var_0_46)

			self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
			self.panelConsole:addChild(self.waveBottom, 999)

			local var_253_0 = ccui.ImageView:create("FightLayer/wave_label.png", var_0_46)

			var_253_0:setPosition(cc.p(self.waveBottom:getContentSize().width / 2, self.waveBottom:getContentSize().height / 2))
			self.waveBottom:addChild(var_253_0, 999)

			local var_253_1 = level_manager:isBigBossNow() and cc.Label:createWithBMFont("fonts/boss_fightcapacity_red.fnt", level_manager.getBossTeamProceed() .. "/" .. level_manager.getBossTeamSumNum()) or cc.Label:createWithBMFont("fonts/boss_fightcapacity_red.fnt", level_manager.getBossTeamProceed() .. "/" .. level_manager.getBossTeamSumNum())

			var_253_1:setName("labelWave")
			var_253_1:setPosition(cc.p(self.waveBottom:getContentSize().width / 2 + 7, self.waveBottom:getContentSize().height / 2))
			self.waveBottom:addChild(var_253_1, 999)

			local var_253_2 = ccui.ImageView:create("FightLayer/wave_notice.png", var_0_46)

			var_253_2:setPosition(cc.p(-7, self.waveBottom:getContentSize().height / 2))
			self.waveBottom:addChild(var_253_2, 999)
			self.waveBottom:runAction(cc.MoveTo:create(0.2, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))
		else
			self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
			self.waveBottom:runAction(cc.MoveTo:create(0.4, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))

			local var_253_3 = self.waveBottom:getChildByName("labelWave")

			if level_manager:isBigBossNow() then
				var_253_3:setString(level_manager.getBossTeamProceed() .. "/" .. level_manager.getBossTeamSumNum())
			else
				var_253_3:setString(level_manager.getBossTeamProceed() .. "/" .. level_manager.getBossTeamSumNum())
			end
		end
	end
end

function FightLayer:createWaveAnim()
	if level_manager:isBossTeam() and level_manager:isBossTeamLastButOne() and monster_manager.isBoss(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)) then
		local var_254_0 = cc.Node:create()

		self.panelConsole:addChild(var_254_0, 999)
		var_254_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.CallFunc:create(function()
			audio_manager:playFightEffect("sound/bosscoming", nil, FightManager.getBossSpeedUp())
		end), cc.RemoveSelf:create()))
	end
end

function FightLayer:removeWave()
	if self.waveBottom then
		self.waveBottom:runAction(cc.RemoveSelf:create())

		self.waveBottom = nil
	end
end

function FightLayer:updateInfinteTimePanel(arg_257_1)
	arg_257_1 = arg_257_1 or 0

	if not self.infinteTimePanel then
		local var_257_0 = ccui.ImageView:create("FightLayer/infinite_timebg.png", var_0_46)

		var_257_0:setAnchorPoint(cc.p(0, 0))
		var_257_0:setPosition(cc.p(0, GameDisplay.height - 250))

		self.infinteTimePanel = var_257_0

		self.panelConsole:addChild(self.infinteTimePanel, 99)

		local var_257_1 = cc.Label:createWithTTF(string.format(":%.2fs", arg_257_1), "fonts/name.ttf", 28)

		var_257_1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		var_257_1:setColor(cc.c3b(255, 255, 255))
		var_257_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_257_1:setName("infintetimelable")
		var_257_1:setPosition(cc.p(self.infinteTimePanel:getContentSize().width / 2 + 45, self.infinteTimePanel:getContentSize().height / 2))
		self.infinteTimePanel:addChild(var_257_1)
	else
		self.infinteTimePanel:getChildByName("infintetimelable"):setString(string.format(":%.2fs", arg_257_1))
	end
end

function FightLayer:updateInfinteAddScore()
	local var_258_0 = level_manager:getinfiniteChapterScore()

	if var_258_0 then
		if not self.infinteAddTimePanel then
			local var_258_1 = ccui.ImageView:create("FightLayer/infinite_addbg.png", var_0_46)

			var_258_1:setAnchorPoint(cc.p(0, 0))
			var_258_1:setPosition(cc.p(230, GameDisplay.height - 300))

			self.infinteAddTimePanel = var_258_1

			self.panelConsole:addChild(self.infinteAddTimePanel, 99)
			self.infinteAddTimePanel:setVisible(true)

			local var_258_2 = cc.Label:createWithTTF("+" .. var_258_0 .. "s", "fonts/name.ttf", 28)

			var_258_2:setColor(cc.c3b(255, 255, 255))
			var_258_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_258_2:setName("infinteaddtimelable")
			var_258_2:setPosition(cc.p(self.infinteAddTimePanel:getContentSize().width / 2, self.infinteAddTimePanel:getContentSize().height / 2))
			self.infinteAddTimePanel:addChild(var_258_2)
			self.infinteAddTimePanel:runAction((cc.Sequence:create(cc.DelayTime:create(1), cc.Spawn:create(cc.MoveTo:create(1, cc.p(100, GameDisplay.height - 300)), (cc.FadeOut:create(1))), (cc.CallFunc:create(function()
				self.infinteAddTimePanel:setVisible(false)
				self.infinteAddTimePanel:setOpacity(255)
				self.infinteAddTimePanel:setPositionX(230)
				self:updateInfinteTimePanel((require("controller.infinite_fight_manager"):get_remain_time()))
			end)))))
		else
			self.infinteAddTimePanel:setVisible(true)
			self.infinteAddTimePanel:getChildByName("infinteaddtimelable"):setString("+" .. var_258_0 .. "s")
			self.infinteAddTimePanel:runAction((cc.Sequence:create(cc.DelayTime:create(1), cc.Spawn:create(cc.MoveTo:create(1, cc.p(100, GameDisplay.height - 300)), (cc.FadeOut:create(1))), (cc.CallFunc:create(function()
				self.infinteAddTimePanel:setVisible(false)
				self.infinteAddTimePanel:setOpacity(255)
				self.infinteAddTimePanel:setPositionX(230)
				self:updateInfinteTimePanel((require("controller.infinite_fight_manager"):get_remain_time()))
			end)))))
		end
	end
end

function FightLayer:createInfinteWaveAnim()
	if level_manager:isInfinteTheLastBoss() then
		local var_261_0 = cc.Node:create()

		self.panelConsole:addChild(var_261_0, 999)
		var_261_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.5), cc.CallFunc:create(function()
			audio_manager:playFightEffect("sound/bosscoming", nil, FightManager.getBossSpeedUp())
		end), cc.RemoveSelf:create()))
	end
end

function FightLayer:updateInfinteWave()
	if FightManager.getFightType() == FIGHTTYPE_INFINITE then
		if not self.waveBottom then
			self.waveBottom = ccui.ImageView:create("FightLayer/wave_bottom.png", var_0_46)

			self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
			self.panelConsole:addChild(self.waveBottom, 999)

			local var_263_0 = ccui.ImageView:create("FightLayer/wave_label.png", var_0_46)

			var_263_0:setPosition(cc.p(self.waveBottom:getContentSize().width / 2, self.waveBottom:getContentSize().height / 2))
			self.waveBottom:addChild(var_263_0, 999)

			local var_263_2, var_263_3 = level_manager:getinfiniteWaveStr()
			local var_263_4 = cc.Label:createWithBMFont("fonts/boss_fightcapacity_red.fnt", var_263_3 .. "/" .. var_263_2)

			var_263_4:setName("labelWave")
			var_263_4:setPosition(cc.p(self.waveBottom:getContentSize().width / 2 + 9, self.waveBottom:getContentSize().height / 2))
			var_263_4:setScale(0.86)
			self.waveBottom:addChild(var_263_4, 999)

			local var_263_5 = ccui.ImageView:create("FightLayer/wave_notice.png", var_0_46)

			var_263_5:setPosition(cc.p(-7, self.waveBottom:getContentSize().height / 2))
			self.waveBottom:addChild(var_263_5, 999)
			self.waveBottom:runAction(cc.MoveTo:create(0.2, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))
		else
			self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
			self.waveBottom:runAction(cc.MoveTo:create(0.4, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))

			local var_263_6, var_263_7 = level_manager:getinfiniteWaveStr()

			if var_263_6 and var_263_7 then
				self.waveBottom:getChildByName("labelWave"):setString(var_263_7 .. "/" .. var_263_6)
			end
		end
	end
end

function FightLayer.initAiList(arg_264_0, ...)
	return
end

function FightLayer.removeAIList(arg_265_0, ...)
	return
end

function FightLayer.tryRemoveAIList(arg_266_0, ...)
	return
end

function FightLayer.updateAINum(arg_267_0, ...)
	return
end

function FightLayer.updateDeadAINum(arg_268_0, ...)
	return
end

function FightLayer:switchToExpeditionFight(arg_269_1)
	LayerManager:showTopBottomLayer({
		TopcostLayer = false,
		ListButtonLayer = false
	})

	self.showstat = var_0_50
	arg_269_1 = arg_269_1 or {}

	for iter_269_0 = 1, 5 do
		self.playerItems[iter_269_0]:updatePlayerInfo(arg_269_1[iter_269_0])
		FightManager.attachPlayerItem(iter_269_0, self.playerItems[iter_269_0])
	end

	self:attachBuffPanelOnBoss(arg_269_1)
	self.panelMap:setVisible(false)
	self.panelConsole:setVisible(true)
	self.panelFightTime:reset()
	self:showBattleFieldStatusOnSwitch()
	self:updateConsoleUIByFightType()
	self:playHorcruxEffectOnEnter(arg_269_1)
	self:removeGuidesOnLayer()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	barrage_manager:stop()
	self.barrage:setVisible(false)

	if not not_change_bgm then
		audio_manager:playbackgroundMusic(level_manager:getChapterBossBgm(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)), true, BOSS_VOLUME)
	end
end

function FightLayer:switchToExpeditionTowerFight()
	LayerManager:showTopBottomLayer({
		TopcostLayer = false,
		ListButtonLayer = false
	})

	self.showstat = var_0_50

	self:attachBuffPanelOnBoss({})
	self.panelMap:setVisible(false)
	self.panelConsole:setVisible(true)
	self.panelFightTime:reset()
	self:showBattleFieldStatusOnSwitch()
	self:updateConsoleUIByFightType()
	self:playHorcruxEffectOnEnter({})
	self:removeGuidesOnLayer()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	barrage_manager:stop()
	self.barrage:setVisible(false)
	self:updateFightAutoMode(false)
	self.btnAuto:setVisible(false)
	self.btnSpeedup:setVisible(true)

	if not not_change_bgm then
		audio_manager:playbackgroundMusic(level_manager:getChapterBossBgm(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)), true, BOSS_VOLUME)
	end
end

function FightLayer:resetExpeditionTowerPanel()
	if not self.expeditionTowerPanel then
		self.expeditionTowerPanel = require("view.Sprite.ExpeditionTowerListPanel"):create()

		self.expeditionTowerPanel:setName("towerListPanel")
		self.panelConsole:addChild(self.expeditionTowerPanel, 99)
		self:initExpeditionTowerSmallMap()
	else
		self.expeditionTowerPanel:resetPanel()
		self:updateExpeditionTowerSmallMap()
		FightManager.registerWorldMapListener(self.expeditionTowerPanel.camera, self.expeditionTowerPanel.camera.listenerFunc)
	end
end

function FightLayer:initExpeditionTowerSmallMap()
	local var_274_0 = FightManager.getWorldMapSize()
	local var_274_1 = ccui.ImageView:create("TowerDefenceListPanel/tower_small_map_bg.png", var_0_46)

	var_274_1:setPosition(320, GameDisplay.height - 120)
	var_274_1:setName("tower_defence_map")
	self.expeditionTowerPanel:addChild(var_274_1, 100)

	local var_274_2 = var_274_1:getContentSize().width

	var_274_1.cameraConf = FightManager.getCamera().getBaseConfig()
	var_274_1.ratio = var_274_2 / var_274_0

	local var_274_3 = ccui.Layout:create()

	var_274_3:setName("childrenPanel")
	var_274_1:addChild(var_274_3)

	var_274_3.width = var_274_2
	var_274_3.childrenList = {}

	local var_274_4 = ccui.ImageView:create("TowerDefenceListPanel/small_map_frame.png", var_0_46)

	var_274_4:setScale9Enabled(true)
	var_274_4:setCapInsets(cc.rect(12, 0, 80, 51))

	local var_274_5 = 640 * (var_274_2 / var_274_0)

	var_274_5 = 640 * (var_274_2 / var_274_0) < 80 and 80 or var_274_5

	var_274_4:setContentSize(cc.size(var_274_5, var_274_4:getContentSize().height))
	var_274_4:setTouchEnabled(true)
	var_274_4:setPosition(cc.p(FightManager.convertCameraToWorldSpace() * (var_274_2 / var_274_0), var_274_1:getContentSize().height / 2))
	var_274_1:addChild(var_274_4)

	local function var_274_6(arg_275_0)
		return arg_275_0 / var_274_1.ratio
	end

	var_274_4.moveManual = false

	var_274_4:addTouchEventListener(function(arg_276_0, arg_276_1)
		if arg_276_1 == ccui.TouchEventType.began then
			var_274_4.moveManual = true

			FightManager.getCamera().lockCameraManual(var_274_6(arg_276_0:getPositionX()))
		elseif arg_276_1 == ccui.TouchEventType.moved then
			var_274_4.moveManual = true

			local var_276_0 = var_274_1:convertToNodeSpace(arg_276_0:getTouchMovePosition())

			arg_276_0:setPositionX(var_276_0.x)
			print(var_276_0.x, var_274_6(var_276_0.x), var_274_2, var_274_0)
			FightManager.getCamera().lockCameraManual(var_274_6(var_276_0.x))
		else
			var_274_4.moveManual = false

			FightManager.getCamera().unlockCameraManual()
		end
	end)

	function var_274_4.listenerFunc()
		if var_274_4.moveManual then
			return
		end

		var_274_4:setPosition(cc.p(FightManager.convertCameraToWorldSpace() * var_274_1.ratio, var_274_1:getContentSize().height / 2))
	end

	self.expeditionTowerPanel.camera = var_274_4

	FightManager.registerWorldMapListener(var_274_4, var_274_4.listenerFunc)
end

function FightLayer:updateExpeditionTowerSmallMap()
	if not self.expeditionTowerPanel then
		return
	end

	local var_278_0 = self.expeditionTowerPanel:getChildByName("tower_defence_map")
	local var_278_1 = var_278_0:getContentSize().width / FightManager.getWorldMapSize()

	var_278_0.cameraConf = FightManager.getCamera().getBaseConfig()
	var_278_0.ratio = var_278_1

	self.expeditionTowerPanel.camera:setPosition(cc.p(FightManager.convertCameraToWorldSpace() * var_278_1, var_278_0:getContentSize().height / 2))
end

function FightLayer:switchToAutoChessFight()
	LayerManager:showTopBottomLayer({
		TopcostLayer = false,
		ListButtonLayer = false
	})

	self.showstat = var_0_50

	self:attachBuffPanelOnBoss({})
	self.panelMap:setVisible(false)
	self.panelConsole:setVisible(true)
	self.panelConsole:getChildByName("panelbg"):setVisible(false)
	self.panelConsole:getChildByName("buffPanel"):setVisible(false)
	self.panelFightTime:reset()
	self:showBattleFieldStatusOnSwitch()
	self:updateConsoleUIByFightType()
	self:playHorcruxEffectOnEnter({})
	self:removeGuidesOnLayer()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	barrage_manager:stop()
	self.barrage:setVisible(false)
	self:updateFightAutoMode(false)
	self.btnAuto:setVisible(false)
	self.btnSpeedup:setVisible(true)

	if not not_change_bgm then
		audio_manager:playbackgroundMusic(level_manager:getChapterBossBgm(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)), true, BOSS_VOLUME)
	end

	for iter_279_0, iter_279_1 in ipairs(self.playerItems) do
		iter_279_1:setVisible(false)
		iter_279_1:setOpacity(0)
	end
end

function FightLayer:switchToTowerFight()
	LayerManager:showTopBottomLayer({
		TopcostLayer = false,
		ListButtonLayer = false
	})

	self.showstat = var_0_50

	self:attachBuffPanelOnBoss({})
	self.panelMap:setVisible(false)
	self.panelConsole:setVisible(true)
	self.panelFightTime:reset()
	self:showBattleFieldStatusOnSwitch()
	self:updateConsoleUIByFightType()
	self:playHorcruxEffectOnEnter({})
	self:removeGuidesOnLayer()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:updateGuidesOnLayer()
	end)))
	barrage_manager:stop()
	self.barrage:setVisible(false)
	self:updateFightAutoMode(false)
	self.btnAuto:setVisible(false)
	self.btnSpeedup:setVisible(true)

	if not not_change_bgm then
		audio_manager:playbackgroundMusic(level_manager:getChapterBossBgm(playermodel.curMode, level_manager:getCurChapter(playermodel.curMode)), true, BOSS_VOLUME)
	end
end

function FightLayer:resetTowerDefencePanel()
	if not self.towerDefencePanel then
		self.towerDefencePanel = require("view.Sprite.TowerDefenceListPanel"):create()

		self.towerDefencePanel:setName("towerListPanel")
		self.panelConsole:addChild(self.towerDefencePanel, 99)
		self:initTowerDefenceSmallMap()
	else
		self.towerDefencePanel:resetPanel()
		self:updateTowerDefenceSmallMap()
		FightManager.registerWorldMapListener(self.towerDefencePanel.camera, self.towerDefencePanel.camera.listenerFunc)
	end
end

function FightLayer:initTowerDefenceSmallMap()
	local var_284_0 = FightManager.getWorldMapSize()
	local var_284_1 = ccui.ImageView:create("TowerDefenceListPanel/tower_small_map_bg.png", var_0_46)

	var_284_1:setPosition(320, GameDisplay.height - 120)
	var_284_1:setName("tower_defence_map")
	self.towerDefencePanel:addChild(var_284_1, 100)

	local var_284_2 = var_284_1:getContentSize().width

	var_284_1.cameraConf = FightManager.getCamera().getBaseConfig()
	var_284_1.ratio = var_284_2 / var_284_0

	local var_284_3 = ccui.Layout:create()

	var_284_3:setName("childrenPanel")
	var_284_1:addChild(var_284_3)

	var_284_3.width = var_284_2
	var_284_3.childrenList = {}

	local var_284_4 = ccui.ImageView:create("TowerDefenceListPanel/small_map_frame.png", var_0_46)

	var_284_4:setScale9Enabled(true)
	var_284_4:setCapInsets(cc.rect(12, 0, 80, 51))

	local var_284_5 = 640 * (var_284_2 / var_284_0)

	var_284_5 = 640 * (var_284_2 / var_284_0) < 80 and 80 or var_284_5

	var_284_4:setContentSize(cc.size(var_284_5, var_284_4:getContentSize().height))
	var_284_4:setTouchEnabled(true)
	var_284_4:setPosition(cc.p(FightManager.convertCameraToWorldSpace() * (var_284_2 / var_284_0), var_284_1:getContentSize().height / 2))
	var_284_1:addChild(var_284_4)

	local function var_284_6(arg_285_0)
		return arg_285_0 / var_284_1.ratio
	end

	var_284_4.moveManual = false

	var_284_4:addTouchEventListener(function(arg_286_0, arg_286_1)
		if arg_286_1 == ccui.TouchEventType.began then
			var_284_4.moveManual = true

			FightManager.getCamera().lockCameraManual(var_284_6(arg_286_0:getPositionX()))
		elseif arg_286_1 == ccui.TouchEventType.moved then
			var_284_4.moveManual = true

			local var_286_0 = var_284_1:convertToNodeSpace(arg_286_0:getTouchMovePosition())

			arg_286_0:setPositionX(var_286_0.x)
			print(var_286_0.x, var_284_6(var_286_0.x), var_284_2, var_284_0)
			FightManager.getCamera().lockCameraManual(var_284_6(var_286_0.x))
		else
			var_284_4.moveManual = false

			FightManager.getCamera().unlockCameraManual()
		end
	end)

	function var_284_4.listenerFunc()
		if var_284_4.moveManual then
			return
		end

		var_284_4:setPosition(cc.p(FightManager.convertCameraToWorldSpace() * var_284_1.ratio, var_284_1:getContentSize().height / 2))
	end

	self.towerDefencePanel.camera = var_284_4

	FightManager.registerWorldMapListener(var_284_4, var_284_4.listenerFunc)
end

function FightLayer:updateTowerDefenceSmallMap()
	if not self.towerDefencePanel then
		return
	end

	local var_288_0 = self.towerDefencePanel:getChildByName("tower_defence_map")
	local var_288_1 = var_288_0:getContentSize().width / FightManager.getWorldMapSize()

	var_288_0.cameraConf = FightManager.getCamera().getBaseConfig()
	var_288_0.ratio = var_288_1

	self.towerDefencePanel.camera:setPosition(cc.p(FightManager.convertCameraToWorldSpace() * var_288_1, var_288_0:getContentSize().height / 2))
end

function FightLayer:updateSmallMapChildrenPos()
	if FightManager.getFightType() == FIGHTTYPE_TOWER or FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER then
		local var_289_0

		if FightManager.getFightType() == FIGHTTYPE_TOWER then
			var_289_0 = self.towerDefencePanel
		elseif FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER then
			var_289_0 = self.expeditionTowerPanel
		end

		if not var_289_0 then
			return
		end

		local var_289_1 = var_289_0:getChildByName("tower_defence_map"):getChildByName("childrenPanel")
		local var_289_2 = {}

		local function var_289_3(arg_290_0)
			local var_290_0 = arg_290_0.model.headimg
			local var_290_1, var_290_2 = arg_290_0:getPosition()
			local var_290_3 = FightManager.convertToWorldSpace(var_290_2)
			local var_290_4 = var_289_1:getChildByName(arg_290_0.index)

			if not var_290_4 then
				var_290_4 = ccui.ImageView:create("TowerDefenceListPanel/head_bg.png", var_0_46)

				var_290_4:setName(arg_290_0.index)
				var_289_1:addChild(var_290_4)

				local var_290_5

				if config._DEBUG then
					var_290_5 = cc.Sprite:create("TowerDefenceListPanel/head_bg.png") or cc.Sprite:createWithSpriteFrameName("TowerDefenceListPanel/head_bg.png")
				end

				var_290_5:setPosition(var_290_4:getContentSize().width / 2, var_290_4:getContentSize().height / 2)

				local var_290_6 = cc.ClippingNode:create(var_290_5)

				var_290_6:setInverted(false)
				var_290_6:setAlphaThreshold(0.5)
				var_290_6:setPosition(0, 0)
				var_290_4:addChild(var_290_6)

				local var_290_7 = cc.Sprite:create(ROLE_HEAD_IMAGE_PATH .. var_290_0 .. ".png")

				var_290_7:setPosition(var_290_4:getContentSize().width / 2, var_290_4:getContentSize().height / 2)
				var_290_7:setScale(0.21)
				var_290_6:addChild(var_290_7)

				local var_290_8 = ccui.ImageView:create("TowerDefenceListPanel/" .. (arg_290_0.charactertype == "player" and "head_player.png" or "head_enemy.png"), var_0_46)

				var_290_8:setPosition(var_290_4:getContentSize().width / 2, var_290_4:getContentSize().height / 2)
				var_290_4:addChild(var_290_8)

				var_289_1.childrenList[arg_290_0.index] = var_290_4
			end

			var_290_4:setPosition(var_289_1.width * FightManager.convertToWorldSpace(var_290_1) / FightManager.getWorldMapSize(), 12)

			var_289_2[arg_290_0.index] = true
		end

		for iter_289_0, iter_289_1 in pairs(FightManager.players) do
			if iter_289_1:isVisible() and not iter_289_1:isBoss() then
				var_289_3(iter_289_1)
			end
		end

		for iter_289_2, iter_289_3 in pairs(FightManager.enemies) do
			if iter_289_3:isVisible() and not iter_289_3:isBoss() then
				var_289_3(iter_289_3)
			end
		end

		for iter_289_4, iter_289_5 in pairs(var_289_1.childrenList) do
			if not var_289_2[iter_289_4] then
				var_289_1.childrenList[iter_289_4]:removeFromParent()

				var_289_1.childrenList[iter_289_4] = nil
			end
		end
	end
end

function FightLayer.updateSpecialUIByFightTypeOnPlayerDie(arg_291_0)
	if FightManager.getFightType() == FIGHTTYPE_TOWER then
		-- block empty
	end
end

function FightLayer:createTowerDefenceWaveAnim()
	local var_292_0 = cc.Node:create()

	self.panelConsole:addChild(var_292_0, 999)
	var_292_0:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		audio_manager:playFightEffect("sound/bosscoming", nil, FightManager.getBossSpeedUp())
	end), cc.RemoveSelf:create()))
end

function FightLayer:updateTowerDefenceWave()
	local var_294_0 = ""
	local var_294_1 = 1

	if FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER then
		var_294_0, var_294_1 = expedition_manager:getTeamIdxStr()
	else
		var_294_0, var_294_1 = tower_defence_manager:getTeamIdxStr()
	end

	if not self.waveBottom then
		self.waveBottom = ccui.ImageView:create("FightLayer/wave_bottom.png", var_0_46)

		self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
		self.panelConsole:addChild(self.waveBottom, 999)

		local var_294_2 = ccui.ImageView:create("FightLayer/wave_label_tft.png", var_0_46)

		var_294_2:setPosition(cc.p(self.waveBottom:getContentSize().width / 2, self.waveBottom:getContentSize().height / 2))
		self.waveBottom:addChild(var_294_2, 999)

		local var_294_3 = cc.Label:createWithBMFont("fonts/boss_fightcapacity_red.fnt", var_294_0)

		var_294_3:setScale(var_294_1)
		var_294_3:setName("labelWave")
		var_294_3:setPosition(cc.p(self.waveBottom:getContentSize().width / 2 + 7, self.waveBottom:getContentSize().height / 2))
		self.waveBottom:addChild(var_294_3, 999)

		local var_294_4 = ccui.ImageView:create("FightLayer/wave_notice.png", var_0_46)

		var_294_4:setPosition(cc.p(-7, self.waveBottom:getContentSize().height / 2))
		self.waveBottom:addChild(var_294_4, 999)
		self.waveBottom:runAction(cc.MoveTo:create(0.2, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))
	else
		self.waveBottom:setPosition(cc.p(698, GameDisplay.height - GameDisplay.notch_height - 190))
		self.waveBottom:runAction(cc.MoveTo:create(0.4, cc.p(570, GameDisplay.height - GameDisplay.notch_height - 190)))

		local var_294_5 = self.waveBottom:getChildByName("labelWave")

		var_294_5:setString(var_294_0)
		var_294_5:setScale(var_294_1)
	end
end

function FightLayer:updateSubRate(arg_295_1)
	if not self.subDemgPercent then
		local var_295_0 = ccui.ImageView:create("FightLayer/subDemgPercent.png", var_0_46)

		var_295_0:setAnchorPoint(cc.p(1, 0.5))
		var_295_0:setPositionX(GameDisplay.width + 10)
		var_295_0:setPositionY(GameDisplay.height - 250)
		self.rootLayer:addChild(var_295_0, 99)

		self.subDemgPercent = var_295_0

		local var_295_1 = ccui.TextBMFont:create(arg_295_1, "fonts/array_fightcapacity_number2.fnt")

		var_295_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_295_1:setPosition(cc.p(self.subDemgPercent:getContentSize().width / 2 + 55, self.subDemgPercent:getContentSize().height / 2))
		self.subDemgPercent:addChild(var_295_1)

		self.subPerNum = var_295_1
	else
		self.subDemgPercent:setVisible(true)
	end

	self.subPerNum:setString(arg_295_1)
	self.subPerNum:setScale(2)
	self.subPerNum:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1)))
end

function FightLayer:hideSubUI()
	if self.subDemgPercent then
		self.subDemgPercent:setVisible(false)
	end
end

function FightLayer.generateCourseField(arg_297_0, arg_297_1)
	local var_297_0 = require("controller.course_cultivate_manager").getInstance()
	local var_297_1 = {}

	for iter_297_0, iter_297_1 in ipairs(playermodel.curSoul) do
		var_297_1 = var_297_0:getEffectBuffType(iter_297_1.fight_girl)

		if #var_297_1 >= 2 then
			break
		end
	end

	for iter_297_2, iter_297_3 in ipairs(var_297_1) do
		if iter_297_3 == "basic" then
			table.insert(arg_297_1, {
				icon = "FightLayer/map_icon.png",
				des = L_LEASCON_SUCC[1]
			})
		elseif iter_297_3 == "element" then
			table.insert(arg_297_1, {
				icon = "FightLayer/map_icon.png",
				des = L_LEASCON_SUCC[2]
			})
		end
	end
end

function FightLayer:handleShowLimittimePackages(arg_298_1)
	if not arg_298_1 or not arg_298_1.packages then
		return
	end

	RoleDefault:getInstance():setBoolForKey("isClickLimit", false)
	self:queryLimitRechargeInfos(true, arg_298_1.packages[1])
end

function FightLayer:adaptFightLayerTopRightPos()
	for iter_299_0, iter_299_1 in pairs({
		{
			"btn_act_entrance"
		},
		{
			"btn_limittime_package"
		},
		{
			"btn_recruit"
		},
		{
			"btn_onlinereward"
		},
		{
			"btn_novicerecharge"
		},
		{
			"btn_returnback_recharge"
		},
		{
			"btn_promoterecharge"
		},
		{
			"btn_newrulespacks"
		},
		{
			"btn_popReturnBackPacks"
		}
	}) do
		local var_299_0 = self.panelMap

		for iter_299_2, iter_299_3 in pairs(iter_299_1) do
			var_299_0 = var_299_0:getChildByName(iter_299_3)
		end

		if var_299_0 and var_299_0:isVisible() == true then
			var_299_0:setPositionY(987 - 0 * ((0 == 1 or nil) and 100))

			var_299_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_299_0:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_299_0:setPositionY(var_299_0.full_posY)
		end
	end
end

function FightLayer:initBtnPcakages()
	self.btnPackages = ccui.Button:create("public/button/btn_limittime_package.png", nil, "public/button/btn_limittime_package.png", var_0_46)

	self.btnPackages:setName("btn_limittime_package")
	self.panelMap:addChild(self.btnPackages)
	self.btnPackages:setPosition(GameDisplay.width - self.btnPackages:getContentSize().width / 2 - 25, GameDisplay.height * 0.86 - 110)

	local var_300_0 = ccui.Text:create(Utility:formatTimeStr(math.max((self.maxFinishTime or 0) - require("controller.time_check_manager"):getCurTime(), 0) or 0), "fonts/name.ttf", 15)

	var_300_0:setPosition(42, 10)
	self.btnPackages:addChild(var_300_0)
	var_300_0:setName("labelRemainTime")
	Utility:addClickEventListener(self.btnPackages, function()
		self:showLimitRechargeLayer()
	end)
	self:adaptFightLayerTopRightPos()
end

function FightLayer:updateBtnPackages()
	local var_302_0 = false

	self.maxFinishTime = 0

	for iter_302_0, iter_302_1 in ipairs(self.limitPackages or {}) do
		if iter_302_1.buy_limit > iter_302_1.have_bought then
			var_302_0 = true
		end

		local var_302_1 = global_get_time_by_date(iter_302_1.finishtime or 0)

		if self.maxFinishTime == 0 then
			self.maxFinishTime = var_302_1
		elseif var_302_1 < self.maxFinishTime then
			self.maxFinishTime = var_302_1
		end
	end

	local var_302_2 = self.btnPackages:getChildByName("labelRemainTime")
	local var_302_3 = math.max((self.maxFinishTime or 0) - require("controller.time_check_manager"):getCurTime(), 0)

	var_302_2:setString(Utility:formatTimeStr(var_302_3))
	var_302_2:stopAllActions()
	var_302_2:runAction((Utility:createClockTimerAction(var_302_2, 1, var_302_3, function(arg_303_0)
		var_302_2:setString(Utility:formatTimeStr(arg_303_0))

		if arg_303_0 <= 0 then
			self.btnPackages:setVisible(false)
			self:adaptFightLayerTopRightPos()
		end
	end)))
	self.btnPackages:setVisible(var_302_3 > 0)
	self:adaptFightLayerTopRightPos()

	if var_302_0 and not RoleDefault:getInstance():getBoolForKey("isClickLimit", false) then
		global_add_alert_tag(self.btnPackages, {
			x = 100,
			y = 100
		})
	else
		global_remove_alert_tag(self.btnPackages)
	end
end

function FightLayer:showLimitRechargeLayer(arg_304_1)
	local var_304_0

	for iter_304_0 = 1, #self.limitPackages do
		if global_get_time_by_date(self.limitPackages[iter_304_0].finishtime or 0) == self.maxFinishTime then
			var_304_0 = self.limitPackages[iter_304_0].id
		end
	end

	if var_304_0 then
		if shop_timelimit_data[var_304_0] and shop_timelimit_data[var_304_0].group == 70001 then
			LayerManager:switchShowLayer("SupermarketLayer", {
				tab = 86
			})
		else
			LayerManager:pushInLayer("PopLimitTimePackageLayer", {
				packages = self.limitPackages,
				exitCallBack = function()
					self:queryLimitRechargeInfos()
				end,
				addPackage = arg_304_1
			})
		end
	end
end

function FightLayer.queryLimitRechargeInfos(arg_306_0, arg_306_1, arg_306_2)
	local recharge_data = require("data.recharge_data")
	local var_306_1 = require("controller.time_check_manager"):getCurTime()

	require("controller.recharge_manager"):getRechargeInfo(function(arg_307_0, arg_307_1, arg_307_2)
		if arg_307_0 == 1 then
			local var_307_0 = {}

			for iter_307_0, iter_307_1 in ipairs(arg_307_1 or {}) do
				if recharge_data[iter_307_1.id] and recharge_data[iter_307_1.id].type == 21 and global_get_time_by_date(iter_307_1.finishtime or 0) > var_306_1 and iter_307_1.have_bought < iter_307_1.buy_limit then
					iter_307_1.order = recharge_data[iter_307_1.id].order or 0

					local var_307_2 = recharge_data[iter_307_1.id].dropid

					if not recharge_data[iter_307_1.id].dropid then
						if var_0_39[recharge_data[iter_307_1.id].dropitem] then
							var_307_2 = var_0_39[recharge_data[iter_307_1.id].dropitem].mode_id or nil
						end
					end

					iter_307_1.dropid = var_307_2
					var_307_0[#var_307_0 + 1] = iter_307_1
				end
			end

			table.sort(var_307_0, function(arg_308_0, arg_308_1)
				return arg_308_0.order < arg_308_1.order
			end)

			arg_306_0.limitPackages = var_307_0

			if not arg_306_0.btnPackages then
				arg_306_0:initBtnPcakages()
			end

			arg_306_0:updateBtnPackages()

			if arg_306_1 and not next(var_307_0) then
				print("warn: no limittime packages")

				return
			end

			if arg_306_1 then
				arg_306_0:showLimitRechargeLayer(arg_306_2)
			end
		end
	end)
end

function FightLayer:initDownloadFightResourceListener()
	self._downloadid = nil
	self._downloadinglist = {}

	self:registerCustomEvent("DOWNLOAD_FIGHT_RESOURCE", function(arg_310_0)
		self:addLoadingAni()
		self:startDownload(arg_310_0.id, arg_310_0.list)
	end)
	self:registerCustomEvent("CANCEL_DOWNLOAD_FIGHT_RESOURCE", function(arg_311_0)
		self:removeLoadingAni()
	end)
	self:registerCustomEvent("DOWNLOAD_EVENT_COMPLETE", function(arg_312_0)
		if self._downloadinglist[arg_312_0.fileName] then
			self._downloadinglist[arg_312_0.fileName] = nil

			if not next(self._downloadinglist) then
				self:onDownloadComplete()
			end
		end
	end)
end

function FightLayer:needDownload(arg_313_1, arg_313_2)
	self:addLoadingAni()
	self:startDownload(arg_313_1, arg_313_2)
end

function FightLayer:addLoadingAni()
	if not self:getChildByName("downloadmask") then
		local var_314_0 = cc.Sprite:create("loading/loadingmask.png")

		var_314_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
		var_314_0:setName("downloadmask")
		self:addChild(var_314_0, 1)

		local var_314_1 = cc.Sprite:create("loading/loadingcircle.png")

		var_314_1:setPosition(cc.p(var_314_0:getContentSize().width / 2, var_314_0:getContentSize().height / 2))
		var_314_0:addChild(var_314_1)

		local var_314_2 = cc.Sprite:create("loading/fightloadingword.png")

		var_314_2:setPosition(cc.p(var_314_0:getContentSize().width / 2, var_314_0:getContentSize().height / 2 - 1 * var_314_1:getContentSize().height / 2 - 15))
		var_314_0:addChild(var_314_2)
		var_314_1:runAction(cc.RepeatForever:create(cc.RotateBy:create(1, 360)))
	end

	self:getChildByName("downloadmask"):setVisible(true)
end

function FightLayer:removeLoadingAni()
	self._downloadid = nil
	self._downloadinglist = {}

	if self:getChildByName("downloadmask") then
		self:getChildByName("downloadmask"):runAction(cc.RemoveSelf:create())
	end
end

function FightLayer:startDownload(arg_316_1, arg_316_2)
	self._downloadid = arg_316_1
	self._downloadinglist = {}

	for iter_316_0, iter_316_1 in ipairs(arg_316_2) do
		self._downloadinglist[iter_316_1.filename] = true
	end

	require("controller.filedownloader.download_manager"):insertDownloadTasks(arg_316_2, "fight")
end

function FightLayer:onDownloadComplete()
	if FightManager.resume(self._downloadid) then
		self:removeLoadingAni()
	end
end
