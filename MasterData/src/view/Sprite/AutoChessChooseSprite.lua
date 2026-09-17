AutoChessChooseSprite = class("AutoChessChooseSprite", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")

function AutoChessChooseSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = AutoChessChooseSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AutoChessChooseSprite:init(arg_3_1)
	self.activityId = arg_3_1
	self.layerName = "AutoChessLayer_" .. self.activityId

	self:setVisible(false)
	self:setTouchEnabled(true)
	self:setBackGroundImage("public/panelbg/selector_bg.png", var_0_0)
	self:setBackGroundImageScale9Enabled(true)
	self:setAnchorPoint(cc.p(0.5, 0.5))
	self:setContentSize(cc.size(580, 560))

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))
	self.confirmPanel = self.rootLayer:getChildByName("confirm"):clone()

	self.confirmPanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.confirmPanel:setPosition(290, 280)
	self:addChild(self.confirmPanel, 200)

	local var_3_0 = ccui.ImageView:create(self.layerName .. "/title_select1.png", var_0_0)

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setPositionX(self:getContentSize().width / 2)
	var_3_0:setPositionY(500)
	self:addChild(var_3_0)

	local var_3_1 = ccui.ImageView:create(self.layerName .. "/close.png", var_0_0)

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(self:getContentSize().width - 25)
	var_3_1:setPositionY(self:getContentSize().height - 30)
	self:addChild(var_3_1)

	local var_3_2 = ccui.Button:create("public/button/public_button_orange.png", nil, "public/button/public_button_orange.png", var_0_0)

	var_3_2:setPosition(cc.p(425, 70))
	self:addChild(var_3_2)

	local var_3_3 = cc.Label:createWithTTF(L_EXPLORE_TASK.Sure_Btn, "fonts/name.ttf", 30)

	var_3_3:setColor(cc.c3b(0, 0, 0))
	var_3_3:setPosition(cc.p(var_3_2:getContentSize().width / 2, var_3_2:getContentSize().height / 2))
	var_3_2:addChild(var_3_3)
	var_3_2:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.chooseServant then
			return
		end

		activity_manager:activity_autochess_select(self.activityId, self.chooseServant)
	end)

	local var_3_4 = ccui.Button:create(self.layerName .. "/btn_re.png", nil, self.layerName .. "/btn_re.png", var_0_0)

	var_3_4:setPosition(cc.p(155, 70))
	self:addChild(var_3_4)

	local var_3_5 = ccui.ImageView:create("public/currency/" .. activity_manager:getAutoChessRefreshNeedItem(self.activityId) .. ".png", var_0_0)

	var_3_5:setScale(0.9)
	var_3_5:setPosition(cc.p(34, 45))
	var_3_4:addChild(var_3_5)

	local var_3_6 = cc.Label:createWithTTF(string.format(L_AUTO_CHESS.restart, activity_manager:getAutoChessReNeed(self.activityId)), "fonts/name.ttf", 30)

	var_3_6:setPosition(cc.p(var_3_4:getContentSize().width / 2 + 10, var_3_4:getContentSize().height / 2))
	var_3_4:addChild(var_3_6)
	var_3_4:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showConfirmPop()
	end)

	local var_3_7 = ccui.ImageView:create(self.layerName .. "/curr_bg.png", var_0_0)

	var_3_7:setPosition(cc.p(100, 525))
	var_3_7:setName("currencybg")
	self:addChild(var_3_7)

	local var_3_8 = activity_manager:getAutoChessSelectNeedItem(self.activityId)
	local var_3_9 = ccui.ImageView:create("public/currency/" .. var_3_8 .. ".png", var_0_0)

	var_3_9:setPosition(cc.p(17, 26))
	var_3_7:addChild(var_3_9)

	local var_3_10 = cc.Label:createWithTTF(item_manager:getItemNumber(var_3_8), FONT_NAME, 24)

	var_3_10:setPosition(cc.p(100, 26))
	var_3_10:setName("currNum")
	var_3_7:addChild(var_3_10)
	self:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:hide()
	end)
end

