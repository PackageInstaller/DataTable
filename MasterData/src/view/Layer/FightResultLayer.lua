require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local var_0_1 = {
	QuickFight = {
		creatItemType = "entityid",
		bg = {
			cc.p(320, 568),
			"fightresult/fightresult_bg.png",
			cc.size(466, 716)
		},
		title = {
			{
				cc.p(-16, 686),
				cc.p(0, 0),
				"fightresult/fightresult_quickfight.png"
			},
			{
				cc.p(466, 766),
				cc.p(0.5, 0.5),
				CUTE_ROLE_IMAGE_PATH .. "101.png",
				0.5
			}
		},
		infos = {
			{
				title = {
					L_FIGHT_RESULT_TITLE.Hangup_Title[1] .. ": ",
					cc.c3b(146, 192, 255),
					26
				},
				info = function(self)
					local var_1_1 = cc.Label:createWithTTF(self.time or "", FONT_DES, 26)

					var_1_1:setAnchorPoint(cc.p(0, 0.5))

					return var_1_1
				end
			},
			{
				title = {
					L_FIGHT_RESULT_TITLE.Hangup_Title[2] .. ": ",
					cc.c3b(146, 192, 255),
					26
				},
				info = function(self)
					local var_2_1 = cc.Label:createWithTTF(self.levelinfo or "", FONT_DES, 26)

					var_2_1:setAnchorPoint(cc.p(0, 0.5))

					return var_2_1
				end
			},
			{
				title = {
					L_FIGHT_RESULT_TITLE.Hangup_Title[3] .. ": ",
					cc.c3b(146, 192, 255),
					26
				},
				info = function(self)
					local var_3_0 = self.sp
					local var_3_1 = cc.Node:create()
					local var_3_2 = 0
					local var_3_3

					if config._DEBUG then
						var_3_3 = cc.Sprite:create(IMAGE_STRENGTHPOINT) or cc.Sprite:createWithSpriteFrameName(IMAGE_STRENGTHPOINT)
					end

					var_3_3:setAnchorPoint(cc.p(0, 0.5))
					var_3_3:setPosition(cc.p(var_3_2, 0))
					var_3_3:setScale(0.9)
					var_3_1:addChild(var_3_3)

					local var_3_4 = var_3_2 + var_3_3:getContentSize().width
					local var_3_5 = cc.Label:createWithTTF(global_trans_number(var_3_0), FONT_DES, 26)

					var_3_5:setColor(cc.c3b(255, 162, 0))
					var_3_5:setAnchorPoint(cc.p(0, 0.5))
					var_3_5:setPosition(cc.p(var_3_4, 0))
					var_3_1:addChild(var_3_5)

					local var_3_6 = var_3_4 + var_3_5:getContentSize().width + 15
					local var_3_7

					if config._DEBUG then
						var_3_7 = cc.Sprite:create(IMAGE_GOLD) or cc.Sprite:createWithSpriteFrameName(IMAGE_GOLD)
					end

					var_3_7:setAnchorPoint(cc.p(0, 0.5))
					var_3_7:setPosition(cc.p(var_3_6, 0))
					var_3_7:setScale(0.9)
					var_3_1:addChild(var_3_7)

					local var_3_8 = cc.Label:createWithTTF(global_trans_number(self.gold), FONT_DES, 26)

					var_3_8:setColor(cc.c3b(255, 162, 0))
					var_3_8:setAnchorPoint(cc.p(0, 0.5))
					var_3_8:setPosition(cc.p(var_3_6 + var_3_7:getContentSize().width, 0))
					var_3_1:addChild(var_3_8)

					return var_3_1
				end
			}
		},
		button = {
			textures = {
				SINGLE_YELLOW_BUTTON,
				SINGLE_YELLOW_BUTTON_ON,
				SINGLE_YELLOW_BUTTON
			},
			size = cc.size(380, 80),
			title = L_BUTTON_TEXT.Sure,
			listener = function(arg_4_0, arg_4_1)
				return function(arg_5_0, arg_5_1)
					if arg_5_1 ~= ccui.TouchEventType.ended then
						return
					end

					arg_4_0:runAction(cc.RemoveSelf:create())

					if arg_4_1.surecallback then
						arg_4_1.surecallback()
					end
				end
			end
		}
	},
	DropCache = {
		createItemType = "itemid",
		bg = {
			cc.p(320, 568),
			"fightresult/fightresult_bg.png",
			cc.size(466, 716)
		},
		title = {
			{
				cc.p(-16, 686),
				cc.p(0, 0),
				"fightresult/fightresult_quickfight.png"
			},
			{
				cc.p(466, 766),
				cc.p(0.5, 0.5),
				CUTE_ROLE_IMAGE_PATH .. "101.png",
				0.5
			}
		},
		infos = {
			{
				title = {
					L_FIGHT_RESULT_TITLE.Drop_Title[1],
					cc.c3b(146, 192, 255),
					26
				},
				info = function()
					local playermodel = require("model.playermodel")
					local var_6_1 = cc.Label:createWithTTF(string.format("%d/%d", playermodel.dropcacheweight.weight, playermodel.dropcacheweight.limit), FONT_DES, 26)

					var_6_1:setAnchorPoint(cc.p(0, 0.5))

					return var_6_1
				end
			}
		},
		button = {
			textures = {
				SINGLE_YELLOW_BUTTON,
				SINGLE_YELLOW_BUTTON_ON,
				SINGLE_YELLOW_BUTTON
			},
			size = cc.size(380, 80),
			title = L_FIGHT_RESULT_TITLE.Drop_Title[2],
			listener = function(arg_7_0, arg_7_1)
				return function(arg_8_0, arg_8_1)
					if arg_8_1 ~= ccui.TouchEventType.ended then
						return
					end

					if not arg_8_0:isBright() then
						return
					end

					arg_8_0:setBright(false)
					require("controller.dropcache_manager"):harvestCache(function(arg_9_0, arg_9_1)
						arg_7_0:harvestAction(arg_9_1)

						if arg_7_1.surecallback then
							arg_7_1.surecallback()
						end
					end)
				end
			end
		}
	},
	OfflineFight = {
		bg = {
			cc.p(320, 568),
			"fightresult/fightresult_bg.png",
			cc.size(466, 278)
		},
		title = {
			{
				cc.p(-16, 248),
				cc.p(0, 0),
				"fightresult/fightresult_quickfight.png"
			},
			{
				cc.p(466, 328),
				cc.p(0.5, 0.5),
				CUTE_ROLE_IMAGE_PATH .. "101.png",
				0.5
			}
		},
		infos = {
			{
				title = {
					L_FIGHT_RESULT_TITLE.Offline_Title[1],
					cc.c3b(146, 192, 255),
					26
				},
				info = function(self)
					local var_10_1 = cc.Label:createWithTTF(self.time or "", FONT_DES, 26)

					var_10_1:setAnchorPoint(cc.p(0, 0.5))

					return var_10_1
				end
			},
			{
				title = {
					L_FIGHT_RESULT_TITLE.Offline_Title[2],
					cc.c3b(146, 192, 255),
					26
				},
				info = function(self)
					local var_11_1 = cc.Label:createWithTTF(self.levelinfo or "", FONT_DES, 26)

					var_11_1:setAnchorPoint(cc.p(0, 0.5))

					return var_11_1
				end
			},
			{
				title = {
					L_FIGHT_RESULT_TITLE.Offline_Title[3],
					cc.c3b(146, 192, 255),
					26
				},
				info = function(self)
					local var_12_0 = self.sp
					local var_12_1 = cc.Node:create()
					local var_12_2 = 0
					local var_12_3

					if config._DEBUG then
						var_12_3 = cc.Sprite:create(IMAGE_STRENGTHPOINT) or cc.Sprite:createWithSpriteFrameName(IMAGE_STRENGTHPOINT)
					end

					var_12_3:setAnchorPoint(cc.p(0, 0.5))
					var_12_3:setPosition(cc.p(var_12_2, 0))
					var_12_3:setScale(0.9)
					var_12_1:addChild(var_12_3)

					local var_12_4 = var_12_2 + var_12_3:getContentSize().width
					local var_12_5 = cc.Label:createWithTTF(global_trans_number(var_12_0), FONT_DES, 26)

					var_12_5:setColor(cc.c3b(255, 162, 0))
					var_12_5:setAnchorPoint(cc.p(0, 0.5))
					var_12_5:setPosition(cc.p(var_12_4, 0))
					var_12_1:addChild(var_12_5)

					local var_12_6 = var_12_4 + var_12_5:getContentSize().width + 15
					local var_12_7

					if config._DEBUG then
						var_12_7 = cc.Sprite:create(IMAGE_GOLD) or cc.Sprite:createWithSpriteFrameName(IMAGE_GOLD)
					end

					var_12_7:setAnchorPoint(cc.p(0, 0.5))
					var_12_7:setPosition(cc.p(var_12_6, 0))
					var_12_7:setScale(0.9)
					var_12_1:addChild(var_12_7)

					local var_12_8 = cc.Label:createWithTTF(global_trans_number(self.gold), FONT_DES, 26)

					var_12_8:setColor(cc.c3b(255, 162, 0))
					var_12_8:setAnchorPoint(cc.p(0, 0.5))
					var_12_8:setPosition(cc.p(var_12_6 + var_12_7:getContentSize().width, 0))
					var_12_1:addChild(var_12_8)

					return var_12_1
				end
			}
		},
		button = {
			textures = {
				SINGLE_YELLOW_BUTTON,
				SINGLE_YELLOW_BUTTON_ON,
				SINGLE_YELLOW_BUTTON
			},
			size = cc.size(380, 80),
			title = L_BUTTON_TEXT.Sure,
			listener = function(arg_13_0)
				return function(arg_14_0, arg_14_1)
					if arg_14_1 ~= ccui.TouchEventType.ended then
						return
					end

					arg_13_0:runAction(cc.RemoveSelf:create())
				end
			end
		}
	}
}
local var_0_2 = config._DEBUG and 0 or 1

