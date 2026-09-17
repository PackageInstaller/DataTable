PopGetWarOrdrBpVIPLayer = class("PopGetWarOrdrBpVIPLayer", function()
	return PopBaseLayer:create()
end)

function PopGetWarOrdrBpVIPLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGetWarOrdrBpVIPLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local var_0_2 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local recharge_manager = require("controller.recharge_manager")
local activity_vipbuy_data = require("data.activity_vipbuy_data")

function PopGetWarOrdrBpVIPLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopGetWarOrdrBpVIPLayer.json" or "PopGetWarOrdrBpVIPLayer.ExportJson")

	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.activityId = arg_3_1.activityId or 9
	self.imagePath = arg_3_1.imagePath or "ActivityBianhuaBP"

	self:initUI()
	self:fullScreen()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopGetWarOrdrBpVIPLayer")
		end
	end)
end

function PopGetWarOrdrBpVIPLayer:registerActivityEventListener()
	activity_manager:registerEventListener("PopGetWarOrdrBpVIPLayer", activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_6_0)
		self:updateVIPButtons()
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_7_0)
		self:updateVIPButtons()
	end), self)
end

function PopGetWarOrdrBpVIPLayer:initUI()
	self:updateVIPButtons()
	self:initExitTouchEvent()
	self:initImageInJson()
	self:initDropView()
	self:initDorps()
end

function PopGetWarOrdrBpVIPLayer:updateVIPButtons()
	local var_9_0 = activity_manager:getBPVipBuyBtnPos(self.activityId)
	local var_9_1 = activity_manager:getBPVipBuyIncoPos(self.activityId)

	self.panelBg = self.rootLayer:getChildByName("panel_bg")
	self.btn_close = self.panelBg:getChildByName("btn_close")
	self.btnVipNeed = self.panelBg:getChildByName("btn_vip_need")
	self.VIPGetted = self.panelBg:getChildByName("btn_getted_vip")

	self.btnVipNeed:setVisible(not activity_manager:isBattlePassVIP(self.activityId))
	self.VIPGetted:setVisible(activity_manager:isBattlePassVIP(self.activityId))
	self.btnVipNeed:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isVIPBtnLock(self.activityId) then
			return
		end

		if activity_manager:isBattlePassVIP(self.activityId) then
			return
		end

		activity_manager:buyVipById(self.activityId, "vip_" .. self.activityId)
		AnalyticManager.touch_bianhua_vipbuy({
			id = "vip_" .. self.activityId
		})
	end)

	self.vipLabel = cc.Label:createWithTTF(recharge_manager:getCommodityPriceStr(activity_vipbuy_data["vip_" .. self.activityId].rechargId), FONT_BUTTON, 24)

	self.vipLabel:setPosition(97, 35)
	self.btnVipNeed:addChild(self.vipLabel)

	self.btnSVipNeed = self.panelBg:getChildByName("btn_svip_need")
	self.SVIPGetted = self.panelBg:getChildByName("btn_getted_svip")

	self.btnSVipNeed:setVisible(not activity_manager:isBattlePassSVIP(self.activityId))
	self.SVIPGetted:setVisible(activity_manager:isBattlePassSVIP(self.activityId))
	self.btnSVipNeed:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isVIPBtnLock(self.activityId) then
			return
		end

		if activity_manager:isBattlePassSVIP(self.activityId) then
			return
		end

		if activity_manager:isBattlePassVIP(self.activityId) then
			activity_manager:buyVipById(self.activityId, "svip_" .. self.activityId)
			AnalyticManager.touch_bianhua_vipbuy({
				id = "svip_" .. self.activityId
			})
		else
			activity_manager:buyVipById(self.activityId, "allvip_" .. self.activityId)
			AnalyticManager.touch_bianhua_vipbuy({
				id = "allvip_" .. self.activityId
			})
		end
	end)
	self.btnSVipNeed:setLocalZOrder(1000)

	local var_9_2 = "PopGetWarOrdrBpVIPLayer/btn_svip_need.png"
	local var_9_3 = activity_vipbuy_data["allvip_" .. self.activityId].rechargId

	if activity_manager:isBattlePassVIP(self.activityId) then
		var_9_2 = "PopGetWarOrdrBpVIPLayer/btn_left_need.png"
		var_9_3 = activity_vipbuy_data["svip_" .. self.activityId].rechargId
	end

	self.btnSVipNeed:loadTextures(var_9_2, nil, var_9_2, var_0_2)

	local l2utils = require("controller.l2utils")

	self.svipLabel = cc.Label:createWithTTF(recharge_manager:getCommodityPriceStr(var_9_3), FONT_BUTTON, 24)

	self.svipLabel:setPosition(97, 35)
	self.btnSVipNeed:addChild(self.svipLabel)
end

function PopGetWarOrdrBpVIPLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		self:exit()
	end)
	self.btn_close:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)
		self:exit()
	end)
end

function PopGetWarOrdrBpVIPLayer:initDorps()
	local var_15_0 = activity_manager:getBuySVIPDrop(self.activityId)
	local var_15_1 = ccui.ScrollView:create()

	var_15_1:setContentSize(cc.size(500, 200))
	var_15_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_15_1:setAnchorPoint(cc.p(0, 0))
	var_15_1:setPosition(100, 30)
	var_15_1:setInnerContainerSize(cc.size(95 * #var_15_0, 200))
	self.panelBg:getChildByName("drop_panel"):addChild(var_15_1)

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		local var_15_2 = ItemPurchaseSprite:createPurchaseItem(iter_15_1.dropid, iter_15_1.dropNum)

		var_15_2:addTouchEventListener(function()
			return
		end)
		var_15_2:setScale(0.55)
		var_15_2:setPosition(cc.p(45 + (iter_15_0 - 1) * 95, 100))
		var_15_1:addChild(var_15_2)

		local var_15_3 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

		var_15_3:setContentSize(cc.size(var_15_2:getContentSize().width, var_15_2:getContentSize().height))
		var_15_3:setPosition(cc.p(var_15_2:getContentSize().width / 2, var_15_2:getContentSize().height / 2))
		var_15_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_3:setName("layout")
		var_15_3:setSwallowTouches(false)
		var_15_2:addChild(var_15_3)
		var_15_2:setTouchEnabled(true)
		var_15_3:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_15_1.dropid)
		end)
	end
