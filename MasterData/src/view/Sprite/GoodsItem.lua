local GoodsItem = class("GoodsItem", function()
	return ccui.Widget:create()
end)
local var_0_1 = config._DEBUG and 0 or 1
local component_effect_data = require("data.component_effect_data")

require("view.Layer.Pops.PopItemLayer")
require("view.Sprite.AvatarSprite")

local TempWidget = require("view.Sprite.TempWidget")

require("view.Sprite.NodeEx"):extend(GoodsItem)

local item_data = require("data.item_data")
local var_0_5 = tonumber
local var_0_6 = string
local var_0_7 = math
local var_0_8 = global_trans_number
local var_0_9 = 1
local var_0_10 = 4

GoodsItem.SpecialID = {
	Diamond = 0
}
GoodsItem.ShowType = {
	Type_3 = 3,
	Type_1 = 1,
	Type_4 = 4,
	Type_2 = 2
}
GoodsItem.Size = {
	[GoodsItem.ShowType.Type_1] = cc.size(170, 170),
	[GoodsItem.ShowType.Type_2] = cc.size(170, 170),
	[GoodsItem.ShowType.Type_3] = cc.size(170, 170),
	[GoodsItem.ShowType.Type_4] = cc.size(170, 170)
}
GoodsItem.QualityBg = {
	[GoodsItem.ShowType.Type_1] = {
		"public/box/box_activity_recharge_1.png",
		"public/box/box_activity_recharge_2.png",
		"public/box/box_activity_recharge_3.png",
		"public/box/box_activity_recharge_4.png",
		"public/box/box_activity_recharge_5.png",
		"public/box/box_activity_recharge_6.png"
	},
	[GoodsItem.ShowType.Type_2] = {},
	[GoodsItem.ShowType.Type_3] = {},
	[GoodsItem.ShowType.Type_4] = {}
}
GoodsItem.MedalColors = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function GoodsItem:ctor()
	return
end

function GoodsItem:create(arg_3_1)
	local var_3_0 = GoodsItem.new()

	if var_3_0 and var_3_0:init(arg_3_1) then
		return var_3_0
	end

	return nil
end

function GoodsItem:init(arg_4_1)
	if not self:initParam(arg_4_1) then
		return false
	end

	self:initLayout()

	return true
end

function GoodsItem:initParam(arg_5_1)
	self._showType = var_0_5(arg_5_1.showType) or GoodsItem.ShowType.Type_1
	self._showType = var_0_7.ceil(self._showType)

	if self._showType < var_0_9 or self._showType > var_0_10 then
		return false
	end

	self._itemId = var_0_5(arg_5_1.itemId)

	if not self._itemId then
		return false
	end

	self._itemCount = arg_5_1.count or 1
	self._countTextColor = arg_5_1.countTextColor or "#FFFFFF"
	self._countTextSize = arg_5_1.countTextSize or 36
	self._countTextVisible = arg_5_1.countTextVisible or true
	self._countTextForcedDisplay = arg_5_1.countTextForcedDisplay or false

	return true
end

function GoodsItem:initLayout()
	self:initSize()

	local var_6_0 = TempWidget:CreateTempLayout()

	self._layout = var_6_0

	if not item_data[self._itemId] then
		var_6_0:setContentSize(cc.size(self._width, self._height))
		self:addChild(var_6_0)

		return
	end

	local var_6_1 = TempWidget:CreateTempImg(self:getQualityBgPath(), nil, var_0_1)

	var_6_1:setScale9Enabled(true)
	var_6_1:setCapInsets(cc.rect(0, 0, var_6_1:size().w, var_6_1:size().h))
	var_6_1:setContentSize(cc.size(self._width, self._height))

	self._itemBg = var_6_1

	if item_data[self._itemId].bag_item_type == kITEM_MEDAL then
		var_6_1:hide()
	end

	var_6_0:setContentSize(cc.size(self._width, self._height))
	self:addChild(var_6_0)
	var_6_0:align(cc.p(0, 0), 0, 0)
	var_6_0:addChild(var_6_1)
	var_6_1:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

	local var_6_2, var_6_3 = self:getItemIconPath()
	local var_6_4

	if type(var_6_2) == "string" then
		var_6_4 = TempWidget:CreateTempImg(var_6_2, var_6_0, var_6_3)

		var_6_4:align(cc.p(0.5, 0.5), var_6_0:size().w / 2, var_6_0:size().h / 2)

		local var_6_5 = var_6_4:getContentSize()

		if var_6_5.width > self._width or var_6_5.height > self._height then
			var_6_4:setScale(var_0_7.min(self._width / var_6_5.width, self._height / var_6_5.height) - 0.1)
		end
	elseif type(var_6_2) == "userdata" then
		var_6_4 = var_6_2

		var_6_0:addChild(var_6_2)

		local var_6_6 = var_6_4:getContentSize()
		local var_6_7 = var_6_0:size()

		var_6_4:setPosition(cc.p(23, 0))
		var_6_4:setScale(225 / var_6_6.width, 230 / var_6_6.height)

		if item_data[self._itemId].spine then
			-- block empty
		end
	end

	self._itemIcon = var_6_4

	local var_6_8 = TempWidget:CreateTempLabel("x" .. var_0_8(self._itemCount), FONT_BUTTON, self._countTextSize, var_6_0)

	var_6_8:_setColor(self._countTextColor)
	var_6_8:align(cc.p(1, 0), var_6_0:size().w, 0)

	self._countText = var_6_8

	self:updateCountTextVisible()

	local var_6_9 = self:getMedalText()

	if var_6_9 then
		var_6_0:addChild(var_6_9)
		var_6_9:align(cc.p(0.5, 0.5), var_6_0:size().w / 2 + 5, var_6_0:size().h / 2 - 5)

		self._medalText = var_6_9
	end

	self:registerBtnClickEvent()
