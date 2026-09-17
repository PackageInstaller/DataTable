PopSpringInfoLayer = class("PopSpringInfoLayer", function()
	return PopBaseLayer:create()
end)

function PopSpringInfoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSpringInfoLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSpringInfoLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSpringInfoLayer.json" or "PopSpringInfoLayer.ExportJson")

	self.rootLayer:setPosition(cc.p(0, 0))
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:addChild(self.rootLayer, 1)

	self.rootpanel = self.rootLayer

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopSpringInfoLayer:initUI()
	self:initBG()
	self.showActions.fadeIn(self)
end

function PopSpringInfoLayer:initBg(arg_6_1)
	local var_6_0 = ccui.Layout:create()

	var_6_0:setTouchEnabled(true)
	var_6_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_6_0:setAnchorPoint(cc.p(0, 0))
	var_6_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_6_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_6_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_6_0:setOpacity(0)
	var_6_0:setCascadeOpacityEnabled(false)
	self:addChild(var_6_0, -1)

	local var_6_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_6_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_6_1:setPositionX(var_6_0:getContentSize().width / 2)
	var_6_1:setPositionY(var_6_0:getContentSize().height / 2)
	var_6_0:addChild(var_6_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_7_0)
		self:addChild(arg_7_0, -2)
		arg_7_0:setPositionY(arg_7_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_6_1)
		var_6_0:setOpacity(102)
	end)
end

function PopSpringInfoLayer:initBG()
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopSpringInfoLayer:exit(arg_10_1)
	self.hideActions.fadeOut(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
