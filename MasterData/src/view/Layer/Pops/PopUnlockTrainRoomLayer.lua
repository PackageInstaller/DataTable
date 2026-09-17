PopUnlockTrainRoomLayer = class("PopUnlockTrainRoomLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local train_rooms_data = require("data.train_rooms_data")
local item_data = require("data.item_data")
local LocalEvent = require("common.LocalEvent")
local Utility = require("common.Utility")

function PopUnlockTrainRoomLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopUnlockTrainRoomLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopUnlockTrainRoomLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	self.id = arg_3_1.roomid
	self.sureCallback = arg_3_1.sureCallback
	self.goto_back_system_id = arg_3_1.goto_back_system_id

	self:initUI()
	self:updateUI()
	Utility:registerNodeEvent(self)
	LocalEvent:registerEvent(self, LocalEvent.EVENT_IDS.COMPOUND_ITEM_ONE_KEY, handler(self, self.handleComposeItemOneKey))
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("electricSupply", function(...)
		self:updateUI()
	end), self)
end

function PopUnlockTrainRoomLayer:handleComposeItemOneKey()
	self:updateUI()
end

function PopUnlockTrainRoomLayer.onExit(arg_8_0)
	LocalEvent:removeEvent(arg_8_0)
end

function PopUnlockTrainRoomLayer:initUI()
	local var_9_0 = ccui.ImageView:create("public/title/unlock_train.png", var_0_0)

	var_9_0:setPositionX(var_9_0:getContentSize().width / 2)
	var_9_0:setPositionY(self.rootpanel:getContentSize().height + var_9_0:getContentSize().height / 2 + 5)
	self.rootpanel:addChild(var_9_0)

	local var_9_1 = cc.Label:createWithTTF(L_LAB_UNLOCK_MATERIAL, FONT_NAME, 30)

	var_9_1:setColor(cc.c3b(216, 230, 246))
	var_9_1:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_9_1:setPositionY(self.rootpanel:getContentSize().height - var_9_1:getContentSize().height)
	self.rootpanel:addChild(var_9_1)

	local var_9_2 = ccui.ImageView:create("SchoolTrainLayer/img_clock.png", var_0_0)

	var_9_2:setPositionX(self.rootpanel:getContentSize().width / 2 + 190)
	var_9_2:setPositionY(self.rootpanel:getContentSize().height - var_9_1:getContentSize().height)
	self.rootpanel:addChild(var_9_2)

	self.labelTime = cc.Label:createWithTTF("", FONT_NAME, 20)

	self.labelTime:setColor(cc.c3b(255, 255, 255))
	self.labelTime:setAnchorPoint(cc.p(0, 0.5))
	self.labelTime:setPosition(cc.p(var_9_2:getContentSize().width + 10, var_9_2:getContentSize().height / 2))
	var_9_2:addChild(self.labelTime, 999)

	self.unlockBtn = ccui.Button:create("public/button/btn_unlock.png", nil, "public/button/btn_unlock.png", var_0_0)

	self.unlockBtn:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.unlockBtn:setPositionY(-self.unlockBtn:getContentSize().height / 2)
	self.rootpanel:addChild(self.unlockBtn)
	self.unlockBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)

		if self.sureCallback then
			self.sureCallback(function(arg_11_0)
				if arg_11_0 == 1 then
					while train_rooms_data[self.id]["material" .. 1] do
						item_manager:deleteItem(train_rooms_data[self.id]["material" .. 1], train_rooms_data[self.id]["material" .. 1 .. "_num"])
					end

					if train_rooms_data[self.id].gold and train_rooms_data[self.id].gold > 0 then
						playermodel.gold = playermodel.gold - train_rooms_data[self.id].gold

						global_update_gold_stone_diamond(playermodel.gold)
					end

					if train_rooms_data[self.id].costdiamond and train_rooms_data[self.id].costdiamond > 0 then
						playermodel.diamond = playermodel.diamond - train_rooms_data[self.id].costdiamond

						global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
					end

					self.hideActions.shrinkVertical(self, function()
						if self.exitcallback then
							self.exitcallback(0)
						end

						LayerManager:removePopLayer(self.__queueindex)
					end)
				end

				arg_10_0:setBright(true)
			end)
		end
	end)
end

function PopUnlockTrainRoomLayer:updateUI()
	local var_13_0 = {}

	if train_rooms_data[self.id].costdiamond and train_rooms_data[self.id].costdiamond > 0 then
		table.insert(var_13_0, {
			itemid = "diamond",
			needNum = train_rooms_data[self.id].costdiamond,
			ownNum = playermodel.diamond
		})
	end

	if train_rooms_data[self.id].gold and train_rooms_data[self.id].gold > 0 then
		table.insert(var_13_0, {
			itemid = "gold",
			needNum = train_rooms_data[self.id].gold,
			ownNum = playermodel.gold
		})
	end

	if train_rooms_data[self.id].cost_time and train_rooms_data[self.id].cost_time > 0 then
		local var_13_1 = math.fmod(math.floor(train_rooms_data[self.id].cost_time / 60 / 60), 25)
		local var_13_2 = math.fmod(math.floor(train_rooms_data[self.id].cost_time / 60), 60)
		local var_13_3 = math.fmod(train_rooms_data[self.id].cost_time, 60)

		if var_13_1 == 0 then
			self.labelTime:setString(string.format("%02d", var_13_2) .. ":" .. string.format("%02d", var_13_3))
		else
			self.labelTime:setString(string.format("%02d", var_13_1) .. ":" .. string.format("%02d", var_13_2) .. ":" .. string.format("%02d", var_13_3))
		end
	end

	local var_13_4 = 1

	while train_rooms_data[self.id]["material" .. var_13_4] do
		table.insert(var_13_0, {
			itemid = train_rooms_data[self.id]["material" .. var_13_4],
			needNum = train_rooms_data[self.id]["material" .. var_13_4 .. "_num"],
			ownNum = item_manager:getItemNumber(train_rooms_data[self.id]["material" .. var_13_4])
		})

		var_13_4 = var_13_4 + 1
	end

	local var_13_5 = false

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1.needNum > iter_13_1.ownNum then
			var_13_5 = true
		end

		local var_13_6 = ItemSmallSprite:createSmallItem(iter_13_1.itemid, iter_13_1.ownNum, iter_13_1.needNum, self.goto_back_system_id)

		var_13_6:setScale(0.7)
		var_13_6:setInfoTouchEvent(true)
		var_13_6:setPositionX(self.rootpanel:getContentSize().width / 2 - (iter_13_0 - (#var_13_0 + 1) / 2) * (var_13_6:getContentSize().width + 5))
		var_13_6:setPositionY(self.rootpanel:getContentSize().height / 2 - 10)
		self.rootpanel:addChild(var_13_6)
	end

	if var_13_5 then
		self.unlockBtn:loadTextures("public/button/btn_unlock_gray.png", nil, "public/button/btn_unlock_gray.png", var_0_0)

		self.unlockBtn.satisfied = false
	else
		self.unlockBtn:loadTextures("public/button/btn_unlock.png", nil, "public/button/btn_unlock.png", var_0_0)

		self.unlockBtn.satisfied = true
	end
end
