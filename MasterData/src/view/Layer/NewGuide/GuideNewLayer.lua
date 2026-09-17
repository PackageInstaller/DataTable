GuideNewLayer = class("GuideNewLayer", function()
	return cc.Layer:create()
end)
GUIDEACTION_compel = 1
GUIDEACTION_snap = 2
GUIDEACTION_photo = 3
GUIDEACTION_tips = 4

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local guide_data = require("data.guide_data")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_6

function GuideNewLayer.create(arg_2_0, arg_2_1, arg_2_2)
	GuideNewLayer.new():init(arg_2_1, arg_2_2)
end

function GuideNewLayer.getInstance()
	return var_0_6
end

function GuideNewLayer:init(arg_4_1, arg_4_2)
	var_0_6 = self
	self.guideInfo = arg_4_2[1].info
	self.guideKye = arg_4_2[1].key
	self.guideLayer = arg_4_2[1].layerName
	self.LayerPanel = arg_4_1

	if self.guideInfo.guideType == GUIDEACTION_compel then
		self.bntLayout = ccui.Layout:create()

		self.bntLayout:setContentSize(SCREEN_WIDTH, SCREEN_HEIGHT)
		self.bntLayout:setTouchEnabled(true)
		self:addChild(self.bntLayout)
		global_basic_scene:addChild(self, 998)
		self:setName("compel" .. self.guideInfo.id)

		if self.guideInfo.time_delay then
			self.bntLayout:runAction(cc.Sequence:create(cc.DelayTime:create(self.guideInfo.time_delay), cc.CallFunc:create(function()
				self:createClip()
				self.bntLayout:setTouchEnabled(false)
			end)))
		else
			self:createClip()
			self.bntLayout:setTouchEnabled(false)
		end
	elseif self.guideInfo.guideType == GUIDEACTION_snap then
		self:createPhoto(GUIDEACTION_snap)
		global_basic_scene:addChild(self, 998)
	elseif self.guideInfo.guideType == GUIDEACTION_photo then
		self:createPhoto(GUIDEACTION_photo)
		global_basic_scene:addChild(self, 998)
	elseif self.guideInfo.guideType == GUIDEACTION_tips then
		if not ccui.Helper:seekWidgetByTag(self.LayerPanel, self.guideInfo.targetUI):getChildByName(self.guideInfo.targetUI) then
			self:createTips()
			ccui.Helper:seekWidgetByTag(self.LayerPanel, self.guideInfo.targetUI):addChild(self, 998)
			self:setName(self.guideInfo.targetUI)
		end
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_6 = nil

			if self.guideInfo.next_guide and guide_data[self.guideInfo.next_guide].targetLayer == self.guideInfo.targetLayer then
				GuideListener:checkCondition(self.guideInfo.targetLayer, self.LayerPanel)
			end

			if self.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

				self.scheduler = nil
			end
		end
	end)
end

