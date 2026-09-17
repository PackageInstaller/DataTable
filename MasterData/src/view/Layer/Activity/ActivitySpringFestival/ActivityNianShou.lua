ActivityNianShou = class("ActivityNianShou", function()
	return cc.Layer:create()
end)

local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local spring_manager = require("controller.spring_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local activity_nianshou_award_data = require("data.activity_nianshou_award_data")
local drop_data = require("data.drop_data")
local var_0_7
local var_0_8 = 100101001

local function var_0_9(arg_2_0)
	local var_2_0 = arg_2_0 - time_check_manager:getCurTime()

	return var_2_0 > 86400 and string.format(L_TIME_FORMAT_DAYHOURMIN_NIANSHOU, math.floor(var_2_0 / 86400), math.floor(var_2_0 % 86400 / 3600), math.floor(var_2_0 % 86400 % 3600 / 60)) or string.format(L_TIME_FORMAT_HOURMINSEC_NIANSHOU, math.floor(var_2_0 / 3600), math.floor(var_2_0 % 3600 / 60), math.floor(var_2_0 % 3600 % 60))
end

function ActivityNianShou.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityNianShou.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityNianShou:init(arg_4_1)
	var_0_7 = true
	self.initInfo = arg_4_1
	self.esc_time = arg_4_1.esc_time
	self.is_gain_award = arg_4_1.award == 1

	LayerManager:createFullScreenMask(self, 160, function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
	self:initUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_7 = nil
		end
	end)
end

function ActivityNianShou:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_nianshou.json" or "Activity_nianshou.ExportJson")

	self:addChild(self.rootLayer)

	self.rankBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_rank")
	self.rewardBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_pt")
	self.barBg = ccui.Helper:seekWidgetByName(self.rootLayer, "bar_bg")
	self.progressBar = ccui.Helper:seekWidgetByName(self.rootLayer, "ProgressBar_30")
	self.curPtLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_pt")
	self.canGainImg = ccui.Helper:seekWidgetByName(self.rootLayer, "can_gain_bg")
	self.mainImg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_nianshou")
	self.timeBg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_time")
	self.timeLabel = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")
	self.goawayImg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_go_away")
	self.item1 = ccui.Helper:seekWidgetByName(self.rootLayer, "item_bg1")
	self.item2 = ccui.Helper:seekWidgetByName(self.rootLayer, "item_bg2")
	self.pt_limit_label = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_pt_limit")
	self.twist_num_label = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_twist_num")
	self.giftBnt = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sure")
	self.awardTips = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_36")

	self:initImg()
	self:initTime()
	self:initPT()
	self:initRank()
	self:initItem()
	self:initDes()
end

function ActivityNianShou:initImg()
	self.mainImg:runAction((cc.RepeatForever:create(cc.Sequence:create(cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, 8)), cc.ScaleBy:create(2, 1.01)), 2), cc.EaseInOut:create(cc.Spawn:create(cc.MoveBy:create(2, cc.p(0, -8)), cc.ScaleBy:create(2, 0.9900990099009901)), 2)))))

	if self.esc_time - time_check_manager:getCurTime() <= 0 then
		l2utils:shaderNode(self.mainImg:getVirtualRenderer())
	end
end

function ActivityNianShou:initTime()
	self.timeLabel:setVisible(false)

	if self.esc_time - time_check_manager:getCurTime() > 0 then
		self.goawayImg:setVisible(false)
		self.timeBg:setVisible(true)
		self.timeLabel:setString(var_0_9(self.esc_time))
		self.timeLabel:setVisible(true)

		local var_9_0 = 1

		self:scheduleUpdateWithPriorityLua(function(arg_10_0)
			var_9_0 = var_9_0 - arg_10_0

			if var_9_0 <= 0 then
				var_9_0 = 1

				self.timeLabel:setString(var_0_9(self.esc_time))
			end
		end, 0)
	else
		self.goawayImg:setVisible(true)
		self.timeBg:setVisible(false)
	end
end

