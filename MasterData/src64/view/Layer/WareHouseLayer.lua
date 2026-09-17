WareHouseLayer = class("WareHouseLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.BottomBtnList")
require("view.Layer.PopLayer")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local diamond_update_data = require("data.diamond_update_data")
local item_data = require("data.item_data")
local var_0_4
local var_0_6
local var_0_7 = {
	resourceButton = {
		{
			x = 0,
			y = 0
		},
		{
			x = 0,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 326,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 285,
			y = 0
		}
	},
	labButton = {
		{
			x = 0,
			y = 0
		},
		{
			x = 37,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 330,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 330,
			y = 0
		}
	},
	partsButton = {
		{
			x = 0,
			y = 0
		},
		{
			x = 0,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 326,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 285,
			y = 0
		}
	},
	foodButton = {
		{
			x = 0,
			y = 0
		},
		{
			x = 37,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 330,
			y = 332 + GameDisplay.fix_y / 2
		},
		{
			x = 330,
			y = 0
		}
	}
}

function WareHouseLayer.getInstance()
	return var_0_4
end

function WareHouseLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = WareHouseLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function WareHouseLayer.createWithListBotton(arg_4_0, arg_4_1)
	local var_4_0 = WareHouseLayer.new()

	var_4_0:init(arg_4_1, 1)

	return var_4_0
end

local var_0_8 = {
	"horcruxButton",
	"resourceButton",
	"foodButton",
	"partsButton",
	"labButton"
}
local var_0_9 = {
	"Image_title",
	"Image_content",
	"Image_arrow"
}

function WareHouseLayer:fullScreen()
	for iter_5_0 = 1, #var_0_8 do
		local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, var_0_8[iter_5_0])

		for iter_5_1 = 1, #var_0_9 do
			local var_5_1 = ccui.Helper:seekWidgetByName(var_5_0, var_0_9[iter_5_1])

			if iter_5_1 == 1 then
				var_5_1:setPositionY(var_5_0:getContentSize().height - 21)
			elseif iter_5_1 == 2 then
				var_5_1:setPositionY(var_5_0:getContentSize().height / 2)
			elseif iter_5_1 == 3 then
				if var_0_8[iter_5_0] == "horcruxButton" then
					var_5_1:setPositionY(var_5_0:getContentSize().height - 33.5)
				else
					var_5_1:setPositionY(var_5_0:getContentSize().height - 19)
				end
			end
		end
	end
end

