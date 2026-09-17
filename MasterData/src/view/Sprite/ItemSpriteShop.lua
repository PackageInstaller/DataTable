local var_0_0 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local component_effect_data = require("data.component_effect_data")
local component_manager = require("controller.component_manager")
local var_0_4 = require("data.item_data")
local var_0_5 = WEAPON_BG_QUALITY_PATH

ItemSpriteShop = class("ItemSpriteShop", function()
	return ccui.Button:create(var_0_5[1], var_0_5[1], var_0_5[1], var_0_0)
end)

local var_0_6 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_7 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 84, 0, 150)
}

function ItemSpriteShop:createSignItemByEntityid(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = self:createSignItem()

	var_2_0:updateSignItemByEntityid(arg_2_1, arg_2_2 or playerModel.items[arg_2_1].number, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function ItemSpriteShop:createSignItem(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	self = ItemSpriteShop.new()

	self:setAnchorPoint(cc.p(0.5, 0.5))

	self.scale = 0.7
	self.goto_back_system_id = arg_3_4

	self:setTouchEnabled(false)
	self:setScale(self.scale)

	self.iconScale = 1.2

	local var_3_0 = ccui.Layout:create()

	var_3_0:setName("cliplayer")
	var_3_0:setContentSize(cc.size(self:getContentSize().width, self:getContentSize().height))
	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height / 2))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_3_0:setClippingEnabled(false)
	self:addChild(var_3_0, 1)

	local var_3_1 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_3_1:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_1:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_1:setName("icon")
	var_3_0:addChild(var_3_1, 1)

	local var_3_2 = ccui.Text:create("x/y", FONT_NAME, 32)

	var_3_2:setPosition(cc.p(self:getContentSize().width / 2, 0))
	var_3_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_2:setName("numLabel")
	self:addChild(var_3_2, 3)

	local var_3_3 = ccui.ImageView:create("public/box/shop_itemsprite_num_bg.png", var_0_0)

	var_3_3:setName("numbg")
	var_3_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_3:setScale(1 / self.scale)
	var_3_3:setPosition(cc.p(self:getContentSize().width / 2, 0))
	self:addChild(var_3_3, 2)

	local var_3_4 = ccui.ImageView:create("public/panelbg/head_tag.png", var_0_0)

	var_3_4:setName("head_tag")
	var_3_4:setScale(0.8)
	var_3_4:setAnchorPoint(cc.p(0, 1))
	var_3_4:setPositionX(-4)
	var_3_4:setPositionY(var_3_0:getContentSize().height + 4)
	var_3_0:addChild(var_3_4, 2)

	local var_3_5 = ccui.ImageView:create("public/box/skin_icon.png", var_0_0)

	var_3_5:setName("skin_tag")
	var_3_5:setScale(0.8)
	var_3_5:setAnchorPoint(cc.p(0, 1))
	var_3_5:setPositionX(-4)
	var_3_5:setPositionY(var_3_0:getContentSize().height + 4)
	var_3_0:addChild(var_3_5, 2)

	if arg_3_1 then
		self:updateSignItemByItemid(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	end

	return self
end

function ItemSpriteShop:updateSignItemByEntityid(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	self:updateSignItemByItemid(playerModel.items[arg_4_1].itemid, arg_4_2 or playerModel.items[arg_4_1].number, arg_4_3, arg_4_4, arg_4_5)
end

function ItemSpriteShop:updateSignItemByItemid(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	self.ownNum = arg_5_2
	self.needNum = arg_5_3
	self.itemid = arg_5_1
	self.goto_back_system_id = arg_5_4 or self.goto_back_system_id
	self.item_attr = arg_5_7

	if self.itemid == "gold" then
		self.quality = 1
		self.path = "equipment/1000001.png"
		self.bagType = 88
	elseif self.itemid == "diamond" then
		self.quality = 6
		self.path = "equipment/1000000.png"
		self.bagType = 88
	elseif item_data[self.itemid].bag_item_type == kITEM_SCULTURE then
		self.quality = item_data[self.itemid].equip_quality
		self.path = "roleimage/role/wuji/" .. item_data[self.itemid].image_id .. ".png"
		self.bagType = item_data[self.itemid].bag_item_type
	elseif item_data[self.itemid].bag_item_type == kITEM_MEDAL then
		self.quality = item_data[self.itemid].equip_quality
		self.bagType = item_data[self.itemid].bag_item_type
	elseif item_data[self.itemid].bag_item_type == kITEM_COMPONENT then
		local var_5_0 = var_0_4[self.itemid]
		local var_5_1 = var_0_4[self.itemid].main_attr
		local var_5_2

		if self.item_attr then
			var_5_2 = component_manager:decode_component_config(self.item_attr)
		else
			local var_5_3 = component_manager:decode_component_config((string.format("effect=%d", var_0_4[self.itemid].effect1)))

			var_5_2 = var_5_3 and var_5_3.effect
		end

		self.path = var_5_2 and component_effect_data[var_5_2] and string.format("equipment/component/%d-%d-%d.png", component_effect_data[var_5_2].image_id, var_5_0.pos, var_5_1) or string.format("equipment/component/unknow-%d-1-%d.png", var_5_0.pos, var_5_1)
		self.quality = item_data[self.itemid].equip_quality
		self.bagType = item_data[self.itemid].bag_item_type
	else
		self.quality = item_data[self.itemid].equip_quality
		self.path = "equipment/" .. item_data[self.itemid].image_id .. ".png"
		self.bagType = item_data[self.itemid].bag_item_type
	end

	if ccui.Helper:seekWidgetByName(self, "medalbg") then
		ccui.Helper:seekWidgetByName(self, "medalbg"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self, "icon"):setVisible(true)

	if ccui.Helper:seekWidgetByName(self, "cliplayer"):getChildByName("avatarsp") then
		ccui.Helper:seekWidgetByName(self, "cliplayer"):removeChildByName("avatarsp")
	end

	if arg_5_6 then
		self:loadTextures(arg_5_6 .. self.quality .. ".png", arg_5_6 .. self.quality .. ".png", arg_5_6 .. self.quality .. ".png", var_0_0)
	else
		self:loadTextures(var_0_5[self.quality], var_0_5[self.quality], var_0_5[self.quality], var_0_0)
	end

	if arg_5_5 then
		ccui.Helper:seekWidgetByName(self, "icon"):loadTexture(arg_5_5)
	elseif item_data[arg_5_1].bag_item_type == kITEM_MEDAL or item_data[arg_5_1].bag_item_type == KITEM_SPRING_FESTIVAL_WORD then
		if not ccui.Helper:seekWidgetByName(self, "medalbg") then
			local var_5_4 = ccui.ImageView:create((item_data[arg_5_1].bg or nil) and ("equipment/" .. item_data[arg_5_1].bg .. ".png" or var_0_6[self.quality]))

			var_5_4:setPosition(ccui.Helper:seekWidgetByName(self, "icon"):getPosition())
			var_5_4:setName("medalbg")
			ccui.Helper:seekWidgetByName(self, "cliplayer"):addChild(var_5_4)

			if item_data[arg_5_1].bag_item_type == kITEM_MEDAL then
				local var_5_5 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_5_5:setName("medal")
				var_5_4:addChild(var_5_5, 1)
			else
				local var_5_7 = cc.Label:createWithTTF("", item_data[arg_5_1].word_font or FONT_DES, item_data[arg_5_1].word_font_size or 54)

				var_5_7:setName("medal")
				var_5_4:addChild(var_5_7, 1)
			end

			var_5_4:getChildByName("medal"):setVisible(item_data[arg_5_1].only_bg ~= 1)
		end

		ccui.Helper:seekWidgetByName(self, "medalbg"):setVisible(true)

		local var_5_8

		if item_data[arg_5_1].bg then
			var_5_8 = "equipment/" .. item_data[arg_5_1].bg .. ".png"

			if not ("equipment/" .. item_data[arg_5_1].bg .. ".png") then
				if item_data[arg_5_1].word_bg .. ".png" then
					var_5_8 = "equipment/" .. item_data[arg_5_1].word_bg .. ".png" or var_0_6[self.quality]
				end
			end
		end

		ccui.Helper:seekWidgetByName(self, "medalbg"):loadTexture(var_5_8)
		ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setString(item_data[arg_5_1].name)
		ccui.Helper:seekWidgetByName(self, "icon"):setVisible(false)
		ccui.Helper:seekWidgetByName(self, "medalbg"):setScale(0.64)

		local var_5_9 = item_data[arg_5_1].word_offset_x or 0
		local var_5_10 = item_data[arg_5_1].word_offset_y or 0
		local var_5_11 = item_data[arg_5_1].word_color or "255,255,255"
		local var_5_12 = cc.c3b(string.split(var_5_11, ",")[1], string.split(var_5_11, ",")[2], string.split(var_5_11, ",")[3])

		if item_data[arg_5_1].bag_item_type == kITEM_MEDAL then
			local var_5_13 = ccui.Helper:seekWidgetByName(self, "medalbg")

			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setAnchorPoint(cc.p(0.5, 0.5))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setPosition(cc.p(var_5_13:getContentSize().width / 2 + 5, var_5_13:getContentSize().height / 2 - 5))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):enableOutline(var_0_7[self.quality], 1)
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):enableShadow(var_0_7[self.quality], cc.size(0, 0))
		else
			local var_5_14 = ccui.Helper:seekWidgetByName(self, "medalbg")

			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setAnchorPoint(cc.p(0.5, 0.5))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setPosition(cc.p(var_5_14:getContentSize().width / 2 + var_5_9, var_5_14:getContentSize().height / 2 + var_5_10))
			ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):enableShadow(cc.c4b(0, 0, 0, 150), cc.size(1, -1))
		end

		ccui.Helper:seekWidgetByName(self, "medalbg"):getChildByName("medal"):setColor(var_5_12)
	else
		ccui.Helper:seekWidgetByName(self, "icon"):loadTexture(self.path)
	end

	ccui.Helper:seekWidgetByName(self, "icon"):setScale(global_get_item_scale(ccui.Helper:seekWidgetByName(self, "icon"), self.bagType) * self.iconScale)

	ccui.Helper:seekWidgetByName(self, "icon").afterLoadSuccess = function(self, arg_6_1)
		self:setScale(global_get_item_scale(self, self.bagType) * self.iconScale)
	end

	self:getChildByName("numLabel"):setColor(cc.c3b(255, 255, 255))

	if arg_5_3 and arg_5_2 then
		self:getChildByName("numLabel"):setVisible(true)
		self:getChildByName("numLabel"):setString(global_trans_number(arg_5_2) .. "/" .. global_trans_number(arg_5_3))

		if arg_5_2 < arg_5_3 then
			self:getChildByName("numLabel"):setColor(cc.c3b(255, 55, 55))
		else
			self:getChildByName("numLabel"):setColor(cc.c3b(61, 255, 107))
		end
	elseif not arg_5_3 and arg_5_2 then
		self:getChildByName("numLabel"):setVisible(true)

		if arg_5_2 == 1 then
			self:getChildByName("numLabel"):setString(item_data[self.itemid].name .. "x" .. global_trans_number(arg_5_2))
		else
			self:getChildByName("numLabel"):setString(item_data[self.itemid].name .. "x" .. global_trans_number(arg_5_2))
		end
	else
		self:getChildByName("numLabel"):setVisible(false)
	end

	self:getChildByName("numLabel"):setScaleX(self:getChildByName("numLabel"):getContentSize().width <= 250 and 1 or 250 / self:getChildByName("numLabel"):getContentSize().width)
	ccui.Helper:seekWidgetByName(self, "head_tag"):setVisible(false)

	if item_data[arg_5_1].bag_item_type == kITEM_SCULTURE then
		ccui.Helper:seekWidgetByName(self, "head_tag"):setVisible(true)

		local var_5_17 = AvatarSprite:create(self.itemid)

		var_5_17:setName("avatarsp")
		ccui.Helper:seekWidgetByName(self, "cliplayer"):addChild(var_5_17)
		ccui.Helper:seekWidgetByName(self, "icon"):setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self, "skin_tag"):setVisible(item_data[arg_5_1].bag_item_type == kITEM_SKIN)

	if self:getChildByName("starsPanel") then
		self:getChildByName("starsPanel"):setName("starsPanelold")
		self:getChildByName("starsPanelold"):removeFromParent()
	end

	if item_data[self.itemid].bag_item_type == kITEM_HORCRUX and self.item_attr then
		local var_5_18 = 1

		for iter_5_0, iter_5_1 in self.item_attr:gmatch("([^&]+)=([^&]+)") do
			if iter_5_0 == "star" then
				var_5_18 = tonumber(iter_5_1)
			end
		end

		local var_5_19 = ccui.Layout:create()

		var_5_19:setName("starsPanel")
		var_5_19:setPosition(cc.p(0, 0))
		self:addChild(var_5_19, 5)

		for iter_5_2 = 1, var_5_18 do
			local var_5_20

			if config._DEBUG then
				var_5_20 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			local var_5_21 = 80

			var_5_20:setScale(0.4)
			var_5_20:setPosition(var_5_21, (iter_5_2 - 1) * 13 + 30)
			var_5_19:addChild(var_5_20)
		end
	end
