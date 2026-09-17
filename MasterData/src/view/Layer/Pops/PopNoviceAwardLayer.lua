PopNoviceAwardLayer = class("PopNoviceAwardLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSprite")
require("view.Sprite.AvatarSprite")

local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local component_manager = require("controller.component_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local novice_award_data = require("data.novice_award_data")
local var_0_9 = 1
local var_0_10 = 2

function PopNoviceAwardLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopNoviceAwardLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopNoviceAwardLayer:init(arg_3_1)
	hx_print("PopNoviceAwardLayer:init")
	print("playerModel.novice_award_process_xinxiya", playermodel.novice_award_process_xinxiya)
	print("playerModel.novice_award_process_lucun", playermodel.novice_award_process_lucun)

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.bg = ccui.ImageView:create("PopNoviceAwardLayer/recharge_bg.png", var_0_0)

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(self.bg:getContentSize())
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)

	self.extheight = 0

	self.bg:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.bg:setPositionY(self.rootpanel:getContentSize().height / 2 + 15 + self.extheight)
	self.rootpanel:addChild(self.bg, 10)
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
	end, 0)
	self:initData()
	self:initUI()
	self:initSelectUI()
	self:updateUI()

	if self.curIndex == 1 then
		self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
	elseif self.curIndex == 2 then
		self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
	elseif self.curIndex == 3 then
		self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
	else
		self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
	end

	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and arg_3_1 and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