end

function PopGetWarOrdrBpVIPLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopGetWarOrdrBpVIPLayer:initDropView()
	local var_20_0 = activity_manager:getWarOrderVipGiftList(self.activityId)
	local var_20_1 = ccui.ScrollView:create()

	var_20_1:setContentSize(cc.size(500, 200))
	var_20_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_20_1:setAnchorPoint(cc.p(0, 0))
	var_20_1:setPosition(100, 360)
	var_20_1:setInnerContainerSize(cc.size(95 * #var_20_0, 200))
	self.panelBg:getChildByName("drop_panel"):addChild(var_20_1)

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		local var_20_2 = ItemPurchaseSprite:createPurchaseItem(iter_20_1.dropid, iter_20_1.dropNum)

		var_20_2:addTouchEventListener(function()
			return
		end)
		var_20_2:setScale(0.55)
		var_20_2:setPosition(cc.p(45 + (iter_20_0 - 1) * 95, 100))
		var_20_1:addChild(var_20_2)

		local var_20_3 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

		var_20_3:setContentSize(cc.size(var_20_2:getContentSize().width, var_20_2:getContentSize().height))
		var_20_3:setPosition(cc.p(var_20_2:getContentSize().width / 2, var_20_2:getContentSize().height / 2))
		var_20_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_20_3:setName("layout")
		var_20_3:setSwallowTouches(false)
		var_20_2:addChild(var_20_3)
		var_20_2:setTouchEnabled(true)
		var_20_3:addTouchEventListener(function(arg_22_0, arg_22_1)
			if arg_22_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(iter_20_1.dropid)
		end)
	end
end

function PopGetWarOrdrBpVIPLayer.createSprite(arg_23_0, arg_23_1)
	local var_23_0 = ItemPurchaseSprite:createPurchaseItem(arg_23_1.dropid, arg_23_1.dropNum)

	var_23_0:setScale(0.7)

	local var_23_1 = ccui.Button:create(ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, ITEM_BUTTON_DEFAULT_IMAGE, var_0_2)

	var_23_1:setContentSize(cc.size(var_23_0:getContentSize().width, var_23_0:getContentSize().height))
	var_23_1:setPosition(cc.p(var_23_0:getContentSize().width / 2, var_23_0:getContentSize().height / 2))
	var_23_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_23_1:setName("layout")
	var_23_1:setSwallowTouches(false)
	var_23_0:addChild(var_23_1)
	var_23_1:addTouchEventListener(function(arg_24_0, arg_24_1)
		if math.abs(arg_24_0:getTouchBeganPosition().y - arg_24_0:getTouchEndPosition().y) > 25 then
			return
		end

		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_23_1.dropid)
	end)

	return var_23_0
end

function PopGetWarOrdrBpVIPLayer.updateSprite(arg_25_0, arg_25_1, arg_25_2)
	arg_25_1:updatePurchaseItemByItemid(arg_25_2.dropid, arg_25_2.dropNum)
	arg_25_1:setSwallowTouches(false)
	arg_25_1:getChildByName("layout"):addTouchEventListener(function(arg_26_0, arg_26_1)
		if math.abs(arg_26_0:getTouchBeganPosition().y - arg_26_0:getTouchEndPosition().y) > 25 then
			return
		end

		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		showItemDetails(arg_25_2.dropid)
	end)
end

function PopGetWarOrdrBpVIPLayer:initBg(arg_27_1)
	local var_27_0 = ccui.Layout:create()

	var_27_0:setTouchEnabled(true)
	var_27_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_27_0:setAnchorPoint(cc.p(0, 0))
	var_27_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_27_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_27_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_27_0:setOpacity(0)
	self:addChild(var_27_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_28_0)
		self:addChild(arg_28_0, -2)
		arg_28_0:setPositionY(arg_28_0:getPositionY() - GameDisplay.fix_y)

		local var_28_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_28_0:setAnchorPoint(cc.p(0, 0))
		var_28_0:setPositionY(-GameDisplay.fix_y)
		var_28_0:setTouchEnabled(true)
		var_28_0:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_29_0:isBright() then
				return
			end

			arg_29_0:setBright(false)
			self:exit()
		end)
		self:addChild(var_28_0, -1)
		self:init(arg_27_1)
		var_27_0:setOpacity(102)
		var_27_0:setTouchEnabled(false)
	end)
end

function PopGetWarOrdrBpVIPLayer:initImageInJson()
	local var_30_0 = "PopGetWarOrdrBpVIPLayer/btn_svip_need.png"

	if activity_manager:isBattlePassVIP(self.activityId) then
		var_30_0 = "PopGetWarOrdrBpVIPLayer/btn_left_need.png"
	end

	self.btnVipNeed:loadTextures("PopGetWarOrdrBpVIPLayer/btn_vip_need.png", nil, "PopGetWarOrdrBpVIPLayer/btn_vip_need.png", var_0_2)
	self.btnSVipNeed:loadTextures(var_30_0, nil, var_30_0, var_0_2)
end

function PopGetWarOrdrBpVIPLayer:fullScreen()
	self.rootLayer:setContentSize(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y)
end
