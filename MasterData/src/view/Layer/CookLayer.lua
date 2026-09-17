CookLayer = class("CookLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.PopLayer")
require("view.Sprite.ItemsPanel")

local pot_data = require("data.food_production.pot.pot_data")
local oil_data = require("data.food_production.oil.oil_data")
local playermodel = require("model.playermodel")
local shop_manager = require("controller.shop_manager")
local alert_manager = require("controller.alert_manager")
local cook_manager = require("controller.cook_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = 0
local var_0_10 = 1
local var_0_11 = 2
local var_0_19

function CookLayer.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = CookLayer.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function CookLayer.getInstance()
	return var_0_19
end

function CookLayer:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	var_0_19 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Cook.json" or "Cook.ExportJson")

	self:addChild(self.rootLayer)
	self.rootLayer:setBackGroundImage("mainScenebg/kitchen.png")

	self.menuid = arg_4_2
	self.hostSoul = arg_4_3
	self.callback = arg_4_4
	self.menuInfo = require("data.food_production.menu.menu" .. arg_4_3 .. "_data")[self.menuid]
	self.showtype = cook_manager:init(arg_4_1)
	self.pot_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_pot")
	self.foodBntsPanel = ccui.Layout:create()

	self:addChild(self.foodBntsPanel)

	self.foodButton = self.rootLayer:getChildByName("Panel_cook"):getChildByName("Button_food")

	self.foodButton:removeFromParent()
	self.foodButton:retain()

	self.addBnts = {}

	for iter_4_0 = 1, 3 do
		self.addBnts[iter_4_0] = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_add" .. iter_4_0)
	end

	local var_4_0 = self.rootLayer:getChildByName("Panel_cook"):getChildByName("Panel_info"):getChildByName("Image_timer")

	self.timelabel = cc.Label:createWithTTF("00:00", "fonts/newkj.ttf", 28)

	self.timelabel:setPosition(cc.p(var_4_0:getContentSize().width / 2, var_4_0:getContentSize().height / 2))
	var_4_0:addChild(self.timelabel)

	self.sureButton = self.rootLayer:getChildByName("button_sure")

	local var_4_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_des")

	self.foodDes = cc.Label:createWithTTF("", "fonts/new1.ttf", 18)

	self.foodDes:setAnchorPoint(cc.p(0, 1))
	self.foodDes:setMaxLineWidth(var_4_1:getContentSize().width)
	var_4_1:addChild(self.foodDes)

	self.resultPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_touch")

	self.resultPanel:setVisible(false)

	self.waves = {}

	local var_4_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_wave")

	for iter_4_1 = 1, 7 do
		self.waves[iter_4_1] = var_4_2:getChildByName("ProgressBar" .. iter_4_1)
	end

	self.kitchenPanel = self.rootLayer:getChildByName("Panel_choose")
	self.menuPanel = self.rootLayer:getChildByName("Panel_cook")
	self.nowfire = "big_fire"

	self:initUI()

	self.backBnt = self.rootLayer:getChildByName("Button_back")

	self.backBnt:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)

	if ListButtonLayer.getInstance() then
		ListButtonLayer.getInstance():hideLayer()
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			self.foodButton:release()

			if self.showtype == "kitchen" then
				self.baseFoodSp:release()
				self.groupBnt:release()
				self.unitBnt:release()
			end

			if cook_manager.cookStage == var_0_11 and #cook_manager.cookData == 0 then
				cook_manager:m_release()
			end

			if cook_manager.cookSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(cook_manager.cookSchedule)

				cook_manager.cookSchedule = nil
			end

			var_0_19 = nil
		end
	end)
end

function CookLayer:initUI()
	self:initSureBnt()
	self:registerAddBntsEvent()

	function self.waves.update(arg_8_0, arg_8_1)
		local var_8_0 = 10
		local var_8_1 = math.rad(360)
		local var_8_2 = 50

		if self.nowfire == "small_fire" then
			var_8_2 = 50
			var_8_1 = math.rad(360)
			var_8_0 = 5
		elseif self.nowfire == "medium_fire" then
			var_8_2 = 50
			var_8_1 = math.rad(540)
			var_8_0 = 10
		elseif self.nowfire == "big_fire" then
			var_8_2 = 50
			var_8_1 = math.rad(720)
			var_8_0 = 15
		end

		for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
			iter_8_1:setPercent(var_8_0 * math.sin(var_8_1 * arg_8_1 + (iter_8_0 - 1)) + var_8_2)
		end
	end

	if self.showtype == "kitchen" then
		self:initKitchenUI()
	elseif self.showtype == "menu" then
		self.rootLayer:getChildByName("Button_return"):setVisible(false)
	end

	self:updateShowType(cook_manager.cookStage)
