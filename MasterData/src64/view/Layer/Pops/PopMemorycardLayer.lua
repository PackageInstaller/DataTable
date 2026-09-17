local baseCard = class("baseCard", function()
	return cc.Node:create()
end)

function baseCard:create()
	local var_2_0 = baseCard.new()

	var_2_0:init()

	return var_2_0
end

function baseCard:init()
	self:setPosition(cc.p(0, 0))

	self.m_scaleDt = 1
	self.m_isScale = false
	self.m_isFront = true
	self.m_pFront = nil
	self.m_pBack = nil
	self.m_box = nil
	self.m_name = ""
end

function baseCard:bindFontSprite(arg_4_1)
	self.m_pFront = arg_4_1

	self.m_pFront:setScaleX(0)
	self:addChild(self.m_pFront)
end

function baseCard:bindBackSprite(arg_5_1)
	self.m_pBack = arg_5_1

	self:addChild(self.m_pBack)
end

function baseCard:getFrontImage()
	return self.m_pFront
end

function baseCard:getBackImage()
	return self.m_pBack
end

function baseCard:setDt(arg_8_1)
	self.m_scaleDt = arg_8_1
end

function baseCard:getDt()
	return self.m_scaleDt
end

function baseCard:scaleCard()
	if self.m_isScale == false then
		self.m_isScale = true

		local var_10_0 = cc.Sequence:create(cc.ScaleTo:create(self.m_scaleDt, 0, 1), cc.CallFunc:create(self:scaleCardStepTwo()))

		if self.m_pFront:getScaleX() == 1 then
			self.m_pFront:runAction(var_10_0)

			self.m_isFront = false
		else
			self.m_pBack:runAction(var_10_0)

			self.m_isFront = true
		end
	end
end

function baseCard:scaleCardStepTwo()
	return function()
		local var_12_0 = cc.Sequence:create(cc.ScaleTo:create(self.m_scaleDt, 1, 1), (cc.CallFunc:create(function()
			self.m_isScale = false
		end)))

		if self.m_isFront == false then
			self.m_pBack:runAction(var_12_0)
		else
			self.m_pFront:runAction(var_12_0)
		end
	end
end

function baseCard:setRect()
	local var_14_0 = self.m_pFront:getContentSize()
	local var_14_1 = self:getBoundingBox()

	self.m_box = cc.rect(var_14_1.x - var_14_0.width / 2, var_14_1.y - var_14_0.height / 2, var_14_0.width, var_14_0.height)
end

function baseCard:isRectContainsPoint(arg_15_1)
	if cc.rectContainsPoint(self.m_box, arg_15_1) then
		return true
	else
		return false
	end
end

local TileSprite = require("view.Sprite.explore.TileSprite")

PopMemorycardLayer = class("PopMemorycardLayer", function()
	return PopBaseLayer:create()
end)

