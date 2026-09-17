AITwistLayer = class("AITwistLayer", function()
	return cc.Layer:create()
end)

local network = require("network.network")

require("view.Layer.PopLayer")
require("view.Layer.TopcostLayer")
require("view.Layer.ListButtonLayer")
require("view.Layer.DropDetailsLayer")
require("view.Layer.DetailsofHelpGirlLayer")
require("controller.goto_system_manager")
require("view.Sprite.ConfirmDialogSprite")

local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local horcrux_manager = require("controller.horcrux_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local twist_manager = require("controller.twist_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local autopop_manager = require("controller.autopop_manager")
local aiattack_manager = require("controller.aiattack_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local twist_config_data = require("data.twist_config_data")
local drop_data = require("data.drop_data")
local var_0_21
local var_0_22 = config._DEBUG and 0 or 1
local var_0_23 = 1
local var_0_24 = 2
local var_0_25 = 1
local var_0_27 = {
	[TWISTEGGS_TYPE.normal] = "今日剩余免费次数不足",
	[TWISTEGGS_TYPE.wind] = "扭蛋券不足",
	[TWISTEGGS_TYPE.fire] = "扭蛋券不足",
	[TWISTEGGS_TYPE.water] = "扭蛋券不足",
	[TWISTEGGS_TYPE.light] = "扭蛋券不足",
	[TWISTEGGS_TYPE.dark] = "扭蛋券不足",
	[TWISTEGGS_TYPE.recommend] = "扭蛋券不足"
}
local var_0_30 = 0
local var_0_31 = 1
local var_0_32 = 2

local function var_0_33(arg_2_0)
	local var_2_0 = arg_2_0 - time_check_manager:getCurTime()

	if var_2_0 < 0 then
		return
	end

	return var_2_0 > 86400 and string.format("%02d天%02d时", math.floor(var_2_0 / 86400), math.floor(var_2_0 % 86400 / 3600)) or var_2_0 > 3600 and string.format("%02d时%02d分", math.floor(var_2_0 / 3600), math.floor(var_2_0 % 3600 / 60)) or string.format("%02d分%02d秒", math.floor(var_2_0 / 60), math.floor(var_2_0 % 60))
end

function AITwistLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = AITwistLayer.new()

	var_3_0:setName("AITwistLayer")
	var_3_0:init(arg_3_1)

	return var_3_0
end

function AITwistLayer.getInstance()
	return var_0_21
end

function AITwistLayer:init(arg_5_1)
	var_0_21 = self
	self.exitCallback = nil

	if arg_5_1 then
		self.exitCallback = arg_5_1.exitCallback
	end

	if arg_5_1 then
		self.initTwisType = arg_5_1.initTwisType
	end

	self.returnLayer = arg_5_1 and (arg_5_1.returnLayer or "MainLayer") or "MainLayer"
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TwistEgg.json" or "TwistEgg.ExportJson")

	self:addChild(self.rootLayer)

	self.oneBnt = self.rootLayer:getChildByName("Button_one")
	self.tenBnt = self.rootLayer:getChildByName("Button_ten")
	self.clipPanel = self.rootLayer:getChildByName("Panel_clip")
	self.mainImg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_main")

	self.mainImg:setTouchEnabled(true)

	self.timePanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_time")
	self.countPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_count")

	self.countPanel:setPositionX(20)

	self.doubleCount1 = ccui.Helper:seekWidgetByName(self.rootLayer, "up_count1")

	self.doubleCount1:setVisible(false)

	self.doubleCount2 = ccui.Helper:seekWidgetByName(self.rootLayer, "up_count2")

	self.doubleCount2:setVisible(false)
	self.rootLayer:getChildByName("Bottom_bg"):setLocalZOrder(1)

	local var_5_0 = self.rootLayer:getChildByName("Bottom_bg"):getChildByName("Panel_num_bg")

	self.freeCostImg = var_5_0:getChildByName("Image_2")
	self.paidCostImg = var_5_0:getChildByName("Image_1")
	self.costLabel = var_5_0:getChildByName("Label_num")
	self.showPanel = self.rootLayer:getChildByName("Panel_show")
	self.skipBnt = self.rootLayer:getChildByName("Button_skip")
	self.pointsPanel = ccui.Layout:create()

	self.rootLayer:addChild(self.pointsPanel)

	self.imgScrollView = ccui.ScrollView:create()

	self.imgScrollView:setDirection(ccui.ScrollViewDir.horizontal)
	self.imgScrollView:setBounceEnabled(true)
	self.imgScrollView:setAnchorPoint(cc.p(0, 0))
	self.imgScrollView:setContentSize(cc.size(640, 92))
	self.imgScrollView:setAnchorPoint(cc.p(0, 1))
	self.imgScrollView:setPosition(0, 340)
	self.rootLayer:addChild(self.imgScrollView)
	self:initShowResultPanel()

	self.returnBnt = self.rootLayer:getChildByName("Bottom_bg"):getChildByName("Button_return")

	self.returnBnt:setPosition(cc.p(63, 60))
	self:registerReturnEvent()
	twist_manager:get_free_times(function(arg_6_0)
		self.freetime = 30 - arg_6_0
	end)

	self.curTwistIndex = 1
	self.isAlowOtherTouch = true

	self:initUI()
	self:fullScreen()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_21 = nil

			if self.showAniScheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
			end

			local alert_manager = require("controller.alert_manager")

			alert_manager:unregister_alert(ALERT_TWIST_TEN)
			RoleDefault:getInstance():setBoolForKey("TWIST_IS_TEN", false)
			TextureManager:removeSpineTexturesWithOutCollect()

			if not twist_manager:checkIsAlertNew() then
				alert_manager:unregister_alert(ALERT_NEW_TWIST)
			end
		end
	end)
end

function AITwistLayer:registerReturnEvent()
	self.returnBnt:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function AITwistLayer:fullScreen()
	local var_10_0 = self.rootLayer:getChildByName("Bottom_bg")

	var_10_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_10_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_10_0:setPositionY(var_10_0.full_posY)

	self.oneBnt.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.oneBnt:getPositionY() + 50, TRANSFORM_UNIT.PX)

	self.oneBnt:setPositionY(self.oneBnt.full_posY)

	self.tenBnt.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.tenBnt:getPositionY() + 50, TRANSFORM_UNIT.PX)

	self.tenBnt:setPositionY(self.tenBnt.full_posY)
	self.mainImg:loadTexture("mainScenebg/twist_bg/0.png")

	self.clipPanel = self.rootLayer:getChildByName("Panel_clip")
	self.clipPanel.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.clipPanel:getPositionY(), TRANSFORM_UNIT.PX)

	self.clipPanel:setPositionY(self.clipPanel.full_posY)

	local var_10_1 = self.clipPanel:getContentSize().height + (GameDisplay.height - GameDisplay.notch_height - config._DESIGN_HEIGHT)

	self.clipPanel:setContentSize(cc.size(640, var_10_1 > self.mainImg:getContentSize().height and self.mainImg:getContentSize().height or var_10_1))

	local var_10_2 = self.rootLayer:getChildByName("Button_goto_market")

	var_10_2.full_posY = self.clipPanel:getContentSize().height - 28 + self.clipPanel.full_posY

	var_10_2:setPositionY(var_10_2.full_posY)

	self.pointsPanel.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.pointsPanel:getPositionY(), TRANSFORM_UNIT.PX)

	self.pointsPanel:setPositionY(self.pointsPanel.full_posY)

	self.imgScrollView.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.imgScrollView:getPositionY(), TRANSFORM_UNIT.PX)

	self.imgScrollView:setPositionY(self.imgScrollView.full_posY)

	self.showPanel.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)

	self.showPanel:setPositionY(self.showPanel.full_posY)
	self.showPanel:setContentSize(cc.size(self.showPanel:getContentSize().width, GameDisplay.height))
	self.doubleCount1:setPositionY(self.doubleCount1:getParent():getContentSize().height - 385)
	self.doubleCount2:setPositionY(self.doubleCount2:getParent():getContentSize().height - 445)
end

function AITwistLayer:initUI()
	self.curtwistDate = {}
	self.twist_type_to_index = {}
	self.isCanChangeTwist = true

	require("view.Sprite.TitleSprite")

	local var_11_0 = TitleSprite:create("public/panelbg/title_ai_twist.png", 2)

	var_11_0:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_11_0)
	self.rootLayer:setVisible(false)
	twist_manager:get_ai_twist_status(function(arg_12_0)
		self.rootLayer:setVisible(true)
		table.sort(arg_12_0, function(arg_13_0, arg_13_1)
			return arg_13_0.pos < arg_13_1.pos
		end)

		for iter_12_0, iter_12_1 in pairs(arg_12_0) do
			self.curtwistDate[iter_12_0] = {
				pos = iter_12_0,
				upitems = iter_12_1.items,
				twistType = iter_12_1.twisttype,
				img = iter_12_1.img,
				time = iter_12_1.time,
				twistcount = iter_12_1.twistcount,
				upid = iter_12_1.upid,
				upcount = iter_12_1.upcount,
				updes = iter_12_1.updes,
				upcount2 = iter_12_1.upcount2,
				uppos2 = iter_12_1.uppos2,
				costtype = iter_12_1.costtype,
				costone = iter_12_1.costone,
				costten = iter_12_1.costten,
				dailyfreeforone = iter_12_1.dailyfreeforone,
				totalfreeforone = iter_12_1.totalfreeforone,
				dailyfreeforten = iter_12_1.dailyfreeforten,
				totalfreeforten = iter_12_1.totalfreeforten,
				naivemark = iter_12_1.naivemark,
				blackcard_type = iter_12_1.blackcard_type
			}
			self.twist_type_to_index[iter_12_1.twisttype] = iter_12_0

			if self.initTwisType and self.initTwisType == iter_12_1.twisttype then
				self.curTwistIndex = iter_12_0
			end
		end

		self:updateTwistType(self.curtwistDate[self.curTwistIndex].twistType)
		self:registBntTimesEvent()
		self:initTimer()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			self:updateGuidesOnLayer()
		end)))
	end)
	self:initGotoMarketBtn()
end

function AITwistLayer:initTimer()
	self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		if self.curtwistDate[self.curTwistIndex].time then
			local var_16_0 = var_0_33(self.curtwistDate[self.curTwistIndex].time)

			if var_16_0 then
				self.timePanel:getChildByName("Label"):setString(var_16_0)
			end
		end
	end), cc.DelayTime:create(1))))
end

function AITwistLayer.updateGuidesOnLayer(arg_17_0)
	LayerManager:updateGuidesOnSwitchLayer()
end

function AITwistLayer:registBntTimesEvent()
	self.oneBnt:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		if twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].unlock_level and config.limit_open_system and not level_manager:isPlayerPassLevel(twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].unlock_level) then
			global_ShowBlockWords("通关" .. level_manager:formatModeChapterLevelByPlayerLevel(twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].unlock_level) .. "解锁")

			return
		end

		if twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].stat == 3 and self:get_naive_stat(self.curtwistDate[self.curTwistIndex].naivemark, "one") then
			global_ShowBlockWords("新手扭蛋单次机会已用过~")

			return
		end

		arg_19_0:setBright(false)

		self.isCanChangeTwist = false

		GuideListener.swallowEvent(false)
		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()
		self:twist_one_result(self.curtwistDate[self.curTwistIndex].twistType, function()
			arg_19_0:setBright(true)

			self.isCanChangeTwist = true
		end)
	end)
	self.tenBnt:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_21_0:isBright() then
			return
		end

		if self.tenBntOtherLock then
			return
		end

		if twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].unlock_level and config.limit_open_system and not level_manager:isPlayerPassLevel(twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].unlock_level) then
			global_ShowBlockWords("通关" .. level_manager:formatModeChapterLevelByPlayerLevel(twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].unlock_level) .. "解锁")

			return
		end

		if twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].stat == 3 and self:get_naive_stat(self.curtwistDate[self.curTwistIndex].naivemark, "ten") then
			global_ShowBlockWords("新手扭蛋十连机会已用过~")

			return
		end

		arg_21_0:setBright(false)

		self.isCanChangeTwist = false
		self.tenBntOtherLock = true

		local function var_21_0()
			arg_21_0:setBright(true)

			self.isCanChangeTwist = true
		end

		local var_21_1 = self.curtwistDate[self.curTwistIndex].twistType

		GuideListener.swallowEvent(false)
		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()

		if playermodel.twistTenPop and self.curtwistDate[self.curTwistIndex].costtype == 6800101 and item_manager:isHaveEnoughItem(self.curtwistDate[self.curTwistIndex].costtype, self.curtwistDate[self.curTwistIndex].costten) then
			LayerManager:pushInLayer("PopDoLayer", {
				labels = global_deepCopy(L_TWIST_TEN_POP),
				surecallback = function()
					self:twist_ten_result(var_21_1, var_21_0)
				end,
				cancelcallback = function()
					var_21_0()

					self.tenBntOtherLock = false
				end
			})
		else
			self:twist_ten_result(self.curtwistDate[self.curTwistIndex].twistType, var_21_0)
		end
	end)
end

function AITwistLayer.registSlideEvent(arg_25_0)
	return
end