function GuideNewLayer.createWidgetLayer(arg_7_0)
	return (ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Guide_new.json" or "Guide_new.ExportJson"))
end

function GuideNewLayer:createClip()
	if self.guideInfo.clipRect_x then
		self.colorLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), SCREEN_WIDTH, SCREEN_HEIGHT)

		local var_8_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 300), self.guideInfo.clipRect_w, self.guideInfo.clipRect_h)

		var_8_0:ignoreAnchorPointForPosition(false)
		var_8_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_0:setPosition(self.guideInfo.clipRect_x, self.guideInfo.clipRect_y)

		local var_8_1 = cc.ClippingNode:create(var_8_0)

		var_8_1:setInverted(true)
		var_8_1:setAlphaThreshold(1)
		var_8_1:addChild((cc.LayerColor:create(cc.c4b(0, 0, 0, 200), SCREEN_WIDTH, SCREEN_HEIGHT)))
		self.colorLayer:addChild(var_8_1, 0)
	else
		self.colorLayer = cc.LayerColor:create(cc.c4b(0, 0, 0, 200), SCREEN_WIDTH, SCREEN_HEIGHT)
	end

	self.widgetLayer = self:createWidgetLayer()

	self.colorLayer:addChild(self.widgetLayer)
	self:addChild(self.colorLayer)

	if self.guideInfo.isPauseFight and self.guideInfo.isPauseFight == 1 then
		FightManager.pauseBattleField()
	end

	if self.guideInfo.removeHodlGuide then
		local var_8_2 = global_basic_scene:getChildByName("compel" .. self.guideInfo.removeHodlGuide)

		if var_8_2 then
			table.remove(playermodel.LayerGuides[var_8_2.guideLayer], var_8_2.guideKye)

			playermodel.previousGuide = var_8_2.guideInfo.id
			playermodel.finishGuides[playermodel.previousGuide] = 0

			playermodel:setPlayerGuide(var_8_2.guideInfo.id)

			if var_8_2.guideKye < self.guideKye then
				self.guideKye = self.guideKye - 1
			end

			global_basic_scene:removeChildByName("compel" .. self.guideInfo.removeHodlGuide)
		end
	end

	if self.guideInfo.targetUI then
		local var_8_3 = ccui.Helper:seekWidgetByTag(self.LayerPanel, self.guideInfo.targetUI)
		local var_8_4 = var_8_3:getParent():convertToWorldSpace(cc.p(var_8_3:getPosition()))

		self.cloneUI = var_8_3:clone()

		self.cloneUI:setTouchEnabled(false)
		self.cloneUI:setVisible(true)
		self.cloneUI:setOpacity(255)
		performWithDelay(self, function()
			self.cloneUI:setPosition(var_8_4)
		end, 0.01)
		self.colorLayer:addChild(self.cloneUI)

		if self.guideInfo.isHideUI then
			self.cloneUI:setOpacity(0)
			self.cloneUI:setCascadeOpacityEnabled(false)
		end

		local var_8_5 = self.widgetLayer:getChildByName("frame_panel"):clone()

		var_8_5:setVisible(true)

		local var_8_6 = self.cloneUI:getContentSize()

		var_8_5:setPosition(var_8_6.width / 2, var_8_6.height / 2)
		var_8_5:setContentSize(cc.size(var_8_6.width + 10, var_8_6.height + 20))
		var_8_5:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.5, 1.05), cc.ScaleTo:create(0.3, 1))))
		self.cloneUI:addChild(var_8_5)

		local var_8_7 = true

		self.listener = cc.EventListenerTouchOneByOne:create()

		self.listener:registerScriptHandler(function(arg_10_0, arg_10_1)
			local var_10_0 = var_8_3:getContentSize()
			local var_10_1 = var_8_3:getAnchorPoint()

			if cc.rectContainsPoint(cc.rect(var_8_4.x - var_10_0.width * var_10_1.x, var_8_4.y - var_10_0.height * var_10_1.y, var_10_0.width, var_10_0.height), (arg_10_0:getLocation())) then
				self.listener:setSwallowTouches(false)
			else
				self.listener:setSwallowTouches(true)
			end

			return true
		end, cc.Handler.EVENT_TOUCH_BEGAN)
		self.listener:registerScriptHandler(function(arg_11_0, arg_11_1)
			local var_11_0 = var_8_3:getContentSize()
			local var_11_1 = var_8_3:getAnchorPoint()
			local var_11_2 = cc.rect(var_8_4.x - var_11_0.width * var_11_1.x, var_8_4.y - var_11_0.height * var_11_1.y, var_11_0.width, var_11_0.height)

			if cc.rectContainsPoint(var_11_2, (arg_11_0:getLocation())) and cc.rectContainsPoint(var_11_2, (arg_11_0:getStartLocation())) then
				if not var_8_7 then
					return
				end

				var_8_7 = false

				if self.guideInfo.isResumeFight and self.guideInfo.isResumeFight == 1 then
					FightManager.resumeBattleField()
				end

				if not self.guideInfo.next_guide and FightManager._pause then
					FightManager.resumeBattleField()
				end

				if self.guideInfo.isStartFight and self.guideInfo.isStartFight == 1 and not SmallFightLayer.getInstance().is_normal_fight then
					SmallFightLayer.getInstance():initNormalFight()
					FightLayer.getInstance():fightplayersflag()
				end

				table.remove(playermodel.LayerGuides[self.guideLayer], self.guideKye)

				playermodel.previousGuide = self.guideInfo.id
				playermodel.finishGuides[playermodel.previousGuide] = 0

				playermodel:setPlayerGuide(self.guideInfo.id)
				self:runAction(cc.RemoveSelf:create())
			end
		end, cc.Handler.EVENT_TOUCH_ENDED)
		self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self.colorLayer)
	else
		local var_8_8 = {}
		local var_8_9 = 1

		if self.guideInfo.isHodl then
			local var_8_10 = 1
			local var_8_11 = "w_word" .. 1

			while self.guideInfo[var_8_11] do
				table.insert(var_8_8, self.guideInfo[var_8_11])

				var_8_10 = var_8_10 + 1
				var_8_11 = "w_word" .. var_8_10
			end
		end

		local function var_8_12(arg_12_0, arg_12_1)
			return true
		end

		local var_8_13 = true

		local function var_8_14(arg_13_0, arg_13_1)
			if self.guideInfo.isHodl and var_8_8[var_8_9] then
				self.widgetLayer:getChildByName("panel_bg"):getChildByName("word"):setString(var_8_8[var_8_9])

				var_8_9 = var_8_9 + 1
			else
				if self.guideInfo.isHodl then
					return
				end

				if not var_8_13 then
					return
				end

				var_8_13 = false

				if self.guideInfo.isResumeFight and self.guideInfo.isResumeFight == 1 then
					FightManager.resumeBattleField()
				end

				if not self.guideInfo.next_guide and FightManager._pause then
					FightManager.resumeBattleField()
				end

				if self.guideInfo.isStartFight and self.guideInfo.isStartFight == 1 and not SmallFightLayer.getInstance().is_normal_fight then
					SmallFightLayer.getInstance():initNormalFight()
					FightLayer.getInstance():fightplayersflag()
				end

				table.remove(playermodel.LayerGuides[self.guideLayer], self.guideKye)

				playermodel.previousGuide = self.guideInfo.id
				playermodel.finishGuides[playermodel.previousGuide] = 0

				playermodel:setPlayerGuide(self.guideInfo.id)
				self:runAction(cc.RemoveSelf:create())
			end
		end

		self.listener = cc.EventListenerTouchOneByOne:create()

		self.listener:setSwallowTouches(true)
		self.listener:registerScriptHandler(var_8_12, cc.Handler.EVENT_TOUCH_BEGAN)
		performWithDelay(self, function()
			self.listener:registerScriptHandler(var_8_14, cc.Handler.EVENT_TOUCH_ENDED)
		end, 2)
		self:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self.colorLayer)
	end

	if self.guideInfo.isShowWidget == 1 then
		local var_8_15 = self.widgetLayer:getChildByName("panel_bg")

		var_8_15:setVisible(true)

		if self.guideInfo.w_postion then
			var_8_15:setPositionY(tonumber(self.guideInfo.w_postion))
		end

		local var_8_16 = var_8_15:getChildByName("word")

		var_8_16:setOpacity(0)

		local var_8_17 = cc.Label:createWithTTF(self.guideInfo.w_words, "fonts/new1.ttf", 22):getContentSize().width
		local var_8_18
		local var_8_19 = var_8_15:getContentSize().height

		if var_8_17 <= 210 then
			var_8_16:setString(self.guideInfo.w_words)

			var_8_18 = 390
		elseif var_8_17 >= 430 then
			var_8_18 = 580

			var_8_16:setContentSize(430, var_8_16:getContentSize().height)
			var_8_16:setString(self.guideInfo.w_words)
		else
			var_8_18 = var_8_17 + 180

			var_8_16:setContentSize(var_8_17, var_8_16:getContentSize().height)
			var_8_16:setString(self.guideInfo.w_words)
		end

		local var_8_20 = 140
		local var_8_21 = var_8_19

		var_8_15:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(function()
			var_8_15:setContentSize(var_8_20, var_8_21)

			if var_8_20 < var_8_18 then
				var_8_20 = var_8_20 + 30
			else
				var_8_15:stopAllActions()
				var_8_15:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0.95), cc.ScaleTo:create(0.1, 1, 1.05), cc.ScaleTo:create(0.1, 1, 1)))
				var_8_16:runAction(cc.FadeIn:create(0.3))
			end
		end))))

		if not self.guideInfo.head_image then
			-- block empty
		end

		local var_8_23 = cc.Sprite:create("role/wuji/" .. self.guideInfo.head_image .. ".png")
		local var_8_24 = var_8_15:getChildByName("clip_panel")

		var_8_23:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_23:setPosition(var_8_24:getContentSize().width / 2, var_8_24:getContentSize().height / 2)
		var_8_23:setScale(var_8_24:getContentSize().width / var_8_23:getContentSize().width)
		var_8_24:addChild(var_8_23)
	end
