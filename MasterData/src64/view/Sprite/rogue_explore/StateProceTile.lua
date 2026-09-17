local TileSprite = require("view.Sprite.explore.TileSprite")
local StateProceTile = class("StateProceTile", function(arg_1_0)
	return TileSprite:createNode(arg_1_0)
end)
local explore_manager = require("controller.explore_manager")
local L2Actor = require("view.Sprite.L2Actor")
local item_manager = require("controller.item_manager")
local explore_img_data = require("data.explore.explore_img_data")
local model_data = require("data.model_data")
local tile_data = require("data.explore.tile_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local item_data = require("data.item_data")

function StateProceTile:create(arg_2_1)
	local var_2_0 = StateProceTile.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:initother()

	return var_2_0
end

function StateProceTile:initother()
	return
end

function StateProceTile:needKeyPopLayer(arg_4_1)
	local var_4_0 = ccs.GUIReader:getInstance()
	local var_4_1 = var_4_0:widgetFromJsonFile(config._DEBUG and "popOutfireLayer.json" or "popOutfireLayer.ExportJson")
	local var_4_2 = ccui.Helper:seekWidgetByName(var_4_1, "Panel_back")

	var_4_2.setContentSize(var_4_0, GameDisplay.getUiScreenSize())
	var_4_2:setBackGroundColorOpacity(145)
	var_4_2:setPositionY(var_4_2:getPositionY() - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(var_4_1, "Image_item"):loadTexture("equipment/9999010.png")
	ccui.Helper:seekWidgetByName(var_4_1, "Label_surplus_num"):setString(string.format(L_FIRE_UNIT_REST, explore_manager:getItemNumber(9999010)))
	ccui.Helper:seekWidgetByName(var_4_1, "Label_num"):setString("1")
	ccui.Helper:seekWidgetByName(var_4_1, "Button_sure"):addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if explore_manager:getItemNumber(9999010) == 0 then
			global_ShowBlockWords(L_FIRE_UNIT_LACK)

			return
		end

		if arg_4_1.surecallback then
			self:playOutFireAni(arg_4_1)
		end

		var_4_1:runAction(cc.RemoveSelf:create())
	end)
	var_4_1:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_4_1:runAction(cc.RemoveSelf:create())

		self.parent.root.touchLock = false
	end)
	ccui.Helper:seekWidgetByName(var_4_1, "Panel_9"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		PopLayer:Item({
			itemid = 9999010,
			hideGainButton = true,
			itemnum = explore_manager:getItemNumber(9999010)
		})
	end)

	return var_4_1
end

function StateProceTile:playOutFireAni(arg_8_1)
	local var_8_0 = L2Skeleton:create("spine/explore/miehuokamila.json", "spine/explore/miehuokamila.atlas")

	var_8_0:refreshSkeleton()
	var_8_0:setVisible(true)
	var_8_0:play("animation", false)
	var_8_0:setPosition(cc.p(320, -GameDisplay.fix_y))
	var_8_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_9_0)
		if arg_8_1.surecallback then
			arg_8_1.surecallback()
		end

		var_8_0:runAction(cc.RemoveSelf:create())

		self.parent.root.touchLock = false
	end)
	self.parent.root.mapPanel:addChild(var_8_0, 2)
end

return StateProceTile
