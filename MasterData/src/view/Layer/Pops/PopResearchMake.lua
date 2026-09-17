PopResearchMake = class("PopResearchMake", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local lab_manager = require("controller.lab_manager")
local item_data = require("data.item_data")
local lab_research_data = require("data.lab_research_data")

function PopResearchMake.create(arg_2_0, arg_2_1)
	local var_2_0 = PopResearchMake.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopResearchMake:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("lab_mark_room/darkroom_manufacture_bg.png", var_0_0)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootpanel:setTouchEnabled(true)
	self.rootLayer:addChild(self.rootpanel)
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
				self.exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.showActions.extendVertical(self)

	self.goto_back_system_id = arg_3_1.goto_back_system_id
	self.researchid = arg_3_1.research
	self.exitcallback = arg_3_1.exitcallback
	self.selectNum = 1

	self:initUI()
end

function PopResearchMake:initUI()
	self:showWindowEffect()

	local var_6_0 = ccui.ImageView:create("equipment/" .. item_data[drop_manager:getEquipDrops(lab_research_data[self.researchid].dropid)[1].dropid].image_id .. ".png")

	var_6_0:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_6_0:setPositionY(self.rootpanel:getContentSize().height / 2)
	self.rootpanel:addChild(var_6_0)

	local var_6_1 = ccui.Button:create("public/button/public_button_orange_long.png", "", "public/button/public_button_orange_long.png", var_0_0)

	self.rootpanel:addChild(var_6_1)
	var_6_1:setPositionX(self.rootpanel:getContentSize().width / 2)
	var_6_1:setPositionY(-80)
	var_6_1:addTouchEventListener(self:getSureBtnHandel())

	local var_6_2 = cc.Label:createWithTTF(L_RESEARCH_MAKE.Btn_Str, FONT_BUTTON, 34)

	var_6_2:setColor(cc.c3b(12, 12, 12))
	var_6_2:setPositionX(var_6_1:getContentSize().width / 2)
	var_6_2:setPositionY(var_6_1:getContentSize().height / 2 - 3)
	var_6_1:addChild(var_6_2)

	local var_6_3 = ccui.ImageView:create(IMAGE_GOLD, var_0_0)

	var_6_3:setName("gold_img")
	var_6_3:setPosition(cc.p(var_6_1:getContentSize().width / 2 - 30, -10))
	var_6_1:addChild(var_6_3)

	self.gold_num = cc.Label:createWithTTF(global_trans_number(lab_research_data[self.researchid].recipe_gold * self.selectNum), FONT_DES, 20)

	self.gold_num:setAnchorPoint(cc.p(0, 0.5))
	self.gold_num:setName("gold_num")
	self.gold_num:setPosition(cc.p(var_6_1:getContentSize().width / 2, -10))
	var_6_1:addChild(self.gold_num)

	local var_6_4 = ccui.Button:create("lab_mark_room/btn_add_workshop.png", "", "lab_mark_room/btn_add_workshop.png", var_0_0)

	var_6_4:setPosition(cc.p(self.rootpanel:getContentSize().width / 2 + 80, 38))

	var_6_4.value = 1

	var_6_4:addTouchEventListener(self:getNumBtnHandel())
	self.rootpanel:addChild(var_6_4, 11)

	local var_6_5 = ccui.Button:create("lab_mark_room/btn_reduce_workshop.png", "", "lab_mark_room/btn_reduce_workshop.png", var_0_0)

	var_6_5:setPosition(cc.p(self.rootpanel:getContentSize().width / 2 - 80, 38))

	var_6_5.value = -1

	var_6_5:addTouchEventListener(self:getNumBtnHandel())
	self.rootpanel:addChild(var_6_5, 11)

	local var_6_6 = ccui.Button:create("lab_mark_room/btn_max_workshop.png", "", "lab_mark_room/btn_max_workshop.png", var_0_0)

	var_6_6:setPosition(cc.p(self.rootpanel:getContentSize().width / 2 + 160, 38))
	var_6_6:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_7_0 = 1

		self.selectNum = 10000

		while lab_research_data[self.researchid]["material" .. var_7_0] do
			local var_7_3 = item_manager:getItemNumber(lab_research_data[self.researchid]["material" .. var_7_0])

			self.selectNum = math.min(self.selectNum, math.floor(var_7_3 / lab_research_data[self.researchid]["material" .. var_7_0 .. "_num"]))

			if math.floor(var_7_3 / lab_research_data[self.researchid]["material" .. var_7_0 .. "_num"]) == 0 then
				global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)
			end

			var_7_0 = var_7_0 + 1
		end

		if math.floor(playermodel.gold / lab_research_data[self.researchid].recipe_gold) == 0 then
			global_ShowBlockWords(L_GOLD_LACK)
		end

		self.selectNum = math.min(self.selectNum, math.floor(playermodel.gold / lab_research_data[self.researchid].recipe_gold))

		if self.selectNum < 1 then
			self.selectNum = 1
		end

		self.curSelectNumLabel:setString(tostring(self.selectNum))
		self.gold_num:setString(global_trans_number(lab_research_data[self.researchid].recipe_gold * self.selectNum))
	end)
	self.rootpanel:addChild(var_6_6, 11)

	local var_6_7 = ccui.Button:create("lab_mark_room/btn_min_workshop.png", "", "lab_mark_room/btn_min_workshop.png", var_0_0)

	var_6_7:setPosition(cc.p(self.rootpanel:getContentSize().width / 2 - 160, 38))
	var_6_7:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectNum = 1

		self.curSelectNumLabel:setString(tostring(self.selectNum))
		self.gold_num:setString(global_trans_number(lab_research_data[self.researchid].recipe_gold * self.selectNum))
	end)
	self.rootpanel:addChild(var_6_7, 11)

	self.curSelectNumLabel = ccui.TextBMFont:create(self.selectNum, "fonts/number_workshop.fnt")

	self.curSelectNumLabel:setPositionX(self.rootpanel:getContentSize().width / 2 + 10)
	self.curSelectNumLabel:setPositionY(38)
	self.curSelectNumLabel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:addChild(self.curSelectNumLabel, 11)
