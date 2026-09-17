PopLabQuickFinish = class("PopLabQuickFinish", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local lab_manager = require("controller.lab_manager")
local item_data = require("data.item_data")
local lab_workshop_data = require("data.lab_workshop_data")
local dorm_rooms_data = require("data.dorm_rooms_data")
local var_0_8 = 200
local var_0_9 = 60
local var_0_10 = 1
local var_0_11 = 360
local var_0_12 = 0.5
local var_0_13 = 0.2

function PopLabQuickFinish.create(arg_2_0, arg_2_1)
	local var_2_0 = PopLabQuickFinish.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopLabQuickFinish:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopLabQuickFinish.json" or "PopLabQuickFinish.ExportJson")

	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, 0))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(true)
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
	self.showActions.extendVertical(self)

	self.sureCallback = arg_3_1.sureCallback
	self.sumTime = arg_3_1.sumTime
	self.goto_back_system_id = arg_3_1.goto_back_system_id
	self.currency = arg_3_1.currency or ELECTRIC
	self.quality = arg_3_1.quality or 1

	self:initData()
	self:updateData()
	self:initUI()
	self:updateUI()
end

function PopLabQuickFinish:initData()
	self.itemList = {
		{
			id = self.currency,
			quality = self.quality
		}
	}

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

function PopLabQuickFinish:updateData()
	self.selectItem = self.itemList[self.selectNo].id
	self.addTime = self:getSpeedupTime(self.selectItem, self.selectNum)
end

function PopLabQuickFinish:initUI()
	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_items")

	for iter_9_0, iter_9_1 in pairs(self.itemList) do
		local var_9_1 = ItemSmallSprite:createSmallItem()

		var_9_1:setScale(0.7)
		var_9_1:setName("sp_" .. iter_9_0)
		var_9_1:setPositionX(var_9_0:getContentSize().width / 2 + (iter_9_0 - (#self.itemList + 1) / 2) * (var_9_1:getContentSize().width + 5))
		var_9_1:setPositionY(var_9_0:getContentSize().height / 2)
		var_9_0:addChild(var_9_1)

		var_9_1.index = iter_9_0

		local var_9_2 = ccui.ImageView:create("public/button/select_item.png", var_0_0)

		var_9_2:setPositionX(var_9_1:getContentSize().width - var_9_2:getContentSize().width / 2)
		var_9_2:setPositionY(var_9_1:getContentSize().height - var_9_2:getContentSize().height / 2)
		var_9_2:setName("selectTag")
		var_9_1:addChild(var_9_2)
		var_9_1:setTouchEnabled(true)
		var_9_1:addTouchEventListener(self:getItemTouchHandel(function(arg_10_0)
			self.selectNo = arg_10_0.index

			if self.itemList[arg_10_0.index].id ~= self.selectItem then
				self.selectNum = 1
			end

			self:updateData()
			self:updateUI()
		end, function(arg_11_0)
			local var_11_0 = PopLayer:Item({
				itemid = arg_11_0.itemid,
				goto_back_system_id = self.goto_back_system_id,
				layer = cc.Layer:create()
			})
		end))
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sub"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectNum = self.selectNum - 1
		self.selectNum = math.max(self.selectNum, 1)

		self:updateData()
		self:updateUI()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_add"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectNum = self.selectNum + 1

		local var_13_0 = math.ceil(self.sumTime / self:getSpeedupTime(self.selectItem))

		if var_13_0 < self.selectNum then
			global_ShowBlockWords(L_LABLINE_QUICK_FINISH.Limit)

			self.selectNum = var_13_0
		end

		self:updateData()
		self:updateUI()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_min"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectNum = 1

		self:updateData()
		self:updateUI()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_max"):addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectNum = math.min(math.ceil(self.sumTime / self:getSpeedupTime(self.selectItem)), self:getOwnNum(self.selectItem))
		self.selectNum = math.max(self.selectNum, 1)

		self:updateData()
		self:updateUI()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:getOwnNum(self.selectItem) < self.selectNum then
			self:purchasePop()
		else
			if not arg_16_0:isBright() then
				return
			end

			arg_16_0:setBright(false)

			if self.sureCallback then
				self.sureCallback(self.selectItem, self.selectNum, function(arg_17_0)
					if arg_17_0 == 1 then
						self.hideActions.shrinkVertical(self, function()
							if self.exitcallback then
								self.exitcallback(0)
							end

							LayerManager:removePopLayer(self.__queueindex)
						end)
					end

					arg_16_0:setBright(true)
				end)
			end
		end
	end)
end

local function var_0_14(arg_19_0)
	return {
		hour = math.floor(arg_19_0 / 3600),
		min = math.floor(arg_19_0 % 3600 / 60),
		sec = arg_19_0 % 60
	}
end

function PopLabQuickFinish:updateUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_useNum"):setString(self.selectNum)

	local var_20_0 = var_0_14(self.addTime)
	local var_20_1 = var_0_14(math.max(self.sumTime - self.addTime, 0))
	local var_20_2 = var_0_14(self.sumTime)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_addTime"):setString(string.format("%02d", var_20_0.hour) .. ":" .. string.format("%02d", var_20_0.min) .. ":" .. string.format("%02d", var_20_0.sec))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_addAfterTime"):setString(string.format("%02d", var_20_1.hour) .. ":" .. string.format("%02d", var_20_1.min) .. ":" .. string.format("%02d", var_20_1.sec))

	if self:getOwnNum(self.selectItem) < self.selectNum then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_btnDes"):setString(L_LABLINE_QUICK_FINISH.Btn_Str[1])
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_btnDes"):setString(L_LABLINE_QUICK_FINISH.Btn_Str[2])
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_14"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costNum"):setVisible(false)

	for iter_20_0, iter_20_1 in pairs(self.itemList) do
		local var_20_3 = 1

		if iter_20_1.id == self.selectItem then
			var_20_3 = self.selectNum
		end

		local var_20_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "sp_" .. iter_20_0)

		var_20_4:updateSmallItemByItemid(iter_20_1.id, self:getOwnNumByDisplay(iter_20_1.id), self:getCost(iter_20_1.id, var_20_3), self.goto_back_system_id)
		var_20_4:getChildByName("selectTag"):setVisible(iter_20_1.id == self.selectItem)
	end