local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")
local tile_data = require("data.explore.tile_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local audio_module = require("controller.audio_module")
local explore_memory_card_img_data = require("data.explore.explore_memory_card_img_data")
local var_0_14 = config._DEBUG and 0 or 1
local var_0_16 = 8
local var_0_17 = {
	6700106,
	6700301,
	6700302,
	6700303,
	6700304,
	6700305,
	6700306,
	6700308
}

function PopMemorycardLayer.create(arg_17_0, arg_17_1)
	local var_17_0 = PopMemorycardLayer.new()

	if explore_memory_card_img_data[explore_manager.curMapConfig.aimid] then
		for iter_17_0, iter_17_1 in pairs(var_0_17) do
			if explore_memory_card_img_data[explore_manager.curMapConfig.aimid]["item_" .. iter_17_0] then
				var_0_17[iter_17_0] = explore_memory_card_img_data[explore_manager.curMapConfig.aimid]["item_" .. iter_17_0]
			end
		end
	end

	var_17_0:init(arg_17_1)

	return var_17_0
end

local function var_0_18(arg_18_0)
	for iter_18_0 = #arg_18_0, 1, -1 do
		local var_18_0 = math.random(1, iter_18_0)

		arg_18_0[var_18_0], arg_18_0[iter_18_0] = arg_18_0[iter_18_0], arg_18_0[var_18_0]
	end
end

function PopMemorycardLayer:initother(arg_19_1)
	self.point = 0
	self.isMatch = false
	self.preCard = nil
	self.cardTable = {}

	for iter_19_0 = 1, var_0_16 do
		for iter_19_1 = 1, 2 do
			local var_19_0 = baseCard:create()

			self.panelBottom:addChild(var_19_0)

			self.cardTable[#self.cardTable + 1] = var_19_0

			local var_19_1

			if config._DEBUG then
				var_19_1 = cc.Sprite:create("Activity_bianhua/MemoryCard/front.png") or cc.Sprite:createWithSpriteFrameName("Activity_bianhua/MemoryCard/front.png")
			end

			local var_19_2 = ccui.ImageView:create("equipment/" .. var_0_17[iter_19_0] .. ".png")

			var_19_2:setScale(0.66)
			var_19_2:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height / 2))
			var_19_1:addChild(var_19_2, 99)
			var_19_1:setPosition(cc.p(0, 0))
			var_19_0:bindFontSprite(var_19_1)

			local var_19_3

			if config._DEBUG then
				var_19_3 = cc.Sprite:create("Activity_bianhua/MemoryCard/back.png") or cc.Sprite:createWithSpriteFrameName("Activity_bianhua/MemoryCard/back.png")
			end

			var_19_3:setPosition(cc.p(0, 0))
			var_19_0:bindBackSprite(var_19_3)
			var_19_0:setName("food" .. iter_19_0)
			var_19_0:setDt(0.2)
		end
	end

	var_0_18(self.cardTable)

	for iter_19_2 = 1, var_0_16 * 2 do
		self.cardTable[iter_19_2]:setPosition(cc.p(75, 565))
		self.cardTable[iter_19_2]:setRect()

		local var_19_4 = 75 + 120

		if iter_19_2 % 4 == 0 then
			var_19_4 = 75
		end
	end

	local var_19_6 = cc.EventListenerTouchOneByOne:create()

	var_19_6:registerScriptHandler(function(arg_20_0, arg_20_1)
		if self.rootlayer and self.rootlayer.isTouch then
			self:onTouchBegan(arg_20_0, arg_20_1, arg_19_1)

			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_19_6:registerScriptHandler(function(arg_21_0, arg_21_1)
		return
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self.panelBottom:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_19_6, self.panelBottom)

	self.rootlayer.index = 0

	local function var_19_7()
		self.rootlayer.index = self.rootlayer.index + 1

		if self.rootlayer.index == 4 then
			self.rootlayer.endTime:runAction(cc.RemoveSelf:create())

			for iter_22_0 = 1, var_0_16 * 2 do
				self.cardTable[iter_22_0]:scaleCard()
			end

			self.rootlayer:stopAllActions()
			self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
				for iter_23_0, iter_23_1 in pairs(self.cardTable) do
					iter_23_1:scaleCard()
				end

				self:endGame()

				self.rootlayer.isTouch = true
			end)))
		end

		if not self.rootlayer.endTime and self.rootlayer.index < 4 then
			self.rootlayer.endTime = ccui.ImageView:create("Activity_bianhua/MemoryCard/" .. self.rootlayer.index .. ".png", var_0_14)

			self.rootlayer.endTime:setPosition(cc.p(self.imgBottom:getContentSize().width / 2, self.imgBottom:getContentSize().height / 2))
			self.imgBottom:addChild(self.rootlayer.endTime, 99)
		elseif self.rootlayer.index < 4 then
			self.rootlayer.endTime:loadTexture("Activity_bianhua/MemoryCard/" .. self.rootlayer.index .. ".png", var_0_14)
		end
	end

	self.btnStart:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.btnStart:setVisible(false)
		self.rootlayer:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(var_19_7), cc.DelayTime:create(1))))
	end)
end

