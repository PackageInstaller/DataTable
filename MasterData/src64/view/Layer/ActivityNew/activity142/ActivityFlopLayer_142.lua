ActivityFlopLayer_142 = class("ActivityFlopLayer_142", function()
	return ActivityFlopBaseLayer:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local var_0_5 = config._DEBUG and 0 or 1

require("view.Sprite.ItemSpriteFlop")

local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local activity_flop_condition_conf = require("data.activity_modules.activity_flop_condition_conf")
local activity_flop_ui_conf_data = require("data.activity_flop.uiconfig.activity_flop_ui_conf_data")

function ActivityFlopLayer_142.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityFlopLayer_142.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityFlopLayer_142:initDynaticPara(arg_3_1)
	self.layerName = "ActivityFlopLayer_142"
	self.id = arg_3_1.activityid or 10000
	self.bgPath = "activitiesRes/activity" .. self.id .. "/flop/flop_bg.png"
	self.rolebg = "activitiesRes/activity" .. self.id .. "/flop/"
	self.texturePath = "Activities/activity" .. self.id .. "/flop/"

	self:getParamFromUIConf()
end

function ActivityFlopLayer_142:initDrawBg()
	local var_4_0 = ccui.Layout:create()

	var_4_0:setContentSize(cc.size(0, 0))
	var_4_0:setAnchorPoint(0.5, 0)
	var_4_0:setPosition(cc.p(120, 740))
	self.rootLayer:addChild(var_4_0, 1)

	local var_4_1 = ccui.ImageView:create(self.texturePath .. "draw_bg.png", var_0_5)

	var_4_1:setAnchorPoint(cc.p(0.5, 1))
	var_4_1:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, var_4_0:getPositionY()))
	self.rootLayer:addChild(var_4_1, 1)

	self.championBg = var_4_0
	self.drawBg = var_4_1

	self.drawBg:setTouchEnabled(true)
end

function ActivityFlopLayer_142:initFlopTurns()
	local var_5_0 = cc.Label:createWithTTF(L_FLOP_TURNS_NOW, FONT_DES, self.turnsLabelSize)

	var_5_0:setAnchorPoint(cc.p(0.5, 0))
	var_5_0:setColor(self.turnsLabelColor)
	var_5_0:setName("flopBgWord")
	var_5_0:setPosition(cc.p(380, self.bottomList:getChildByName("previousTurn"):getPositionY() - 20))
	self.bottomList:addChild(var_5_0)

	local var_5_1 = ccui.Layout:create()

	var_5_1:setContentSize(cc.size(60, var_5_0:getContentSize().height))
	var_5_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_5_1:setAnchorPoint(0.5, 0)
	var_5_1:setPosition(cc.p(var_5_0:getPositionX() + 15, var_5_0:getPositionY()))
	var_5_1:setName("numLayer")
	self.bottomList:addChild(var_5_1)

	local var_5_2 = cc.Label:createWithTTF("/" .. activity_flop_condition_conf[self.id].flop_limit_turns, FONT_DES, self.turnsLabelSize)

	var_5_2:setAnchorPoint(cc.p(1, 0.5))
	var_5_2:setName("flopTotalTurns")
	var_5_2:setColor(self.turnsLabelColor)
	var_5_2:setPosition(cc.p(var_5_1:getContentSize().width / 2, var_5_1:getContentSize().height / 2))
	var_5_1:addChild(var_5_2)

	local var_5_3 = cc.Label:createWithTTF("", FONT_DES, self.turnsLabelSize)

	var_5_3:setAnchorPoint(cc.p(0, 0.5))
	var_5_3:setName("flopTurns")
	var_5_3:setColor(self.turnsLabelColorOn)
	var_5_3:setPosition(cc.p(var_5_1:getContentSize().width / 2, var_5_1:getContentSize().height / 2))
	var_5_1:addChild(var_5_3)

	self.flopTurns = var_5_3

	var_5_1:setContentSize(cc.size(var_5_2:getContentSize().width + var_5_3:getContentSize().width, var_5_0:getContentSize().height))
	var_5_1:setPositionX(var_5_0:getPositionX() + 20)
	var_5_2:setPositionX(var_5_1:getContentSize().width)
	var_5_3:setPositionX(0)
end

function ActivityFlopLayer_142:updateFlopTurns()
	local var_6_0 = self.bottomList:getChildByName("flopBgWord")
	local var_6_1 = self.bottomList:getChildByName("numLayer")
	local var_6_2 = var_6_1:getChildByName("flopTotalTurns")
	local var_6_3 = var_6_1:getChildByName("flopTurns")

	self.flopTurns:setString((activity_manager:getFlopTurns(self.id)))
	var_6_1:setContentSize(cc.size(var_6_2:getContentSize().width + var_6_3:getContentSize().width, var_6_0:getContentSize().height))
	var_6_1:setPositionX(var_6_0:getPositionX() + 20)
	var_6_2:setPositionX(var_6_1:getContentSize().width)
	var_6_3:setPositionX(0)
