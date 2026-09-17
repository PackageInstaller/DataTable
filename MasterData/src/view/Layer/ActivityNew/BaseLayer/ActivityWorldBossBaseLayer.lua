ActivityWorldBossBaseLayer = class("ActivityWorldBossBaseLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local time_check_manager = require("controller.time_check_manager")
local adverture_random_manager = require("controller.adverture_random_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local level_manager = require("controller.level_manager")
local servant_data = require("data.servant_data")
local var_0_10 = require("controller.formation.formation_manager"):getInstance()
local drop_manager = require("controller.drop_manager")
local worldboss_data = require("data.worldboss_data")
local battlefield_status_data = require("data.battlefield_status_data")
local var_0_14 = 110
local var_0_15 = 1
local var_0_16 = 2
local var_0_17 = 3
local var_0_18 = {}

var_0_18[1] = "小怪阶段"
var_0_18[2] = "精英怪阶段"
var_0_18[3] = "BOSS阶段"

local function var_0_19(arg_2_0)
	return "解锁时间:" .. string.format("%02d:%02d:%02d", math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60), math.floor(arg_2_0 % 60))
end

function ActivityWorldBossBaseLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityWorldBossBaseLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityWorldBossBaseLayer:init(arg_4_1)
	self.activityId = arg_4_1.activityId
	self.layerName = "Activity_worldboss_" .. self.activityId
	self.respath = "Activity_worldboss_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	self:initTouchEvent()
	activity_manager:get_worldboss_data(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			for iter_5_0, iter_5_1 in pairs(self.enemys) do
				if iter_5_1.activityScheduler then
					time_check_manager:removeUpdatePool(iter_5_1.activityScheduler)

					self.activityScheduler = nil
				end
			end

			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
		end
	end)
	self:createAni()

	if arg_4_1.entercallback then
		arg_4_1.entercallback()
	end
end

function ActivityWorldBossBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_WORLDBOSS_UPDATE, function(arg_7_0)
		self:updateUI(arg_7_0)
	end)
end

function ActivityWorldBossBaseLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.boss_name = ccui.Helper:seekWidgetByName(self.title, "bossname_label")
	self.booshp = self.title:getChildByName("bosshp")
	self.stagela_bg = self.rootLayer:getChildByName("stage_bg")
	self.stagelabel = self.stagela_bg:getChildByName("Label_61")
	self.btn_rank = self.rootLayer:getChildByName("btn_rank")
	self.btn_reward = self.rootLayer:getChildByName("btn_reward")
	self.btn_task = self.rootLayer:getChildByName("btn_task")
	self.enemy_1 = self.rootLayer:getChildByName("enemy_1")
	self.enemy_2 = self.rootLayer:getChildByName("enemy_2")
	self.enemy_sp = self.rootLayer:getChildByName("enemy_sp")
	self.enemy_boss = self.rootLayer:getChildByName("enemy_1_2")
	self.btn_return = self.rootLayer:getChildByName("btn_return")
	self.servant_add_title = self.rootLayer:getChildByName("servant_add_title")
	self.servant_add_bg = self.rootLayer:getChildByName("servant_add_bg")
	self.fight_info_bg = self.rootLayer:getChildByName("fight_info_bg")
	self.ranklabel = self.fight_info_bg:getChildByName("rank")
	self.scorelabel = self.fight_info_bg:getChildByName("score")
	self.chancelabel = self.fight_info_bg:getChildByName("chance")
	self.damage_add = self.fight_info_bg:getChildByName("add_1")
	self.hp_add = self.fight_info_bg:getChildByName("add_2")
	self.enemy_1.stagetype = var_0_15
	self.enemy_2.stagetype = var_0_15
	self.enemy_sp.stagetype = var_0_16
	self.enemy_boss.stagetype = var_0_17
	self.enemys = {}

	table.insert(self.enemys, self.enemy_1)
	table.insert(self.enemys, self.enemy_2)
	table.insert(self.enemys, self.enemy_sp)
	table.insert(self.enemys, self.enemy_boss)

	local var_8_0, var_8_1 = self.booshp:getPosition()

	self.booshp:removeFromParent()

	local var_8_2 = ccui.Slider:create()

	var_8_2:setName("slider")
	var_8_2:loadBarTexture(self.respath .. "progress_bg.png", var_0_0)
	var_8_2:loadProgressBarTexture(self.respath .. "progress_on.png", var_0_0)
	self.title:addChild(var_8_2)

	self.booshp = var_8_2

	self.booshp:setPosition(var_8_0, var_8_1)
	self.booshp:setAnchorPoint((self.booshp:getAnchorPoint()))

	local var_8_3 = ccui.ListView:create()

	var_8_3:setDirection(ccui.ScrollViewDir.horizontal)
	var_8_3:setContentSize(self.servant_add_bg:getContentSize().width, self.servant_add_bg:getContentSize().height)
	var_8_3:setPosition(cc.p(20, 10))
	self.servant_add_bg:addChild(var_8_3)
	var_8_3:setBounceEnabled(true)
	var_8_3:setName("servant_add_list")

	self.servant_add_list = var_8_3

	self.title:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "worldboss_" .. self.activityId
		})
	end)