function AITwistLayer:updateTwistType(arg_26_1)
	local var_26_0 = self.curtwistDate[self.twist_type_to_index[arg_26_1]]

	self.twistBlackCard = self.curtwistDate[self.twist_type_to_index[arg_26_1]].blackcard_type

	self.mainImg:loadTexture("mainScenebg/twist_bg/" .. var_26_0.img .. ".png")
	self.mainImg:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.isAlowOtherTouch then
			return
		end

		local var_27_0 = arg_27_0:getTouchBeganPosition()
		local var_27_1 = arg_27_0:getTouchEndPosition()

		if math.abs(var_27_0.x - var_27_1.x) > 50 then
			if var_27_0.x > var_27_1.x then
				self:switchTwistType("left")
			else
				self:switchTwistType("right")
			end
		else
			self.mainImg:setTouchEnabled(false)
			self:showTwistEggDrops(arg_26_1, arg_27_0)
		end
	end)

	if var_26_0.time then
		self.timePanel:setVisible(true)

		if var_0_33(var_26_0.time) then
			-- block empty
		else
			self.timePanel:setVisible(false)
		end
	else
		self.timePanel:setVisible(false)
	end

	if var_26_0.upcount2 then
		self.doubleCount1:setVisible(true)
		self.doubleCount2:setVisible(true)
		self.countPanel:setVisible(false)

		local var_26_1
		local var_26_2

		if var_26_0.uppos2 == 1 then
			var_26_2 = var_26_0.upcount
			var_26_1 = var_26_0.upcount2
		else
			var_26_2 = var_26_0.upcount2
			var_26_1 = var_26_0.upcount
		end

		if var_26_1 then
			self.doubleCount1:getChildByName("num"):setString(var_26_1)
		else
			self.doubleCount1:setVisible(false)
		end

		if var_26_2 then
			self.doubleCount2:getChildByName("num"):setString(var_26_2)
		else
			self.doubleCount2:setVisible(false)
		end
	elseif var_26_0.upcount then
		self.countPanel:setVisible(true)
		self.doubleCount1:setVisible(false)
		self.doubleCount2:setVisible(false)
		self.countPanel:getChildByName("num"):setString(var_26_0.upcount)

		local var_26_3 = 0

		for iter_26_0, iter_26_1 in pairs(var_26_0.upitems) do
			var_26_3 = var_26_3 + 1

			if var_26_3 > 2 then
				break
			end

			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img" .. var_26_3):loadTexture("role/wuji/" .. model_data[servant_data[item_data[iter_26_1].servant].modelid].head_image .. ".png")
		end

		if var_26_3 == 1 then
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):setPositionY(190)
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):setPositionX(47)
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):setScale(0.3)
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img2"):setVisible(false)

			if self.clipPanel:getChildByName("Panel_count"):getChildByName("line") then
				self.clipPanel:getChildByName("Panel_count"):getChildByName("line"):setVisible(false)
			end
		else
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):setPositionY(209)
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):setPositionX(37)
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img2"):setPositionX(57)
			print(self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):getPositionX())
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img1"):setScale(0.2)
			self.clipPanel:getChildByName("Panel_count"):getChildByName("q_img2"):setVisible(true)

			if not self.clipPanel:getChildByName("Panel_count"):getChildByName("line") then
				local var_26_4 = cc.DrawNode:create()

				var_26_4:drawSegment(cc.p(25, 175), cc.p(65, 205), 1, cc.c4f(1, 1, 1, 1))
				var_26_4:setName("line")
				self.clipPanel:getChildByName("Panel_count"):addChild(var_26_4)
			else
				self.clipPanel:getChildByName("Panel_count"):getChildByName("line"):setVisible(true)
			end
		end
	else
		self.countPanel:setVisible(false)
		self.doubleCount1:setVisible(false)
		self.doubleCount2:setVisible(false)
	end

	if arg_26_1 == 4 then
		self.clipPanel:getChildByName("Image_must"):setVisible(false)
		self.clipPanel:getChildByName("cover_bottom"):setVisible(false)
		self.clipPanel:getChildByName("items_list"):setVisible(true)

		if self.clipPanel:getChildByName("new_hand_must") then
			self.clipPanel:getChildByName("new_hand_must"):setVisible(false)
		end
	elseif arg_26_1 == 3 then
		self.clipPanel:getChildByName("Image_must"):setVisible(true)
		self.clipPanel:getChildByName("cover_bottom"):setVisible(false)
		self.clipPanel:getChildByName("items_list"):setVisible(false)

		if self.clipPanel:getChildByName("new_hand_must") then
			self.clipPanel:getChildByName("new_hand_must"):setVisible(false)
		end
	elseif twist_config_data[arg_26_1].stat == 3 then
		if not self.clipPanel:getChildByName("new_hand_must") then
			local var_26_5 = ccui.ImageView:create("TwistEgg/new_hand_must.png", var_0_22)

			var_26_5:setAnchorPoint(cc.p(0, 0.5))
			var_26_5:setPosition(10, 102)
			var_26_5:setName("new_hand_must")
			self.clipPanel:addChild(var_26_5)
		else
			self.clipPanel:getChildByName("new_hand_must"):setVisible(true)
		end

		self.clipPanel:getChildByName("Image_must"):setVisible(false)
		self.clipPanel:getChildByName("cover_bottom"):setVisible(false)
		self.clipPanel:getChildByName("items_list"):setVisible(false)
	elseif arg_26_1 == 101 then
		self.clipPanel:getChildByName("Image_must"):setVisible(false)
		self.clipPanel:getChildByName("cover_bottom"):setVisible(false)
		self.clipPanel:getChildByName("items_list"):setVisible(false)

		if self.clipPanel:getChildByName("new_hand_must") then
			self.clipPanel:getChildByName("new_hand_must"):setVisible(false)
		end
	else
		self.clipPanel:getChildByName("Image_must"):setVisible(true)
		self.clipPanel:getChildByName("cover_bottom"):setVisible(true)
		self.clipPanel:getChildByName("items_list"):setVisible(false)

		if self.clipPanel:getChildByName("new_hand_must") then
			self.clipPanel:getChildByName("new_hand_must"):setVisible(false)
		end
	end

	self:updateCostInfo(arg_26_1)

	if twist_config_data[arg_26_1].unlock_level and not level_manager:isPlayerPassLevel(twist_config_data[arg_26_1].unlock_level) then
		if not self.oneBnt:getChildByName("lockBg") then
			local var_26_6 = ccui.ImageView:create("zhucheng3/lockbg.png", var_0_22)

			var_26_6:setScale9Enabled(true)
			var_26_6:setCapInsets(cc.rect(1, 1, 2, 2))
			var_26_6:setContentSize(cc.size(self.oneBnt:getContentSize().width - 20, var_26_6:getContentSize().height))
			var_26_6:setName("lockBg")
			var_26_6:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_6:setPosition(cc.p(self.oneBnt:getContentSize().width / 2, 22))
			self.oneBnt:addChild(var_26_6)

			local var_26_7 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(twist_config_data[arg_26_1].unlock_level) .. "解锁", "fonts/number.ttf", 18)

			var_26_7:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_7:setName("label")
			var_26_7:setColor(cc.c3b(255, 163, 2))
			var_26_7:setPosition(cc.p(var_26_6:getContentSize().width / 2, var_26_6:getContentSize().height / 2))
			var_26_6:addChild(var_26_7, 1)
		else
			self.oneBnt:getChildByName("lockBg"):setVisible(true)
			self.oneBnt:getChildByName("lockBg"):getChildByName("label"):setString(level_manager:formatModeChapterLevelByPlayerLevel(twist_config_data[arg_26_1].unlock_level) .. "解锁")
		end

		if not self.tenBnt:getChildByName("lockBg") then
			local var_26_8 = ccui.ImageView:create("zhucheng3/lockbg.png", var_0_22)

			var_26_8:setScale9Enabled(true)
			var_26_8:setCapInsets(cc.rect(1, 1, 2, 2))
			var_26_8:setContentSize(cc.size(self.tenBnt:getContentSize().width - 20, var_26_8:getContentSize().height))
			var_26_8:setName("lockBg")
			var_26_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_8:setPosition(cc.p(self.tenBnt:getContentSize().width / 2, 22))
			self.tenBnt:addChild(var_26_8)

			local var_26_9 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(twist_config_data[arg_26_1].unlock_level) .. "解锁", "fonts/number.ttf", 18)

			var_26_9:setName("label")
			var_26_9:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_9:setColor(cc.c3b(255, 163, 2))
			var_26_9:setPosition(cc.p(var_26_8:getContentSize().width / 2, var_26_8:getContentSize().height / 2))
			var_26_8:addChild(var_26_9, 1)
		else
			self.tenBnt:getChildByName("lockBg"):setVisible(true)
			self.tenBnt:getChildByName("lockBg"):getChildByName("label"):setString(level_manager:formatModeChapterLevelByPlayerLevel(twist_config_data[arg_26_1].unlock_level) .. "解锁")
		end
	else
		if self.oneBnt:getChildByName("lockBg") then
			self.oneBnt:getChildByName("lockBg"):setVisible(false)
		end

		if self.tenBnt:getChildByName("lockBg") then
			self.tenBnt:getChildByName("lockBg"):setVisible(false)
		end
	end

	if twist_config_data[var_26_0.twistType].stat == 3 then
		if self:get_naive_stat(var_26_0.naivemark, "one") then
			ccui.Helper:seekWidgetByName(self.oneBnt, "one_des"):setVisible(false)
			self.oneBnt:setOpacity(100)
		elseif self:get_naive_stat(var_26_0.naivemark, "ten") then
			ccui.Helper:seekWidgetByName(self.tenBnt, "ten_des"):setVisible(false)
			self.tenBnt:setOpacity(100)
		end
	else
		self.tenBnt:setOpacity(255)
		self.tenBnt:setOpacity(255)
	end

	self:checkBntsAlert("oneBnt")
	self:checkBntsAlert("tenBnt")
	self:updateTimePanel()
	self:updateByBlackCard()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market")
	AnalyticManager.browseTwist(arg_26_1)
end

function AITwistLayer:updateByBlackCard()
	self.blackCardPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_blackcard")

	if self.curtwistDate[self.curTwistIndex].twistType == 101 then
		self.blackCardPanel:setVisible(false)
	elseif self.twistBlackCard == BLACK_CARD then
		self.blackCardPanel:loadTexture("TwistEgg/panel_blackcard_num.png", var_0_22)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market"):loadTextures("TwistEgg/goto_market_btn.png", nil, nil, var_0_22)

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market").shoptype = {
			"1-3",
			"1-11"
		}

		self.blackCardPanel:getChildByName("blackcard_num"):setString(item_manager:getItemNumber(BLACK_CARD))
	else
		self.blackCardPanel:loadTexture("TwistEgg/panel_blackcard_sp_num.png", var_0_22)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market"):loadTextures("TwistEgg/goto_market_sp_btn.png", nil, nil, var_0_22)

		ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market").shoptype = {
			"1-11",
			"1-3"
		}

		self.blackCardPanel:getChildByName("blackcard_num"):setString(item_manager:getItemNumber(BLACK_SP_CARD))
	end
end

function AITwistLayer:initSlidePoints()
	local var_29_0 = #self.curtwistDate

	for iter_29_0, iter_29_1 in pairs(self.curtwistDate) do
		local var_29_2 = iter_29_0 == 1 and ccui.ImageView:create("TwistEgg/yellow_point.png", var_0_22) or ccui.ImageView:create("TwistEgg/white_point.png", var_0_22)

		var_29_2:setName("point" .. iter_29_0)
		var_29_2:setPosition(320 + (iter_29_0 - (var_29_0 + 1) / 2) * 30, 340)
		self.pointsPanel:addChild(var_29_2)

		if iter_29_0 ~= 1 and iter_29_0 == var_29_0 then
			-- block empty
		end
	end

	function self.pointsPanel:updatePoints()
		for iter_35_0 = 1, var_29_0 do
			if iter_35_0 == self.curTwistIndex then
				self:getChildByName("point" .. iter_35_0):loadTexture("TwistEgg/yellow_point.png", var_0_22)
			else
				self:getChildByName("point" .. iter_35_0):loadTexture("TwistEgg/white_point.png", var_0_22)
			end
		end
	end

	self.pointsPanel:updatePoints()
end

function AITwistLayer:initSlideImg()
	self.imgScrollView:setInnerContainerSize(cc.size(#self.curtwistDate * 164, 92))

	for iter_36_0, iter_36_1 in pairs(self.curtwistDate) do
		local var_36_0 = ccui.Button:create("mainScenebg/twist_bg/small_" .. iter_36_1.img .. ".png", nil, "mainScenebg/twist_bg/small_" .. iter_36_1.img .. ".png")

		var_36_0:setAnchorPoint(cc.p(0, 0))
		var_36_0:setPosition(10 + (iter_36_0 - 1) * (var_36_0:getContentSize().width + 20), 0)
		var_36_0:setName("class_image" .. iter_36_0)

		var_36_0.twistIndex = iter_36_0

		self.imgScrollView:addChild(var_36_0)
		var_36_0:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_36_0.twistIndex == self.curTwistIndex then
				return
			end

			if twist_manager:isTwistNew(iter_36_1.twistType) then
				twist_manager:markTwistOld(iter_36_1.twistType)
			end

			if twist_manager:isTwistUpNew(iter_36_1.upid) then
				twist_manager:markUpOld(iter_36_1.upid)
			end

			self:switchTwistType(var_36_0.twistIndex)
		end)

		if self:checkIsHaveFreeTimes(iter_36_1.twistType) then
			AlertManager:add_alert_by_config(var_36_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(10, var_36_0:getContentSize().height - 20)
			})
		end

		if iter_36_1.upid then
			local var_36_1 = ccui.ImageView:create("TwistEgg/up_tips.png", var_0_22)

			var_36_1:setPosition(14, var_36_0:getContentSize().height)
			var_36_0:addChild(var_36_1)
		end
	end

	local var_36_2 = ccui.ImageView:create("TwistEgg/small_heightLight.png", var_0_22)

	self.imgScrollView:setVisible("heightLight")
	self.imgScrollView:addChild(var_36_2)

	function self.imgScrollView.switchImg(arg_38_0)
		local var_38_9000

		for iter_38_0 = 1, #self.curtwistDate do
			if self.curTwistIndex == iter_38_0 then
				var_36_2:setPosition(self.imgScrollView:getChildByName("class_image" .. iter_38_0):getPositionX() + var_38_9000, self.imgScrollView:getChildByName("class_image" .. iter_38_0).getPositionY(self.imgScrollView:getChildByName("class_image" .. iter_38_0):getContentSize().width / 2) + self.imgScrollView:getChildByName("class_image" .. iter_38_0):getContentSize().height / 2)
			end

			if not twist_manager:isTwistNew(self.curtwistDate[iter_38_0].twistType) then
				if twist_manager:isTwistUpNew(self.curtwistDate[iter_38_0].upid) then
					local var_38_1 = self.imgScrollView:getChildByName("class_image" .. iter_38_0)
					local var_38_2 = {
						ALERT_SHOW_NEW,
						""
					}

					var_38_2[3] = cc.p(23, self.imgScrollView:getChildByName("class_image" .. iter_38_0):getContentSize().height - 17)

					AlertManager:add_alert_by_config(var_38_1, true, var_38_2)

					goto label_38_0
				end
			end

			do
				local var_38_3 = self.imgScrollView:getChildByName("class_image" .. iter_38_0)
				local var_38_4 = {
					ALERT_SHOW_NEW,
					""
				}

				var_38_4[3] = cc.p(23, self.imgScrollView:getChildByName("class_image" .. iter_38_0):getContentSize().height - 17)

				AlertManager:add_alert_by_config(var_38_3, false, var_38_4)
			end

			::label_38_0::
		end
	end

	self.imgScrollView:switchImg()
end

local var_0_34 = 0.2

function AITwistLayer:switchTwistType(arg_39_1)
	local var_39_0
	local var_39_1

	if type(arg_39_1) == "string" then
		local var_39_2

		if arg_39_1 == "left" then
			var_39_2 = 1
			var_39_1 = 640
			var_39_0 = -640
		elseif arg_39_1 == "right" then
			var_39_2 = -1
			var_39_1 = -640
			var_39_0 = 640
		end

		self.curTwistIndex = self.curTwistIndex + nil

		if self.curTwistIndex > #self.curtwistDate then
			self.curTwistIndex = 1
		elseif self.curTwistIndex < 1 then
			self.curTwistIndex = #self.curtwistDate
		end
	elseif type(arg_39_1) == "number" then
		if arg_39_1 - self.curTwistIndex > 0 then
			var_39_1 = 640
			var_39_0 = -640
		elseif arg_39_1 - self.curTwistIndex < 0 then
			var_39_1 = -640
			var_39_0 = 640
		end

		self.curTwistIndex = arg_39_1
	end

	self.clipPanel:stopAllActions()
	self.clipPanel:runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(var_0_34), cc.MoveTo:create(var_0_34, cc.p(var_39_0, self.clipPanel:getPositionY()))), cc.CallFunc:create(function()
		self.pointsPanel:updatePoints()
		self.imgScrollView:switchImg()
		self:updateTwistType(self.curtwistDate[self.curTwistIndex].twistType)
		self.clipPanel:setPositionX(var_39_1)
	end), cc.Spawn:create(cc.FadeIn:create(var_0_34), cc.MoveTo:create(var_0_34, cc.p(0, self.clipPanel:getPositionY())))))
	self:UIHideShowAction()
end

function AITwistLayer:UIHideShowAction()
	local var_41_0 = 255
	local var_41_1 = 255

	if twist_config_data[self.curtwistDate[self.curTwistIndex].twistType].stat == 3 then
		if self:get_naive_stat(self.curtwistDate[self.curTwistIndex].naivemark, "one") then
			var_41_0 = 100
		elseif self:get_naive_stat(self.curtwistDate[self.curTwistIndex].naivemark, "ten") then
			var_41_1 = 100
		end
	end

	self.oneBnt:setTouchEnabled(false)
	self.oneBnt:stopAllActions()
	self.oneBnt:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_34), cc.DelayTime:create(var_0_34), cc.FadeTo:create(var_0_34, var_41_0), cc.CallFunc:create(function()
		self.oneBnt:setTouchEnabled(true)
	end)))
	self.tenBnt:setTouchEnabled(false)
	self.tenBnt:stopAllActions()
	self.tenBnt:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_34), cc.DelayTime:create(var_0_34), cc.FadeTo:create(var_0_34, var_41_1), cc.CallFunc:create(function()
		self.tenBnt:setTouchEnabled(true)
	end)))
	self.timePanel:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_34), cc.DelayTime:create(var_0_34), cc.FadeIn:create(var_0_34)))
	self.countPanel:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_34), cc.DelayTime:create(var_0_34), cc.FadeIn:create(var_0_34)))
	self.doubleCount1:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_34), cc.DelayTime:create(var_0_34), cc.FadeIn:create(var_0_34)))
	self.doubleCount2:runAction(cc.Sequence:create(cc.FadeOut:create(var_0_34), cc.DelayTime:create(var_0_34), cc.FadeIn:create(var_0_34)))