local function var_0_3(arg_15_0, arg_15_1, arg_15_2)
	local var_15_1 = ccui.ImageView:create(arg_15_1, (arg_15_1:find("mainScenebg") or nil) and 0)

	if arg_15_2 then
		var_15_1:setScale9Enabled(true)
		var_15_1:setContentSize(arg_15_2)
	end

	var_15_1:setPosition(arg_15_0)
	var_15_1:setTouchEnabled(true)

	return var_15_1
end

local function var_0_4(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_1 = ccui.ImageView:create(arg_16_2, (arg_16_2:find("role") or nil) and 0)

	var_16_1:setAnchorPoint(arg_16_1)
	var_16_1:setPosition(arg_16_0)

	arg_16_3 = arg_16_3 or 1

	var_16_1:setScale(arg_16_3)

	return var_16_1
end

local function var_0_5(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = ccui.Layout:create()

	var_17_0:setContentSize(cc.size(436, 60))
	var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_17_0:setBackGroundColor(cc.c3b(15, 15, 15))
	var_17_0:setBackGroundColorOpacity(178.5)
	var_17_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_17_1 = cc.Label:createWithTTF(arg_17_0[1], FONT_DES, arg_17_0[3])

	var_17_1:setAnchorPoint(cc.p(0, 0.5))
	var_17_1:setPosition(cc.p(20, var_17_0:getContentSize().height / 2))
	var_17_1:setColor(arg_17_0[2])
	var_17_0:addChild(var_17_1)

	if type(arg_17_1) == "function" then
		local var_17_2 = arg_17_1(arg_17_2)

		var_17_2:setPosition(cc.p(var_17_1:getContentSize().width + 20, var_17_0:getContentSize().height / 2))
		var_17_0:addChild(var_17_2)
	elseif type(arg_17_1) == "string" then
		-- block empty
	end

	return var_17_0
end

local function var_0_6(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ccui.Button:create(arg_18_0[1], arg_18_0[2], arg_18_0[3], var_0_2)

	var_18_0:setPressedActionEnabled(true)

	if arg_18_2 then
		var_18_0:setScale9Enabled(true)
		var_18_0:setContentSize(arg_18_2)
	end

	if arg_18_1 then
		local var_18_1 = cc.Label:createWithTTF(arg_18_1, FONT_BUTTON, 26)

		var_18_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_18_1:setColor(cc.c3b(15, 15, 15))
		var_18_1:setPosition(cc.p(var_18_0:getContentSize().width / 2, var_18_0:getContentSize().height / 2))
		var_18_0:addChild(var_18_1)
	end

	return var_18_0
end

local FightResultLayer = class("FightResultLayer", function()
	return ccui.Layout:create()
end)

function FightResultLayer:create(arg_20_1, arg_20_2)
	local var_20_0 = FightResultLayer.new()

	var_20_0:init(arg_20_1, arg_20_2)

	return var_20_0
end

function FightResultLayer:ctor()
	self:setContentSize(cc.size(SCREEN_WIDTH, SCREEN_HEIGHT))
	self:setTouchEnabled(true)
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self:setBackGroundColor(cc.c3b(15, 15, 15))
	self:setCascadeOpacityEnabled(false)
	self:setBackGroundColorOpacity(150)
	self:setAnchorPoint(cc.p(0.5, 0.5))
	self:setPosition(cc.p(320, 568))
end

function FightResultLayer:init(arg_22_1, arg_22_2)
	local var_22_0 = var_0_3(var_0_1[arg_22_1].bg[1], var_0_1[arg_22_1].bg[2], var_0_1[arg_22_1].bg[3])

	self:addChild(var_22_0)

	local var_22_1 = var_22_0:getContentSize().width / 2
	local var_22_2 = var_22_0:getContentSize().height - 60

	if var_0_1[arg_22_1].title then
		for iter_22_0, iter_22_1 in ipairs(var_0_1[arg_22_1].title) do
			var_22_0:addChild(var_0_4(iter_22_1[1], iter_22_1[2], iter_22_1[3], iter_22_1[4]), 5)
		end
	end

	if var_0_1[arg_22_1].infos then
		for iter_22_2, iter_22_3 in ipairs(var_0_1[arg_22_1].infos) do
			local var_22_3 = var_0_5(iter_22_3.title, iter_22_3.info, arg_22_2)

			var_22_3:setPosition(cc.p(var_22_1, var_22_2))
			var_22_0:addChild(var_22_3, 1)

			var_22_2 = var_22_2 - var_22_3:getContentSize().height - 10
		end
	end

	if var_0_1[arg_22_1].button then
		local var_22_4 = var_0_6(var_0_1[arg_22_1].button.textures, var_0_1[arg_22_1].button.title, var_0_1[arg_22_1].button.size)

		var_22_4:addTouchEventListener(var_0_1[arg_22_1].button.listener(self, arg_22_2))
		var_22_4:setPosition(cc.p(var_22_1, -20 - var_22_4:getContentSize().height / 2))
		var_22_0:addChild(var_22_4, 10)
	end

	self.basepanel = var_22_0

	if arg_22_2.items and #arg_22_2.items > 0 then
		self:initItemsPanel(arg_22_2, cc.size(var_22_0:getContentSize().width - 30, var_22_2 - 15), var_0_1[arg_22_1].createItemType)
	end

	self:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())

		if arg_22_2.cancelcallback then
			arg_22_2.cancelcallback()
		end
	end)
end

local var_0_8 = 174
local var_0_9 = 228

function FightResultLayer:initItemsPanel(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = cc.Label:createWithTTF(L_FIGHT_RESULT_TITLE.Item_Title[1], FONT_DES, 26)

	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(15, 10 + arg_24_2.height))
	self.basepanel:addChild(var_24_0)

	local var_24_1 = arg_24_2.width / (20 + (var_0_8 + 20) * 3)
	local var_24_2 = (20 + math.ceil(#arg_24_1.items / 3) * (20 + var_0_9)) * (arg_24_2.width / (20 + (var_0_8 + 20) * 3))

	if var_24_2 < arg_24_2.height then
		var_24_2 = arg_24_2.height
	end

	local var_24_3 = ccui.ScrollView:create()

	var_24_3:setDirection(ccui.ScrollViewDir.vertical)
	var_24_3:setContentSize(arg_24_2)
	var_24_3:setInnerContainerSize(cc.size(arg_24_2.width, var_24_2))
	var_24_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_3:setBackGroundColor(cc.c3b(15, 15, 15))
	var_24_3:setBackGroundColorOpacity(178.5)
	var_24_3:setPosition(cc.p(15, 10))
	self.basepanel:addChild(var_24_3)

	local var_24_4 = 0
	local var_24_5 = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_1.items) do
		local var_24_6
		local var_24_7

		if arg_24_3 == "itemid" then
			local var_24_8

			if iter_24_1.component_attr then
				var_24_8 = iter_24_1.component_attr
			elseif iter_24_1.weapon_attr then
				var_24_8 = iter_24_1.weapon_attr
			elseif iter_24_1.horcrux_attr then
				var_24_8 = iter_24_1.horcrux_attr
			end

			var_24_6 = ItemSprite:createNewWithItemId(iter_24_1.itemid, iter_24_1.itemcount, nil, nil, var_24_8)
			var_24_7 = iter_24_1.itemid
		else
			var_24_6 = ItemSprite:createBigWithEntityId(iter_24_1.entityid, iter_24_1.dropNum)
			var_24_7 = iter_24_1.dropid
		end

		var_24_6:setScale(var_24_1)
		var_24_6:setPosition(cc.p((20 + var_0_8 / 2 + (var_0_8 + 20) * var_24_5) * var_24_1, var_24_2 - (20 + var_0_9 / 2 + (var_0_9 + 20) * var_24_4) * var_24_1))
		var_24_6:setTouchEnabled(true)
		var_24_6:addSpriteTouchEventListener(function(arg_25_0, arg_25_1)
			if arg_25_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_data[var_24_7].bag_item_type == kITEM_HORCRUX then
				return
			end

			if item_data[var_24_7].bag_item_type == kITEM_HERO then
				return
			end

			if math.abs(arg_25_0:getLocation().y - arg_25_0:getStartLocation().y) >= 50 then
				return
			end

			if not self:getChildByName("OTHER_LAYER") then
				local var_25_0 = PopLayer:Item({
					hideGainButton = true,
					itemid = var_24_7
				})
			end
		end)
		var_24_3:addChild(var_24_6)

		var_24_5 = var_24_5 + 1

		if var_24_5 >= 3 then
			var_24_4 = var_24_4 + 1
			var_24_5 = 0
		end
	end

	self.itempanel = var_24_3

	self:createPanelControllTag(arg_24_2, cc.size(arg_24_2.width, var_24_2))
end

local var_0_10 = 10
local var_0_11 = 18

function FightResultLayer:createPanelControllTag(arg_26_1, arg_26_2)
	if arg_26_1.height >= arg_26_2.height then
		return
	end

	local var_26_0 = cc.DrawNode:create()
	local var_26_1 = self.basepanel:getContentSize().width - 8

	var_26_0:drawSegment(cc.p(var_26_1, 10 + arg_26_1.height - 2), cc.p(var_26_1, 10), 0.7, cc.c4f(1, 1, 1, 1))
	self.basepanel:addChild(var_26_0)

	local var_26_2 = ccui.Button:create("fightresult/fightresult_scrolltag.png", "fightresult/fightresult_scrolltag.png", "fightresult/fightresult_scrolltag.png", var_0_2)

	var_26_2:setScale9Enabled(true)

	local var_26_3 = math.ceil(arg_26_1.height * arg_26_1.height / arg_26_2.height)

	if var_26_3 < var_0_11 then
		var_26_3 = var_0_11
	end

	if var_26_3 > 2 * arg_26_1.height / 3 then
		var_26_3 = math.ceil(2 * arg_26_1.height / 3)
	end

	var_26_2:setContentSize(cc.size(var_0_10, var_26_3))
	var_26_2:setPosition(cc.p(var_26_1, 10 + arg_26_1.height - var_26_2:getContentSize().height / 2))
	self.basepanel:addChild(var_26_2, 5)

	local var_26_4 = 10 + var_26_2:getContentSize().height / 2
	local var_26_5 = arg_26_1.height - var_26_2:getContentSize().height
	local var_26_6 = var_26_4 + var_26_5
	local var_26_7 = self.itempanel
	local var_26_8 = self.itempanel:getInnerContainer()
	local var_26_9 = arg_26_2.height - arg_26_1.height

	local function var_26_10(arg_27_0)
		var_26_7:scrollToPercentVertical(arg_27_0, 0.1, false)
	end

	var_26_2:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 == ccui.TouchEventType.began then
			var_26_6 = arg_28_0:getPositionY()
		elseif arg_28_1 == ccui.TouchEventType.moved then
			local var_28_0 = var_26_6 + (arg_28_0:getTouchMovePosition().y - arg_28_0:getTouchBeganPosition().y)

			if var_28_0 < var_26_4 then
				var_28_0 = var_26_4
			elseif var_28_0 > var_26_4 + var_26_5 then
				var_28_0 = var_26_4 + var_26_5
			end

			arg_28_0:setPositionY(var_28_0)
			var_26_10((var_26_5 - (var_28_0 - var_26_4)) * 100 / var_26_5)
		end
	end)
	self.itempanel:addEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 == ccui.ScrollviewEventType.scrolling then
			var_26_2:setPositionY(var_26_4 + var_26_5 * (1 - (var_26_9 + var_26_8:getPositionY()) / var_26_9))
		elseif arg_29_1 == ccui.ScrollviewEventType.scrollToBottom then
			var_26_2:setPositionY(var_26_4)
		elseif arg_29_1 == ccui.ScrollviewEventType.scrollToTop then
			var_26_2:setPositionY(var_26_4 + var_26_5)
		end
	end)
end

function FightResultLayer:harvestAction(arg_30_1)
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0.1), cc.RemoveSelf:create()))
end

return FightResultLayer