end

function ActivityWorldBossBaseLayer:updateUI(arg_10_1)
	local var_10_0 = arg_10_1.infos[var_0_15]
	local var_10_1 = arg_10_1.infos[var_0_16]
	local var_10_2 = arg_10_1.infos[var_0_17]

	self.bossInfo = arg_10_1.infos[var_0_17]
	self.spInfo = var_10_1
	self.normalInfo = var_10_0
	self.worldbosshp = arg_10_1.bosshp or 0

	self.booshp:setPercent(100 * (arg_10_1.bosshp or 0) / var_10_2.boss_hp)

	self.stagetype = arg_10_1.stagetype
	self.stage = arg_10_1.stage

	self.stagelabel:setString(var_0_18[self.stagetype])
	self.ranklabel:setString((not arg_10_1.rank or arg_10_1.rank == -1) and "未上榜" or arg_10_1.rank)
	self.scorelabel:setString(arg_10_1.max_score and global_trans_number(arg_10_1.max_score) or 0)
	self.chancelabel:setString(arg_10_1.daily_chance)
	self.damage_add:setString(item_manager:getItemNumber(var_10_2.damage_item) .. "%")
	self.hp_add:setString(item_manager:getItemNumber(var_10_2.hp_item) .. "%")

	self.daily_chance = arg_10_1.daily_chance

	self:updateAddServant(arg_10_1.add_servant)

	local var_10_3 = string.split(var_10_0.mode, ",")

	self.enemy_1.fightmode = tonumber(var_10_3[1])
	self.enemy_2.fightmode = tonumber(var_10_3[2])
	self.enemy_sp.fightmode = tonumber(var_10_1.mode)
	self.enemy_boss.fightmode = tonumber(var_10_2.mode)

	self:updateEnemy(self.enemy_1, arg_10_1)
	self:updateEnemy(self.enemy_2, arg_10_1)
	self:updateEnemy(self.enemy_sp, arg_10_1)
	self:updateEnemy(self.enemy_boss, arg_10_1)

	local var_10_4 = tonumber(self.bossInfo.mode)

	self.boss_name:setString(model_data[level_manager.getCurMonsterData(var_10_4, level_manager.getCurMonsterTeamData(var_10_4, level_manager.getCurLevelData(var_10_4, "1-1").boss_team).boss).modelid].name)
end