end

function ActivityFlopLayer_142.updateOther(arg_7_0)
	return
end

function ActivityFlopLayer_142:fullScreen()
	self.championBg:setPositionY(self.championBg:getPositionY() + GameDisplay.fix_y * 0.8)
	self.drawBg:setPositionY(self.championBg:getPositionY() + 35)
	self.bigRole:setPositionY(GameDisplay.height + 126 - GameDisplay.fix_y * 0.8)
	self.Title:setPositionY(self.rootLayer:getContentSize().height - self.Title:getContentSize().height / 2 - 10)

	self.bottomList.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomList:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomList:setPositionY(0)
	self.changeSkinBtn:setPositionY(self.shopbtn:getPositionY() - (self.shopbtn:getPositionY() - self.drawBg:getPositionY() - 50) / 2)

	local var_8_0 = self.drawBg:getChildByName("flopTurns")

	var_8_0:setPositionX(600)
	var_8_0:setPositionY(self.drawBg:getContentSize().height - 650)
end

function ActivityFlopLayer_142:updateChampionTipLabel()
	if not self.itemShade:getChildByName("tip") then
		local var_9_0 = cc.Label:createWithTTF(L_FLOP_CHAMPION_TIP, FONT_DES, 20)

		var_9_0:setAnchorPoint(cc.p(0, 0.5))
		var_9_0:setMaxLineWidth(180)
		var_9_0:setName("tip")
		var_9_0:setPosition(cc.p(40, self.itemShade:getContentSize().height / 2))
		self.itemShade:addChild(var_9_0)
	end
end

function ActivityFlopLayer_142:updateFurniture()
	local var_10_0, var_10_1, var_10_2 = activity_manager:getFlopFurniture(self.id)

	if not self.furniture then
		local var_10_3 = ccui.ImageView:create(self.texturePath .. "champion_shade.png", var_0_5)

		var_10_3:setAnchorPoint(cc.p(0.5, 0))
		var_10_3:setPosition(cc.p(200, self.itemShade:getPositionY()))
		var_10_3:setName("furnitureLabelBg")
		self.championBg:addChild(var_10_3)

		local var_10_4 = cc.Label:createWithTTF(string.format(L_FLOP_FURNITURE_TIP, var_10_1, var_10_2), FONT_NAME, 20)

		var_10_4:setAnchorPoint(cc.p(0, 0.5))
		var_10_4:setName("furnitureLabel")
		var_10_4:setPosition(cc.p(40, var_10_4:getContentSize().height / 2 + 5))
		var_10_3:addChild(var_10_4)

		self.furnitureLabel = var_10_4

		local var_10_5 = ccui.ImageView:create(self.rolebg .. "furniture_" .. var_10_0 .. ".png")

		var_10_5:setName("championItem")
		var_10_5:setScale(0.25)
		var_10_5:setAnchorPoint(cc.p(0.5, 0))
		var_10_5:setPosition(cc.p(var_10_3:getContentSize().width / 2 - 10, 50))
		var_10_3:addChild(var_10_5)

		self.furnitureIndex = var_10_0
		self.furniture = var_10_5

		var_10_5:setTouchEnabled(true)
		var_10_5:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:createFurniturePanel()
		end)
	elseif self.furnitureIndex ~= var_10_0 then
		self.championBg:getChildByName("furnitureLabelBg"):getChildByName("furnitureLabel"):setString(string.format(L_FLOP_FURNITURE_TIP, var_10_1, var_10_2))
		self.furniture:loadTexture(self.rolebg .. "furniture_" .. var_10_0 .. ".png")

		self.furnitureIndex = var_10_0
	end
end

