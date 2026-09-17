PopActivityBpSignLayer = class("PopActivityBpSignLayer", function()
	return PopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local drop_manager = require("controller.drop_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = 0
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3
local var_0_9 = 4

function PopActivityBpSignLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityBpSignLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivityBpSignLayer:init(arg_3_1)
	self.activityId = arg_3_1.activityId

	ErrorCodeManager:check({
		systemname = "ActivityGeneralBPLayer",
		id = self.activityId
	})

	self.layerName = "ActivityBpSign_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self.rootLayer:setContentSize((cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y)))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)

	self.rootpanel = self.rootLayer

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getActivitySignData(self.activityId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName(self.layerName)

			if self.signList then
				for iter_4_0, iter_4_1 in ipairs(self.signList) do
					if iter_4_1 == var_0_7 then
						activity_manager:updateActivityAlert("sign", self.activityId, true)

						return
					end
				end

				activity_manager:updateActivityAlert("sign", self.activityId, false)
			end
		end
	end)
end

function PopActivityBpSignLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.ACTIVITY_BP_SIGN_DATA_UPDATE, function(arg_6_0)
		print(dump(arg_6_0))

		self.signList = arg_6_0

		self:upDateSignView()

		if self.buyPanel and self.buyPanel:isVisible() then
			if activity_manager:isSignVip(self.activityId) then
				self.btnBuy:setVisible(false)
			end

			self.buyPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
				self.buyPanel:setVisible(false)
			end)))
		end
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_8_0)
		activity_manager:getActivitySignData(self.activityId)
	end), self)
end

function PopActivityBpSignLayer:initUI()
	self:addTouchEventMask()
	self:playJoinEffect()
	self:initVipBuyPanel()
end

function PopActivityBpSignLayer:addTouchEventMask()
	self.rootLayer:setTouchEnabled(true)

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y * 2)
	self.rootLayer:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopActivityBpSignLayer:playJoinEffect()
	self.rootLayer:setScaleY(0.1)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
end