end

function PopResearchMake:getNumBtnHandel()
	local var_9_0 = 0
	local var_9_1 = cc.Node:create()

	self:addChild(var_9_1)

	local function var_9_2(arg_10_0, arg_10_1)
		self.selectNum = self.selectNum + arg_10_0.value

		while lab_research_data[self.researchid]["material" .. 1] do
			if item_manager:getItemNumber(lab_research_data[self.researchid]["material" .. 1]) < lab_research_data[self.researchid]["material" .. 1 .. "_num"] * self.selectNum then
				global_ShowBlockWords(L_COMMON_WARNING.Material_Lack)

				self.selectNum = self.selectNum - arg_10_0.value

				return
			end
		end

		if playermodel.gold < lab_research_data[self.researchid].recipe_gold * self.selectNum then
			global_ShowBlockWords(L_GOLD_LACK)

			self.selectNum = self.selectNum - arg_10_0.value

			return
		end

		if self.selectNum < 1 then
			self.selectNum = 1
		end

		self.curSelectNumLabel:setString(tostring(self.selectNum))
		self.gold_num:setString(global_trans_number(lab_research_data[self.researchid].recipe_gold * self.selectNum))
	end

	return function(arg_11_0, arg_11_1)
		if arg_11_1 == ccui.TouchEventType.began then
			arg_11_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				var_9_0 = 0.2

				var_9_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
					var_9_2(arg_11_0, arg_11_1)
				end), cc.DelayTime:create(0.022222222222222223))))
			end)))
		elseif arg_11_1 == ccui.TouchEventType.canceled then
			var_9_1:stopAllActions()
			arg_11_0:stopAllActions()

			var_9_0 = 0
		elseif arg_11_1 == ccui.TouchEventType.ended then
			var_9_1:stopAllActions()
			arg_11_0:stopAllActions()

			if var_9_0 == 0 then
				var_9_2(arg_11_0, arg_11_1)
			end

			var_9_0 = 0
		end
	end
end

function PopResearchMake.getSureBtnHandel(arg_14_0)
	return function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_15_0:setBright(false)

		arg_14_0.touchLock = true

		lab_manager:make_lab_research(arg_14_0.researchid, arg_14_0.selectNum, function(arg_16_0)
			if arg_16_0.result == 1 then
				arg_14_0:showMakeEffect()

				function arg_14_0.showGainPop()
					LayerManager:pushInLayer("PopPurchaseResultLayer", {
						items = arg_16_0.items
					})
				end

				arg_14_0.selectNum = 1

				arg_14_0.curSelectNumLabel:setString(tostring(arg_14_0.selectNum))
				arg_14_0.gold_num:setString(global_trans_number(lab_research_data[arg_14_0.researchid].recipe_gold * arg_14_0.selectNum))
			elseif arg_16_0.result == 6 then
				LayerManager:removePopLayer()
				LayerManager:pushInLayer("PopGoGainLayer", {
					item = "gold",
					goto_back_system_id = arg_14_0.goto_back_system_id
				})
			end

			arg_15_0:setBright(true)

			arg_14_0.touchLock = false
		end)
	end
end

function PopResearchMake:showMakeEffect()
	local var_18_0 = ccui.Layout:create()

	var_18_0:setTouchEnabled(true)
	var_18_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, GameDisplay.getScreenSize().height / 2))
	var_18_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_18_0:setBackGroundColorOpacity(180)
	self.rootLayer:addChild(var_18_0)
	var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchLock then
			return
		end

		var_18_0:runAction(cc.RemoveSelf:create())

		if self.showGainPop then
			self.showGainPop()
		end

		self.showGainPop = nil
	end)

	local var_18_1 = L2Skeleton:create("spine/ui/e_huode.json", "spine/ui/e_huode.atlas")

	var_18_1:refreshSkeleton()
	var_18_1:play("gain", false)
	var_18_1:setPosition(cc.p(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2))
	var_18_0:addChild(var_18_1)
	var_18_0:runAction(cc.Sequence:create(cc.DelayTime:create(2.2), cc.CallFunc:create(function()
		var_18_0:removeFromParent()

		if self.showGainPop then
			self.showGainPop()
		end

		self.showGainPop = nil
	end)))
end

function PopResearchMake:showWindowEffect()
	local var_21_0 = ccui.ImageView:create("lab_mark_room/effect_light.png", var_0_0)

	var_21_0:setAnchorPoint(cc.p(0.5, 1))
	var_21_0:setPosition(cc.p(self.rootpanel:getContentSize().width / 2 + 1, self.rootpanel:getContentSize().height))
	var_21_0:setScale(1, 0.01)
	self.rootpanel:addChild(var_21_0, 10)
	var_21_0:runAction(cc.RepeatForever:create((cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(4, cc.p(self.rootpanel:getContentSize().width / 2 + 1, self.rootpanel:getContentSize().height)), cc.ScaleTo:create(4, 1, (self.rootpanel:getContentSize().height - 60) / var_21_0:getContentSize().height)), cc.CallFunc:create(function()
		var_21_0:setScale(1, 0.01)
		var_21_0:setPosition(cc.p(self.rootpanel:getContentSize().width / 2 + 1, self.rootpanel:getContentSize().height))
	end)))))
end

function PopResearchMake:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