end

function PopLabQuickFinish:purchasePop()
	if self.selectItem == "gold" then
		PopLayer:popGainGold(self.goto_back_system_id, {
			callback = function()
				self:updateData()
				self:updateUI()
			end
		})
	elseif self.selectItem == "diamond" then
		LayerManager:pushInLayer("PopGoBuyDiamond", {
			is_need_pop_layer = 1
		})
	else
		local var_21_0 = cc.Layer:create()
		local var_21_1 = PopLayer:Go_Gain_Layer({
			item = self.selectItem,
			goto_back_system_id = self.goto_back_system_id
		})

		if var_21_1 then
			cc.Director:getInstance():getRunningScene():addChild(var_21_1, 999)
		end
	end
end

function PopLabQuickFinish.getCost(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == "gold" then
		return var_0_8 * arg_23_2
	elseif arg_23_1 == "diamond" then
		return var_0_10 * arg_23_2
	else
		return arg_23_2
	end
end

function PopLabQuickFinish:getSpeedupTime(arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or 1

	return (arg_24_1 == "gold" and var_0_9 or arg_24_1 == "diamond" and var_0_11 or item_data[self.selectItem].speedup_time) * arg_24_2
end

function PopLabQuickFinish.getOwnNum(arg_25_0, arg_25_1)
	return arg_25_1 == "gold" and math.floor(playermodel.gold / var_0_8) or arg_25_1 == "diamond" and math.floor(playermodel.diamond / var_0_10) or item_manager:getItemNumber(arg_25_1)
end

function PopLabQuickFinish.getOwnNumByDisplay(arg_26_0, arg_26_1)
	return arg_26_1 == "gold" and playermodel.gold or arg_26_1 == "diamond" and playermodel.diamond or item_manager:getItemNumber(arg_26_1)
end

function PopLabQuickFinish.getItemTouchHandel(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0

	return function(arg_28_0, arg_28_1)
		if arg_28_1 == ccui.TouchEventType.began or arg_28_1 == ccui.TouchEventType.moved then
			var_27_0 = true

			if arg_28_1 == ccui.TouchEventType.began and type(arg_28_0.itemid) == "number" then
				arg_27_0:startPress(function()
					return true
				end, function()
					arg_27_0:endPress()

					var_27_0 = false

					if arg_27_2 then
						arg_27_2(arg_28_0)
					end
				end)
			end
		elseif arg_28_1 == ccui.TouchEventType.canceled then
			arg_27_0:endPress()
		elseif arg_28_1 == ccui.TouchEventType.ended then
			arg_27_0:endPress()

			if var_27_0 and arg_27_1 then
				arg_27_1(arg_28_0)
			end
		end
	end
end

function PopLabQuickFinish:startPress(arg_31_1, arg_31_2)
	local var_31_0 = 0.1

	self.timer = cc.Node:create()

	self:addChild(self.timer)

	self.timer1 = cc.Node:create()

	self:addChild(self.timer1)
	self.timer1:runAction(cc.Sequence:create(cc.DelayTime:create(var_0_13), cc.CallFunc:create(function()
		if arg_31_1() then
			self:showLongPressProgress()
			self.timer:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				self:setLongPressProgressPercent(var_31_0 / var_0_12 * 100)

				if var_31_0 >= var_0_12 then
					self.timer:stopAllActions()

					if arg_31_2 then
						arg_31_2()
					end
				end

				var_31_0 = var_31_0 + 0.016666666666666666
			end))))
		else
			self:endPress()
		end
	end)))
end

function PopLabQuickFinish:endPress()
	if self.timer then
		self.timer:stopAllActions()
		self.timer1:stopAllActions()
	end

	self:hideLongPressProgress()
end

function PopLabQuickFinish:showLongPressProgress()
	if not self.progress then
		self.progressBg = ccui.Layout:create()

		self.progressBg:setTouchEnabled(true)
		self.progressBg:setContentSize(cc.size(640, GameDisplay.height))
		self.progressBg:setAnchorPoint(cc.p(0.5, 0.5))
		self.progressBg:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
		self.progressBg:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		self.progressBg:setBackGroundColor(cc.c3b(0, 0, 0))
		self.progressBg:setBackGroundColorOpacity(128)
		self.progressBg:setPosition(cc.p(320, GameDisplay.height / 2))
		self.rootLayer:addChild(self.progressBg, 10000)

		self.progress = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create("public/button/press_bar.png") or cc.Sprite:createWithSpriteFrameName("public/button/press_bar.png")))

		self.progress:setAnchorPoint(cc.p(0.5, 0.5))
		self.progress:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
		self.progress:setPositionX(self.progressBg:getContentSize().width / 2)
		self.progress:setPositionY(self.progressBg:getContentSize().height / 2)
		self.progress:setReverseDirection(false)
		self.progressBg:addChild(self.progress)
	end

	self.progressBg:setVisible(true)
	self.progress:setPercentage(50)
end

function PopLabQuickFinish:hideLongPressProgress()
	if self.progress then
		self.progressBg:setVisible(false)
	end
end

function PopLabQuickFinish:setLongPressProgressPercent(arg_37_1)
	if self.progress then
		self.progress:setPercentage(arg_37_1)
	end
end

function PopLabQuickFinish:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
