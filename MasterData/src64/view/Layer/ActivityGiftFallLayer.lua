ActivityGiftFallLayer = class("ActivityGiftFallLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local giftfall_conf = require("data.giftfall_conf")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local giftfall_gamelogic_manager = require("controller.giftfall_gamelogic_manager")
local var_0_9 = 130
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_13 = 4
local ObjectPool = require("view.Layer.ObjectPool")

function ActivityGiftFallLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityGiftFallLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityGiftFallLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.layerName = "ActivityGiftFallLayer_" .. self.activityId
	self.respath = "ActivityGiftFallLayer_" .. self.activityId .. "/"

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	self:initTouchEvent()
	giftfall_gamelogic_manager:registerUIRef(self)
	self:registerGameEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)
			TextureManager:removeLayerTextures({
				self.layerName
			})
			giftfall_gamelogic_manager:exitGame()
		end
	end)
	self:fullScreen()
	self:updateItemNum()
end

function ActivityGiftFallLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, function(arg_6_0)
		self:updateItemNum()
	end)
end

function ActivityGiftFallLayer:initTouchEvent()
	self.title:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityGiftFallLayer_" .. self.activityId
		})
	end)
	self.return_btn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.task_btn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityGameTaskLayer", {
			uiconfmodule = "giftfall",
			activityId = self.activityId
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_11_0, arg_11_1)
		local var_11_0

		if arg_11_1 ~= ccui.TouchEventType.ended then
			do return end

			var_11_0 = {}
		end

		var_11_0[1] = "1-" .. tonumber(giftfall_conf[self.activityId].shop) % 1500000

		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_11_0,
			showType = var_11_0[1]
		})
	end)
	self.start_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:activity_smallgame_startgame(self.activityId, {
			gametype = ACTIVITY_SMALLGAME_TYPE_GIFTFALL
		}, function(arg_13_0)
			if arg_13_0.result ~= 1 then
				return
			end

			giftfall_gamelogic_manager:gameStart()
			self.start_btn:setVisible(false)
			self.main_icon:setVisible(true)
			self.main_icon:setPositionX(320)
			self.timeLabel:setVisible(true)
			self:updateItemNum()
		end)
	end)
end

function ActivityGiftFallLayer.registerGameEvent(arg_14_0)
	giftfall_gamelogic_manager:registerGameEvent("ADD_GIFT", arg_14_0, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_14_0.objPool:getObject()

		if not var_15_0 then
			var_15_0 = ccui.ImageView:create(arg_14_0.respath .. "gift_1.png", var_0_0)

			arg_14_0.rootLayer:addChild(var_15_0, 2)
			arg_14_0.objPool:createObject(var_15_0)

			var_15_0 = arg_14_0.objPool:getObject()
		end

		;(function(arg_16_0, arg_16_1)
			if arg_16_1 == var_0_10 then
				arg_16_0:setScale(0.6)
				arg_16_0:loadTexture(arg_14_0.respath .. "gift_" .. math.random(4) .. ".png", var_0_0)
			elseif arg_16_1 == var_0_11 then
				arg_16_0:setScale(1)
				arg_16_0:loadTexture(arg_14_0.respath .. "gift_" .. math.random(4) .. ".png", var_0_0)
			elseif arg_16_1 == var_0_12 then
				arg_16_0:setScale(0.6)
				arg_16_0:loadTexture(arg_14_0.respath .. "fall_freeze_gift.png", var_0_0)
			elseif arg_16_1 == var_0_13 then
				arg_16_0:setScale(0.6)
				arg_16_0:loadTexture(arg_14_0.respath .. "move_freeze_gift.png", var_0_0)
			end
		end)(var_15_0, arg_15_1.type)
		var_15_0:setPosition(arg_15_1.posX, arg_15_1.posY)

		arg_15_1.node = var_15_0
	end)
	giftfall_gamelogic_manager:registerGameEvent("DELETE_GIFT", arg_14_0, function(arg_17_0, arg_17_1)
		arg_14_0.objPool:recycleObject(arg_17_1.node)
	end)
	giftfall_gamelogic_manager:registerGameEvent("GAME_END", arg_14_0, function(arg_18_0, arg_18_1)
		global_ShowBlockWords("游戏结束！得分为:" .. arg_18_1.score)
		arg_14_0.scoreLabel:setString(arg_18_1.score)
		arg_14_0.objPool:clearAllActiveObject()
		activity_manager:activity_smallgame_data_report(arg_14_0.activityId, {
			score = arg_18_1.score,
			key_point_num = arg_18_1.score,
			gametype = ACTIVITY_SMALLGAME_TYPE_GIFTFALL
		}, function(arg_19_0)
			if arg_19_0.result ~= 1 then
				return
			end

			arg_14_0:updateItemNum()
		end)
		arg_14_0.start_btn:setVisible(true)
		arg_14_0.main_icon:setVisible(false)
		arg_14_0.timeLabel:setVisible(false)
	end)
	giftfall_gamelogic_manager:registerGameEvent("UPDATE_GAMEDATA", arg_14_0, function(arg_20_0, arg_20_1)
		if arg_20_1.score then
			arg_14_0.scoreLabel:setString(arg_20_1.score)
		end

		if arg_20_1.player_posX then
			arg_14_0.main_icon:setPositionX(arg_20_1.player_posX)
		end

		if arg_20_1.time then
			arg_14_0.timeLabel:setString(math.floor(arg_20_1.time) .. "s")
		end
	end)