function PopNoviceAwardLayer:initData()
	self.curIndex = 1
	self.data = {}
	self.xinxiya_signstats = {}
	self.lucun_signstats = {}

	for iter_7_0, iter_7_1 in pairs(novice_award_data) do
		table.insert(self.data, {
			id = iter_7_1.id,
			xinxiya_dropid = iter_7_1.xinxiya_dropid,
			lucun_dropid = iter_7_1.lucun_dropid
		})

		self.xinxiya_signstats[iter_7_1.id] = iter_7_1.id <= playermodel.novice_award_process_xinxiya
		self.lucun_signstats[iter_7_1.id] = iter_7_1.id <= playermodel.novice_award_process_lucun

		if self.xinxiya_signstats[iter_7_1.id] then
			self.curIndex = iter_7_1.id + 1
			self.curIndex = math.min(self.curIndex, #novice_award_data)
		end
	end
end

function PopNoviceAwardLayer:initUI()
	self.itemsPanel = ccui.Layout:create()

	self.itemsPanel:setTouchEnabled(true)
	self.itemsPanel:setContentSize(cc.size(500, 315))
	self.itemsPanel:setAnchorPoint(cc.p(0, 0))
	self.itemsPanel:setPosition(cc.p(60, 80 + self.extheight))
	self.itemsPanel:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.itemsPanel:setBackGroundColor(cc.c3b(255, 0, 0))
	self.itemsPanel:setTouchEnabled(true)
	self.rootpanel:addChild(self.itemsPanel, 20)

	self.leftArrow = ccui.ImageView:create("PopNoviceAwardLayer/arrow_createrole.png", var_0_0)

	self.leftArrow:setTouchEnabled(true)
	self.leftArrow:setPosition(cc.p(36, 230 + self.extheight))
	self.rootpanel:addChild(self.leftArrow, 30)
	self.leftArrow:runAction(cc.RotateTo:create(0, 180))
	self.leftArrow:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curIndex = self.curIndex - 1

		if self.curIndex == 0 then
			self.curIndex = #self.data
		end

		self:updateUI()

		if self.curIndex == 1 then
			self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
		elseif self.curIndex == 2 then
			self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
		elseif self.curIndex == 3 then
			self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
		else
			self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
		end
	end)

	local var_8_0 = ccui.Layout:create()

	var_8_0:setTouchEnabled(true)
	var_8_0:setContentSize(cc.size(60, 160))
	var_8_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_0:setPosition(cc.p(20, 0))
	var_8_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_8_0:setBackGroundColor(cc.c3b(255, 0, 0))
	var_8_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curIndex = self.curIndex - 1

		if self.curIndex == 0 then
			self.curIndex = #self.data
		end

		self:updateUI()

		if self.curIndex == 1 then
			self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
		elseif self.curIndex == 2 then
			self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
		elseif self.curIndex == 3 then
			self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
		else
			self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
		end
	end)
	self.leftArrow:addChild(var_8_0)

	self.rightArrow = ccui.ImageView:create("PopNoviceAwardLayer/arrow_createrole.png", var_0_0)

	self.rightArrow:setTouchEnabled(true)
	self.rightArrow:setPosition(cc.p(600, 230 + self.extheight))
	self.rootpanel:addChild(self.rightArrow, 20)
	self.rightArrow:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curIndex = self.curIndex + 1

		if self.curIndex > #self.data then
			self.curIndex = 1
		end

		self:updateUI()

		if self.curIndex == 1 then
			self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
		elseif self.curIndex == 2 then
			self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
		elseif self.curIndex == 3 then
			self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
		else
			self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
		end
	end)

	local var_8_1 = ccui.Layout:create()

	var_8_1:setTouchEnabled(true)
	var_8_1:setContentSize(cc.size(70, 160))
	var_8_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_1:setPosition(cc.p(20, 20 + self.extheight))
	var_8_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_8_1:setBackGroundColor(cc.c3b(255, 0, 0))
	var_8_1:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.curIndex = self.curIndex + 1

		if self.curIndex > #self.data then
			self.curIndex = 1
		end

		self:updateUI()

		if self.curIndex == 1 then
			self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
		elseif self.curIndex == 2 then
			self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
		elseif self.curIndex == 3 then
			self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
		else
			self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
		end
	end)
	self.rightArrow:addChild(var_8_1)

	self.getAwardBtn = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_0)

	self.getAwardBtn:setPosition(cc.p(163, -50 + self.extheight))
	self.rootpanel:addChild(self.getAwardBtn, 10)
	self.getAwardBtn:addTouchEventListener(self:getAwardHanel())

	self.awardDesImg = ccui.ImageView:create("PopNoviceAwardLayer/award_des_1.png", var_0_0)

	self.awardDesImg:setPosition(cc.p(400, 388 + self.extheight))
	self.rootpanel:addChild(self.awardDesImg, 10)

	self.levelLimitLabel = cc.Label:createWithTTF("1-1", FONT_DES, 24)

	self.levelLimitLabel:setPosition(cc.p(300, -20))
	self.getAwardBtn:addChild(self.levelLimitLabel)

	local var_8_2 = ccui.ImageView:create("PopNoviceAwardLayer/lucun_page_1.png", var_0_0)

	self.tabScorllView = ccui.ScrollView:create()

	self.tabScorllView:setBounceEnabled(false)
	self.tabScorllView:setPosition(cc.p(0, 35 + self.extheight))
	self.tabScorllView:setContentSize(cc.size(640, var_8_2:getContentSize().height))
	self.tabScorllView:setInnerContainerSize(cc.size(var_8_2:getContentSize().width * #novice_award_data, var_8_2:getContentSize().height))
	self.tabScorllView:setDirection(ccui.ScrollViewDir.horizontal)
	self.tabScorllView:setTouchEnabled(true)
	self.tabScorllView:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.tabScorllView:setBackGroundColor(cc.c3b(255, 255, 0))
	self.tabScorllView:setBackGroundColorOpacity(255)
	self.rootpanel:addChild(self.tabScorllView, 121)

	self.dayPonts = {}

	for iter_8_0 = 1, #novice_award_data do
		self.dayPonts[iter_8_0] = ccui.ImageView:create("PopNoviceAwardLayer/lucun_page_" .. iter_8_0 .. ".png", var_0_0)

		self.dayPonts[iter_8_0]:setPosition(cc.p((iter_8_0 - 0.5) * self.dayPonts[iter_8_0]:getContentSize().width, self.tabScorllView:getContentSize().height / 2))

		self.dayPonts[iter_8_0].index = iter_8_0

		self.dayPonts[iter_8_0]:setTouchEnabled(true)
		self.dayPonts[iter_8_0]:addTouchEventListener(function(arg_13_0, arg_13_1)
			if arg_13_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.curIndex = arg_13_0.index

			self:updateUI()
		end)
		self.tabScorllView:addChild(self.dayPonts[iter_8_0])
	end

	self.valueimg = ccui.ImageView:create("GUI/image.png", var_0_0)

	self.valueimg:setPosition(cc.p(544, 440 + self.extheight))
	self.rootpanel:addChild(self.valueimg, 10)

	self.magnifier = ccui.Layout:create()

	self.magnifier:setContentSize(cc.size(100, 100))
	self.magnifier:setTouchEnabled(true)
	self.magnifier:setPosition(cc.p(520, 500 + self.extheight))
	self.magnifier:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootpanel:addChild(self.magnifier, 10)

	local var_8_3 = ccui.Layout:create()

	var_8_3:setContentSize(cc.size(640, 150))
	var_8_3:setTouchEnabled(true)
	var_8_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_3:setPosition(cc.p(320, 20 + self.extheight))
	var_8_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_8_3:setBackGroundColor(cc.c3b(255, 0, 0))
	var_8_3:setBackGroundColorOpacity(180)
	self.rootpanel:addChild(var_8_3, -1)
	self.magnifier:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[13015020].servant
		})
	end)

	self.magnifier_xinxiya = ccui.Layout:create()

	self.magnifier_xinxiya:setContentSize(cc.size(100, 100))
	self.magnifier_xinxiya:setTouchEnabled(true)
	self.magnifier_xinxiya:setPosition(cc.p(30, 500 + self.extheight))
	self.magnifier_xinxiya:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootpanel:addChild(self.magnifier_xinxiya, 10)
	self.magnifier_xinxiya:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("SoulsLayer", {
			showtype = 6,
			defaultDisplayType = "preview",
			layertype = "DropDetailsLayer",
			cursoul = item_data[1305920].servant
		})
	end)

	self.touchButton = ccui.Button:create("GUI/image.png", "GUI/image.png", "GUI/image.png", var_0_0)

	self.touchButton:setSwallowTouches(false)
	self.touchButton:setScale9Enabled(true)
	self.touchButton:setOpacity(0)
	self.touchButton:setCapInsets(cc.rect(20, 20, 1, 1))
	self.touchButton:setContentSize(cc.size(640, 340))
	self.touchButton:setPosition(cc.p(self.rootpanel:getContentSize().width / 2, 220 + self.extheight))
	self.rootpanel:addChild(self.touchButton, 110)
	self.touchButton:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0 = arg_16_0:getTouchBeganPosition()
		local var_16_1 = arg_16_0:getTouchEndPosition()

		if var_16_0.x - var_16_1.x > 50 then
			self.curIndex = self.curIndex + 1

			if self.curIndex > #self.data then
				self.curIndex = 1
			end

			self:updateUI()

			if self.curIndex == 1 then
				self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
			elseif self.curIndex == 2 then
				self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
			elseif self.curIndex == 3 then
				self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
			else
				self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
			end
		elseif var_16_0.x - var_16_1.x < -50 then
			self.curIndex = self.curIndex - 1

			if self.curIndex == 0 then
				self.curIndex = #self.data
			end

			self:updateUI()

			if self.curIndex == 1 then
				self.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
			elseif self.curIndex == 2 then
				self.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
			elseif self.curIndex == 3 then
				self.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
			else
				self.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
			end
		end
	end)

	self.bpBtn = ccui.Button:create("PopNoviceAwardLayer/bp.png", nil, "PopNoviceAwardLayer/bp.png", var_0_0)

	self.bpBtn:setPosition(cc.p(456, -50 + self.extheight))
	self.rootpanel:addChild(self.bpBtn, 10)

	local var_8_4 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_8_4:setPosition(self.bpBtn:getContentSize().width + 60, 70)
	self.bpBtn:addChild(var_8_4)

	local function var_8_5(...)
		if not self.bpBtn then
			return
		end

		if not activity_manager:getActivityObj(136) and not activity_manager:getActivityObj(255) then
			self.bpBtn:setVisible(false)
			self.getAwardBtn:setPosition(cc.p(320, -50 + self.extheight))
			self.levelLimitLabel:setPosition(cc.p(self.getAwardBtn:getContentSize().width / 2, -15))
		else
			self.bpBtn:setVisible(true)

			if activity_manager:getAlertAllStatus(136) or activity_manager:getAlertAllStatus(255) then
				var_8_4:setVisible(true)
			else
				var_8_4:setVisible(false)
			end
		end
	end

	var_8_5()
	self.bpBtn:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("NoviceSummaryLayer", {
			layerName = "ActivityXinxiYaBPLayer",
			isHideOther = true,
			exitCallback = var_8_5
		})
	end)

	self.recharge_tip = ccui.ImageView:create("PopNoviceAwardLayer/recharge_tip.png", var_0_0)

	self.rootpanel:addChild(self.recharge_tip, 10)
	self.recharge_tip:setPositionX(self.rootpanel:getContentSize().width / 2 + 100)
	self.recharge_tip:setPositionY(self.rootpanel:getContentSize().height / 2 + 150)