end

function AITwistLayer:updateTimePanel()
	if self.curtwistDate[self.curTwistIndex].twistType == 1 then
		self.freeCostImg:setVisible(true)
		self.paidCostImg:setVisible(false)
		self.costLabel:setString(self.freetime)
	else
		self.freeCostImg:setVisible(false)
		self.paidCostImg:setVisible(true)

		if self.curtwistDate[self.curTwistIndex].costtype > 2 then
			self.paidCostImg:loadTexture("equipment/" .. item_data[self.curtwistDate[self.curTwistIndex].costtype].image_id .. ".png")
			self.costLabel:setString(item_manager:getItemNumber(self.curtwistDate[self.curTwistIndex].costtype))
		elseif self.curtwistDate[self.curTwistIndex].costtype == 1 then
			self.paidCostImg:loadTexture("equipment/1000001.png")
			self.costLabel:setString(global_trans_number(playermodel.gold))
		end
	end
end

function AITwistLayer:updateCostInfo(arg_45_1)
	local var_45_0 = self.curtwistDate[self.twist_type_to_index[arg_45_1]]

	ccui.Helper:seekWidgetByName(self.oneBnt, "one_des"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.tenBnt, "ten_des"):setVisible(true)

	if arg_45_1 == var_0_25 then
		ccui.Helper:seekWidgetByName(self.oneBnt, "Label"):setString("一次免费次数")
		ccui.Helper:seekWidgetByName(self.tenBnt, "Label"):setString("十次免费次数")
	else
		local function var_45_1(arg_46_0, arg_46_1, arg_46_2)
			if arg_46_1 == "one" then
				arg_46_0:setString("今日免费" .. arg_46_2 .. "次")
			else
				arg_46_0:setString("今日免费" .. arg_46_2 .. "次")
			end
		end

		local function var_45_2(arg_47_0, arg_47_1, arg_47_2)
			if arg_47_1 == "one" then
				arg_47_0:setString("免费" .. arg_47_2 .. "次扩招")
			else
				arg_47_0:setString("免费" .. arg_47_2 .. "次十连")
			end
		end

		local function var_45_3(arg_48_0, arg_48_1)
			local var_48_0 = {
				"一",
				"二",
				"三",
				"四",
				"五",
				"六",
				"七",
				"八",
				"九",
				"十"
			}
			local var_48_1 = setmetatable({}, {
				__index = function(arg_49_0, arg_49_1)
					if arg_49_1 <= 10 then
						return var_48_0[arg_49_1] .. ""
					else
						return arg_49_1 .. ""
					end
				end
			})

			if arg_48_1 == "one" then
				if not var_45_0.costone then
					arg_48_0:getParent():setVisible(false)

					return
				end

				if var_45_0.costtype > 2 then
					arg_48_0:setString(var_48_1[var_45_0.costone] .. "制造因子")
				elseif var_45_0.costtype == 1 then
					arg_48_0:setString(var_45_0.costone .. L_GOLD)
				end
			else
				if not var_45_0.costten then
					arg_48_0:getParent():setVisible(false)

					return
				end

				if var_45_0.costtype > 2 then
					arg_48_0:setString(var_48_1[var_45_0.costten] .. "制造因子")
				elseif var_45_0.costtype == 1 then
					arg_48_0:setString(var_45_0.costten .. L_GOLD)
				end
			end
		end

		if var_45_0.dailyfreeforone and var_45_0.dailyfreeforone > 0 then
			var_45_1(ccui.Helper:seekWidgetByName(self.oneBnt, "Label"), "one", var_45_0.dailyfreeforone)
		elseif var_45_0.totalfreeforone and var_45_0.totalfreeforone > 0 then
			var_45_2(ccui.Helper:seekWidgetByName(self.oneBnt, "Label"), "one", var_45_0.totalfreeforone)
		else
			var_45_3(ccui.Helper:seekWidgetByName(self.oneBnt, "Label"), "one")
		end

		if var_45_0.dailyfreeforten and var_45_0.dailyfreeforten > 0 then
			var_45_1(ccui.Helper:seekWidgetByName(self.tenBnt, "Label"), "ten", var_45_0.dailyfreeforten)
		elseif var_45_0.totalfreeforten and var_45_0.totalfreeforten > 0 then
			var_45_2(ccui.Helper:seekWidgetByName(self.tenBnt, "Label"), "ten", var_45_0.totalfreeforten)
		else
			var_45_3(ccui.Helper:seekWidgetByName(self.tenBnt, "Label"), "ten")
		end
	end

	if var_45_0.naivemark then
		self.oneBnt:setVisible(false)
		self.tenBnt:setPositionX(320)
	else
		self.oneBnt:setVisible(true)
		self.tenBnt:setPositionX(500)
	end
end

local var_0_35 = "mainScenebg/bg.jpg"
local var_0_36 = "mainScenebg/resultbg.jpg"
local var_0_37 = "spine/ui/twist/twist"
local var_0_38 = "spine/ui/twist/fangkuai"
local var_0_40 = cc.size(514, 815)
local var_0_44 = {
	"public/rarity/r_long.png",
	"public/rarity/sr_long.png",
	"public/rarity/ur_long.png",
	"public/rarity/mr_long.png",
	"public/rarity/sp_long.png"
}
local var_0_45 = {
	"TwistEgg/star.png",
	"TwistEgg/star_dark.png"
}
local var_0_46 = {
	{
		"r1",
		"r2"
	},
	{
		"sr1",
		"sr2"
	},
	{
		"ur1",
		"ur2"
	},
	{
		"mr1",
		"mr2"
	},
	{
		"sp1",
		"sp2"
	}
}
local var_0_47 = {
	{
		"HQ-R",
		"HQ-R-R"
	},
	{
		"HQ-SR",
		"HQ-SR-R"
	},
	{
		"HQ-UR",
		"HQ-UR-R"
	},
	{
		"HQ-MR",
		"HQ-MR-R"
	},
	{
		"HQ-SP",
		"HQ-SP-R"
	}
}

local function var_0_48()
	local var_50_0 = ccui.ImageView:create(var_0_44[1], var_0_22)

	var_50_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_50_0:setVisible(false)

	return var_50_0
end

local function var_0_49()
	return (ccui.ImageView:create())
end

local function var_0_50()
	local var_52_0 = cc.Label:createWithTTF("", FONT_NAME, 40)

	var_52_0:setAnchorPoint(cc.p(0, 0.5))
	var_52_0:enableGlow(cc.c4b(30, 170, 255, 150), 2)
	var_52_0:setVisible(false)

	return var_52_0
end

local function var_0_51()
	local var_53_0 = cc.Label:createWithTTF("", FONT_DES, 20)

	var_53_0:setAnchorPoint(cc.p(0, 0.5))
	var_53_0:setVisible(false)

	return var_53_0
end

local function var_0_52()
	local var_54_0 = ccui.ImageView:create()

	var_54_0:setScale(0.9)

	return var_54_0
end

local function var_0_53()
	local var_55_0 = cc.Label:createWithTTF("", FONT_NAME, 50)

	var_55_0:enableGlow(cc.c4b(0, 205, 255, 150), 2)

	return var_55_0
end

local function var_0_54()
	local var_56_0 = cc.Label:createWithTTF("", FONT_NAME, 50)

	var_56_0:enableGlow(cc.c4b(250, 187, 15, 150), 2)

	return var_56_0
end

local var_0_55 = {
	cc.p(118, 213 + GameDisplay.fix_y),
	cc.p(118, 103 + GameDisplay.fix_y)
}