end

function GuideNewLayer:createTips()
	local var_16_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), SCREEN_WIDTH, SCREEN_HEIGHT)
	local var_16_1 = self:createWidgetLayer()

	var_16_0:addChild(var_16_1)
	self:addChild(var_16_0)

	if self.guideInfo.targetUI then
		local var_16_2 = true
		local var_16_3 = ccui.Helper:seekWidgetByTag(self.LayerPanel, self.guideInfo.targetUI)
		local var_16_4 = var_16_3:getParent():convertToWorldSpace(cc.p(var_16_3:getPosition()))

		if self.LayerPanel:getPositionY() < -10 then
			var_16_4.y = var_16_4.y + 100
		end

		local var_16_5 = var_16_3:getContentSize()
		local var_16_6 = var_16_3:getAnchorPoint()
		local var_16_7 = var_16_1:getChildByName("tips_bnt")

		var_16_7:setVisible(true)
		var_16_7:getChildByName("word_tips"):setVisible(false)

		local var_16_8 = cc.Label:createWithTTF(self.guideInfo.w_words, "fonts/new1.ttf", 20)

		var_16_8:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_16_8:setVerticalAlignment(cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
		var_16_8:setAnchorPoint(cc.p(0.5, 0.5))

		if var_16_8:getContentSize().width > 400 then
			var_16_7:setContentSize(cc.size(420, 56))
			var_16_8:setDimensions(400, 56)
		elseif var_16_8:getContentSize().width > 124 then
			var_16_7:setContentSize(cc.size(var_16_8:getContentSize().width + 20, 56))
		end

		var_16_8:setPosition(var_16_7:getBoundingBox().width / 2, 28)
		var_16_7:addChild(var_16_8)

		local var_16_9 = var_16_5.width / 2 + 94
		local var_16_10 = -50

		if self.guideInfo.w_postion then
			if self.guideInfo.w_postion == "topright" then
				var_16_7:setScaleY(-1)
				var_16_8:setScaleY(-1)

				var_16_10 = var_16_5.height + 50
			elseif self.guideInfo.w_postion == "topleft" then
				var_16_7:setScale(-1, -1)
				var_16_8:setScale(-1, -1)

				var_16_9 = var_16_5.width / 2 - 94
				var_16_10 = var_16_5.height + 50
			elseif self.guideInfo.w_postion == "bottomleft" then
				var_16_7:setScaleX(-1)
				var_16_8:setScaleX(-1)

				var_16_9 = var_16_5.width / 2 - 94
			elseif self.guideInfo.w_postion == "bottomleft" then
				-- block empty
			end
		end

		var_16_7:setPosition(var_16_9, var_16_10)
		var_16_7:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not var_16_2 then
				return
			end

			var_16_2 = false

			table.remove(playermodel.LayerGuides[self.guideLayer], self.guideKye)

			playermodel.previousGuide = self.guideInfo.id
			playermodel.finishGuides[playermodel.previousGuide] = 0

			playermodel:setPlayerGuide(self.guideInfo.id)
			self:runAction(cc.RemoveSelf:create())
		end)

		local var_16_11 = cc.EventListenerTouchOneByOne:create()

		var_16_11:setSwallowTouches(false)
		var_16_11:registerScriptHandler(function(arg_18_0, arg_18_1)
			local var_18_0 = var_16_3:getAnchorPoint()

			if cc.rectContainsPoint(cc.rect(var_16_4.x - var_16_5.width * var_18_0.x, var_16_4.y - var_16_5.height * var_18_0.y, var_16_5.width, var_16_5.height), (arg_18_0:getLocation())) then
				return true
			else
				return false
			end
		end, cc.Handler.EVENT_TOUCH_BEGAN)
		var_16_11:registerScriptHandler(function(arg_19_0, arg_19_1)
			local var_19_0 = var_16_3:getAnchorPoint()
			local var_19_1 = cc.rect(var_16_4.x - var_16_5.width * var_19_0.x, var_16_4.y - var_16_5.height * var_19_0.y, var_16_5.width, var_16_5.height)

			if cc.rectContainsPoint(var_19_1, (arg_19_0:getLocation())) and cc.rectContainsPoint(var_19_1, (arg_19_0:getStartLocation())) then
				if not var_16_2 then
					return
				end

				var_16_2 = false

				table.remove(playermodel.LayerGuides[self.guideLayer], self.guideKye)

				playermodel.previousGuide = self.guideInfo.id
				playermodel.finishGuides[playermodel.previousGuide] = 0

				playermodel:setPlayerGuide(self.guideInfo.id)
				self:runAction(cc.RemoveSelf:create())
			end
		end, cc.Handler.EVENT_TOUCH_ENDED)
		self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_16_11, var_16_0)
	end
