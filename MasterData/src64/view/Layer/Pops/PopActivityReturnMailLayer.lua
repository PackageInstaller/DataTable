PopActivityReturnMailLayer = class("PopActivityReturnMailLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local activity_return_manager = require("controller.activity_return_manager")
local gamebuff_data = require("data.gamebuff_data")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_7 = require("model.playermodel")
local returnback_conf_data = require("data.returnback_conf_data")
local returnback_sign_data = require("data.returnback_sign_data")
local item_data = require("data.item_data")

function PopActivityReturnMailLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityReturnMailLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopActivityReturnMailLayer:init(arg_3_1)
	print("/////////////////////////////////////////////")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_Return_MailLayer.json" or "Activity_Return_MailLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_bg")

	self.rootpanel:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	self.rootpanel:setScaleY(0)
	self.rootpanel:setTouchEnabled(false)

	self.Listview = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_9")
	self.getaward = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_17")
	self.exitcallback = arg_3_1 and arg_3_1.callback

	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback()
			end

			activity_return_manager:get_returnback_info()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.getaward:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback()
			end

			activity_return_manager:get_returnback_info()
			LayerManager:switchShowLayer("ActivityGameBackGuideLayer", {
				index = REWARD
			})
		end)
	end)
	self.showActions.extendVertical(self)
	self:initUI()
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopActivityReturnMailLayer")

			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end
	end)
end

function PopActivityReturnMailLayer.registerActivityEventListener(arg_9_0)
	activity_manager:registerEventListener("PopActivityReturnMailLayer", activity_manager.activityEventId.ACTIVITY_RETURN_SIGN_UPDATE, function(arg_10_0)
		arg_9_0:initUI()
	end)
end

function PopActivityReturnMailLayer:initUI()
	self.Listview:removeAllChildren()
	self.Listview:setItemsMargin(50)

	local var_11_0 = activity_return_manager:get_mail_drop()

	if not var_11_0 then
		print(">>>>>>>>>>>>>>>>the is no dropid !!!!!!!!!")

		return
	end

	self.data = activity_return_manager:getDropData(var_11_0)

	local var_11_1 = self.data

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items"):clone()

	for iter_11_0 = 1, #self.data do
		local var_11_2 = self.items:clone()
		local var_11_3 = ccui.Helper:seekWidgetByName(var_11_2, "Image_11")

		ccui.Helper:seekWidgetByName(var_11_2, "Label_13"):setString("x" .. var_11_1[iter_11_0].num)

		local var_11_4
		local var_11_5

		if var_11_1[iter_11_0].itemid == "gold" and var_11_1[iter_11_0].num > 0 then
			var_11_4 = "equipment/1000001.png"
		elseif var_11_1[iter_11_0].itemid == "diamond" and var_11_1[iter_11_0].num > 0 then
			var_11_4 = "equipment/1000000.png"
		elseif item_data[var_11_1[iter_11_0].itemid].image_id then
			var_11_4 = "equipment/" .. item_data[var_11_1[iter_11_0].itemid].image_id .. ".png"
		else
			var_11_5 = item_data[var_11_1[iter_11_0].itemid].bag_item_type == kITEM_MEDAL and ItemSprite:create_medal_icon(var_11_1[iter_11_0].itemid) or componentManager:create_component_icon(var_11_1[iter_11_0].itemid, nil, nil)
		end

		var_11_5 = var_11_5 or ccui.ImageView:create(var_11_4)

		var_11_5:setName("award_" .. iter_11_0)
		var_11_5:setTouchEnabled(true)
		var_11_5:setPosition(cc.p(var_11_3:getContentSize().width / 2, var_11_3:getContentSize().height / 2))
		var_11_3:addChild(var_11_5)
		var_11_5:setScale(var_11_3:getContentSize().width / math.max(var_11_5:getContentSize().width, var_11_5:getContentSize().height) - 0.1)

		var_11_5.itemtype = "gold"

		if var_11_1[iter_11_0].itemid ~= "gold" and var_11_1[iter_11_0].itemid ~= "diamond" then
			var_11_5.itemtype = "item"
		end

		var_11_5:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_11_1[iter_11_0].itemid, var_11_5.itemtype)
		end)
		self.Listview:pushBackCustomItem(var_11_2)
	end
end

function PopActivityReturnMailLayer:exit(arg_13_1)
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback({
				type = self.atrr
			})
		end

		if arg_13_1 then
			arg_13_1()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopActivityReturnMailLayer:initBg(arg_15_1)
	local var_15_0 = ccui.Layout:create()

	var_15_0:setTouchEnabled(true)
	var_15_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_15_0:setAnchorPoint(cc.p(0, 0))
	var_15_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_15_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_15_0:setOpacity(0)
	var_15_0:setCascadeOpacityEnabled(false)
	self:addChild(var_15_0, -1)

	local var_15_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_15_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_15_1:setPositionX(var_15_0:getContentSize().width / 2)
	var_15_1:setPositionY(var_15_0:getContentSize().height / 2)
	var_15_0:addChild(var_15_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_16_0)
		self:addChild(arg_16_0, -2)
		arg_16_0:setPositionY(arg_16_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_15_1)
		var_15_0:setOpacity(102)
		var_15_0:setTouchEnabled(false)
	end)
end

function PopActivityReturnMailLayer:showDetailsofItems(arg_17_1, arg_17_2)
	local function var_17_1()
		return
	end

	if arg_17_2 == "item" then
		if item_data[arg_17_1].bag_item_type == kITEM_HORCRUX then
			local var_17_2 = -1
			local HelpGirl_data = require("data.HelpGirl_data")

			for iter_17_0, iter_17_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_17_1.model_id == HelpGirl_data[arg_17_1].model then
					var_17_2 = iter_17_0

					break
				end
			end

			if var_17_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_17_2,
				itemid = arg_17_1,
				callback = var_17_1
			})
		elseif item_data[arg_17_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_17_1].servant,
				exitCallback = var_17_1
			})
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_17_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_17_1
			})
		end
	elseif arg_17_2 == "gold" then
		-- block empty
	elseif arg_17_2 == "diamond" then
		-- block empty
	end
end