function PopActivityBpSignLayer:initVipBuyPanel()
	local var_14_0 = self.bg:getChildByName("btn_buy")

	self.btnBuy = var_14_0

	if activity_manager:isSignVip(self.activityId) then
		var_14_0:setVisible(false)

		return
	end

	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.buyPanel:setOpacity(0)
		self.buyPanel:setVisible(true)
		self.buyPanel:runAction(cc.FadeIn:create(0.2))
	end)

	self.buyPanel = self.rootLayer:getChildByName("buy_panel")

	self.buyPanel:setContentSize((cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y)))
	self.buyPanel:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.buyPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			self.buyPanel:setVisible(false)
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.buyPanel, "btn_go_buy"):addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:buySignVip(self.activityId)
	end)

	local var_14_1 = self.buyPanel:getChildByName("buy_bg")
	local var_14_2 = var_14_1:getChildByName("tableview")
	local var_14_3 = var_14_1:getChildByName("sp_1")

	var_14_3:setVisible(false)
	var_14_1:setTouchEnabled(true)
	var_14_1:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:buySignVip(self.activityId)
	end)

	local var_14_4 = activity_manager:getSignVipBuyReward(self.activityId)

	if #var_14_4 <= 0 then
		return
	end

	self.vipView = cc.TableView:create(var_14_2:getContentSize())

	self.vipView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	self.vipView:setVerticalFillOrder(cc.TABLEVIEW_FILL_DOWNTOP)
	self.vipView:setAnchorPoint(var_14_2:getAnchorPoint())
	self.vipView:setPosition(var_14_2:getPosition())
	self.vipView:setDelegate()
	var_14_2:getParent():addChild(self.vipView)

	self.vipView.cellsize = cc.size(var_14_3:getContentSize().width + 10, var_14_3:getContentSize().height)

	self.vipView:registerScriptHandler(function(arg_21_0, arg_21_1)
		return var_14_3:getContentSize().width + 10, var_14_3:getContentSize().height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.vipView:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if not var_20_0 then
			var_20_0 = cc.TableViewCell:create()

			local var_20_2 = self:createVipItemSprite(var_14_3, var_14_4[arg_20_1 + 1])

			var_20_2:setAnchorPoint(cc.p(0, 0))
			var_20_2:setPosition(cc.p(0, 0))
			var_20_0:addChild(var_20_2)
		else
			self:updateVipItemSprite(var_20_0:getChildByTag(100), var_14_4[arg_20_1 + 1])
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.vipView:registerScriptHandler(function(arg_22_0, arg_22_1)
		return #var_14_4
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.vipView:reloadData()
end

function PopActivityBpSignLayer.createVipItemSprite(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:clone()

	var_23_0:setVisible(true)
	var_23_0:getChildByName("item"):loadTexture("equipment/" .. item_data[arg_23_2.dropid].image_id .. ".png")
	var_23_0:getChildByName("num"):setString(arg_23_2.dropNum)
	var_23_0:getChildByName("num"):setVisible(arg_23_2.dropNum > 1)
	var_23_0:setTag(100)

	return var_23_0
end

function PopActivityBpSignLayer.updateVipItemSprite(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1:getChildByName("item"):loadTexture("equipment/" .. item_data[arg_24_2.dropid].image_id .. ".png")
	arg_24_1:getChildByName("num"):setString(arg_24_2.dropNum)
	arg_24_1:getChildByName("num"):setVisible(arg_24_2.dropNum > 1)
end

function PopActivityBpSignLayer:upDateSignView()
	if self.signView then
		self:updateShowingCells(self.signView, #self.signList)

		return
	end

	local var_25_0 = self.bg:getChildByName("tableview")
	local var_25_1 = self.bg:getChildByName("cell_bg")

	self.signView = cc.TableView:create(cc.size(var_25_0:getContentSize().width, var_25_0:getContentSize().height))

	self.signView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.signView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.signView:setAnchorPoint(var_25_0:getAnchorPoint())
	self.signView:setPosition(var_25_0:getPosition())
	self.signView:setDelegate()
	var_25_0:getParent():addChild(self.signView)

	self.signView.cellsize = cc.size(var_25_1:getContentSize().width, var_25_1:getContentSize().height + 20)

	self.signView:registerScriptHandler(function(arg_27_0, arg_27_1)
		return var_25_1:getContentSize().width, var_25_1:getContentSize().height + 20
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.signView:registerScriptHandler(function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0:dequeueCell()

		if not var_26_0 then
			var_26_0 = cc.TableViewCell:create()

			local var_26_2 = self:updateItemSprite(nil, var_25_1, arg_26_1 + 1)

			var_26_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_26_2:setPosition(cc.p(var_25_0:getContentSize().width / 2, var_25_1:getContentSize().height / 2 + 10))
			var_26_0:addChild(var_26_2)
		else
			self:updateItemSprite(var_26_0:getChildByName("sprite"), nil, arg_26_1 + 1)
		end

		return var_26_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.signView:registerScriptHandler(function(arg_28_0, arg_28_1)
		return #self.signList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.signView:reloadData()
end

function PopActivityBpSignLayer:updateItemSprite(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = self.signList[arg_29_3]

	if not arg_29_1 then
		arg_29_1 = arg_29_2:clone()

		arg_29_1:setVisible(true)
		arg_29_1:setName("sprite")
	end

	arg_29_1:getChildByName("num"):loadTexture(self.layerName .. "/" .. arg_29_3 .. ".png", var_0_4)

	local var_29_1 = activity_manager:isSignVip(self.activityId) == true
	local var_29_2 = arg_29_1:getChildByName("btn_sign")
	local var_29_3 = arg_29_1:getChildByName("sp_1")
	local var_29_4 = arg_29_1:getChildByName("sp_2")
	local var_29_5 = activity_manager:getSignDropByIndex(self.activityId, arg_29_3)
	local var_29_6 = activity_manager:getVipSignDropByIndex(self.activityId, arg_29_3)

	var_29_3:getChildByName("lock"):setScale(2)
	var_29_4:getChildByName("lock"):setScale(2)
	var_29_3:loadTexture("public/box/new_item_bg" .. item_data[var_29_5[1].dropid].equip_quality .. ".png", var_0_4)
	var_29_4:loadTexture("public/box/new_item_bg" .. item_data[var_29_6[1].dropid].equip_quality .. ".png", var_0_4)
	var_29_3:getChildByName("item"):loadTexture("equipment/" .. item_data[var_29_5[1].dropid].image_id .. ".png")
	var_29_4:getChildByName("item"):loadTexture("equipment/" .. item_data[var_29_6[1].dropid].image_id .. ".png")
	var_29_3:getChildByName("num"):setString("X" .. var_29_5[1].dropNum)
	var_29_4:getChildByName("num"):setString("X" .. var_29_6[1].dropNum)
	var_29_3:setTouchEnabled(true)
	var_29_3:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_30_0:getTouchBeganPosition().y - arg_30_0:getTouchEndPosition().y) > 50 then
			return
		end

		showItemDetails(var_29_5[1].dropid)
	end)
	var_29_4:setTouchEnabled(true)
	var_29_4:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_31_0:getTouchBeganPosition().y - arg_31_0:getTouchEndPosition().y) > 50 then
			return
		end

		if var_29_1 then
			showItemDetails(var_29_6[1].dropid)
		else
			self.buyPanel:setOpacity(0)
			self.buyPanel:setVisible(true)
			self.buyPanel:runAction(cc.FadeIn:create(0.2))

			return
		end
	end)

	if var_29_0 == var_0_9 then
		var_29_2:setVisible(false)
		var_29_3:getChildByName("lock"):setVisible(false)
		var_29_3:getChildByName("num"):setVisible(true)
		var_29_3:getChildByName("clip"):setVisible(false)
		var_29_3:getChildByName("got"):setVisible(true)
		var_29_4:getChildByName("lock"):setVisible(false)
		var_29_4:getChildByName("num"):setVisible(true)
		var_29_4:getChildByName("clip"):setVisible(false)
		var_29_4:getChildByName("got"):setVisible(true)
	elseif var_29_0 == var_0_8 then
		var_29_2:setVisible(true)
		var_29_2:loadTextures(self.layerName .. "/btn_sign_2.png", nil, self.layerName .. "/btn_sign_2.png", var_0_4)
		var_29_3:getChildByName("lock"):setVisible(false)
		var_29_3:getChildByName("num"):setVisible(true)
		var_29_3:getChildByName("clip"):setVisible(false)
		var_29_3:getChildByName("got"):setVisible(true)
		var_29_4:getChildByName("lock"):setVisible(not var_29_1)
		var_29_4:getChildByName("num"):setVisible(true)
		var_29_4:getChildByName("clip"):setVisible(false)
		var_29_4:getChildByName("got"):setVisible(false)
	elseif var_29_0 == var_0_7 then
		var_29_2:setVisible(true)
		var_29_2:loadTextures(self.layerName .. "/btn_sign.png", nil, self.layerName .. "/btn_sign.png", var_0_4)
		var_29_3:getChildByName("lock"):setVisible(false)
		var_29_3:getChildByName("num"):setVisible(true)
		var_29_3:getChildByName("clip"):setVisible(false)
		var_29_3:getChildByName("got"):setVisible(false)
		var_29_4:getChildByName("lock"):setVisible(not var_29_1)
		var_29_4:getChildByName("num"):setVisible(true)
		var_29_4:getChildByName("clip"):setVisible(false)
		var_29_4:getChildByName("got"):setVisible(false)
	elseif var_29_0 == var_0_6 then
		var_29_2:setVisible(true)
		var_29_2:loadTextures(self.layerName .. "/btn_supple.png", nil, self.layerName .. "/btn_supple.png", var_0_4)
		var_29_3:getChildByName("lock"):setVisible(false)
		var_29_3:getChildByName("num"):setVisible(true)
		var_29_3:getChildByName("clip"):setVisible(false)
		var_29_3:getChildByName("got"):setVisible(false)
		var_29_4:getChildByName("lock"):setVisible(not var_29_1)
		var_29_4:getChildByName("num"):setVisible(true)
		var_29_4:getChildByName("clip"):setVisible(false)
		var_29_4:getChildByName("got"):setVisible(false)
	elseif var_29_0 == var_0_5 then
		var_29_2:setVisible(true)
		var_29_2:loadTextures(self.layerName .. "/btn_advance.png", nil, self.layerName .. "/btn_advance.png", var_0_4)
		var_29_3:getChildByName("lock"):setVisible(false)
		var_29_3:getChildByName("num"):setVisible(true)
		var_29_3:getChildByName("clip"):setVisible(false)
		var_29_3:getChildByName("got"):setVisible(false)
		var_29_4:getChildByName("lock"):setVisible(not var_29_1)
		var_29_4:getChildByName("num"):setVisible(true)
		var_29_4:getChildByName("clip"):setVisible(false)
		var_29_4:getChildByName("got"):setVisible(false)
	end

	if activity_manager:isLoginBpSign(self.activityId) then
		if var_29_0 == var_0_5 or var_29_0 == var_0_9 then
			var_29_2:setVisible(false)
		else
			var_29_2:setVisible(true)
		end
	end

	var_29_2:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_29_0 == var_0_8 and not var_29_1 then
			self.buyPanel:setOpacity(0)
			self.buyPanel:setVisible(true)
			self.buyPanel:runAction(cc.FadeIn:create(0.2))

			return
		end

		activity_manager:activityBpSign(self.activityId, arg_29_3, var_29_0)
	end)

	return arg_29_1
end

function PopActivityBpSignLayer.updateShowingCells(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0, var_33_1 = GetTableViewShowCellIdx(arg_33_1, {
		maxcount = math.ceil(arg_33_2),
		cellsize = arg_33_1.cellsize
	})

	for iter_33_0 = var_33_0, var_33_1 do
		arg_33_1:updateCellAtIndex(iter_33_0)
	end
end

function PopActivityBpSignLayer:buyActivityItem(arg_34_1)
	activity_manager:buyActivityItem(self.activityId, tonumber(string.match(arg_34_1, "buy_(%d+)")) or 1)
end

function PopActivityBpSignLayer:initBg(arg_35_1)
	local var_35_0 = ccui.Layout:create()

	var_35_0:setTouchEnabled(true)
	var_35_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_35_0:setAnchorPoint(cc.p(0, 0))
	var_35_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_35_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_35_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_35_0:setOpacity(0)
	var_35_0:setCascadeOpacityEnabled(false)
	self:addChild(var_35_0, -1)

	local var_35_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_35_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_35_1:setPositionX(var_35_0:getContentSize().width / 2)
	var_35_1:setPositionY(var_35_0:getContentSize().height / 2)
	var_35_0:addChild(var_35_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_36_0)
		self:addChild(arg_36_0, -2)
		arg_36_0:setPositionY(arg_36_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_35_1)
		var_35_0:setOpacity(102)
		var_35_0:setTouchEnabled(false)
	end)
end
