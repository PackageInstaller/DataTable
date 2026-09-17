PopCommunityWishFilterLayer = class("PopCommunityWishFilterLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local playermodel = require("model.playermodel")
local var_0_3 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local var_0_5
local var_0_6 = {
	off = cc.c3b(255, 255, 255),
	on = cc.c3b(0, 0, 0)
}
local var_0_7 = {
	title = COMMUNITY_WISH_SYSTEM.tips38,
	title1 = COMMUNITY_POPCOMMUNITYFILTERLAYER.tips13,
	condition1 = COMMUNITY_WISH_SYSTEM.tips39,
	condition2 = COMMUNITY_WISH_SYSTEM.tips40
}
local var_0_8 = {
	on = "public/filter/filter_selected_bg.png",
	off = "public/filter/filter_select_bg.png"
}

function PopCommunityWishFilterLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityWishFilterLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityWishFilterLayer:init(arg_3_1)
	var_0_5 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityWishFilterLayer.json" or "PopCommunityWishFilterLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.title1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_64")
	self.panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel1")
	self.title2 = ccui.Helper:seekWidgetByName(self.panel, "Label_9")
	self.condition1 = ccui.Helper:seekWidgetByName(self.panel, "editdefault")
	self.condition2 = ccui.Helper:seekWidgetByName(self.panel, "editneed")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_30")

	self.surebtn:getChildByName("Label_4"):setFontName("fonts/newkj.ttf")
	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_5 = nil
		end
	end)
end

function PopCommunityWishFilterLayer:initUI()
	self.filterparam = community_system_manager:getComminityWishFilterParm().wishfilterparam

	self:initLayerText()
	self:initBtnStatus()
	self.surebtn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_8_0 = {
			self.condition1.type,
			self.condition2.type
		}

		if not (function(arg_9_0, arg_9_1)
			if not arg_9_0 or not arg_9_1 then
				return false
			end

			if arg_9_0[1] == arg_9_1[1] and arg_9_0[2] == arg_9_1[2] then
				return true
			else
				return false
			end
		end)(var_8_0, self.filterparam) then
			community_system_manager:updateComminityWishFilterParm(var_8_0)
			self:exit(1)
		end

		self:exit()
	end)
end

function PopCommunityWishFilterLayer:initLayerText()
	self.surebtn:getChildByName("Label_4"):setString(COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips2)
	self.title1:setString(var_0_7.title)
	self.title2:setString(var_0_7.title1)
	self.condition1:getChildByName("name"):setString(var_0_7.condition1)
	self.condition2:getChildByName("name"):setString(var_0_7.condition2)
end

function PopCommunityWishFilterLayer:initBtnStatus()
	if not self.filterparam or not next(self.filterparam) then
		self.condition1.type = 0
		self.condition2.type = 0
	else
		if not self.filterparam[1] then
			self.condition1.type = 0
		end

		self.condition2.type = self.filterparam[2] or 0
	end

	local function var_11_1(arg_12_0)
		if not arg_12_0 then
			return
		end

		if arg_12_0.type == 0 then
			arg_12_0:getChildByName("name"):getVirtualRenderer():setColor(var_0_6.off)
			arg_12_0:loadTextures(var_0_8.off, var_0_8.off, var_0_8.off, var_0_3)
		else
			arg_12_0:getChildByName("name"):getVirtualRenderer():setColor(var_0_6.on)
			arg_12_0:loadTextures(var_0_8.on, var_0_8.on, var_0_8.on, var_0_3)
		end
	end

	self.condition1:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_13_0.type == 0 then
			arg_13_0.type = 1
		elseif arg_13_0.type == 1 then
			arg_13_0.type = 0
		end

		var_11_1(arg_13_0)
	end)
	self.condition2:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_0.type == 0 then
			arg_14_0.type = 1
		elseif arg_14_0.type == 1 then
			arg_14_0.type = 0
		end

		var_11_1(arg_14_0)
	end)
	var_11_1(self.condition1)
	var_11_1(self.condition2)
end

function PopCommunityWishFilterLayer:initBg(arg_15_1)
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

function PopCommunityWishFilterLayer:exit(arg_17_1)
	self.hideActions.shrinkVertical(self, function()
		if arg_17_1 and self.callback then
			self.callback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
