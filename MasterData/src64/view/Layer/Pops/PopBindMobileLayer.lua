require("view.Layer.Pops.PopBaseLayer")

PopBindMobileLayer = class("PopBindMobileLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")

function PopBindMobileLayer.create(arg_2_0)
	local var_2_0 = PopBindMobileLayer.new()

	var_2_0:init()

	return var_2_0
end

function PopBindMobileLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopBindMobileLayer.json" or "PopBindMobileLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)

	self.rootpanel = self.rootLayer:getChildByName("bg")

	self.rootpanel:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootpanel:setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	self.rootpanel:getChildByName("btn_sure"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showBindWebLayer()
	end)
end

local var_0_2 = "https://passport.737.com/migrate/email/login"

function PopBindMobileLayer.showBindWebLayer(arg_7_0)
	if DeviceManager.platform == "windows" then
		DeviceManager.openURL(var_0_2)

		return
	end

	local var_7_0 = ccui.Layout:create()

	var_7_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_7_0:setTouchEnabled(true)
	var_7_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_7_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_7_0:setBackGroundColorOpacity(150)
	global_basic_scene:addChild(var_7_0, 999)
	var_7_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		local var_8_0 = ccexp.WebView:create()

		var_8_0:setVisible(true)
		var_8_0:setScalesPageToFit(true)
		var_8_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
		var_8_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
		var_8_0:loadURL(var_0_2)
		var_8_0:setOnDidFinishLoading(function(arg_9_0, arg_9_1)
			return
		end)
		var_7_0:addChild(var_8_0, 10)

		local var_8_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

		var_8_1:setScale(0.5)
		var_8_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
		var_7_0:addChild(var_8_1, 100)
		var_8_1:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_7_0:checkBindStatus()
			var_7_0:runAction(cc.RemoveSelf:create())
		end)
	end)))
end

function PopBindMobileLayer.checkBindStatus(arg_11_0)
	local account_manager = require("controller.account_manager")

	require("network.network"):rpc("check_bind_mobile", {
		sdkver = "3.0",
		uuid = account_manager:getUserID(),
		platform = account_manager:getPlatform()
	}, function(arg_12_0)
		playermodel.bindmobilestatus = arg_12_0.bindmobilestatus

		cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("UPDATEBINDMOBILE")))
	end)
end