function WareHouseLayer:init(arg_6_1, arg_6_2)
	var_0_4 = self
	self.exitCallback = arg_6_1 and arg_6_1.exitCallback or nil
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "WareHouseLayer.json" or "WareHouseLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.bagContent = ccui.Helper:seekWidgetByName(self.rootLayer, "button_add_num")

	self.bagContent:setVisible(false)

	if arg_6_1 and arg_6_1.returnLayer then
		var_0_6 = arg_6_1.returnLayer
	end

	local var_6_0 = BottomBtnList:create(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {})

	var_6_0:setName("bottomlist")
	var_6_0:setPositionY(-GameDisplay.fix_y)
	self:addChild(var_6_0, 9)

	if arg_6_2 == 1 then
		var_6_0:setVisible(false)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "horcruxButton"):setPositionY(global_transfrompercent_pos(900 - GameDisplay.fix_y / 2))
	ccui.Helper:seekWidgetByName(self.rootLayer, "partsButton"):setPositionY(global_transfrompercent_pos(264 - GameDisplay.fix_y / 2))
	ccui.Helper:seekWidgetByName(self.rootLayer, "labButton"):setPositionY(global_transfrompercent_pos(603 - GameDisplay.fix_y / 2))
	ccui.Helper:seekWidgetByName(self.rootLayer, "resourceButton"):setPositionY(global_transfrompercent_pos(603 - GameDisplay.fix_y / 2))
	ccui.Helper:seekWidgetByName(self.rootLayer, "foodButton"):setPositionY(global_transfrompercent_pos(267 - GameDisplay.fix_y / 2))
	ccui.Helper:seekWidgetByName(self.rootLayer, "horcruxButton"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "horcruxButton"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 == ccui.TouchEventType.began then
			if not cc.rectContainsPoint(cc.rect(0, 0, arg_8_0:getContentSize().width, arg_8_0:getContentSize().height), (arg_8_0:convertToNodeSpace((arg_8_0:getTouchBeganPosition())))) then
				return
			end

			arg_8_0:setScale(1.1)
		elseif arg_8_1 == ccui.TouchEventType.canceled then
			arg_8_0:setScale(1)
		elseif arg_8_1 == ccui.TouchEventType.ended then
			arg_8_0:setScale(1)
		end

		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("HorcruxLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "horcruxButton"):setContentSize(cc.size(640, 221 + GameDisplay.fix_y / 2))

	if self:checkCurBagNewHorcruxAlert(ccui.Helper:seekWidgetByName(self.rootLayer, "horcruxButton")) == false then
		self:check_horcrux_strenghth(ccui.Helper:seekWidgetByName(self.rootLayer, "horcruxButton"))
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "partsButton"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "partsButton"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 == ccui.TouchEventType.began then
			if not isContainPosOfConvexPolygon(var_0_7[arg_9_0:getName()], (arg_9_0:convertToNodeSpace((arg_9_0:getTouchBeganPosition())))) then
				return
			end

			arg_9_0:setScale(1.1)
		elseif arg_9_1 == ccui.TouchEventType.canceled then
			arg_9_0:setScale(1)
		elseif arg_9_1 == ccui.TouchEventType.ended then
			arg_9_0:setScale(1)
		end

		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_7[arg_9_0:getName()], (arg_9_0:convertToNodeSpace((arg_9_0:getTouchBeganPosition())))) then
			return
		end

		LayerManager:switchShowLayer("BagLayerNew", {
			bagType = 1,
			createType = arg_6_2
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "partsButton"):setContentSize(cc.size(326, 332 + GameDisplay.fix_y / 2))
	self:createWeightLabel(3, ccui.Helper:seekWidgetByName(self.rootLayer, "partsButton"))
	self:checkCurBagFullAlert(3, ccui.Helper:seekWidgetByName(self.rootLayer, "partsButton"))
	ccui.Helper:seekWidgetByName(self.rootLayer, "resourceButton"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "resourceButton"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 == ccui.TouchEventType.began then
			if not isContainPosOfConvexPolygon(var_0_7[arg_10_0:getName()], (arg_10_0:convertToNodeSpace((arg_10_0:getTouchBeganPosition())))) then
				return
			end

			arg_10_0:setScale(1.1)
		elseif arg_10_1 == ccui.TouchEventType.canceled then
			arg_10_0:setScale(1)
		elseif arg_10_1 == ccui.TouchEventType.ended then
			arg_10_0:setScale(1)
		end

		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_7[arg_10_0:getName()], (arg_10_0:convertToNodeSpace((arg_10_0:getTouchBeganPosition())))) then
			return
		end

		local var_10_0 = cc.EventCustom:new("switchShowLayer")

		LayerManager:switchShowLayer("BagLayerNew", {
			bagType = 2,
			bagType_partition = 1,
			createType = arg_6_2
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "resourceButton"):setContentSize(cc.size(326, 332 + GameDisplay.fix_y / 2))
	self:createWeightLabel(6, ccui.Helper:seekWidgetByName(self.rootLayer, "resourceButton"))
	self:checkCurBagFullAlert(6, ccui.Helper:seekWidgetByName(self.rootLayer, "resourceButton"))
	ccui.Helper:seekWidgetByName(self.rootLayer, "foodButton"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "foodButton"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 == ccui.TouchEventType.began then
			if not isContainPosOfConvexPolygon(var_0_7[arg_11_0:getName()], (arg_11_0:convertToNodeSpace((arg_11_0:getTouchBeganPosition())))) then
				return
			end

			arg_11_0:setScale(1.1)
		elseif arg_11_1 == ccui.TouchEventType.canceled then
			arg_11_0:setScale(1)
		elseif arg_11_1 == ccui.TouchEventType.ended then
			arg_11_0:setScale(1)
		end

		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_7[arg_11_0:getName()], (arg_11_0:convertToNodeSpace((arg_11_0:getTouchBeganPosition())))) then
			return
		end

		LayerManager:switchShowLayer("BagLayerNew", {
			bagType = 3,
			createType = arg_6_2
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "foodButton"):setContentSize(cc.size(330, 332 + GameDisplay.fix_y / 2))
	self:createWeightLabel(4, ccui.Helper:seekWidgetByName(self.rootLayer, "foodButton"))
	self:checkCurBagFullAlert(4, ccui.Helper:seekWidgetByName(self.rootLayer, "foodButton"))
	ccui.Helper:seekWidgetByName(self.rootLayer, "labButton"):setSwallowTouches(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "labButton"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 == ccui.TouchEventType.began then
			if not isContainPosOfConvexPolygon(var_0_7[arg_12_0:getName()], (arg_12_0:convertToNodeSpace((arg_12_0:getTouchBeganPosition())))) then
				return
			end

			arg_12_0:setScale(1.1)
		elseif arg_12_1 == ccui.TouchEventType.canceled then
			arg_12_0:setScale(1)
		elseif arg_12_1 == ccui.TouchEventType.ended then
			arg_12_0:setScale(1)
		end

		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not isContainPosOfConvexPolygon(var_0_7[arg_12_0:getName()], (arg_12_0:convertToNodeSpace((arg_12_0:getTouchBeganPosition())))) then
			return
		end

		LayerManager:switchShowLayer("BagLayerNew", {
			bagType = 5,
			bagType_partition = 2,
			createType = arg_6_2
		})
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "labButton"):setContentSize(cc.size(330, 332 + GameDisplay.fix_y / 2))
	self:createWeightLabel(5, ccui.Helper:seekWidgetByName(self.rootLayer, "labButton"))
	self:checkCurBagFullAlert(5, ccui.Helper:seekWidgetByName(self.rootLayer, "labButton"))
	self:fullScreen()
	self:registerScriptHandler(function(arg_13_0)
		if arg_13_0 == "exit" then
			TextureManager:unregisterTexture("WareHouseLayer")

			var_0_4 = nil
		end
	end)
	self:trans_overdue_item()
end

function WareHouseLayer.trans_overdue_item(arg_14_0, ...)
	local var_14_0 = RoleDefault:getInstance():getIntegerForKey("trans_overdue_item", 0)

	RoleDefault:getInstance():setIntegerForKey("trans_overdue_item", (tonumber(os.date("%j", require("controller.time_check_manager"):getCurTime()))))
	item_manager:trans_overdue_item(function(arg_15_0)
		if not var_0_4 then
			return
		end

		if arg_15_0.result == 1 and next(arg_15_0.items) then
			LayerManager:pushInLayer("PopTransOverdueItemLayer", {
				items = arg_15_0.items,
				consumes = arg_15_0.consumes
			})
		end
	end)
end

function WareHouseLayer.topupdate()
	return {
		"Topcost/item.png",
		"Topcost/item.png"
	}
end

function WareHouseLayer:initBottom()
	self.rootLayer:addChild(BottomBtnList:create(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.exitCallback then
			self.exitCallback()
		else
			LayerManager:switchReturnLayer("FightLayer")
		end
	end), 2)
end

function WareHouseLayer.updatebagContent(arg_19_0)
	print("WareHouseLayer:updatebagContent is deprecated!!!!!")
end

function WareHouseLayer.createWeightLabel(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = cc.Label:createWithTTF("/" .. playermodel.bagweight[arg_20_1].limit, FONT_NAME, 22)

	var_20_0:setAnchorPoint(cc.p(1, 0))

	if arg_20_2:getName() == "resourceButton" or arg_20_2:getName() == "partsButton" then
		var_20_0:setPosition(arg_20_2:getContentSize().width - 40, 18)
	else
		var_20_0:setPosition(arg_20_2:getContentSize().width - 8, 18)
	end

	arg_20_2:addChild(var_20_0)

	local var_20_1 = cc.Label:createWithTTF(math.floor(playermodel.bagweight[arg_20_1].weight), FONT_NAME, 22)

	var_20_1:setColor(cc.c3b(255, 168, 0))
	var_20_1:setAnchorPoint(cc.p(1, 0))
	var_20_1:setPosition(var_20_0:getPositionX() - var_20_0:getContentSize().width, var_20_0:getPositionY())
	arg_20_2:addChild(var_20_1)

	local var_20_2 = cc.Label:createWithTTF(L_ITEM_WEIGHT .. " ", FONT_NAME, 22)

	var_20_2:setAnchorPoint(cc.p(1, 0))
	var_20_2:setPosition(var_20_1:getPositionX() - var_20_1:getContentSize().width, var_20_1:getPositionY())
	arg_20_2:addChild(var_20_2)
end

function WareHouseLayer.checkCurBagFullAlert(arg_21_0, arg_21_1, arg_21_2)
	if playermodel.bagweight[arg_21_1].weight >= playermodel.bagweight[arg_21_1].limit then
		AlertManager:add_alert_by_config(arg_21_2, true, {
			ALERT_SHOW_FULL,
			nil,
			cc.p(arg_21_2:getContentSize().width - 20, arg_21_2:getContentSize().height - 20)
		})
	end
end

local function var_0_10()
	for iter_22_0, iter_22_1 in pairs(require("model.playermodel").items) do
		if iter_22_1.itemtype == kITEM_HORCRUX and iter_22_1.new then
			return true
		end
	end

	return false
end

function WareHouseLayer.checkCurBagNewHorcruxAlert(arg_23_0, arg_23_1)
	if var_0_10() then
		AlertManager:add_alert_by_config(arg_23_1, true, {
			ALERT_SHOW_NEW,
			nil,
			cc.p(arg_23_1:getContentSize().width - 20, arg_23_1:getContentSize().height - 20)
		})

		return true
	end

	return false
end

local function var_0_11(arg_24_0)
	if not arg_24_0 then
		return false
	end

	return require("controller.horcrux_manager"):horcruxCanBreakOut(arg_24_0)
end

local function var_0_12(arg_25_0)
	if not arg_25_0 then
		return false
	end

	return require("controller.horcrux_manager"):horcruxBagIsTipsHorcruxUpgrade(arg_25_0)
end

local function var_0_13(arg_26_0)
	if var_0_11(arg_26_0) then
		return true
	end

	if var_0_12(arg_26_0) then
		return true
	end

	return false
end

function WareHouseLayer.check_horcrux_strenghth(arg_27_0, arg_27_1)
	local horcrux_manager = require("controller.horcrux_manager")

	for iter_27_0, iter_27_1 in pairs(require("model.playermodel").items) do
		if iter_27_1.itemtype == kITEM_HORCRUX and horcrux_manager:isTipsHorcruxUpgrade(iter_27_1.entityid) and var_0_13(iter_27_1.entityid) then
			AlertManager:add_alert_by_config(arg_27_1, true, {
				ALERT_SHOW_REDDOT,
				nil,
				cc.p(arg_27_1:getContentSize().width - 20, arg_27_1:getContentSize().height - 20)
			})

			break
		end
	end
end