end

function GoodsItem:initSize()
	self:setAnchorPoint(cc.p(0, 0))
	self:setContentSize(GoodsItem.Size[self._showType])

	self._width = self:size().w
	self._height = self:size().h
end

function GoodsItem:getQualityBgPath()
	local var_8_1 = var_0_5(item_data[self._itemId].equip_quality or 1)

	return GoodsItem.QualityBg[self._showType][(GoodsItem.SpecialID.Diamond == self._itemId or nil) and 5]
end

function GoodsItem:getItemIconPath()
	if GoodsItem.SpecialID.Diamond == self._itemId then
		return "equipment/1000000.png", 0
	end

	if item_data[self._itemId] then
		if item_data[self._itemId].bag_item_type == kITEM_COMPONENT then
			if item_data[self._itemId].effect1 and component_effect_data[item_data[self._itemId].effect1] and component_effect_data[item_data[self._itemId].effect1].image_id and item_data[self._itemId].pos and item_data[self._itemId].main_attr then
				return var_0_6.format("equipment/component/%d-%d-%d.png", component_effect_data[item_data[self._itemId].effect1].image_id, item_data[self._itemId].pos, item_data[self._itemId].main_attr), 0
			end
		elseif item_data[self._itemId].bag_item_type == kITEM_MEDAL then
			if item_data[self._itemId].bg then
				return "equipment/" .. item_data[self._itemId].bg .. ".png", 0
			end
		elseif item_data[self._itemId].bag_item_type == kITEM_SCULTURE then
			return AvatarSprite:create(self._itemId)
		elseif item_data[self._itemId].image_id then
			return "equipment/" .. item_data[self._itemId].image_id .. ".png", 0
		end
	end

	return "equipment/unkonw.png", 0
end

function GoodsItem:registerBtnClickEvent()
	local var_10_0 = TempWidget:CreateTempBtn()

	var_10_0:ignoreContentAdaptWithSize(false)

	if self._itemBg and not self._itemBg:isVisible() then
		if self._itemIcon then
			var_10_0:setContentSize(self._itemIcon:getContentSize())
		end
	else
		var_10_0:setContentSize(self:size())
	end

	var_10_0:setSwallowTouches(true)
	self:addChild(var_10_0)
	var_10_0:align(cc.p(0.5, 0.5), self:size().w / 2, self:size().h / 2)
	var_10_0:_addSuperEvent(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == TempWidget.Click then
			if GoodsItem.SpecialID.Diamond == self._itemId then
				return
			end

			PopLayer:Item({
				itemid = self._itemId
			})
		end
	end, {})

	self.touchBtn = var_10_0
end

function GoodsItem:unRegisterBtnClickEvent()
	ScriptHandlerMgr:getInstance():removeObjectAllHandlers(self.touchBtn)
	self.touchBtn:_addSuperEvent(function()
		return
	end, {})
	self.touchBtn:setSwallowTouches(false)
end

function GoodsItem:updateCountTextVisible()
	if self._countTextForcedDisplay then
		self._countText:show()
	elseif self._countTextVisible then
		if self._itemCount > 1 then
			self._countText:show()
		else
			self._countText:hide()
		end
	else
		self._countText:hide()
	end
end

function GoodsItem:setButtonSwallowTouches(arg_15_1)
	self.touchBtn:setSwallowTouches(arg_15_1)
end

function GoodsItem:setBgVisible(arg_16_1)
	if self._itemBg then
		self._itemBg:setVisible(arg_16_1)

		if self.touchBtn then
			if not self._itemBg:isVisible() then
				if self._itemIcon then
					self.touchBtn:setContentSize(self._itemIcon:getContentSize())
				end
			else
				self.touchBtn:setContentSize(self:size())
			end
		end
	end
end

function GoodsItem:getMedalText()
	local var_17_0

	if item_data[self._itemId] then
		if item_data[self._itemId].bag_item_type == kITEM_MEDAL then
			if item_data[self._itemId].name then
				var_17_0 = TempWidget:CreateTempLabel(item_data[self._itemId].name, FONT_DES, 54)

				var_17_0:enableOutline(self.MedalColors[item_data[self._itemId].equip_quality], 1)
				var_17_0:enableShadow(self.MedalColors[item_data[self._itemId].equip_quality], cc.size(0, 0))
			end
		end
	end

	return var_17_0
end

function GoodsItem:setCountTextScale(arg_18_1)
	self._countText:setScale(arg_18_1)
end

return GoodsItem