function PopMemorycardLayer:onTouchBegan(arg_25_1, arg_25_2, arg_25_3)
	local function var_25_0()
		self.preCard = nil
		self.isMatch = false
	end

	local var_25_1 = self.panelBottom:convertToNodeSpace(arg_25_1:getLocation())

	if self.isMatch == false then
		for iter_25_0, iter_25_1 in pairs(self.cardTable) do
			if iter_25_1:isRectContainsPoint(var_25_1) then
				if iter_25_1:getBackImage():getScaleX() == 1 then
					iter_25_1:scaleCard()

					if self.preCard == nil then
						self.preCard = iter_25_1
					else
						self.isMatch = true

						if self.preCard:getName() == iter_25_1:getName() then
							self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(iter_25_1:getDt() * 3), cc.CallFunc:create(function()
								self.preCard:setVisible(false)
								iter_25_1:setVisible(false)
							end), cc.CallFunc:create(var_25_0)))

							self.point = self.point + 1

							if self.point == var_0_16 then
								if self.exitCallback then
									self.exitCallback()
								end

								self.rootlayer:stopAllActions()
								self.rootlayer:runAction(cc.Sequence:create(cc.CallFunc:create(function()
									local var_28_0 = ccui.ImageView:create("Activity_bianhua/MemoryCard/success.png", var_0_14)

									var_28_0:setPosition(cc.p(self.imgBottom:getContentSize().width / 2, self.imgBottom:getContentSize().height / 2))
									self.imgBottom:addChild(var_28_0, 99)
								end), cc.DelayTime:create(1), cc.CallFunc:create(function()
									if self.rootlayer.scheduler then
										cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.rootlayer.scheduler)

										self.rootlayer.scheduler = nil
									end

									if self.runTileEvent then
										self.runTileEvent()
									end

									LayerManager:removePopLayer()
									self:exit()
								end)))

								if self.rootlayer.scheduler then
									cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.rootlayer.scheduler)

									self.rootlayer.scheduler = nil
								end
							end
						else
							self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(iter_25_1:getDt() * 3), cc.CallFunc:create(function()
								self.preCard:scaleCard()
								iter_25_1:scaleCard()
								var_25_0()
							end)))
						end
					end

					break
				end
			end
		end
	end
end

function PopMemorycardLayer:init(arg_31_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopMemoryCard.json" or "PopMemoryCard.ExportJson")

	self:addChild(self.rootlayer)

	self.imgBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")
	self.panelBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_bottom")

	self.panelBottom:setVisible(true)

	self.btnStart = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_start")
	self.surplusTime = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_time")
	self.time = arg_31_1.time

	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_4"):getVirtualRenderer():setMaxLineWidth(451)
	self.surplusTime:setString("00:" .. self.time)
	self:initother(arg_31_1.cur_event)

	self.runTileEvent = arg_31_1.runTileEvent
	self.exitCallback = arg_31_1.exitCallback

	local var_31_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	var_31_0:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.exitCallback then
			self.exitCallback()
		end

		self:exit()
		LayerManager:removePopLayer()
	end)
	var_31_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_31_0:setPositionY(-GameDisplay.fix_y)
end

function PopMemorycardLayer:endGame()
	self.rootlayer.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_34_0)
		self.time = self.time - 1

		self.surplusTime:setString("00:" .. self.time)

		if self.time == 0 then
			self.rootlayer:stopAllActions()
			self.rootlayer:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				local var_35_0 = ccui.ImageView:create("Activity_bianhua/MemoryCard/fail.png", var_0_14)

				var_35_0:setPosition(cc.p(self.imgBottom:getContentSize().width / 2, self.imgBottom:getContentSize().height / 2))
				self.imgBottom:addChild(var_35_0, 99)

				self.isMatch = true
			end), cc.DelayTime:create(1), cc.CallFunc:create(function()
				if self.exitCallback then
					self.exitCallback()
				end

				LayerManager:removePopLayer()
			end)))
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.rootlayer.scheduler)

			self.rootlayer.scheduler = nil
		end
	end, 1, false)
end

function PopMemorycardLayer:exit()
	if self.rootlayer.scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.rootlayer.scheduler)

		self.rootlayer.scheduler = nil
	end
end