local function var_0_56(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.resultInfosPanel:getChildByName("skillicon" .. arg_57_1)

	if not var_57_0 then
		var_57_0 = ccui.ImageView:create()

		var_57_0:setName("skillicon" .. arg_57_1)
		var_57_0:setScale(0.85)
		var_57_0:setPosition(var_0_55[arg_57_1])
		arg_57_0.resultInfosPanel:addChild(var_57_0)
	end

	return var_57_0
end

local var_0_57 = {
	cc.p(168, 240 + GameDisplay.fix_y),
	cc.p(168, 130 + GameDisplay.fix_y)
}

local function var_0_58(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.resultInfosPanel:getChildByName("skillname" .. arg_58_1)

	if not var_58_0 then
		var_58_0 = cc.Label:createWithTTF("", FONT_NAME, 35)

		var_58_0:setName("skillname" .. arg_58_1)
		var_58_0:setAnchorPoint(cc.p(0, 0.5))
		var_58_0:setPosition(var_0_57[arg_58_1])
		arg_58_0.resultInfosPanel:addChild(var_58_0)
	end

	return var_58_0
end

local var_0_59 = {
	cc.p(172, 220 + GameDisplay.fix_y),
	cc.p(172, 110 + GameDisplay.fix_y)
}

local function var_0_60(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.resultInfosPanel:getChildByName("skilldes" .. arg_59_1)

	if not var_59_0 then
		var_59_0 = cc.Label:createWithTTF("", FONT_DES, 20)

		var_59_0:setName("skilldes" .. arg_59_1)
		var_59_0:setAnchorPoint(cc.p(0, 1))
		var_59_0:setDimensions(350, 0)
		var_59_0:setPosition(var_0_59[arg_59_1])
		arg_59_0.resultInfosPanel:addChild(var_59_0)
	end

	return var_59_0
end

local var_0_61 = {
	[kITEM_HERO] = function(arg_60_0, arg_60_1)
		local var_60_0 = servant_data[item_data[arg_60_1.dropid].servant].modelid
		local var_60_1 = arg_60_0.resultPanel:getChildByName("icon")

		if not var_60_1 then
			var_60_1 = cc.Sprite:create()

			var_60_1:setAnchorPoint(cc.p(0.5, 0))
			var_60_1:setVisible(false)
			var_60_1:setName("icon")
			arg_60_0.resultPanel:addChild(var_60_1)
		end

		local var_60_2 = model_data[servant_data[item_data[arg_60_1.dropid].servant].modelid].egg_offset_x or 0
		local var_60_3 = model_data[servant_data[item_data[arg_60_1.dropid].servant].modelid].egg_offset_y or 0

		var_60_1:setTexture("role/" .. model_data[servant_data[item_data[arg_60_1.dropid].servant].modelid].role_image .. ".png")
		var_60_1:setPosition(cc.p(315 + var_60_2, 190 + GameDisplay.fix_y + var_60_3))
		var_60_1:setScale(0.8)
		var_60_1:setVisible(false)
		var_60_1:setOpacity(0)

		local var_60_4 = arg_60_0.resultInfosPanel:getChildByName("rarity")

		if not var_60_4 then
			var_60_4 = var_0_48()

			var_60_4:setName("rarity")
			arg_60_0.resultInfosPanel:addChild(var_60_4)
		end

		local var_60_5 = servant_data[item_data[arg_60_1.dropid].servant].roll_rarity or 1

		var_60_4:loadTexture(var_0_44[var_60_5], var_0_22)
		var_60_4:setPosition(cc.p(130, 181 + GameDisplay.fix_y))
		var_60_4:setOpacity(0)
		var_60_4:setVisible(false)

		local var_60_6 = arg_60_0.resultInfosPanel:getChildByName("roleattricon")

		if not var_60_6 then
			var_60_6 = var_0_49()

			var_60_6:setName("roleattricon")
			var_60_6:setPosition(cc.p(525, 120 + GameDisplay.fix_y))
			arg_60_0.resultInfosPanel:addChild(var_60_6)
		end

		var_60_6:loadTexture(ATTRICONPATH[global_get_model_attr(servant_data[item_data[arg_60_1.dropid].servant].modelid)], var_0_22)
		var_60_6:setOpacity(0)
		var_60_6:setVisible(false)

		local var_60_7 = arg_60_0.resultInfosPanel:getChildByName("name")

		if not var_60_7 then
			var_60_7 = var_0_50()

			var_60_7:setName("name")
			arg_60_0.resultInfosPanel:addChild(var_60_7)
		end

		var_60_7:setPosition(cc.p(90, 124 + GameDisplay.fix_y))
		var_60_7:setString(major_factor_data[servant_data[item_data[arg_60_1.dropid].servant].major].easy_name)
		var_60_7:setOpacity(0)
		var_60_7:setVisible(false)

		local var_60_8 = arg_60_0.resultInfosPanel:getChildByName("roledes")

		if not var_60_8 then
			var_60_8 = var_0_51()

			var_60_8:setName("roledes")
			arg_60_0.resultInfosPanel:addChild(var_60_8)
		end

		var_60_8:setString(GlobalShowRoleSaying(servant_data[item_data[arg_60_1.dropid].servant].modelid, ROLE_SOUND_TYPE.home) or major_factor_data[servant_data[item_data[arg_60_1.dropid].servant].major].descrip)
		var_60_8:setMaxLineWidth(512)
		var_60_8:setPosition(cc.p(97, 64 + GameDisplay.fix_y))
		var_60_8:setOpacity(0)
		var_60_8:setVisible(false)
		arg_60_0.skipBnt:setVisible(false)
		arg_60_0.resultAni:setVisible(true)
		arg_60_0.resultAni:play(var_0_46[var_60_5][1], false)
		arg_60_0.resultAni:addAnimation(var_0_46[var_60_5][2])
		var_60_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_60_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			l2utils:shakeNode(var_60_1, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_60_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_60_1)
			GlobalPlayRoleSound(var_60_0, ROLE_SOUND_TYPE.home)
		end)))
		var_60_4:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_60_6:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_60_7:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_60_8:runAction(cc.Sequence:create(cc.DelayTime:create(3.6666666666666665), cc.Show:create(), cc.FadeIn:create(0.5)))

		local var_60_9 = arg_60_0.resultPanel:getChildByName("blackcardinfo")

		if arg_60_0.lastTwistBlackCard == BLACK_CARD then
			var_60_9:loadTexture("TwistEgg/panel_blackcard_bg2.png", var_0_22)
			var_60_9:getChildByName("num"):setString(string.format("魂卡x%d", arg_60_1.dropnum - 1))
			var_60_9:getChildByName("num"):setScale(1)
		else
			var_60_9:loadTexture("TwistEgg/panel_blackcard_sp_bg2.png", var_0_22)
			var_60_9:getChildByName("num"):setString(string.format("SP魂卡x%d", arg_60_1.dropnum - 1))
			var_60_9:getChildByName("num"):setScale(0.91)
		end

		var_60_9:setVisible(false)
		var_60_9:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create()))
		arg_60_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_60_0.resultTouchEnabled = true
		end)))
		var_60_1:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end,
	[kITEM_HORCRUX] = function(arg_65_0, arg_65_1)
		local var_65_0 = arg_65_1.entityid
		local var_65_1 = arg_65_0.resultPanel:getChildByName("icon")

		if not var_65_1 then
			var_65_1 = cc.Sprite:create()

			var_65_1:setAnchorPoint(cc.p(0.5, 0))
			var_65_1:setVisible(false)
			var_65_1:setName("icon")
			arg_65_0.resultPanel:addChild(var_65_1)
		end

		var_65_1:setTexture("role1/" .. model_data[horcrux_data[arg_65_1.dropid].model].cute_Q .. ".png")
		var_65_1:setPosition(cc.p(315, 525 + GameDisplay.fix_y))
		var_65_1:setScale(1)
		var_65_1:setOpacity(0)
		var_65_1:setVisible(false)

		local var_65_2 = arg_65_0.resultInfosPanel:getChildByName("rarity")

		if not var_65_2 then
			var_65_2 = var_0_48()

			var_65_2:setName("rarity")
			arg_65_0.resultInfosPanel:addChild(var_65_2)
		end

		local var_65_3 = horcrux_data[arg_65_1.dropid].rarity or 1

		var_65_2:loadTexture(var_0_44[var_65_3], var_0_22)
		var_65_2:setPosition(cc.p(210, 985 + GameDisplay.fix_y))
		var_65_2:setOpacity(0)
		var_65_2:setVisible(false)

		local var_65_4 = arg_65_0.resultInfosPanel:getChildByName("horcruxattricon")

		if not var_65_4 then
			var_65_4 = var_0_52()

			var_65_4:setName("horcruxattricon")
			var_65_4:setPosition(cc.p(42, 416 + GameDisplay.fix_y))
			arg_65_0.resultInfosPanel:addChild(var_65_4)
		end

		var_65_4:loadTexture(ATTRICONPATH[global_get_model_attr(horcrux_manager:getHorcruxModel(arg_65_1.entityid))], var_0_22)
		var_65_4:setOpacity(0)
		var_65_4:setVisible(false)

		local var_65_5 = arg_65_0.resultInfosPanel:getChildByName("name")

		if not var_65_5 then
			var_65_5 = var_0_50()

			var_65_5:setName("name")
			arg_65_0.resultInfosPanel:addChild(var_65_5)
		end

		var_65_5:setPosition(cc.p(75, 420 + GameDisplay.fix_y))
		var_65_5:setString(horcrux_manager:getHorcruxName(arg_65_1.entityid))
		var_65_5:setOpacity(0)
		var_65_5:setVisible(false)

		local var_65_6 = arg_65_0.resultInfosPanel:getChildByName("dfaclabel")

		if not var_65_6 then
			var_65_6 = var_0_53()

			var_65_6:setName("dfaclabel")
			arg_65_0.resultInfosPanel:addChild(var_65_6)
		end

		var_65_6:setPosition(cc.p(250, 310 + GameDisplay.fix_y))
		var_65_6:setString("")
		var_65_6:setVisible(false)

		local var_65_7 = arg_65_0.resultInfosPanel:getChildByName("hfaclabel")

		if not var_65_7 then
			var_65_7 = var_0_54()

			var_65_7:setName("hfaclabel")
			arg_65_0.resultInfosPanel:addChild(var_65_7)
		end

		var_65_7:setPosition(cc.p(540, 310 + GameDisplay.fix_y))
		var_65_7:setString("")
		var_65_7:setVisible(false)

		local var_65_8 = horcrux_manager:getHorcruxSkills(arg_65_1.entityid)
		local var_65_9 = {}
		local var_65_10 = {}
		local var_65_11 = {}

		for iter_65_0 = 1, 2 do
			var_65_9[iter_65_0] = var_0_56(arg_65_0, iter_65_0)
			var_65_10[iter_65_0] = var_0_58(arg_65_0, iter_65_0)
			var_65_11[iter_65_0] = var_0_60(arg_65_0, iter_65_0)

			if var_65_8[iter_65_0] then
				local var_65_12 = var_65_8[iter_65_0]

				var_65_9[iter_65_0]:loadTexture((total_skill_data[var_65_8[iter_65_0]].icon or nil) and ("skill_new/skill/" .. total_skill_data[var_65_12].icon .. ".png" or "public/rolebg/skill_frame_bg.png"), var_0_22)
				var_65_10[iter_65_0]:setString(total_skill_data[var_65_12].name)
				var_65_11[iter_65_0]:setString(total_skill_data[var_65_12].description)
			else
				var_65_9[iter_65_0]:loadTexture("public/rolebg/skill_frame_bg.png", var_0_22)
				var_65_10[iter_65_0]:setString("")
				var_65_11[iter_65_0]:setString("")
			end

			var_65_9[iter_65_0]:setOpacity(0)
			var_65_9[iter_65_0]:setVisible(false)
			var_65_10[iter_65_0]:setOpacity(0)
			var_65_10[iter_65_0]:setVisible(false)
			var_65_11[iter_65_0]:setOpacity(0)
			var_65_11[iter_65_0]:setVisible(false)
		end

		local var_65_13 = horcrux_manager:getHorcruxStarLevel(arg_65_1.entityid)

		arg_65_0.skipBnt:setVisible(false)
		arg_65_0.resultAni:setVisible(true)
		arg_65_0.resultAni:play(var_0_47[var_65_3][1] .. var_65_13, false)

		if var_65_13 == 1 then
			var_65_13 = ""
		end

		arg_65_0.resultAni:addAnimation(var_0_47[var_65_3][2] .. var_65_13)
		var_65_1:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_65_1:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.CallFunc:create(function()
			l2utils:shakeNode(var_65_1, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_65_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.466666666666667), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_65_1)
		end)))
		var_65_2:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_65_4:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.2)))
		var_65_5:runAction(cc.Sequence:create(cc.DelayTime:create(1.6666666666666667), cc.Show:create(), cc.FadeIn:create(0.2)))
		var_65_6:runAction(cc.Sequence:create(cc.DelayTime:create(2.2333333333333334), cc.Show:create(), cc.CallFunc:create(function()
			local var_68_0 = horcrux_manager:getHorcruxDamageFac(var_65_0) / 100

			l2utils:numberlabelRandomAction(var_65_6, var_68_0 >= 10 and string.format("%.1f", var_68_0) or string.format("%.1f", var_68_0), 1, "outQuad", 20)
		end)))
		var_65_7:runAction(cc.Sequence:create(cc.DelayTime:create(2.2333333333333334), cc.Show:create(), cc.CallFunc:create(function()
			l2utils:numberlabelRandomAction(var_65_7, tostring(horcrux_manager:getHorcruxHpFac(var_65_0) / 100), 1, "outQuad", 20)
		end)))

		for iter_65_1 = 1, 2 do
			var_65_9[iter_65_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.3333333333333335), cc.Show:create(), cc.FadeIn:create(0.1)))
			var_65_10[iter_65_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.533333333333333), cc.Show:create(), cc.FadeIn:create(0.5)))
			var_65_11[iter_65_1]:runAction(cc.Sequence:create(cc.DelayTime:create(2.533333333333333), cc.Show:create(), cc.FadeIn:create(0.5)))
		end

		arg_65_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_65_0.resultTouchEnabled = true
		end)))
		var_65_1:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end,
	[KITEM_AI_MONSTER] = function(arg_72_0, arg_72_1)
		local var_72_0 = aiattack_manager:getMonsterData(item_data[arg_72_1.dropid].monster).modelid
		local var_72_1 = arg_72_0.resultPanel:getChildByName("icon")

		if not var_72_1 then
			var_72_1 = cc.Sprite:create()

			var_72_1:setAnchorPoint(cc.p(0.5, 0))
			var_72_1:setVisible(false)
			var_72_1:setName("icon")
			arg_72_0.resultPanel:addChild(var_72_1)
		end

		local var_72_2 = model_data[var_72_0].egg_offset_x or 0
		local var_72_3 = model_data[var_72_0].egg_offset_y or 0

		var_72_1:setTexture("role/" .. model_data[var_72_0].role_image .. ".png")
		var_72_1:setPosition(cc.p(315 + var_72_2, 190 + GameDisplay.fix_y + var_72_3))
		var_72_1:setScale(0.8)
		var_72_1:setVisible(false)
		var_72_1:setOpacity(0)

		local var_72_4 = arg_72_0.resultInfosPanel:getChildByName("roleattricon")

		if not var_72_4 then
			var_72_4 = var_0_49()

			var_72_4:setName("roleattricon")
			var_72_4:setPosition(cc.p(525, 120 + GameDisplay.fix_y))
			arg_72_0.resultInfosPanel:addChild(var_72_4)
		end

		var_72_4:loadTexture(ATTRICONPATH[global_get_model_attr(var_72_0)], var_0_22)
		var_72_4:setOpacity(0)
		var_72_4:setVisible(false)

		local var_72_5 = arg_72_0.resultInfosPanel:getChildByName("name")

		if not var_72_5 then
			var_72_5 = var_0_50()

			var_72_5:setName("name")
			arg_72_0.resultInfosPanel:addChild(var_72_5)
		end

		var_72_5:setPosition(cc.p(90, 124 + GameDisplay.fix_y))
		var_72_5:setString(model_data[var_72_0].name)
		var_72_5:setOpacity(0)
		var_72_5:setVisible(false)

		local var_72_6 = arg_72_0.resultInfosPanel:getChildByName("roledes")

		if not var_72_6 then
			var_72_6 = var_0_51()

			var_72_6:setName("roledes")
			arg_72_0.resultInfosPanel:addChild(var_72_6)
		end

		var_72_6:setString(item_data[arg_72_1.dropid].intro or "我...梦到了?? 电子羊...")
		var_72_6:setMaxLineWidth(512)
		var_72_6:setPosition(cc.p(97, 64 + GameDisplay.fix_y))
		var_72_6:setOpacity(0)
		var_72_6:setVisible(false)
		arg_72_0.skipBnt:setVisible(false)
		arg_72_0.resultAni:setVisible(true)
		arg_72_0.resultAni:play(var_0_46[var_72_7][1], false)
		arg_72_0.resultAni:addAnimation(var_0_46[var_72_7][2])
		var_72_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_72_1:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
			l2utils:shakeNode(var_72_1, {
				scanlinethreshold = 0.025,
				scanlinedrift = 5,
				waitframe = 0,
				shakeframe = 24,
				driftpixel = 0,
				scanlinedriftfac = 5,
				restoreframe = 24,
				driftfac = 3
			})
		end)))
		var_72_1:runAction(cc.Sequence:create(cc.DelayTime:create(2.8), cc.CallFunc:create(function()
			l2utils:removeNodeShake(var_72_1)
		end)))
		var_72_4:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_72_5:runAction(cc.Sequence:create(cc.DelayTime:create(3.2666666666666666), cc.Show:create(), cc.FadeIn:create(0.5)))
		var_72_6:runAction(cc.Sequence:create(cc.DelayTime:create(3.6666666666666665), cc.Show:create(), cc.FadeIn:create(0.5)))

		local var_72_9 = arg_72_0.resultPanel:getChildByName("blackcardinfo")

		if arg_72_0.lastTwistBlackCard == BLACK_CARD then
			var_72_9:loadTexture("TwistEgg/panel_blackcard_bg2.png", var_0_22)
			var_72_9:getChildByName("num"):setString(string.format("魂卡x%d", arg_72_1.dropnum - 1))
			var_72_9:getChildByName("num"):setScale(1)
		else
			var_72_9:loadTexture("TwistEgg/panel_blackcard_sp_bg2.png", var_0_22)
			var_72_9:getChildByName("num"):setString(string.format("SP魂卡x%d", arg_72_1.dropnum - 1))
			var_72_9:getChildByName("num"):setScale(0.91)
		end

		var_72_9:setVisible(false)
		arg_72_0.skipBnt:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.Show:create(), cc.CallFunc:create(function()
			arg_72_0.resultTouchEnabled = true
		end)))
		var_72_1:runAction(cc.Sequence:create(cc.DelayTime:create(7), cc.CallFunc:create(function()
			audio_manager:playeffectMusic(TWIST_CYCLE_EFFECT, true)
		end)))
	end
}

local function var_0_62(arg_80_0)
	if arg_80_0.resultPanel:getChildByName("icon") then
		arg_80_0.resultPanel:getChildByName("icon"):stopAllActions()
		l2utils:removeNodeShake(arg_80_0.resultPanel:getChildByName("icon"))
		arg_80_0.resultPanel:getChildByName("icon"):setVisible(false)
	end

	arg_80_0.resultPanel:getChildByName("blackcardinfo"):setVisible(false)

	for iter_80_0, iter_80_1 in pairs(arg_80_0.resultInfosPanel:getChildren()) do
		iter_80_1:stopAllActions()
		iter_80_1:setVisible(false)
	end
end

setmetatable(var_0_61, {
	__index = function(arg_77_0, arg_77_1)
		return function(arg_78_0, arg_78_1)
			local var_78_0 = arg_78_0.resultPanel:getChildByName("icon")

			if not var_78_0 then
				var_78_0 = cc.Sprite:create()

				var_78_0:setAnchorPoint(cc.p(0.5, 0))
				var_78_0:setVisible(false)
				var_78_0:setName("icon")
				arg_78_0.resultPanel:addChild(var_78_0)
			end

			var_78_0:setTexture("equipment/" .. item_data[arg_78_1.dropid].image_id .. ".png")
			var_78_0:setPosition(cc.p(257, 400 - var_78_0:getContentSize().height / 2))
			arg_78_0.resultAni:setVisible(false)
			var_78_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create()))
			var_78_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				arg_78_0.resultTouchEnabled = true
			end)))
		end
	end,
	__call = function(self, arg_81_1, ...)
		var_0_62(...)
		self[arg_81_1](...)
	end
})

local var_0_63 = setmetatable({
	[1] = false,
	[4] = false
}, {
	__index = function(arg_82_0, arg_82_1)
		return true
	end
})

