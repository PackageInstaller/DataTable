PopSkinPackage = class("PopSkinPackage", function()
	return PopBaseLayer:create()
end)

function PopSkinPackage.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSkinPackage.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local audio_manager = require("controller.audio_manager")
local armature_manager = require("controller.armature_manager")
local lab_manager = require("controller.lab_manager")
local var_0_7 = config._DEBUG and 0 or 1

setmetatable({
	nil,
	"mainScenebg/market/",
	"mainScenebg/market/",
	"mainScenebg/market/"
}, {
	__index = function(arg_3_0, arg_3_1)
		return "equipment/"
	end
})

function PopSkinPackage:fullscreen()
	for iter_4_0, iter_4_1 in pairs({
		"giftimage"
	}) do
		local var_4_0 = self.rootpanel:getChildByName(iter_4_1)

		if var_4_0 ~= nil then
			var_4_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_4_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_4_0:setPositionY(var_4_0.full_posY)
		end
	end

	for iter_4_2, iter_4_3 in pairs({}) do
		local var_4_1 = self.rootpanel:getChildByName(iter_4_3)

		if var_4_1 ~= nil then
			var_4_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_4_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			var_4_1:setPositionY(var_4_1.full_posY)
		end
	end

	self.rootpanel:setPosition(cc.p(0, -GameDisplay.fix_y))
end

function PopSkinPackage:init(arg_5_1)
	local var_5_0 = ccui.Layout:create()

	var_5_0:setTouchEnabled(true)
	var_5_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_5_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_5_0:setBackGroundColorOpacity(180)
	self:addChild(var_5_0, 10)

	if arg_5_1.rootpos then
		var_5_0:setPositionY(var_5_0:getPositionY() + arg_5_1.rootpos)
	end

	self.rootpanel = var_5_0

	local var_5_1 = ccui.ImageView:create("mainScenebg/market/" .. item_data[arg_5_1.itemid].image_id .. ".png")

	var_5_1:setPosition(cc.p(var_5_0:getContentSize().width / 2, var_5_0:getContentSize().height / 2))
	var_5_1:setName("giftimage")
	var_5_0:addChild(var_5_1)
	self:initCostIcon(arg_5_1)

	local var_5_2 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", var_0_7)
	local var_5_3 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_5_3:setColor(cc.c3b(12, 12, 12))
	var_5_2:setPosition(cc.p(279, -70))
	var_5_3:setPosition(cc.p(var_5_2:getContentSize().width / 2, var_5_2:getContentSize().height / 2 - 5))
	var_5_2:addChild(var_5_3)
	var_5_1:addChild(var_5_2)
	var_5_2:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_5_1.ShopSliderCallback then
			arg_5_1.ShopSliderCallback(arg_6_0, arg_6_1, function()
				var_5_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
					LayerManager:removePopLayer(self.__queueindex)
				end)))
			end)
		end
	end)
	var_5_1:setScaleY(0)
	var_5_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_5_0:addTouchEventListener(function(arg_9_0, arg_9_1)
		var_5_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)
	self:fullscreen()
end

function PopSkinPackage:initCostIcon(arg_11_1)
	local var_11_0 = self.rootpanel:getChildByName("giftimage")

	if arg_11_1.slidecost.cost_old and arg_11_1.slidecost.costnum < arg_11_1.slidecost.cost_old then
		local var_11_1 = ccui.ImageView:create(arg_11_1.slidecost.costtype, var_0_7)

		var_11_1:setPositionX(259)
		var_11_1:setPositionY(-130)
		var_11_0:addChild(var_11_1)

		local var_11_2 = cc.Label:createWithTTF(arg_11_1.slidecost.cost_old, FONT_DES, 23)

		var_11_2:setAnchorPoint(cc.p(0, 0.5))
		var_11_2:setPositionX(var_11_1:getPositionX() + var_11_1:getContentSize().width / 2 + 5)
		var_11_2:setPositionY(var_11_1:getPositionY())
		var_11_0:addChild(var_11_2)

		local var_11_3 = ccui.ImageView:create("public/currency/discount_line.png", var_0_7)

		var_11_3:setPositionX((var_11_1:getPositionX() + var_11_2:getPositionX() + var_11_2:getContentSize().width / 2) / 2)
		var_11_3:setPositionY(var_11_1:getPositionY())
		var_11_0:addChild(var_11_3, 2)
	end

	local var_11_4 = -130 - 45
	local var_11_5 = ccui.ImageView:create(arg_11_1.slidecost.costtype, var_0_7)

	var_11_5:setPositionX(259)
	var_11_5:setPositionY(var_11_4)
	var_11_0:addChild(var_11_5)

	local var_11_6 = cc.Label:createWithTTF(arg_11_1.slidecost.costnum, FONT_DES, 23)

	var_11_6:setAnchorPoint(cc.p(0, 0.5))
	var_11_6:setPositionX(var_11_5:getPositionX() + var_11_5:getContentSize().width / 2 + 5)
	var_11_6:setPositionY(var_11_5:getPositionY())
	var_11_0:addChild(var_11_6)
end

function PopSkinPackage:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.msg and self.msg.callback then
			self.msg.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
