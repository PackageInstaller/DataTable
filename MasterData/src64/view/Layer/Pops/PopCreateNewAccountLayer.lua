PopCreateNewAccountLayer = class("PopCreateNewAccountLayer", function()
	return PopBaseLayer:create()
end)

function PopCreateNewAccountLayer.create(arg_2_0)
	local var_2_0 = PopCreateNewAccountLayer.new()

	var_2_0:initBg()

	return var_2_0
end

function PopCreateNewAccountLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCreateNewAccountLayer.json" or "PopCreateNewAccountLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	end)
end

function PopCreateNewAccountLayer:initUI()
	self.rootLayer:getChildByName("close"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)
	self.rootLayer:getChildByName("btn"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		G_NEED_CREATE_NEW_PLAYER = true

		global_logout("switchplayer")
	end)
end

function PopCreateNewAccountLayer:initBg()
	local var_8_0 = ccui.Layout:create()

	var_8_0:setTouchEnabled(true)
	var_8_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_8_0:setAnchorPoint(cc.p(0, 0))
	var_8_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_8_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_8_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_8_0:setOpacity(0)
	var_8_0:setCascadeOpacityEnabled(false)
	self:addChild(var_8_0, -1)

	local var_8_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_8_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_1:setPositionX(var_8_0:getContentSize().width / 2)
	var_8_1:setPositionY(var_8_0:getContentSize().height / 2)
	var_8_0:addChild(var_8_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_9_0)
		self:addChild(arg_9_0, -2)
		arg_9_0:setPositionY(arg_9_0:getPositionY() - GameDisplay.fix_y)
		self:init()
		var_8_0:setOpacity(102)
	end)
end
