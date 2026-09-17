PopHolidayConfirmLayer = class("PopHolidayConfirmLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local core_data = require("data.core_data")
local model_qrole_scale_data = require("data.model_qrole_scale_data")
local role_vacation_consume_data = require("data.role_vacation_consume_data")
local item_manager = require("controller.item_manager")
local core_manager = require("controller.core_manager")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local weapon_manager = require("controller.weapon_manager")

function PopHolidayConfirmLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopHolidayConfirmLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopHolidayConfirmLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_holiday.json" or "Pop_holiday.ExportJson")

	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(320, GameDisplay.getScreenSize().height / 2))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_45")

	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setContentSize(GameDisplay.getScreenSize())
	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))

	self.msg = arg_3_1
	self.servantid = arg_3_1.servantid
	self.resetCallback = arg_3_1.resetCallback
	self.goto_back_system_id = arg_3_1.goto_back_system_id

	self.showActions.extendVertical(self)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):getPositionY() - 60)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_sureBtn"):addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_4_0:setBright(false)
		self:createConfirmPop(function()
			core_manager:servantCoreReset(self.servantid, self.selectCostItemid, function(arg_6_0)
				arg_4_0:setBright(true)

				if arg_6_0 == 1 then
					if self.resetCallback then
						self.resetCallback()
					end

					self.hideActions.shrinkVertical(self, function()
						LayerManager:removePopLayer(self.__queueindex)
					end)

					if arg_3_1.sureCallback then
						arg_3_1.sureCallback()
					end
				end
			end)
		end)
	end)
	self:createFullScreenMask(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initUI()
end

function PopHolidayConfirmLayer:initUI()
	local var_10_0 = global_get_servant_skin(self.servantid)
	local var_10_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")
	local var_10_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "level_bg")
	local var_10_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "break_bg")
	local var_10_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "weapon_bg")
	local var_10_6 = ccui.Helper:seekWidgetByName(self.rootLayer, "tech_bg")
	local var_10_7 = ccui.Helper:seekWidgetByName(self.rootLayer, "material_bg")
	local var_10_8 = ccui.Helper:seekWidgetByName(self.rootLayer, "money_bg")
	local var_10_9 = ccui.Helper:seekWidgetByName(self.rootLayer, "name_bg")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_curLevel"):setString((core_manager:getCoreLv(self.servantid)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_curBreakCount"):setString("")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_nextBreakCount"):setString("")

	local var_10_10 = ccui.ImageView:create("public/rolebg/breakout_" .. core_data[playermodel.cores[self.servantid].coreid].rank .. ".png", var_0_0)
	local var_10_11 = ccui.ImageView:create("public/rolebg/breakout_0.png", var_0_0)

	var_10_4:addChild(var_10_10)
	var_10_4:addChild(var_10_11)
	var_10_10:setPosition(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_curBreakCount"):getPosition())
	var_10_11:setPosition(ccui.Helper:seekWidgetByName(self.rootLayer, "Label_nextBreakCount"):getPosition())
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_curWeapon"):setString(0)

	if playermodel.weaponId[self.servantid] then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_curWeapon"):setString(playermodel.items[playermodel.weaponId[self.servantid]].weapon_attr.level)
	end

	var_10_3:setPositionY(var_10_3:getPositionY() - 30)
	var_10_4:setPositionY(var_10_4:getPositionY() - 70)
	var_10_5:setPositionY(var_10_5:getPositionY() - 110)
	var_10_6:setPosition(var_10_6:getPositionX() - var_10_2:getContentSize().width / 3, var_10_6:getPositionY() - var_10_2:getContentSize().height / 4)
	var_10_8:setPosition(var_10_8:getPositionX() - var_10_2:getContentSize().width / 3, var_10_8:getPositionY() - var_10_2:getContentSize().height / 4 - 15)
	var_10_7:setPosition(var_10_7:getPositionX() - var_10_2:getContentSize().width / 3, var_10_7:getPositionY() - var_10_2:getContentSize().height / 4 - 30)
	ccui.Helper:seekWidgetByName(self.rootLayer, "material_bg"):getChildByName("material_list_bg"):setVisible(false)

	local var_10_12 = ccui.ImageView:create("holidayPop/reset_level_buttom.png", var_0_0)

	var_10_12:setAnchorPoint(0, 1)
	var_10_7:addChild(var_10_12)
	var_10_12:setPositionY(-20)
	var_10_12:setScale(4.5, 4)
	var_10_3:getChildByName("Label_37"):setString(L_FRIEND_BRIEF_INDEX[1])
	var_10_4:getChildByName("Label_37"):setString(L_WEAPON_RANGE_UP.Up)
	var_10_5:getChildByName("Label_37"):setString(L_PLAYER_DATA_TYPE.Weapons)
	var_10_6:getChildByName("Label_37"):setString(L_MARRY_SCIENCE[1] .. L_SMELT_SHOW_RESULT.Return)
	var_10_7:getChildByName("Label_37"):setString(L_HOLIDAY_CONFIRM_1)
	var_10_8:getChildByName("Label_37"):setString(L_HOLIDAY_CONFIRM_2)
	ccui.Helper:seekWidgetByName(self.rootLayer, "name_label"):setString(servant_data[self.servantid].name)
	var_10_9:setPositionX(var_10_9:getPositionX() - 15)

	local var_10_13 = ccui.Helper:seekWidgetByName(self.rootLayer, "role_bg")

	var_10_13:loadTexture("role1/" .. model_data[var_10_0].cute_role .. ".png")

	local var_10_14 = model_qrole_scale_data[tonumber(model_data[var_10_0].cute_role)]

	var_10_13:setScale(0.6)
	var_10_13:setPosition(cc.p(var_10_13:getPositionX() - 15, var_10_13:getPositionY()))

	local var_10_15

	if var_10_14 then
		var_10_13:setPosition(cc.p(var_10_13:getPositionX() + var_10_14.offset_x, var_10_13:getPositionY() + var_10_14.offset_y))

		var_10_15 = 0
	end

	for iter_10_0, iter_10_1 in pairs((self:getReturnMsg(self.servantid))) do
		if iter_10_1.itemName == L_PLAYER_DATA_TYPE.Tech then
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_tech_Num"):setString("X" .. global_trans_number(iter_10_1.itemNum))
		end

		if iter_10_1.itemName == L_GOLD then
			ccui.Helper:seekWidgetByName(self.rootLayer, "money_bg"):setVisible(true)
			ccui.Helper:seekWidgetByName(self.rootLayer, "Label_money_Num"):setString("X" .. global_trans_number(iter_10_1.itemNum))

			local var_10_16 = ccui.Helper:seekWidgetByName(self.rootLayer, "money_bg"):getChildByName("Label_37")

			var_10_16:setPositionX(var_10_16:getPositionX() + 20)
		end

		if iter_10_1.itemName ~= L_PLAYER_DATA_TYPE.Tech and iter_10_1.itemName ~= L_GOLD then
			ccui.Helper:seekWidgetByName(self.rootLayer, "material_bg"):setVisible(true)

			local var_10_17 = ItemSmallSprite:createSmallItem(iter_10_1.itemid, iter_10_1.itemNum, self.goto_back_system_id)

			var_10_17:setScale(0.5)
			var_10_17:getChildByName("numLabel"):setString("X" .. iter_10_1.itemNum)
			var_10_17:getChildByName("numLabel"):setColor(cc.c3b(255, 255, 255))
			var_10_17:getChildByName("numLabel"):setScale(1.6)
			var_10_17:setInfoTouchEvent(true)
			var_10_7:addChild(var_10_17)
			var_10_17:setPosition(cc.p(var_10_12:getPositionX() + var_10_17:getContentSize().width / 2 + 90 + 120 * (0 - 1), var_10_12:getPositionY() - var_10_12:getContentSize().height / 2 * 4))
		end

		var_10_15 = var_10_15 + 1
	end

	if var_10_15 == 1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "material_bg"):setVisible(false)
		var_10_12:setVisible(false)
		var_10_3:setPositionY(var_10_3:getPositionY() - 50)
		var_10_4:setPositionY(var_10_4:getPositionY() - 50)
		var_10_5:setPositionY(var_10_5:getPositionY() - 50)
		var_10_6:setPositionY(var_10_6:getPositionY() - 50)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "material_col"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_hook"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_hook"):setVisible(false)