function ActivityNianShou:initPT()
	if self.is_gain_award then
		self.rewardBnt:setVisible(false)
		self.canGainImg:setVisible(false)
		self.barBg:setVisible(false)
		self.awardTips:setVisible(false)
	else
		self.rewardBnt:loadTextures("roleimage/role/wuji/1000920001.png", nil, "roleimage/role/wuji/1000920001.png")
		self.rewardBnt:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_12_0.isLock then
				return
			end

			arg_12_0.isLock = true

			spring_manager:get_nianshou_award(function(arg_13_0)
				if arg_13_0 == 1 then
					self.rewardBnt:setVisible(false)
					self.canGainImg:setVisible(false)
					self.barBg:setVisible(false)
					self.awardTips:setVisible(false)
				end

				arg_12_0.isLock = false
			end)
		end)

		local var_11_0 = item_manager:getItemNumber(var_0_8) / activity_nianshou_award_data[1].score * 100

		var_11_0 = var_11_0 > 100 and 100 or var_11_0

		if var_11_0 >= 100 then
			self.canGainImg:setVisible(true)
			self.barBg:setVisible(false)
		else
			self.canGainImg:setVisible(false)
			self.barBg:setVisible(true)
		end

		self.progressBar:setPercent(var_11_0)
		self.curPtLabel:setString(item_manager:getItemNumber(var_0_8) .. "/" .. activity_nianshou_award_data[1].score)

		if self.esc_time - time_check_manager:getCurTime() < 0 and var_11_0 < 100 then
			self.rewardBnt:setVisible(false)
			self.canGainImg:setVisible(false)
			self.barBg:setVisible(false)
			self.awardTips:setVisible(false)
		end
	end
end

function ActivityNianShou:initRank()
	self.rankBnt:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("SpringRankListLayer")
	end)
end

function ActivityNianShou:initItem()
	local var_16_0 = 10000010

	self.item1:getChildByName("Image_gift"):loadTexture("mainScenebg/barrage/" .. item_data[10000010].image_id .. ".png")
	self.item1:getChildByName("Label_19"):setString(NIANSHOU_ITEM_DES[1] .. item_data[10000010].pt .. NIANSHOU_ITEM_DES[2])
	self.item1:setTouchEnabled(true)
	self.item1:addTouchEventListener(function(arg_17_0, arg_17_1)
		local var_17_2
		local var_17_1
		local var_17_0

		if arg_17_1 ~= ccui.TouchEventType.ended then
			do return end

			var_17_0 = {
				itemid = var_16_0
			}
			var_17_1 = {}
			var_17_2 = {
				label = "前往使用"
			}
		end

		function var_17_2.surecallback(arg_18_0, arg_18_1, arg_18_2)
			if arg_18_2 then
				arg_18_2()
			end

			self:goToGift()
		end

		var_17_1[1] = var_17_2
		var_17_0.button = var_17_1

		LayerManager:pushInLayer("PopItemLayer", var_17_0)
	end)

	local var_16_1 = 10000009

	self.item2:getChildByName("Image_gift"):loadTexture("mainScenebg/barrage/" .. item_data[10000009].image_id .. ".png")
	self.item2:getChildByName("Label_19"):setString(NIANSHOU_ITEM_DES[1] .. item_data[10000009].pt .. NIANSHOU_ITEM_DES[2])
	self.item2:setTouchEnabled(true)
	self.item2:addTouchEventListener(function(arg_19_0, arg_19_1)
		local var_19_2
		local var_19_1
		local var_19_0

		if arg_19_1 ~= ccui.TouchEventType.ended then
			do return end

			var_19_0 = {
				itemid = var_16_1
			}
			var_19_1 = {}
			var_19_2 = {
				label = "前往使用"
			}
		end

		function var_19_2.surecallback(arg_20_0, arg_20_1, arg_20_2)
			if arg_20_2 then
				arg_20_2()
			end

			self:goToGift()
		end

		var_19_1[1] = var_19_2
		var_19_0.button = var_19_1

		LayerManager:pushInLayer("PopItemLayer", var_19_0)
	end)
	self.giftBnt:setTouchEnabled(true)
	self.giftBnt:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:goToGift()
	end)
end

function ActivityNianShou:initDes()
	self.pt_limit_label:setString(activity_nianshou_award_data[1].score)
end

function ActivityNianShou:goToGift()
	if LayerManager:getActiveLayerName() == "FightLayer" then
		LayerManager:removePopLayer(self.__queueindex)
		LayerManager:pushInLayer("PopUseBarrageGiftLayer", {})
	else
		LayerManager:switchShowLayer("FightLayer", {
			createPopCallback = function()
				if LayerManager:getActiveLayerName() == "FightLayer" then
					LayerManager:pushInLayer("PopUseBarrageGiftLayer", {})
				end
			end
		})
	end
end