function AITwistLayer:show_twist_result(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	self.showPanel:setVisible(true)
	self.resultBg:setVisible(true)
	self:cleanShowResultPanelEvent()
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)

	if var_0_63[arg_83_1] then
		self:startTwistResultAni(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	else
		self:showTwistFinalResult(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	end
end

local function var_0_64()
	local var_84_0 = {}
	local var_84_1 = -1

	for iter_84_0 = 1, 10 do
		var_84_0[iter_84_0] = cc.p(320 + var_84_1 * 200, 950 - 0 * 250 + GameDisplay.fix_y)
		var_84_1 = var_84_1 + 1

		if var_84_1 > 1 then
			var_84_1 = -1
		end
	end

	return var_84_0
end

local function var_0_65(arg_85_0)
	if item_data[arg_85_0].bag_item_type == kITEM_HERO then
		return servant_data[item_data[arg_85_0].servant].roll_rarity > 3
	elseif item_data[arg_85_0].bag_item_type == kITEM_HORCRUX then
		return item_data[arg_85_0].rarity > 3
	elseif item_data[arg_85_0].bag_item_type == KITEM_AI_MONSTER then
		if item_data[arg_85_0].ai_monster_level and item_data[arg_85_0].ai_monster_level >= 2 then
			return true
		end
	else
		return false
	end
end

local function var_0_66(arg_86_0)
	if item_data[arg_86_0].bag_item_type == kITEM_HERO then
		return servant_data[item_data[arg_86_0].servant].roll_rarity >= 3
	elseif item_data[arg_86_0].bag_item_type == kITEM_HORCRUX then
		return item_data[arg_86_0].rarity > 2
	elseif item_data[arg_86_0].bag_item_type == KITEM_AI_MONSTER then
		return true
	else
		return item_data[arg_86_0].equip_quality >= 5
	end
end

local function var_0_67(arg_87_0)
	if item_data[arg_87_0].bag_item_type == kITEM_HERO then
		if servant_data[item_data[arg_87_0].servant].roll_rarity >= 5 then
			return true
		end
	elseif item_data[arg_87_0].bag_item_type == kITEM_HORCRUX and item_data[arg_87_0].rarity >= 5 then
		return true
	end

	return false
end

function AITwistLayer:startTwistResultAni(arg_88_1, arg_88_2, arg_88_3, arg_88_4)
	self:cleanTwistRectPanel()
	self.resultBg:setTexture(var_0_36)
	self.twistingRectPanel:setVisible(true)
	self.skipBnt:setVisible(false)

	local var_88_0 = #arg_88_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_64()

	local function var_88_1(arg_89_0)
		local var_89_0 = self.twistingRectPanel:getChildByName("rect" .. arg_89_0)

		if not var_89_0 then
			var_89_0 = L2Skeleton:create(var_0_38 .. ".json", var_0_38 .. ".atlas", nil, true)

			var_89_0:refreshSkeleton()
			var_89_0:setName("rect" .. arg_89_0)
			self.twistingRectPanel:addChild(var_89_0)
		end

		return var_89_0
	end

	local function var_88_2(arg_90_0)
		return (item_data[arg_90_0].bag_item_type == kITEM_HERO and "role_" or "") .. (var_0_67(arg_90_0) and "red" or var_0_65(arg_90_0) and "orange" or var_0_66(arg_90_0) and "purple" or "blue")
	end

	local function var_88_3()
		return coroutine.create(function()
			for iter_92_0 = 1, #arg_88_2 do
				local var_92_0 = var_88_1(iter_92_0)

				var_92_0:setPosition(var_88_0[iter_92_0])
				var_92_0:setVisible(true)

				local var_92_2 = var_88_2(arg_88_2[iter_92_0].itemid ~= arg_88_2[iter_92_0].dropid and arg_88_2[iter_92_0].itemid == 1500001 and arg_88_2[iter_92_0].dropid or arg_88_2[iter_92_0].itemid)

				var_92_0:play(var_92_2, false)
				var_92_0:addAnimation(var_92_2 .. "2")
				audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				coroutine.yield(iter_92_0)
			end

			for iter_92_1 = 1, 3 do
				coroutine.yield("wait")
			end

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_88_4 = var_88_3()

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_93_0)
		if not var_88_4 then
			var_88_4 = var_88_3()

			return
		end

		local var_93_0, var_93_1 = coroutine.resume(var_88_4)

		assert(var_93_0, var_93_1)

		if var_93_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_88_4 = nil

			self.twistingRectPanel:setVisible(false)

			if var_0_63[arg_88_1] then
				self:showTwistItemsInfoAni(arg_88_1, arg_88_2, arg_88_3, arg_88_4)
			else
				self:showTwistFinalResult(arg_88_1, arg_88_2, arg_88_3, arg_88_4)
			end
		end
	end, 0.2, false)
end

function AITwistLayer:showTwistItemsInfoAni(arg_94_1, arg_94_2, arg_94_3, arg_94_4)
	self.resultBg:setTexture(var_0_35)
	self.resultPanel:setVisible(true)
	self.resultInfosPanel:setVisible(true)
	self.skipBnt:setVisible(true)
	var_0_62(self)

	local var_94_0 = (function()
		return coroutine.create(function()
			for iter_96_0 = 1, #arg_94_2 do
				var_0_61(item_data[arg_94_2[iter_96_0].dropid].bag_item_type, self, arg_94_2[iter_96_0])
				audio_manager:stopAllEffects()
				audio_manager:playeffectMusic(TWIST_CHANGE_EFFECT)
				coroutine.yield(iter_96_0)
			end

			audio_manager:stopAllEffects()

			return "end"
		end)
	end)()
	local var_94_1, var_94_2 = coroutine.resume(var_94_0)

	assert(var_94_1, var_94_2)
	self.showPanel:addTouchEventListener(function(arg_97_0, arg_97_1)
		if arg_97_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		if not var_94_0 then
			return
		end

		self.resultTouchEnabled = false

		local var_97_0, var_97_1 = coroutine.resume(var_94_0)

		assert(var_97_0, var_97_1)

		if var_97_1 == "end" then
			var_94_0 = nil

			self.resultAni:setVisible(false)
			self.resultPanel:setVisible(false)
			self.resultInfosPanel:setVisible(false)
			var_0_62(self)
			self:showTwistFinalResult(arg_94_1, arg_94_2, arg_94_3, arg_94_4)
		end
	end)
	self.skipBnt:addTouchEventListener(function(arg_98_0, arg_98_1)
		if arg_98_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		self.resultTouchEnabled = false
		var_94_0 = nil

		self.resultAni:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		var_0_62(self)
		audio_manager:stopAllEffects()
		self:showTwistFinalResult(arg_94_1, arg_94_2, arg_94_3, arg_94_4)
	end)
end

local var_0_68 = {
	"public/box/new_item_bg1.png",
	"public/box/new_item_bg2.png",
	"public/box/new_item_bg3.png",
	"public/box/new_item_bg4.png",
	"public/box/new_item_bg5.png",
	"public/box/new_item_bg6.png"
}
local var_0_69 = {
	wind = "TwistEgg/bg_wind.png",
	water = "TwistEgg/bg_water.png",
	fire = "TwistEgg/bg_fire.png",
	null = "TwistEgg/bg_wind.png",
	light = "TwistEgg/bg_light.png",
	dark = "TwistEgg/bg_dark.png",
	imaginary = "TwistEgg/bg_wind.png"
}
local var_0_70 = "TwistEgg/shine_frame.png"
local var_0_71 = "TwistEgg/purple_frame.png"
local var_0_72 = "TwistEgg/red_frame.png"
local var_0_73 = {
	"TwistEgg/btn_sure.png",
	"TwistEgg/btn_sure_on.png"
}
local var_0_74 = {
	[kITEM_HERO] = function(arg_99_0, arg_99_1)
		local var_99_1 = global_get_model_attr(servant_data[item_data[arg_99_0.dropid].servant].modelid)
		local var_99_2 = ccui.ImageView:create(var_0_69[var_99_1], var_0_22)
		local var_99_3 = ccui.Layout:create()

		var_99_3:setClippingEnabled(true)
		var_99_3:setContentSize(var_99_2:getContentSize().width - 8, var_99_2:getContentSize().height - 8)
		var_99_3:setPosition(cc.p(4, 4))
		var_99_3:setCascadeOpacityEnabled(true)
		var_99_3:setName("clip")
		var_99_2:addChild(var_99_3)

		local var_99_4 = cc.Sprite:create("role/shop_image/" .. model_data[servant_data[item_data[arg_99_0.dropid].servant].modelid].role_image .. ".png")

		var_99_4:setAnchorPoint(cc.p(0.5, 0))
		var_99_4:setScale(0.9)
		var_99_4:setPosition(cc.p(var_99_3:getContentSize().width / 2, -100))
		var_99_4:setName("icon")
		var_99_3:addChild(var_99_4)

		local var_99_5 = servant_data[item_data[arg_99_0.dropid].servant].roll_rarity or 1
		local var_99_6 = ccui.ImageView:create(var_0_44[var_99_5], var_0_22)

		var_99_6:setScale(0.5)
		var_99_6:setAnchorPoint(cc.p(0, 1))
		var_99_6:setPosition(cc.p(0, var_99_2:getContentSize().height))
		var_99_2:addChild(var_99_6, 1)

		local var_99_7 = ccui.ImageView:create(ATTRICONPATH[var_99_1], var_0_22)

		var_99_7:setScale(0.7)
		var_99_7:setAnchorPoint(cc.p(0, 0))
		var_99_7:setPosition(cc.p(0, 0))
		var_99_2:addChild(var_99_7, 1)

		if arg_99_0.dropnum > 2 then
			local var_99_8 = ccui.Layout:create()

			var_99_8:setClippingEnabled(true)
			var_99_8:setContentSize(var_99_2:getContentSize().width, var_99_2:getContentSize().height)
			var_99_8:setPosition(cc.p(0, 0))
			var_99_8:setCascadeOpacityEnabled(true)
			var_99_2:addChild(var_99_8)

			local var_99_10 = arg_99_1 == BLACK_CARD and "TwistEgg/black_img.png" or "TwistEgg/black_sp_img.png"
			local var_99_11 = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_99_10) or cc.Sprite:createWithSpriteFrameName(var_99_10)))

			var_99_11:setType(cc.PROGRESS_TIMER_TYPE_BAR)
			var_99_11:setBarChangeRate(cc.p(0, 1))
			var_99_11:setMidpoint(cc.p(0, 1))
			var_99_11:setAnchorPoint(cc.p(0, 1))
			var_99_11:setPosition(0, var_99_8:getContentSize().height)
			var_99_11:runAction(cc.Sequence:create(cc.DelayTime:create(1.0666666666666667), cc.ProgressTo:create(0.8, 100), cc.CallFunc:create(function()
				var_99_11:stopAllActions()
				var_99_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1.2, 0), cc.DelayTime:create(0.3), cc.FadeTo:create(1.2, 255))))
			end)))
			var_99_8:addChild(var_99_11, 9)

			local var_99_12 = ccui.ImageView:create("TwistEgg/light_img.png", var_0_22)

			var_99_12:setAnchorPoint(cc.p(0, 1))
			var_99_12:setPosition(-10, var_99_8:getContentSize().height + 10)
			var_99_8:addChild(var_99_12, 10)
			var_99_12:setVisible(false)
			var_99_12:runAction(cc.Sequence:create(cc.DelayTime:create(1.0666666666666667), cc.Show:create(), cc.MoveTo:create(0.8, cc.p(-10, 10))))
		end

		local var_99_13

		if var_99_5 >= 5 then
			var_99_13 = var_0_72
		elseif var_99_5 >= 4 then
			var_99_13 = var_0_70
		elseif var_99_5 >= 3 then
			var_99_13 = var_0_71
		end

		if var_99_13 then
			for iter_99_0 = 1, 2 do
				local var_99_14 = ccui.ImageView:create(var_99_13, var_0_22)

				var_99_14:setPosition(cc.p(var_99_2:getContentSize().width / 2, var_99_2:getContentSize().height / 2))

				if iter_99_0 == 1 then
					var_99_14:setScale(1.1)
					var_99_14:setOpacity(0)
					var_99_14:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
				else
					var_99_14:setScale(1)
					var_99_14:setOpacity(255)
					var_99_14:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
				end

				var_99_2:addChild(var_99_14, 2)
			end
		end

		return var_99_2
	end,
	[kITEM_HORCRUX] = function(arg_101_0)
		local var_101_1 = item_data[arg_101_0.dropid].image_offset_y or 0
		local var_101_2 = (item_data[arg_101_0.dropid].image_offse_x or 0) * 0.65
		local var_101_3 = global_get_model_attr(horcrux_data[arg_101_0.dropid].model)
		local var_101_4 = ccui.ImageView:create(var_0_69[var_101_3], var_0_22)
		local var_101_5 = ccui.Layout:create()

		var_101_5:setClippingEnabled(true)
		var_101_5:setContentSize(var_101_4:getContentSize().width - 8, var_101_4:getContentSize().height - 8)
		var_101_5:setPosition(cc.p(4, 4))
		var_101_5:setCascadeOpacityEnabled(true)
		var_101_5:setName("clip")
		var_101_4:addChild(var_101_5)

		local var_101_6 = cc.Sprite:create("role1/" .. horcrux_manager:getHorcruxRoleImage(arg_101_0.dropid) .. ".png")

		var_101_6:setScale(0.65)
		var_101_6:setAnchorPoint(cc.p(0.5, 0))
		var_101_6:setPosition(cc.p(var_101_5:getContentSize().width / 2 + var_101_2, -40 + var_101_1 * 0.65))
		var_101_6:setName("icon")
		var_101_5:addChild(var_101_6)

		local var_101_7 = horcrux_data[arg_101_0.dropid].rarity or 1
		local var_101_8 = ccui.ImageView:create(var_0_44[var_101_7], var_0_22)

		var_101_8:setScale(0.5)
		var_101_8:setAnchorPoint(cc.p(0, 1))
		var_101_8:setPosition(cc.p(0, var_101_4:getContentSize().height))
		var_101_4:addChild(var_101_8, 1)

		local var_101_9 = ccui.ImageView:create(ATTRICONPATH[var_101_3], var_0_22)

		var_101_9:setScale(0.7)
		var_101_9:setAnchorPoint(cc.p(0, 0))
		var_101_9:setPosition(cc.p(0, 0))
		var_101_4:addChild(var_101_9, 1)

		for iter_101_0 = 1, horcrux_manager:getHorcruxStarLevel(arg_101_0.entityid) do
			local var_101_10 = ccui.ImageView:create(var_0_45[1], var_0_22)

			var_101_10:setScale(0.5)
			var_101_10:setPosition(cc.p(var_101_4:getContentSize().width - 20, 20 + 30 * (iter_101_0 - 1)))
			var_101_4:addChild(var_101_10, 1)
		end

		if var_101_7 > 2 then
			for iter_101_1 = 1, 2 do
				local var_101_11

				if var_101_7 > 3 then
					var_101_11 = ccui.ImageView:create(var_0_70, var_0_22) or ccui.ImageView:create(var_0_71, var_0_22)
				end

				var_101_11:setPosition(cc.p(var_101_4:getContentSize().width / 2, var_101_4:getContentSize().height / 2))

				if iter_101_1 == 1 then
					var_101_11:setScale(1.1)
					var_101_11:setOpacity(0)
					var_101_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
				else
					var_101_11:setScale(1)
					var_101_11:setOpacity(255)
					var_101_11:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
				end

				var_101_4:addChild(var_101_11, 2)
			end
		end

		return var_101_4
	end,
	[kITEM_DRAWING] = function(arg_102_0)
		local var_102_0 = ccui.ImageView:create(var_0_68[item_data[arg_102_0.dropid].equip_quality], var_0_22)
		local var_102_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		var_102_1:setString(item_data[arg_102_0.dropid].name)
		var_102_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_102_1:setPosition(cc.p(var_102_0:getContentSize().width / 2, var_102_0:getContentSize().height / 2 - 90))
		var_102_0:addChild(var_102_1, 1)

		local var_102_2 = ccui.Layout:create()

		var_102_2:setClippingEnabled(true)
		var_102_2:setContentSize(cc.size(170, 170))
		var_102_2:setPosition(cc.p(var_102_0:getContentSize().width / 2 - 85, var_102_0:getContentSize().height / 2 - 56))
		var_102_2:setCascadeOpacityEnabled(true)
		var_102_2:setName("clip")
		var_102_0:addChild(var_102_2)

		local var_102_3 = cc.Sprite:create("equipment/draw.png")

		var_102_3:setPosition(cc.p(84, 84))
		var_102_3:setName("icon")
		var_102_3:setCascadeOpacityEnabled(true)
		var_102_2:addChild(var_102_3)

		local var_102_4 = cc.Sprite:create("equipment/" .. item_data[arg_102_0.dropid].image_id .. ".png")

		var_102_4:setScale(0.46875)
		var_102_4:setPosition(cc.p(var_102_3:getContentSize().width / 2, var_102_3:getContentSize().height / 2))
		var_102_3:addChild(var_102_4)

		if item_data[arg_102_0.dropid].equip_quality >= 5 then
			local var_102_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_102_5:setScale(1.25)
			var_102_5:setName("eggEffect")
			var_102_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_102_5:setPosition(var_102_0:getContentSize().width / 2, var_102_0:getContentSize().height / 2)

			local var_102_6 = cc.Animation:create()

			for iter_102_0 = 1, 8 do
				var_102_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_102_0 .. ".png")))
			end

			var_102_6:setDelayPerUnit(0.1)
			var_102_6:setRestoreOriginalFrame(true)
			var_102_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_102_6)))
			var_102_0:addChild(var_102_5)
		end

		return var_102_0
	end,
	[kITEM_HORCRUX_DRAWING] = function(arg_103_0)
		local var_103_0 = ccui.ImageView:create(var_0_68[item_data[arg_103_0.dropid].equip_quality], var_0_22)
		local var_103_1 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

		var_103_1:setString(item_data[arg_103_0.dropid].name)
		var_103_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_103_1:setPosition(cc.p(var_103_0:getContentSize().width / 2, var_103_0:getContentSize().height / 2 - 90))
		var_103_0:addChild(var_103_1, 1)

		local var_103_2 = ccui.Layout:create()

		var_103_2:setClippingEnabled(true)
		var_103_2:setContentSize(cc.size(170, 170))
		var_103_2:setPosition(cc.p(var_103_0:getContentSize().width / 2 - 85, var_103_0:getContentSize().height / 2 - 56))
		var_103_2:setCascadeOpacityEnabled(true)
		var_103_2:setName("clip")
		var_103_0:addChild(var_103_2)

		local var_103_3 = cc.Sprite:create("equipment/draw.png")

		var_103_3:setPosition(cc.p(84, 84))
		var_103_3:setName("icon")
		var_103_3:setCascadeOpacityEnabled(true)
		var_103_2:addChild(var_103_3)

		local var_103_4 = cc.Sprite:create("equipment/" .. item_data[arg_103_0.dropid].image_id .. ".png")

		var_103_4:setScale(0.46875)
		var_103_4:setPosition(cc.p(var_103_3:getContentSize().width / 2, var_103_3:getContentSize().height / 2))
		var_103_3:addChild(var_103_4)

		if item_data[arg_103_0.dropid].equip_quality >= 5 then
			local var_103_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

			var_103_5:setScale(1.25)
			var_103_5:setName("eggEffect")
			var_103_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_103_5:setPosition(var_103_0:getContentSize().width / 2, var_103_0:getContentSize().height / 2)

			local var_103_6 = cc.Animation:create()

			for iter_103_0 = 1, 8 do
				var_103_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_103_0 .. ".png")))
			end

			var_103_6:setDelayPerUnit(0.1)
			var_103_6:setRestoreOriginalFrame(true)
			var_103_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_103_6)))
			var_103_0:addChild(var_103_5)
		end

		return var_103_0
	end
}