end

function PopHolidayConfirmLayer:createConfirmPop(arg_11_1)
	local var_11_0 = L_HOLIDAY_CONFIRM.title
	local var_11_1 = L_HOLIDAY_CONFIRM.des
	local var_11_2 = string.len(L_HOLIDAY_CONFIRM.des) * 8 + 10 > 320 and 320 or string.len(var_11_1) * 8 + 10
	local var_11_4 = ccs.GUIReader:getInstance()
	local var_11_5 = var_11_4:widgetFromJsonFile(config._DEBUG and "Pop_Chapter_require.json" or "Pop_Chapter_require.ExportJson")

	ccui.Helper:seekWidgetByName(var_11_5, "Panel").setContentSize(var_11_4, GameDisplay.getUiScreenSize())

	local var_11_6 = ccui.Helper:seekWidgetByName(var_11_5, "box")

	var_11_6:setPositionY(var_11_6:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	ccui.Helper:seekWidgetByName(var_11_5, "description"):setContentSize(cc.size(var_11_2, 60))
	ccui.Helper:seekWidgetByName(var_11_5, "title"):setString(var_11_0)
	ccui.Helper:seekWidgetByName(var_11_5, "description"):setString(var_11_1)
	ccui.Helper:seekWidgetByName(var_11_5, "image_Q"):loadTexture("roleimage/role1/" .. model_data[global_get_servant_skin(self.servantid)].head_image .. ".png")

	local var_11_7 = ccui.Helper:seekWidgetByName(var_11_5, "button")

	var_11_7:getChildByName("button_label"):setString(L_BUTTON_TEXT.Sure)
	var_11_7:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)

		if arg_11_1 then
			arg_11_1()
		end

		var_11_5:runAction(cc.RemoveSelf:create())
	end)
	var_11_5:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_11_5:runAction(cc.RemoveSelf:create())
	end)
	global_basic_scene:addChild(var_11_5, 100)