end

function GuideNewLayer:createPhoto(arg_20_1)
	local var_20_0

	if arg_20_1 == GUIDEACTION_snap then
		var_20_0 = "mainScenebg/guide/" .. self.guideInfo.w_id .. ".png"
	elseif arg_20_1 == GUIDEACTION_photo then
		var_20_0 = "mainScenebg/guide/" .. self.guideInfo.w_id .. ".jpg"
	end

	local var_20_1 = ccui.Button:create(var_20_0, var_20_0, "", 0)

	var_20_1:setAnchorPoint(cc.p(0, 0))
	self:addChild(var_20_1)

	if arg_20_1 == GUIDEACTION_snap then
		var_20_1:setOpacity(0)
		var_20_1:runAction(cc.FadeIn:create(0.5))
	elseif arg_20_1 == GUIDEACTION_photo then
		var_20_1:setScale(0.01)
		var_20_1:runAction(cc.ScaleTo:create(0.5, 1, 1))
	end

	self.widgetLayer = self:createWidgetLayer()

	var_20_1:addChild(self.widgetLayer)

	local var_20_2 = self.widgetLayer:getChildByName("count_down")

	var_20_2:setVisible(true)

	local var_20_3 = 3

	self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		var_20_2:getChildByName("num"):setString(var_20_3)

		var_20_3 = var_20_3 - 1

		if var_20_3 < 0 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
			var_20_2:getChildByName("num"):setVisible(false)
			var_20_2:setString(L_GUIDENEW_CLOSE_BTN)
			var_20_1:addTouchEventListener(function(arg_22_0, arg_22_1)
				if arg_22_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_22_0:setTouchEnabled(false)
				table.remove(playermodel.LayerGuides[self.guideLayer], self.guideKye)

				playermodel.previousGuide = self.guideInfo.id
				playermodel.finishGuides[playermodel.previousGuide] = 0

				playermodel:setPlayerGuide(self.guideInfo.id)
				self:runAction(cc.RemoveSelf:create())
			end)
		end
	end, 1, false)
end