end

function CookLayer:registerAddBntsEvent()
	function self.addBnts:updateBnts()
		for iter_10_0 = 1, 3 do
			if self[iter_10_0]:getChildByName("icon") then
				self[iter_10_0]:getChildByName("icon"):removeFromParent()
			end

			self[iter_10_0]:getChildByName("Image_add"):setVisible(true)
		end

		for iter_10_1, iter_10_2 in pairs(cook_manager.selectedFoods) do
			if iter_10_2 > 0 then
				local var_10_0 = ccui.ImageView:create("equipment/food_e/" .. item_data[iter_10_1].image_id .. ".png")

				var_10_0:setPosition(self[1]:getContentSize().width / 2, self[1]:getContentSize().height / 2)
				var_10_0:setName("icon")
				self[1]:addChild(var_10_0)

				local var_10_1 = cc.Label:createWithTTF("x" .. iter_10_2, "fonts/W5.ttf", 20)

				var_10_1:setAnchorPoint(cc.p(1, 0))
				var_10_1:setPosition(var_10_0:getContentSize().width - 7, 5)
				var_10_0:addChild(var_10_1)
				self[1]:getChildByName("Image_add"):setVisible(false)
			end
		end
	end

	self.addBnts:updateBnts()

	for iter_9_0, iter_9_1 in pairs(self.addBnts) do
		if type(iter_9_0) == "number" then
			iter_9_1:getChildByName("Image_add"):runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(0.4), cc.DelayTime:create(0.2), cc.FadeIn:create(0.4))))
			iter_9_1:addTouchEventListener(function(arg_11_0, arg_11_1)
				local var_11_0

				if arg_11_1 ~= ccui.TouchEventType.ended then
					do return end

					var_11_0 = {}
				end

				function var_11_0.sure(arg_12_0)
					cook_manager.selectedFoods = arg_12_0

					self.addBnts:updateBnts()
				end

				function var_11_0.cancelcallback()
					return
				end

				self:addChild(ItemsPanel:create(kITEM_FOOD, {
					cookFoods = cook_manager.needFood
				}, cook_manager.selectedFoods, var_11_0, ITEMPANEL_TYPE_COOK_ADD_FOOD), 99)
			end)
		end
	end
end

function CookLayer:beginCookAddBntUpdate()
	for iter_14_0, iter_14_1 in pairs(self.addBnts) do
		if type(iter_14_0) == "number" then
			iter_14_1:setOpacity(125)
			iter_14_1:setTouchEnabled(false)
			iter_14_1:getChildByName("Image_add"):setVisible(true)
			iter_14_1:getChildByName("Image_add"):setOpacity(255)
			iter_14_1:getChildByName("Image_add"):stopAllActions()
			iter_14_1:getChildByName("Image_add"):loadTexture("cook/jia_bg2.png", var_0_8)

			if iter_14_1:getChildByName("icon") then
				iter_14_1:getChildByName("icon"):runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(1, cc.p((2 - iter_14_0) * 160, 300)), cc.FadeOut:create(1)), cc.RemoveSelf:create()))
			end
		end
	end
end