setmetatable(var_0_74, {
	__index = function(arg_104_0, arg_104_1)
		return function(arg_105_0)
			local var_105_0 = item_data[arg_105_0.dropid].equip_quality
			local var_105_1 = ccui.ImageView:create(var_0_68[item_data[arg_105_0.dropid].equip_quality], var_0_22)
			local var_105_2 = cc.Label:createWithTTF("", "fonts/number.ttf", 25)

			if arg_105_0.dropnum > 1 then
				var_105_2:setString(item_data[arg_105_0.dropid].name .. " X" .. arg_105_0.dropnum)
			else
				var_105_2:setString(item_data[arg_105_0.dropid].name)
			end

			var_105_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_105_2:setPosition(cc.p(var_105_1:getContentSize().width / 2, var_105_1:getContentSize().height / 2 - 90))
			var_105_1:addChild(var_105_2, 1)

			local var_105_3 = ccui.Layout:create()

			var_105_3:setClippingEnabled(true)
			var_105_3:setContentSize(cc.size(170, 170))
			var_105_3:setPosition(cc.p(var_105_1:getContentSize().width / 2 - 85, var_105_1:getContentSize().height / 2 - 56))
			var_105_3:setCascadeOpacityEnabled(true)
			var_105_3:setName("clip")
			var_105_1:addChild(var_105_3)

			local var_105_4 = cc.Sprite:create("equipment/" .. item_data[arg_105_0.dropid].image_id .. ".png")

			var_105_4:setPosition(cc.p(84, 84))
			var_105_4:setName("icon")
			var_105_3:addChild(var_105_4)

			if var_105_0 >= 5 then
				local var_105_5 = cc.Sprite:createWithSpriteFrameName("eggegg_1.png")

				var_105_5:setScale(1.25)
				var_105_5:setName("eggEffect")
				var_105_5:setAnchorPoint(cc.p(0.5, 0.5))
				var_105_5:setPosition(var_105_1:getContentSize().width / 2, var_105_1:getContentSize().height / 2)

				local var_105_6 = cc.Animation:create()

				for iter_105_0 = 1, 8 do
					var_105_6:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("eggegg_" .. iter_105_0 .. ".png")))
				end

				var_105_6:setDelayPerUnit(0.1)
				var_105_6:setRestoreOriginalFrame(true)
				var_105_5:runAction(cc.RepeatForever:create(cc.Animate:create(var_105_6)))
				var_105_1:addChild(var_105_5)
			end

			if item_data[arg_105_0.dropid].bag_item_type == kITEM_WEAPON then
				var_105_4:setScale(0.65)
			end

			return var_105_1
		end
	end,
	__call = function(self, arg_106_1, ...)
		return self[arg_106_1](...)
	end
})

function AITwistLayer:showTwistFinalResult(arg_107_1, arg_107_2, arg_107_3, arg_107_4)
	self.skipBnt:setVisible(false)
	self.twistSureBtn:setVisible(false)
	self.twistingRectPanel:setVisible(true)
	self.resultBg:setTexture(var_0_36)
	self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(false)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/twist_animation/eggegg.plist")

	self.resultTouchEnabled = false

	local var_107_0 = #arg_107_2 == 1 and {
		cc.p(320, GameDisplay.height / 2)
	} or var_0_64()

	local function var_107_1(arg_108_0)
		local var_108_0 = self.twistingRectPanel:getChildByName("rect" .. arg_108_0)

		if not var_108_0 then
			var_108_0 = L2Skeleton:create(var_0_38 .. ".json", var_0_38 .. ".atlas", nil, true)

			var_108_0:refreshSkeleton()
			var_108_0:setName("rect" .. arg_108_0)
			self.twistingRectPanel:addChild(var_108_0)
		end

		return var_108_0
	end

	local function var_107_2()
		return coroutine.create(function()
			for iter_110_0 = 1, #arg_107_2 do
				local var_110_0 = var_107_1(iter_110_0)

				var_110_0:setPosition(var_107_0[iter_110_0])
				var_110_0:setVisible(true)
				var_110_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_111_0)
					if arg_111_0.animation == "blue-out" or arg_111_0.animation == "orange-out" or arg_111_0.animation == "red-out" or arg_111_0.animation == "purple-out" then
						var_110_0:setVisible(false)
					end
				end)

				local var_110_1 = arg_107_2[iter_110_0].dropid
				local var_110_2 = arg_107_2[iter_110_0].entityid
				local var_110_3, var_110_4 = var_110_0:getPosition()
				local var_110_5 = item_data[arg_107_2[iter_110_0].dropid].bag_item_type
				local var_110_6 = var_0_74(item_data[arg_107_2[iter_110_0].dropid].bag_item_type, arg_107_2[iter_110_0], self.twistBlackCard)

				var_110_6:setName("item" .. iter_110_0)
				var_110_6:setPosition(cc.p(var_110_3, var_110_4))
				var_110_6:setOpacity(0)

				local var_110_7 = var_110_6:getChildByName("clip"):getChildByName("icon")

				var_110_7:setOpacity(0)
				self.twistingRectPanel:addChild(var_110_6)
				var_110_6:setTouchEnabled(true)
				var_110_6:addTouchEventListener(function(arg_112_0, arg_112_1)
					if arg_112_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not self.resultTouchEnabled then
						return
					end

					if var_110_5 == kITEM_HORCRUX then
						LayerManager:pushInLayer("HorcruxInfoLayer", var_110_2, "twist_preview")

						return
					end

					if var_110_5 == kITEM_HERO then
						if arg_107_2[iter_110_0].itemid == 1500001 then
							if not global_basic_scene:getChildByName("OTHER_LAYER") then
								local var_112_0 = PopLayer:Item({
									hideGainButton = true,
									itemid = arg_107_2[iter_110_0].itemid
								})
							end
						else
							LayerManager:pushInLayer("SoulsLayer", {
								showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
								cursoul = item_data[var_110_1].servant
							})
						end

						return
					end

					if not global_basic_scene:getChildByName("OTHER_LAYER") then
						local var_112_1 = PopLayer:Item({
							hideGainButton = true,
							itemid = var_110_1
						})
					end
				end)

				local var_110_8 = arg_107_2[iter_110_0].itemid ~= arg_107_2[iter_110_0].dropid and arg_107_2[iter_110_0].itemid == 1500001 and arg_107_2[iter_110_0].dropid or arg_107_2[iter_110_0].itemid

				if var_0_67(var_110_8) then
					var_110_0:play("red-out", false)
				elseif var_0_65(var_110_8) then
					var_110_0:play("orange-out", false)
				elseif var_0_66(var_110_8) then
					var_110_0:play("purple-out", false)
				else
					var_110_0:play("blue-out", false)
				end

				var_110_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_110_7:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.FadeIn:create(0.2)))
				var_110_6:runAction(cc.Sequence:create(cc.DelayTime:create(0.6666666666666666), cc.CallFunc:create(function()
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT_AFTER)
				end)))

				if not var_0_63[arg_107_1] then
					audio_manager:playeffectMusic(TWIST_ADD_EFFECT)
				end

				coroutine.yield(iter_110_0)
			end

			if arg_107_4 and arg_107_4 > 0 then
				self.twistingRectPanel:getChildByName("blackcardinfo"):setVisible(true)

				if self.lastTwistBlackCard == BLACK_CARD then
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_bg1.png", var_0_22)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format("魂卡x%d", arg_107_4))
				else
					self.twistingRectPanel:getChildByName("blackcardinfo"):loadTexture("TwistEgg/panel_blackcard_sp_bg1.png", var_0_22)
					self.twistingRectPanel:getChildByName("blackcardinfo"):getChildByName("num"):setString(string.format("SP魂卡x%d", arg_107_4))
				end
			end

			self.twistSureBtn:setOpacity(0)
			self.twistSureBtn:setVisible(true)
			self.twistSureBtn:runAction(cc.FadeIn:create(0.2))

			return "end"
		end)
	end

	if self.showAniScheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
	end

	local var_107_3 = var_107_2()
	local var_107_4, var_107_5 = coroutine.resume(var_107_3)

	assert(var_107_4, var_107_5)

	self.showAniScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_114_0)
		if not var_107_3 then
			var_107_3 = var_107_2()

			return
		end

		local var_114_0, var_114_1 = coroutine.resume(var_107_3)

		assert(var_114_0, var_114_1)

		if var_114_1 == "end" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)

			self.showAniScheduler = nil
			var_107_3 = nil
			self.resultTouchEnabled = true
		end
	end, 0.2, false)

	self.twistSureBtn:addTouchEventListener(function(arg_115_0, arg_115_1)
		if arg_115_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.resultTouchEnabled then
			return
		end

		self.resultTouchEnabled = false
		self.isAlowOtherTouch = true
		self.tenBntOtherLock = false

		self.twistingRectPanel:setVisible(false)
		self:cleanTwistRectPanel()
		self.showPanel:setVisible(false)
		self.resultPanel:setVisible(false)
		self.resultInfosPanel:setVisible(false)
		self:cleanShowResultPanelEvent()

		if arg_107_3 then
			audio_manager:playeffectMusic(GAIN_HEAD_PORTRAIT_EFFECT)
			self:onGetNewHead(arg_107_3.itemid, function()
				GuideListener.swallowEvent(false)
				GuideListener.lockGuideTrigger(false)
				GuideListener.updateGuides(self)
			end)
		else
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(self)
		end

		autopop_manager:resumeAchievementPop()
	end)
end

function AITwistLayer:initShowResultPanel()
	self.skipBnt:setPositionY(self.skipBnt:getPositionY() - GameDisplay.fix_y)

	self.resultTouchEnabled = false
	self.resultBg = cc.Sprite:create(var_0_35)

	self.resultBg:setPosition(cc.p(320, GameDisplay.height / 2))
	self.resultBg:setVisible(false)
	self.showPanel:addChild(self.resultBg, 1)

	self.resultAni = L2Skeleton:create(var_0_37 .. ".json", var_0_37 .. ".atlas", nil, true)

	self.resultAni:refreshSkeleton()
	self.resultAni:setPosition(cc.p(-45, 638 + GameDisplay.fix_y))
	self.resultAni:setVisible(false)
	self.showPanel:addChild(self.resultAni, 3)

	self.resultPanel = ccui.Layout:create()

	self.resultPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.resultPanel:setVisible(false)
	self.showPanel:addChild(self.resultPanel, 5)

	self.resultInfosPanel = ccui.Layout:create()

	self.resultInfosPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.resultInfosPanel:setVisible(false)
	self.showPanel:addChild(self.resultInfosPanel, 4)

	local var_117_0 = ccui.ImageView:create("TwistEgg/panel_blackcard_bg2.png", var_0_22)

	var_117_0:setAnchorPoint(cc.p(1, 0.5))
	var_117_0:setPosition(cc.p(640, 221 + GameDisplay.fix_y))
	var_117_0:setName("blackcardinfo")
	self.resultPanel:addChild(var_117_0, 5)

	local var_117_1 = cc.Label:createWithTTF("魂卡x1", "fonts/number.ttf", 18)

	var_117_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_117_1:setPosition(cc.p(var_117_0:getContentSize().width / 2 + 32, var_117_0:getContentSize().height / 2 - 18))
	var_117_1:setName("num")
	var_117_0:addChild(var_117_1)

	self.twistingRectPanel = ccui.Layout:create()

	self.twistingRectPanel:setContentSize(cc.size(640, GameDisplay.height))
	self.twistingRectPanel:setTouchEnabled(true)
	self.twistingRectPanel:setVisible(false)
	self.showPanel:addChild(self.twistingRectPanel, 2)

	local var_117_2 = ccui.ImageView:create("TwistEgg/panel_blackcard_bg1.png", var_0_22)

	var_117_2:setAnchorPoint(cc.p(1, 0.5))
	var_117_2:setPosition(cc.p(640, 226 + GameDisplay.fix_y))
	var_117_2:setName("blackcardinfo")
	var_117_2:setVisible(false)
	self.twistingRectPanel:addChild(var_117_2, 5)

	local var_117_3 = cc.Label:createWithTTF("魂卡x20", "fonts/number.ttf", 28)

	var_117_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_117_3:setPosition(cc.p(var_117_2:getContentSize().width / 2 + 50, var_117_2:getContentSize().height / 2 - 36))
	var_117_3:setName("num")
	var_117_2:addChild(var_117_3)

	self.twistSureBtn = ccui.Button:create(var_0_73[1], var_0_73[2], var_0_73[1], var_0_22)

	self.twistSureBtn:setPressedActionEnabled(true)
	self.twistSureBtn:setPosition(cc.p(450, 100 + GameDisplay.fix_y))
	self.twistSureBtn:setVisible(false)
	self.twistingRectPanel:addChild(self.twistSureBtn)
end

function AITwistLayer:cleanTwistRectPanel()
	self.resultTouchEnabled = false

	for iter_118_0 = 1, 10 do
		local var_118_0 = self.twistingRectPanel:getChildByName("rect" .. iter_118_0)

		if var_118_0 then
			var_118_0:setVisible(false)
		else
			break
		end
	end

	for iter_118_1 = 1, 10 do
		if self.twistingRectPanel:getChildByName("item" .. iter_118_1) then
			self.twistingRectPanel:removeChildByName("item" .. iter_118_1)
		else
			break
		end
	end

	self.twistSureBtn:setVisible(false)
end

function AITwistLayer:cleanShowResultPanelEvent()
	self.resultTouchEnabled = false

	self.showPanel:addTouchEventListener(function(arg_120_0, arg_120_1)
		return
	end)
	self.skipBnt:addTouchEventListener(function(arg_121_0, arg_121_1)
		return
	end)
end

function AITwistLayer.twist_one_result(arg_122_0, arg_122_1, arg_122_2)
	autopop_manager:pauseAchievementPop()

	arg_122_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items", {
		twisttype = arg_122_1
	}, function(arg_123_0)
		if arg_123_0.result == 1 then
			arg_122_0.lastTwistBlackCard = arg_122_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_122_0:twistcost(var_0_23, arg_122_1)

			if arg_123_0.item.itemtype == kITEM_HERO then
				if not playermodel.haveServant[item_data[arg_123_0.item.itemid].servant] then
					local var_123_0 = {
						servantid = item_data[arg_123_0.item.itemid].servant
					}

					var_123_0.rarity = servant_data[item_data[arg_123_0.item.itemid].servant].roll_rarity or 1

					AnalyticManager.gain_new_servant_by_twist(var_123_0)
				end
			end

			local var_123_1 = item_manager:setItemByServerItem(arg_123_0.item)

			arg_122_0:show_twist_result(arg_122_1, {
				{
					dropid = arg_123_0.dropitem.dropid,
					dropnum = arg_123_0.dropitem.dropNum,
					itemid = arg_123_0.item.itemid,
					entityid = arg_123_0.item.entityid
				}
			}, nil, (arg_123_0.blackcard or nil) and item_manager:setItemByServerItem(arg_123_0.blackcard))
			arg_122_0:updateByBlackCard(twisttype)

			if twist_config_data[arg_122_1].stat == 3 then
				arg_122_0:updateNaiveTwist(arg_122_1, "one")
			end
		elseif arg_123_0.result == 2 then
			arg_122_0:lackofcost(var_0_23, arg_122_1)
		elseif arg_123_0.result == 3 then
			global_ShowBlockWords("蛋池未开放")
		elseif arg_123_0.result == 4 then
			global_ShowBlockWords("蛋池未解锁")
		end

		if arg_122_2 then
			arg_122_2()
		end

		arg_122_0.isAlowOtherTouch = true
	end)
end

