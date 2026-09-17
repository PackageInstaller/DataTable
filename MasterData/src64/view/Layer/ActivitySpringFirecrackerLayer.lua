ActivitySpringFirecrackerLayer = class("ActivitySpringFirecrackerLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local musicialnote_conf = require("data.musicialnote_conf")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local springfirecracker_gamelogic_manager = require("controller.springfirecracker_gamelogic_manager")
local var_0_15 = require("view.Layer.ObjectPool"):new()
local var_0_16 = require("view.Layer.ObjectPool"):new()

function var_0_16:getObjectByMyType(arg_2_1, arg_2_2, ...)
	local var_2_0 = self:getObject(arg_2_1)

	if var_2_0 then
		return var_2_0
	else
		local var_2_1 = arg_2_2:create(...)

		var_2_1.type = arg_2_1

		self:createObject(var_2_1)
	end

	return self:getObject(arg_2_1)
end

function var_0_16:clearAllActiveObject()
	for iter_3_0, iter_3_1 in pairs(self.activePool) do
		iter_3_1.isActive = false

		iter_3_1:setVisible(false)
	end

	self.activePool = {}
end

function ActivitySpringFirecrackerLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ActivitySpringFirecrackerLayer.new()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function ActivitySpringFirecrackerLayer:init(arg_5_1)
	self.activityId = arg_5_1.activityId
	self.layerName = "ActivitySpringFirecracker_" .. self.activityId
	self.respath = "ActivitySpringFirecracker_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:initTouchPanel()
	self:registerActivityEventListener()
	self:initTouchEvent()
	springfirecracker_gamelogic_manager:registerUIRef(self)
	self:registerGameEvent()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
			springfirecracker_gamelogic_manager:exitGame()
		end
	end)
	self:fullScreen()
	activity_manager:springfirecracker_get_game_data(self.activityId)
end

function ActivitySpringFirecrackerLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_FIRECRACKER_DATA_UPDATE, function(arg_8_0)
		self.damage_level = arg_8_0.damage_level
		self.bullet_num_level = arg_8_0.bullet_num_level
		self.attack_speed_level = arg_8_0.attack_speed_level
		self.levelupInfo = activity_manager:getLevelupInfo(self.activityId, {
			damage_level = arg_8_0.damage_level,
			bullet_num_level = arg_8_0.bullet_num_level,
			attack_speed_level = arg_8_0.attack_speed_level
		})

		self:updateLevelupPanel()
	end)
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function(arg_9_0)
		self:updateLevelupPanel()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_10_0)
		self:updateLevelupPanel()
	end), self)
end

function ActivitySpringFirecrackerLayer:initTouchEvent()
	self.title:setTouchEnabled(true)
	self.title:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivitySpringFirecrackerLayer_" .. self.activityId
		})
	end)
	self.return_btn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.task_btn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "springfirecracker",
			activityId = self.activityId
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_15_0 = require("data.activity_springfirecracker_conf")[self.activityId].shop_id

		if not var_15_0 then
			return
		end

		local var_15_1 = {
			"1-" .. tonumber(var_15_0) % 1500000
		}

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_15_1,
			showType = var_15_1[1]
		})
	end)
	self.start_btn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.start_btn:setBright(false)
		activity_manager:springfirecracker_start_game(self.activityId, function(arg_17_0)
			self.start_btn:setBright(true)

			if arg_17_0.result == 1 then
				springfirecracker_gamelogic_manager:gameStart({
					damage_level = self.damage_level,
					bullet_num_level = self.bullet_num_level,
					attack_speed_level = self.attack_speed_level
				})
				self.start_btn:setVisible(false)
				self.btn_strengthen:setVisible(false)
				self.levelup_bg:setVisible(false)
				self.objPool:clearAllActiveObject()
			end
		end)
	end)
	self.btn_strengthen:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.levelup_bg:setVisible(not self.levelup_bg:isVisible())
	end)
	self.btn_attack_speed_levelup:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:haveItem(self.levelupInfo.strengthen_item, self.levelupInfo.attack_speed_level_need) then
			activity_manager:springfirecracker_level_up(self.activityId, {
				strengthen = "attack_speed_level"
			})
		else
			global_ShowBlockWords("道具不足!!!")
		end
	end)
	self.btn_bullet_num_levelup:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:haveItem(self.levelupInfo.strengthen_item, self.levelupInfo.bullet_num_level_need) then
			activity_manager:springfirecracker_level_up(self.activityId, {
				strengthen = "bullet_num_level"
			})
		else
			global_ShowBlockWords("道具不足!!!")
		end
	end)
	self.btn_damage_levelup:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:haveItem(self.levelupInfo.strengthen_item, self.levelupInfo.damage_level_need) then
			activity_manager:springfirecracker_level_up(self.activityId, {
				strengthen = "damage_level"
			})
		else
			global_ShowBlockWords("道具不足!!!")
		end
	end)