function CookLayer:initSureBnt()
	self.sureButton:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if cook_manager.cookStage == var_0_9 then
			-- block empty
		elseif cook_manager.cookStage == var_0_10 then
			self:beginCookAddBntUpdate()
			self:updateShowType(var_0_11)
			self:pushFireData(self.nowfire)
			self.rootLayer:getChildByName("Button_return"):setVisible(false)
		elseif cook_manager.cookStage == var_0_11 then
			self:setTouchEnabled(false)

			if self.foodBntsPanel.totalNum == 0 then
				self:cookFinish()
			else
				self:cookCancel()
			end
		end
	end)

	function self.sureButton:update()
		if cook_manager.cookStage == var_0_9 then
			self:loadTextures("cook/start_off.png", "cook/start_off.png", "cook/start_off.png", var_0_8)
			self:setOpacity(50)
		elseif cook_manager.cookStage == var_0_10 then
			self:loadTextures("cook/start.png", "cook/start_on.png", "cook/start_on.png", var_0_8)
			self:setOpacity(255)
		elseif cook_manager.cookStage == var_0_11 then
			self:setOpacity(255)

			if self.foodBntsPanel.totalNum == 0 then
				self:loadTextures("cook/finish.png", "cook/finish_on.png", "cook/finish.png", var_0_8)
			else
				self:loadTextures("cook/cancle_button.png", "cook/cancle_button_on.png", "cook/cancle_button_on.png", var_0_8)
			end
		end
	end
end

function CookLayer:initPanelinfo()
	if cook_manager.cookbookid and item_data[cook_manager.cookbookid] then
		self.foodDes:setString(item_data[cook_manager.cookbookid].production)
	end

	local var_18_0 = self.foodDes:getContentSize()

	self.menuPanel:getChildByName("Panel_info"):getChildByName("ScrollView_des"):setInnerContainerSize(var_18_0)
	self.foodDes:setAnchorPoint(cc.p(0, 1))
	self.foodDes:setPosition(cc.p(0, var_18_0.height))
end

function CookLayer:initPotsPanel()
	self.pot_panel:getChildByName("Image_pot"):loadTexture("equipment/food_e/" .. item_data[item_data[cook_manager.cookbookid].pot_id].image_id .. ".png")
	self.pot_panel:getChildByName("Label_name"):setString(item_data[item_data[cook_manager.cookbookid].pot_id].intro)
end