function AITwistLayer.twist_ten_result(arg_124_0, arg_124_1, arg_124_2)
	autopop_manager:pauseAchievementPop()

	arg_124_0.isAlowOtherTouch = false

	network:rpc("add_twistegg_items_for_ten", {
		twisttype = arg_124_1
	}, function(arg_125_0)
		if arg_125_0.result == 1 then
			arg_124_0.lastTwistBlackCard = arg_124_0.twistBlackCard

			LayerManager:showTopBottomLayer({
				TopcostLayer = false
			})
			arg_124_0:twistcost(var_0_24, arg_124_1)

			for iter_125_0, iter_125_1 in pairs(arg_125_0.items) do
				if iter_125_1.itemtype == kITEM_HERO then
					if not playermodel.haveServant[item_data[iter_125_1.itemid].servant] then
						local var_125_0 = {
							servantid = item_data[iter_125_1.itemid].servant
						}

						var_125_0.rarity = servant_data[item_data[iter_125_1.itemid].servant].roll_rarity or 1

						AnalyticManager.gain_new_servant_by_twist(var_125_0)
					end
				end

				item_manager:setItemByServerItem(iter_125_1)
			end

			if arg_125_0.icon then
				item_manager:setItemByServerItem(arg_125_0.icon)
			end

			local var_125_1 = 0

			if arg_125_0.blackcard then
				var_125_1 = item_manager:setItemByServerItem(arg_125_0.blackcard)
			end

			local var_125_2 = {}

			for iter_125_2 = 1, 10 do
				table.insert(var_125_2, {
					dropid = arg_125_0.dropitems[iter_125_2].dropid,
					dropnum = arg_125_0.dropitems[iter_125_2].dropNum,
					itemid = arg_125_0.items[iter_125_2].itemid,
					entityid = arg_125_0.items[iter_125_2].entityid
				})
			end

			arg_124_0:show_twist_result(arg_124_1, var_125_2, arg_125_0.icon, var_125_1)
			arg_124_0:updateByBlackCard(arg_124_1)

			if twist_config_data[arg_124_1].stat == 3 then
				arg_124_0:updateNaiveTwist(arg_124_1, "ten")
			end

			AnalyticManager.twistSuccess(arg_124_1, "ten")
		elseif arg_125_0.result == 2 then
			arg_124_0:lackofcost(var_0_24, arg_124_1)
		elseif arg_125_0.result == 3 then
			global_ShowBlockWords("蛋池未开放")
		elseif arg_125_0.result == 4 then
			global_ShowBlockWords("蛋池未解锁")
		end

		if arg_124_2 then
			arg_124_2()
		end

		arg_124_0.isAlowOtherTouch = true

		if arg_125_0.result ~= 1 then
			arg_124_0.tenBntOtherLock = false
		end
	end)
end

function AITwistLayer:updateTwistCount(arg_126_1, arg_126_2)
	if self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2 then
		self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2 = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2 - arg_126_2

		if self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount then
			self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount - arg_126_2
		end

		if self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2 <= 0 then
			self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2 = nil
		end

		if self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount and self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount <= 0 then
			self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount = nil
		end

		local var_126_0
		local var_126_1

		if self.curtwistDate[self.twist_type_to_index[arg_126_1]].uppos2 == 1 then
			var_126_1 = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount
			var_126_0 = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2
		else
			var_126_1 = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount2
			var_126_0 = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount
		end

		if var_126_0 then
			self.doubleCount1:getChildByName("num"):setString(var_126_0)
		else
			self.doubleCount1:setVisible(false)
		end

		if var_126_1 then
			self.doubleCount2:getChildByName("num"):setString(var_126_1)
		else
			self.doubleCount2:setVisible(false)
		end
	elseif self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount then
		self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount = self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount - arg_126_2

		if self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount <= 0 then
			self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount = nil

			self.countPanel:setVisible(false)
		else
			self.countPanel:getChildByName("num"):setString(self.curtwistDate[self.twist_type_to_index[arg_126_1]].upcount)
		end
	end
end

function AITwistLayer:twistcost(arg_127_1, arg_127_2)
	local var_127_0 = self.twist_type_to_index[arg_127_2]
	local var_127_1 = self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype

	if arg_127_1 == var_0_23 then
		self:updateTwistCount(arg_127_2, 1)

		if arg_127_2 == var_0_25 then
			self.freetime = self.freetime - 1
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforone and self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforone > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforone = self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforone - 1
			var_127_1 = var_0_30
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforone and self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforone > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforone = self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforone - 1
			var_127_1 = var_0_30
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype > 2 then
			item_manager:deleteItem(self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype, self.curtwistDate[self.twist_type_to_index[arg_127_2]].costone)
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype == var_0_31 then
			playermodel.gold = playermodel.gold - self.curtwistDate[var_127_0].costone

			global_update_gold_stone_diamond(playermodel.gold)
			AnalyticManager.twistCostSuccess(self.curtwistDate[var_127_0].costone)
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype == var_0_32 then
			playermodel.diamond = playermodel.diamond - self.curtwistDate[var_127_0].costone

			global_update_gold_stone_diamond(nil, nil, 1)
			AnalyticManager.twistCostSuccess(nil, self.curtwistDate[var_127_0].costone, 1)
		end

		AnalyticManager.twist_one_success({
			twisttype = arg_127_2,
			cost_type = var_127_1,
			cost_num = var_127_1 == var_0_30 and 1 or self.curtwistDate[var_127_0].costone
		})

		if arg_127_2 == 4 then
			AnalyticManager.favor_twist_one({
				cost_type = var_127_1,
				cost_num = var_127_1 == var_0_30 and 1 or self.curtwistDate[var_127_0].costone
			})
		end
	elseif arg_127_1 == var_0_24 then
		self:updateTwistCount(arg_127_2, 10)

		if arg_127_2 == var_0_25 then
			self.freetime = self.freetime - 10
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforten and self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforten > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforten = self.curtwistDate[self.twist_type_to_index[arg_127_2]].dailyfreeforten - 1
			var_127_1 = var_0_30
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforten and self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforten > 0 then
			self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforten = self.curtwistDate[self.twist_type_to_index[arg_127_2]].totalfreeforten - 1
			var_127_1 = var_0_30
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype > 2 then
			item_manager:deleteItem(self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype, self.curtwistDate[self.twist_type_to_index[arg_127_2]].costten)
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype == var_0_31 then
			playermodel.gold = playermodel.gold - self.curtwistDate[var_127_0].costten

			global_update_gold_stone_diamond(playermodel.gold)
			AnalyticManager.twistCostSuccess(self.curtwistDate[var_127_0].costten)
		elseif self.curtwistDate[self.twist_type_to_index[arg_127_2]].costtype == var_0_32 then
			playermodel.diamond = playermodel.diamond - self.curtwistDate[var_127_0].costten

			global_update_gold_stone_diamond(nil, nil, 1)
			AnalyticManager.twistCostSuccess(nil, self.curtwistDate[var_127_0].costten, 10)
		end

		AnalyticManager.twist_ten_success({
			twisttype = arg_127_2,
			cost_type = var_127_1,
			cost_num = var_127_1 == var_0_30 and 1 or self.curtwistDate[var_127_0].costten
		})

		if arg_127_2 == 4 then
			AnalyticManager.favor_twist_one({
				cost_type = var_127_1,
				cost_num = var_127_1 == var_0_30 and 1 or self.curtwistDate[var_127_0].costten
			})
		end
	end

	self:updateTimePanel()
	self:updateCostInfo(arg_127_2)
	self:checkBntsAlert()

	if not self:checkIsHaveFreeTimes() then
		require("controller.alert_manager"):unregister_alert(ALERT_TWISTEGG)
	end
end

function AITwistLayer:lackofcost(arg_128_1, arg_128_2)
	local var_128_0 = self.curtwistDate[self.twist_type_to_index[arg_128_2]].costtype

	if arg_128_2 == var_0_25 then
		global_ShowBlockWords(var_0_27[arg_128_2])
	elseif var_128_0 > 4 then
		local var_128_1

		if arg_128_1 == var_0_23 then
			var_128_1 = self.curtwistDate[self.twist_type_to_index[arg_128_2]].costone - item_manager:getItemNumber(var_128_0)
		elseif arg_128_1 == var_0_24 then
			var_128_1 = self.curtwistDate[self.twist_type_to_index[arg_128_2]].costten - item_manager:getItemNumber(var_128_0)
		end

		if not twist_config_data[arg_128_2].supply_cost then
			if twist_config_data[arg_128_2].gold_cost then
				local var_128_2 = {
					is_need_pop_layer = 1
				}

				function var_128_2.surecallback()
					network:rpc("supply_twist_cost", {
						twisttype = arg_128_2,
						num = var_128_1
					}, function(arg_130_0)
						if arg_130_0.result == 1 then
							if twist_config_data[arg_128_2].supply_cost then
								playermodel.diamond = playermodel.diamond - var_128_1 * twist_config_data[arg_128_2].supply_cost
							else
								playermodel.gold = playermodel.gold - var_128_1 * twist_config_data[arg_128_2].gold_cost
							end

							global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)
							item_manager:setItemByServerItem(arg_130_0.item)
							self:updateTimePanel()
							self.oneBnt:setBright(false)
							self.tenBnt:setBright(false)

							local function var_130_0()
								self.oneBnt:setBright(true)
								self.tenBnt:setBright(true)
							end

							if arg_128_1 == var_0_23 then
								self:twist_one_result(arg_128_2, var_130_0)
							else
								self:twist_ten_result(arg_128_2, var_130_0)
							end

							global_ShowBlockWords("购买成功!", RISE_WORDS_SUCCESS)

							if twist_config_data[arg_128_2].supply_cost then
								AnalyticManager.buyTwistTicketSuccess(var_128_1 * twist_config_data[arg_128_2].supply_cost, var_128_1)
							end
						elseif arg_130_0.result == 2 then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 0
							})
						elseif arg_130_0.result == 3 then
							LayerManager:pushInLayer("PopGoGainLayer", {
								goto_back_system_id = 180,
								item = var_128_0
							})
						else
							l2Log("buy_twist_ticket fail")
						end
					end)
				end

				if twist_config_data[arg_128_2].supply_cost then
					var_128_2.costtype = "diamond"
					var_128_2.own = playermodel.diamond
					var_128_2.cost = twist_config_data[arg_128_2].supply_cost * var_128_1
					var_128_2.des = "消耗" .. twist_config_data[arg_128_2].supply_cost * var_128_1 .. L_DIAMOND .. "购买" .. var_128_1 .. "张" .. item_data[var_128_0].name
				else
					var_128_2.costtype = "gold"
					var_128_2.own = playermodel.gold
					var_128_2.cost = twist_config_data[arg_128_2].gold_cost * var_128_1
					var_128_2.des = "消耗" .. twist_config_data[arg_128_2].gold_cost * var_128_1 .. "金币购买" .. var_128_1 .. "张" .. item_data[var_128_0].name
				end

				var_128_2.labels = global_deepCopy(L_COMPONENT_TWIST)
				var_128_2.labels.des = var_128_2.des or "消耗" .. L_DIAMOND .. "购买扭蛋券~"

				LayerManager:pushInLayer("PopDoLayer", var_128_2)

				goto label_128_0
			end
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 180,
			item = var_128_0
		})

		::label_128_0::
	elseif var_128_0 == var_0_31 then
		LayerManager:pushInLayer("PopGoLayer", {
			targetlayer = "HandOfMidasLayer",
			labels = L_GO_BUY_GOLD
		})
	end
end

local function var_0_75(arg_132_0, arg_132_1, arg_132_2)
	local var_132_0 = {
		type_tbl = {}
	}

	for iter_132_0, iter_132_1 in pairs(arg_132_0) do
		local var_132_1, var_132_2 = string.match(iter_132_0, arg_132_1)
		local var_132_3 = tonumber(var_132_1)
		local var_132_4 = tonumber(var_132_2)
		local var_132_5

		if var_132_3 and var_132_4 then
			if true == true then
				var_132_0[var_132_3] = {}
				var_132_0[var_132_3].attribute = var_132_3
				var_132_0[var_132_3].content = {}
				var_132_0[var_132_3].content[var_132_4] = {
					itemid = iter_132_1
				}
				var_132_5 = false
			else
				local var_132_7 = false

				for iter_132_2, iter_132_3 in pairs(var_132_0) do
					if iter_132_3.attribute and iter_132_3.attribute == var_132_3 then
						if iter_132_3.content[var_132_4] then
							iter_132_3.content[var_132_4].itemid = iter_132_1
						else
							iter_132_3.content[var_132_4] = {
								itemid = iter_132_1
							}
						end

						var_132_7 = true

						break
					end
				end

				if var_132_7 == false then
					var_132_0[var_132_3] = {}
					var_132_0[var_132_3].attribute = var_132_3
					var_132_0[var_132_3].content = {}
					var_132_0[var_132_3].content[var_132_4] = {
						itemid = iter_132_1
					}
				end
			end
		else
			local var_132_8 = string.match(iter_132_0, arg_132_2)

			if var_132_8 then
				var_132_0.type_tbl[tonumber(var_132_8)] = iter_132_1
			end
		end
	end

	return var_132_0
end

local function var_0_76(arg_133_0)
	local var_133_0 = {
		type_tbl = {}
	}

	for iter_133_0, iter_133_1 in pairs(arg_133_0) do
		if servant_data[item_data[iter_133_1].servant].roll_rarity == 5 then
			if not var_133_0[2] then
				var_133_0[2] = {
					attribute = 2,
					content = {}
				}
				var_133_0.type_tbl[2] = "学员-特殊作战形态"
			end

			table.insert(var_133_0[2].content, {
				itemid = iter_133_1
			})
		else
			if not var_133_0[1] then
				var_133_0[1] = {
					attribute = 1,
					content = {}
				}
				var_133_0.type_tbl[1] = "学员"
			end

			table.insert(var_133_0[1].content, {
				itemid = iter_133_1
			})
		end
	end

	return var_133_0
end

local function var_0_77(arg_134_0)
	local var_134_0 = {
		type_tbl = {}
	}

	for iter_134_0, iter_134_1 in pairs(arg_134_0) do
		if not var_134_0[1] then
			var_134_0[1] = {
				attribute = 1,
				content = {}
			}
			var_134_0.type_tbl[1] = "AI"
		end

		table.insert(var_134_0[1].content, {
			itemid = iter_134_1
		})
	end

	return var_134_0
end

local function var_0_78(arg_135_0)
	local var_135_0 = {
		type_tbl = {}
	}

	for iter_135_0, iter_135_1 in pairs(arg_135_0) do
		if 1 and iter_135_0 then
			local var_135_2

			if true == true then
				var_135_0[1] = {}
				var_135_0[1].attribute = 1
				var_135_0[1].content = {}
				var_135_0[1].content[iter_135_0] = {
					itemid = iter_135_1
				}
				var_135_2 = false
			else
				local var_135_4 = false

				for iter_135_2, iter_135_3 in pairs(var_135_0) do
					if iter_135_3.attribute and iter_135_3.attribute == 1 then
						if iter_135_3.content[iter_135_0] then
							iter_135_3.content[iter_135_0].itemid = iter_135_1
						else
							iter_135_3.content[iter_135_0] = {
								itemid = iter_135_1
							}
						end

						var_135_4 = true

						break
					end
				end

				if var_135_4 == false then
					var_135_0[1] = {}
					var_135_0[1].attribute = 1
					var_135_0[1].content = {}
					var_135_0[1].content[iter_135_0] = {
						itemid = iter_135_1
					}
				end
			end
		end
	end

	local var_135_5 = {
		[65] = 2,
		[17] = 3,
		[67] = 1
	}

	setmetatable(var_135_5, {
		__index = function(arg_136_0, arg_136_1)
			return 4
		end
	})

	var_135_0.type_tbl = {}

	table.insert(var_135_0.type_tbl, "礼物")
	table.insert(var_135_0.type_tbl, "家具")
	table.insert(var_135_0.type_tbl, "科研材料")
	table.insert(var_135_0.type_tbl, "其他")

	local var_135_6 = {}

	table.insert(var_135_6, {
		attribute = 1,
		content = {}
	})
	table.insert(var_135_6, {
		attribute = 2,
		content = {}
	})
	table.insert(var_135_6, {
		attribute = 3,
		content = {}
	})
	table.insert(var_135_6, {
		attribute = 4,
		content = {}
	})

	for iter_135_4, iter_135_5 in pairs((global_deepCopy(var_135_0[1].content))) do
		table.insert(var_135_6[var_135_5[item_data[iter_135_5.itemid].bag_item_type]].content, {
			itemid = iter_135_5.itemid
		})
	end

	var_135_0[1] = var_135_6[1]
	var_135_0[2] = var_135_6[2]
	var_135_0[3] = var_135_6[3]
	var_135_0[4] = var_135_6[4]

	return var_135_0