function ActivityWorldBossBaseLayer:updateEnemy(arg_11_1, arg_11_2)
	if not arg_11_1.fightmode then
		arg_11_1:setVisible(false)

		return
	end

	local var_11_0 = arg_11_1:getChildByName("mask")
	local var_11_1 = arg_11_1:getChildByName("name")
	local var_11_2 = arg_11_1:getChildByName("unlock_time_bg")
	local var_11_3 = arg_11_1:getChildByName("unlock_time")

	if var_11_0 then
		var_11_0:setLocalZOrder(10)
	end

	local var_11_4 = level_manager.getCurMonsterData(arg_11_1.fightmode, level_manager.getCurMonsterTeamData(arg_11_1.fightmode, level_manager.getCurLevelData(arg_11_1.fightmode, "1-1").boss_team).boss).modelid
	local var_11_5 = model_data[var_11_4].name
	local var_11_6 = arg_11_1:getChildByName("image_boss")

	if not var_11_6 then
		var_11_6 = self:createBOSS(arg_11_1.fightmode)

		arg_11_1:addChild(var_11_6, 11)
	elseif model_data[var_11_4].role_image then
		var_11_6:loadTexture("role/" .. model_data[var_11_4].role_image .. ".png")
	else
		var_11_6:loadTexture("role1/" .. model_data[var_11_4].cute_role .. ".png")
	end

	var_11_6:setOpacity(255)

	if arg_11_1.stagetype == var_0_17 then
		var_11_6:setPosition(cc.p(var_11_6:getPositionX() + 55, var_11_6:getPositionY() + 50))
		var_11_6:setScale(0.5)
	end

	local var_11_7 = arg_11_1.stagetype == var_0_17 and "boss_bg" or "normal_bg"

	if self.worldbosshp <= 0 and self.stagetype == var_0_17 and worldboss_data[self.stage + 1] then
		if var_11_0 then
			var_11_0:setVisible(false)
		end

		var_11_2:setVisible(true)
		var_11_3:setVisible(true)
		arg_11_1:loadTexture(self.respath .. var_11_7 .. "_lock.png", var_0_0)
		var_11_6:setVisible(false)
		var_11_1:setString("即将抵达")
		arg_11_1:setTouchEnabled(true)
		arg_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords("下一轮怪物即将抵达!!!")
		end)

		if not arg_11_1.activityScheduler then
			local var_11_8

			if arg_11_1.stagetype == var_0_17 then
				var_11_8 = arg_11_2.endtime + 86400 * (self.normalInfo.duration + self.spInfo.duration)
			elseif arg_11_1.stagetype == var_0_16 then
				var_11_8 = arg_11_2.endtime + 86400 * self.normalInfo.duration
			elseif arg_11_1.stagetype == var_0_15 then
				var_11_8 = arg_11_2.endtime
			end

			arg_11_1.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(math.floor(var_11_8 - time_check_manager:getCurTime()), function(arg_13_0)
				var_11_3:setString(var_0_19(arg_13_0))

				if arg_13_0 <= 0 and arg_11_1.activityScheduler then
					time_check_manager:removeUpdatePool(arg_11_1.activityScheduler)

					arg_11_1.activityScheduler = nil
				end
			end)))
		end

		return
	end

	if arg_11_1.stagetype < self.stagetype then
		if var_11_0 then
			var_11_0:setVisible(true)
		end

		var_11_2:setVisible(false)
		var_11_3:setVisible(false)
		arg_11_1:loadTexture(self.respath .. var_11_7 .. ".png", var_0_0)
		var_11_6:setVisible(true)
		var_11_6:setOpacity(100)
		var_11_1:setString(var_11_5)
	elseif arg_11_1.stagetype == self.stagetype then
		if var_11_0 then
			var_11_0:setVisible(false)
		end

		var_11_2:setVisible(false)
		var_11_3:setVisible(false)
		arg_11_1:loadTexture(self.respath .. var_11_7 .. ".png", var_0_0)
		var_11_6:setVisible(true)
		var_11_1:setString(var_11_5)
	elseif arg_11_1.stagetype > self.stagetype then
		if var_11_0 then
			var_11_0:setVisible(false)
		end

		var_11_2:setVisible(true)
		var_11_3:setVisible(true)
		arg_11_1:loadTexture(self.respath .. var_11_7 .. "_lock.png", var_0_0)
		var_11_6:setVisible(false)
		var_11_1:setString("即将抵达")

		arg_11_1.activityScheduler = arg_11_1.activityScheduler or time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(math.floor(((arg_11_1.stagetype == var_0_17 and self.stagetype == var_0_15 or nil) and (arg_11_2.endtime + self.spInfo.duration * 24 * 3600 or arg_11_2.endtime)) - time_check_manager:getCurTime()), function(arg_14_0)
			var_11_3:setString(var_0_19(arg_14_0))

			if arg_14_0 <= 0 and arg_11_1.activityScheduler then
				time_check_manager:removeUpdatePool(arg_11_1.activityScheduler)

				arg_11_1.activityScheduler = nil
			end
		end)))
	end

	arg_11_1:setTouchEnabled(true)
	arg_11_1:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_11_1.stagetype < self.stagetype then
			global_ShowBlockWords("怪物已被消灭")

			return
		elseif arg_11_1.stagetype > self.stagetype then
			global_ShowBlockWords("危险怪物即将抵达！！")

			return
		elseif arg_11_1.stagetype == self.stagetype then
			local var_15_0
			local playermodel = require("model.playermodel")

			if arg_11_1.stagetype ~= var_0_17 then
				if self.daily_chance <= 0 then
					global_ShowBlockWords("今日挑战次数不足!")

					return
				end

				RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", var_0_14)
				RoleDefault:getInstance():setIntegerForKey("EnterWorldBossActivityId", self.activityId)

				function var_15_0()
					playermodel.curMode = arg_11_1.fightmode
					playermodel.curLevel = "1-1"

					FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
					LayerManager:switchShowLayer("FightLayer", {
						is_hide_topcost = true,
						is_hide_listbutton = true
					})
				end
			else
				function var_15_0()
					activity_manager:switch_to_worldboss_fight(self.activityId, arg_11_1.fightmode, 1)
				end
			end

			LayerManager:pushInLayer("LevelDetailLayer", {
				fight_type = "WORLDBOSS",
				chapter = 1,
				level = 1,
				mode = arg_11_1.fightmode,
				callback = function()
					return
				end,
				adventuresurecallback = function()
					local var_19_0 = {
						mode = arg_11_1.fightmode
					}

					var_19_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
					var_19_0.configtype = CONFIG_TYPE_MODE
					var_19_0.configcallback = var_15_0

					var_0_10:pushFormationLayer("FormationMaterialLayer", var_19_0)
				end
			})
		end
	end)