function AutoChessChooseSprite:update()
	self.selectList = {}

	local var_7_0 = activity_manager:getAutoChessSelectNeedItem(self.activityId)

	self:getChildByName("currencybg"):getChildByName("currNum"):setString(item_manager:getItemNumber(var_7_0))

	local var_7_1 = true
	local var_7_2 = activity_manager:getAutoChessRedomList(self.activityId)

	self.chooseServant = var_7_2[1]

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_3 = self:getChildByName("girlSprite_" .. iter_7_0)

		if var_7_3 then
			var_7_3:removeFromParent()
		end

		local var_7_4 = GirlSprite:create({
			initType = "arrayStyle"
		})

		var_7_4:setGetGirlServantRollFunc(function(arg_8_0)
			return require("data.servant_data")[arg_8_0].roll_rarity
		end)
		var_7_4:setScale(1.2)
		var_7_4:update(iter_7_1)
		var_7_4:setAnchorPoint(cc.p(0, 0))
		var_7_4:setPosition(cc.p(-173 + 190 * iter_7_0, 160))
		var_7_4:setName("girlSprite_" .. iter_7_0)
		var_7_4:getChildByName("rarityIcon"):setScale(1.08)
		var_7_4:imgScaleTo(1, 0)
		self:addChild(var_7_4)

		self.selectList[iter_7_0] = var_7_4

		var_7_4:getChildByName("lvLabel"):setString(activity_manager:getAutoChessLvByStar(1))

		local var_7_5 = ccui.ImageView:create(self.layerName .. "/select.png", var_0_0)

		var_7_5:setPosition(var_7_4:getContentSize().width / 2, var_7_4:getContentSize().height / 2)
		var_7_5:setLocalZOrder(30)
		var_7_5:setScale(0.85)
		var_7_5:setName("select")
		var_7_5:setVisible(self.chooseServant == iter_7_1 and var_7_1)
		var_7_4:addChild(var_7_5)

		if self.chooseServant == iter_7_1 then
			var_7_1 = false
		end

		local var_7_6 = L2Skeleton:create(UI_SPINE_PATH .. "autochess/linelight.json", UI_SPINE_PATH .. "autochess/linelight.atlas")

		var_7_6:refreshSkeleton()
		var_7_6.skeletonAnimation:setPositionX(var_7_4:getContentSize().width / 2)
		var_7_6.skeletonAnimation:setPositionY(var_7_4:getContentSize().height / 2)
		var_7_6:setName("upStarSpine")
		var_7_6:play("animation", true)
		var_7_6:setScale(0.85)
		var_7_6:setVisible(activity_manager:canAutoChessServantUpStar(self.activityId, iter_7_1))
		var_7_4:addChild(var_7_6)

		local var_7_7 = ccui.ImageView:create("public/currency/" .. var_7_0 .. ".png", var_0_0)

		var_7_7:setPosition(cc.p(55, -20))
		var_7_7:setScale(0.7)
		var_7_4:addChild(var_7_7)

		local var_7_8 = activity_manager:getAutoChessServantList(self.activityId)
		local var_7_9 = cc.Label:createWithTTF("X1", FONT_NAME, 20)

		if not var_7_8 or not next(var_7_8) then
			var_7_9:setString("X0")
		else
			var_7_9:setString("X1")
		end

		var_7_9:setPosition(cc.p(84, -20))
		var_7_4:addChild(var_7_9)
		var_7_4:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.chooseServant = iter_7_1

			for iter_9_0, iter_9_1 in pairs(self.selectList) do
				iter_9_1:getChildByName("select"):setVisible(false)
			end

			arg_9_0:getChildByName("select"):setVisible(true)
		end)
	end
end

function AutoChessChooseSprite:showConfirmPop()
	self.confirmPanel:setOpacity(0)
	self.confirmPanel:setVisible(true)
	self.confirmPanel:runAction(cc.FadeIn:create(0.2))

	local var_10_0 = self.confirmPanel:getChildByName("do_bg")
	local var_10_1 = var_10_0:getChildByName("des1")
	local var_10_2 = var_10_0:getChildByName("des2")
	local var_10_3 = var_10_0:getChildByName("des3")
	local var_10_4 = activity_manager:getAutoChessReNeed(self.activityId)
	local var_10_5 = activity_manager:getAutoChessRefreshNeedItem(self.activityId)

	var_10_4 = var_10_5 == 888888 and var_10_4 .. L_DIAMOND or var_10_4 .. item_data[var_10_5].name

	var_10_2:setString(var_10_4)
	var_10_3:setPositionX(var_10_2:getPositionX() + var_10_2:getContentSize().width + 3)
	var_10_0:getChildByName("btn_sure"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.chooseServant = nil

		activity_manager:activity_autochess_refresh(self.activityId)
		self.confirmPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			self.confirmPanel:setVisible(false)
		end)))
	end)
	var_10_0:getChildByName("btn_cancel"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.confirmPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			self.confirmPanel:setVisible(false)
		end)))
	end)
	self.confirmPanel:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.confirmPanel:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			self.confirmPanel:setVisible(false)
		end)))
	end)
end

function AutoChessChooseSprite:show()
	if self:isVisible() then
		self:hide()

		return
	end

	self:setVisible(true)
	self:setScaleY(0.1)
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.1, 1, 1)))
end

function AutoChessChooseSprite:hide()
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
		self:setVisible(false)
	end)))
end

return AutoChessChooseSprite
