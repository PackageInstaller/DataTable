PopSubScoreUpLayer = class("PopSubScoreUpLayer", function()
	return PopBaseLayer:create()
end)

function PopSubScoreUpLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSubScoreUpLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local activity_daily_level_des_data = require("data.activity_daily_level_des_data")

function PopSubScoreUpLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopScoreUpLayer.json" or "PopScoreUpLayer.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelback:setTouchEnabled(false)

	self.uplist = arg_3_1.uplist

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 180)
	self.showActions.extendVertical(self)
	self:initUplist()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score30"):getChildByName("Label_14"):setString(L_STABLESCORE)

	if arg_3_1.activityid then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Label_8"):setString(activity_daily_level_des_data["uptitle_" .. arg_3_1.activityid])
		ccui.Helper:seekWidgetByName(self.rootlayer, "Label_9"):setString(activity_daily_level_des_data["upDes1_" .. arg_3_1.activityid])
		ccui.Helper:seekWidgetByName(self.rootlayer, "Label_9_0"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score30"):getChildByName("Label_14"):setString(activity_daily_level_des_data["upDes2_" .. arg_3_1.activityid])
	end
end

function PopSubScoreUpLayer:initUplist()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_role_up")
	local var_7_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "ScrollView_scoreup")
	local var_7_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score30")
	local var_7_3 = {}
	local var_7_4 = {}

	for iter_7_0, iter_7_1 in pairs(self.uplist) do
		if iter_7_1.up == "0.25" then
			var_7_3[#var_7_3 + 1] = iter_7_1.servantid
		else
			var_7_4[#var_7_4 + 1] = iter_7_1.servantid
		end
	end

	local var_7_5 = (math.ceil(#var_7_3 / 3) - 1) * 200 + (math.ceil(#var_7_4 / 3) - 1) * 200

	var_7_1:setContentSize(cc.size(545, 600))
	var_7_1:setClippingEnabled(true)
	var_7_1:setInnerContainerSize(cc.size(545, 600 + var_7_5))

	local var_7_6 = 0

	if #var_7_3 > 0 then
		ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score50"):setPosition(cc.p(275, var_7_5 + 565 + var_7_6 * 200))
	end

	for iter_7_2 = 1, math.ceil(#var_7_3 / 3) do
		local var_7_8 = var_7_0:clone()
		local var_7_9 = var_7_8:getChildByName("Panel_role")

		var_7_9:setVisible(false)

		local var_7_10 = 0

		for iter_7_3 = 1, 3 do
			if not var_7_3[iter_7_3 + (iter_7_2 - 1) * 3] then
				break
			end

			local var_7_11 = var_7_9:clone()
			local var_7_12 = ccui.Helper:seekWidgetByName(var_7_11, "Label_role_name")
			local var_7_13 = ccui.Helper:seekWidgetByName(var_7_11, "Image_role")

			var_7_12:setString(servant_data[var_7_3[iter_7_3 + (iter_7_2 - 1) * 3]].name)
			var_7_13:loadTexture("role1/" .. model_data[servant_data[var_7_3[iter_7_3 + (iter_7_2 - 1) * 3]].modelid].cute_role .. ".png")
			var_7_11:setPosition(cc.p(var_7_10, 0))

			var_7_10 = var_7_10 + 170

			var_7_8:addChild(var_7_11, 99)
			var_7_11:setVisible(true)
		end

		var_7_8:setPosition(cc.p(20, var_7_5 + 320 - (iter_7_2 - 1) * 200))
		var_7_8:setName("panel_role_up_clone" .. iter_7_2)

		var_7_6 = var_7_6 - 1 > 0 and var_7_6 - 1 or 0

		var_7_1:addChild(var_7_8, 99)
	end

	local var_7_15 = math.ceil(#var_7_4 / 3)
	local var_7_16 = 25

	if var_7_15 >= 2 then
		var_7_16 = 225
	end

	if #var_7_3 > 0 and #var_7_4 > 0 then
		var_7_2:setPosition(cc.p(275, var_7_5 + 270 - (math.ceil(#var_7_3 / 3) - 1) * 200))
	end

	if #var_7_3 == 0 and #var_7_4 > 0 then
		var_7_2:setPosition(cc.p(275, var_7_5 + 565 + var_7_6 * 200))
	end

	for iter_7_4 = 1, var_7_15 do
		local var_7_17 = var_7_0:clone()
		local var_7_18 = var_7_17:getChildByName("Panel_role")

		for iter_7_5 = 1, 3 do
			if not var_7_4[iter_7_5 + (iter_7_4 - 1) * 3] then
				break
			end

			local var_7_19 = var_7_18:clone()
			local var_7_20 = ccui.Helper:seekWidgetByName(var_7_19, "Label_role_name")
			local var_7_21 = ccui.Helper:seekWidgetByName(var_7_19, "Image_role")

			var_7_20:setString(servant_data[var_7_4[iter_7_5 + (iter_7_4 - 1) * 3]].name)
			var_7_21:loadTexture("role1/" .. model_data[servant_data[var_7_4[iter_7_5 + (iter_7_4 - 1) * 3]].modelid].cute_role .. ".png")
			var_7_19:setPosition(cc.p(0, 0))
			var_7_17:addChild(var_7_19, 99)
			var_7_19:setVisible(true)
		end

		var_7_18:setVisible(false)
		var_7_17:setPosition(cc.p(20, var_7_16 + var_7_6 * 200))

		var_7_6 = var_7_6 - 1 ~= 0 and var_7_6 - 1 or 0

		var_7_1:addChild(var_7_17, 99)
	end
end