end

function ActivityWorldBossBaseLayer:createBOSS(arg_20_1)
	local var_20_0 = level_manager.getCurMonsterData(arg_20_1, level_manager.getCurMonsterTeamData(arg_20_1, level_manager.getCurLevelData(arg_20_1, "1-1").boss_team).boss).modelid
	local var_20_1 = ccui.ImageView:create()

	var_20_1:setAnchorPoint(0.5, 0.5)

	if model_data[var_20_0].role_image then
		var_20_1:loadTexture("role/" .. model_data[var_20_0].role_image .. ".png")
	else
		var_20_1:loadTexture("role1/" .. model_data[var_20_0].cute_role .. ".png")
	end

	self.modelid = var_20_0

	var_20_1:setPosition(self.enemy_1:getContentSize().width / 2, self.enemy_1:getContentSize().height / 2 + 20)
	var_20_1:setPosition(cc.p(var_20_1:getPositionX() + (model_data[self.modelid].substitution_offset_x or 0), var_20_1:getPositionY() + (model_data[self.modelid].substitution_offset_y or 0)))
	var_20_1:setScale(0.35)

	return var_20_1
end

function ActivityWorldBossBaseLayer:updateAddServant(arg_21_1)
	self.servant_add_list:removeAllChildren()

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_0 = ccui.Layout:create()

		var_21_0:setContentSize(cc.size(77, 100))
		var_21_0:setAnchorPoint(0, 0)

		local var_21_1 = ccui.ImageView:create(self.respath .. "servant_bg.png", var_0_0)

		var_21_0:addChild(var_21_1)
		var_21_1:setPosition(40, 50)

		local var_21_2 = ccui.ImageView:create("equipment/" .. item_data[servant_data[iter_21_1].itemid].image_id .. ".png")

		var_21_1:addChild(var_21_2)
		var_21_2:setScale(0.4)
		var_21_2:setAnchorPoint(0, 0)
		self.servant_add_list:pushBackCustomItem(var_21_0)
		var_21_1:setTouchEnabled(true)
		var_21_1:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showBuffInfo(self.bossInfo.battlefield_status)
		end)
	end
end

function ActivityWorldBossBaseLayer:initTouchEvent()
	self.btn_return:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btn_reward:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.stage then
			return
		end

		self:updateRankRewardLayout()
	end)
	self.btn_rank:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.stage then
			return
		end

		LayerManager:pushInLayer("WorldBossRankListLayer", {
			activityId = self.activityId,
			stage = self.bossInfo.id
		})
	end)

	if self.btn_task then
		self.btn_task:addTouchEventListener(function(arg_27_0, arg_27_1)
			if arg_27_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActivityGameTaskLayer", {
				uiconfmodule = "worldboss",
				activityId = self.activityId
			})
		end)
	end
end

function ActivityWorldBossBaseLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.stagela_bg:setPositionY(self.stagela_bg:getPositionY() + GameDisplay.fix_y)
	self.btn_rank:setPositionY(self.btn_rank:getPositionY() + GameDisplay.fix_y)
	self.btn_reward:setPositionY(self.btn_reward:getPositionY() + GameDisplay.fix_y)
	self.btn_task:setPositionY(self.btn_task:getPositionY() + GameDisplay.fix_y)
	self.enemy_1:setPositionY(self.enemy_1:getPositionY() + GameDisplay.fix_y)
	self.enemy_2:setPositionY(self.enemy_2:getPositionY() + GameDisplay.fix_y * 0.7)
	self.enemy_sp:setPositionY(self.enemy_sp:getPositionY() + GameDisplay.fix_y * 0.2)
	self.enemy_sp:setScale(1.2)
	self.enemy_boss:setPositionY(self.enemy_boss:getPositionY() - GameDisplay.fix_y * 0.1)
	self.btn_return:setPositionY(self.btn_return:getPositionY() - GameDisplay.fix_y * 0.8)
	self.servant_add_title:setPositionY(self.servant_add_title:getPositionY() - GameDisplay.fix_y * 0.5)
	self.servant_add_bg:setPositionY(self.servant_add_bg:getPositionY() - GameDisplay.fix_y * 0.5)
	self.fight_info_bg:setPositionY(self.fight_info_bg:getPositionY() - GameDisplay.fix_y * 0.5)
end