end

function PopNoviceAwardLayer.getAwardHanel(arg_19_0)
	return function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_20_0:isBright() then
			return
		end

		arg_20_0:setBright(false)

		if arg_19_0.selectType ~= var_0_9 and arg_19_0.selectType ~= var_0_10 then
			arg_20_0:setBright(true)

			return
		end

		if arg_19_0.selectType == var_0_9 then
			local var_20_0 = arg_19_0.xinxiya_signstats or arg_19_0.lucun_signstats

			if var_20_0[arg_19_0.curIndex] then
				global_ShowBlockWords("已领取")
				arg_20_0:setBright(true)

				return
			end
		end

		local var_20_1 = novice_award_data[arg_19_0.curIndex].limit_level

		if playermodel.rechargeamountxinxiya < novice_award_data[arg_19_0.curIndex].recharge_rmb then
			arg_20_0:setBright(true)
			LayerManager:pushInLayer("PopSupermarketLayer", {
				callback = function(...)
					arg_19_0:updateUI()
				end
			})

			return
		elseif var_20_1 and not level_manager:isPlayerPassLevel(var_20_1) then
			global_ShowBlockWords(L_CLEAR_CHAPTER .. level_manager:formatSystemUnlockLevel(var_20_1))
			arg_20_0:setBright(true)

			return
		end

		if arg_19_0.selectType == var_0_9 then
			if arg_19_0.curIndex ~= (playermodel.novice_award_process_xinxiya or playermodel.novice_award_process_lucun) + 1 then
				global_ShowBlockWords(L_NOVICE_AWARD_2[1])
				arg_20_0:setBright(true)

				return
			end
		end

		playermodel:get_novice_award(arg_19_0.selectType, function(arg_22_0)
			if arg_22_0.result == 1 then
				var_20_0[arg_19_0.curIndex] = true
				arg_19_0.curIndex = arg_19_0.curIndex + 1
				arg_19_0.curIndex = math.min(arg_19_0.curIndex, #novice_award_data)

				arg_19_0:updateUI()
				activity_manager:fireEvent(activity_manager.activityEventId.UPDATE_NEW_ACTIVITY_LIST)
				cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("ON_GET_XINXIYA_TOTAL_RECHARGE_AWARD")))

				if arg_19_0.curIndex == 1 then
					arg_19_0.tabScorllView:scrollToPercentHorizontal(1, 0.1, false)
				elseif arg_19_0.curIndex == 2 then
					arg_19_0.tabScorllView:scrollToPercentHorizontal(44, 0.1, false)
				elseif arg_19_0.curIndex == 3 then
					arg_19_0.tabScorllView:scrollToPercentHorizontal(88, 0.1, false)
				else
					arg_19_0.tabScorllView:scrollToPercentHorizontal(99, 0.1, false)
				end
			elseif arg_22_0.result == 4 then
				print(L_NOVICE_AWARD_2[2])
			elseif arg_22_0.result == 3 then
				print(L_NOVICE_AWARD_2[3])
			elseif arg_22_0.result == 5 then
				print(L_NOVICE_AWARD_2[4])
			end

			arg_20_0:setBright(true)
		end)
	end
