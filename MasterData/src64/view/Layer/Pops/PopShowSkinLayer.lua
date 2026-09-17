local PopShowSkinLayer = class("PopShowSkinLayer", function()
	return cc.Layer:create()
end)
local L2Actor = require("view.Sprite.L2Actor")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local favorfile_data = require("data.favorfile_data")
local playermodel = require("model.playermodel")
local var_0_6 = {}
local var_0_7 = config._DEBUG and 0 or 1

function PopShowSkinLayer:create(arg_2_1)
	local var_2_0 = PopShowSkinLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopShowSkinLayer:init(arg_3_1)
	local var_3_0 = ccs.GUIReader:getInstance()
	local var_3_1 = var_3_0:widgetFromJsonFile(config._DEBUG and "SoulGirlPop.json" or "SoulGirlPop.ExportJson")
	local var_3_2 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_26")

	var_3_2.setLocalZOrder(var_3_0, 1)
	self:addChild(var_3_1)
	ccui.Helper:seekWidgetByName(var_3_1, "Image_cost_bottom"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_3_1, "Image_name"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_3_1, "Button_buy"):setVisible(false)

	local var_3_3 = item_data[arg_3_1.itemid].model

	self.showSoulGirlScenePanel = ccui.Helper:seekWidgetByName(var_3_1, "Image_back")

	self.showSoulGirlScenePanel:loadTexture("mainScenebg/" .. (model_data[var_3_3].background or "dark") .. ".jpg")
	self.showSoulGirlScenePanel:setPosition(cc.p(320, 568))
	self.showSoulGirlScenePanel:setTouchEnabled(true)
	self.showSoulGirlScenePanel:setLocalZOrder(0)

	local var_3_4 = ccui.Helper:seekWidgetByName(var_3_1, "Button_return")

	if model_data[var_3_3].background and model_data[var_3_3].background == "dark" then
		var_3_4:loadTextures("MarketLayer/return_btn_dark.png", nil, "MarketLayer/return_btn_dark.png", var_0_7)
	else
		var_3_4:loadTextures("MarketLayer/return_btn_bright.png", nil, "MarketLayer/return_btn_bright.png", var_0_7)
	end

	var_3_4:setLocalZOrder(2)

	local function var_3_5(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end

	var_3_4:setTouchEnabled(false)
	self.showSoulGirlScenePanel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
		var_3_4:setTouchEnabled(true)
		var_3_4:addTouchEventListener(var_3_5)
	end)))

	local var_3_6 = ccui.Layout:create()

	var_3_6:setTouchEnabled(true)
	var_3_6:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_6:setAnchorPoint(cc.p(0, 0))
	var_3_6:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_6:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_3_1:addChild(var_3_6, -2)

	local var_3_7 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_cute_role")
	local var_3_8 = ccui.Helper:seekWidgetByName(var_3_1, "Image_cute_role")

	var_3_8:loadTexture("roleimage/role1/" .. model_data[var_3_3].cute_role .. ".png")
	var_3_8:setPosition(cc.p(var_3_7:getContentSize().width / 2, var_3_7:getContentSize().height / 2 + 30))
	var_3_8:setScale(0.4)
	var_3_8:setVisible(false)

	local var_3_9 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_up"):setPositionY(568 + GameDisplay.fix_y)
	local var_3_10 = ccui.Helper:seekWidgetByName(var_3_1, "Panel_down"):setPositionY(568 - GameDisplay.fix_y)

	ccui.Helper:seekWidgetByName(var_3_1, "Panel_down"):setLocalZOrder(3)
	ccui.Helper:seekWidgetByName(var_3_1, "Panel_up"):setLocalZOrder(3)

	local var_3_11 = L2Actor:create(ROLE_SPINE_PATH .. model_data[var_3_3].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[var_3_3].spine_model .. ".atlas", (model_data[var_3_3].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[var_3_3].clothes_model .. ".atlas" or nil))

	var_3_11:setScale(model_data[var_3_3].modelscale / 1.3 * 0.4, model_data[var_3_3].modelscale / 1.3 * 0.4)
	var_3_11:setContentSize(cc.size(100, 200))
	var_3_11:setPosition(cc.p(var_3_7:getContentSize().width / 2, var_3_7:getContentSize().height / 2 - 60))
	var_3_7:addChild(var_3_11, 99)
	var_3_11:playAni(nil, "idle", true)
	var_3_7:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = math.random(2, 5)

		local function var_6_1()
			var_3_11:playAni(nil, "idle", true)
		end

		if var_6_0 == 2 then
			var_3_11:playAni(var_6_1, "run", false)
		elseif var_6_0 == 3 then
			var_3_11:playAni(var_6_1, "yule", false)
		elseif var_6_0 == 4 then
			var_3_11:playAni(var_6_1, "chihe", false)
		else
			var_3_11:playAni(var_6_1, "fadai", false)
		end
	end)

	local var_3_12 = ccui.Helper:seekWidgetByName(var_3_1, "Label_name")
	local var_3_13 = ccui.Helper:seekWidgetByName(var_3_1, "Image_cv")

	var_3_13:loadTexture("public/panelbg/cv_bg.png", var_0_7)

	if favorfile_data[3][model_data[var_3_3].photofile_model] then
		var_3_13:setVisible(favorfile_data[3][model_data[var_3_3].photofile_model] ~= L_CV_UNSURE)

		local var_3_14 = cc.Label:createWithTTF("声优/" .. favorfile_data[3][model_data[var_3_3].photofile_model], FONT_DES, 28)

		var_3_14:setPosition(cc.p(var_3_13:getContentSize().width / 2, var_3_13:getContentSize().height / 2 - 3))
		var_3_13:addChild(var_3_14)
	else
		var_3_13:setVisible(false)
	end

	var_3_12:setFontSize(global_change_fontsize_by_length(model_data[var_3_3].name, 40, 4, 6))
	var_3_12:setString(model_data[var_3_3].name)
	var_3_12:setLocalZOrder(9999)

	local var_3_15 = ccui.Helper:seekWidgetByName(var_3_1, "Label_name_bottom")
	local var_3_16 = ccui.Helper:seekWidgetByName(var_3_1, "Label_name_top")

	var_3_15:setString(model_data[var_3_3].main_name)
	var_3_16:setString(model_data[var_3_3].main_name)

	if model_data[var_3_3].background and model_data[var_3_3].background == "bright" then
		var_3_15:setColor(cc.c3b(40, 125, 205))
		var_3_16:setColor(cc.c3b(0, 255, 246))
	end

	local var_3_17 = ccui.Helper:seekWidgetByName(var_3_1, "Image_type")
	local var_3_18

	if model_data[var_3_3].live2d and not model_data[var_3_3].origin then
		var_3_18 = "MarketLayer/skin_type_live2d.png"
	elseif model_data[var_3_3].rolespine then
		var_3_18 = "MarketLayer/skin_type_spine.png"
	else
		var_3_17:setVisible(false)
	end

	var_3_17:loadTextures(var_3_18, nil, var_3_18, var_0_7)
	var_3_17:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	self.showgirlLayer = require("view.Layer.ShowGirlLayer"):create(var_3_3, 3)

	self.showgirlLayer:resetCurTalkConfig()

	if not var_0_6[playermodel.playerid] then
		var_0_6[playermodel.playerid] = {}
		var_0_6[playermodel.playerid][var_3_3] = var_0_6[playermodel.playerid][var_3_3] or 0
	else
		var_0_6[playermodel.playerid][var_3_3] = var_0_6[playermodel.playerid][var_3_3] or 0
	end

	self.showgirlLayer:setTalkEnabled(var_0_6[playermodel.playerid][var_3_3] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self.showgirlLayer:setTouchTalkCallback(function()
		var_0_6[playermodel.playerid][var_3_3] = var_0_6[playermodel.playerid][var_3_3] + 1

		self.showgirlLayer:setTalkEnabled(var_0_6[playermodel.playerid][var_3_3] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
	var_3_2:addChild(self.showgirlLayer, 1)

	if model_data[var_3_3].backgroundid then
		local var_3_20 = BackGroundLayer:create(model_data[var_3_3].backgroundid, (model_data[var_3_3].is_own_full_screen_background == 1 or nil) and 2)

		var_3_2:addChild(var_3_20, 0)
		var_3_20:setName("backGroundLayer")
	end
end

return PopShowSkinLayer