end

local drop_words_data = require("data.drop_words_data")

function AITwistLayer.showTwistEggDrops(arg_137_0, arg_137_1, arg_137_2)
	twist_manager:set_twist_status(function(arg_138_0)
		local var_138_0 = {}
		local var_138_1 = {}
		local var_138_2 = {}

		while drop_data[twist_config_data[arg_137_1].dropid]["rd_dropmodel_id" .. 1] do
			if drop_data[twist_config_data[arg_137_1].dropid]["rd_dropmodel_rate" .. 1] ~= 0 then
				var_138_2[#var_138_2 + 1] = drop_data[twist_config_data[arg_137_1].dropid]["rd_dropmodel_id" .. 1]
			end
		end

		local var_138_4 = {}

		for iter_138_0 = 1, #var_138_2 do
			local var_138_5 = 1

			while drop_data[var_138_2[iter_138_0]]["rd_drop_id" .. var_138_5] do
				if drop_data[var_138_2[iter_138_0]]["rd_drop_weight" .. var_138_5] ~= 0 and not horcrux_data[drop_data[var_138_2[iter_138_0]]["rd_drop_id" .. var_138_5]] then
					var_138_4[#var_138_4 + 1] = drop_data[var_138_2[iter_138_0]]["rd_drop_id" .. var_138_5]
				end

				var_138_5 = var_138_5 + 1
			end
		end

		table.sort(var_138_4)

		local twist_probability_data = require("data.twist_probability_data")

		for iter_138_1, iter_138_2 in pairs(arg_138_0) do
			if iter_138_2.twisttype == arg_137_1 then
				print("check egg pool: ", arg_137_1)

				if iter_138_2.twisttype == 4 then
					var_138_0 = var_0_78(var_138_4)
					var_138_1 = var_0_75(drop_words_data[iter_138_2.twisttype], "type(%d+)_words(%d+)", "words_type(%d+)")
				elseif iter_138_2.twisttype == 101 then
					var_138_0 = var_0_77(var_138_4)
					var_138_1 = var_0_75(drop_words_data[iter_138_2.twisttype], "type(%d+)_words(%d+)", "words_type(%d+)")
				else
					var_138_0 = var_0_76(var_138_4)
					var_138_1 = var_0_75(drop_words_data[iter_138_2.twisttype], "type(%d+)_words(%d+)", "words_type(%d+)")
				end
			end
		end

		local var_138_7, var_138_8, var_138_9 = (function(arg_140_0, arg_140_1)
			local var_140_0 = {}
			local var_140_1 = {}
			local var_140_2 = {
				startTime,
				finishTime
			}

			for iter_140_0 = 1, #arg_140_1 do
				if arg_140_1[iter_140_0].twisttype == arg_140_0 then
					var_140_0 = arg_140_1[iter_140_0].items
					var_140_1 = arg_140_1[iter_140_0].weights
					var_140_2.startTime = arg_140_1[iter_140_0].upstarttime
					var_140_2.finishTime = arg_140_1[iter_140_0].upfinishtime
				end
			end

			return var_140_0, var_140_1, var_140_2
		end)(arg_137_1, arg_138_0)

		if var_138_7 and next(var_138_7) ~= nil then
			local var_138_10 = {
				attribute = 999,
				content = {}
			}

			for iter_138_3 = 1, #var_138_7 do
				table.insert(var_138_10.content, {
					itemid = var_138_7[iter_138_3]
				})
			end

			table.insert(var_138_0, var_138_10)

			if var_138_0.type_tbl then
				var_138_0.type_tbl[999] = "概率UP"
			end

			local var_138_11 = #var_138_0

			for iter_138_4 = #var_138_0, 1, -1 do
				var_138_0[iter_138_4 + 1] = var_138_0[iter_138_4]
			end

			var_138_0[1] = var_138_0[var_138_11 + 1]

			table.remove(var_138_0)
		end

		if next(var_138_0) == nil then
			if next(var_138_1) ~= nil then
				local var_138_12 = {
					callback = function()
						if not var_0_21 then
							return
						end

						arg_137_2:setTouchEnabled(true)
					end
				}

				var_138_12.category = {
					type = 2,
					egg_pool_type = arg_137_1,
					Items_Up = var_138_7,
					Items_Weights = var_138_8,
					Items_Uptime = var_138_9
				}
				var_138_12.items_tbl = var_138_0
				var_138_12.words_tbl = var_138_1

				LayerManager:pushInLayer("DropDetailsLayer", var_138_12)
			end
		end
	end)
end

function AITwistLayer:updateGoldPanel()
	if self.curtwistDate[self.curTwistIndex] and self.curtwistDate[self.curTwistIndex].costtype == 1 then
		self:updateTimePanel()
	end
end

function AITwistLayer:checkIsHaveFreeTimes(arg_142_1, arg_142_2)
	if not arg_142_1 then
		for iter_142_0, iter_142_1 in pairs(self.twist_type_to_index) do
			local var_142_0 = iter_142_1

			if (self.curtwistDate[iter_142_1].dailyfreeforone or 0) <= 0 then
				local var_142_2

				if (self.curtwistDate[var_142_0].totalfreeforone or 0) <= 0 then
					var_142_2 = false

					goto label_142_0
				end
			end

			var_142_2 = true

			do
				local var_142_4
			end

			::label_142_0::

			if (self.curtwistDate[var_142_0].dailyfreeforten or 0) <= 0 then
				if (self.curtwistDate[var_142_0].totalfreeforten or 0) <= 0 then
					var_142_4 = false

					goto label_142_1
				end
			end

			::label_142_1::

			if var_142_2 or true then
				return true
			end
		end

		return false
	else
		local var_142_5 = self.twist_type_to_index[arg_142_1]

		if (self.curtwistDate[self.twist_type_to_index[arg_142_1]].dailyfreeforone or 0) <= 0 then
			local var_142_7

			if (self.curtwistDate[var_142_5].totalfreeforone or 0) <= 0 then
				var_142_7 = false

				goto label_142_2
			end
		end

		var_142_7 = true

		::label_142_2::

		if (self.curtwistDate[var_142_5].dailyfreeforten or 0) <= 0 then
			local var_142_9

			if (self.curtwistDate[var_142_5].totalfreeforten or 0) <= 0 then
				var_142_9 = false

				goto label_142_3
			end
		end

		var_142_9 = true

		::label_142_3::

		if arg_142_2 == "one" then
			return var_142_7
		elseif arg_142_2 == "ten" then
			return var_142_9
		elseif not arg_142_2 then
			return var_142_9 or var_142_7
		end
	end
end

function AITwistLayer:checkBntsAlert(arg_143_1)
	local var_143_0 = self.curtwistDate[self.curTwistIndex].twistType

	local function var_143_1()
		if self:checkIsHaveFreeTimes(var_143_0, "one") then
			AlertManager:add_alert_by_config(self.oneBnt, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.oneBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		else
			AlertManager:add_alert_by_config(self.oneBnt, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.oneBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		end
	end

	local function var_143_2()
		if self:checkIsHaveFreeTimes(var_143_0, "ten") then
			AlertManager:add_alert_by_config(self.tenBnt, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.tenBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		else
			AlertManager:add_alert_by_config(self.tenBnt, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.tenBnt:getContentSize().width - 20, self.oneBnt:getContentSize().height - 20)
			})
		end
	end

	if arg_143_1 == "img" then
		(function()
			local var_144_0 = self.imgScrollView:getChildByName("class_image" .. self.curTwistIndex)

			if self:checkIsHaveFreeTimes(var_143_0) then
				AlertManager:add_alert_by_config(var_144_0, true, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(10, var_144_0:getContentSize().height - 20)
				})
			else
				AlertManager:add_alert_by_config(var_144_0, false, {
					ALERT_SHOW_REDDOT,
					"",
					cc.p(10, var_144_0:getContentSize().height - 20)
				})
			end
		end)()
	elseif arg_143_1 == "oneBnt" then
		var_143_1()
	elseif arg_143_1 == "tenBnt" then
		var_143_2()
	else
		var_143_1()
		var_143_2()
	end
end

function AITwistLayer:initGotoMarketBtn()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goto_market"):addTouchEventListener(function(arg_148_0, arg_148_1)
		if arg_148_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("MarketLayer", {
			returnLayer = "AITwistLayer",
			singleMarket = arg_148_0.shoptype,
			showType = arg_148_0.shoptype[1]
		})
	end)
end

function AITwistLayer.onGetNewHead(arg_149_0, arg_149_1, arg_149_2)
	local var_149_0 = ccui.Layout:create()

	var_149_0:setContentSize(cc.size(640, GameDisplay.height))
	var_149_0:setTouchEnabled(true)
	var_149_0:setBackGroundImage("mainScenebg/head_get_bg.jpg")
	global_basic_scene:addChild(var_149_0, 999)
	var_149_0:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.RemoveSelf:create()))

	local var_149_1

	if config._DEBUG then
		var_149_1 = cc.Sprite:create("TwistEgg/xiao.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/xiao.png")
	end

	var_149_1:setPosition(cc.p(320, GameDisplay.height / 2))
	var_149_1:setScale(0.1)
	var_149_0:addChild(var_149_1)

	local var_149_2

	if config._DEBUG then
		var_149_2 = cc.Sprite:create("TwistEgg/zhong.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/zhong.png")
	end

	var_149_2:setPosition(cc.p(320, GameDisplay.height / 2))
	var_149_2:setScale(0.1)
	var_149_0:addChild(var_149_2, 5)

	local var_149_3

	if config._DEBUG then
		var_149_3 = cc.Sprite:create("TwistEgg/da.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/da.png")
	end

	var_149_3:setPosition(cc.p(320, GameDisplay.height / 2))
	var_149_3:setScale(0.1)
	var_149_0:addChild(var_149_3, 5)
	cc.SpriteFrameCache:getInstance():addSpriteFrames("effect/compose.plist")

	local var_149_4 = cc.Sprite:createWithSpriteFrameName("compose_1.png")

	var_149_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_149_4:setPosition(cc.p(320, GameDisplay.height / 2))
	var_149_4:setVisible(false)
	var_149_0:addChild(var_149_4, 4)

	local var_149_5

	if config._DEBUG then
		var_149_5 = cc.Sprite:create("TwistEgg/kuang.png") or cc.Sprite:createWithSpriteFrameName("TwistEgg/kuang.png")
	end

	var_149_5:setPosition(cc.p(320, GameDisplay.height / 2))
	var_149_5:setVisible(false)
	var_149_0:addChild(var_149_5, 2)

	local var_149_6

	if config._DEBUG then
		var_149_6 = cc.Sprite:create("public/rolebg/icon_bg.png") or cc.Sprite:createWithSpriteFrameName("public/rolebg/icon_bg.png")
	end

	local var_149_7 = cc.Sprite:create("role/wuji/" .. item_data[arg_149_1].image_id .. ".png")

	var_149_7:setPosition(cc.p(var_149_6:getContentSize().width / 2, var_149_6:getContentSize().height / 2))
	var_149_6:addChild(var_149_7)
	var_149_6:setPosition(cc.p(320, GameDisplay.height / 2))
	var_149_6:setVisible(false)
	var_149_0:addChild(var_149_6, 300)
	var_149_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_149_2:runAction(cc.ScaleTo:create(0.2, 1))
	var_149_3:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1), cc.CallFunc:create(function()
		var_149_3:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))
		var_149_2:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, -360)))
		var_149_1:runAction(cc.RepeatForever:create(cc.RotateBy:create(3, 360)))

		local var_150_0 = cc.Animation:create()

		for iter_150_0 = 1, 12 do
			var_150_0:addSpriteFrame((cc.SpriteFrameCache:getInstance():getSpriteFrame("compose_" .. iter_150_0 .. ".png")))
		end

		var_150_0:setDelayPerUnit(0.1)
		var_149_4:setVisible(true)
		var_149_4:runAction(cc.Sequence:create(cc.Animate:create(var_150_0), cc.Hide:create(), cc.CallFunc:create(function()
			local var_151_0 = cc.Label:createWithTTF(item_data[arg_149_1].name, FONT_NAME, 40)

			var_151_0:setAnchorPoint(cc.p(0, 0.5))
			var_151_0:setPosition(cc.p(320 - var_151_0:getContentSize().width / 2, 450 + GameDisplay.fix_y))
			var_149_0:addChild(var_151_0)
			var_149_0:addTouchEventListener(function(arg_152_0, arg_152_1)
				if arg_152_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_149_2 then
					arg_149_2()
				end

				var_149_0:runAction(cc.RemoveSelf:create())
			end)
		end)))

		local var_150_1 = cc.OrbitCamera:create(0.8, 180, 0, -180, 180, 0, 0)

		var_149_5:setVisible(true)
		var_149_5:runAction(cc.Spawn:create(var_150_1:clone(), cc.Sequence:create(cc.DelayTime:create(0.4), cc.Hide:create())))
		var_149_6:runAction(cc.Spawn:create(var_150_1:clone(), cc.Sequence:create(cc.DelayTime:create(0.4), cc.Show:create())))
	end)))
end

function AITwistLayer.get_naive_stat(arg_153_0, arg_153_1, arg_153_2)
	local bit = require("bit")
	local var_153_1 = bit.band(arg_153_1, 1) > 0 and true
	local var_153_2 = bit.band(arg_153_1, 2) > 0 and true

	if arg_153_2 == "one" then
		return var_153_1
	elseif arg_153_2 == "ten" then
		return var_153_2
	else
		return var_153_2
	end
end

function AITwistLayer:updateNaiveTwist(arg_154_1, arg_154_2)
	local bit = require("bit")
	local var_154_1 = self.twist_type_to_index[arg_154_1]
	local var_154_2 = self.curtwistDate[self.twist_type_to_index[arg_154_1]]

	if arg_154_2 == "one" then
		var_154_2.naivemark = bit.bor(self.curtwistDate[self.twist_type_to_index[arg_154_1]].naivemark, 1)
	elseif arg_154_2 == "ten" then
		var_154_2.naivemark = bit.bor(self.curtwistDate[self.twist_type_to_index[arg_154_1]].naivemark, 2)
	end

	if self:get_naive_stat(var_154_2.naivemark) then
		table.remove(self.curtwistDate, var_154_1)

		for iter_154_0, iter_154_1 in pairs(self.curtwistDate) do
			self.twist_type_to_index[iter_154_1.twistType] = iter_154_0
		end

		for iter_154_2, iter_154_3 in pairs(self.imgScrollView:getChildren()) do
			if iter_154_3.twistIndex then
				if var_154_1 < iter_154_3.twistIndex then
					iter_154_3.twistIndex = iter_154_3.twistIndex - 1

					iter_154_3:setName("class_image" .. iter_154_3.twistIndex)
					iter_154_3:setPositionX(10 + (iter_154_3.twistIndex - 1) * (iter_154_3:getContentSize().width + 20))
				elseif iter_154_3.twistIndex == var_154_1 then
					iter_154_3:removeFromParent()
				end
			end
		end

		self.curTwistIndex = 1

		self.pointsPanel:removeAllChildren()
		self:initSlidePoints()
		self.imgScrollView:switchImg()
		self:updateTwistType(self.curtwistDate[self.curTwistIndex].twistType)
		self.oneBnt:setOpacity(255)
		self.tenBnt:setOpacity(255)
	elseif self:get_naive_stat(var_154_2.naivemark, "one") then
		self.oneBnt:setOpacity(100)
	elseif self:get_naive_stat(var_154_2.naivemark, "ten") then
		self.tenBnt:setOpacity(100)
	end
end