end

function PopNoviceAwardLayer:initSelectUI()
	self.selectType = var_0_9

	local var_23_0 = ccui.ImageView:create("PopNoviceAwardLayer/xinxiya_btn_on.png", var_0_0)

	var_23_0:setAnchorPoint(0, 0.5)

	self.xinxiya_Button = var_23_0

	self.xinxiya_Button:setPositionX(0)
	self.xinxiya_Button:setPositionY(self.rootpanel:getContentSize().height / 2 + 340 + self.extheight)
	self.rootpanel:addChild(var_23_0, 2)

	local var_23_1 = ccui.ImageView:create("PopNoviceAwardLayer/lucun_btn_on.png", var_0_0)

	var_23_1:setAnchorPoint(1, 0.5)

	self.lucun_Button = var_23_1

	self.lucun_Button:setPositionX(self.rootpanel:getContentSize().width + 50)
	self.lucun_Button:setPositionY(self.rootpanel:getContentSize().height / 2 + 235 + self.extheight)
	self.rootpanel:addChild(var_23_1, 1)

	local var_23_2 = ccui.Layout:create()

	var_23_2:setContentSize(cc.size(320, 500))
	var_23_2:setTouchEnabled(true)
	var_23_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_2:setPosition(cc.p(160, self.rootpanel:getContentSize().height / 2 + 350 + self.extheight))
	var_23_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootpanel:addChild(var_23_2, 5)

	local var_23_3 = ccui.Layout:create()

	var_23_3:setContentSize(cc.size(320, 500))
	var_23_3:setTouchEnabled(true)
	var_23_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_3:setPosition(cc.p(480, self.rootpanel:getContentSize().height / 2 + 350 + self.extheight))
	var_23_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self.rootpanel:addChild(var_23_3, 5)
	var_23_2:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchSelectServant(var_0_9)
	end)
	var_23_3:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchSelectServant(var_0_10)
	end)
