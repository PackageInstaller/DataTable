PopTwistEggCostTicketLayer = class("PopTwistEggCostTicketLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local var_0_2 = config._DEBUG and 0 or 1

function PopTwistEggCostTicketLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTwistEggCostTicketLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopTwistEggCostTicketLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.ImageView:create("public/panelbg/bg_pupup_level3.png", var_0_2)

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.rootpanel)
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
				self.exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)

	self.initParam = arg_3_1
	self.sureCallback = arg_3_1.sureCallback

	self:initUI()

	self.titleimg = ccui.ImageView:create("public/title/title_operation_comfirm.png", var_0_2)

	self.titleimg:setPosition(cc.p(96, 214))
	self.rootpanel:addChild(self.titleimg)

	self.sureBtn = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_2)

	self.sureBtn:setPositionX(self.rootpanel:getContentSize().width / 2)
	self.sureBtn:setPositionY(-self.sureBtn:getContentSize().height / 2)
	self.rootpanel:addChild(self.sureBtn)

	local var_3_0 = cc.Label:createWithTTF("扩 招", FONT_BUTTON, 32)

	var_3_0:setColor(cc.c3b(12, 12, 12))
	var_3_0:setPositionX(self.sureBtn:getContentSize().width / 2)
	var_3_0:setPositionY(self.sureBtn:getContentSize().height / 2 - 4)
	self.sureBtn:addChild(var_3_0)

	for iter_3_0, iter_3_1 in pairs(self.initParam.cost_ticket) do
		if iter_3_1.itemid == "diamond" then
			local var_3_1 = ccui.ImageView:create("public/currency/888888.png", var_0_2)

			var_3_1:setPositionX(self.sureBtn:getContentSize().width / 2)
			var_3_1:setPositionY(-20)
			self.sureBtn:addChild(var_3_1)

			local var_3_2 = cc.Label:createWithTTF(iter_3_1.num, FONT_DES, 24)

			var_3_2:setPositionX(self.sureBtn:getContentSize().width / 2)
			var_3_2:setPositionY(var_3_1:getPositionY())
			self.sureBtn:addChild(var_3_2)
			var_3_1:setPositionX(var_3_1:getPositionX() - var_3_2:getContentSize().width / 2)
			var_3_2:setPositionX(var_3_2:getPositionX() + var_3_1:getContentSize().width / 2)
		end
	end

	self.sureBtn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.sureCallback then
			self.sureCallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

local var_0_3 = {
	[1] = "equipment/1000001.png",
	diamond = "equipment/1000000.png"
}

setmetatable(var_0_3, {
	__index = function(arg_7_0, arg_7_1)
		return "equipment/" .. item_data[arg_7_1].image_id .. ".png"
	end
})

function PopTwistEggCostTicketLayer:initUI(...)
	self.desLabel = cc.Label:createWithTTF(L_TWISTEGG_COST_TICKET, FONT_DES, 24)

	self.desLabel:setMaxLineWidth(400)
	self.desLabel:setLineBreakWithoutSpace(true)
	self.desLabel:setAnchorPoint(cc.p(0, 1))
	self.desLabel:setPosition(cc.p(160, 160))
	self.rootpanel:addChild(self.desLabel)

	self.orgin_ticket_img = ccui.ImageView:create(var_0_3[self.initParam.orgin_ticket])

	self.orgin_ticket_img:setPosition(cc.p(100, 140))
	self.orgin_ticket_img:setScale(0.46)
	self.rootpanel:addChild(self.orgin_ticket_img)

	while self.initParam.cost_ticket[1] do
		local var_8_0

		if self.initParam.cost_ticket[1].itemid == self.initParam.orgin_ticket then
			table.remove(self.initParam.cost_ticket, 1)
		else
			var_8_0 = 1 + 1
		end
	end

	local var_8_1 = 500

	for iter_8_0, iter_8_1 in pairs(self.initParam.cost_ticket) do
		local var_8_2 = ccui.ImageView:create(var_0_3[iter_8_1.itemid])

		var_8_2:setPosition(cc.p((iter_8_0 * 2 - 1) / (#self.initParam.cost_ticket * 2) * var_8_1 + 70, 40))
		var_8_2:setScale(0.46)
		self.rootpanel:addChild(var_8_2)

		local var_8_3 = cc.Label:createWithTTF("X" .. iter_8_1.num, FONT_DES, 24)

		var_8_3:setPosition(cc.p((iter_8_0 * 2 - 1) / (#self.initParam.cost_ticket * 2) * var_8_1 + 70, var_8_2:getPositionY()))
		self.rootpanel:addChild(var_8_3)
		var_8_2:setPositionX(var_8_2:getPositionX() - var_8_3:getContentSize().width / 2)
		var_8_3:setPositionX(var_8_3:getPositionX() + var_8_2:getContentSize().width * var_8_2:getScale() / 2)
	end
end