function CookLayer:initFoods()
	self.foodBntsPanel.totalNum = #cook_manager.needFood

	for iter_20_0, iter_20_1 in ipairs(cook_manager.needFood) do
		local var_20_0 = self.foodButton:clone()

		var_20_0:getChildByName("Image_food"):loadTexture("equipment/food_e/" .. item_data[iter_20_1.id].image_id .. ".png")
		var_20_0:getChildByName("food_num"):setString("×" .. iter_20_1.num)
		var_20_0:setTag(iter_20_1.id)
		var_20_0:setName("food" .. tostring(iter_20_1.id))
		var_20_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_20_0:setPositionX((iter_20_0 - (#cook_manager.needFood + 1) / 2) * 114 + 320)
		self.foodBntsPanel:addChild(var_20_0, 88)

		if iter_20_1.isIntoPot then
			var_20_0:setTouchEnabled(false)
			var_20_0:setOpacity(100)

			self.foodBntsPanel.totalNum = self.foodBntsPanel.totalNum - 1

			if self.foodBntsPanel.totalNum == 0 then
				self.sureButton:update()
			end
		else
			var_20_0:addTouchEventListener(function(arg_21_0, arg_21_1)
				if arg_21_1 ~= ccui.TouchEventType.ended then
					return
				end

				if cook_manager.cookStage ~= var_0_11 then
					global_ShowBlockWords(L_FIRE_ON)

					return
				end

				iter_20_1.isIntoPot = true

				arg_21_0:setTouchEnabled(false)
				self:pushFood(iter_20_1.id, iter_20_1.num)

				local var_21_0 = var_20_0:clone()

				self.foodBntsPanel:addChild(var_21_0)
				var_21_0:stopAllActions()
				var_21_0:runAction(cc.Spawn:create(cc.MoveTo:create(0.5, cc.p(320, 580)), cc.FadeOut:create(0.5)))
				arg_21_0:setOpacity(100)

				self.foodBntsPanel.totalNum = self.foodBntsPanel.totalNum - 1

				if self.foodBntsPanel.totalNum == 0 then
					self.sureButton:update()
				end
			end)
		end
	end
end

function CookLayer:updateShowType(arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or "group"
	cook_manager.cookStage = arg_22_1

	;({
		[var_0_9] = function()
			self.kitchenPanel:setVisible(true)
			self.menuPanel:setVisible(false)
			self:updateKitchenScroll(arg_22_2)
			self.menuPanel:getChildByName("Panel_arrow"):setVisible(true)
			self.menuPanel:getChildByName("Panel_info"):setVisible(false)
			self.foodBntsPanel:removeAllChildren()
		end,
		[var_0_10] = function()
			if cook_manager.cookbookid and type(cook_manager.cookbookid) == "number" then
				cook_manager:initMenuTypeData(cook_manager.cookbookid)
				self:initFoods()
				self:initPotsPanel()
				self:initPanelinfo()
				self.kitchenPanel:setVisible(false)
				self.menuPanel:setVisible(true)
				GuideListener:checkCondition("CookLayer", self.rootLayer)
			end
		end,
		[var_0_11] = function()
			if cook_manager.resume then
				self:initFoods()
				self:initPotsPanel()
				self:initPanelinfo()
			end

			cook_manager:beginCook()
			self.kitchenPanel:setVisible(false)
			self.menuPanel:setVisible(true)
			self.menuPanel:getChildByName("Panel_arrow"):setVisible(false)
			self.menuPanel:getChildByName("Panel_info"):setVisible(true)
		end
	})[arg_22_1]()
	self.sureButton:update()
end

function CookLayer.pushFireData(arg_26_0, arg_26_1)
	table.insert(cook_manager.potFireData, {
		fireType = arg_26_1,
		time = os.time()
	})
end

function CookLayer.pushFood(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0

	if item_data[arg_27_1].bag_item_type == kITEM_FOOD then
		item_manager:deleteItem(arg_27_1, arg_27_2)

		var_27_0 = {
			itemid = arg_27_1
		}
	end

	var_27_0.weight = item_data[arg_27_1].weight * arg_27_2
	var_27_0.time = os.time()

	table.insert(cook_manager.cookData, var_27_0)
end

function CookLayer:cookFinish()
	self.resultPanel:setVisible(true)
	self:pushFireData("ended")
	cook_manager:finishCook(function(arg_29_0)
		if self.showtype == "menu" then
			if arg_29_0.result == 1 then
				local var_29_0 = cook_manager.cookbookid
				local var_29_1 = ccui.ImageView:create("equipment/" .. item_data[cook_manager.cookbookid].image_id .. ".png")

				var_29_1:setScale(0.2)
				var_29_1:setPosition(self.resultPanel:getChildByName("Panel_clip"):getContentSize().width / 2, 300)
				self.resultPanel:getChildByName("Panel_clip"):addChild(var_29_1)
				var_29_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.EaseIn:create(cc.MoveTo:create(1, cc:p(100)), 16), cc.ScaleTo:create(1, 0.8)), cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(self.resultPanel:getChildByName("Panel_clip").getContentSize(self.resultPanel:getChildByName("Panel_clip"):getContentSize().width / 2).width / 2, 115)), cc.ScaleTo:create(0.1, 0.85)), cc.Spawn:create(cc.MoveTo:create(0.1, cc.p(self.resultPanel:getChildByName("Panel_clip"):getContentSize().width / 2, 100)), cc.ScaleTo:create(0.1, 0.8)), cc.DelayTime:create(1), cc.CallFunc:create(function()
					local var_30_0 = {}
					local var_30_1 = {}

					var_30_1.text = arg_29_0.addfavor < 0 and L_GIFT_PANEL.favor .. arg_29_0.addfavor or L_GIFT_PANEL.favor .. " + " .. arg_29_0.addfavor

					local var_30_2

					if config._DEBUG then
						var_30_2 = cc.Sprite:create("public/heart.png") or cc.Sprite:createWithSpriteFrameName("public/heart.png")
					end

					var_30_2:setScale(1.2)
					var_30_2:retain()

					var_30_1.sp = var_30_2

					table.insert(var_30_0, var_30_1)
					global_riseWords2(var_30_0, cc.c3b(255, 152, 0), nil, 1.5, 0.5)
					self.resultPanel:setTouchEnabled(false)

					if self.callback then
						self.callback(arg_29_0.insertScript, arg_29_0.nextScript, item_data[var_29_0].image_id)
					end

					LayerManager:removePopLayer()
				end)))
			elseif arg_29_0.result == 2 then
				self.resultPanel:getChildByName("Panel_fail"):setVisible(true)
				self.resultPanel:getChildByName("Panel_fail"):setOpacity(0)

				local var_29_4 = ""

				if arg_29_0.rawFoods then
					for iter_29_0, iter_29_1 in pairs(arg_29_0.rawFoods) do
						var_29_4 = var_29_4 .. item_data[iter_29_1].name .. ", "
					end

					var_29_4 = var_29_4 .. L_COOK_RAW .. "\n"
				end

				if arg_29_0.cokeFoods then
					for iter_29_2, iter_29_3 in pairs(arg_29_0.cokeFoods) do
						var_29_4 = var_29_4 .. item_data[iter_29_3].name .. ", "
					end

					var_29_4 = var_29_4 .. L_COOK_COKE .. "\n"
				end

				self.resultPanel:getChildByName("Panel_fail"):getChildByName("Label_info"):setString(var_29_4)
				self.resultPanel:getChildByName("Panel_fail"):runAction(cc.Sequence:create(cc.FadeIn:create(1), cc.CallFunc:create(function()
					self.resultPanel:addTouchEventListener(function(arg_32_0, arg_32_1)
						if arg_32_1 ~= ccui.TouchEventType.ended then
							return
						end

						if self.callback then
							self.callback(arg_29_0.insertScript, arg_29_0.nextScript)
						end

						LayerManager:removePopLayer()
					end)
				end)))
			end

			cook_manager:m_release()
		elseif self.showtype == "kitchen" then
			cook_manager.menuData = nil
			cook_manager.needFood = {}
			cook_manager.cookbookid = nil
			cook_manager.potFireData = {}
			cook_manager.cookData = {}
			cook_manager.cookStage = nil
			cook_manager.cooktime = 0
			cook_manager.resume = false

			if cook_manager.cookSchedule then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(cook_manager.cookSchedule)

				cook_manager.cookSchedule = nil
			end

			self:updateShowType(var_0_9, "unit")
		end
	end, self.menuid, self.hostSoul)