function ActivityFlopLayer_142:createFurniturePanel()
	if self.rootLayer:getChildByName("furniture_detail") then
		return
	end

	local var_12_0 = ccui.Layout:create()

	var_12_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_12_0:setAnchorPoint(0, 0)
	var_12_0:setPosition(cc.p(0, 0))
	var_12_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_12_0:setBackGroundColorOpacity(180)
	var_12_0:setName("furniture_detail")
	self.rootLayer:addChild(var_12_0, 99)

	local var_12_1 = ccui.Layout:create()

	var_12_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_12_1:setAnchorPoint(0.5, 0.5)
	var_12_1:setPosition(var_12_0:getContentSize().width / 2, var_12_0:getContentSize().height / 2)
	var_12_0:addChild(var_12_1, 2)

	local var_12_2 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", var_0_5)

	var_12_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_12_2:setPosition(var_12_0:getContentSize().width / 2, var_12_0:getContentSize().height / 2)

	local var_12_3 = ccui.ImageView:create(self.rolebg .. "furniture_" .. furnitureIndex .. ".png")

	var_12_3:setScale(0.5)
	var_12_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_12_3:setPosition(cc.p(var_12_2:getContentSize().width / 2, var_12_2:getContentSize().height / 2))
	var_12_2:addChild(var_12_3)
	var_12_0:setTouchEnabled(true)
	var_12_1:setTouchEnabled(false)
	var_12_2:setScale(0)
	var_12_0:addChild(var_12_2, 10)
	var_12_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.1, 1), cc.CallFunc:create(function()
		var_12_0:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_12_1:setTouchEnabled(true)
			var_12_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.2), cc.ScaleTo:create(0.2, 0), cc.CallFunc:create(function()
				var_12_0:runAction(cc.RemoveSelf:create())
			end)))
		end)
	end)))
end

function ActivityFlopLayer_142:updateChampionItem(arg_16_1)
	local var_16_1 = self:getUIConf()
	local var_16_2 = var_16_1.champion_offset_y or 50

	if not var_16_1.champion_size then
		-- block empty
	end

	local var_16_4 = self.texturePath .. "champion_bg.png"

	if not self.itemShade then
		local var_16_5 = ItemSpriteFlop:createPurchaseItemByItemid()

		var_16_5:setName("championItem")
		var_16_5:setAnchorPoint(cc.p(0.5, 0))
		var_16_5:setPosition(cc.p(self.championBg:getContentSize().width / 2, 64 + var_16_2))
		self.championBg:addChild(var_16_5)
		var_16_5:updateFlopItemByItemid(self.championItem.itemid, nil, nil, var_16_4)

		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			var_16_5:getChildByName("icon"):loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
			var_16_5:getChildByName("icon"):setScale(0.3)
		end

		var_16_5:setTouchEnabled(true)
		var_16_5:addTouchEventListener(function(arg_17_0, arg_17_1)
			if arg_17_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_17_0 = {
				itemid = self.championItem.itemid
			}

			var_17_0.hideGainButton = true

			if var_17_0.itemid and type(var_17_0.itemid) == "number" then
				LayerManager:pushInLayer("PopItemLayer", var_17_0)
			end
		end)

		local var_16_6 = cc.Label:createWithTTF("x" .. self.championItem.itemNum, FONT_NAME, var_16_1.champion_num_size)

		var_16_6:setAnchorPoint(cc.p(0.5, 0))
		var_16_6:setName("championNumLabel")
		var_16_6:setPositionX(var_16_5:getPositionX())
		var_16_6:setPositionY(var_16_1.champion_num_offset_y)
		self.championBg:addChild(var_16_6, 99)

		local var_16_7 = ccui.ImageView:create(self.texturePath .. "champion_shade.png", var_0_5)

		var_16_7:setAnchorPoint(cc.p(0.5, 0))
		var_16_7:setPosition(cc.p(self.championBg:getContentSize().width / 2 + (var_16_1.champion_offset_x or 0), var_16_5:getPositionY() - 45 - var_16_2))
		self.championBg:addChild(var_16_7)

		self.itemShade = var_16_7
	else
		local var_16_8 = self.championBg:getChildByName("championItem")

		var_16_8:updateFlopItemByItemid(self.championItem.itemid, nil, nil, var_16_4)

		if item_data[self.championItem.itemid].bag_item_type == kITEM_SKIN then
			var_16_8:getChildByName("icon"):loadTexture("roleimage/role1/" .. model_data[item_data[self.championItem.itemid].model].cute_role .. ".png")
			var_16_8:getChildByName("icon"):setScale(0.4)
		end

		self.championBg:getChildByName("championNumLabel"):setString("x" .. self.championItem.itemNum)
		self.championBg:getChildByName("championItem"):setTouchEnabled(true)
	end

	if not arg_16_1 then
		self.championBg:getChildByName("championItem"):setOpacity(0)
		self.championBg:getChildByName("championItem"):runAction(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.EaseIn:create(cc.MoveBy:create(0.6, cc.p(0, -var_16_2)), 0.2))))
		self.championBg:getChildByName("championNumLabel"):setOpacity(0)
		self.championBg:getChildByName("championNumLabel"):runAction(cc.Sequence:create(cc.FadeIn:create(0.6)))
	end
end