function ActivityWorldBossBaseLayer:updateRankRewardLayout()
	if self.rewardLayout then
		self.rewardLayout:setVisible(true)

		return
	end

	local var_29_0 = "排名奖励"
	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs((require("data.worldboss_reward_data"))) do
		if iter_29_1.bossid == self.bossInfo.id then
			table.insert(var_29_1, iter_29_1)
		end
	end

	local var_29_2 = ccui.Layout:create()

	var_29_2:setContentSize(cc.size(640, 1600))
	var_29_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_29_2:setCascadeOpacityEnabled(false)
	var_29_2:setBackGroundColorOpacity(122)
	var_29_2:setAnchorPoint(0.5, 0.5)
	var_29_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_29_2:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_29_2:setTouchEnabled(true)
	var_29_2:setLocalZOrder(1000)
	self:addChild(var_29_2)

	self.rewardLayout = var_29_2

	local var_29_3 = ccui.ImageView:create(self.respath .. "rank_reward_bg.png", var_0_0)

	self.rewardLayout:addChild(var_29_3)
	var_29_3:setPosition(320, 700)
	var_29_3:setTouchEnabled(true)

	local var_29_4 = ccui.ImageView:create(self.respath .. "rank_reward_title.png", var_0_0)

	self.rewardLayout:addChild(var_29_4)
	var_29_4:setAnchorPoint(0.5, 0)
	var_29_4:setPosition(320, 700 + var_29_3:getContentSize().height / 2 - 20)

	local var_29_5 = cc.Label:createWithTTF("", FONT_DES, 34)

	var_29_5:setPosition(var_29_4:getContentSize().width / 2, var_29_4:getContentSize().height / 2)
	var_29_4:addChild(var_29_5)
	var_29_5:setString(var_29_0)

	local var_29_6 = cc.Label:createWithTTF("当前排名：", FONT_DES, 26)

	var_29_6:setAnchorPoint(0, 1)
	var_29_6:setPosition(20, var_29_3:getContentSize().height - 20)
	var_29_3:addChild(var_29_6)

	local var_29_7 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_29_7:setAnchorPoint(0, 1)
	var_29_7:setPosition(145, var_29_3:getContentSize().height - 20)
	var_29_3:addChild(var_29_7)
	var_29_7:setColor(cc.c3b(0, 255, 198))

	local var_29_8 = cc.TableView:create(cc.size(var_29_3:getContentSize().width - 40, var_29_3:getContentSize().height - 150))

	var_29_8:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_29_8:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_29_8:setPosition(20, 75)
	var_29_8:setDelegate()
	var_29_3:addChild(var_29_8)

	local function var_29_9(arg_30_0, arg_30_1)
		local var_30_0 = ccui.Layout:create()

		var_30_0:setTag(100)

		local var_30_1 = ccui.Layout:create()

		var_30_1:setContentSize(cc.size(460, 120))
		var_30_1:setPosition(cc.p(50, -45))
		var_30_0:addChild(var_30_1)
		var_30_1:setName("droplist")
		var_30_1:setLayoutType(ccui.LayoutType.horizontal)

		for iter_30_0, iter_30_1 in pairs(drop_manager:getDropMsg(arg_30_0.dropid).equips) do
			local var_30_2 = ccui.Layout:create()

			var_30_2:setContentSize(cc.size(100, 100))

			local var_30_3 = ccui.ImageView:create(self.respath .. "reward_bg.png", var_0_0)

			var_30_3:setPosition(cc.p(50, 62))

			local var_30_4, var_30_5 = create_item_icon(arg_30_0.dropid, true, iter_30_1.dropid, iter_30_1.dropNum)

			var_30_4:setPosition(40, 65)
			var_30_4:setScale(var_30_4:getScale() * 0.6)
			var_30_3:addChild(var_30_4)
			var_30_2:addChild(var_30_3)

			local var_30_6 = cc.Label:createWithTTF("x" .. var_30_5, FONT_DES, 18)

			var_30_6:setPosition(40, 10)
			var_30_3:addChild(var_30_6)
			var_30_1:addChild(var_30_2)
			var_30_2:setPositionX(iter_30_0 * 100 - 80)
		end

		local var_30_7 = ccui.ImageView:create(self.respath .. "rank_first_bg.png", var_0_0)

		var_30_0:addChild(var_30_7)
		var_30_7:setAnchorPoint(0, 0)
		var_30_7:setPosition(35, 80)
		var_30_7:setName("rankTitlebg")

		local var_30_8 = ({
			"rank_first_bg.png",
			"rank_second_bg.png",
			"rank_third_bg.png"
		})[arg_30_1]

		if not var_30_8 then
			var_30_7:setVisible(false)
		else
			var_30_7:loadTexture(self.respath .. var_30_8, var_0_0)
			var_30_7:setVisible(true)
		end

		local var_30_9 = cc.Label:createWithTTF("", FONT_DES, 26)

		var_30_9:setAnchorPoint(0, 0)
		var_30_9:setPosition(65, 90)
		var_30_0:addChild(var_30_9)
		var_30_9:setString(not arg_30_0.max and string.format("第%d名及以后", arg_30_0.min) or arg_30_0.min == arg_30_0.max and string.format("第%d名", arg_30_0.min) or string.format("第%d-%d名", arg_30_0.min, arg_30_0.max))
		var_30_9:setName("rankTitle")

		return var_30_0
	end

	local function var_29_10(arg_31_0, arg_31_1, arg_31_2)
		local var_31_0 = arg_31_0:getChildByName("droplist")

		var_31_0:removeAllChildren()

		for iter_31_0, iter_31_1 in pairs(drop_manager:getDropMsg(arg_31_1.dropid).equips) do
			local var_31_1 = ccui.Layout:create()

			var_31_1:setContentSize(cc.size(100, 100))

			local var_31_2 = ccui.ImageView:create(self.respath .. "reward_bg.png", var_0_0)

			var_31_2:setPosition(cc.p(50, 62))

			local var_31_3, var_31_4 = create_item_icon(arg_31_1.dropid, true, iter_31_1.dropid, iter_31_1.dropNum)

			var_31_3:setPosition(40, 65)
			var_31_3:setScale(var_31_3:getScale() * 0.6)
			var_31_2:addChild(var_31_3)
			var_31_1:addChild(var_31_2)

			local var_31_5 = cc.Label:createWithTTF("x" .. var_31_4, FONT_DES, 18)

			var_31_5:setPosition(40, 10)
			var_31_2:addChild(var_31_5)
			var_31_0:addChild(var_31_1)
			var_31_1:setPositionX(iter_31_0 * 100 - 80)
		end

		local var_31_6 = arg_31_0:getChildByName("rankTitlebg")
		local var_31_7 = arg_31_0:getChildByName("rankTitle")
		local var_31_8 = ({
			"rank_first_bg.png",
			"rank_second_bg.png",
			"rank_third_bg.png"
		})[arg_31_2]

		if not var_31_8 then
			var_31_6:setVisible(false)
		else
			var_31_6:loadTexture(self.respath .. var_31_8, var_0_0)
			var_31_6:setVisible(true)
		end

		var_31_7:setString(not arg_31_1.max and string.format("第%d名及以后", arg_31_1.min) or arg_31_1.min == arg_31_1.max and string.format("第%d名", arg_31_1.min) or string.format("第%d-%d名", arg_31_1.min, arg_31_1.max))
	end

	var_29_8:registerScriptHandler(function(arg_33_0, arg_33_1)
		return var_29_3:getContentSize().width - 40, 180
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_29_8:registerScriptHandler(function(arg_32_0, arg_32_1)
		local var_32_0 = arg_32_0:dequeueCell()

		if not var_32_0 then
			var_32_0 = cc.TableViewCell:create()

			local var_32_2 = var_29_9(var_29_1[arg_32_1 + 1], arg_32_1 + 1)

			var_32_2:setPosition(cc.p(0, 65))
			var_32_0:addChild(var_32_2)
		else
			var_29_10(var_32_0:getChildByTag(100), var_29_1[arg_32_1 + 1], arg_32_1 + 1)
		end

		return var_32_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_29_8:registerScriptHandler(function(arg_34_0, arg_34_1)
		return #var_29_1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_29_8:reloadData()
	var_29_2:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_29_2:setVisible(false)
	end)
end

function ActivityWorldBossBaseLayer.moveAni(arg_36_0, arg_36_1, arg_36_2)
	arg_36_2:setVisible(true)

	if arg_36_1 == "left" then
		local var_36_0 = arg_36_2:getContentSize().width

		arg_36_2:setPositionX(arg_36_2:getPositionX() - var_36_0)
		arg_36_2:runAction(cc.MoveBy:create(0.4, cc.p(var_36_0, 0)))
	elseif arg_36_1 == "right" then
		local var_36_1 = arg_36_2:getContentSize().width

		arg_36_2:setPositionX(arg_36_2:getPositionX() + var_36_1)
		arg_36_2:runAction(cc.MoveBy:create(0.4, cc.p(-var_36_1, 0)))
	end
end

function ActivityWorldBossBaseLayer.showAni(arg_37_0, arg_37_1)
	arg_37_1:setOpacity(0)
	arg_37_1:runAction(cc.FadeIn:create(0.4))
end

function ActivityWorldBossBaseLayer:createAni()
	self:moveAni("right", self.enemy_2)
	self:moveAni("right", self.enemy_boss)
	self:moveAni("right", self.fight_info_bg)
	self:moveAni("left", self.enemy_1)
	self:moveAni("left", self.enemy_sp)
	self:moveAni("left", self.servant_add_title)
	self:moveAni("left", self.servant_add_bg)
	self:showAni(self.enemy_1)
	self:showAni(self.enemy_2)
	self:showAni(self.enemy_sp)
	self:showAni(self.enemy_boss)
	self:showAni(self.title)
	self:showAni(self.booshp)
	self:showAni(self.stagela_bg)
end

function ActivityWorldBossBaseLayer:showBuffInfo(arg_39_1)
	if not arg_39_1 then
		return
	end

	local var_39_0 = ccui.Layout:create()

	var_39_0:setTouchEnabled(true)
	var_39_0:setContentSize(640, 1600)
	var_39_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_39_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_39_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_39_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_39_0:setBackGroundColorOpacity(120)
	var_39_0:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_39_0:runAction(cc.RemoveSelf:create())
	end)
	;(function()
		local var_41_0 = ccui.ImageView:create(self.respath .. "skill_des_bg.png", var_0_0)

		var_41_0:setPosition(cc.p(320, 800))
		var_41_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_39_0:addChild(var_41_0)

		local var_41_1 = ccui.Layout:create()

		var_41_1:setContentSize(cc.size(500, 124))
		var_41_1:setAnchorPoint(cc.p(0, 0))
		var_41_1:setPosition(cc.p(20, 728))
		var_41_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_41_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_41_1:setBackGroundColorOpacity(0)
		var_39_0:addChild(var_41_1, 2)

		local var_41_2 = RichTextPro:create()

		var_41_2:setMaxWidth(520)
		var_41_2:setSize(35)
		var_41_2:setColor(cc.c3b(220, 251, 241))
		var_41_2:setLineSpace(0)
		var_41_2:setText((transSkillDesToRichText(battlefield_status_data[arg_39_1].des)))
		var_41_2:setName("richText")
		var_41_2:setPosition(cc.p(40, 82))
		var_41_1:addChild(var_41_2)

		local var_41_3 = cc.Label:createWithTTF("列表中学员对抗boss时获得增益效果:", FONT_DES, 24)

		var_41_1:addChild(var_41_3)
		var_41_3:setAnchorPoint(0, 0)
		var_41_3:setPosition(10, 110)
	end)()
	self:addChild(var_39_0, 1000)
end