end

function ActivitySpringFirecrackerLayer.registerGameEvent(arg_22_0)
	springfirecracker_gamelogic_manager:registerGameEvent("GENERATE_MONSTER", arg_22_0, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_22_0.objPool:getObjectByMyType("monster", ccui.ImageView, arg_22_0.respath .. "monster_1.png", var_0_0)

		var_23_0:loadTexture(arg_22_0.respath .. "monster_" .. arg_23_1.monster.type .. ".png", var_0_0)

		if not var_23_0:getParent() then
			arg_22_0.gamePanel:addChild(var_23_0, 3)
		end

		if not var_23_0:getChildByName("hp_progress") then
			local var_23_1 = ccui.ImageView:create(arg_22_0.respath .. "monster_hp_bg.png", var_0_0)

			var_23_1:setPosition(var_23_0:getContentSize().width / 2, 0)
			var_23_1:setName("hp_progress_bg")

			local var_23_2 = ccui.Slider:create()

			var_23_2:loadBarTexture(arg_22_0.respath .. "monster_hp_progress.png", var_0_0)
			var_23_2:loadProgressBarTexture(arg_22_0.respath .. "monster_hp.png", var_0_0)
			var_23_2:setPosition(var_23_0:getContentSize().width / 2, 0)
			var_23_2:setName("hp_progress")
			var_23_0:addChild(var_23_1)
			var_23_0:addChild(var_23_2)
		end

		if arg_23_1.monster.type == 1 then
			var_23_0:getChildByName("hp_progress_bg"):setPositionY(45)
			var_23_0:getChildByName("hp_progress"):setPositionY(45)
		elseif arg_23_1.monster.type == 2 then
			var_23_0:getChildByName("hp_progress_bg"):setPositionY(25)
			var_23_0:getChildByName("hp_progress"):setPositionY(25)
		elseif arg_23_1.monster.type == 3 then
			var_23_0:getChildByName("hp_progress_bg"):setPositionY(10)
			var_23_0:getChildByName("hp_progress"):setPositionY(10)
		end

		var_23_0:getChildByName("hp_progress"):setPercent(100)
		var_23_0:setPosition(arg_23_1.monster.pos_x, arg_23_1.monster.pos_y)

		arg_23_1.monster.node = var_23_0
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("DELETE_MONSTER", arg_22_0, function(arg_24_0, arg_24_1)
		if arg_24_1.monster.hp <= 0 then
			local var_24_0 = arg_22_0.spinePool:getObjectByMyType("delete_monster_spine", sp.SkeletonAnimation, "spine/smallgame/xiaosan.json", "spine/smallgame/xiaosan.atlas", 1)

			if not var_24_0:getParent() then
				arg_22_0.gamePanel:addChild(var_24_0, 4)
			end

			var_24_0:setAnimation(0, tostring(arg_24_1.monster.type), false)
			var_24_0:setPosition(arg_24_1.monster.node:getPosition())
			var_24_0:registerSpineEventHandler(function()
				arg_22_0.spinePool:recycleObject(var_24_0)
			end, SP_ANIMATION_COMPLETE)
		end

		arg_22_0.objPool:recycleObject(arg_24_1.monster.node)
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("UPDATE_MONSTER", arg_22_0, function(arg_26_0, arg_26_1)
		if arg_26_1.monster.node and arg_26_1.monster.node:getChildByName("hp_progress") then
			arg_26_1.monster.node:getChildByName("hp_progress"):setPercent(100 * arg_26_1.monster.hp / arg_26_1.monster.max_hp)
		end
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("GENERATE_BULLET", arg_22_0, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_22_0.objPool:getObjectByMyType("bullet", ccui.ImageView, arg_22_0.respath .. "bullet.png", var_0_0)

		if not var_27_0:getParent() then
			arg_22_0.gamePanel:addChild(var_27_0, 1)
		end

		var_27_0:setPosition(arg_27_1.bullet.pos_x, arg_27_1.bullet.pos_y)
		var_27_0:setRotation(arg_27_1.bullet.rotation)

		arg_27_1.bullet.node = var_27_0
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("DELETE_BULLET", arg_22_0, function(arg_28_0, arg_28_1)
		arg_22_0.objPool:recycleObject(arg_28_1.bullet.node)
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("GENERATE_PROP", arg_22_0, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_22_0.objPool:getObjectByMyType("prop", ccui.ImageView, arg_22_0.respath .. "boom.png", var_0_0)

		var_29_0:loadTexture(arg_22_0.respath .. arg_29_1.prop.type .. ".png", var_0_0)

		if not var_29_0:getParent() then
			arg_22_0.gamePanel:addChild(var_29_0, 2)
		end

		var_29_0:setPosition(arg_29_1.prop.pos_x, arg_29_1.prop.pos_y)

		arg_29_1.prop.node = var_29_0
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("DELETE_PROP", arg_22_0, function(arg_30_0, arg_30_1)
		arg_22_0.objPool:recycleObject(arg_30_1.prop.node)
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("GAME_END", arg_22_0, function(arg_31_0, arg_31_1)
		global_ShowBlockWords("游戏结束！得分为:" .. arg_31_1.score)
		arg_22_0.objPool:clearAllActiveObject()
		arg_22_0.start_btn:setVisible(true)
		arg_22_0.btn_strengthen:setVisible(true)
		activity_manager:springfirecracker_game_end(arg_22_0.activityId, {
			score = arg_31_1.score
		})
		arg_22_0.score_label:setString("得分:" .. arg_31_1.score)

		if arg_31_1.hp then
			arg_22_0:updateHp(arg_31_1.hp)
		end

		if arg_31_1.time then
			arg_22_0.time_label:setString(arg_31_1.time .. "s")
		end
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("UPDATE_GAMEDATA", arg_22_0, function(arg_32_0, arg_32_1)
		if arg_32_1.score then
			arg_22_0.score_label:setString("得分:" .. arg_32_1.score)
		end

		if arg_32_1.hp then
			arg_22_0:updateHp(arg_32_1.hp)
		end

		if arg_32_1.time then
			arg_22_0.time_label:setString(arg_32_1.time .. "s")
		end
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("BOOM", arg_22_0, function(arg_33_0, arg_33_1)
		arg_22_0.objPool:clearAllActiveObject()

		if arg_33_1.score then
			arg_22_0.score_label:setString("得分:" .. arg_33_1.score)
		end

		if arg_33_1.monsters then
			for iter_33_0, iter_33_1 in pairs(arg_33_1.monsters) do
				if iter_33_1.node then
					local var_33_0 = arg_22_0.spinePool:getObjectByMyType("boom_spine", sp.SkeletonAnimation, "spine/smallgame/baozha.json", "spine/smallgame/baozha.atlas", 1)

					if not var_33_0:getParent() then
						arg_22_0.gamePanel:addChild(var_33_0, 4)
					end

					var_33_0:setAnimation(0, "animation", false)
					var_33_0:setPosition(iter_33_1.node:getPosition())
					var_33_0:registerSpineEventHandler(function()
						arg_22_0.spinePool:recycleObject(var_33_0)
					end, SP_ANIMATION_COMPLETE)
				end
			end
		end
	end)
	springfirecracker_gamelogic_manager:registerGameEvent("TOWER_LEVELUP", arg_22_0, function(arg_35_0, arg_35_1)
		arg_22_0.levelupSpine:setVisible(true)
		arg_22_0.levelupSpine:setAnimation(0, "animation", false)
		arg_22_0.levelupSpine:registerSpineEventHandler(function()
			arg_22_0.levelupSpine:setVisible(false)
		end, SP_ANIMATION_COMPLETE)
	end)
end

function ActivitySpringFirecrackerLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.task_btn = self.rootLayer:getChildByName("btn_task")
	self.shop_btn = self.rootLayer:getChildByName("btn_shop")
	self.line = self.rootLayer:getChildByName("line")
	self.bottom = self.rootLayer:getChildByName("bottom")
	self.return_btn = self.bottom:getChildByName("btn_return")
	self.start_btn = self.bottom:getChildByName("btn_start")
	self.btn_strengthen = self.bottom:getChildByName("btn_strengthen")
	self.hp_line = self.rootLayer:getChildByName("hp_line")
	self.tower = self.rootLayer:getChildByName("tower")
	self.levelup_bg = self.rootLayer:getChildByName("levelup_bg")

	self.levelup_bg:setVisible(false)

	self.damage_level_label = self.levelup_bg:getChildByName("damage_level_label")
	self.bullet_num_level_label = self.levelup_bg:getChildByName("bullet_num_level_label")
	self.attack_speed_level_label = self.levelup_bg:getChildByName("attack_speed_level_label")
	self.btn_attack_speed_levelup = self.levelup_bg:getChildByName("btn_attack_speed_levelup")
	self.btn_bullet_num_levelup = self.levelup_bg:getChildByName("btn_bullet_num_levelup")
	self.btn_damage_levelup = self.levelup_bg:getChildByName("btn_damage_levelup")

	local var_37_0 = ccui.Layout:create()

	var_37_0:setContentSize(cc.size(640, self.line:getPositionY() - self.hp_line:getPositionY() + 2 * GameDisplay.fix_y))
	var_37_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_37_0:setCascadeOpacityEnabled(false)
	var_37_0:setBackGroundColorOpacity(0)
	var_37_0:setAnchorPoint(0.5, 0)
	var_37_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_37_0:setPosition(320, self.hp_line:getPositionY() - GameDisplay.fix_y)
	var_37_0:setTouchEnabled(false)
	var_37_0:setVisible(true)

	self.gamePanel = var_37_0

	self.rootLayer:addChild(self.gamePanel, 9)

	self.objPool = var_0_16:new()
	self.spinePool = var_0_16:new()

	local var_37_1 = cc.Label:createWithTTF("", FONT_NAME, 36)

	var_37_1:setPosition(35, 930 + GameDisplay.fix_y)
	var_37_1:setAnchorPoint(0, 0.5)
	var_37_1:setColor(cc.c3b(0, 0, 0))
	self.rootLayer:addChild(var_37_1)

	self.score_label = var_37_1

	local var_37_2 = cc.Label:createWithTTF("", FONT_NAME, 48)

	var_37_2:setPosition(550, 920 + GameDisplay.fix_y)
	var_37_2:setColor(cc.c3b(0, 0, 0))
	self.rootLayer:addChild(var_37_2)

	self.time_label = var_37_2

	local var_37_3 = sp.SkeletonAnimation:create("spine/smallgame/up.json", "spine/smallgame/up.atlas", 1)

	var_37_3:setAnimation(0, "animation", true)
	self.rootLayer:addChild(var_37_3, 99)
	var_37_3:setPosition(self.tower:getPosition())

	self.levelupSpine = var_37_3

	self.levelupSpine:setVisible(false)
end

function ActivitySpringFirecrackerLayer:initTouchPanel()
	local var_38_0 = ccui.Layout:create()

	var_38_0:setContentSize(cc.size(640, self.line:getPositionY() - self.hp_line:getPositionY() + 2 * GameDisplay.fix_y))
	var_38_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_38_0:setCascadeOpacityEnabled(false)
	var_38_0:setBackGroundColorOpacity(0)
	var_38_0:setAnchorPoint(0.5, 0)
	var_38_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_38_0:setPosition(320, self.hp_line:getPositionY() - GameDisplay.fix_y)
	var_38_0:setTouchEnabled(true)
	var_38_0:setVisible(true)

	self.touchPanel = var_38_0

	self.rootLayer:addChild(self.touchPanel, 10)

	local function var_38_1(arg_39_0, arg_39_1)
		return math.atan2(arg_39_0, arg_39_1) * 180 / math.pi
	end

	var_38_0:addTouchEventListener(function(arg_40_0, arg_40_1)
		if arg_40_1 == ccui.TouchEventType.began then
			self._longPressPos = arg_40_0:getTouchBeganPosition()
			self._longPressHandler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
				local var_41_0 = math.min(90, math.max(-90, (var_38_1(var_38_0:convertToNodeSpace(self._longPressPos).x - 320, var_38_0:convertToNodeSpace(self._longPressPos).y - 50))))

				if springfirecracker_gamelogic_manager.mainloop then
					self.tower:setRotation(var_41_0)
				end

				springfirecracker_gamelogic_manager:PanelTouch(var_41_0)
			end, 0, false)
		elseif arg_40_1 == ccui.TouchEventType.moved then
			self._longPressPos = arg_40_0:getTouchMovePosition()
		elseif (arg_40_1 == ccui.TouchEventType.ended or arg_40_1 == ccui.TouchEventType.canceled) and self._longPressHandler then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._longPressHandler)

			self._longPressHandler = nil
		end
	end)
end

function ActivitySpringFirecrackerLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.task_btn:setPositionY(self.task_btn:getPositionY() + GameDisplay.fix_y)
	self.shop_btn:setPositionY(self.shop_btn:getPositionY() + GameDisplay.fix_y)
	self.line:setPositionY(self.line:getPositionY() + GameDisplay.fix_y)
	self.bottom:setPositionY(self.bottom:getPositionY() - GameDisplay.fix_y)
	self.hp_line:setPositionY(self.hp_line:getPositionY() - GameDisplay.fix_y)
	self.tower:setPositionY(self.tower:getPositionY() - GameDisplay.fix_y)
	self.levelup_bg:setPositionY(self.levelup_bg:getPositionY() - GameDisplay.fix_y)
	self.levelupSpine:setPositionY(self.levelupSpine:getPositionY() - GameDisplay.fix_y)
end

function ActivitySpringFirecrackerLayer:updateLevelupPanel()
	if not self.levelupInfo then
		return
	end

	self.damage_level_label:setString("LV." .. (self.damage_level or 1))
	self.bullet_num_level_label:setString("LV." .. (self.bullet_num_level or 1))
	self.attack_speed_level_label:setString("LV." .. (self.attack_speed_level or 1))

	if self.damage_level >= self.levelupInfo.max_strengthen_level then
		self.btn_damage_levelup:setVisible(false)
	elseif item_manager:isHaveEnoughItem(self.levelupInfo.strengthen_item, self.levelupInfo.damage_level_need) then
		self.btn_damage_levelup:loadTextures(self.respath .. "btn_levelup_on.png", nil, self.respath .. "btn_levelup_on.png", var_0_0)
	else
		self.btn_damage_levelup:loadTextures(self.respath .. "btn_levelup_off.png", nil, self.respath .. "btn_levelup_off.png", var_0_0)
	end

	if self.bullet_num_level >= self.levelupInfo.max_strengthen_level then
		self.btn_bullet_num_levelup:setVisible(false)
	elseif item_manager:isHaveEnoughItem(self.levelupInfo.strengthen_item, self.levelupInfo.bullet_num_level_need) then
		self.btn_bullet_num_levelup:loadTextures(self.respath .. "btn_levelup_on.png", nil, self.respath .. "btn_levelup_on.png", var_0_0)
	else
		self.btn_bullet_num_levelup:loadTextures(self.respath .. "btn_levelup_off.png", nil, self.respath .. "btn_levelup_off.png", var_0_0)
	end

	if self.attack_speed_level >= self.levelupInfo.max_strengthen_level then
		self.btn_attack_speed_levelup:setVisible(false)
	elseif item_manager:isHaveEnoughItem(self.levelupInfo.strengthen_item, self.levelupInfo.attack_speed_level_need) then
		self.btn_attack_speed_levelup:loadTextures(self.respath .. "btn_levelup_on.png", nil, self.respath .. "btn_levelup_on.png", var_0_0)
	else
		self.btn_attack_speed_levelup:loadTextures(self.respath .. "btn_levelup_off.png", nil, self.respath .. "btn_levelup_off.png", var_0_0)
	end
end

function ActivitySpringFirecrackerLayer:updateHp(arg_44_1)
	self.hp_count = self.hp_count or 0

	if arg_44_1 > self.hp_count then
		for iter_44_0 = 1, arg_44_1 do
			if not self.rootLayer:getChildByName("hpitem_" .. iter_44_0) then
				local var_44_0 = ccui.ImageView:create(self.respath .. "hpItem.png", var_0_0)

				self.rootLayer:addChild(var_44_0)
				var_44_0:setPosition(50 + 20 * (iter_44_0 - 1), 880 + GameDisplay.fix_y)
				var_44_0:setName("hpitem_" .. iter_44_0)

				self.hp_count = self.hp_count + 1
			end
		end
	else
		for iter_44_1 = 1, self.hp_count do
			if iter_44_1 <= arg_44_1 then
				self.rootLayer:getChildByName("hpitem_" .. iter_44_1):setVisible(true)
			else
				self.rootLayer:getChildByName("hpitem_" .. iter_44_1):setVisible(false)
			end
		end
	end
end