end

function ItemSpriteShop:setInfoTouchEvent(arg_7_1)
	self:setTouchEnabled(arg_7_1)
	self:addTouchEventListener((function()
		return function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_9_0:getTouchBeganPosition().y - arg_9_0:getTouchEndPosition().y) > 50 then
				return
			end

			if not arg_9_0.itemid then
				return
			end

			if type(arg_9_0.itemid) ~= "number" then
				return
			end

			if arg_9_0.ownNum and arg_9_0.needNum then
				if arg_9_0.ownNum < arg_9_0.needNum then
					if self.gotoSystemCallback then
						self.gotoSystemCallback(arg_9_0.itemid)
					end

					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_9_0.itemid,
						goto_back_system_id = self.goto_back_system_id,
						layer = cc.Layer:create()
					})
				elseif item_data[arg_9_0.itemid].bag_item_type == kITEM_CHOOSE_GIFT then
					LayerManager:pushInLayer("PopOpenChoosegiftLayer", {
						itemid = arg_9_0.itemid
					})
				else
					local var_9_0 = {
						hideGainButton = true,
						itemid = arg_9_0.itemid,
						goto_back_system_id = self.goto_back_system_id
					}

					var_9_0.layer = cc.Layer:create()

					local var_9_1 = PopLayer:Item(var_9_0)
				end
			elseif item_data[arg_9_0.itemid].bag_item_type == kITEM_CHOOSE_GIFT then
				LayerManager:pushInLayer("PopOpenChoosegiftLayer", {
					itemid = arg_9_0.itemid
				})
			else
				local var_9_2 = {
					hideGainButton = true,
					itemid = arg_9_0.itemid,
					goto_back_system_id = self.goto_back_system_id
				}

				var_9_2.layer = cc.Layer:create()

				local var_9_3 = PopLayer:Item(var_9_2)
			end

			if self.register_touch_callback then
				self.register_touch_callback()
			end
		end
	end)())
end

function ItemSpriteShop.registerTouchCallback(arg_10_0, arg_10_1)
	arg_10_0.register_touch_callback = arg_10_1
end

function ItemSpriteShop.registerGotoSystemCallback(arg_11_0, arg_11_1)
	arg_11_0.gotoSystemCallback = arg_11_1
end
