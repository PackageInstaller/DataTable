PopUmaruScoreUpLayer = class("PopUmaruScoreUpLayer", function()
	return PopBaseLayer:create()
end)

function PopUmaruScoreUpLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopUmaruScoreUpLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local servant_data = require("data.servant_data")
local score_up_data = require("data.score_up_data")
local model_data = require("data.model_data")

function PopUmaruScoreUpLayer:adapt()
	local var_3_0 = self.rootpanel:getChildByName("Label_9")

	var_3_0:setPositionX(var_3_0:getPositionX() - 10)
	var_3_0:setString("队伍中编入属性加成学员时，此学员战斗中可以获得额外的属性")
end

function PopUmaruScoreUpLayer:init(arg_4_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopScoreUpUmaruLayer.json" or "PopScoreUpUmaruLayer.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelback:setTouchEnabled(false)

	local var_4_0 = {}

	if arg_4_1 and arg_4_1.curcity and score_up_data[arg_4_1.curcity] then
		while score_up_data[arg_4_1.curcity]["upservant" .. 1] do
			table.insert(var_4_0, {
				up = "0.5",
				type = score_up_data[arg_4_1.curcity]["uptype" .. 1],
				servantid = score_up_data[arg_4_1.curcity]["upservant" .. 1],
				upNum = score_up_data[arg_4_1.curcity]["upnum" .. 1]
			})
		end
	end

	self.uplist = var_4_0

	self:createFullScreenMask(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_5_0:isBright() then
			return
		end

		arg_5_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if arg_4_1 and arg_4_1.callback then
				arg_4_1.callback()
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 180)
	self.showActions.extendVertical(self)
	self:initUplist()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			-- block empty
		end
	end)
	self:adapt()
end

function PopUmaruScoreUpLayer:initUplist()
	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_role_up")
	local var_8_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "ScrollView_scoreup")
	local var_8_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score50")
	local var_8_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_score30")

	var_8_2:setVisible(false)
	var_8_3:setVisible(false)
	var_8_0:setVisible(false)
	var_8_2:removeFromParent()
	var_8_3:removeFromParent()
	var_8_0:removeFromParent()

	local var_8_4 = {
		{},
		{},
		{}
	}

	for iter_8_0, iter_8_1 in pairs(self.uplist) do
		if var_8_4[iter_8_1.type].tittle == nil then
			var_8_4[iter_8_1.type].tittle = ACTIVITY_LEVEL_MAP.SCORE_UP_TITLE_2 .. ACTIVITY_LEVEL_MAP.SCORE_UP_TITLE_1[iter_8_1.type] .. ACTIVITY_LEVEL_MAP.UP_STRING .. iter_8_1.upNum * 100 .. "%"
		end

		table.insert(var_8_4[iter_8_1.type], iter_8_1.servantid)
	end

	local var_8_5 = 0

	for iter_8_2 = 1, #var_8_4 do
		if var_8_4[iter_8_2] and #var_8_4[iter_8_2] > 0 then
			var_8_5 = var_8_5 + 50
			var_8_5 = var_8_5 + math.ceil(#var_8_4[iter_8_2] / 3) * 230
		end
	end

	var_8_1:setInnerContainerSize(cc.size(545, var_8_5))
	print(#var_8_4)

	for iter_8_3 = 1, #var_8_4 do
		if #var_8_4[iter_8_3] > 0 then
			local var_8_7 = var_8_2:clone()

			var_8_7:setVisible(true)
			var_8_1:addChild(var_8_7)

			local var_8_8 = var_8_7:getChildByName("Label_14")

			print("tittle is ")
			print(var_8_4[iter_8_3].tittle)
			var_8_8:setString(var_8_4[iter_8_3].tittle)

			for iter_8_4 = 1, math.ceil(#var_8_4[iter_8_3] / 3) do
				local var_8_9 = var_8_0:clone()

				var_8_9:setVisible(true)

				local var_8_10 = var_8_9:getChildByName("Panel_role")

				var_8_10:setVisible(false)

				for iter_8_5 = 1, 3 do
					if not var_8_4[iter_8_3][iter_8_5 + (iter_8_4 - 1) * 3] then
						break
					end

					local var_8_11 = var_8_10:clone()
					local var_8_12 = ccui.Helper:seekWidgetByName(var_8_11, "Label_role_name")
					local var_8_13 = ccui.Helper:seekWidgetByName(var_8_11, "Image_role")

					var_8_12:setString(model_data[servant_data[var_8_4[iter_8_3][iter_8_5 + (iter_8_4 - 1) * 3]].modelid].name_Q)
					var_8_13:loadTexture("role1/" .. model_data[servant_data[var_8_4[iter_8_3][iter_8_5 + (iter_8_4 - 1) * 3]].modelid].cute_role .. ".png")
					var_8_11:setPosition(cc.p(0, 0))
					var_8_9:addChild(var_8_11, 99)
					var_8_11:setVisible(true)
				end

				var_8_9:setName("panel_role_up_clone" .. iter_8_4)
				var_8_1:addChild(var_8_9, 99)
			end
		end
	end

	var_8_1:setContentSize(cc.size(545, 600))
	var_8_1:setClippingEnabled(true)
end