end

function PopHolidayConfirmLayer:getReturnMsg()
	local servant_level_data = require("data.servant_level_data")
	local var_14_2 = {}
	local var_14_3 = 0

	for iter_14_0 = 1, core_manager:getCoreLv(self.servantid) do
		var_14_3 = var_14_3 + servant_level_data[iter_14_0].consume_intensitem_number
	end

	table.insert(var_14_2, {
		itemName = L_PLAYER_DATA_TYPE.Tech,
		itemNum = var_14_3
	})

	local var_14_4 = 0
	local var_14_5 = {}

	for iter_14_1 = 1, core_data[playermodel.cores[self.servantid].coreid].rank do
		for iter_14_2, iter_14_3 in pairs((core_manager:getBreakOutCostMaterial(self.servantid, iter_14_1))) do
			var_14_5[iter_14_3.itemid] = var_14_5[iter_14_3.itemid] or {
				itemNum = 0,
				itemid = iter_14_3.itemid,
				itemName = item_data[iter_14_3.itemid].name
			}
			var_14_5[iter_14_3.itemid].itemNum = var_14_5[iter_14_3.itemid].itemNum + iter_14_3.num
		end

		var_14_4 = var_14_4 + core_manager:getBreakOutCostGold(self.servantid, iter_14_1)
	end

	local var_14_6 = weapon_manager:getResetLevelReturnedItems(self.servantid)

	if next(var_14_6) then
		var_14_4 = var_14_4 + var_14_6.costgold

		for iter_14_4, iter_14_5 in pairs(var_14_6.costItems) do
			if not var_14_5[iter_14_4] then
				var_14_5[iter_14_4] = clone(iter_14_5)
			else
				var_14_5[iter_14_4].itemNum = var_14_5[iter_14_4].itemNum + iter_14_5.itemNum
			end
		end
	end

	if var_14_4 > 0 then
		table.insert(var_14_2, {
			itemName = L_GOLD,
			itemNum = var_14_4
		})
	end

	for iter_14_6, iter_14_7 in pairs(var_14_5) do
		table.insert(var_14_2, iter_14_7)
	end

	table.sort(var_14_2, function(arg_15_0, arg_15_1)
		return arg_15_0.itemNum > arg_15_1.itemNum
	end)

	return var_14_2
end

function PopHolidayConfirmLayer.getCostTbl(arg_16_0, arg_16_1)
	return {}
end

function PopHolidayConfirmLayer:initBg(arg_17_1)
	local var_17_0 = ccui.Layout:create()

	var_17_0:setTouchEnabled(true)
	var_17_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_17_0:setAnchorPoint(cc.p(0, 0))
	var_17_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_17_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_17_0:setOpacity(0)
	self:addChild(var_17_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_18_0)
		self:addChild(arg_18_0, -2)
		arg_18_0:setPositionY(arg_18_0:getPositionY() - GameDisplay.fix_y)

		local var_18_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_18_0:setAnchorPoint(cc.p(0, 0))
		var_18_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_18_0, -1)
		self:init(arg_17_1, initInfo)
		var_17_0:setOpacity(102)
		var_17_0:setTouchEnabled(false)
	end)
end

function PopHolidayConfirmLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
