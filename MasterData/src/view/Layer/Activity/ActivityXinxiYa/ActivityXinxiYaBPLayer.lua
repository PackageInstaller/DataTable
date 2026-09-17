ActivityXinxiYaBPLayer = class("ActivityXinxiYaBPLayer", function()
	return ActivityBattlePassBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_3 = config._DEBUG and 0 or 1

function ActivityXinxiYaBPLayer.create(arg_2_0)
	local var_2_0 = ActivityXinxiYaBPLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityXinxiYaBPLayer.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityXinxiYaBPLayer"
	arg_3_0.activityId = 136
end

function ActivityXinxiYaBPLayer:setUIPosition()
	local var_4_0 = self.rootLayer:getChildByName("panel_up")

	var_4_0:setPositionY(982 + GameDisplay.fix_y * 2)

	local var_4_1 = var_4_0:getChildByName("title_detial")

	var_4_1:setAnchorPoint(cc.p(0, 1))
	var_4_1:setPosition(20, 300)

	local var_4_2 = var_4_0:getChildByName("btn_detail")

	var_4_2:setPosition(360, 220)
	var_4_2:setVisible(false)

	local var_4_3 = var_4_0:getChildByName("lbl_time")

	var_4_3:setPosition(142, 176)
	var_4_3:setColor(cc.c3b(63, 48, 103))
	var_4_3:setVisible(false)

	local var_4_4 = var_4_0:getChildByName("upup")

	var_4_4:setScale(0.9)
	var_4_4:setPosition(50, 149)

	self.progress_banner_pos = cc.p(190, 128)

	local var_4_5 = var_4_0:getChildByName("level_bg")

	var_4_5:setScale(0.8)
	var_4_5:setPosition(320, 145)

	local var_4_6 = var_4_5:getChildByName("cur_level")

	var_4_6:setPosition(var_4_5:getContentSize().width / 2, var_4_5:getContentSize().height / 2 + 8)
	var_4_6:setColor(cc.c3b(255, 255, 255))

	local var_4_7 = ccui.Helper:seekWidgetByName(var_4_0, "cur_exp")

	var_4_7:setFontSize(20)
	var_4_7:setColor(cc.c3b(255, 255, 255))
	var_4_7:setPosition(150, 145)

	self.BtnBuyPt_pos = cc.p(230, 145)

	var_4_0:getChildByName("button_jump_to"):setPosition(180, 60)

	self.curLevelLbl_color = cc.c3b(255, 255, 255)
	self.ptNum_color = cc.c3b(255, 255, 255)
	self.itemsp_wordbg = "ActivityXinxiYaBPLayer/item_num_bg.png"
	self.bigGiftPanelY = 50
	self.levelTableviewPosY = 20
	self.taskTableviewPosY = 0
	self.task_height_add = -90
	self.level_height_add = -60

	self.bottomList:setVisible(false)

	self.award_preview_btn = ccui.Button:create(self.layerName .. "/award_preview.png", self.layerName .. "/award_preview.png", self.layerName .. "/award_preview.png", var_0_3)

	self.award_preview_btn:addTouchEventListener(self:getJumpToHandel())
	self.award_preview_btn:setPosition(cc.p(566, 270))
	var_4_0:addChild(self.award_preview_btn)
end

function ActivityXinxiYaBPLayer:updateShowBigGift()
	self.bigGiftPanel = self.rootLayer:getChildByName("big_gift_bg")

	self.bigGiftPanel:setTouchEnabled(true)
	self.bigGiftPanel:setPositionY(self.bigGiftPanelY or self.bottomList:getPositionY() + 92)

	local var_5_0 = math.floor((self.curLevel - 1) / 10) * 10 + 10

	if var_5_0 > 40 then
		var_5_0 = 40
	end

	local var_5_1 = self.levelListData[var_5_0]
	local var_5_2 = self.bigGiftPanel:getChildByName("drop_node")

	if var_5_2 then
		var_5_2:removeFromParent()
	end

	if var_5_1 and next(var_5_1) and type(var_5_1.level) ~= "string" and var_5_1.drop then
		local var_5_3 = ccui.Layout:create()

		var_5_3:setPosition(cc.p(self.bigGiftPanel:getContentSize().width / 2 + 50, self.LEVEL_CELL_HEIGHT / 2 + 5))
		var_5_3:setName("drop_node")
		self.bigGiftPanel:addChild(var_5_3)

		for iter_5_0, iter_5_1 in pairs((activity_manager:getBattlePassDrop(self.activityId, var_5_1.drop))) do
			local var_5_4 = ItemPurchaseSprite:createPurchaseItem(iter_5_1.dropid)

			var_5_4:setName("sp_" .. iter_5_0)
			var_5_4:setScale(0.6)
			var_5_4:setTouchEnabled(true)
			var_5_4:setSwallowTouches(false)
			var_5_4:setPosition(cc.p(-300 + (iter_5_0 - 1) * 150, 50))
			var_5_4:addTouchEventListener(function(arg_6_0, arg_6_1)
				if arg_6_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_5_1.dropid)
			end)
			var_5_3:addChild(var_5_4)
		end
	end

	local var_5_5 = 1
	local var_5_6 = self.bigGiftPanel:getChildByName("special_drop_node")

	if var_5_6 then
		var_5_6:removeFromParent()
	end

	if var_5_1 and next(var_5_1) and type(var_5_1.level) ~= "string" and var_5_1.specialDrop then
		local var_5_7 = ccui.Layout:create()

		var_5_7:setPosition(cc.p(self.bigGiftPanel:getContentSize().width / 2 + 100 + var_5_5 * 100, self.LEVEL_CELL_HEIGHT / 2 + 5))
		var_5_7:setName("special_drop_node")
		self.bigGiftPanel:addChild(var_5_7)

		for iter_5_2, iter_5_3 in pairs((activity_manager:getBattlePassDrop(self.activityId, var_5_1.specialDrop))) do
			local var_5_8 = ItemPurchaseSprite:createPurchaseItem(iter_5_3.dropid)

			var_5_8:setScale(0.6)
			var_5_8:setTouchEnabled(true)
			var_5_8:setSwallowTouches(false)
			var_5_8:setPosition(cc.p(-300 + (iter_5_2 - 1) * 150, 50))
			var_5_7:addChild(var_5_8)
			var_5_8:addTouchEventListener(function(arg_7_0, arg_7_1)
				if arg_7_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_5_3.dropid)
			end)
		end
	end

	self.all_gain_btn = ccui.Button:create(self.layerName .. "/all_gain.png", self.layerName .. "/all_gain.png", self.layerName .. "/all_gain.png", var_0_3)

	self.all_gain_btn:addTouchEventListener(self:getGetAllHandel())
	self.all_gain_btn:setPosition(cc.p(550, 96))
	self.bigGiftPanel:addChild(self.all_gain_btn, 1000)
end