end

function CookLayer:cookCancel()
	if next(cook_manager.cookData) ~= nil then
		cook_manager:cancelCook(function()
			if DormitoryLayer.getInstance() then
				local var_34_0 = {
					labels = {
						title = L_GIVEUP_RETURN_FOOD
					},
					items = {}
				}

				for iter_34_0, iter_34_1 in pairs(cook_manager.needFood) do
					if not iter_34_1.isIntoPot then
						var_34_0.items[#var_34_0.items + 1] = {
							dropid = iter_34_1.id,
							entityid = iter_34_1.id,
							dropNum = iter_34_1.num
						}
					end
				end

				LayerManager:pushInLayer("PopPurchaseResultLayer", var_34_0)
			end

			if self.showtype == "menu" then
				cook_manager:m_release()
				LayerManager:removePopLayer()
				require("view.Layer.PopDRLayer")

				if PopDRLayer.getInstance() then
					PopDRLayer.getInstance():runAction(cc.RemoveSelf:create())
				end
			elseif self.showtype == "kitchen" then
				cook_manager.menuData = nil
				cook_manager.needFood = {}
				cook_manager.cookbookid = nil
				cook_manager.potFireData = {}
				cook_manager.cookData = {}
				cook_manager.cookStage = nil
				cook_manager.cooktime = 0
				cook_manager.resume = false

				if cook_manager.cookSchedule then
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(cook_manager.cookSchedule)

					cook_manager.cookSchedule = nil
				end

				self:updateShowType(var_0_9, "unit")
			end
		end)
	elseif self.showtype == "menu" then
		LayerManager:removePopLayer()
		cook_manager:m_release()
	elseif self.showtype == "kitchen" then
		cook_manager.menuData = nil
		cook_manager.needFood = {}
		cook_manager.cookbookid = nil
		cook_manager.potFireData = {}
		cook_manager.cookData = {}
		cook_manager.cookStage = nil
		cook_manager.cooktime = 0
		cook_manager.resume = false

		if cook_manager.cookSchedule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(cook_manager.cookSchedule)

			cook_manager.cookSchedule = nil
		end

		self:updateShowType(var_0_9, "unit")
	end
end

function CookLayer.showCookResult(arg_35_0)
	return
end