end

function ActivityGiftFallLayer:initUI()
	self.title = self.rootLayer:getChildByName("title")
	self.scoreLine = self.rootLayer:getChildByName("scoreLine")
	self.scoreLabel = self.rootLayer:getChildByName("scoreLabel")

	self.scoreLabel:setString("0")

	self.shop_btn = self.rootLayer:getChildByName("btn_shop")
	self.task_btn = self.rootLayer:getChildByName("btn_task")
	self.return_btn = self.rootLayer:getChildByName("btn_return")
	self.start_btn = self.rootLayer:getChildByName("btn_start")
	self.key_item_icon = self.rootLayer:getChildByName("key_item_icon")
	self.key_point_icon = self.rootLayer:getChildByName("key_point_icon")
	self.keyitem_label_bg = self.rootLayer:getChildByName("keyitem_label_bg")
	self.keypoint_label_bg = self.rootLayer:getChildByName("keypoint_label_bg")
	self.keyitem_label = self.keyitem_label_bg:getChildByName("numLabel")
	self.keypoint_label = self.keypoint_label_bg:getChildByName("numLabel")

	self.key_item_icon:setTouchEnabled(true)
	self.key_point_icon:setTouchEnabled(true)

	self.main_icon = ccui.ImageView:create(self.respath .. "main_icon.png", var_0_0)

	self.rootLayer:addChild(self.main_icon, 3)
	self.main_icon:setPosition(320, var_0_9)
	self.main_icon:setScale(0.6)
	self.main_icon:setTouchEnabled(true)
	self.main_icon:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 == ccui.TouchEventType.began then
			-- block empty
		elseif arg_22_1 == ccui.TouchEventType.moved then
			giftfall_gamelogic_manager:TouchMove((math.min(560, math.max(80, arg_22_0:getTouchMovePosition().x))))
		elseif arg_22_1 == ccui.TouchEventType.ended then
			giftfall_gamelogic_manager:TouchMoveEnd()
		elseif arg_22_1 == ccui.TouchEventType.canceled then
			giftfall_gamelogic_manager:TouchMoveEnd()
		end
	end)
	self.main_icon:setVisible(false)

	self.timeLabel = cc.Label:createWithTTF("60s", FONT_NAME, 32)

	self.rootLayer:addChild(self.timeLabel, 5)
	self.timeLabel:setPosition(560, 860)
	self.timeLabel:setVisible(false)

	self.objPool = ObjectPool:new()
end

function ActivityGiftFallLayer:updateItemNum()
	self.keyitem_label:setString(item_manager:getItemNumber(giftfall_conf[self.activityId].key_item))
	self.keypoint_label:setString(item_manager:getItemNumber(giftfall_conf[self.activityId].key_point))
end

function ActivityGiftFallLayer:fullScreen()
	self.title:setPositionY(self.title:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.scoreLine:setPositionY(self.scoreLine:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.scoreLabel:setPositionY(self.scoreLabel:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.key_item_icon:setPositionY(self.key_item_icon:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.key_point_icon:setPositionY(self.key_point_icon:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.keyitem_label_bg:setPositionY(self.keyitem_label_bg:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.keypoint_label_bg:setPositionY(self.keypoint_label_bg:getPositionY() + 0.8 * GameDisplay.fix_y)
	self.return_btn:setPositionY(self.return_btn:getPositionY() - 0.9 * GameDisplay.fix_y)
	self.task_btn:setPositionY(self.task_btn:getPositionY() - 0.9 * GameDisplay.fix_y)
	self.shop_btn:setPositionY(self.shop_btn:getPositionY() - 0.9 * GameDisplay.fix_y)
end
