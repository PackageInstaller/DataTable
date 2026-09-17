PopRoomQuickFinishLayer = class("PopRoomQuickFinishLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local lab_workshop_data = require("data.lab_workshop_data")
local dorm_rooms_data = require("data.dorm_rooms_data")

function PopRoomQuickFinishLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopRoomQuickFinishLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopRoomQuickFinishLayer:init(arg_3_1)
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

	self.goto_back_system_id = arg_3_1.goto_back_system_id
	self.sureCallback = arg_3_1.sureCallback
	self.time = arg_3_1.surplus

	self:initData()
	self:initUI()
	self:updateUI()
end

function PopRoomQuickFinishLayer:initData()
	self.itemList = {}

	for iter_6_0, iter_6_1 in pairs(item_data) do
		if iter_6_1.bag_item_type == KITEM_LAB_SPEEDUP_TICKTE then
			table.insert(self.itemList, {
				id = iter_6_1.id,
				quality = iter_6_1.equip_quality
			})
		end
	end

	table.sort(self.itemList, function(arg_7_0, arg_7_1)
		return arg_7_0.quality < arg_7_1.quality
	end)

	self.selectNo = 1
	self.selectNum = 1
	self.selectItem = self.itemList[self.selectNo].id
end

function PopRoomQuickFinishLayer:initUI()
	local var_8_0 = ccui.ImageView:create("pop_unlock_room/title_unlock_workshop.png", var_0_0)

	var_8_0:setPositionX(var_8_0:getContentSize().width / 2)
	var_8_0:setPositionY(self.rootpanel:getContentSize().height + var_8_0:getContentSize().height / 2 + 5)
	self.rootpanel:addChild(var_8_0)

	self.unlockBtn = ccui.Button:create("pop_unlock_room/btn_unlock.png", nil, "pop_unlock_room/btn_unlock.png", var_0_0)

	self.unlockBtn:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.unlockBtn:setPositionY(-self.unlockBtn:getContentSize().height / 2)
	self.rootpanel:addChild(self.unlockBtn)

	self.buttonDes = cc.Label:createWithTTF("", FONT_BUTTON, 32)

	self.buttonDes:setColor(cc.c3b(12, 12, 12))
	self.buttonDes:setPositionX(self.unlockBtn:getContentSize().width / 2)
	self.buttonDes:setPositionY(self.unlockBtn:getContentSize().height / 2 - 5)
	self.unlockBtn:addChild(self.buttonDes)

	self.costIcon = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_0)

	self.costIcon:setPositionY(-5)
	self.costIcon:setPositionX(self.unlockBtn:getContentSize().width / 2 - 15)
	self.unlockBtn:addChild(self.costIcon)

	self.costLabel = cc.Label:createWithTTF("", FONT_DES, 24)

	self.costLabel:setAnchorPoint(cc.p(0, 0.5))
	self.costLabel:setPositionY(self.costIcon:getPositionY())
	self.costLabel:setPositionX(self.unlockBtn:getContentSize().width / 2 + 10)
	self.unlockBtn:addChild(self.costLabel)

	self.clockIcon = ccui.ImageView:create("room_widget/img_clock.png", var_0_0)

	self.clockIcon:setPosition(cc.p(500, 170))
	self.rootpanel:addChild(self.clockIcon)

	self.costTimeLabel = cc.Label:createWithTTF(global_get_time_by_second(self.time), FONT_DES, 22)

	self.costTimeLabel:setAnchorPoint(cc.p(0, 0.5))
	self.costTimeLabel:setPositionX(self.clockIcon:getPositionX() + self.clockIcon:getContentSize().width / 2 + 5)
	self.costTimeLabel:setPositionY(self.clockIcon:getPositionY())
	self.rootpanel:addChild(self.costTimeLabel)
	self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		self.time = self.time - 1

		self:updateUI()
	end))))

	self.selectNum = math.ceil(self.time / item_data[self.selectItem].speedup_time)
	self.itemSp = ItemSmallSprite:createSmallItem()

	self.itemSp:setScale(0.8)
	self.itemSp:setInfoTouchEvent(true)
	self.itemSp:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.itemSp:setPositionY(self.rootpanel:getContentSize().height / 2)
	self.rootpanel:addChild(self.itemSp)
	self.unlockBtn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)

		local function var_10_0()
			if self.sureCallback then
				self.sureCallback(self.selectItem, self.selectNum, function(arg_12_0)
					if arg_12_0 == 1 then
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
		end

		if item_manager:getItemNumber(self.selectItem) >= self.selectNum then
			var_10_0()
		else
			local var_10_1 = self.selectNum - item_manager:getItemNumber(self.selectItem)

			if item_data[self.selectItem].price_diamond * var_10_1 > playermodel.diamond then
				LayerManager:pushInLayer("PopGoBuyDiamond", {
					targetlayer = "PopSupermarketLayer"
				})
				self.hideActions.shrinkVertical(self, function()
					if self.exitcallback then
						self.exitcallback(0)
					end

					LayerManager:removePopLayer(self.__queueindex)
				end)
			else
				local var_10_2 = {
					is_need_pop_layer = 1,
					surecallback = function()
						playermodel:purchase_speed_up_ticket(var_10_1, function(arg_16_0)
							if arg_16_0.result == 1 then
								var_10_0()
							end
						end)
					end
				}

				var_10_2.costtype = "diamond"
				var_10_2.own = playermodel.diamond
				var_10_2.cost = item_data[self.selectItem].price_diamond * var_10_1
				var_10_2.labels = global_deepCopy(L_QUICK_FINISH_UNLOCK_ROOM)
				var_10_2.labels.des = string.format(L_BUY_SCRIP, item_data[self.selectItem].price_diamond * var_10_1, var_10_1, item_data[self.selectItem].name)

				function var_10_2.cancelcallback()
					arg_10_0:setBright(true)
				end

				LayerManager:pushInLayer("PopDoLayer", var_10_2)
			end
		end
	end)
	self:updateUI()
end

function PopRoomQuickFinishLayer:updateUI()
	self.costTimeLabel:setString(global_get_time_by_second(self.time))

	self.selectNum = math.ceil(self.time / item_data[self.selectItem].speedup_time)

	self.itemSp:updateSmallItemByItemid(self.selectItem, item_manager:getItemNumber(self.selectItem), self.selectNum, self.goto_back_system_id)

	if item_manager:getItemNumber(self.selectItem) < self.selectNum then
		self.unlockBtn:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_0)
		self.buttonDes:setString(L_LABLINE_QUICK_FINISH.Btn_Str[2])
		self.costIcon:setVisible(true)
		self.costLabel:setVisible(true)
		self.costLabel:setString(item_data[self.selectItem].price_diamond * (self.selectNum - item_manager:getItemNumber(self.selectItem)))
	else
		self.unlockBtn:loadTextures("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_0)
		self.buttonDes:setString(L_LABLINE_QUICK_FINISH.Btn_Str[2])
		self.costIcon:setVisible(false)
		self.costLabel:setVisible(false)
	end
end

function PopRoomQuickFinishLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