end

function PopNoviceAwardLayer:switchSelectServant(arg_26_1)
	if self.selectType == arg_26_1 then
		return
	end

	self.selectType = arg_26_1

	self:updateUI()
end

local var_0_11 = {
	cc.p(90, 142),
	cc.p(310, 194),
	cc.p(450, 194),
	cc.p(275, 76),
	cc.p(380, 76),
	(cc.p(475, 76))
}
local var_0_12 = {
	1,
	1.1,
	1.1,
	0.8,
	0.8,
	0.8
}

function PopNoviceAwardLayer:updateUI()
	(function(...)
		while self.itemsPanel:getChildByName("itemSp_" .. 1) do
			self.itemsPanel:removeChild((self.itemsPanel:getChildByName("itemSp_" .. 1)))
		end
	end)()
	;(function()
		local var_29_0 = drop_manager:getDropMsg((self.selectType == var_0_9 or nil) and (self.data[self.curIndex].xinxiya_dropid or self.data[self.curIndex].lucun_dropid))
		local var_29_1 = {}

		if var_29_0.diamond > 0 then
			table.insert(var_29_1, {
				itemid = "diamond",
				order = 1.5,
				num = var_29_0.diamond,
				name = L_DIAMOND
			})
		end

		if var_29_0.gold > 0 then
			table.insert(var_29_1, {
				itemid = "gold",
				order = 100,
				num = var_29_0.gold,
				name = L_GOLD
			})
		end

		for iter_29_0, iter_29_1 in pairs(var_29_0.equips) do
			table.insert(var_29_1, {
				itemid = iter_29_1.dropid,
				num = iter_29_1.dropNum,
				name = item_data[iter_29_1.dropid].name,
				order = iter_29_0
			})
		end

		table.sort(var_29_1, function(arg_30_0, arg_30_1)
			return arg_30_0.order < arg_30_1.order
		end)

		for iter_29_2, iter_29_3 in pairs(var_29_1) do
			local var_29_2

			if iter_29_2 == 1 then
				var_29_2 = ccui.Button:create("public/box/new_item_bg1.png", "public/box/new_item_bg1.png", "public/box/new_item_bg1.png", var_0_0)

				local var_29_4 = ItemSprite:createNewWithItemId(iter_29_3.itemid, nil, nil, iter_29_3.name .. ((iter_29_3.num > 1 or nil) and "X" .. iter_29_3.num))

				var_29_4:setName("itemSp")
				var_29_4:setAnchorPoint(cc.p(0, 0))
				var_29_2:addChild(var_29_4)
			else
				local var_29_5
				local var_29_6
				local var_29_7 = 1
				local var_29_8

				if iter_29_3.itemid == "gold" then
					var_29_5 = "equipment/1000001.png"
					var_29_6 = 1
					var_29_7 = 1
				elseif iter_29_3.itemid == "diamond" then
					var_29_5 = "equipment/1000000.png"
					var_29_6 = 1
					var_29_7 = 5
				elseif item_data[iter_29_3.itemid].bag_item_type == kITEM_COMPONENT then
					var_29_8 = component_manager:create_component_icon(iter_29_3.itemid)
					var_29_7 = item_data[iter_29_3.itemid].equip_quality
				elseif item_data[iter_29_3.itemid].bag_item_type == kITEM_SCULTURE then
					var_29_5 = "roleimage/role/wuji/" .. item_data[iter_29_3.itemid].image_id .. ".png"
					var_29_7 = item_data[iter_29_3.itemid].equip_quality
				elseif item_data[iter_29_3.itemid].image_id then
					var_29_5 = "equipment/" .. item_data[iter_29_3.itemid].image_id .. ".png"
					var_29_7 = item_data[iter_29_3.itemid].equip_quality
				end

				var_29_2 = ccui.Button:create("ActivityFlopDuanwu/" .. var_29_7 .. ".png", "ActivityFlopDuanwu/" .. var_29_7 .. ".png", "ActivityFlopDuanwu/" .. var_29_7 .. ".png", var_0_0)
				var_29_8 = var_29_8 or ccui.ImageView:create(var_29_5)

				var_29_8:setVisible(true)
				var_29_8:setName("itemSp")

				if var_29_6 then
					var_29_8:setScale(var_29_6 * 0.6)
				else
					var_29_8:setScale(global_get_item_scale(var_29_8, item_data[iter_29_3.itemid].bag_item_type) * 0.6)
				end

				var_29_8:setAnchorPoint(cc.p(0.5, 0.5))
				var_29_8:setPositionX(var_29_2:getContentSize().width / 2)
				var_29_8:setPositionY(var_29_2:getContentSize().height / 2)
				var_29_2:addChild(var_29_8)

				function var_29_8:afterLoadSuccess(...)
					if var_29_6 then
						return
					end

					self:setScale(global_get_item_scale(self, item_data[iter_29_3.itemid].bag_item_type) * 0.6)
				end

				local var_29_9 = ccui.ImageView:create("PopNoviceAwardLayer/num_bg.png", var_0_0)

				var_29_9:setAnchorPoint(cc.p(0.5, 0))
				var_29_9:setPositionX(var_29_2:getContentSize().width / 2)
				var_29_2:addChild(var_29_9)

				local var_29_10 = cc.Label:createWithTTF("x" .. iter_29_3.num, FONT_DES, 16)

				var_29_10:setAnchorPoint(cc.p(0, 0.5))
				var_29_10:setPositionX(4)
				var_29_10:setPositionY(var_29_9:getContentSize().height / 2)
				var_29_10:setColor(cc.c3b(63, 28, 92))
				var_29_9:addChild(var_29_10)

				if var_29_2:getChildByName("avatar_spine") then
					var_29_2:getChildByName("avatar_spine"):setName("avatar_spine_old")
					var_29_2:getChildByName("avatar_spine_old"):removeFromParent()
				end

				if item_data[iter_29_3.itemid] and item_data[iter_29_3.itemid].bag_item_type == kITEM_SCULTURE and item_data[iter_29_3.itemid].spine then
					var_29_8:setVisible(false)

					local var_29_11 = AvatarSprite:create(iter_29_3.itemid)

					var_29_11:setName("avatar_spine")
					var_29_11:setPositionX(0)
					var_29_11:setPositionY(0)
					var_29_11:setScale(0.6)
					var_29_2:addChild(var_29_11)
				end
			end

			var_29_2:setScale(var_0_12[iter_29_2])
			var_29_2:setName("itemSp_" .. iter_29_2)
			var_29_2:setPosition(var_0_11[iter_29_2])

			var_29_2.itemid = iter_29_3.itemid

			self.itemsPanel:addChild(var_29_2)

			if type(iter_29_3.itemid) == "number" then
				var_29_2:addTouchEventListener(function(arg_32_0, arg_32_1)
					if arg_32_1 ~= ccui.TouchEventType.ended then
						return
					end

					if arg_32_0.itemid == 1305920 then
						if arg_32_1 ~= ccui.TouchEventType.ended then
							return
						end

						LayerManager:pushInLayer("SoulsLayer", {
							showtype = 6,
							defaultDisplayType = "preview",
							layertype = "DropDetailsLayer",
							cursoul = item_data[1305920].servant
						})
					else
						PopLayer:Item({
							hideGainButton = true,
							itemid = arg_32_0.itemid
						})
					end
				end)
			end
		end
	end)()
	;(function(...)
		return
	end)()
	;(function(...)
		local var_34_0 = self.selectType == var_0_9 and "PopNoviceAwardLayer/xinxiya_" or "PopNoviceAwardLayer/lucun_"
		local var_34_1

		if self.selectType == var_0_9 then
			var_34_1 = self.xinxiya_signstats or self.lucun_signstats

			local var_34_2

			if self.selectType == var_0_9 then
				var_34_2 = playermodel.novice_award_process_xinxiya or playermodel.novice_award_process_lucun

				if playermodel.rechargeamountxinxiya < novice_award_data[self.curIndex].recharge_rmb then
					self.levelLimitLabel:setVisible(true)
					self.levelLimitLabel:setVisible(true)

					if not var_34_1[self.curIndex] then
						if self.curIndex == 1 then
							self.levelLimitLabel:setString(L_NOVICE_AWARD[1] .. novice_award_data[self.curIndex].recharge_rmb .. L_NOVICE_AWARD[2])
						else
							self.levelLimitLabel:setString(L_NOVICE_AWARD[3] .. novice_award_data[self.curIndex].recharge_rmb - playermodel.rechargeamountxinxiya .. L_NOVICE_AWARD[2])
						end
					elseif self.curIndex == #var_34_1 then
						self.levelLimitLabel:setVisible(false)
					else
						self.levelLimitLabel:setString(L_NOVICE_AWARD[3] .. novice_award_data[self.curIndex + 1].recharge_rmb - playermodel.rechargeamountxinxiya .. L_NOVICE_AWARD[4])
					end

					goto label_34_0
				end
			end
		end

		self.levelLimitLabel:setVisible(false)

		::label_34_0::

		if var_34_1[self.curIndex] then
			self.getAwardBtn:loadTextures(var_34_0 .. "btn_got.png", nil, var_34_0 .. "btn_got.png", var_0_0)
		else
			local var_34_3 = novice_award_data[self.curIndex].limit_level

			if var_34_2 + 1 ~= self.curIndex then
				if playermodel.rechargeamountxinxiya < novice_award_data[self.curIndex].recharge_rmb then
					self.getAwardBtn:loadTextures(var_34_0 .. "btn_goto_recharge.png", nil, var_34_0 .. "btn_goto_recharge.png", var_0_0)
				else
					self.getAwardBtn:loadTextures(var_34_0 .. "btn_get.png", nil, var_34_0 .. "btn_get.png", var_0_0)
				end
			elseif var_34_3 and not level_manager:isPlayerPassLevel(var_34_3) then
				self.getAwardBtn:loadTextures(var_34_0 .. "btn_get.png", nil, var_34_0 .. "btn_get.png", var_0_0)
			elseif playermodel.rechargeamountxinxiya < novice_award_data[self.curIndex].recharge_rmb then
				self.getAwardBtn:loadTextures(var_34_0 .. "btn_goto_recharge.png", nil, var_34_0 .. "btn_goto_recharge.png", var_0_0)
			else
				self.getAwardBtn:loadTextures(var_34_0 .. "btn_get.png", nil, var_34_0 .. "btn_get.png", var_0_0)
			end
		end
	end)()
	;(function(...)
		local var_35_0 = self.selectType == var_0_9 and "xinxiya_page_" or "lucun_page_"
		local var_35_1

		if self.selectType == var_0_9 then
			var_35_1 = self.xinxiya_signstats or self.lucun_signstats

			if self.selectType ~= var_0_9 or not playermodel.novice_award_process_xinxiya then
				-- block empty
			end
		end

		for iter_35_0, iter_35_1 in pairs(self.dayPonts) do
			if self.curIndex == iter_35_0 then
				iter_35_1:loadTexture("PopNoviceAwardLayer/" .. var_35_0 .. iter_35_0 .. ".png", var_0_0)
			else
				iter_35_1:loadTexture("PopNoviceAwardLayer/" .. var_35_0 .. iter_35_0 .. "_lock.png", var_0_0)
			end

			local var_35_3 = novice_award_data[iter_35_0].limit_level

			if not var_35_1[iter_35_0] and playermodel.rechargeamountxinxiya >= novice_award_data[iter_35_0].recharge_rmb and (not var_35_3 or level_manager:isPlayerPassLevel(var_35_3)) then
				global_add_alert_tag(iter_35_1, {
					x = iter_35_1:getContentSize().width + 5,
					y = iter_35_1:getContentSize().height + 10
				})
			else
				global_remove_alert_tag(iter_35_1)
			end
		end
	end)()
	;(function(...)
		self.awardDesImg:loadTexture((self.selectType == var_0_9 and "PopNoviceAwardLayer/xinxiya_award_des_" or "PopNoviceAwardLayer/lucun_award_des_") .. self.curIndex .. ".png", var_0_0)
	end)()
	;(function(...)
		self.valueimg:loadTexture("PopNoviceAwardLayer/" .. ({
			5000,
			6000,
			7000,
			8000,
			9000,
			12500,
			25000
		})[self.curIndex] .. ".png", var_0_0)
	end)()
	;(function(...)
		if self.selectType == var_0_9 then
			self.xinxiya_Button:loadTexture("PopNoviceAwardLayer/xinxiya_btn_on.png", var_0_0)
			self.lucun_Button:loadTexture("PopNoviceAwardLayer/lucun_btn_off.png", var_0_0)
			self.xinxiya_Button:setLocalZOrder(2)
			self.lucun_Button:setLocalZOrder(1)
		else
			self.xinxiya_Button:loadTexture("PopNoviceAwardLayer/xinxiya_btn_off.png", var_0_0)
			self.lucun_Button:loadTexture("PopNoviceAwardLayer/lucun_btn_on.png", var_0_0)
			self.xinxiya_Button:setLocalZOrder(1)
			self.lucun_Button:setLocalZOrder(2)
		end
	end)()
	;(function(...)
		self.bg:loadTexture(self.selectType == var_0_9 and "PopNoviceAwardLayer/recharge_bg.png" or "PopNoviceAwardLayer/recharge_bg2.png", var_0_0)

		if self.bpBtn then
			self.bpBtn:loadTextures(self.selectType == var_0_9 and "PopNoviceAwardLayer/xinxiya_bp.png" or "PopNoviceAwardLayer/lucun_bp.png", nil, self.selectType == var_0_9 and "PopNoviceAwardLayer/xinxiya_bp.png" or "PopNoviceAwardLayer/lucun_bp.png", var_0_0)
		end
	end)()
	print(self.curIndex, #novice_award_data)
end

function PopNoviceAwardLayer:initBg(arg_40_1)
	local var_40_0 = ccui.Layout:create()

	var_40_0:setTouchEnabled(true)
	var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_40_0:setAnchorPoint(cc.p(0, 0))
	var_40_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_40_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_40_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_40_0:setOpacity(0)
	self:addChild(var_40_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_41_0)
		self:addChild(arg_41_0, -2)
		arg_41_0:setPositionY(arg_41_0:getPositionY() - GameDisplay.fix_y)

		local var_41_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_41_0:setAnchorPoint(cc.p(0, 0))
		var_41_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_41_0, -1)
		self:init(arg_40_1)
		var_40_0:setOpacity(102)
		var_40_0:setTouchEnabled(false)
	end)
end

function PopNoviceAwardLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
